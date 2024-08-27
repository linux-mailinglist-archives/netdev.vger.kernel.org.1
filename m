Return-Path: <netdev+bounces-122353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76935960C63
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F46F1F21181
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1E1BFE04;
	Tue, 27 Aug 2024 13:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC671BFE1C
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766088; cv=none; b=o48t09yqBtfl025DEBVT+CWqGiW8vRGicdw1g7G3By++Z/o+0onZX4IaGu2KneBKVkra+anckBpcUkXv4SVqu7uPaIEb5ZZK2fJi0jchUMA6nWqz1s6KXk2sKzp7HheeM2ioYRAQCM6AtqGi0OTsSU4rKcLJHipM0kxaU0RFoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766088; c=relaxed/simple;
	bh=BJQTUzZjxM9ugGvdHLngGKbxPIyGSC3VTspxMw/BoQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5KQ3mCcP2f68OrJW6haltZi58ym/31+SResg2CnTxVxmqROvGnfDz7swbc9Ua8R1nGGcMsm61yRujkF2wyPeCiwJbClWJpSUa0f4mjqCeQj14V2JOMTuORmt27Y68cyWD/A0Ueu8lKnldrLp4Mivd11KOA+VwS4Jc1pWdtg0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1siwRo-00039I-G3; Tue, 27 Aug 2024 15:41:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next] xfrm: minor update to sdb and xfrm_policy comments
Date: Tue, 27 Aug 2024 15:38:23 +0200
Message-ID: <20240827133827.19259-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spd is no longer maintained as a linear list.
We also haven't been caching bundles in the xfrm_policy
struct since 2010.

While at it, add kdoc style comments for the xfrm_policy structure
and extend the description of the current rbtree based search to
mention why it needs to search the candidate set.

Signed-off-by: Florian Westphal <fw@strlen.de>
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
2.44.2


