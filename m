Return-Path: <netdev+bounces-170488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A88DAA48DE5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850D616EA17
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9BC1547FF;
	Fri, 28 Feb 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7WVkaOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9714D70E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705941; cv=none; b=hA4NxnyhwP1iMQhAhKP7e2yeb8AFnaKAgAZa4g/gwhluJN80ENKjFpfoHe4mZOzWkdk+BFe6AT5p7asSqEg30U7HGlvyAmFraFQSaemLgD45Krp3tnvdj4B3giVGnYQbirY9ZINpvjWqjR0qpta4yp7GiR0M3oEuw1zJZmN36MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705941; c=relaxed/simple;
	bh=nhCZIB/XRzxwwR8yVQYylQzwU3DUB4sGLrvNiUVQz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQtkMwkA5NxNGqcgm4ij8T1BfYAcIWLR0G9OcFnc6FMRb/qQm7g1NxeN1QQbtw9GL89cHWZq5Mmo7vagZT1+2ZPv7hFKYD3zqpzoU2YjzAPW80Bt/tYip4HK19lgoBSo3CAZcwC4UbCoCl14GUOert+marH3tgKTzbZmtKHJFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7WVkaOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE8DC4CEE8;
	Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705941;
	bh=nhCZIB/XRzxwwR8yVQYylQzwU3DUB4sGLrvNiUVQz/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7WVkaOaagGKiI1gvjYT17aem0aygXxofNcPDnzHlWD4GKWUmtx9sw4MaknWz8tR1
	 pXrtrUi5vMlRksqE9uo+0411IAlPdsGOQa18aQhzblsshF4JW+zMJ6nAODxFkJtM23
	 stsgK6M6cZ0b/fEtvb+pFkx29b+ZbZEGsV3n8v6DoEBeZHrKZO/0eCp0X/O5iP3sxG
	 ZBSLJd9yH8tq66VZdQWlvq5ofhq9E/4PgSvlKVoZ7BjTNUhUvTe2Msi+Y8TAFUWP4c
	 IwSM1Kb4oMz4Jd/0lGAk+7D2aduZXCknJiBtFVR3dr8ezgCflQVAghE+6fWmI7WHeb
	 YprenPb75TYuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 7/9] eth: bnxt: maintain rx pkt/byte stats in SW
Date: Thu, 27 Feb 2025 17:25:32 -0800
Message-ID: <20250228012534.3460918-8-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228012534.3460918-1-kuba@kernel.org>
References: <20250228012534.3460918-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some workloads want to be able to track bandwidth utilization on
the scale of 10s of msecs. Updating all HW stats at this rate is
both hard and wasteful of PCIe bandwidth.

Maintain basic Rx pkt/byte counters in software. ethtool -S will still
show the HW stats, but qstats and rtnl stats will show SW statistics.

We need to take care of HW-GRO, XDP and VF representors. Per netdev
qstat definition Rx stats should reflect packets passed to XDP (if
active, otherwise to the stack). XDP and GRO do not interoperate
in bnxt, so we need to count the packets in a few places.
Add a helper and call it where needed.

Do not count VF representor traffic as traffic for the main netdev.

The stats are added towards the end of the struct since ethtool
code expects existing members to be first.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - adjust to skipping XDP inside bnxt_rx_pkt()
v1: https://lore.kernel.org/20250226211003.2790916-8-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 25 +++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 68 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 14 +++-
 3 files changed, 77 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 34f23ddd4d71..376141a41ecf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1118,8 +1118,12 @@ struct bnxt_rx_sw_stats {
 	u64			rx_l4_csum_errors;
 	u64			rx_resets;
 	u64			rx_buf_errors;
+	/* non-ethtool stats follow */
 	u64			rx_oom_discards;
 	u64			rx_netpoll_discards;
+	u64			rx_packets;
+	u64			rx_bytes;
+	struct u64_stats_sync	syncp;
 };
 
 struct bnxt_tx_sw_stats {
@@ -1146,6 +1150,9 @@ struct bnxt_total_ring_drv_stats {
 	u64			tx_total_resets;
 	u64			tx_total_ring_discards;
 	u64			total_missed_irqs;
+	/* non-ethtool stats follow */
+	u64			rx_total_packets;
+	u64			rx_total_bytes;
 };
 
 struct bnxt_stats_mem {
@@ -2797,6 +2804,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
 	return bp->tx_ring_size - (used & bp->tx_ring_mask);
 }
 
+static inline void bnxt_rx_pkt_cnt(struct bnxt *bp, struct bnxt_napi *bnapi,
+				   struct net_device *dev,
+				   int segs, int len, int payload_off)
+{
+	struct bnxt_sw_stats *sw_stats = bnapi->cp_ring.sw_stats;
+
+	/* Packet is for a representor */
+	if (bp->dev != dev)
+		return;
+
+	u64_stats_update_begin(&sw_stats->rx.syncp);
+	sw_stats->rx.rx_packets	+= segs;
+	sw_stats->rx.rx_bytes	+= len;
+	if (segs > 1)
+		sw_stats->rx.rx_bytes += (segs - 1) * payload_off;
+	u64_stats_update_end(&sw_stats->rx.syncp);
+}
+
 static inline void bnxt_writeq(struct bnxt *bp, u64 val,
 			       volatile void __iomem *addr)
 {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d4052bfcc4ff..3840359250b2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1735,6 +1735,7 @@ static struct sk_buff *bnxt_gro_func_5730x(struct bnxt_tpa_info *tpa_info,
 }
 
 static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
+					   struct bnxt_napi *bnapi,
 					   bool gro,
 					   struct bnxt_tpa_info *tpa_info,
 					   struct rx_tpa_end_cmp *tpa_end,
@@ -1742,11 +1743,15 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 					   struct sk_buff *skb)
 {
 	int payload_off;
+	int full_len;
 	u16 segs;
 
+	full_len = skb->len - skb_mac_offset(skb);
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (!gro || segs == 1 || !IS_ENABLED(CONFIG_INET))
+	if (!gro || segs == 1 || !IS_ENABLED(CONFIG_INET)) {
+		bnxt_rx_pkt_cnt(bp, bnapi, skb->dev, 1, full_len, 0);
 		return skb;
+	}
 
 	NAPI_GRO_CB(skb)->count = segs;
 	skb_shinfo(skb)->gso_size =
@@ -1757,8 +1762,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	else
 		payload_off = TPA_END_PAYLOAD_OFF(tpa_end);
 	skb = bp->gro_func(tpa_info, payload_off, TPA_END_GRO_TS(tpa_end), skb);
-	if (likely(skb))
+	if (likely(skb)) {
 		tcp_gro_complete(skb);
+		bnxt_rx_pkt_cnt(bp, bnapi, skb->dev,
+				segs, full_len, payload_off);
+	}
 	return skb;
 }
 
@@ -1918,7 +1926,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
 	}
 
-	return bnxt_gro_skb(bp, gro, tpa_info, tpa_end, tpa_end1, skb);
+	return bnxt_gro_skb(bp, bnapi, gro, tpa_info, tpa_end, tpa_end1, skb);
 }
 
 static void bnxt_tpa_agg(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
@@ -2275,6 +2283,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			}
 		}
 	}
+
+	if (!xdp_active) /* XDP packets counted in bnxt_rx_xdp() */
+		bnxt_rx_pkt_cnt(bp, bnapi, dev,
+				1, skb->len - skb_mac_offset(skb), 0);
 	bnxt_deliver_skb(bp, bnapi, skb);
 	rc = 1;
 
@@ -5115,6 +5127,8 @@ static int bnxt_alloc_stats(struct bnxt *bp)
 		if (!cpr->sw_stats)
 			return -ENOMEM;
 
+		u64_stats_init(&cpr->sw_stats->rx.syncp);
+
 		cpr->stats.len = size;
 		rc = bnxt_alloc_stats_mem(bp, &cpr->stats, !i);
 		if (rc)
@@ -13092,7 +13106,14 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 static void bnxt_drv_stat_snapshot(const struct bnxt_sw_stats *sw_stats,
 				   struct bnxt_sw_stats *snapshot)
 {
-	memcpy(snapshot, sw_stats, sizeof(*snapshot));
+	unsigned int seq_rx;
+
+	do {
+		seq_rx = u64_stats_fetch_begin(&sw_stats->rx.syncp);
+
+		memcpy(snapshot, sw_stats, sizeof(*snapshot));
+
+	} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq_rx));
 }
 
 static void bnxt_get_ring_stats(struct bnxt *bp,
@@ -13108,18 +13129,13 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 
 		bnxt_drv_stat_snapshot(cpr->sw_stats, &sw_stats);
 
-		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_ucast_pkts);
-		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_mcast_pkts);
-		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_bcast_pkts);
+		stats->rx_packets += sw_stats.rx.rx_packets;
+		stats->rx_bytes += sw_stats.rx.rx_bytes;
 
 		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
 		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
 		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
 
-		stats->rx_bytes += BNXT_GET_RING_STATS64(sw, rx_ucast_bytes);
-		stats->rx_bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
-		stats->rx_bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
-
 		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
 		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
 		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
@@ -13210,6 +13226,8 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
 	stats->rx_total_buf_errors += sw_stats.rx.rx_buf_errors;
 	stats->rx_total_oom_discards += sw_stats.rx.rx_oom_discards;
 	stats->rx_total_netpoll_discards += sw_stats.rx.rx_netpoll_discards;
+	stats->rx_total_packets += sw_stats.rx.rx_packets;
+	stats->rx_total_bytes += sw_stats.rx.rx_bytes;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
 	stats->tx_total_resets += sw_stats.tx.tx_resets;
@@ -15602,23 +15620,17 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_rx *stats)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	struct bnxt_cp_ring_info *cpr;
-	u64 *sw;
+	struct bnxt_sw_stats *sw_stats;
+	unsigned int seq;
 
-	cpr = &bp->bnapi[i]->cp_ring;
-	sw = cpr->stats.sw_stats;
+	sw_stats = bp->bnapi[i]->cp_ring.sw_stats;
 
-	stats->packets = 0;
-	stats->packets += BNXT_GET_RING_STATS64(sw, rx_ucast_pkts);
-	stats->packets += BNXT_GET_RING_STATS64(sw, rx_mcast_pkts);
-	stats->packets += BNXT_GET_RING_STATS64(sw, rx_bcast_pkts);
-
-	stats->bytes = 0;
-	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_ucast_bytes);
-	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
-	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
-
-	stats->alloc_fail = cpr->sw_stats->rx.rx_oom_discards;
+	do {
+		seq = u64_stats_fetch_begin(&sw_stats->rx.syncp);
+		stats->packets = sw_stats->rx.rx_packets;
+		stats->bytes = sw_stats->rx.rx_bytes;
+		stats->alloc_fail = sw_stats->rx.rx_oom_discards;
+	} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq));
 }
 
 static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
@@ -15648,8 +15660,8 @@ static void bnxt_get_base_stats(struct net_device *dev,
 {
 	struct bnxt *bp = netdev_priv(dev);
 
-	rx->packets = bp->net_stats_prev.rx_packets;
-	rx->bytes = bp->net_stats_prev.rx_bytes;
+	rx->packets = bp->ring_drv_stats_prev.rx_total_packets;
+	rx->bytes = bp->ring_drv_stats_prev.rx_total_bytes;
 	rx->alloc_fail = bp->ring_drv_stats_prev.rx_total_oom_discards;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index aba49ddb0e66..16d3698cf0e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -247,10 +247,20 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct net_device *dev,
 	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
 	orig_data = xdp->data;
 
-	if (bp->dev == dev)
+	if (bp->dev == dev) {
+		struct skb_shared_info *sinfo;
+		int stat_len = *len;
+
+		if (unlikely(xdp_buff_has_frags(xdp))) {
+			sinfo = xdp_get_shared_info_from_buff(xdp);
+			stat_len += sinfo->xdp_frags_size;
+		}
+
+		bnxt_rx_pkt_cnt(bp, rxr->bnapi, dev, 1, stat_len, 0);
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
-	else /* packet is for a VF representor */
+	} else { /* packet is for a VF representor */
 		act = XDP_PASS;
+	}
 
 	tx_avail = bnxt_tx_avail(bp, txr);
 	/* If the tx ring is not full, we must not update the rx producer yet
-- 
2.48.1


