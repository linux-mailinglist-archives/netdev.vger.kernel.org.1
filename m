Return-Path: <netdev+bounces-121004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4D95B642
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4711C22F4F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955841C944B;
	Thu, 22 Aug 2024 13:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F426AC1
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332654; cv=none; b=mPgsAEMxItGWgOlHCu+zfH7efRfBv8sBG4Yj4M3tGXmQEVKnvteDgOpLORCH1MUPi2+S+xAy41ESk7aaqniJpaujaBdHjtQi/EkkczSDtbZ1oq6pCFF/PxIHS6MjCKnIQFrPrj5FKZYYBvdFaD3TN0h74t3jq5W+w/NV40t+lKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332654; c=relaxed/simple;
	bh=RbHQSO0b1ICz2lfsUTYq4vkrZO/S+1lYC0uSDA3pGdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8DwfqZMLeIR6HztztioX/BP2qBiSod7iOzoL7VrZm9AtBKIA9B0WWEfgroykhvD1WWmCMqM2mDOkw3ei8SfhuyxaNh9kXfRj7wegtD3ZF6vUOtO5groppL6tzNL2pY0DUqkv+M8kCCy0NwzR6NHDmca8J2ueLmIlblgUBPD9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sh7gw-0006pW-DD; Thu, 22 Aug 2024 15:17:30 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	noel@familie-kuntze.de,
	tobias@strongswan.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 3/4] xfrm: switch migrate to xfrm_policy_lookup_bytype
Date: Thu, 22 Aug 2024 15:04:31 +0200
Message-ID: <20240822130643.5808-4-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240822130643.5808-1-fw@strlen.de>
References: <20240822130643.5808-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFRM_MIGRATE still uses the old lookup method:
first check the bydst hash table, then search the list of all the other
policies.

Switch MIGRATE to use the same lookup function as the packetpath.

This is done to remove the last remaining users of the pernet
xfrm.policy_inexact lists with the intent of removing this list.

After this patch, policies are still added to the list on insertion
and they are rehashed as-needed but no single API makes use of these
anymore.

This change is compile tested only.

Cc: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 106 +++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 67 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 423d1eb24f31..d2feee60bb62 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1252,13 +1252,10 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 {
 	struct net *net = container_of(work, struct net,
 				       xfrm.policy_hthresh.work);
-	unsigned int hmask;
 	struct xfrm_policy *pol;
 	struct xfrm_policy *policy;
 	struct hlist_head *chain;
-	struct hlist_head *odst;
 	struct hlist_node *newpos;
-	int i;
 	int dir;
 	unsigned seq;
 	u8 lbits4, rbits4, lbits6, rbits6;
@@ -1322,23 +1319,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 			goto out_unlock;
 	}
 
-	/* reset the bydst and inexact table in all directions */
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
-		struct hlist_node *n;
-
-		hlist_for_each_entry_safe(policy, n,
-					  &net->xfrm.policy_inexact[dir],
-					  bydst_inexact_list) {
-			hlist_del_rcu(&policy->bydst);
-			hlist_del_init(&policy->bydst_inexact_list);
-		}
-
-		hmask = net->xfrm.policy_bydst[dir].hmask;
-		odst = net->xfrm.policy_bydst[dir].table;
-		for (i = hmask; i >= 0; i--) {
-			hlist_for_each_entry_safe(policy, n, odst + i, bydst)
-				hlist_del_rcu(&policy->bydst);
-		}
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
 			/* dir out => dst = remote, src = local */
 			net->xfrm.policy_bydst[dir].dbits4 = rbits4;
@@ -1363,6 +1344,10 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 			/* skip socket policies */
 			continue;
 		}
+
+		hlist_del_rcu(&policy->bydst);
+		hlist_del_init(&policy->bydst_inexact_list);
+
 		newpos = NULL;
 		chain = policy_hash_bysel(net, &policy->selector,
 					  policy->family, dir);
@@ -4484,63 +4469,50 @@ EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
 #endif
 
 #ifdef CONFIG_XFRM_MIGRATE
-static bool xfrm_migrate_selector_match(const struct xfrm_selector *sel_cmp,
-					const struct xfrm_selector *sel_tgt)
-{
-	if (sel_cmp->proto == IPSEC_ULPROTO_ANY) {
-		if (sel_tgt->family == sel_cmp->family &&
-		    xfrm_addr_equal(&sel_tgt->daddr, &sel_cmp->daddr,
-				    sel_cmp->family) &&
-		    xfrm_addr_equal(&sel_tgt->saddr, &sel_cmp->saddr,
-				    sel_cmp->family) &&
-		    sel_tgt->prefixlen_d == sel_cmp->prefixlen_d &&
-		    sel_tgt->prefixlen_s == sel_cmp->prefixlen_s) {
-			return true;
-		}
-	} else {
-		if (memcmp(sel_tgt, sel_cmp, sizeof(*sel_tgt)) == 0) {
-			return true;
-		}
-	}
-	return false;
-}
-
 static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *sel,
 						    u8 dir, u8 type, struct net *net, u32 if_id)
 {
 	struct xfrm_policy *pol, *ret = NULL;
-	struct hlist_head *chain;
-	u32 priority = ~0U;
+	struct flowi fl;
 
-	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
-	chain = policy_hash_direct(net, &sel->daddr, &sel->saddr, sel->family, dir);
-	hlist_for_each_entry(pol, chain, bydst) {
-		if ((if_id == 0 || pol->if_id == if_id) &&
-		    xfrm_migrate_selector_match(sel, &pol->selector) &&
-		    pol->type == type) {
-			ret = pol;
-			priority = ret->priority;
-			break;
-		}
-	}
-	chain = &net->xfrm.policy_inexact[dir];
-	hlist_for_each_entry(pol, chain, bydst_inexact_list) {
-		if ((pol->priority >= priority) && ret)
-			break;
+	memset(&fl, 0, sizeof(fl));
 
-		if ((if_id == 0 || pol->if_id == if_id) &&
-		    xfrm_migrate_selector_match(sel, &pol->selector) &&
-		    pol->type == type) {
-			ret = pol;
+	fl.flowi_proto = sel->proto;
+
+	switch (sel->family) {
+	case AF_INET:
+		fl.u.ip4.saddr = sel->saddr.a4;
+		fl.u.ip4.daddr = sel->daddr.a4;
+		if (sel->proto == IPSEC_ULPROTO_ANY)
 			break;
-		}
+		fl.u.flowi4_oif = sel->ifindex;
+		fl.u.ip4.fl4_sport = sel->sport;
+		fl.u.ip4.fl4_dport = sel->dport;
+		break;
+	case AF_INET6:
+		fl.u.ip6.saddr = sel->saddr.in6;
+		fl.u.ip6.daddr = sel->daddr.in6;
+		if (sel->proto == IPSEC_ULPROTO_ANY)
+			break;
+		fl.u.flowi6_oif = sel->ifindex;
+		fl.u.ip6.fl4_sport = sel->sport;
+		fl.u.ip6.fl4_dport = sel->dport;
+		break;
+	default:
+		return ERR_PTR(-EAFNOSUPPORT);
 	}
 
-	xfrm_pol_hold(ret);
+	rcu_read_lock();
 
-	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
+	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
+	if (IS_ERR_OR_NULL(pol))
+		goto out_unlock;
 
-	return ret;
+	if (!xfrm_pol_hold_rcu(ret))
+		pol = NULL;
+out_unlock:
+	rcu_read_unlock();
+	return pol;
 }
 
 static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tmpl *t)
@@ -4677,9 +4649,9 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* Stage 1 - find policy */
 	pol = xfrm_migrate_policy_find(sel, dir, type, net, if_id);
-	if (!pol) {
+	if (IS_ERR_OR_NULL(pol)) {
 		NL_SET_ERR_MSG(extack, "Target policy not found");
-		err = -ENOENT;
+		err = IS_ERR(pol) ? PTR_ERR(pol) : -ENOENT;
 		goto out;
 	}
 
-- 
2.44.2


