Return-Path: <netdev+bounces-77578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F6287238F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86FE285DF0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66482128392;
	Tue,  5 Mar 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5LnMqcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA05128372
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654660; cv=none; b=GxUJbgrq+xQy+hf+JnzU0avbHQ3P1/rrHmk9zT042A50h0AOgQJaKpxtVcTwjn++cnczl0f4Bc+GwklBhTVLUVn5jpTYrrvg8Efbpo5g/FQiCJiE5sLzpTPC83Wr519thQwdG2co+m6w8DX5zNPtOdzdSxwO3REpDEIgeuLulF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654660; c=relaxed/simple;
	bh=lkRFVLV27FDOA478lzcOz2mJAgCuUYQ+GWyEJJp1w5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C4CrEG5b6wVRYqfUJxTUzOSicfPSyuy4I/4QRlTQUmW6yQUHFSlLw1Osj04fG890Pgi935kbg2G67QKf/lPwdkhEtIKq8s/FWnbiHvgMKVkS10hA6xNMS9Q8+njZPnVgf8rNe1uqhfr1P+FfZ/J8HyB61ru//97lOaTiFrJel20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5LnMqcp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so7590445276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654657; x=1710259457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbLX2AYPg1cLWgj5PFHrnbQLL+wLioeOEdysz4St+Ks=;
        b=F5LnMqcpktpfzY+BIYJNstApYineFGZm0DontP2AIGC4QHDDOWnJhh0bvJGdEc02RN
         XhzNfZlGSf+WQXawB4rjb0v6JsRMynMzP7gdEK4ogQBP/Kkwdmf2Vv6NXB4/RktHK9z7
         tWS8z9VWsrkSL7IV7yYTGbxmBkfI04t+5PObIRqdI+G51H1AP0nAzG8dDo42IlxCQzNr
         OskHns8r9UVdwYLKN6B0dpwLmuOjG2YQtGDUQfvsyA8xz++v7Tl3K/K1NbAGviQvWkF3
         cvKyeK7rNg3EOs3bNAS1m2/HEEo7Pr9UHD1WTkJuQrzROBd+/tcX88JZLMATl8BMNLNW
         UY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654657; x=1710259457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbLX2AYPg1cLWgj5PFHrnbQLL+wLioeOEdysz4St+Ks=;
        b=cqNcpTAiRYwOtEX/1VBhOrL4HxQ8nw2+JcDpFxdDKiodYUDZdkvuSwJbwgwewbTOXC
         8iPstVj+oiiVgwV2sw2jxybW+tzO+JGRjsxgZTHHyJI8NBApx/ByZTgPRni0kACuVNVa
         8zg5qwv/02EUYoEVvwdQr+/J9kUzFQ0mGusgtRl2BeQNDDr3YFb7BRK/MpIrt8LpPM55
         k2t0oWi4uhVgo8xo+zS7mUqG1xPfB+93u3tyYEz4LKR/pZ4LRzbh4AM6kJJ/N4RExfMc
         dfxxHBQ2ckxXX5y++RlbLcphRRlqRDp0iyyydqyPnUzoQgtG1MbawqXx5TKC9HHWkQa1
         DdEQ==
X-Gm-Message-State: AOJu0Yw4CGmoDuNBLGFDQ8ZkzWmGBCWy0sYWsL8LmY6agOxeNf8FZr6d
	th8w2nsf5KAymq2iYUWvEN6zKF50HhL88ZOwTLzBfwkUrPBy+Ho0QYmsOTVUDdUAelzY/+IrI2w
	FHGs7DYYKyw==
X-Google-Smtp-Source: AGHT+IHjczfvIsRGPOszux8vj7Q9MLZaHiDt0o9/P9+pxVhYhKf0WlSd+S+AA3ZF2HnSYVwOpfi4hQlcVABSbQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1143:b0:dc7:6cfa:dc59 with SMTP
 id p3-20020a056902114300b00dc76cfadc59mr475366ybu.4.1709654657706; Tue, 05
 Mar 2024 08:04:17 -0800 (PST)
Date: Tue,  5 Mar 2024 16:03:56 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-2-edumazet@google.com>
Subject: [PATCH net-next 01/18] net: introduce struct net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of spreading networking critical fields
all over the places, add a custom net_hotdata
structure so that we can precisely control its layout.

In this first patch, move :

- gro_normal_batch used in rx (GRO stack)
- offload_base used in rx and tx (GRO and TSO stacks)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h  |  1 -
 include/net/gro.h          |  5 ++---
 include/net/hotdata.h      | 15 +++++++++++++++
 net/core/Makefile          |  1 +
 net/core/gro.c             | 15 ++++++---------
 net/core/gso.c             |  4 ++--
 net/core/hotdata.c         |  9 +++++++++
 net/core/sysctl_net_core.c |  3 ++-
 8 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 include/net/hotdata.h
 create mode 100644 net/core/hotdata.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c41019f3417948d09ae9a50b57b856be1dc8ae42..15ce809e0541078bff7a48b8d7cb2cf2c1ac8a93 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4790,7 +4790,6 @@ void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 extern int		netdev_max_backlog;
 extern int		dev_rx_weight;
 extern int		dev_tx_weight;
-extern int		gro_normal_batch;
 
 enum {
 	NESTED_SYNC_IMM_BIT,
diff --git a/include/net/gro.h b/include/net/gro.h
index 2b58671a65492bf3f9dabf1e7a2d985cee007e11..d6fc8fbd37302338fc09ab01fead899002c5833f 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -9,6 +9,7 @@
 #include <net/ip6_checksum.h>
 #include <linux/skbuff.h>
 #include <net/udp.h>
+#include <net/hotdata.h>
 
 struct napi_gro_cb {
 	union {
@@ -446,7 +447,7 @@ static inline void gro_normal_one(struct napi_struct *napi, struct sk_buff *skb,
 {
 	list_add_tail(&skb->list, &napi->rx_list);
 	napi->rx_count += segs;
-	if (napi->rx_count >= READ_ONCE(gro_normal_batch))
+	if (napi->rx_count >= READ_ONCE(net_hotdata.gro_normal_batch))
 		gro_normal_list(napi);
 }
 
@@ -493,6 +494,4 @@ static inline void inet6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *
 #endif
 }
 
-extern struct list_head offload_base;
-
 #endif /* _NET_IPV6_GRO_H */
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
new file mode 100644
index 0000000000000000000000000000000000000000..6ed32e4e34aa3bdc6e860f5a8a6cab69c36c7fad
--- /dev/null
+++ b/include/net/hotdata.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NET_HOTDATA_H
+#define _NET_HOTDATA_H
+
+#include <linux/types.h>
+
+/* Read mostly data used in network fast paths. */
+struct net_hotdata {
+	struct list_head	offload_base;
+	int			gro_normal_batch;
+};
+
+extern struct net_hotdata net_hotdata;
+
+#endif /* _NET_HOTDATA_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 821aec06abf1460d3504de4b6b66a328bba748d8..6e6548011fae570e345717e43eb3c1a6133571c7 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,6 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
+obj-y += hotdata.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/gro.c b/net/core/gro.c
index 6a0edbd826a17573b51c5f71e20ff0c09364fc21..ee30d4f0c03876e78795397d1c495881a2c9e80f 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -10,9 +10,6 @@
 #define GRO_MAX_HEAD (MAX_HEADER + 128)
 
 static DEFINE_SPINLOCK(offload_lock);
-struct list_head offload_base __read_mostly = LIST_HEAD_INIT(offload_base);
-/* Maximum number of GRO_NORMAL skbs to batch up for list-RX */
-int gro_normal_batch __read_mostly = 8;
 
 /**
  *	dev_add_offload - register offload handlers
@@ -31,7 +28,7 @@ void dev_add_offload(struct packet_offload *po)
 	struct packet_offload *elem;
 
 	spin_lock(&offload_lock);
-	list_for_each_entry(elem, &offload_base, list) {
+	list_for_each_entry(elem, &net_hotdata.offload_base, list) {
 		if (po->priority < elem->priority)
 			break;
 	}
@@ -55,7 +52,7 @@ EXPORT_SYMBOL(dev_add_offload);
  */
 static void __dev_remove_offload(struct packet_offload *po)
 {
-	struct list_head *head = &offload_base;
+	struct list_head *head = &net_hotdata.offload_base;
 	struct packet_offload *po1;
 
 	spin_lock(&offload_lock);
@@ -235,9 +232,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 {
+	struct list_head *head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
 	__be16 type = skb->protocol;
-	struct list_head *head = &offload_base;
 	int err = -ENOENT;
 
 	BUILD_BUG_ON(sizeof(struct napi_gro_cb) > sizeof(skb->cb));
@@ -444,7 +441,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 {
 	u32 bucket = skb_get_hash_raw(skb) & (GRO_HASH_BUCKETS - 1);
 	struct gro_list *gro_list = &napi->gro_hash[bucket];
-	struct list_head *head = &offload_base;
+	struct list_head *head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
 	__be16 type = skb->protocol;
 	struct sk_buff *pp = NULL;
@@ -550,7 +547,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 
 struct packet_offload *gro_find_receive_by_type(__be16 type)
 {
-	struct list_head *offload_head = &offload_base;
+	struct list_head *offload_head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
 
 	list_for_each_entry_rcu(ptype, offload_head, list) {
@@ -564,7 +561,7 @@ EXPORT_SYMBOL(gro_find_receive_by_type);
 
 struct packet_offload *gro_find_complete_by_type(__be16 type)
 {
-	struct list_head *offload_head = &offload_base;
+	struct list_head *offload_head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
 
 	list_for_each_entry_rcu(ptype, offload_head, list) {
diff --git a/net/core/gso.c b/net/core/gso.c
index 9e1803bfc9c6cac2fe7054661f8995909a6c28d9..bcd156372f4df080f83cc45fc96df1789125a8ae 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -17,7 +17,7 @@ struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
 	struct packet_offload *ptype;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ptype, &offload_base, list) {
+	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
 			segs = ptype->callbacks.gso_segment(skb, features);
 			break;
@@ -48,7 +48,7 @@ struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
 	__skb_pull(skb, vlan_depth);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ptype, &offload_base, list) {
+	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
 			segs = ptype->callbacks.gso_segment(skb, features);
 			break;
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
new file mode 100644
index 0000000000000000000000000000000000000000..abb8ad19d59acc0d7d6e1b06f4506afa42bde44b
--- /dev/null
+++ b/net/core/hotdata.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <net/hotdata.h>
+#include <linux/cache.h>
+#include <linux/list.h>
+
+struct net_hotdata net_hotdata __cacheline_aligned = {
+	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
+	.gro_normal_batch = 8,
+};
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 986f15e5d6c41250c8b9099fc1d2883112e77ffb..0eb1242eabbe0d3ea58886b1db409c9d991ac672 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -23,6 +23,7 @@
 #include <net/net_ratelimit.h>
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
+#include <net/hotdata.h>
 
 #include "dev.h"
 
@@ -632,7 +633,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "gro_normal_batch",
-		.data		= &gro_normal_batch,
+		.data		= &net_hotdata.gro_normal_batch,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-- 
2.44.0.278.ge034bb2e1d-goog


