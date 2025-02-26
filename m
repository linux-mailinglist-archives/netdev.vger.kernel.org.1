Return-Path: <netdev+bounces-170004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3AEA46D1C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F1716BBE8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4C25D558;
	Wed, 26 Feb 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr0Q2MuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A625D54A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604222; cv=none; b=MH8OPCQ+cwq1frE4BfpXpN95/BN7Y6e0lBxJWyVj3pAlg1+fZE5Le8vFTKPwEESSGBN+MW8htk8e4/b9W0WxUheroAYWXQgJgiT0T2HyKX5h2ol5dt895UxbTFL9+z2YnWqiGcCKSGK+BFoDiWp+/CHEDyKidSMCj8p9hCT7gPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604222; c=relaxed/simple;
	bh=B4NtmXfwn2HYA6yKWxEH+06tIkcoujNoYN6GOXvUlEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv8yw4XW2OEr1wP4hWc129bIEBtEbKN2gZtKj38Y9i1vXzkV+clbrlmIA1whomASlLlEkGCivi+/B8zcI5Q1Y+Zpf4ON4z7PDOw7D1Q66GmEL1bFJmEdlGHYyUCtguqL3WElGmk0MGvJPMgc7BOvmEwnL6kwPjIVnVKXRQTrcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr0Q2MuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45FFC4CEEB;
	Wed, 26 Feb 2025 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604222;
	bh=B4NtmXfwn2HYA6yKWxEH+06tIkcoujNoYN6GOXvUlEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nr0Q2MuBe+sLse7Cz6+FbibM67tfZSsMtD5nCwYEB9dQbVvLNZ37+4s2zoe+N5b14
	 Zr2jX2TVH0lvcH6fm5k3/dDXXGMZ9r3JGk2mMiO1jxOYMlz05Y2ru5xNniZC/yx1BJ
	 ShYnzisjqG3q/CPAyL14g5kExymbV4Mv5oxoDxdn3tbBmrmwbrUUz4eur0VMvjLtw/
	 CmN42PvvKcHpyG7ffu+kzx52wmYh0hwiHGqKySGUfj8xuaosMhnE7eTA5T19rJVKFA
	 hXhINtIlk6fkzj/bezlcKEt7bF7kIvvaiutpWKLXG/x7juRy6XlKsyTdQbRwSMa4r0
	 udbUngZtmidjA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 9/9] eth: bnxt: count xdp xmit packets
Date: Wed, 26 Feb 2025 13:10:03 -0800
Message-ID: <20250226211003.2790916-10-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211003.2790916-1-kuba@kernel.org>
References: <20250226211003.2790916-1-kuba@kernel.org>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 15 ++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e542e39bf84c..6db34f8b8fa6 100644
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
index 19f823f1079b..ca68f677368e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13181,6 +13181,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 
 		stats->tx_packets += sw_stats.tx.tx_packets;
 		stats->tx_bytes += sw_stats.tx.tx_bytes;
+		stats->tx_packets += sw_stats.tx.xdp_packets;
+		stats->tx_bytes += sw_stats.tx.xdp_bytes;
 
 		stats->rx_missed_errors +=
 			BNXT_GET_RING_STATS64(sw, rx_discard_pkts);
@@ -13272,8 +13274,9 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
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
@@ -15698,6 +15701,7 @@ static void bnxt_get_base_stats(struct net_device *dev,
 				struct netdev_queue_stats_tx *tx)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	int i;
 
 	rx->packets = bp->ring_drv_stats_prev.rx_total_packets;
 	rx->bytes = bp->ring_drv_stats_prev.rx_total_bytes;
@@ -15705,6 +15709,21 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
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
index e6c64e4bd66c..d4cd36f227b9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -38,6 +38,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 	if (xdp && xdp_buff_has_frags(xdp)) {
 		sinfo = xdp_get_shared_info_from_buff(xdp);
 		num_frags = sinfo->nr_frags;
+		tx_buf->xdp_len += sinfo->xdp_frags_size;
 	}
 
 	/* fill up the first buffer */
@@ -47,6 +48,8 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 	if (xdp)
 		tx_buf->page = virt_to_head_page(xdp->data);
 
+	tx_buf->xdp_len += len;
+
 	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 	flags = (len << TX_BD_LEN_SHIFT) |
 		((num_frags + 1) << TX_BD_FLAGS_BD_CNT_SHIFT) |
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


