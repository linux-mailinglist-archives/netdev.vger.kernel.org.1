Return-Path: <netdev+bounces-121005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F295B643
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90786B242F1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE611CB130;
	Thu, 22 Aug 2024 13:17:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BF26AC1
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332657; cv=none; b=ePC8yDsKtVsd49ZYe00e1s79l5stPJ5f6ObsMt6UpBe35llSz9r2umqSlziyZO0QWkUuSzHNV5Pd/4i57/CjOYrKpkOOwT2531V8BUWZ0alhDlTrotOcPuvKcI9lV/Qh52iXvRnP+BHsN54nrc/+FwuLWcG2ut1oiGwu9J4PGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332657; c=relaxed/simple;
	bh=svwyB2zT8EFuz3CdZl/r3KsWQ/8nvEScI51Wd56pL/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D81LizyMK9VvrM3FZ6gERaZ8tSsfaUqTsQYmUwYGrrRoU8/j5B3L/+wU/CCDIyLf6XW9OB7E/3GqLvN0S62chaNB4rOnOy3bG/M8mxAd2TCLuyzQpSXIhctljjS+cDhBDZjM/GCZcxm2prAWw2Ql0pQ50dCFCWdPfLWDPf19kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sh7h0-0006pn-FH; Thu, 22 Aug 2024 15:17:34 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	noel@familie-kuntze.de,
	tobias@strongswan.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 4/4] xfrm: policy: remove remaining use of inexact list
Date: Thu, 22 Aug 2024 15:04:32 +0200
Message-ID: <20240822130643.5808-5-fw@strlen.de>
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

No consumers anymore, remove it.  After this, insertion of policies
no longer require list walk of all inexact policies but only those
that are reachable via the candidate sets.

This gives almost linear insertion speeds provided the inserted
policies are for non-overlapping networks.

Before:
Inserted 1000   policies in 70 ms
Inserted 10000  policies in 1155 ms
Inserted 100000 policies in 216848 ms

After:
Inserted 1000   policies in 56 ms
Inserted 10000  policies in 478 ms
Inserted 100000 policies in 4580 ms

Insertion of 1m entries takes about ~40s after this change
on my test vm.

Cc: Noel Kuntze <noel@familie-kuntze.de>
Cc: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/xfrm.h     |  1 -
 net/xfrm/xfrm_policy.c | 38 --------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 54cef89f6c1e..101715064707 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -555,7 +555,6 @@ struct xfrm_policy {
 	u16			family;
 	struct xfrm_sec_ctx	*security;
 	struct xfrm_tmpl       	xfrm_vec[XFRM_MAX_DEPTH];
-	struct hlist_node	bydst_inexact_list;
 	struct rcu_head		rcu;
 
 	struct xfrm_dev_offload xdo;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d2feee60bb62..b79ac453ea37 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -196,8 +196,6 @@ xfrm_policy_inexact_lookup_rcu(struct net *net,
 static struct xfrm_policy *
 xfrm_policy_insert_list(struct hlist_head *chain, struct xfrm_policy *policy,
 			bool excl);
-static void xfrm_policy_insert_inexact_list(struct hlist_head *chain,
-					    struct xfrm_policy *policy);
 
 static bool
 xfrm_policy_find_inexact_candidates(struct xfrm_pol_inexact_candidates *cand,
@@ -410,7 +408,6 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 	if (policy) {
 		write_pnet(&policy->xp_net, net);
 		INIT_LIST_HEAD(&policy->walk.all);
-		INIT_HLIST_NODE(&policy->bydst_inexact_list);
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
 		rwlock_init(&policy->lock);
@@ -1228,9 +1225,6 @@ xfrm_policy_inexact_insert(struct xfrm_policy *policy, u8 dir, int excl)
 		return ERR_PTR(-EEXIST);
 	}
 
-	chain = &net->xfrm.policy_inexact[dir];
-	xfrm_policy_insert_inexact_list(chain, policy);
-
 	if (delpol)
 		__xfrm_policy_inexact_prune_bin(bin, false);
 
@@ -1346,7 +1340,6 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		}
 
 		hlist_del_rcu(&policy->bydst);
-		hlist_del_init(&policy->bydst_inexact_list);
 
 		newpos = NULL;
 		chain = policy_hash_bysel(net, &policy->selector,
@@ -1515,36 +1508,6 @@ static const struct rhashtable_params xfrm_pol_inexact_params = {
 	.automatic_shrinking	= true,
 };
 
-static void xfrm_policy_insert_inexact_list(struct hlist_head *chain,
-					    struct xfrm_policy *policy)
-{
-	struct xfrm_policy *pol, *delpol = NULL;
-	struct hlist_node *newpos = NULL;
-
-	hlist_for_each_entry(pol, chain, bydst_inexact_list) {
-		if (pol->type == policy->type &&
-		    pol->if_id == policy->if_id &&
-		    !selector_cmp(&pol->selector, &policy->selector) &&
-		    xfrm_policy_mark_match(&policy->mark, pol) &&
-		    xfrm_sec_ctx_match(pol->security, policy->security) &&
-		    !WARN_ON(delpol)) {
-			delpol = pol;
-			if (policy->priority > pol->priority)
-				continue;
-		} else if (policy->priority >= pol->priority) {
-			newpos = &pol->bydst_inexact_list;
-			continue;
-		}
-		if (delpol)
-			break;
-	}
-
-	if (newpos && policy->xdo.type != XFRM_DEV_OFFLOAD_PACKET)
-		hlist_add_behind_rcu(&policy->bydst_inexact_list, newpos);
-	else
-		hlist_add_head_rcu(&policy->bydst_inexact_list, chain);
-}
-
 static struct xfrm_policy *xfrm_policy_insert_list(struct hlist_head *chain,
 						   struct xfrm_policy *policy,
 						   bool excl)
@@ -2346,7 +2309,6 @@ static struct xfrm_policy *__xfrm_policy_unlink(struct xfrm_policy *pol,
 	/* Socket policies are not hashed. */
 	if (!hlist_unhashed(&pol->bydst)) {
 		hlist_del_rcu(&pol->bydst);
-		hlist_del_init(&pol->bydst_inexact_list);
 		hlist_del(&pol->byidx);
 	}
 
-- 
2.44.2


