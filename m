Return-Path: <netdev+bounces-170489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF3A48DE7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D2E16EB28
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A5155C88;
	Fri, 28 Feb 2025 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuJ5gt7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29215539D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705942; cv=none; b=HmezU7QDmns+sAQaFfld09742N28D0ASkRdcfBe39hwfnE/0prgJ+u0ncVszFAF9+UEpLwg95o3AbS/Gok9yBybE9CMPx5iFP/w6YoMdQgRLneOWXIzAss5hMsjYXTZHs9FsV/HZ3dA/VmWMshhZbMHZJRT1CtQQm7sA5OH3Ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705942; c=relaxed/simple;
	bh=llUzk1zhukEgUgjPPMSsQ+y4IBukawncF4wednpCqaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4R40p83yYBBgSunG/LEVyOiK7zzbyqIwiqcS5soCGsx78J7FG6VQ8V7aTSjXS5DkpBSIft4vYBo11Kgt8actXf+4AfaR1AOZS/up7dh0d528xBj9+zskChVOdmS0pCOmn2roQPgQIUTMnz9YIolEkkJrvQRZCS9IMjpJAQrsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuJ5gt7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650DCC4CEE9;
	Fri, 28 Feb 2025 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705941;
	bh=llUzk1zhukEgUgjPPMSsQ+y4IBukawncF4wednpCqaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuJ5gt7cCeSCZXWSiC7lFVY+s84hDqVvm74sbQDCVrm0uk7TxzhtqbkmoY2EEv4ZS
	 Bihvm28u/zB/orpJj6TbXsM7N0/fqRjWJbqdOHBAMkQ8jtj0hFnJ89W/RVT5YD26dR
	 SCm2wjfS9eTAGAWENgwhvfEX9ryYAwp7lKWI6TNFvDTOy3HKrAlAy+2/rDiYcHY2QE
	 Dwtc/UTXXHJXCTRrx9zoe2Yf3t8AYfHm8b/do39kOBmP9RlKBKs0RMOJU4x3piDo6H
	 9hn2/FpELGJHP/MlglqQkCnJ8qGo1YD3FlpLjZHALi4NKF2EwcPMFSzFaDPnrGlIcG
	 WOGbq/oaEs/iA==
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
Subject: [PATCH net-next v2 8/9] eth: bnxt: maintain tx pkt/byte stats in SW
Date: Thu, 27 Feb 2025 17:25:33 -0800
Message-ID: <20250228012534.3460918-9-kuba@kernel.org>
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

Maintain basic Tx pkt/byte counters in software. ethtool -S will still
show the HW stats, but qstats and rtnl stats will show SW statistics.

We need to take care of TSO and VF representors, record relevant
state in tx_buf to avoid touching potentially cold skb. Use existing
holes in the struct (no size change). Note that according to TX_BD_HSIZE
max header size is 255, so u8 should be enough.

It's not obvious whether VF representor traffic should be counted,
on one hand it doesn't belong to the local interface. On the other
it does go thru normal queuing so Qdisc will show it. I opted to
_not_ count it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 11 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 70 ++++++++++++++---------
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 376141a41ecf..d5f617fd5beb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -877,11 +877,14 @@ struct bnxt_sw_tx_bd {
 		struct sk_buff		*skb;
 		struct xdp_frame	*xdpf;
 	};
+	struct page		*page;
 	DEFINE_DMA_UNMAP_ADDR(mapping);
 	DEFINE_DMA_UNMAP_LEN(len);
-	struct page		*page;
+	u16			extra_segs;
+	u8			hdr_size;
 	u8			is_ts_pkt;
 	u8			is_push;
+	u8			is_vfr;
 	u8			action;
 	unsigned short		nr_frags;
 	union {
@@ -1128,6 +1131,10 @@ struct bnxt_rx_sw_stats {
 
 struct bnxt_tx_sw_stats {
 	u64			tx_resets;
+	/* non-ethtool stats follow */
+	u64			tx_packets;
+	u64			tx_bytes;
+	struct u64_stats_sync	syncp;
 };
 
 struct bnxt_cmn_sw_stats {
@@ -1153,6 +1160,8 @@ struct bnxt_total_ring_drv_stats {
 	/* non-ethtool stats follow */
 	u64			rx_total_packets;
 	u64			rx_total_bytes;
+	u64			tx_total_packets;
+	u64			tx_total_bytes;
 };
 
 struct bnxt_stats_mem {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3840359250b2..f6308e4e8360 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -514,6 +514,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	vlan_tag_flags = 0;
 	cfa_action = bnxt_xmit_get_cfa_action(skb);
+	tx_buf->is_vfr = !!cfa_action;
 	if (skb_vlan_tag_present(skb)) {
 		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
 				 skb_vlan_tag_get(skb);
@@ -675,6 +676,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		length = skb_shinfo(skb)->gso_size;
 		txbd1->tx_bd_mss = cpu_to_le32(length);
 		length += hdr_len;
+
+		tx_buf->hdr_size = hdr_len;
+		tx_buf->extra_segs = skb_shinfo(skb)->gso_segs - 1;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
@@ -784,6 +788,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
 	txr->tx_buf_ring[txr->tx_prod].skb = NULL;
+	txr->tx_buf_ring[txr->tx_prod].extra_segs = 0;
+	txr->tx_buf_ring[txr->tx_prod].hdr_size = 0;
+	txr->tx_buf_ring[txr->tx_prod].is_vfr = 0;
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
@@ -793,11 +800,12 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  int budget)
 {
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
+	struct bnxt_sw_stats *sw_stats = txr->bnapi->cp_ring.sw_stats;
 	struct pci_dev *pdev = bp->pdev;
+	int adj_bytes = 0, tx_bytes = 0;
+	int adj_pkts = 0, tx_pkts = 0;
 	u16 hw_cons = txr->tx_hw_cons;
-	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
-	int tx_pkts = 0;
 	bool rc = false;
 
 	while (RING_TX(bp, cons) != hw_cons) {
@@ -823,8 +831,18 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		cons = NEXT_TX(cons);
 		tx_pkts++;
 		tx_bytes += skb->len;
+		if (!tx_buf->is_vfr) {
+			adj_pkts += tx_buf->extra_segs;
+			adj_bytes += tx_buf->extra_segs * tx_buf->hdr_size;
+		} else {
+			adj_pkts--;
+			adj_bytes -= skb->len;
+		}
 		tx_buf->skb = NULL;
+		tx_buf->extra_segs = 0;
+		tx_buf->hdr_size = 0;
 		tx_buf->is_ts_pkt = 0;
+		tx_buf->is_vfr = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
@@ -860,6 +878,11 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 
 	WRITE_ONCE(txr->tx_cons, cons);
 
+	u64_stats_update_begin(&sw_stats->tx.syncp);
+	sw_stats->tx.tx_packets += tx_pkts + adj_pkts;
+	sw_stats->tx.tx_bytes   += tx_bytes + adj_bytes;
+	u64_stats_update_end(&sw_stats->tx.syncp);
+
 	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
 				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
@@ -5128,6 +5151,7 @@ static int bnxt_alloc_stats(struct bnxt *bp)
 			return -ENOMEM;
 
 		u64_stats_init(&cpr->sw_stats->rx.syncp);
+		u64_stats_init(&cpr->sw_stats->tx.syncp);
 
 		cpr->stats.len = size;
 		rc = bnxt_alloc_stats_mem(bp, &cpr->stats, !i);
@@ -13106,14 +13130,16 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 static void bnxt_drv_stat_snapshot(const struct bnxt_sw_stats *sw_stats,
 				   struct bnxt_sw_stats *snapshot)
 {
-	unsigned int seq_rx;
+	unsigned int seq_rx, seq_tx;
 
 	do {
 		seq_rx = u64_stats_fetch_begin(&sw_stats->rx.syncp);
+		seq_tx = u64_stats_fetch_begin(&sw_stats->tx.syncp);
 
 		memcpy(snapshot, sw_stats, sizeof(*snapshot));
 
-	} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq_rx));
+	} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq_rx) ||
+		 u64_stats_fetch_retry(&sw_stats->tx.syncp, seq_tx));
 }
 
 static void bnxt_get_ring_stats(struct bnxt *bp,
@@ -13132,13 +13158,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 		stats->rx_packets += sw_stats.rx.rx_packets;
 		stats->rx_bytes += sw_stats.rx.rx_bytes;
 
-		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
-		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
-		stats->tx_packets += BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
-
-		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
-		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
-		stats->tx_bytes += BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
+		stats->tx_packets += sw_stats.tx.tx_packets;
+		stats->tx_bytes += sw_stats.tx.tx_bytes;
 
 		stats->rx_missed_errors +=
 			BNXT_GET_RING_STATS64(sw, rx_discard_pkts);
@@ -13230,6 +13251,8 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
 	stats->rx_total_bytes += sw_stats.rx.rx_bytes;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->tx_total_packets += sw_stats.tx.tx_packets;
+	stats->tx_total_bytes += sw_stats.tx.tx_bytes;
 	stats->tx_total_resets += sw_stats.tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
@@ -15637,21 +15660,16 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_tx *stats)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	struct bnxt_napi *bnapi;
-	u64 *sw;
+	struct bnxt_sw_stats *sw_stats;
+	unsigned int seq;
 
-	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
-	sw = bnapi->cp_ring.stats.sw_stats;
+	sw_stats = bp->tx_ring[bp->tx_ring_map[i]].bnapi->cp_ring.sw_stats;
 
-	stats->packets = 0;
-	stats->packets += BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
-	stats->packets += BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
-	stats->packets += BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
-
-	stats->bytes = 0;
-	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
-	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
-	stats->bytes += BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
+	do {
+		seq = u64_stats_fetch_begin(&sw_stats->tx.syncp);
+		stats->packets = sw_stats->tx.tx_packets;
+		stats->bytes = sw_stats->tx.tx_bytes;
+	} while (u64_stats_fetch_retry(&sw_stats->tx.syncp, seq));
 }
 
 static void bnxt_get_base_stats(struct net_device *dev,
@@ -15664,8 +15682,8 @@ static void bnxt_get_base_stats(struct net_device *dev,
 	rx->bytes = bp->ring_drv_stats_prev.rx_total_bytes;
 	rx->alloc_fail = bp->ring_drv_stats_prev.rx_total_oom_discards;
 
-	tx->packets = bp->net_stats_prev.tx_packets;
-	tx->bytes = bp->net_stats_prev.tx_bytes;
+	tx->packets = bp->ring_drv_stats_prev.tx_total_packets;
+	tx->bytes = bp->ring_drv_stats_prev.tx_total_bytes;
 }
 
 static const struct netdev_stat_ops bnxt_stat_ops = {
-- 
2.48.1


