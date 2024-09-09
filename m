Return-Path: <netdev+bounces-126484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790519714B7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF191C23109
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E41B530A;
	Mon,  9 Sep 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VcaFkBT/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600661B3F3F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876223; cv=none; b=ICqjL30evk0sqJ73OcNkwFVqmFkY0SC4MnAzctGGvoWv+K1WhEU97T5BlBjv0Kn9qki8zczTG071HkI04/efci8jBXpllXPvajpwZJYb1uUCj/FUbE72Gmaz9/EosJJ3KUzYXusIrlaXCQe9e0AenB/Ej8kho1P0u06w9/YFkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876223; c=relaxed/simple;
	bh=0TST6cxqOzGGpTqTkGXpBgzChHanW4rbJG1BD8aLbu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2XzpobSb4xUxsviXewd93RwTBn8iirE3EU3fh5b0dPRKM8O6uiEtZtvg7PbLlDqt1/K5ghwJphXug9KS/XPBMhVJvxAazf90VAiCjZbyvhldiQtGVBfHmO06U62UFuJB+Wsk2xTTFzSB1Hcg9PHQ9ES/eWw1R+cu27yYryt2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VcaFkBT/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 582CA2087B;
	Mon,  9 Sep 2024 12:03:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPtsb6fC-7_N; Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BC3012082B;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BC3012082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876215;
	bh=vorJ3V1CsURCiWLfS0xBx3s7lc9k2WC3MGLw4OwzGi0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VcaFkBT/cqa+ta63JIdtp593dlLZDgqRmE5dt82xVaCMmqWAUaO6pfHdWglcINIOk
	 V0p8dIMQxZAkRN8+L0vMFisyIkleeuCkqUsr1UHCBoEzxrfkunjW+CMYzLTSQ+ZwrG
	 zYDzDT3kll1mYw87j45dSxG5MYlKNgQpv5IDhgCYCg+o1gl4Sy86/5eNX3nJiAmFVx
	 Dp7ocdMqBMo760JRfrP+DXSywMkub+4ndDaRdSP6kx9P4/FLO+hXeQLt9upIFhUpyi
	 ze8F092TUr8qIgYF6f7GGXOd3f1oUwAKp10myFVAetCrekUBiC/aLCovoBtcWm+Hwt
	 cT6vSGBds3/bA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4558131844C0; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/11] xfrm: policy: remove remaining use of inexact list
Date: Mon, 9 Sep 2024 12:03:24 +0200
Message-ID: <20240909100328.1838963-8-steffen.klassert@secunet.com>
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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  1 -
 net/xfrm/xfrm_policy.c | 38 --------------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f7244ac4fa08..1fa2da22a49e 100644
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
2.34.1


