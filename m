Return-Path: <netdev+bounces-126481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778F9714B4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE61F2144E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194911B4C32;
	Mon,  9 Sep 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BiWI6k6A"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575F1B3F1C
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876222; cv=none; b=rfUeNkYEevPrfkRc7avg6htQitiv6QzlDAvZOrywpBeDjWG67LcmQ5sLrV/cJDAQrNYo56ZlhZCu8UP6QVppLIRwX73pAm0/we41PtIjneXLGuL0pKt1e3tW7uENLt2EwwtTbtvougKcQjCp2TyBI3/aXXzBetXAZz5uWABhIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876222; c=relaxed/simple;
	bh=ujIP0vZmhqESPXmTbdk3/RgX+QUkces8LqEttPXUpKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aeb9cq2fGk75XVskOlhx9j3JEFiZJa5cWEOwVOR44gbnLmNG/rdWI1ObF3bx/gOTn7uvs/V4xN3Ih96LZxRiMNU/zchTrLRBf4Hl2gF3myRSvMU+u2ONRbFh3giUVAgZ9nzSb3sTbPiXhmpdGKBREEDFhcsrPeD0sSUpxDxiXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BiWI6k6A; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A3734206E9;
	Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jflAyDlZCSva; Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 73650207F4;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 73650207F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876215;
	bh=0UdvoizZu0Eu3M9eTqpxPaAVMgJFwNH2IeCqh0vMK2U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BiWI6k6AQRDMHyol5klPBWalEMnrRHxcCR9U7p/8U7ED6AvzEjS3lnPv2ghOIplMI
	 cL0HK2A2qz843GAoF9LoTN2bDOwxTfb9z8tLttX265q9ga/DWzo7IJMkkIONCJiCfD
	 JeFXBB+TJdoFttLHp2jqjsemcopjXTGVHSJL1/rZ6CACTR4UwzH3M7h6TmGvcJMu5v
	 SdH7hOXridB5vYUzi01IfR08cHs2N0ZXW1lMr4pjoX87B3/WJy9oxWJvUqzQR297yc
	 H7OyRfRobDob/rdUlE29s2eUe/Sc9Zq9WkHksgUbP1UpRmA68rkBhyiEXDi2I6l9a3
	 ybs7SNcNrMoeg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4161131843D6; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/11] xfrm: switch migrate to xfrm_policy_lookup_bytype
Date: Mon, 9 Sep 2024 12:03:23 +0200
Message-ID: <20240909100328.1838963-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909100328.1838963-1-steffen.klassert@secunet.com>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


