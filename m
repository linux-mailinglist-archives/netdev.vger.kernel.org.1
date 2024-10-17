Return-Path: <netdev+bounces-136528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EA9A2013
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C88B20B03
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5D5478E;
	Thu, 17 Oct 2024 10:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF121E3BB
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161220; cv=none; b=evyTUn5pp814mDydTZtR9kH1Cvkd8xLV0xhuQGZIdtiDQSUrDvXvJzg20XirUNjOR0RJeDmjcOnXr0t+SFQHsNp/U7qBFoQXEkehCTNw4ENuzN6ItT3YK99QnvPtyvk78kauB9nAj2NtnI4V1H6h68jVFcKSwjCwyUt30nOQE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161220; c=relaxed/simple;
	bh=BbOKPWQ8tdjH+N71h23K0v85p+OyYDqtFHQfngFvzp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEAxE3FEAZzsneD6dN5QhoZvLBsgYYB4FgLngqgFaxoQKzuZuq3anFu+CRwD9bCs8T0kffNhrT8eYZnUKa4IiYNcRQBt029HXr/0CN3HkT3IW+HS3U6Ny8ymkdAlmuhDwbKMr7exnMwOPSfxUqAoSxGlVlbJ7ZqrYkaCxfI/QyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t1Np0-000330-Nl; Thu, 17 Oct 2024 12:33:34 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Nathan Harold <nharold@google.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Yan Yan <evitayan@google.com>
Subject: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
Date: Thu, 17 Oct 2024 11:43:05 +0200
Message-ID: <20241017094315.6948-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Looks like there are userspace applications which rely on the ability to
migrate xfrm-interface policies while not providing the interface id.

This worked because old code contains a match workaround:
   "if_id == 0 || pol->if_id == if_id".

The packetpath lookup code uses the id_id as a key into rhashtable; after
switch of migrate lookup over to those functions policy lookup fails.

Add a workaround: if no policy to migrate is found and userspace provided
no if_id  (normal for non-interface policies!) do a full search of all
policies and try to find one that matches the selector.

This is super-slow, so print a warning when we find a policy, so
hopefully such userspace requests are fixed up over time to not rely on
magic-0-match.

In case of setups where userspace frequently tries to migrate non-existent
policies with if_id 0 such migrate requests will take much longer to
complete.

Other options:
 1. also add xfrm interface usage counter so we know in advance if the
    slowpath could potentially find the 'right' policy or not.

 2. Completely revert policy insertion patches and go back to linear
    insertion complexity.

1) seems premature, I'd expect userspace to try migration of policies it
   has inserted in the past, so either normal fastpath or slowpath
   should find a match anyway.

2) seems like a worse option to me.

Cc: Nathan Harold <nharold@google.com>
Cc: Maciej Żenczykowski <maze@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Reported-by: Yan Yan <evitayan@google.com>
Tested-by: Yan Yan <evitayan@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d555ea401234..29554173831a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4425,6 +4425,81 @@ EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
 #endif
 
 #ifdef CONFIG_XFRM_MIGRATE
+static bool xfrm_migrate_selector_match(const struct xfrm_selector *sel_cmp,
+					const struct xfrm_selector *sel_tgt)
+{
+	if (sel_cmp->proto == IPSEC_ULPROTO_ANY) {
+		if (sel_tgt->family == sel_cmp->family &&
+		    xfrm_addr_equal(&sel_tgt->daddr, &sel_cmp->daddr,
+				    sel_cmp->family) &&
+		    xfrm_addr_equal(&sel_tgt->saddr, &sel_cmp->saddr,
+				    sel_cmp->family) &&
+		    sel_tgt->prefixlen_d == sel_cmp->prefixlen_d &&
+		    sel_tgt->prefixlen_s == sel_cmp->prefixlen_s) {
+			return true;
+		}
+	} else {
+		if (memcmp(sel_tgt, sel_cmp, sizeof(*sel_tgt)) == 0)
+			return true;
+	}
+	return false;
+}
+
+/* Ugly workaround for userspace that wants to migrate policies for
+ * xfrm interfaces but does not provide the interface if_id.
+ *
+ * Old code used to search the lists and handled if_id == 0 as 'does match'.
+ * New xfrm_migrate code uses the packet-path lookup which uses the if_id
+ * as part of hash key and won't find correct policies.
+ *
+ * Walk entire policy list to see if there is a matching selector without
+ * checking if_id.
+ */
+static u32 xfrm_migrate_policy_find_slow(const struct xfrm_selector *sel,
+					 u8 dir, u8 type, struct net *net)
+{
+	const struct xfrm_policy *policy, *cand = NULL;
+	const struct hlist_head *chain;
+	u32 if_id = 0;
+
+	chain = policy_hash_direct(net, &sel->daddr, &sel->saddr, sel->family, dir);
+	hlist_for_each_entry(policy, chain, bydst) {
+		if (policy->type != type)
+			continue;
+
+		if (xfrm_migrate_selector_match(sel, &policy->selector)) {
+			if_id = policy->if_id;
+			cand = policy;
+			break;
+		}
+	}
+
+	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
+
+	list_for_each_entry(policy, &net->xfrm.policy_all, walk.all) {
+		if (xfrm_policy_is_dead_or_sk(policy))
+			continue;
+
+		if (policy->type != type)
+			continue;
+
+		/* candidate has better priority */
+		if (cand && policy->priority >= cand->priority)
+			continue;
+
+		if (dir != xfrm_policy_id2dir(policy->index))
+			continue;
+
+		if (xfrm_migrate_selector_match(sel, &policy->selector)) {
+			if_id = policy->if_id;
+			cand = policy;
+		}
+	}
+	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
+
+	return if_id;
+}
+
 static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *sel,
 						    u8 dir, u8 type, struct net *net, u32 if_id)
 {
@@ -4579,6 +4654,19 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 	return 0;
 }
 
+static void xfrm_migrate_warn_workaround(void)
+{
+	char name[sizeof(current->comm)];
+	static bool warned;
+
+	if (warned)
+		return;
+
+	warned = true;
+	pr_warn_once("warning: `%s' is migrating xfrm interface policies with if_id 0, this is slow.\n",
+		     get_task_comm(name, current));
+}
+
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
@@ -4606,11 +4694,24 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	/* Stage 1 - find policy */
 	pol = xfrm_migrate_policy_find(sel, dir, type, net, if_id);
 	if (IS_ERR_OR_NULL(pol)) {
+		if (if_id == 0) {
+			if_id = xfrm_migrate_policy_find_slow(sel, dir, type, net);
+
+			if (if_id) {
+				pol = xfrm_migrate_policy_find(sel, dir, type, net, if_id);
+				if (!IS_ERR_OR_NULL(pol)) {
+					xfrm_migrate_warn_workaround();
+					goto found;
+				}
+			}
+		}
+
 		NL_SET_ERR_MSG(extack, "Target policy not found");
 		err = IS_ERR(pol) ? PTR_ERR(pol) : -ENOENT;
 		goto out;
 	}
 
+found:
 	/* Stage 2 - find and update state(s) */
 	for (i = 0, mp = m; i < num_migrate; i++, mp++) {
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
-- 
2.45.2


