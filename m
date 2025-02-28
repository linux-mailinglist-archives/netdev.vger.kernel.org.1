Return-Path: <netdev+bounces-170490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA278A48DE9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DF716EC6D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C615A864;
	Fri, 28 Feb 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOfVNy+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A1586C8
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705943; cv=none; b=r1UhfhHqJXd+kfFJPPyKG77HPQmgDDNoPRfCm83kIrS8OmJBEOrf4QxLwS/ei+WSqkWQrq9OAg/lVl0EPJWcvlJu1v+TnXQltZUu5mx3ppgLKfw9GSmJlbmKhHshZZaQSVRffiX9+3aRWisqDk1H+xqZ6BDCsSf+N4IvJ1fLUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705943; c=relaxed/simple;
	bh=zmgD7sv0H7HkTZaB19WsbIXaPUAL5eLTxdLW8zBya2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ/w65v4X17QWtmAkKu9p5yAqQIfVybRKuz8+LHOYmdVX/QQKF7Kk4ShVtS4eimVhfg82BB9j3zhJgErAl2uwAggqhEsSMpq9seoc8vAaMYlqR+v/hzI1U8/xsCMGH+k6r1cx0adpvdTmyFcd5XyCcTiE3cJFeKj6E9Fwxptw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOfVNy+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B360C4CEE8;
	Fri, 28 Feb 2025 01:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705942;
	bh=zmgD7sv0H7HkTZaB19WsbIXaPUAL5eLTxdLW8zBya2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOfVNy+i6SDCwVU/AfHnq5/FLQ+1w3MrV3VscvsrT6ZY2KaqxJHuITv7fkhl9O0EG
	 DtE1FTJVm0iAcvnhHN4UJsjBkmL9XZB/eHjLUfBJFfOJI9l62TgfipVRgdGt4uu+R1
	 ubwaAhZrSCUw/caWrz3fFK4ntDX26n0IeBokvfVnX/g0aSmqHGAPw8TOsG+zp24voy
	 tSg2OXtnajDL18cMZgqGmreG/7hbv2TrPx2qLazXiUAebsiIXneyqVkHa9jZaEMVZM
	 7WusQOqMkahuYvEu789z25CW6A3WlSl8S5HHxKz8nLAG6JPsZDKRN772libEluym+D
	 bqv7KztaO9mOA==
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
Subject: [PATCH net-next v2 9/9] eth: bnxt: count xdp xmit packets
Date: Thu, 27 Feb 2025 17:25:34 -0800
Message-ID: <20250228012534.3460918-10-kuba@kernel.org>
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

Count XDP_TX and XDP_REDIRECT packets. Since the Tx rings are separate
we count the packets sent to the base stats, not per-queues stats.

The XDP stats are protected by the Rx syncp since they are in NAPI
context. Feels slightly less ugly than having a Tx stats in Rx struct.
But neither is ideal.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move tx_buf init sooner so that shinfo handling can access it
v1: https://lore.kernel.org/20250226211003.2790916-10-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 25 +++++++++++++++----
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d5f617fd5beb..415dda512329 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -880,7 +880,10 @@ struct bnxt_sw_tx_bd {
 	struct page		*page;
 	DEFINE_DMA_UNMAP_ADDR(mapping);
 	DEFINE_DMA_UNMAP_LEN(len);
-	u16			extra_segs;
+	union {
+		u16			extra_segs;
+		u16			xdp_len;
+	};
 	u8			hdr_size;
 	u8			is_ts_pkt;
 	u8			is_push;
@@ -1134,6 +1137,8 @@ struct bnxt_tx_sw_stats {
 	/* non-ethtool stats follow */
 	u64			tx_packets;
 	u64			tx_bytes;
+	u64			xdp_packets; /* under rx syncp */
+	u64			xdp_bytes;  /* under rx syncp */
 	struct u64_stats_sync	syncp;
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f6308e4e8360..7dbb940c0591 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13160,6 +13160,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 
 		stats->tx_packets += sw_stats.tx.tx_packets;
 		stats->tx_bytes += sw_stats.tx.tx_bytes;
+		stats->tx_packets += sw_stats.tx.xdp_packets;
+		stats->tx_bytes += sw_stats.tx.xdp_bytes;
 
 		stats->rx_missed_errors +=
 			BNXT_GET_RING_STATS64(sw, rx_discard_pkts);
@@ -13251,8 +13253,9 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
 	stats->rx_total_bytes += sw_stats.rx.rx_bytes;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
-	stats->tx_total_packets += sw_stats.tx.tx_packets;
-	stats->tx_total_bytes += sw_stats.tx.tx_bytes;
+	stats->tx_total_packets +=
+		sw_stats.tx.tx_packets + sw_stats.tx.xdp_packets;
+	stats->tx_total_bytes += sw_stats.tx.tx_bytes + sw_stats.tx.xdp_bytes;
 	stats->tx_total_resets += sw_stats.tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
@@ -15677,6 +15680,7 @@ static void bnxt_get_base_stats(struct net_device *dev,
 				struct netdev_queue_stats_tx *tx)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	int i;
 
 	rx->packets = bp->ring_drv_stats_prev.rx_total_packets;
 	rx->bytes = bp->ring_drv_stats_prev.rx_total_bytes;
@@ -15684,6 +15688,21 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
 	tx->packets = bp->ring_drv_stats_prev.tx_total_packets;
 	tx->bytes = bp->ring_drv_stats_prev.tx_total_bytes;
+
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		struct bnxt_sw_stats *sw_stats = bp->bnapi[i]->cp_ring.sw_stats;
+		unsigned int seq;
+		u64 pkts, bytes;
+
+		do {
+			seq = u64_stats_fetch_begin(&sw_stats->rx.syncp);
+			pkts = sw_stats->tx.xdp_packets;
+			bytes = sw_stats->tx.xdp_bytes;
+		} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq));
+
+		tx->packets += pkts;
+		tx->bytes += bytes;
+	}
 }
 
 static const struct netdev_stat_ops bnxt_stat_ops = {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 16d3698cf0e9..644e4a7818a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -35,14 +35,17 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 	u16 prod;
 	int i;
 
-	if (xdp && xdp_buff_has_frags(xdp)) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		num_frags = sinfo->nr_frags;
-	}
-
 	/* fill up the first buffer */
 	prod = txr->tx_prod;
 	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+	tx_buf->xdp_len = len;
+
+	if (xdp && xdp_buff_has_frags(xdp)) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		tx_buf->xdp_len += sinfo->xdp_frags_size;
+		num_frags = sinfo->nr_frags;
+	}
+
 	tx_buf->nr_frags = num_frags;
 	if (xdp)
 		tx_buf->page = virt_to_head_page(xdp->data);
@@ -120,9 +123,11 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
+	struct bnxt_sw_stats *sw_stats = bnapi->cp_ring.sw_stats;
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring[0];
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	u16 tx_hw_cons = txr->tx_hw_cons;
+	unsigned int pkts = 0, bytes = 0;
 	bool rx_doorbell_needed = false;
 	struct bnxt_sw_tx_bd *tx_buf;
 	u16 tx_cons = txr->tx_cons;
@@ -135,6 +140,10 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 	while (RING_TX(bp, tx_cons) != tx_hw_cons) {
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, tx_cons)];
 
+		pkts++;
+		bytes += tx_buf->xdp_len;
+		tx_buf->xdp_len = 0;
+
 		if (tx_buf->action == XDP_REDIRECT) {
 			struct pci_dev *pdev = bp->pdev;
 
@@ -163,6 +172,12 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		tx_cons = NEXT_TX(tx_cons);
 	}
 
+	/* Note: Rx sync here, because Rx == NAPI context */
+	u64_stats_update_begin(&sw_stats->rx.syncp);
+	sw_stats->tx.xdp_packets += pkts;
+	sw_stats->tx.xdp_bytes += bytes;
+	u64_stats_update_end(&sw_stats->rx.syncp);
+
 	bnapi->events &= ~BNXT_TX_CMP_EVENT;
 	WRITE_ONCE(txr->tx_cons, tx_cons);
 	if (rx_doorbell_needed) {
-- 
2.48.1


