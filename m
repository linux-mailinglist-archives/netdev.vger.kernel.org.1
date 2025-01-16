Return-Path: <netdev+bounces-159105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7EA14676
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C04164520
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044A15747D;
	Thu, 16 Jan 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQQ/3eoS"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9B246EA1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070218; cv=none; b=V5q0XEMa56YTgqu++cdM83P7NkFv5BhjSpHmwPpye+FVL3wAwh3mD69ZGfU9uf6eaEXoE3qgmgQcBIXU8Sih8gefh1K7u29WFKw6kDm1V/ZRWDbekhFpsgINhkYw9PSLcEu1C18DEutb1z+WU0XD2YK0Q8jRou8H2d0xYePAXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070218; c=relaxed/simple;
	bh=Ngn5ZMkiMaJgpRZsiBml+Sv1e4CI0d5Dt0i3HXPSJc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SP/Ycg7Lnj9uH2DDUKA1aoAuzt8bty9aB+kZMgHBYdGMryJGAgObWsDM0HYh5mQtcdmMczEToxub9u5SDmyVSpg0ObWGrYBHI56gFvNSjziVTQjDgs11LuOSimeXySaaoNXvfERpWLXpYPR5UOpAAgFSlvsnmrlfUJGDZUwIyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQQ/3eoS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737070213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55J01E329TXRmj1UViL/WOqrMkw+tg1U5LpWXUjCkj0=;
	b=bQQ/3eoSbxxPFVdRDKKOmXXYSJVlChIdf3j6CslzgdOmX+JBqma2PvPbsu7RXgWmgzugWs
	87mCSenhxXOmYAOwQNedzWqNVwzzj1/QEepfj7hd7vJrigS4OKSYfEoc34dOInCiYZmOII
	lPWxiwopCxY1dFeQSE/qReCgxZ/kB9o=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 5/6] net: xilinx: axienet: Get coalesce parameters from driver state
Date: Thu, 16 Jan 2025 18:29:53 -0500
Message-Id: <20250116232954.2696930-6-sean.anderson@linux.dev>
In-Reply-To: <20250116232954.2696930-1-sean.anderson@linux.dev>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cr variables now contain the same values as the control registers
themselves. Extract/calculate the values from the variables instead of
saving the user-specified values. This allows us to remove some
bookeeping, and also lets the user know what the actual coalesce
settings are.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
---

(no changes since v2)

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  8 ---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 70 +++++++++++++------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 6b8e550c2155..45d8d80dbb1a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -533,10 +533,6 @@ struct skbuf_dma_descriptor {
  *		  supported, the maximum frame size would be 9k. Else it is
  *		  1522 bytes (assuming support for basic VLAN)
  * @rxmem:	Stores rx memory size for jumbo frame handling.
- * @coalesce_count_rx:	Store the irq coalesce on RX side.
- * @coalesce_usec_rx:	IRQ coalesce delay for RX
- * @coalesce_count_tx:	Store the irq coalesce on TX side.
- * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
  * @tx_chan:	TX DMA channel.
  * @rx_chan:	RX DMA channel.
@@ -615,10 +611,6 @@ struct axienet_local {
 	u32 max_frm_size;
 	u32 rxmem;
 
-	u32 coalesce_count_rx;
-	u32 coalesce_usec_rx;
-	u32 coalesce_count_tx;
-	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
 	struct dma_chan *tx_chan;
 	struct dma_chan *rx_chan;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b70e65757454..81224b672eb0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -223,6 +223,13 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			  lp->rx_bd_p);
 }
 
+static u64 axienet_dma_rate(struct axienet_local *lp)
+{
+	if (lp->axi_clk)
+		return clk_get_rate(lp->axi_clk);
+	return 125000000; /* arbitrary guess if no clock rate set */
+}
+
 /**
  * axienet_calc_cr() - Calculate control register value
  * @lp: Device private data
@@ -242,12 +249,9 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 	 * the first packet. Otherwise leave at 0 to disable delay interrupt.
 	 */
 	if (count > 1) {
-		u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+		u64 clk_rate = axienet_dma_rate(lp);
 		u32 timer;
 
-		if (lp->axi_clk)
-			clk_rate = clk_get_rate(lp->axi_clk);
-
 		/* 1 Timeout Interval = 125 * (clock period of SG clock) */
 		timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
 						XAXIDMA_DELAY_SCALE);
@@ -260,6 +264,23 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 	return cr;
 }
 
+/**
+ * axienet_cr_params() - Extract coalesce parameters from the CR
+ * @lp: Device private data
+ * @cr: The control register to parse
+ * @count: Number of packets before an interrupt
+ * @usec: Idle time (in usec) before an interrupt
+ */
+static void axienet_coalesce_params(struct axienet_local *lp, u32 cr,
+				    u32 *count, u32 *usec)
+{
+	u64 clk_rate = axienet_dma_rate(lp);
+	u64 timer = FIELD_GET(XAXIDMA_DELAY_MASK, cr);
+
+	*count = FIELD_GET(XAXIDMA_COALESCE_MASK, cr);
+	*usec = DIV64_U64_ROUND_CLOSEST(timer * XAXIDMA_DELAY_SCALE, clk_rate);
+}
+
 /**
  * axienet_dma_start - Set up DMA registers and start DMA operation
  * @lp:		Pointer to the axienet_local structure
@@ -2104,11 +2125,21 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	u32 cr;
 
-	ecoalesce->rx_max_coalesced_frames = lp->coalesce_count_rx;
-	ecoalesce->rx_coalesce_usecs = lp->coalesce_usec_rx;
-	ecoalesce->tx_max_coalesced_frames = lp->coalesce_count_tx;
-	ecoalesce->tx_coalesce_usecs = lp->coalesce_usec_tx;
+	spin_lock_irq(&lp->rx_cr_lock);
+	cr = lp->rx_dma_cr;
+	spin_unlock_irq(&lp->rx_cr_lock);
+	axienet_coalesce_params(lp, cr,
+				&ecoalesce->rx_max_coalesced_frames,
+				&ecoalesce->rx_coalesce_usecs);
+
+	spin_lock_irq(&lp->tx_cr_lock);
+	cr = lp->tx_dma_cr;
+	spin_unlock_irq(&lp->tx_cr_lock);
+	axienet_coalesce_params(lp, cr,
+				&ecoalesce->tx_max_coalesced_frames,
+				&ecoalesce->tx_coalesce_usecs);
 	return 0;
 }
 
@@ -2155,15 +2186,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
-	lp->coalesce_usec_rx = ecoalesce->rx_coalesce_usecs;
-	lp->coalesce_count_tx = ecoalesce->tx_max_coalesced_frames;
-	lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
-
-	cr = axienet_calc_cr(lp, lp->coalesce_count_rx, lp->coalesce_usec_rx);
+	cr = axienet_calc_cr(lp, ecoalesce->rx_max_coalesced_frames,
+			     ecoalesce->rx_coalesce_usecs);
 	axienet_update_coalesce_rx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
 
-	cr = axienet_calc_cr(lp, lp->coalesce_count_tx, lp->coalesce_usec_tx);
+	cr = axienet_calc_cr(lp, ecoalesce->tx_max_coalesced_frames,
+			     ecoalesce->tx_coalesce_usecs);
 	axienet_update_coalesce_tx(lp, cr, ~XAXIDMA_CR_RUNSTOP_MASK);
 	return 0;
 }
@@ -2946,14 +2974,10 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
-	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
-	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
-	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
-	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
-	lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
-					lp->coalesce_usec_rx);
-	lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
-					lp->coalesce_usec_tx);
+	lp->rx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_RX_THRESHOLD,
+					XAXIDMA_DFT_RX_USEC);
+	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
+					XAXIDMA_DFT_TX_USEC);
 
 	ret = axienet_mdio_setup(lp);
 	if (ret)
-- 
2.35.1.1320.gc452695387.dirty


