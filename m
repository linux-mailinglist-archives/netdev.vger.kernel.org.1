Return-Path: <netdev+bounces-126830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5F9729D9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1911F253D4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A817C9AB;
	Tue, 10 Sep 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lUuKh6Wr"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4117C20F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951328; cv=none; b=hB8ZT0YYcgn5nVrx5EqKryrOTx+spu/2z2aFbHefnMyTjoUbKtThUP7i70INw7LWkXpNXcAHqOJsGPT5htAQ0Ja9aZULPV2fhq2R4UWtjez1tJtB4+qbk1m9WVumezWuXgGfNf0x0mOJNGcRxfkNR6sN88tAwC+CggIV3xuEANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951328; c=relaxed/simple;
	bh=aWmP1tM9bDGK+sevcyJ/NTvAN8rkJWnWsKn6RP+8JBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyDtx60kD0aOlY+dYcjpCjPStLkCwiFMyaW8rTYOJNKBh4WJPrE61jeNa48qT4GBzsCNed1R2yotlR77pWxTTrIks09an05tt70PfFTXB7o/sCrGssht8taeAuw/AJlQzxYma5HCMeiKoyqfJ4nnTIIuhXcIMEOvSlFPHIH6azI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lUuKh6Wr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 068882087C;
	Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCaEbJXoPNIA; Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 363B420893;
	Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 363B420893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951322;
	bh=EKEcU6AWwiNeURiwiIW/JhbB4t6pOvMFvj+xdRwGUh4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lUuKh6Wr3AbsDadyM4h7ukrxKdSjBuUlMHcRMNZBqvV5PyxVosyVnWxdQ/LajTKwx
	 Tw8S3pyslKjx6oqRTSWcY6GaMNfbo3FGofoWhgHziWYXQj22ynzINuuwiVIn6jIws6
	 IvpE8s1ney8TWbGxXLpguBrKiOYqVSCKMpgUVtw+CPyXQTZ61U+YGb1QgRKugyw0dZ
	 Iqs3SXVdWzOITcA6Pij5NY3wg6XDVTfY3cKgKxt4solVlMEM81p5Q3H2yc7eJSsoAD
	 6OWwLoUL/V7ZDe77IDXtoXd9A591UgmIP8b648GzinMEuw/GqtVb6fQPkH90ux7zMQ
	 wwUq55HNCQBIA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 628623184092; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/13] xfrm: policy: don't iterate inexact policies twice at insert time
Date: Tue, 10 Sep 2024 08:54:59 +0200
Message-ID: <20240910065507.2436394-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


