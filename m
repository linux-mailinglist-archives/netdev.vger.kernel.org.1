Return-Path: <netdev+bounces-172244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26051A50F24
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21551893067
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D164B2673BA;
	Wed,  5 Mar 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN96gt3e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EE2673A7
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215156; cv=none; b=ELdw2Rz+yFGhSwKHhyQjEsy/D2dVd3e/1UP8RNNSC974ZO/cChuFqx9Dz7+cWqvvAsRnTfsnBP1VZ4FBADOK0FlgeAq1l2u/LUt/LY8GE/yV8VVr5ieL6TX0rwvtCABTaeiCieZML6MKYuf0+Vlfu7qvDOpQeQpa4DI88VYpQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215156; c=relaxed/simple;
	bh=CVJuugwiB0UxcgtqChtwDiY+7V4zzsH4jQHsT8AoCpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD/LAxUl1pWoe6WOOwapMMUntMGNLbC1NOO9r79RxFo/oPPaOW8enIypBfsXpe1dNmwXVFQShs1ZC8U/32OVJ25TYNCSKEQ30P5A6LqbNxH9FhyHxX9eJhynbRwwYPSryZkqYS9AJJeJB2uXwdo3tvoyCGMe4+nsHYCxseYz7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN96gt3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A315C4CEEE;
	Wed,  5 Mar 2025 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215156;
	bh=CVJuugwiB0UxcgtqChtwDiY+7V4zzsH4jQHsT8AoCpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XN96gt3eMU2P7R0ItPHFg6zSmvS5xu3k8Y+PaT6kV2IJnmzFreQPeM0LX0Ez1LSkb
	 nxRDpCDjLwftHVtL96rx5PTTEWrJMG4tKcNpP+O/fv9W1sa+gEwAYW6Gpj7pu/OTis
	 RygMOMCjVqbiSoCuflcua82T2xyvAzSlYwoHRj8XYSTRktpFxspY6mhg/Prt8T4fHS
	 T2VPoLi8ggKFjY8GgaTeGP/EbUEuE9hPFkxBjajbjqm3VFqmXHHyA3Kc4A6vNeKy0E
	 X3OCryji4j/AJ7Tph3gEZg+vn/woHoeCvK/GzULlZ0abQ6nCloe2woJmdvGBJEKm9w
	 Ijk9CYJqnU8OQ==
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
Subject: [PATCH net-next v3 10/10] eth: bnxt: count xdp xmit packets
Date: Wed,  5 Mar 2025 14:52:15 -0800
Message-ID: <20250305225215.1567043-11-kuba@kernel.org>
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

Count XDP_TX and XDP_REDIRECT packets. Since the Tx rings are separate
we count the packets sent to the base stats, not per-queues stats.

The XDP stats are protected by the Rx syncp since they are in NAPI
context. Feels slightly less ugly than having a Tx stats in Rx struct.
But neither is ideal.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - count XDP on same members as Tx
v2: https://lore.kernel.org/20250228012534.3460918-10-kuba@kernel.org
 - move tx_buf init sooner so that shinfo handling can access it
v1: https://lore.kernel.org/20250226211003.2790916-10-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  9 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 16 ++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 25 +++++++++++++++----
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 37d7f08a73c3..0e9702871fd3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -881,7 +881,10 @@ struct bnxt_sw_tx_bd {
 	struct page		*page;
 	DEFINE_DMA_UNMAP_ADDR(mapping);
 	DEFINE_DMA_UNMAP_LEN(len);
-	u16			extra_segs;
+	union {
+		u16			extra_segs;
+		u16			xdp_len;
+	};
 	u8			extra_bytes;
 	u8			hdr_size;
 	u8			is_ts_pkt;
@@ -1134,8 +1137,8 @@ struct bnxt_rx_sw_stats {
 struct bnxt_tx_sw_stats {
 	u64			tx_resets;
 	/* non-ethtool stats follow */
-	u64			tx_packets;
-	u64			tx_bytes;
+	u64			tx_packets; /* for XDP_TX, under rx syncp */
+	u64			tx_bytes; /* for XDP_TX, under rx syncp */
 	struct u64_stats_sync	syncp;
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 893102c0d24e..30d2b6b25301 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15685,6 +15685,7 @@ static void bnxt_get_base_stats(struct net_device *dev,
 				struct netdev_queue_stats_tx *tx)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	int i;
 
 	rx->packets = bp->ring_drv_stats_prev.rx_total_packets;
 	rx->bytes = bp->ring_drv_stats_prev.rx_total_bytes;
@@ -15692,6 +15693,21 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
 	tx->packets = bp->ring_drv_stats_prev.tx_total_packets;
 	tx->bytes = bp->ring_drv_stats_prev.tx_total_bytes;
+
+	for (i = 0; i < bp->tx_nr_rings_xdp; i++) {
+		struct bnxt_sw_stats *sw_stats = bp->bnapi[i]->cp_ring.sw_stats;
+		unsigned int seq;
+		u64 pkts, bytes;
+
+		do {
+			seq = u64_stats_fetch_begin(&sw_stats->rx.syncp);
+			pkts = sw_stats->tx.tx_packets;
+			bytes = sw_stats->tx.tx_bytes;
+		} while (u64_stats_fetch_retry(&sw_stats->rx.syncp, seq));
+
+		tx->packets += pkts;
+		tx->bytes += bytes;
+	}
 }
 
 static const struct netdev_stat_ops bnxt_stat_ops = {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index d13c8e06d299..8ab40ae5c443 100644
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
+	sw_stats->tx.tx_packets += pkts;
+	sw_stats->tx.tx_bytes += bytes;
+	u64_stats_update_end(&sw_stats->rx.syncp);
+
 	bnapi->events &= ~BNXT_TX_CMP_EVENT;
 	WRITE_ONCE(txr->tx_cons, tx_cons);
 	if (rx_doorbell_needed) {
-- 
2.48.1


