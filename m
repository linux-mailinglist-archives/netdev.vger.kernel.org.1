Return-Path: <netdev+bounces-271294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCupOXP4wmklngQAu9opvQ
	(envelope-from <netdev+bounces-271294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:47:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96E31C7F5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B8430F5EE7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639673537F9;
	Tue, 24 Mar 2026 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAKtSEfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B0356A09
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384890; cv=none; b=uEAXpEJ8TMONa4wO0OA9LNRiyciqyfSZZy0BMyvHVzz+QVB6Ikpe36r632RCQACG0sBAlVAY36YTxNBit16RYOBh4vjXgFz5fahJ88SyzERKcl5GFfjsTIX3hjsnP84IOoBA3plSwF0sfS1ofZGtrbUNz1ElJIrhClMkyJW2ESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384890; c=relaxed/simple;
	bh=OMzMv0TSgnhZtLvwhP+BHffFyvt+TSPyAeE/6RqIn8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgcUyGkWvaJGhlzZWnHcbRy7tMBI8hs/LFqo5fnJ4TFWesnUFV54z/1jKhxGAfnzTFrCo31mgSHRR88MNN16FPEJj/emO/3msh9zlP2LFuMKCL/40//DNydtNtvloOupNFNd6kla/CjsHRIMg9vdNDg6KkmVJWuKpuDTzqTgaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAKtSEfZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fb14227cso18329845e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384887; x=1774989687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0C5qZvIKcbCB9gIop4y1SIVtOCb4Lm6XlWELeubUrQ=;
        b=iAKtSEfZS2/Or6UT5n+zWYVaGk0wFOcjtJF3ZUI3b0H13o8I5B9nQsADOUJ2dxc30U
         mUeRNaV4Acp0+Ng/8Q6vjIiBk81zBdsg3ag9LhtHsK/mQzYrxEO+C2lKTgzVcSf0Vsos
         s9lSr+qtoKWRT/M2yzQQ0Ra4eVSoz2MpfLGatyDKotQ06ZSRAimZrDk0xQK2Z2jWVWZv
         RQKQE5L+LVJNpTT9dqY5FgQ1HRrtb+6LgN5PmdERvArgYlJhNvxswkDYB0iADDq4pssf
         csStCGtImcViBTAauFGJKYR+By+VWli50k2+/J1T2FJGtcIgu9VDAuAxNYJsGR08KAbP
         f2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384887; x=1774989687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D0C5qZvIKcbCB9gIop4y1SIVtOCb4Lm6XlWELeubUrQ=;
        b=dLEVppa13HdwOkXaNaoS9mk9qP2M6wqpeUJtNUpielM/fIknTS1f8hZUv9hqo3DGIt
         D4gJRJDNFYhwRc1u6zTsZzVBv2dWHTNL4WkWmyTOYPkse48wge+Nq7wMPpppBhAAwIiv
         /YL3fUqTw/NOofz4GNi1ekRNMSUdYpLfLskd191sNJ/E23k/Zre88egJbCNCkc4XkulI
         2dCcPaYq3eX8xeEd1rB699cbM/pivLnRLAtvSVXTaU9h/xXmq9savLo4SsDD/9vJPhqW
         3KURwy6SrtHk4X8BtGosj2XEMddaH3IgehlLqQ69fO9lzuMcErxZxd4Ts48YVhQOTZ7u
         S3wA==
X-Forwarded-Encrypted: i=1; AJvYcCWKvRgg1Silg+rcOeHSFos7gZOhFPDzYd3Vn5c1NYJQAkAq6Jj6Xaku6y2RV6FxPTpAJY/gR6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwturgOZHbXGTjulXi9S58PbWGwl5u5UAk4NwYjLzzPA1cXzTHY
	e9+dBa8AOA2wVI1TTrKl7suieSTynIHy68+TIs+yTWhTzIVvfidSZRFJ
X-Gm-Gg: ATEYQzzcomMwcslds5zYh8gCcuK0oUrlZbii9sndpa51bH8gN1O5qwWdBfVvBRaHt9A
	CpzoPUX5Hii7Gs22SoU6Ych/Wn9IU9449IHbza6Tek9HlRoD+rgXBmZNovMbQnQW87L9MFhO1xe
	16IydiKj+I2LMCa10ZAWw5g9kt/cqFitVcNn4K0GSK+9FipGydle/0PmDGQwtS8razDxvlTIw8Q
	Z/1w26KwjkCh6x2AotLY4Ek4t1iPv3HTQKPyuQT97WuaquGBga3wyn8Bw2Nno9DyXqunGgHkKoo
	N1ZyQRe6XFKJ2x/CmXXSfXXNUkeNQrQwkoQvg4EfIwL3uG0gR9rpfRj43qKudFeH7QndBF4fhqd
	KJtm0g1Bj4bzGUrCN0gsqDo726Skso5DALIiZMHZ2/aMsJKZwjophG3/scEhHyygIUt+Xk0eQ9O
	HXdUp1DIezB7muA5j1B+8Y
X-Received: by 2002:a05:600c:4685:b0:486:5f71:5829 with SMTP id 5b1f17b1804b1-48715fc3870mr17265075e9.5.1774384886440;
        Tue, 24 Mar 2026 13:41:26 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716658352sm3686825e9.13.2026.03.24.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:41:25 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	pablo@netfilter.org,
	fw@strlen.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next v2 1/2] netfilter: flowtable: update netdev stats with HW_OFFLOAD flows
Date: Tue, 24 Mar 2026 14:40:15 -0600
Message-ID: <20260324204016.2089193-2-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324204016.2089193-1-anzaki@gmail.com>
References: <20260324204016.2089193-1-anzaki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271294-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,gmail.com,netfilter.org,strlen.de,kernel.org,redhat.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C96E31C7F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some drivers (notably DSA) delegate the nft flowtable HW_OFFLOAD flows
to a parent driver. While the parent driver is able to report the
offloaded traffic stats directly from the HW, the delegating driver
does not report the stats. This fails SNMP-based monitoring tools that
rely on netdev stats to report the network traffic.

Add a new struct pcpu_sw_netstats "fstats" to net_device that gets
allocated only if the new flag "flow_offload_via_parent" is set by the
driver. The new stats are lazily allocated by the nft flow offloading
code when the first flow is offloaded. The stats are updated periodically
in flow_offload_work_stats() and also once in flow_offload_work_del()
before the flow is deleted. For this, flow_offload_work_del() had to
be moved below flow_offload_tuple_stats().

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
---
 include/linux/netdevice.h             | 45 ++++++++++++
 net/core/dev.c                        |  8 +++
 net/netfilter/nf_flow_table_offload.c | 98 +++++++++++++++++++++++++--
 3 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 67e25f6d15a4..647758f78213 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1840,6 +1840,11 @@ enum netdev_reg_state {
  *	@stats:		Statistics struct, which was left as a legacy, use
  *			rtnl_link_stats64 instead
  *
+ *	@fstats:	HW offloaded flow statistics: RX/TX packets,
+ *			RX/TX bytes. Lazily allocated by the flow offload
+ *			path on the first offloaded flow for devices that
+ *			set @flow_offload_via_parent. Freed by free_netdev().
+ *
  *	@core_stats:	core networking counters,
  *			do not use this in drivers
  *	@carrier_up_count:	Number of times the carrier has been up
@@ -2048,6 +2053,12 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@flow_offload_via_parent: device delegates nft flowtable hardware
+ *				  offload to a parent/conduit device (e.g. DSA
+ *				  user ports delegate to their conduit MAC).
+ *				  The parent's HW count the offloaded traffic
+ *				  but this device's sw netstats path does not.
+ *				  @fstats is allocated to fill that gap.
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2233,6 +2244,7 @@ struct net_device {
 
 	struct net_device_stats	stats; /* not used by modern drivers */
 
+	struct pcpu_sw_netstats __percpu *fstats;
 	struct net_device_core_stats __percpu *core_stats;
 
 	/* Stats to monitor link on/off, flapping */
@@ -2463,6 +2475,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		flow_offload_via_parent:1;
 
 	struct list_head	net_notifier_list;
 
@@ -2992,6 +3005,38 @@ struct pcpu_lstats {
 
 void dev_lstats_read(struct net_device *dev, u64 *packets, u64 *bytes);
 
+static inline void dev_fstats_rx_add(struct net_device *dev,
+				     unsigned int packets,
+				     unsigned int len)
+{
+	struct pcpu_sw_netstats *fstats;
+
+	if (!dev->fstats)
+		return;
+
+	fstats = this_cpu_ptr(dev->fstats);
+	u64_stats_update_begin(&fstats->syncp);
+	u64_stats_add(&fstats->rx_bytes, len);
+	u64_stats_add(&fstats->rx_packets, packets);
+	u64_stats_update_end(&fstats->syncp);
+}
+
+static inline void dev_fstats_tx_add(struct net_device *dev,
+				     unsigned int packets,
+				     unsigned int len)
+{
+	struct pcpu_sw_netstats *fstats;
+
+	if (!dev->fstats)
+		return;
+
+	fstats = this_cpu_ptr(dev->fstats);
+	u64_stats_update_begin(&fstats->syncp);
+	u64_stats_add(&fstats->tx_bytes, len);
+	u64_stats_add(&fstats->tx_packets, packets);
+	u64_stats_update_end(&fstats->syncp);
+}
+
 static inline void dev_sw_netstats_rx_add(struct net_device *dev, unsigned int len)
 {
 	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
diff --git a/net/core/dev.c b/net/core/dev.c
index f48dc299e4b2..07fb315ad42c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11865,6 +11865,7 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	const struct net_device_core_stats __percpu *p;
+	const struct pcpu_sw_netstats __percpu *fstats;
 
 	/*
 	 * IPv{4,6} and udp tunnels share common stat helpers and use
@@ -11893,6 +11894,11 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}
 
+	/* This READ_ONCE() pairs with cmpxchg in flow_offload_fstats_ensure() */
+	fstats = READ_ONCE(dev->fstats);
+	if (fstats)
+		dev_fetch_sw_netstats(storage, fstats);
+
 	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
 	p = READ_ONCE(dev->core_stats);
 	if (p) {
@@ -12212,6 +12218,8 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->pcpu_refcnt);
 	dev->pcpu_refcnt = NULL;
 #endif
+	free_percpu(dev->fstats);
+	dev->fstats = NULL;
 	free_percpu(dev->core_stats);
 	dev->core_stats = NULL;
 	free_percpu(dev->xdp_bulkq);
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index b2e4fb6fa011..fc1e67a79904 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -925,13 +925,80 @@ static void flow_offload_work_add(struct flow_offload_work *offload)
 	nf_flow_offload_destroy(flow_rule);
 }
 
-static void flow_offload_work_del(struct flow_offload_work *offload)
+static bool flow_offload_fstats_ensure(struct net_device *dev)
 {
-	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
-	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
-	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
-		flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
-	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
+	struct pcpu_sw_netstats __percpu *p;
+
+	if (!dev->flow_offload_via_parent)
+		return false;
+
+	/* Pairs with cmpxchg() below. */
+	if (likely(READ_ONCE(dev->fstats)))
+		return true;
+
+	p = __netdev_alloc_pcpu_stats(struct pcpu_sw_netstats, GFP_ATOMIC);
+	if (!p)
+		return false;
+
+	if (cmpxchg(&dev->fstats, NULL, p))
+		free_percpu(p);	/* lost the race, discard and use winner's */
+
+	return true;
+}
+
+static u32 flow_offload_egress_ifidx(const struct flow_offload_tuple *tuple)
+{
+	switch (tuple->xmit_type) {
+	case FLOW_OFFLOAD_XMIT_NEIGH:
+		return tuple->ifidx;
+	case FLOW_OFFLOAD_XMIT_DIRECT:
+		return tuple->out.ifidx;
+	default:
+		return 0;
+	}
+}
+
+static void flow_offload_netdev_update(struct flow_offload_work *offload,
+				       struct flow_stats *stats)
+{
+	const struct flow_offload_tuple *tuple;
+	struct net_device *indev, *outdev;
+	struct net *net;
+
+	rcu_read_lock();
+	net = read_pnet(&offload->flowtable->net);
+	if (stats[FLOW_OFFLOAD_DIR_ORIGINAL].pkts) {
+		tuple = &offload->flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple;
+		indev = dev_get_by_index_rcu(net, tuple->iifidx);
+		if (indev && flow_offload_fstats_ensure(indev))
+			dev_fstats_rx_add(indev,
+					  stats[FLOW_OFFLOAD_DIR_ORIGINAL].pkts,
+					  stats[FLOW_OFFLOAD_DIR_ORIGINAL].bytes);
+
+		outdev = dev_get_by_index_rcu(net,
+					      flow_offload_egress_ifidx(tuple));
+		if (outdev && flow_offload_fstats_ensure(outdev))
+			dev_fstats_tx_add(outdev,
+					  stats[FLOW_OFFLOAD_DIR_ORIGINAL].pkts,
+					  stats[FLOW_OFFLOAD_DIR_ORIGINAL].bytes);
+	}
+
+	if (stats[FLOW_OFFLOAD_DIR_REPLY].pkts) {
+		tuple = &offload->flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple;
+		indev = dev_get_by_index_rcu(net, tuple->iifidx);
+		if (indev && flow_offload_fstats_ensure(indev))
+			dev_fstats_rx_add(indev,
+					  stats[FLOW_OFFLOAD_DIR_REPLY].pkts,
+					  stats[FLOW_OFFLOAD_DIR_REPLY].bytes);
+
+		outdev = dev_get_by_index_rcu(net,
+					      flow_offload_egress_ifidx(tuple));
+		if (outdev && flow_offload_fstats_ensure(outdev))
+			dev_fstats_tx_add(outdev,
+					  stats[FLOW_OFFLOAD_DIR_REPLY].pkts,
+					  stats[FLOW_OFFLOAD_DIR_REPLY].bytes);
+	}
+	rcu_read_unlock();
 }
 
 static void flow_offload_tuple_stats(struct flow_offload_work *offload,
@@ -968,6 +1035,25 @@ static void flow_offload_work_stats(struct flow_offload_work *offload)
 				       FLOW_OFFLOAD_DIR_REPLY,
 				       stats[1].pkts, stats[1].bytes);
 	}
+
+	flow_offload_netdev_update(offload, stats);
+}
+
+static void flow_offload_work_del(struct flow_offload_work *offload)
+{
+	struct flow_stats stats[FLOW_OFFLOAD_DIR_MAX] = {};
+
+	flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_ORIGINAL, &stats[0]);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_REPLY,
+					 &stats[1]);
+	flow_offload_netdev_update(offload, stats);
+
+	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
+	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
+	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
 }
 
 static void flow_offload_work_handler(struct work_struct *work)
-- 
2.43.0


