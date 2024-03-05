Return-Path: <netdev+bounces-77582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B715B872394
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A21C22E15
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DE128834;
	Tue,  5 Mar 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o09aTMVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829A128830
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654666; cv=none; b=gaoSGxCWyJlgbjpgwAbpB63UYJHoIyU3pc0y4lCcPw9lr45UVvh5F4k1wZCFgS05BDX0eoR/D62xciKW+gJAjYIUy1X9zHhzeU3gKA6eQ9Wdwul6q4xXFs3PJD3SgdExxjhHq75QSDxABYmTfWh8TbKjxqhP3RFyTW/Gv1T91GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654666; c=relaxed/simple;
	bh=0yw0C0XAQ5Askvz5OGBEXGb8dMuNgFf9izDpTevmaDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2v2FRzn4XcU4S7SLHp9+m1ctaogDYTEDKuEPhecfi4eqbKCjqCMfs8/o72Ix0Q6/+qR3GRDXXMg/f4tx437jl2F3DcgOCn/Z8v1L5qcs5MmrZkJ+b5XSe7QGVwgi2jDnX4ehJrJSzo/kem5TA3ezbv3fUEmR8ALpMgm7G7miiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o09aTMVI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso9808852276.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654663; x=1710259463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI8hlkbcYR6A41wLQsMFj8e6JRiA/d3SlGACllYlHvw=;
        b=o09aTMVIYkxxDCmcQRo4G9rqMO5DFEz1NT82gkpZ0rWHO4pMVT64RJoaT0b5blCkZM
         UqBOQ8H5YfpkMUerpDLDWTEUB+GQuzigzlOreyjIvnWFwUYI+GO1HgKKSe9p4dBoLvuM
         e4x1a2dKayOHnPTCBWEmBZM/zT3sJVBt/JqBa6YaQJT/UIHEgCFZjODUMRopXARGYIIR
         i4leSzf+grGPgejoEzGDNY2ppKwmsq/yCuN/UucDyL1IN5HVjGn/CZafWVAr99hEVV8T
         lBlYvHZih7HyCG8ol83eerRhRQYuxg4j8VlILOlrA8f2KPvFen20X6MRGDu92y5Ek/dI
         c0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654663; x=1710259463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI8hlkbcYR6A41wLQsMFj8e6JRiA/d3SlGACllYlHvw=;
        b=tUk9bZRNy1h5HBgReHc7IKj5cjf+QaKXt//4WdRNyB/8o1uA/Ks8wT3opcupLU0KM1
         RmvO3RgxJND1eUBCaeHg61oVJWeXmchsNxbgWrYKi+7U7oNsYkisGfuRhd1++3M4MW+X
         xaik2kPO6OwB/JJQN5yH4wGjfeHxiVcgbJvXeAUsQYjQIQvLvck/KgePm6RcygiUjbIB
         RahhwmPJSjpc6djcrNCR5VlmLD6iiD84H2LGRXcC/2JPX4zC7tsqYpU113DYSY67kQFt
         7GZtUFW3+azROEYs85vlBbgvf6eY0azBYn2sIl/YKRU1Qmlj/XPc+EhRM+ln2ozrj569
         jXtA==
X-Gm-Message-State: AOJu0YxltOvhyiD0/Uag0G6aJPswjM6drueTaVwExZ0H2vSUmHXPiSdw
	9DoSnAiIMgkYa0xMD/nzN+MTG92KekSY8fMnHyoIPd7RNp+IfFb39Xe9VYOAqSphre/gCo0MqFt
	VEHmtJdmVyw==
X-Google-Smtp-Source: AGHT+IEQ6CSpyvi526a/E6/437rLfO+gQ8YqMPl0yg9tYAlQpPoG/gWA/JLqAQjreKevsghwp4HVBtOGic7T1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:f307:0:b0:dc7:4af0:8c6c with SMTP id
 c7-20020a25f307000000b00dc74af08c6cmr473643ybs.6.1709654663380; Tue, 05 Mar
 2024 08:04:23 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:00 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-6-edumazet@google.com>
Subject: [PATCH net-next 05/18] net: move netdev_max_backlog to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_max_backlog is used in rx fat path.

Move it to net_hodata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h  | 1 -
 include/net/hotdata.h      | 1 +
 net/core/dev.c             | 8 +++-----
 net/core/gro_cells.c       | 3 ++-
 net/core/hotdata.c         | 2 ++
 net/core/sysctl_net_core.c | 2 +-
 net/xfrm/espintcp.c        | 4 +++-
 net/xfrm/xfrm_input.c      | 3 ++-
 8 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e2e7d5a7ef34de165cd293eb71800e1e6b450432..044d6f5b2ace3e2decd4296e01c8d3e200c6c7dc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4787,7 +4787,6 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 			   const struct pcpu_sw_netstats __percpu *netstats);
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 
-extern int		netdev_max_backlog;
 extern int		dev_rx_weight;
 extern int		dev_tx_weight;
 
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index d462cb8f16bad459b439c566274c01a0f18a95d0..dc50b200a94b6b935cd79d8e0406a61209fdc68e 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -12,6 +12,7 @@ struct net_hotdata {
 	int			netdev_budget;
 	int			netdev_budget_usecs;
 	int			tstamp_prequeue;
+	int			max_backlog;
 };
 
 extern struct net_hotdata net_hotdata;
diff --git a/net/core/dev.c b/net/core/dev.c
index 119b7004a8e51ea6785c60e558988d369eec8935..1b112c4db983c2d7cd280bc8c2ebc621ea3c6145 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4404,9 +4404,6 @@ EXPORT_SYMBOL(__dev_direct_xmit);
  *			Receiver routines
  *************************************************************************/
 
-int netdev_max_backlog __read_mostly = 1000;
-EXPORT_SYMBOL(netdev_max_backlog);
-
 unsigned int sysctl_skb_defer_max __read_mostly = 64;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
@@ -4713,7 +4710,7 @@ static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
 	struct softnet_data *sd;
 	unsigned int old_flow, new_flow;
 
-	if (qlen < (READ_ONCE(netdev_max_backlog) >> 1))
+	if (qlen < (READ_ONCE(net_hotdata.max_backlog) >> 1))
 		return false;
 
 	sd = this_cpu_ptr(&softnet_data);
@@ -4761,7 +4758,8 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen = skb_queue_len(&sd->input_pkt_queue);
-	if (qlen <= READ_ONCE(netdev_max_backlog) && !skb_flow_limit(skb, qlen)) {
+	if (qlen <= READ_ONCE(net_hotdata.max_backlog) &&
+	    !skb_flow_limit(skb, qlen)) {
 		if (qlen) {
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ed5ec5de47f670753924bd0c72db1e3ceb9b9e7a..ff8e5b64bf6b76451a69e3eae132b593c60ee204 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <net/gro_cells.h>
+#include <net/hotdata.h>
 
 struct gro_cell {
 	struct sk_buff_head	napi_skbs;
@@ -26,7 +27,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 
 	cell = this_cpu_ptr(gcells->cells);
 
-	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(netdev_max_backlog)) {
+	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
 drop:
 		dev_core_stats_rx_dropped_inc(dev);
 		kfree_skb(skb);
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 29fcfe89fd9a697120f826dbe2fd36a1617581a1..35ed5a83ecc7ebda513fe4fafc596e053f0252c5 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -15,4 +15,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.netdev_budget_usecs = 2 * USEC_PER_SEC / HZ,
 
 	.tstamp_prequeue = 1,
+	.max_backlog = 1000,
 };
+EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index bddd07da099886f2747f2ac4ba39a482b0f4231d..8eaeeb289914258f90cf940e906d5c6be0cc0cd6 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -440,7 +440,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "netdev_max_backlog",
-		.data		= &netdev_max_backlog,
+		.data		= &net_hotdata.max_backlog,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index d3b3f9e720b3b6c2a4ea89df4257a564100b2c4b..fe82e2d073006e5ab1b03868c851147c0422d26d 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -10,6 +10,7 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
+#include <net/hotdata.h>
 
 static void handle_nonesp(struct espintcp_ctx *ctx, struct sk_buff *skb,
 			  struct sock *sk)
@@ -169,7 +170,8 @@ int espintcp_queue_out(struct sock *sk, struct sk_buff *skb)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog))
+	if (skb_queue_len(&ctx->out_queue) >=
+	    READ_ONCE(net_hotdata.max_backlog))
 		return -ENOBUFS;
 
 	__skb_queue_tail(&ctx->out_queue, skb);
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index bd4ce21d76d7551d8f0a4a11f4b75705a7f634c5..161f535c8b9495b01f6d9689e14c40e5c0885968 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -21,6 +21,7 @@
 #include <net/ip_tunnels.h>
 #include <net/ip6_tunnel.h>
 #include <net/dst_metadata.h>
+#include <net/hotdata.h>
 
 #include "xfrm_inout.h"
 
@@ -764,7 +765,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
-	if (skb_queue_len(&trans->queue) >= READ_ONCE(netdev_max_backlog))
+	if (skb_queue_len(&trans->queue) >= READ_ONCE(net_hotdata.max_backlog))
 		return -ENOBUFS;
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
-- 
2.44.0.278.ge034bb2e1d-goog


