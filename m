Return-Path: <netdev+bounces-116961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5494C360
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6FA1F22B84
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91119067A;
	Thu,  8 Aug 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1voQ1ud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE6190676
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136973; cv=none; b=nrDKkvD7y1LIg7SRdHV9WaHCIn3zYQU9wLQveyx04cylGVqAR7zxxTP/TQg+Af3gbdPENmBi6H3bC5KBx5/rDJETCEwYgANiPhFRk5Kg8oQqx8oa3YgUdseloPWh7bsMWGqCTeQtxdf+2KbkGo3kOOK/Vw4lgDNu1mEE5DGZ+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136973; c=relaxed/simple;
	bh=c+l7O2ABusMiC77vOzlO1yAGb7nzBwwN1YL/ywP5w2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHv3lt/dJKmHPbzQQE24LwIYuxI/qf3oiQ52N+bhw+nJhYuiNqfPSW+ZMZRG21BrF7A3+T43giRCJ+2yGffuEwp5mNP2W3UjQPMbb8QG/kb1NFq69XyoutT6rLx5He08NrRFXAp7dqvAR1CdZYZy8uLgq0cA7qYKBFK9tEfx6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1voQ1ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7BBC4AF0D;
	Thu,  8 Aug 2024 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723136973;
	bh=c+l7O2ABusMiC77vOzlO1yAGb7nzBwwN1YL/ywP5w2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1voQ1udamvEJOrk8jK8Z6wLfm8bcgEisRIDgN6hz4JaBTs/CyURgkoNgw0pcham3
	 z/6WVXOYLZHZ9DVM+ryxNKIGq26+tPCWeF2njEWNIwk/02LMW81mM5zPi5c28DVM/q
	 1kAqGUJTAySl5TgneI+6ZzybXirKn3T2/898cUpgmlxN9DoVZaO1mh+GM0f+kVRQDR
	 5aHcBbrYyDhPNuVErEQ7umDY2Z8mCSxG2RjF3dwZ78pJcayFjXgfZ4zruQKGcmELvM
	 yQdlh3Zh39vAxgTch9+gwECHjPzp4rUg1qrU7PLKxbVs9NoI7pUKIWcecDQWBRjZah
	 whyENrXetKVlw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] eth: fbnic: add basic rtnl stats
Date: Thu,  8 Aug 2024 10:09:14 -0700
Message-ID: <20240808170915.2114410-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808170915.2114410-1-kuba@kernel.org>
References: <20240808170915.2114410-1-kuba@kernel.org>
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
v2:
 - drop duplicated check
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 69 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 50 +++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  | 10 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

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
index 0ed4c9fff5d8..63d8c31da31d 100644
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


