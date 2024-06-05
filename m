Return-Path: <netdev+bounces-100838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359E8FC3C9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8811C24B71
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BD190478;
	Wed,  5 Jun 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TEUw+f68"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C519046E
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569474; cv=none; b=OUpMnULZEEAlShqCZrGXoi398UgxR30WZ3OdySTJKBDMkK9Ew12YK/3peV2EkoURmG2C8kySPGya1jEBstAObnMtF+iNc6/lcCAWyriKRN6/bQN0M7z7T/O6VcwVnXHv4HqX2MW2yiKkAJ29HnOxEhlTjD5lL5SDruMqfKHV9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569474; c=relaxed/simple;
	bh=b88N4t9KHLgm3JAd9f/qWlXxq77HyonoQ8pv4hIBQmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8oSKPDW8bWJX18DzJ8wExzzLIyQyiCcsZ2GKsO9ounHa/1aVAw1K0MskJhQH7l9j3g+Wnzsj0IjKxpqf/+IxmULU2UCVv/iniIG4NMnI9pvYaGoFhvkDA6aVyZSZOSwhQK2O1pLkZwHVKD4ggMVS/r9pULht1AVTtKNjhccQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TEUw+f68; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 947AA201EF; Wed,  5 Jun 2024 14:37:44 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717569464;
	bh=92C+jzxAQRXGFtrP6+hVtbsm3ZUZJt1lIsFAh0c8P9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TEUw+f68YQRx4eq/Od6FfYMFJi2SDSFMnm3Yu4cN/ta1nmc9XDn7Pugy843itI8oy
	 jw8x4H8MYuMNEx/EyB+37yCsKT7mN3JHzvTYeN9MGYr44JFE45PE/fvqLYQFPoHAU4
	 qukc0n76ZKdnTN0HKVko+3l+/PlDs1SxjJk+3gvt7Th211dEx/tomv83sS5zzHE0ty
	 T26e7dDvMbCAQeXrKh2H+ZQCovdpf11DUxphKe6E5Ad9nAW2D0WiPGqDs8wTleydZ3
	 mE8ePIzMOMagUMq/C2/mjv0A6BfgJmXs9KTQp40xYgQA/DeLDwA1bwjviEYrSZrB9U
	 UrgITaD4Y0bgw==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 14:37:29 +0800
Subject: [PATCH 2/3] net: core: Implement dstats-type stats collections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>
References: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
In-Reply-To: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.13.0

We currently have dev_get_tstats64() for collecting per-cpu stats of
type pcpu_sw_netstats ("tstats"). However, tstats doesn't allow for
accounting tx/rx drops. We do have a stats variant that does have stats
for dropped packets: struct pcpu_dstats, but there are no core helpers
for using those stats.

The VRF driver uses dstats, by providing its own collation/fetch
functions to do so.

This change adds a common helpers for dstats-type collection, based on
the VRF driver's own (plus the unused tx_drops stat from there). We
will switch the VRF driver to use this in the next change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f148a01dd1d1..fdc3d8a6c0f4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4690,6 +4690,9 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 			   const struct pcpu_sw_netstats __percpu *netstats);
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
+void dev_fetch_dstats(struct rtnl_link_stats64 *s,
+		      const struct pcpu_dstats __percpu *dstats);
+void dev_get_dstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 
 enum {
 	NESTED_SYNC_IMM_BIT,
diff --git a/net/core/dev.c b/net/core/dev.c
index e1bb6d7856d9..dc77529600ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10849,6 +10849,62 @@ void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s)
 }
 EXPORT_SYMBOL_GPL(dev_get_tstats64);
 
+/**
+ *	dev_fetch_dstats - collate per-cpu network dstats statistics
+ *	@s: place to store stats
+ *	@dstats: per-cpu network stats to read from
+ *
+ *	Read per-cpu network statistics from dev->dstats and populate the
+ *	related fields in @s.
+ */
+void dev_fetch_dstats(struct rtnl_link_stats64 *s,
+		      const struct pcpu_dstats __percpu *dstats)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 rx_packets, rx_bytes, rx_drops;
+		u64 tx_packets, tx_bytes, tx_drops;
+		const struct pcpu_dstats *dstats;
+		unsigned int start;
+
+		dstats = per_cpu_ptr(dstats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&dstats->syncp);
+			rx_packets = u64_stats_read(&dstats->rx_packets);
+			rx_bytes   = u64_stats_read(&dstats->rx_bytes);
+			rx_drops   = u64_stats_read(&dstats->rx_drops);
+			tx_packets = u64_stats_read(&dstats->tx_packets);
+			tx_bytes   = u64_stats_read(&dstats->tx_bytes);
+			tx_drops   = u64_stats_read(&dstats->tx_drops);
+		} while (u64_stats_fetch_retry(&dstats->syncp, start));
+
+		s->rx_packets += rx_packets;
+		s->rx_bytes   += rx_bytes;
+		s->rx_dropped += rx_drops;
+		s->tx_packets += tx_packets;
+		s->tx_bytes   += tx_bytes;
+		s->tx_dropped += tx_drops;
+	}
+}
+EXPORT_SYMBOL_GPL(dev_fetch_dstats);
+
+/**
+ *	dev_get_dstats64 - ndo_get_stats64 implementation for dtstats-based
+ *	account.
+ *	@dev: device to get statistics from
+ *	@s: place to store stats
+ *
+ *	Populate @s from dev->stats and dev->dstats. Can be used as
+ *	ndo_get_stats64() callback.
+ */
+void dev_get_dstats64(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	netdev_stats_to_stats64(s, &dev->stats);
+	dev_fetch_dstats(s, dev->dstats);
+}
+EXPORT_SYMBOL_GPL(dev_get_dstats64);
+
 struct netdev_queue *dev_ingress_queue_create(struct net_device *dev)
 {
 	struct netdev_queue *queue = dev_ingress_queue(dev);

-- 
2.39.2


