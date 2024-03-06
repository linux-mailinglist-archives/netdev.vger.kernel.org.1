Return-Path: <netdev+bounces-77995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25343873B74
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829251F22536
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C31361C2;
	Wed,  6 Mar 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVfS/ITE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94483137936
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740851; cv=none; b=rhPn5KxFoESv2Th53USBe0tKlBbhzny4JYlSyJJw3sFus8Xyoo/opcyBqtYU35qk3/BmodLKG5dau5le/Irsg3t0CgiTJIvnI3bBZXMJriiJeTyl7zvmG88RXM1co+A+o8ErL6j7x1Ni+X2Pkr0NMpVnApbO6LMGLJZcPR1orZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740851; c=relaxed/simple;
	bh=0a9W4HIDQVY0vwNk7wHx78HQ9ooqOP6SWSqIAUjxM5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N6oXf+/qy9pl1FFBsLEhtHQQflzfF2D9IKYodFbxaBQrMFVg33FlvQbymdXQiDj9E4+XEg15UrJDbJx6DrOnK2J2sVtGKN6MUSB2yRKfp8QTHd2NCkEJ1UpE0EBxtXX3Nrdu2uvuq4AVpzAHVmYvlt1YvPiPf87y30205bnBIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVfS/ITE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so9860872276.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740848; x=1710345648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3vewczgsKGiW/OBDkqgpG4XxHTBMfPPcUpL4NtIU7M=;
        b=WVfS/ITEJg35wmzuUKpYNE3Xvvr0admlmcI0k9FlypKRdIcTjGReeWXIbj7j3PcGt6
         +rTetx9ED/cqibURz4202w9hLhBC6QumtfJ6zEF8A/jKK5/vLmzrx/zcbi19VhsZh0Sl
         x8Zhx9BozO/4uhd3D6B1F9O5J5L7hihN317+jCQ+pPAJSoPrtmfXxgviFp672NQdrQ+F
         NoTHp3dyliePUrBRBxroc1+JENiHne8NBXM9LytsMgkBFGheVkP7OphIPYC0Aghpd8xG
         Yb0TP/wGiq1PYj+sq/7E+v/2s4Iw+rRoHLlvkll7fbcLOVSOE4G1q7yc5vb7DmSkTJEj
         9Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740848; x=1710345648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3vewczgsKGiW/OBDkqgpG4XxHTBMfPPcUpL4NtIU7M=;
        b=bDmwSauggEp68PHGyvbNIcSC3DMEn08iV06yGLFzo7nV+T+G+14+uxHA5gEELzZ+73
         pLe7uljjre/a3XLc2Iw0TfUi+NA91jxxD7J2g+G4581Jg8fU4yCVCMdd7LDME88HcHK8
         x66LQbW9Wjixuq68FE7tTU2eVNQNfSg7OSNTfvhBxZ8pAhlex726oTD9KEO6VzhGjogv
         LbRJ0k26wjAfbC/PH0LHVrzGpnrgty9fRje4fQk23uXM7gmFnjOdNpsq58jQ0KAE//HB
         uKVztEN56rT+qSbdjC1DbMkmb03xiWkGXUL6ZqUrNIngmwhLnIAuOmyS+GuOoznQObKp
         JaPw==
X-Forwarded-Encrypted: i=1; AJvYcCXUDNkaA6ZKsgWAlxO1MxCo+VgYc47t6clyMyN62vzmNfTExvnC9iQzra18FXMObX4s/+iaQWG9AoLdGQBkhXLUo5+c24IL
X-Gm-Message-State: AOJu0Yzy7Whsgb68PQj/Cff88qQp2osvaMAWnCDe8UEIESiqOjzRxHYA
	7YNVRPU/Qa225rrtR9YvCOZvMVTzCtbIYWjuPHhONdaRcq79Tx1bQGEGLy6T7mC3Vv8wYB9k+Sr
	12ZIEtKz0aA==
X-Google-Smtp-Source: AGHT+IFQk0FQnc9Ze52HzuVowAOpTr0e89rNio2F2DSOHCjrjGshJwDbTfc+irbrLH++K7cewJuqIdGnZ2shNg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP
 id w9-20020a056902100900b00dbe387da8efmr504777ybt.1.1709740847981; Wed, 06
 Mar 2024 08:00:47 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:18 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/18] net: move netdev_max_backlog to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_max_backlog is used in rx fat path.

Move it to net_hodata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


