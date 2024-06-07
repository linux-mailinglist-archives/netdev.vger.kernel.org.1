Return-Path: <netdev+bounces-101780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3F9000BE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20551F254A3
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCF15CD6C;
	Fri,  7 Jun 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="l2JZcSiL"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14115B967
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755941; cv=none; b=Al38hqsJHu82BaDBG9bSSqPBPnKQDO+eYAmp1FId63OJ07nwE3J0RlpYlpEbtUnSSBriNahb31iJzLtNmqSeP2XC1HpoK6xFpjKNGtQp2bWe+S/uqHOj2/wOzGRHOJd3J7EeOvyb6FSepOx496kZgNQh++3jS6MXVNTp20Z5V9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755941; c=relaxed/simple;
	bh=0shH0MIpU/+fHe3BpvoegYg1ty2d8Q96t4AIpk9WppA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWNzx9E1g4ARjOkJQ8dH7spPd+Y3kledj4JCQVYpBDJjTANz0rHoy/Sq1jKfvc8eK6pM4mzBWJSUNK3UxiMKE3i+bwJZ4eNsLdU0VgzwJl8UMNrQ5uER+CCTo/eS8mx6sz1jWkKDXJMN/Ago2+jCUApvFtD7UHDRBxwJ7KIyhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=l2JZcSiL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id DABBD20239; Fri,  7 Jun 2024 18:25:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717755937;
	bh=yd4IJp7KEoVXYbhKe9PO348L7pYanHh9Dhj573+5fWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l2JZcSiLp8fnkDCqR4wEQ22Ffr/fkAOT2JqAkC/vUB1dF2NIXjm6vDialcTSUng1D
	 paorEcBU8VVcdL6O/UnFvDV7LyUo0Hn+XQZv9eBfyHGZVO3x7JBVEN0JyjU0eiAaS3
	 racdRGl/bb1lmBYM32opWHNLevKiea/rDaZZTml2JtDHxx95IgEWzf8c2pHOxpxRYk
	 bqmflaT9yp7doviuYfNtNvJn7lVe49+kGrGRrc2dx1zu2+iTjJg5Zrj3barlBETU34
	 XpkUcE3S2ZPguRsRV3cETAlAqoLbUJ7hYwiSgMjlb2W1na3vrhhK2Kq3vMwbRV1ITE
	 Vsmj+LlipwrXg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 07 Jun 2024 18:25:25 +0800
Subject: [PATCH net-next v3 2/3] net: core: Implement dstats-type stats
 collections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-dstats-v3-2-cc781fe116f7@codeconstruct.com.au>
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
In-Reply-To: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
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

This change adds a common implementation for dstats-type collection,
used when pcpu_stat_type == NETDEV_PCPU_STAT_DSTAT. This is based on the
VRF driver's existing stats collator (plus the unused tx_drops stat from
there). We will switch the VRF driver to use this in the next change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v3:
 - As suggested by Jakub: don't expose dev_get_dstats64 as a helper, but
   invoke automatically for NETDEV_PCPU_STAT_DSTAT devices.
v2:
 - use correct percpu var ("stats", not "dstats") in dev_fetch_dstats
---
 net/core/dev.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e1bb6d7856d9..3dcfc8d6c51a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10702,6 +10702,54 @@ void netdev_run_todo(void)
 		wake_up(&netdev_unregistering_wq);
 }
 
+/* Collate per-cpu network dstats statistics
+ *
+ * Read per-cpu network statistics from dev->dstats and populate the related
+ * fields in @s.
+ */
+static void dev_fetch_dstats(struct rtnl_link_stats64 *s,
+			     const struct pcpu_dstats __percpu *dstats)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 rx_packets, rx_bytes, rx_drops;
+		u64 tx_packets, tx_bytes, tx_drops;
+		const struct pcpu_dstats *stats;
+		unsigned int start;
+
+		stats = per_cpu_ptr(dstats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			rx_packets = u64_stats_read(&stats->rx_packets);
+			rx_bytes   = u64_stats_read(&stats->rx_bytes);
+			rx_drops   = u64_stats_read(&stats->rx_drops);
+			tx_packets = u64_stats_read(&stats->tx_packets);
+			tx_bytes   = u64_stats_read(&stats->tx_bytes);
+			tx_drops   = u64_stats_read(&stats->tx_drops);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		s->rx_packets += rx_packets;
+		s->rx_bytes   += rx_bytes;
+		s->rx_dropped += rx_drops;
+		s->tx_packets += tx_packets;
+		s->tx_bytes   += tx_bytes;
+		s->tx_dropped += tx_drops;
+	}
+}
+
+/* ndo_get_stats64 implementation for dtstats-based accounting.
+ *
+ * Populate @s from dev->stats and dev->dstats. This is used internally by the
+ * core for NETDEV_PCPU_STAT_DSTAT-type stats collection.
+ */
+static void dev_get_dstats64(const struct net_device *dev,
+			     struct rtnl_link_stats64 *s)
+{
+	netdev_stats_to_stats64(s, &dev->stats);
+	dev_fetch_dstats(s, dev->dstats);
+}
+
 /* Convert net_device_stats to rtnl_link_stats64. rtnl_link_stats64 has
  * all the same fields in the same order as net_device_stats, with only
  * the type differing, but rtnl_link_stats64 may have additional fields
@@ -10778,6 +10826,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
 	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
 		dev_get_tstats64(dev, storage);
+	} else if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_DSTATS) {
+		dev_get_dstats64(dev, storage);
 	} else {
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}

-- 
2.39.2


