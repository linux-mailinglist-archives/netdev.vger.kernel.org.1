Return-Path: <netdev+bounces-172237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4BA50F1C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD1818930F7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1686E20A5C2;
	Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhRf22fl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2E209684
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215154; cv=none; b=Y1UPbAIYuxn8ZznKfxJ0qkPkPNun4TGsFckKTwmE3zSoux/NAaXrB9uhzEcYsVmQHoKPk0KNZuS+V5dEN+g93AXFf+aQziLDQiUPrKo8kbgGeVghDjjOkDtuqdFktSE3QrHbj02lWC6pGnSz5J18SPDUQTJQ2o7i/Z0bdzPHRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215154; c=relaxed/simple;
	bh=mn1Be16fzDSwbQI6VkqqgHlKFNjuHngeyCHLUcGNyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJsn90nGive7rNQIpfWW5pZE4IlXPoEP355hk0IlLVhaoo5aKT1EmOrx4bksVWvr0SCLotIKW5zixa72vsVGRp6uzftVRUBrRZQqXhO5q/PD4IJ5TjPnYzGDCNhN4v0Mm1/l4nsqC2NNWGBtXarXOasIXLE+EdTEi7t5g0iHg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhRf22fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E638C4CED1;
	Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215153;
	bh=mn1Be16fzDSwbQI6VkqqgHlKFNjuHngeyCHLUcGNyTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhRf22flosiYeiaoZcedpjBJFoq7MtE8dbSQk9Nmm6UZW71OaLuRUCWBWzYS1m5jF
	 nKAki7KH8BN5LLnaHY39NqSz0Kayda7ZTyXNcFlHJlpJqWLQsd8jYS7yWVIepJJp6H
	 i4IG+m6v9hiev9UkRs6cKPxW7VySOrhegG7NpqfDnWwwJ3rp7xqG3NZGq+lfZU80A4
	 zCACzW33PDFQehO03Xhc1aP2BFoummeS5bXAYHmKH9/HEZTZK5Ly9SDT951xv/a45M
	 Nm5+C69lURiSVdZBTYsYuR+qX1Z3TQyTYw41onWh+pHCeZR1RTObpfRU15EnFVEI7x
	 vgvr1zWyTXgcg==
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
Subject: [PATCH net-next v3 03/10] eth: bnxt: rename ring_err_stats -> ring_drv_stats
Date: Wed,  5 Mar 2025 14:52:08 -0800
Message-ID: <20250305225215.1567043-4-kuba@kernel.org>
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

We will soon store non-error stats to the ring struct.
Rename them to "drv" stats, as these are all maintained
by the driver (even if partially based on info from descriptors).

Pure rename using sed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 14 ++++++-------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 20 +++++++++----------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e85b5ce94f58..34f23ddd4d71 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1136,7 +1136,7 @@ struct bnxt_sw_stats {
 	struct bnxt_cmn_sw_stats cmn;
 };
 
-struct bnxt_total_ring_err_stats {
+struct bnxt_total_ring_drv_stats {
 	u64			rx_total_l4_csum_errors;
 	u64			rx_total_resets;
 	u64			rx_total_buf_errors;
@@ -2538,7 +2538,7 @@ struct bnxt {
 	u8			pri2cos_idx[8];
 	u8			pri2cos_valid;
 
-	struct bnxt_total_ring_err_stats ring_err_stats_prev;
+	struct bnxt_total_ring_drv_stats ring_drv_stats_prev;
 
 	u16			hwrm_max_req_len;
 	u16			hwrm_max_ext_req_len;
@@ -2936,8 +2936,8 @@ int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
 void bnxt_reenable_sriov(struct bnxt *bp);
 void bnxt_close_nic(struct bnxt *, bool, bool);
-void bnxt_get_ring_err_stats(struct bnxt *bp,
-			     struct bnxt_total_ring_err_stats *stats);
+void bnxt_get_ring_drv_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_drv_stats *stats);
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 94bc9121d3f9..4b85f224c344 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12941,7 +12941,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	/* Save ring stats before shutdown */
 	if (bp->bnapi && irq_re_init) {
 		bnxt_get_ring_stats(bp, &bp->net_stats_prev);
-		bnxt_get_ring_err_stats(bp, &bp->ring_err_stats_prev);
+		bnxt_get_ring_drv_stats(bp, &bp->ring_drv_stats_prev);
 	}
 	if (irq_re_init) {
 		bnxt_free_irq(bp);
@@ -13191,8 +13191,8 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	clear_bit(BNXT_STATE_READ_STATS, &bp->state);
 }
 
-static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
-					struct bnxt_total_ring_err_stats *stats,
+static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
+					struct bnxt_total_ring_drv_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
@@ -13211,13 +13211,13 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 	stats->total_missed_irqs += sw_stats->cmn.missed_irqs;
 }
 
-void bnxt_get_ring_err_stats(struct bnxt *bp,
-			     struct bnxt_total_ring_err_stats *stats)
+void bnxt_get_ring_drv_stats(struct bnxt *bp,
+			     struct bnxt_total_ring_drv_stats *stats)
 {
 	int i;
 
 	for (i = 0; i < bp->cp_nr_rings; i++)
-		bnxt_get_one_ring_err_stats(bp, stats, &bp->bnapi[i]->cp_ring);
+		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
 }
 
 static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
@@ -15643,7 +15643,7 @@ static void bnxt_get_base_stats(struct net_device *dev,
 
 	rx->packets = bp->net_stats_prev.rx_packets;
 	rx->bytes = bp->net_stats_prev.rx_bytes;
-	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
+	rx->alloc_fail = bp->ring_drv_stats_prev.rx_total_oom_discards;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
 	tx->bytes = bp->net_stats_prev.tx_bytes;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c5820839514..023a0c2d52fd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -340,7 +340,7 @@ enum {
 	RX_NETPOLL_DISCARDS,
 };
 
-static const char *const bnxt_ring_err_stats_arr[] = {
+static const char *const bnxt_ring_drv_stats_arr[] = {
 	"rx_total_l4_csum_errors",
 	"rx_total_resets",
 	"rx_total_buf_errors",
@@ -500,7 +500,7 @@ static const struct {
 	BNXT_TX_STATS_PRI_ENTRIES(tx_packets),
 };
 
-#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_err_stats_arr)
+#define BNXT_NUM_RING_DRV_STATS	ARRAY_SIZE(bnxt_ring_drv_stats_arr)
 #define BNXT_NUM_PORT_STATS ARRAY_SIZE(bnxt_port_stats_arr)
 #define BNXT_NUM_STATS_PRI			\
 	(ARRAY_SIZE(bnxt_rx_bytes_pri_arr) +	\
@@ -539,7 +539,7 @@ static int bnxt_get_num_stats(struct bnxt *bp)
 	int num_stats = bnxt_get_num_ring_stats(bp);
 	int len;
 
-	num_stats += BNXT_NUM_RING_ERR_STATS;
+	num_stats += BNXT_NUM_RING_DRV_STATS;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS)
 		num_stats += BNXT_NUM_PORT_STATS;
@@ -594,7 +594,7 @@ static bool is_tx_ring(struct bnxt *bp, int ring_num)
 static void bnxt_get_ethtool_stats(struct net_device *dev,
 				   struct ethtool_stats *stats, u64 *buf)
 {
-	struct bnxt_total_ring_err_stats ring_err_stats = {0};
+	struct bnxt_total_ring_drv_stats ring_drv_stats = {0};
 	struct bnxt *bp = netdev_priv(dev);
 	u64 *curr, *prev;
 	u32 tpa_stats;
@@ -643,12 +643,12 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 			buf[j] = sw[k];
 	}
 
-	bnxt_get_ring_err_stats(bp, &ring_err_stats);
+	bnxt_get_ring_drv_stats(bp, &ring_drv_stats);
 
 skip_ring_stats:
-	curr = &ring_err_stats.rx_total_l4_csum_errors;
-	prev = &bp->ring_err_stats_prev.rx_total_l4_csum_errors;
-	for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
+	curr = &ring_drv_stats.rx_total_l4_csum_errors;
+	prev = &bp->ring_drv_stats_prev.rx_total_l4_csum_errors;
+	for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++, j++, curr++, prev++)
 		buf[j] = *curr + *prev;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS) {
@@ -752,8 +752,8 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 				ethtool_sprintf(&buf, "[%d]: %s", i, str);
 			}
 		}
-		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++)
-			ethtool_puts(&buf, bnxt_ring_err_stats_arr[i]);
+		for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++)
+			ethtool_puts(&buf, bnxt_ring_drv_stats_arr[i]);
 
 		if (bp->flags & BNXT_FLAG_PORT_STATS)
 			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
-- 
2.48.1


