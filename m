Return-Path: <netdev+bounces-52027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21997FCFE2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1139D1C20CE1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61C1094F;
	Wed, 29 Nov 2023 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nz7ZJqWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BA1FFF
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db512266d27so1673697276.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701242886; x=1701847686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1CcdGbg2AwT6WqExvKgvlMPxom1BxQJstK+vZGpojk=;
        b=Nz7ZJqWFR/SmMGYaVL2kPltInkodzOZWKzTCtSMqtK234vpJyBKYBYULOsTfhEAqi9
         2yHuqdiZ3/CkVIgRQf3tLltYzgiKWpCTdqI9P/yROYReBodnFl4yUth9hDIwMjncaPbZ
         vld2x8pyzVCbg2EyQWsi8k3TNZKoUpbjKLYfb6pZW/p2tELBt+DN5+k3LFUrLwUfb+JA
         F5h9lz0WCU649PGKhJBNftyNy24GSxlltus7wXNjGozChqJ49UdOlfdjRQEim0AVtHth
         qg3lcX4Bk3my6KOoGMciWyd/FjQyMRRYsM++FBGY6y5yYKYN9KocG+SXaKS+rGQn0YvR
         vkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242887; x=1701847687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1CcdGbg2AwT6WqExvKgvlMPxom1BxQJstK+vZGpojk=;
        b=hK7+mmObEQ71X3bERAvTc1SydtaNEVyWm5HYHBeXV0VWhpdqf0SSLjZtEXNx6Fd7lP
         jdhhqznucXJiv1lMEuni4P/W4BoLNZRlOgU/HwIcPz9a9Zk6wI7yQPmDn50C8JLfjzIY
         EYbpAP8F2RFQYbw3fBG9qtfQSOlY7e73sW8XavfDwqJaZSlvmLnuyJl+km8OZxJgGcyW
         cVRjIegiYF3yYkziNRBKIjgk/sMbiQx58dW95QQDDP4XBzooChH5LiZqJizhr8awWxzB
         92aq7FgjcOqQTak8FRQbWM9UX8kpyvUw+nGwnRvWWjSYWTk6d33oaFCucmdnvwZ5WbKD
         e9Ag==
X-Gm-Message-State: AOJu0Yz3lXkNCTTqq1QAHH2+6a6F+HfVL4rI84lDzvDLGN/gWW4mKzY4
	fzKtCbhY+CwAc7chl+H631fafiNNUxLnhIM=
X-Google-Smtp-Source: AGHT+IEHKsLbbkn3Xlh3bEWQPzEwPfQYAo/pEg6d8bRMLnNfsXg+7TuBBVH6rcBZ4cJGKpR/m7VKu9GjGzBfbao=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:3d05:0:b0:da0:3a24:fe25 with SMTP id
 k5-20020a253d05000000b00da03a24fe25mr519414yba.9.1701242886737; Tue, 28 Nov
 2023 23:28:06 -0800 (PST)
Date: Wed, 29 Nov 2023 07:27:55 +0000
In-Reply-To: <20231129072756.3684495-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129072756.3684495-5-lixiaoyan@google.com>
Subject: [PATCH v8 net-next 4/5] net-device: reorganize net_device fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Reorganize fast path variables on tx-txrx-rx order
Fastpath variables end after npinfo.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 4

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 include/linux/netdevice.h | 117 +++++++++++++++++++++-----------------
 net/core/dev.c            |  56 ++++++++++++++++++
 2 files changed, 120 insertions(+), 53 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87caa81f70ca..e3081e6ca516f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2091,6 +2091,70 @@ enum netdev_stat_type {
  */
 
 struct net_device {
+	/* Cacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/net_device.rst.
+	 * Please update the document when adding new fields.
+	 */
+
+	/* TX read-mostly hotpath */
+	__cacheline_group_begin(net_device_read_tx);
+	unsigned long long	priv_flags;
+	const struct net_device_ops *netdev_ops;
+	const struct header_ops *header_ops;
+	struct netdev_queue	*_tx;
+	unsigned int		real_num_tx_queues;
+	unsigned int		gso_max_size;
+	unsigned int		gso_ipv4_max_size;
+	u16			gso_max_segs;
+	s16			num_tc;
+	/* Note : dev->mtu is often read without holding a lock.
+	 * Writers usually hold RTNL.
+	 * It is recommended to use READ_ONCE() to annotate the reads,
+	 * and to use WRITE_ONCE() to annotate the writes.
+	 */
+	unsigned int		mtu;
+	unsigned short		needed_headroom;
+	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
+#ifdef CONFIG_XPS
+	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
+#endif
+#ifdef CONFIG_NETFILTER_EGRESS
+	struct nf_hook_entries __rcu *nf_hooks_egress;
+#endif
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_mprog_entry __rcu *tcx_egress;
+#endif
+	__cacheline_group_end(net_device_read_tx);
+
+	/* TXRX read-mostly hotpath */
+	__cacheline_group_begin(net_device_read_txrx);
+	unsigned int		flags;
+	unsigned short		hard_header_len;
+	netdev_features_t	features;
+	struct inet6_dev __rcu	*ip6_ptr;
+	__cacheline_group_end(net_device_read_txrx);
+
+	/* RX read-mostly hotpath */
+	__cacheline_group_begin(net_device_read_rx);
+	struct list_head	ptype_specific;
+	int			ifindex;
+	unsigned int		real_num_rx_queues;
+	struct netdev_rx_queue	*_rx;
+	unsigned long		gro_flush_timeout;
+	int			napi_defer_hard_irqs;
+	unsigned int		gro_max_size;
+	unsigned int		gro_ipv4_max_size;
+	rx_handler_func_t __rcu	*rx_handler;
+	void __rcu		*rx_handler_data;
+	possible_net_t			nd_net;
+#ifdef CONFIG_NETPOLL
+	struct netpoll_info __rcu	*npinfo;
+#endif
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_mprog_entry __rcu *tcx_ingress;
+#endif
+	__cacheline_group_end(net_device_read_rx);
+
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
@@ -2115,7 +2179,6 @@ struct net_device {
 	struct list_head	unreg_list;
 	struct list_head	close_list;
 	struct list_head	ptype_all;
-	struct list_head	ptype_specific;
 
 	struct {
 		struct list_head upper;
@@ -2123,25 +2186,12 @@ struct net_device {
 	} adj_list;
 
 	/* Read-mostly cache-line for fast-path access */
-	unsigned int		flags;
 	xdp_features_t		xdp_features;
-	unsigned long long	priv_flags;
-	const struct net_device_ops *netdev_ops;
 	const struct xdp_metadata_ops *xdp_metadata_ops;
-	int			ifindex;
 	unsigned short		gflags;
-	unsigned short		hard_header_len;
 
-	/* Note : dev->mtu is often read without holding a lock.
-	 * Writers usually hold RTNL.
-	 * It is recommended to use READ_ONCE() to annotate the reads,
-	 * and to use WRITE_ONCE() to annotate the writes.
-	 */
-	unsigned int		mtu;
-	unsigned short		needed_headroom;
 	unsigned short		needed_tailroom;
 
-	netdev_features_t	features;
 	netdev_features_t	hw_features;
 	netdev_features_t	wanted_features;
 	netdev_features_t	vlan_features;
@@ -2185,8 +2235,6 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	const struct header_ops *header_ops;
-
 	unsigned char		operstate;
 	unsigned char		link_mode;
 
@@ -2227,9 +2275,7 @@ struct net_device {
 
 
 	/* Protocol-specific pointers */
-
 	struct in_device __rcu	*ip_ptr;
-	struct inet6_dev __rcu	*ip6_ptr;
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
@@ -2264,26 +2310,14 @@ struct net_device {
 	/* Interface address info used in eth_type_trans() */
 	const unsigned char	*dev_addr;
 
-	struct netdev_rx_queue	*_rx;
 	unsigned int		num_rx_queues;
-	unsigned int		real_num_rx_queues;
-
 	struct bpf_prog __rcu	*xdp_prog;
-	unsigned long		gro_flush_timeout;
-	int			napi_defer_hard_irqs;
 #define GRO_LEGACY_MAX_SIZE	65536u
 /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
  * and shinfo->gso_segs is a 16bit field.
  */
 #define GRO_MAX_SIZE		(8 * 65535u)
-	unsigned int		gro_max_size;
-	unsigned int		gro_ipv4_max_size;
 	unsigned int		xdp_zc_max_segs;
-	rx_handler_func_t __rcu	*rx_handler;
-	void __rcu		*rx_handler_data;
-#ifdef CONFIG_NET_XGRESS
-	struct bpf_mprog_entry __rcu *tcx_ingress;
-#endif
 	struct netdev_queue __rcu *ingress_queue;
 #ifdef CONFIG_NETFILTER_INGRESS
 	struct nf_hook_entries __rcu *nf_hooks_ingress;
@@ -2298,25 +2332,13 @@ struct net_device {
 /*
  * Cache lines mostly used on transmit path
  */
-	struct netdev_queue	*_tx ____cacheline_aligned_in_smp;
 	unsigned int		num_tx_queues;
-	unsigned int		real_num_tx_queues;
 	struct Qdisc __rcu	*qdisc;
 	unsigned int		tx_queue_len;
 	spinlock_t		tx_global_lock;
 
 	struct xdp_dev_bulk_queue __percpu *xdp_bulkq;
 
-#ifdef CONFIG_XPS
-	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
-#endif
-#ifdef CONFIG_NET_XGRESS
-	struct bpf_mprog_entry __rcu *tcx_egress;
-#endif
-#ifdef CONFIG_NETFILTER_EGRESS
-	struct nf_hook_entries __rcu *nf_hooks_egress;
-#endif
-
 #ifdef CONFIG_NET_SCHED
 	DECLARE_HASHTABLE	(qdisc_hash, 4);
 #endif
@@ -2355,12 +2377,6 @@ struct net_device {
 	bool needs_free_netdev;
 	void (*priv_destructor)(struct net_device *dev);
 
-#ifdef CONFIG_NETPOLL
-	struct netpoll_info __rcu	*npinfo;
-#endif
-
-	possible_net_t			nd_net;
-
 	/* mid-layer private */
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
@@ -2395,20 +2411,15 @@ struct net_device {
  */
 #define GSO_MAX_SIZE		(8 * GSO_MAX_SEGS)
 
-	unsigned int		gso_max_size;
 #define TSO_LEGACY_MAX_SIZE	65536
 #define TSO_MAX_SIZE		UINT_MAX
 	unsigned int		tso_max_size;
-	u16			gso_max_segs;
 #define TSO_MAX_SEGS		U16_MAX
 	u16			tso_max_segs;
-	unsigned int		gso_ipv4_max_size;
 
 #ifdef CONFIG_DCB
 	const struct dcbnl_rtnl_ops *dcbnl_ops;
 #endif
-	s16			num_tc;
-	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
 	u8			prio_tc_map[TC_BITMASK + 1];
 
 #if IS_ENABLED(CONFIG_FCOE)
diff --git a/net/core/dev.c b/net/core/dev.c
index 3950ced396b50..4779689f7c437 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11572,6 +11572,60 @@ static struct pernet_operations __net_initdata default_device_ops = {
 	.exit_batch = default_device_exit_batch,
 };
 
+static void __init net_dev_struct_check(void)
+{
+	/* TX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, priv_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, netdev_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, header_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, _tx);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, real_num_tx_queues);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_ipv4_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, num_tc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, mtu);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, needed_headroom);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tc_to_txq);
+#ifdef CONFIG_XPS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, xps_maps);
+#endif
+#ifdef CONFIG_NETFILTER_EGRESS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, nf_hooks_egress);
+#endif
+#ifdef CONFIG_NET_XGRESS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tcx_egress);
+#endif
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_tx, 152);
+
+	/* TXRX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 30);
+
+	/* RX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler_data);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, nd_net);
+#ifdef CONFIG_NETPOLL
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, npinfo);
+#endif
+#ifdef CONFIG_NET_XGRESS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
+#endif
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 96);
+}
+
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
  *	unhooks any devices that fail to initialise (normally hardware not
@@ -11589,6 +11643,8 @@ static int __init net_dev_init(void)
 
 	BUG_ON(!dev_boot_phase);
 
+	net_dev_struct_check();
+
 	if (dev_proc_init())
 		goto out;
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


