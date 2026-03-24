Return-Path: <netdev+bounces-270906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNdzASRBwmmCagQAu9opvQ
	(envelope-from <netdev+bounces-270906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:45:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8413041F7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8D43039C80
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127833D6EE;
	Tue, 24 Mar 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6OXRmbl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A012459ED
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337882; cv=none; b=u0va7pZaF7+q1XMaJebLMbFSHCZM7DF/lAjvyH/3iTiMhbSPAm41P8aFqGDWQm9D9XGkEEzvj2kGLFzXGpLoHzq0L7AqNOCkubcUgYc0OVpsnQzKfc47VwCCnzYjBGOUKJBJl7MxPWdcRzrVqHk777pMQ6Hd+n0np1knQbvDhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337882; c=relaxed/simple;
	bh=LAxve2E723xcInPxFfOLjYpn/zETcYmFrZ0F4Ktispw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sa9M8DLY8Ia7HCkWA+KpfMPE5e32LTakB/pf/Fe9OD/W9ruKERCbQQRm7Ibtmv/BkzOIfsILolLVfpHmZMk+VexPCtrjSd2yrCilEel6l9RJE/JWQIySHbGGSjnBcu5k6t6I+Py3DOTT83jjtJUb26IcUwuQrDRzgw4jy3MZOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6OXRmbl; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5093787e2fdso214740491cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774337872; x=1774942672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IB6zNT730Q19QwQ1KMTzIfdYI7dQ5nb7NkdxT4Gv9fA=;
        b=j6OXRmbljos/4BUMIj/GC32kW5djP7XN+Zm9EBngqKhn0bEJzEVoFrPg8HUfI4PaPG
         Vw/42Gxic/O1YSzfEuQBENJSuaEkI/1KH+o4dux0fzjrHgEb8igElaL+lPSlIYuYe3p9
         pZbO+tW4k6jCthTI3N1Q/T7tGIZtLwaBoFpmst1zuWUv/nVbcVcMq3QnIJ7MuhJmj7eD
         Ghw3oifnUN3baYFTxuD9oPRfx2E8qYMFNS5LH/vGxviD09yAYj0RQh6WIfhGPCFv75eS
         iL3VfnOo7Hc21cOIpkGPtk4Gsq77o/yHBvAffF6JNlJr9H4U4Ohxb7meSec8/EmoeIt1
         /lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774337872; x=1774942672;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB6zNT730Q19QwQ1KMTzIfdYI7dQ5nb7NkdxT4Gv9fA=;
        b=hDfeQ6kSPtgYrHpZx5Z0BHoCh0e/XdINInF73TTN91Ho4mnmm4HRieEmP9lmYFVdDi
         zy++ys5wi7IX2SIP18N/IOOy9/qlfGxvIVuWZmHPJLaLNmq2Z6hGh+t0u3j5jqolOwKY
         tc+TkDhS2qo5MnhB4PBitjev7eJzasWkQ04Nk3KjEJyw7k8w5q+iGA55wuOI26WrjOmK
         JMe0nBGnAjkFAfgrGgVm3U+SAK1mHSGUcBAQQY48VyJNe/oPN+TX12tk6QQEx/ISr//i
         5jYmRloQU4wgSpsMUFWbU7o+kycIASdqHL+W57GVG5TcBLsGWu4Tih+ZAU0zAdhTu8h1
         x0fA==
X-Forwarded-Encrypted: i=1; AJvYcCURG2jMzRBM1UOxS3YPt8F+EsAf8NsZhk5jVo3jt3ut1EvAAvWG6v25eEGY49FdyUmtSUyBKjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9VA5YgwTwyRr5yf7hs2nPdxEP6RBomjgc7Kxgh/w7ndxQArN
	bwALMr7lctzXwTC445CXrwokPm86+EuAbVDZJqSdrfjEet6F06rAyrCJMOE66dVM7E2xMYlo5zp
	sVwUWw54GGkOKBA==
X-Received: from qtw1.prod.google.com ([2002:ac8:5701:0:b0:509:14e4:44ee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1149:b0:50b:5183:f74e with SMTP id d75a77b69052e-50b5183fc8fmr136480671cf.31.1774337872103;
 Tue, 24 Mar 2026 00:37:52 -0700 (PDT)
Date: Tue, 24 Mar 2026 07:37:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260324073750.1500328-1-edumazet@google.com>
Subject: [PATCH net-next] net/dst: improve dst_ops refcounting with per-dst bit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, xietangxin <xietangxin@yeah.net>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,yeah.net];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270906-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yeah.net:email]
X-Rspamd-Queue-Id: 5A8413041F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before a netns is destroyed, we make sure that all its dst_entries
have been removed, or went through dst_dev_put().

Problem:

dst that went through dst_dev_put() might call dst_release() way after
the netns has been dismantled/freed.

IPv6 keeps its ip6_dst_ops embedded in struct netns_ipv6.

This means dst_count_dec() might be called with a dst->ops pointing
to freed memory.

Similarly dst->ops->kmem_cachep can cause UAF.

In this patch, I added a dst_count_dec() call from dst_dev_put(),
and I added an atomic bit to make sure the dst_ops refcount is released
at most once.

Then when dst_dev_put() is called, switch dst->ops to the 'template'
object, so that dst->ops points back to static memory.

We might later add more READ_ONCE(dst->ops) to avoid hypothetical load-tearing.

Or we could move the counters into a separate structure, so that dst->ops
is never changed.

DEBUG_NET_WARN_ON_ONCE(dst_entries_get_slow(dst) > 0) is added to
dst_entries_destroy() to warn if a dst_ops is destroyed while still
having active dst_entry references.

DEBUG_NET_WARN_ON_ONCE(dst->dst_ops_refcounted) is added to dst_destroy()
to warn if a dst_entry is being freed but its dst_ops_refcounted bit
is still set, indicating a potential refcount leak.

Note: IFF_XMIT_DST_RELEASE was added as a performance improvement, not
specifically to fix this bug.

We can still audit drivers to make sure they call skb_dst_drop()
before holding an skb for arbitrary amount of time.

Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
Closes: https://lore.kernel.org/netdev/20260312024902.15627-1-xietangxin@yeah.net/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>
---
 include/net/dst.h         |  1 +
 include/net/dst_ops.h     |  3 +++
 net/bridge/br_nf_core.c   |  1 +
 net/core/dst.c            | 31 +++++++++++++++++++++----------
 net/core/pktgen.c         |  1 +
 net/ipv4/route.c          |  2 ++
 net/ipv4/xfrm4_policy.c   |  1 +
 net/ipv6/route.c          |  2 ++
 net/ipv6/xfrm6_policy.c   |  1 +
 net/openvswitch/actions.c |  1 +
 net/sched/sch_frag.c      |  1 +
 11 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 307073eae7f83456aa80dfa8686f839b302ca004..793f38452bf49a57bf2ed9d875efa831be360ed2 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -95,6 +95,7 @@ struct dst_entry {
 #ifdef CONFIG_64BIT
 	struct lwtunnel_state   *lwtstate;
 #endif
+	unsigned long		dst_ops_refcounted; /* Use one (atomic) bit */
 };
 
 struct dst_metrics {
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 3a9001a042a5c392a79cfc59af528ef410a28668..dc4ab11c3eed022cf346e38301e2d66eee7ed44a 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/percpu_counter.h>
 #include <linux/cache.h>
+#include <net/net_debug.h>
 
 struct dst_entry;
 struct kmem_cachep;
@@ -39,6 +40,7 @@ struct dst_ops {
 						 const void *daddr);
 
 	struct kmem_cache	*kmem_cachep;
+	struct dst_ops		*template;
 
 	struct percpu_counter	pcpuc_entries ____cacheline_aligned_in_smp;
 };
@@ -67,6 +69,7 @@ static inline int dst_entries_init(struct dst_ops *dst)
 
 static inline void dst_entries_destroy(struct dst_ops *dst)
 {
+	DEBUG_NET_WARN_ON_ONCE(dst_entries_get_slow(dst) > 0);
 	percpu_counter_destroy(&dst->pcpuc_entries);
 }
 
diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index a8c67035e23c00cc689801c89fcc444f96c5650c..fc6548475ac3b626fa022eae29418588ddf16d76 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -56,6 +56,7 @@ static struct dst_ops fake_dst_ops = {
 	.cow_metrics	= fake_cow_metrics,
 	.neigh_lookup	= fake_neigh_lookup,
 	.mtu		= fake_mtu,
+	.template	= &fake_dst_ops,
 };
 
 /*
diff --git a/net/core/dst.c b/net/core/dst.c
index 092861133023c819000be59931ac365ac1651a1f..d1efd3e7c44e3885f00a687f0de4d7865d145174 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -72,8 +72,11 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 	dst->__use = 0;
 	dst->lastuse = jiffies;
 	dst->flags = flags;
-	if (!(flags & DST_NOCOUNT))
+	dst->dst_ops_refcounted = 0;
+	if (!(flags & DST_NOCOUNT)) {
+		dst->dst_ops_refcounted = 1;
 		dst_entries_add(ops, 1);
+	}
 }
 EXPORT_SYMBOL(dst_init);
 
@@ -100,6 +103,7 @@ EXPORT_SYMBOL(dst_alloc);
 static void dst_destroy(struct dst_entry *dst)
 {
 	struct dst_entry *child = NULL;
+	const struct dst_ops *ops;
 
 	smp_rmb();
 
@@ -110,16 +114,18 @@ static void dst_destroy(struct dst_entry *dst)
 		child = xdst->child;
 	}
 #endif
-	if (dst->ops->destroy)
-		dst->ops->destroy(dst);
+	ops = READ_ONCE(dst->ops);
+	if (ops->destroy)
+		ops->destroy(dst);
 	netdev_put(dst->dev, &dst->dev_tracker);
 
 	lwtstate_put(dst->lwtstate);
 
+	DEBUG_NET_WARN_ON_ONCE(dst->dst_ops_refcounted);
 	if (dst->flags & DST_METADATA)
 		metadata_dst_free((struct metadata_dst *)dst);
 	else
-		kmem_cache_free(dst->ops->kmem_cachep, dst);
+		kmem_cache_free(ops->kmem_cachep, dst);
 
 	dst = child;
 	if (dst)
@@ -133,6 +139,14 @@ static void dst_destroy_rcu(struct rcu_head *head)
 	dst_destroy(dst);
 }
 
+static void dst_count_dec(struct dst_entry *dst)
+{
+	struct dst_ops *ops = READ_ONCE(dst->ops);
+
+	if (cmpxchg(&dst->dst_ops_refcounted, 1, 0) == 1)
+		dst_entries_add(ops, -1);
+}
+
 /* Operations to mark dst as DEAD and clean up the net device referenced
  * by dst:
  * 1. put the dst under blackhole interface and discard all tx/rx packets
@@ -146,9 +160,11 @@ void dst_dev_put(struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 
+	dst_count_dec(dst);
 	WRITE_ONCE(dst->obsolete, DST_OBSOLETE_DEAD);
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
+	WRITE_ONCE(dst->ops, dst->ops->template);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
 	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
@@ -157,12 +173,6 @@ void dst_dev_put(struct dst_entry *dst)
 }
 EXPORT_SYMBOL(dst_dev_put);
 
-static void dst_count_dec(struct dst_entry *dst)
-{
-	if (!(dst->flags & DST_NOCOUNT))
-		dst_entries_add(dst->ops, -1);
-}
-
 void dst_release(struct dst_entry *dst)
 {
 	if (dst && rcuref_put(&dst->__rcuref)) {
@@ -276,6 +286,7 @@ static struct dst_ops dst_blackhole_ops = {
 	.update_pmtu	= dst_blackhole_update_pmtu,
 	.redirect	= dst_blackhole_redirect,
 	.mtu		= dst_blackhole_mtu,
+	.template	= &dst_blackhole_ops,
 };
 
 static void __metadata_dst_init(struct metadata_dst *md_dst,
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288530fd2e1111feb343d25b30b4817..a21bb8a8f2752ba6d057c3b206eadcb76d1a1ea4 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3894,6 +3894,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	 * performance under such circumstance.
 	 */
 	pkt_dev->dstops.family = AF_INET;
+	pkt_dev->dstops.template = &pkt_dev->dstops;
 	pkt_dev->xdst.u.dst.dev = pkt_dev->odev;
 	dst_init_metrics(&pkt_dev->xdst.u.dst, pktgen_dst_metrics, false);
 	pkt_dev->xdst.child = &pkt_dev->xdst.u.dst;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 463236e0dc2d5f2ffefbdd8677c2baa14930ab57..31c5cc26188523427a72dd5ebdbbb33ecb8c127c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -165,6 +165,7 @@ static struct dst_ops ipv4_dst_ops = {
 	.local_out =		__ip_local_out,
 	.neigh_lookup =		ipv4_neigh_lookup,
 	.confirm_neigh =	ipv4_confirm_neigh,
+	.template =		&ipv4_dst_ops,
 };
 
 #define ECN_OR_COST(class)	TC_PRIO_##class
@@ -2887,6 +2888,7 @@ static struct dst_ops ipv4_dst_blackhole_ops = {
 	.update_pmtu		= dst_blackhole_update_pmtu,
 	.redirect		= dst_blackhole_redirect,
 	.mtu			= dst_blackhole_mtu,
+	.template		= &ipv4_dst_blackhole_ops,
 };
 
 struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_orig)
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 58faf1ddd2b151e4569bb6351029718dac37521b..d20849dcfc29a75809222e4a6308c42aa541e003 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -130,6 +130,7 @@ static struct dst_ops xfrm4_dst_ops_template = {
 	.ifdown =		xfrm_dst_ifdown,
 	.local_out =		__ip_local_out,
 	.gc_thresh =		32768,
+	.template = 		&xfrm4_dst_ops_template,
 };
 
 static const struct xfrm_policy_afinfo xfrm4_policy_afinfo = {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 08cd86f49bf96383e3c37dbe1e662b42859afe90..658c0f742e458a5573dffdb905834911d72373fb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -263,6 +263,7 @@ static struct dst_ops ip6_dst_ops_template = {
 	.local_out		=	__ip6_local_out,
 	.neigh_lookup		=	ip6_dst_neigh_lookup,
 	.confirm_neigh		=	ip6_confirm_neigh,
+	.template		=	&ip6_dst_ops_template,
 };
 
 static struct dst_ops ip6_dst_blackhole_ops = {
@@ -275,6 +276,7 @@ static struct dst_ops ip6_dst_blackhole_ops = {
 	.update_pmtu		= dst_blackhole_update_pmtu,
 	.redirect		= dst_blackhole_redirect,
 	.mtu			= dst_blackhole_mtu,
+	.template		= &ip6_dst_blackhole_ops,
 };
 
 static const u32 ip6_template_metrics[RTAX_MAX] = {
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 125ea9a5b8a082052380b7fd7ed7123f5247d7cc..caabc6de4a7f1376482c229648e26c15b9bf00c4 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -165,6 +165,7 @@ static struct dst_ops xfrm6_dst_ops_template = {
 	.ifdown =		xfrm6_dst_ifdown,
 	.local_out =		__ip6_local_out,
 	.gc_thresh =		32768,
+	.template =		&xfrm6_dst_ops_template,
 };
 
 static const struct xfrm_policy_afinfo xfrm6_policy_afinfo = {
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461da0bb98d49bfe9f233214fb57a61e..0cf26afaa5cf9533aa946566f672627c12881d20 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -731,6 +731,7 @@ ovs_dst_get_mtu(const struct dst_entry *dst)
 static struct dst_ops ovs_dst_ops = {
 	.family = AF_UNSPEC,
 	.mtu = ovs_dst_get_mtu,
+	.template = &ovs_dst_ops,
 };
 
 /* prepare_frag() is called once per (larger-than-MTU) frame; its inverse is
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index d1d87dce7f3f72e33e3c8ec0c0eb35bdd9b5c9f1..f8e1071ca1fd229d43c9208f00e2bbbd3ab4a4a1 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -83,6 +83,7 @@ sch_frag_dst_get_mtu(const struct dst_entry *dst)
 static struct dst_ops sch_frag_dst_ops = {
 	.family = AF_UNSPEC,
 	.mtu = sch_frag_dst_get_mtu,
+	.template = &sch_frag_dst_ops,
 };
 
 static int sch_fragment(struct net *net, struct sk_buff *skb,
-- 
2.53.0.983.g0bb29b3bc5-goog


