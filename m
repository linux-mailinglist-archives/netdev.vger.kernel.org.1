Return-Path: <netdev+bounces-163662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AAA2B31C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460F73A993A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B31D5AC0;
	Thu,  6 Feb 2025 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJ6R/cJQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8421D5165
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872685; cv=none; b=KoE5m4fp1ACoTCuP0dUe0ORaKgyozsY3TuKyW6VovA/hzfCz4DJVafDp48VP9xGyGV5AAu+r/Mtvzz74MQvpEDPd1+ueTM+T0N03OxdYOwYLIojThGVbZ4WNfgAzYAzFm7dq2pveoGgaIRcv71p0Gu5HSp2XetoU011BDR4ZLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872685; c=relaxed/simple;
	bh=CWQQYip21k7ALCETR2uDTeI76+qU+2vSgYf2Ypq00oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=de/J8yj6jwjugDbZQsdu7dpDn+ZAV7kKhw7Etr4wHhKGInmHide0m10Qmm3kzjsi+RF+a/IQibS+gMj5FsszKd+bhsrWuZDsH/xFTXAGvH9NhFCyqR4FxNn2UwqiclqCPwKOMtPkpwNhGzLWCQ+B7ESkPA4dbZ3apiXnVnJ9by4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJ6R/cJQ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738872676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nY3p+aMLuibMZvnwQkFhxNfBChj+BrcxAbD7Pwa83c=;
	b=IJ6R/cJQTt/Tf/ohmHhdZmhrvUABOeNj64RSy9qhLvvwMhak9RT6oUz84l+VfvG0n16Z8w
	5Y29gAbL+0mWFgDjrTx7V/UIrALcjq85vNdRIp42wFYbXun5/lyr0fwLwUuRmqivNmSNeq
	DgtHhfNVmb40zGYJJ7nRjHrKEv+5cmo=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v5 3/4] net: xilinx: axienet: Get coalesce parameters from driver state
Date: Thu,  6 Feb 2025 15:10:35 -0500
Message-Id: <20250206201036.1516800-4-sean.anderson@linux.dev>
In-Reply-To: <20250206201036.1516800-1-sean.anderson@linux.dev>
References: <20250206201036.1516800-1-sean.anderson@linux.dev>
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

Changes in v5:
- Move axienet_coalesce_params doc fix to correct patch

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
index b70e65757454..da3d4193674e 100644
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
+ * axienet_coalesce_params() - Extract coalesce parameters from the CR
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


