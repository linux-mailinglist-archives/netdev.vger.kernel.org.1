Return-Path: <netdev+bounces-117382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0594DAFB
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C12822CF
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43A4644E;
	Sat, 10 Aug 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS487n7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A445957
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268606; cv=none; b=IPbx5BMAKKXgoysb97RhGtCoQEKVc0Xwl31/tFoIvVcFxwe6AbiDNnBrf7DKolH4yHB4tgbqDgcaqLcvxfUPjMoS9VlJhNS5VEFhCVV280oX/W+j6C05iPOfhk0pPM0AEEiFN4btjngaWjR7SkGzB+91aw3HCnM9H5OWc6zrivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268606; c=relaxed/simple;
	bh=KkRt3LDFKWg6KlW3a4QqzOS1X8U1zX4vkPzeWuR/d9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKog2sh32b7+N0pPpw3SIGm6FLCl8hu+pLt0HbK3NIg5wvdGt6/TEEsTCG5F5lcD5qBDfSxKF9quzrCKxsump85sH2G2JZOQZ0KM3kVjTGk0HQ1Hdyt79bCpuqL6TiLcdXDVGWM2Bgtksax7gID+eXLKbw2a6CapStpld034zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS487n7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80F2C4AF0E;
	Sat, 10 Aug 2024 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268606;
	bh=KkRt3LDFKWg6KlW3a4QqzOS1X8U1zX4vkPzeWuR/d9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uS487n7Jx8zITD7Jb6snAFWfY6QdsmVjoA3J/q1durF1chBQTOSAveIE/Owh2sRRm
	 tW6M94QQ5GbzeleigCgTTEryy/VVz66JBfmOY+NWtNoc34GLXPYz/03Hfddnx91lc4
	 Kr913B+6dSkF5KSjzLxcrZfMBgUdniZRyq81iiTFvZ2U4mg+auHaLtSDlJl4YPYROc
	 xo5fRR+h9+fqYQYubPeKVyYOo3et3AFtdG1VG9EYJdqXmHmOuiVA225B6R/7GQM394
	 qsQoh64+rONCTsZ71S59UWpeqgJgUugUxHPI3VchnjijVXQ8tzYk4C/yBfKz60IVvt
	 pB4+iObkFGunQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/2] eth: fbnic: add basic rtnl stats
Date: Fri,  9 Aug 2024 22:43:21 -0700
Message-ID: <20240810054322.2766421-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810054322.2766421-1-kuba@kernel.org>
References: <20240810054322.2766421-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count packets, bytes and drop on the datapath, and report
to the user. Since queues are completely freed when the
device is down - accumulate the stats in the main netdev struct.
This means that per-queue stats will only report values since
last reset (per qstat recommendation).

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - add u64_stats_init()
v2:
 - drop duplicated check
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 69 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 51 +++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  | 10 +++
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b7ce6da68543..a048e4a617eb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -316,6 +316,74 @@ void fbnic_clear_rx_mode(struct net_device *netdev)
 	__dev_mc_unsync(netdev, NULL);
 }
 
+static void fbnic_get_stats64(struct net_device *dev,
+			      struct rtnl_link_stats64 *stats64)
+{
+	u64 tx_bytes, tx_packets, tx_dropped = 0;
+	u64 rx_bytes, rx_packets, rx_dropped = 0;
+	struct fbnic_net *fbn = netdev_priv(dev);
+	struct fbnic_queue_stats *stats;
+	unsigned int start, i;
+
+	stats = &fbn->tx_stats;
+
+	tx_bytes = stats->bytes;
+	tx_packets = stats->packets;
+	tx_dropped = stats->dropped;
+
+	stats64->tx_bytes = tx_bytes;
+	stats64->tx_packets = tx_packets;
+	stats64->tx_dropped = tx_dropped;
+
+	for (i = 0; i < fbn->num_tx_queues; i++) {
+		struct fbnic_ring *txr = fbn->tx[i];
+
+		if (!txr)
+			continue;
+
+		stats = &txr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			tx_bytes = stats->bytes;
+			tx_packets = stats->packets;
+			tx_dropped = stats->dropped;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->tx_bytes += tx_bytes;
+		stats64->tx_packets += tx_packets;
+		stats64->tx_dropped += tx_dropped;
+	}
+
+	stats = &fbn->rx_stats;
+
+	rx_bytes = stats->bytes;
+	rx_packets = stats->packets;
+	rx_dropped = stats->dropped;
+
+	stats64->rx_bytes = rx_bytes;
+	stats64->rx_packets = rx_packets;
+	stats64->rx_dropped = rx_dropped;
+
+	for (i = 0; i < fbn->num_rx_queues; i++) {
+		struct fbnic_ring *rxr = fbn->rx[i];
+
+		if (!rxr)
+			continue;
+
+		stats = &rxr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			rx_bytes = stats->bytes;
+			rx_packets = stats->packets;
+			rx_dropped = stats->dropped;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->rx_bytes += rx_bytes;
+		stats64->rx_packets += rx_packets;
+		stats64->rx_dropped += rx_dropped;
+	}
+}
+
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
@@ -324,6 +392,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_features_check	= fbnic_features_check,
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
+	.ndo_get_stats64	= fbnic_get_stats64,
 };
 
 void fbnic_reset_queues(struct fbnic_net *fbn,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 6bc0ebeb8182..60199e634468 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -40,6 +40,9 @@ struct fbnic_net {
 	u32 rss_key[FBNIC_RPC_RSS_KEY_DWORD_LEN];
 	u32 rss_flow_hash[FBNIC_NUM_HASH_OPT];
 
+	/* Storage for stats after ring destruction */
+	struct fbnic_queue_stats tx_stats;
+	struct fbnic_queue_stats rx_stats;
 	u64 link_down_events;
 
 	struct list_head napis;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 0ed4c9fff5d8..4d0406af297f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -273,6 +273,9 @@ fbnic_xmit_frame_ring(struct sk_buff *skb, struct fbnic_ring *ring)
 err_free:
 	dev_kfree_skb_any(skb);
 err_count:
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.dropped++;
+	u64_stats_update_end(&ring->stats.syncp);
 	return NETDEV_TX_OK;
 }
 
@@ -363,10 +366,19 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	txq = txring_txq(nv->napi.dev, ring);
 
 	if (unlikely(discard)) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.dropped += total_packets;
+		u64_stats_update_end(&ring->stats.syncp);
+
 		netdev_tx_completed_queue(txq, total_packets, total_bytes);
 		return;
 	}
 
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.bytes += total_bytes;
+	ring->stats.packets += total_packets;
+	u64_stats_update_end(&ring->stats.syncp);
+
 	netif_txq_completed_wake(txq, total_packets, total_bytes,
 				 fbnic_desc_unused(ring),
 				 FBNIC_TX_DESC_WAKEUP);
@@ -730,12 +742,12 @@ static bool fbnic_rcd_metadata_err(u64 rcd)
 static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
+	unsigned int packets = 0, bytes = 0, dropped = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	s32 head0 = -1, head1 = -1;
 	__le64 *raw_rcd, done;
 	u32 head = rcq->head;
-	u64 packets = 0;
 
 	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
 	raw_rcd = &rcq->desc[head & rcq->size_mask];
@@ -780,9 +792,11 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				fbnic_populate_skb_fields(nv, rcd, skb, qt);
 
 				packets++;
+				bytes += skb->len;
 
 				napi_gro_receive(&nv->napi, skb);
 			} else {
+				dropped++;
 				fbnic_put_pkt_buff(nv, pkt, 1);
 			}
 
@@ -799,6 +813,14 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 		}
 	}
 
+	u64_stats_update_begin(&rcq->stats.syncp);
+	rcq->stats.packets += packets;
+	rcq->stats.bytes += bytes;
+	/* Re-add ethernet header length (removed in fbnic_build_skb) */
+	rcq->stats.bytes += ETH_HLEN * packets;
+	rcq->stats.dropped += dropped;
+	u64_stats_update_end(&rcq->stats.syncp);
+
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
 		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
@@ -865,12 +887,36 @@ static irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
+					     struct fbnic_ring *rxr)
+{
+	struct fbnic_queue_stats *stats = &rxr->stats;
+
+	/* Capture stats from queues before dissasociating them */
+	fbn->rx_stats.bytes += stats->bytes;
+	fbn->rx_stats.packets += stats->packets;
+	fbn->rx_stats.dropped += stats->dropped;
+}
+
+static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
+					     struct fbnic_ring *txr)
+{
+	struct fbnic_queue_stats *stats = &txr->stats;
+
+	/* Capture stats from queues before dissasociating them */
+	fbn->tx_stats.bytes += stats->bytes;
+	fbn->tx_stats.packets += stats->packets;
+	fbn->tx_stats.dropped += stats->dropped;
+}
+
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
 				 struct fbnic_ring *txr)
 {
 	if (!(txr->flags & FBNIC_RING_F_STATS))
 		return;
 
+	fbnic_aggregate_ring_tx_counters(fbn, txr);
+
 	/* Remove pointer to the Tx ring */
 	WARN_ON(fbn->tx[txr->q_idx] && fbn->tx[txr->q_idx] != txr);
 	fbn->tx[txr->q_idx] = NULL;
@@ -882,6 +928,8 @@ static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
 	if (!(rxr->flags & FBNIC_RING_F_STATS))
 		return;
 
+	fbnic_aggregate_ring_rx_counters(fbn, rxr);
+
 	/* Remove pointer to the Rx ring */
 	WARN_ON(fbn->rx[rxr->q_idx] && fbn->rx[rxr->q_idx] != rxr);
 	fbn->rx[rxr->q_idx] = NULL;
@@ -974,6 +1022,7 @@ static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
 static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 			    int q_idx, u8 flags)
 {
+	u64_stats_init(&ring->stats.syncp);
 	ring->doorbell = doorbell;
 	ring->q_idx = q_idx;
 	ring->flags = flags;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 4a206c0e7192..2f91f68d11d5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <net/xdp.h>
 
 struct fbnic_net;
@@ -51,6 +52,13 @@ struct fbnic_pkt_buff {
 	u16 nr_frags;
 };
 
+struct fbnic_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 dropped;
+	struct u64_stats_sync syncp;
+};
+
 /* Pagecnt bias is long max to reserve the last bit to catch overflow
  * cases where if we overcharge the bias it will flip over to be negative.
  */
@@ -77,6 +85,8 @@ struct fbnic_ring {
 
 	u32 head, tail;			/* Head/Tail of ring */
 
+	struct fbnic_queue_stats stats;
+
 	/* Slow path fields follow */
 	dma_addr_t dma;			/* Phys addr of descriptor memory */
 	size_t size;			/* Size of descriptor ring in memory */
-- 
2.46.0


