Return-Path: <netdev+bounces-121003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95D95B641
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1431C283DFE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB971CB14A;
	Thu, 22 Aug 2024 13:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30441CB14D
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332649; cv=none; b=uCKL9JxIfJRy+jxMzgVECwh3eJDcPnFuwbsma7ZklmcAkvaDiIPSl0++fzrvRPFYDfejQ0p2Wb0QJ2ULENjM2Grd5G5wWO6Jr3SknimzossEqWyRzpWtPMyxPGREW6XZH0PJ3s3UqLQEZgnQv0nbWRORB3ozAbZsok39fMKAa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332649; c=relaxed/simple;
	bh=HBYSmUaZEAcnty3c/IEtnPkv1TfpCCahI+zrA3LRKgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ19yCm9nSLfjrUtD3GA8Vp/XXOON30+zYjqbPz69xNFd1Qf9GSTLdiQ9BuHTDLqjf+s22VQ7QcEG0KKQgQAyiiYMk/EAj+F8AZZG5hmAqP+UFzroczB1DUCnPnNlkSMQCtSTvds8A0so2LSLLY/UBOP1Ta9LL8RNJlIEI7vs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sh7gs-0006pB-Az; Thu, 22 Aug 2024 15:17:26 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	noel@familie-kuntze.de,
	tobias@strongswan.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 2/4] xfrm: policy: don't iterate inexact policies twice at insert time
Date: Thu, 22 Aug 2024 15:04:30 +0200
Message-ID: <20240822130643.5808-3-fw@strlen.de>
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

Since commit
6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")
policy lookup no longer walks a list but has a set of candidate lists.

This set has to be searched for the best match.
In case there are several matches, the priority wins.

If the priority is also the same, then the historic behaviour with
a single list was to return the first match (first-in-list).

With introduction of serval lists, this doesn't work and a new
'pos' member was added that reflects the xfrm_policy structs position
in the list.

This value is not exported to userspace and it does not need to be
the 'position in the list', it just needs to make sure that
a->pos < b->pos means that a was added to the lists more recently
than b.

This re-walk is expensive when many inexact policies are in use.

Speed this up: when appending the policy to the end of the walker list,
then just take the ->pos value of the last entry made and add 1.

Add a slowpath version to prevent overflow, if we'd assign UINT_MAX
then iterate the entire list and fix the ordering.

While this speeds up insertion considerably finding the insertion spot
in the inexact list still requires a partial list walk.

This is addressed in followup patches.

Before:
./xfrm_policy_add_speed.sh
Inserted 1000   policies in 72 ms
Inserted 10000  policies in 1540 ms
Inserted 100000 policies in 334780 ms

After:
Inserted 1000   policies in 68 ms
Inserted 10000  policies in 1137 ms
Inserted 100000 policies in 157307 ms

Reported-by: Noel Kuntze <noel@familie-kuntze.de>
Cc: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_policy.c | 59 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c56c61b0c12e..423d1eb24f31 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1237,6 +1237,17 @@ xfrm_policy_inexact_insert(struct xfrm_policy *policy, u8 dir, int excl)
 	return delpol;
 }
 
+static bool xfrm_policy_is_dead_or_sk(const struct xfrm_policy *policy)
+{
+	int dir;
+
+	if (policy->walk.dead)
+		return true;
+
+	dir = xfrm_policy_id2dir(policy->index);
+	return dir >= XFRM_POLICY_MAX;
+}
+
 static void xfrm_hash_rebuild(struct work_struct *work)
 {
 	struct net *net = container_of(work, struct net,
@@ -1524,7 +1535,6 @@ static void xfrm_policy_insert_inexact_list(struct hlist_head *chain,
 {
 	struct xfrm_policy *pol, *delpol = NULL;
 	struct hlist_node *newpos = NULL;
-	int i = 0;
 
 	hlist_for_each_entry(pol, chain, bydst_inexact_list) {
 		if (pol->type == policy->type &&
@@ -1548,11 +1558,6 @@ static void xfrm_policy_insert_inexact_list(struct hlist_head *chain,
 		hlist_add_behind_rcu(&policy->bydst_inexact_list, newpos);
 	else
 		hlist_add_head_rcu(&policy->bydst_inexact_list, chain);
-
-	hlist_for_each_entry(pol, chain, bydst_inexact_list) {
-		pol->pos = i;
-		i++;
-	}
 }
 
 static struct xfrm_policy *xfrm_policy_insert_list(struct hlist_head *chain,
@@ -2294,10 +2299,52 @@ static struct xfrm_policy *xfrm_sk_policy_lookup(const struct sock *sk, int dir,
 	return pol;
 }
 
+static u32 xfrm_gen_pos_slow(struct net *net)
+{
+	struct xfrm_policy *policy;
+	u32 i = 0;
+
+	/* oldest entry is last in list */
+	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
+		if (!xfrm_policy_is_dead_or_sk(policy))
+			policy->pos = ++i;
+	}
+
+	return i;
+}
+
+static u32 xfrm_gen_pos(struct net *net)
+{
+	const struct xfrm_policy *policy;
+	u32 i = 0;
+
+	/* most recently added policy is at the head of the list */
+	list_for_each_entry(policy, &net->xfrm.policy_all, walk.all) {
+		if (xfrm_policy_is_dead_or_sk(policy))
+			continue;
+
+		if (policy->pos == UINT_MAX)
+			return xfrm_gen_pos_slow(net);
+
+		i = policy->pos + 1;
+		break;
+	}
+
+	return i;
+}
+
 static void __xfrm_policy_link(struct xfrm_policy *pol, int dir)
 {
 	struct net *net = xp_net(pol);
 
+	switch (dir) {
+	case XFRM_POLICY_IN:
+	case XFRM_POLICY_FWD:
+	case XFRM_POLICY_OUT:
+		pol->pos = xfrm_gen_pos(net);
+		break;
+	}
+
 	list_add(&pol->walk.all, &net->xfrm.policy_all);
 	net->xfrm.policy_count[dir]++;
 	xfrm_pol_hold(pol);
-- 
2.44.2


