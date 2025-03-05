Return-Path: <netdev+bounces-172243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA3A50F25
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C1673E7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A862673B2;
	Wed,  5 Mar 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iufm6RIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69A2673A1
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215156; cv=none; b=d3QUHXj59iuMnL6PpTZ0QuZGplvazvw9bJV8f8SBOfCZcZshOyOHEZmd0wPiAFQq6Jy2ATwD5ECsjKENBwesHOO7i64cfkxYKu5/P6Ga8NDgJLeMJirSItcBC7POVjWwMsj2+E08F9S1Z0yz4WwBGHpkdeLq+uh4OUDNFcFEi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215156; c=relaxed/simple;
	bh=2NMABfEWHv9SKr+Fyd6GVBpwZwonaqx56fcprY4oHPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCnelXnAJqo8sXx8R4xoaSy41RbpTVPgIBq6Z7PuLpJIKGwFRjAon0dAqaYNOsNUYtV3+o0KIIj8zjNAJ/oC/oAAPAUbZ7wBi9JaZwpuLPmgho0GJ4C6JuWW6tWsv7G/vZzE4tCel0wpLT45wvidaLNMn3ysjem8w3e53pd3ZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iufm6RIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43B6C4CEE0;
	Wed,  5 Mar 2025 22:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215156;
	bh=2NMABfEWHv9SKr+Fyd6GVBpwZwonaqx56fcprY4oHPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iufm6RIMPR6lWRXy6eRHmrBHgrUFxEG1layymUWoCEICxv2tpVsQkJ4CwLKDLV3Tf
	 4Ly+W0pTt3wCWOQ0VCftOOiPk8aWHw8Z0hj2lGa8rRsEj50O01PyKbQW6QUzIwMx6d
	 YFwNMMD/qAnDSvTyfGU4dN8EBlxRKKWM/ICdqwtum5/+D0OvtcLQpJ8H6XmmkDqQdJ
	 rj+InrUGjV8PBGNkRoUJF0CLmj08pbElW704FNhoR3iNgGRjd3FhKD6Y3xDnfVXOD/
	 g4wQ/eazU++HUP28+tNIiHyUeljXnlwgVwZ//7Jaoqtw2vk6rK5W5VYB1qdPUSFmB0
	 ez3615Wgy3mjQ==
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
Subject: [PATCH net-next v3 09/10] eth: bnxt: maintain tx pkt/byte stats in SW
Date: Wed,  5 Mar 2025 14:52:14 -0800
Message-ID: <20250305225215.1567043-10-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305225215.1567043-1-kuba@kernel.org>
References: <20250305225215.1567043-1-kuba@kernel.org>
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
v3:
 - count padding and vlans
v2: https://lore.kernel.org/20250228012534.3460918-9-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 13 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 +++++++++++++++--------
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 376141a41ecf..37d7f08a73c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -771,6 +771,7 @@ struct nqe_cn {
 	 SKB_DATA_ALIGN((unsigned int)sizeof(struct skb_shared_info)))
 
 #define BNXT_MIN_PKT_SIZE	52
+#define BNXT_MIN_ETH_SIZE	60
 
 #define BNXT_DEFAULT_RX_RING_SIZE	511
 #define BNXT_DEFAULT_TX_RING_SIZE	511
@@ -877,11 +878,15 @@ struct bnxt_sw_tx_bd {
 		struct sk_buff		*skb;
 		struct xdp_frame	*xdpf;
 	};
+	struct page		*page;
 	DEFINE_DMA_UNMAP_ADDR(mapping);
 	DEFINE_DMA_UNMAP_LEN(len);
-	struct page		*page;
+	u16			extra_segs;
+	u8			extra_bytes;
+	u8			hdr_size;
 	u8			is_ts_pkt;
 	u8			is_push;
+	u8			is_vfr;
 	u8			action;
 	unsigned short		nr_frags;
 	union {
@@ -1128,6 +1133,10 @@ struct bnxt_rx_sw_stats {
 
 struct bnxt_tx_sw_stats {
 	u64			tx_resets;
+	/* non-ethtool stats follow */
+	u64			tx_packets;
+	u64			tx_bytes;
+	struct u64_stats_sync	syncp;
 };
 
 struct bnxt_cmn_sw_stats {
@@ -1153,6 +1162,8 @@ struct bnxt_total_ring_drv_stats {
 	/* non-ethtool stats follow */
 	u64			rx_total_packets;
 	u64			rx_total_bytes;
+	u64			tx_total_packets;
+	u64			tx_total_bytes;
 };
 
 struct bnxt_stats_mem {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bdc052b247ba..893102c0d24e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -514,6 +514,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	vlan_tag_flags = 0;
 	cfa_action = bnxt_xmit_get_cfa_action(skb);
+	tx_buf->is_vfr = !!cfa_action;
 	if (skb_vlan_tag_present(skb)) {
 		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
 				 skb_vlan_tag_get(skb);
@@ -522,6 +523,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 */
 		if (skb->vlan_proto == htons(ETH_P_8021Q))
 			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
+		tx_buf->extra_bytes += VLAN_HLEN;
 	}
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && ptp &&
@@ -610,6 +612,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				    DB_RING_IDX(&txr->tx_db, prod));
 		WRITE_ONCE(txr->tx_prod, prod);
 
+		if (skb->len < BNXT_MIN_ETH_SIZE)
+			tx_buf->extra_bytes += BNXT_MIN_ETH_SIZE - skb->len;
 		tx_buf->is_push = 1;
 		netdev_tx_sent_queue(txq, skb->len);
 		wmb();	/* Sync is_push and byte queue before pushing data */
@@ -634,6 +638,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto tx_kick_pending;
 		length = BNXT_MIN_PKT_SIZE;
 	}
+	if (skb->len < BNXT_MIN_ETH_SIZE)
+		tx_buf->extra_bytes += BNXT_MIN_ETH_SIZE - skb->len;
 
 	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
@@ -675,6 +681,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		length = skb_shinfo(skb)->gso_size;
 		txbd1->tx_bd_mss = cpu_to_le32(length);
 		length += hdr_len;
+
+		tx_buf->hdr_size = hdr_len;
+		tx_buf->extra_segs = skb_shinfo(skb)->gso_segs - 1;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
@@ -784,6 +793,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
 	txr->tx_buf_ring[txr->tx_prod].skb = NULL;
+	txr->tx_buf_ring[txr->tx_prod].extra_segs = 0;
+	txr->tx_buf_ring[txr->tx_prod].extra_bytes = 0;
+	txr->tx_buf_ring[txr->tx_prod].hdr_size = 0;
+	txr->tx_buf_ring[txr->tx_prod].is_vfr = 0;
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
@@ -793,11 +806,12 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
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
@@ -823,8 +837,20 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		cons = NEXT_TX(cons);
 		tx_pkts++;
 		tx_bytes += skb->len;
+		if (!tx_buf->is_vfr) {
+			adj_pkts += tx_buf->extra_segs;
+			adj_bytes += tx_buf->extra_bytes +
+				tx_buf->extra_segs * tx_buf->hdr_size;
+		} else {
+			adj_pkts--;
+			adj_bytes -= skb->len;
+		}
 		tx_buf->skb = NULL;
+		tx_buf->extra_segs = 0;
+		tx_buf->extra_bytes = 0;
+		tx_buf->hdr_size = 0;
 		tx_buf->is_ts_pkt = 0;
+		tx_buf->is_vfr = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
@@ -860,6 +886,11 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 
 	WRITE_ONCE(txr->tx_cons, cons);
 
+	u64_stats_update_begin(&sw_stats->tx.syncp);
+	sw_stats->tx.tx_packets += tx_pkts + adj_pkts;
+	sw_stats->tx.tx_bytes   += tx_bytes + adj_bytes;
+	u64_stats_update_end(&sw_stats->tx.syncp);
+
 	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
 				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
@@ -5128,6 +5159,7 @@ static int bnxt_alloc_stats(struct bnxt *bp)
 			return -ENOMEM;
 
 		u64_stats_init(&cpr->sw_stats->rx.syncp);
+		u64_stats_init(&cpr->sw_stats->tx.syncp);
 
 		cpr->stats.len = size;
 		rc = bnxt_alloc_stats_mem(bp, &cpr->stats, !i);
@@ -13106,14 +13138,16 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
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
@@ -13132,13 +13166,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
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
@@ -13230,6 +13259,8 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
 	stats->rx_total_bytes += sw_stats.rx.rx_bytes;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->tx_total_packets += sw_stats.tx.tx_packets;
+	stats->tx_total_bytes += sw_stats.tx.tx_bytes;
 	stats->tx_total_resets += sw_stats.tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
@@ -15637,21 +15668,16 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
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
@@ -15664,8 +15690,8 @@ static void bnxt_get_base_stats(struct net_device *dev,
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


