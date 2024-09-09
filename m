Return-Path: <netdev+bounces-126482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA499714B5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857BC1C23059
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675291B4C35;
	Mon,  9 Sep 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hP7oxMj8"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B051B3F24
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876222; cv=none; b=QObxomWaAAna6FNyFBZtd6JLZ/FgdaEKBq5ZSTxKHmerGk9UzffAwnOT8ddBy0aQ41O/sdtTRKxSUASycd+nn9K0nE+1l2pYqs86vL7bdCjl7W2X1hPJU63MKIX9hqAenZTaswtQexQ21IYyud58k3pj+zjmtOzSTVSuRSBgrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876222; c=relaxed/simple;
	bh=URTURclBVdQcez9mixmYuVg7DFMGeYsrGKGcnQDeJeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJWMM1rNMuedqsDgJAwAL1Qlg5Wk89qczp6E56nElIu4fixJxWpNOSPHwYNszAc6wAn/jeEVmHWYaGRtnRuHSOz8fK3CDZRKzqDcNLKp0Il3JJKXBhZPTlQT4u3SyH/Bxu4U9gEVf+U7jx5mcldqNzed2EHkYvJbtdVKrE4gFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hP7oxMj8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C13C72083E;
	Mon,  9 Sep 2024 12:03:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y9xZYcbPlwQT; Mon,  9 Sep 2024 12:03:37 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1538D2085A;
	Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1538D2085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876216;
	bh=SUXX6W209WXnD2onP37BeprLdsQqyr4EtrH5uqJlzLA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hP7oxMj8H1qKBAP/9+aFSb0N4UDV2ZzMvR8WfKUY+zQEIkF9ONnuo8ogAzqIH7+qp
	 Ir13YaysOhQ2FFVQX3wSI0OmGzSTPqK1Hhc87JjLRolY3WnUWOnz2RBi0iTSSMWjRN
	 vQZtzYS/mG1BvyFZwKik7GjWLGP6yiUuY2sCpxGJlkdtYvRsbL5LzrvVJuin5saKwX
	 BAj883TQmbJVoE5mFlczPYTJvy73YVohfqz4LoMSkp/SM4W/D3wDRbe9ZItcFMNzRb
	 XnpPTsOWWzL+20K4gQO33/hyMElATVEVWYrJlGsRoDBBf4/Cu4J4/ekDa3tqMH1Hsp
	 Jaax01z4kgPXw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 59E95318463A; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/11] xfrm: minor update to sdb and xfrm_policy comments
Date: Mon, 9 Sep 2024 12:03:27 +0200
Message-ID: <20240909100328.1838963-11-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

The spd is no longer maintained as a linear list.
We also haven't been caching bundles in the xfrm_policy
struct since 2010.

While at it, add kdoc style comments for the xfrm_policy structure
and extend the description of the current rbtree based search to
mention why it needs to search the candidate set.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 40 +++++++++++++++++++++++++++++++++++-----
 net/xfrm/xfrm_policy.c |  6 +++++-
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1fa2da22a49e..b6bfdc6416c7 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -67,13 +67,15 @@
    - instance of a transformer, struct xfrm_state (=SA)
    - template to clone xfrm_state, struct xfrm_tmpl
 
-   SPD is plain linear list of xfrm_policy rules, ordered by priority.
+   SPD is organized as hash table (for policies that meet minimum address prefix
+   length setting, net->xfrm.policy_hthresh).  Other policies are stored in
+   lists, sorted into rbtree ordered by destination and source address networks.
+   See net/xfrm/xfrm_policy.c for details.
+
    (To be compatible with existing pfkeyv2 implementations,
    many rules with priority of 0x7fffffff are allowed to exist and
    such rules are ordered in an unpredictable way, thanks to bsd folks.)
 
-   Lookup is plain linear search until the first match with selector.
-
    If "action" is "block", then we prohibit the flow, otherwise:
    if "xfrms_nr" is zero, the flow passes untransformed. Otherwise,
    policy entry has list of up to XFRM_MAX_DEPTH transformations,
@@ -86,8 +88,6 @@
                      |---. child .-> dst -. xfrm .-> xfrm_state #3
                                       |---. child .-> NULL
 
-   Bundles are cached at xrfm_policy struct (field ->bundles).
-
 
    Resolution of xrfm_tmpl
    -----------------------
@@ -526,6 +526,36 @@ struct xfrm_policy_queue {
 	unsigned long		timeout;
 };
 
+/**
+ *	struct xfrm_policy - xfrm policy
+ *	@xp_net: network namespace the policy lives in
+ *	@bydst: hlist node for SPD hash table or rbtree list
+ *	@byidx: hlist node for index hash table
+ *	@lock: serialize changes to policy structure members
+ *	@refcnt: reference count, freed once it reaches 0
+ *	@pos: kernel internal tie-breaker to determine age of policy
+ *	@timer: timer
+ *	@genid: generation, used to invalidate old policies
+ *	@priority: priority, set by userspace
+ *	@index:  policy index (autogenerated)
+ *	@if_id: virtual xfrm interface id
+ *	@mark: packet mark
+ *	@selector: selector
+ *	@lft: liftime configuration data
+ *	@curlft: liftime state
+ *	@walk: list head on pernet policy list
+ *	@polq: queue to hold packets while aqcuire operaion in progress
+ *	@bydst_reinsert: policy tree node needs to be merged
+ *	@type: XFRM_POLICY_TYPE_MAIN or _SUB
+ *	@action: XFRM_POLICY_ALLOW or _BLOCK
+ *	@flags: XFRM_POLICY_LOCALOK, XFRM_POLICY_ICMP
+ *	@xfrm_nr: number of used templates in @xfrm_vec
+ *	@family: protocol family
+ *	@security: SELinux security label
+ *	@xfrm_vec: array of templates to resolve state
+ *	@rcu: rcu head, used to defer memory release
+ *	@xdo: hardware offload state
+ */
 struct xfrm_policy {
 	possible_net_t		xp_net;
 	struct hlist_node	bydst;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 94859b2182ec..6336baa8a93c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -109,7 +109,11 @@ struct xfrm_pol_inexact_node {
  * 4. saddr:any list from saddr tree
  *
  * This result set then needs to be searched for the policy with
- * the lowest priority.  If two results have same prio, youngest one wins.
+ * the lowest priority.  If two candidates have the same priority, the
+ * struct xfrm_policy pos member with the lower number is used.
+ *
+ * This replicates previous single-list-search algorithm which would
+ * return first matching policy in the (ordered-by-priority) list.
  */
 
 struct xfrm_pol_inexact_key {
-- 
2.34.1


