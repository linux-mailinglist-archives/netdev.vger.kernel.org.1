Return-Path: <netdev+bounces-124692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7996A74E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C281C22F43
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C81CC142;
	Tue,  3 Sep 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xaK9ejtS"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983F187561
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391538; cv=none; b=JOzun92i7cNasKwaUdIc1U6N70kBMsEID/eaWz3lhSVFvv9qmW0km/Oqswx1QkObqtO2j9cx/+S9udrSmcS7Ais4VcjL62HUitUlviz8s1Qv162B+UUEyCquKGKdzC/W5S8FRevlwuwEi5uc1+u98uH1CpBV5igMGefnZPxO3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391538; c=relaxed/simple;
	bh=vCUUmFW48voTltTqDX9MmTFr+MQ5KFv8xbQ8gK/868o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzjqEAPjR9f00+zeRCw7ANH+AW4Lz9SEthypWpvYtfSiCNqE69gA1c8R+r0/aMtkne9A1Fy2zwhM5mPjpDC93FLX5ZY1dnb9W/S2c9MKdU9yTn8yanrdB/tUtsq9w+QA3ihZ2O+0j8UnzUw0tf4nGPt3CPUz12Fz/oNbR6fhSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xaK9ejtS; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725391533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQFTy/5ZCLWlZVC1DKWw6rZjmiG+v1iB8ocS/zQdpGE=;
	b=xaK9ejtS0NU76CLlubKwvB2cROms6TvB3rLFEQZm0SN1N+khpSrxAto5y6itrFBxWRnPNe
	0mViOU6wDr5FtRvCkXZu+OaZBwtkrJVf/4hOrU1EhihXoT54eYp3e7h8zsBb8INYqtNx5W
	c7UymljnZpZm9JCBtCQKdvRj03CUOlc=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 1/2] net: xilinx: axienet: Support adjusting coalesce settings while running
Date: Tue,  3 Sep 2024 15:25:23 -0400
Message-Id: <20240903192524.4158713-2-sean.anderson@linux.dev>
In-Reply-To: <20240903192524.4158713-1-sean.anderson@linux.dev>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation for adaptive IRQ coalescing, we first need to support
adjusting the settings at runtime. The existing code doesn't require any
locking because

- dma_start is the only function that modifies rx/tx_dma_cr. It is
  always called with IRQs and NAPI disabled, so nothing else is touching
  the hardware.
- The IRQs don't race with poll, since the latter is a softirq.
- The IRQs don't race with dma_stop since they both just clear the
  control registers.
- dma_stop doesn't race with poll since the former is called with NAPI
  disabled.

However, once we introduce another function that modifies rx/tx_dma_cr,
we need to have some locking to prevent races. Introduce two locks to
protect these variables and their registers.

The control register values are now generated where the coalescing
settings are set. This is because we need to hold the RTNL when reading
the settings, but axienet_dma_start cannot sleep.

Since axienet_dma_start writes the control settings when it runs, we don't
bother updating the CR registers when rx/tx_dma_started is false. This
prevents any issues from writing to the control registers in the middle
of a reset sequence.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   8 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 187 +++++++++++++-----
 2 files changed, 146 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index c301dd2ee083..66cb8aa5b716 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -484,7 +484,9 @@ struct skbuf_dma_descriptor {
  * @regs:	Base address for the axienet_local device address space
  * @dma_regs:	Base address for the axidma device address space
  * @napi_rx:	NAPI RX control structure
+ * @rx_cr_lock: Lock protecting @rx_dma_cr, its register, and @rx_dma_started
  * @rx_dma_cr:  Nominal content of RX DMA control register
+ * @rx_dma_started: Set when RX DMA is started
  * @rx_bd_v:	Virtual address of the RX buffer descriptor ring
  * @rx_bd_p:	Physical address(start address) of the RX buffer descr. ring
  * @rx_bd_num:	Size of RX buffer descriptor ring
@@ -494,7 +496,9 @@ struct skbuf_dma_descriptor {
  * @rx_bytes:	RX byte count for statistics
  * @rx_stat_sync: Synchronization object for RX stats
  * @napi_tx:	NAPI TX control structure
+ * @tx_cr_lock: Lock protecting @tx_dma_cr, its register, and @tx_dma_started
  * @tx_dma_cr:  Nominal content of TX DMA control register
+ * @tx_dma_started: Set when TX DMA is started
  * @tx_bd_v:	Virtual address of the TX buffer descriptor ring
  * @tx_bd_p:	Physical address(start address) of the TX buffer descr. ring
  * @tx_bd_num:	Size of TX buffer descriptor ring
@@ -566,7 +570,9 @@ struct axienet_local {
 	void __iomem *dma_regs;
 
 	struct napi_struct napi_rx;
+	spinlock_t rx_cr_lock;
 	u32 rx_dma_cr;
+	bool rx_dma_started;
 	struct axidma_bd *rx_bd_v;
 	dma_addr_t rx_bd_p;
 	u32 rx_bd_num;
@@ -576,7 +582,9 @@ struct axienet_local {
 	struct u64_stats_sync rx_stat_sync;
 
 	struct napi_struct napi_tx;
+	spinlock_t tx_cr_lock;
 	u32 tx_dma_cr;
+	bool tx_dma_started;
 	struct axidma_bd *tx_bd_v;
 	dma_addr_t tx_bd_p;
 	u32 tx_bd_num;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fd5cca4f5499..7bd109b77afc 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -224,25 +224,41 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 }
 
 /**
- * axienet_usec_to_timer - Calculate IRQ delay timer value
- * @lp:		Pointer to the axienet_local structure
- * @coalesce_usec: Microseconds to convert into timer value
+ * axienet_calc_cr() - Calculate control register value
+ * @lp: Device private data
+ * @coalesce_count: Number of completions before an interrupt
+ * @coalesce_usec: Microseconds after the last completion before an interrupt
+ *
+ * Calculate a control register value based on the coalescing settings. The
+ * run/stop bit is not set.
  */
-static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
+static u32 axienet_calc_cr(struct axienet_local *lp, u32 coalesce_count, u32 coalesce_usec)
 {
-	u32 result;
-	u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+	u32 cr;
 
-	if (lp->axi_clk)
-		clk_rate = clk_get_rate(lp->axi_clk);
+	coalesce_count = min(coalesce_count, 255);
+	cr = (coalesce_count << XAXIDMA_COALESCE_SHIFT) | XAXIDMA_IRQ_IOC_MASK |
+	     XAXIDMA_IRQ_ERROR_MASK;
+	/* Only set interrupt delay timer if not generating an interrupt on
+	 * the first packet. Otherwise leave at 0 to disable delay interrupt.
+	 */
+	if (coalesce_count > 1) {
+		u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+		u32 timer;
 
-	/* 1 Timeout Interval = 125 * (clock period of SG clock) */
-	result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
-					 (u64)125000000);
-	if (result > 255)
-		result = 255;
+		if (lp->axi_clk)
+			clk_rate = clk_get_rate(lp->axi_clk);
 
-	return result;
+		/* 1 Timeout Interval = 125 * (clock period of SG clock) */
+		timer = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
+						(u64)125000000);
+		if (timer > 255)
+			timer = 255;
+
+		cr |= (timer << XAXIDMA_DELAY_SHIFT) | XAXIDMA_IRQ_DELAY_MASK;
+	}
+
+	return cr;
 }
 
 /**
@@ -251,32 +267,12 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
  */
 static void axienet_dma_start(struct axienet_local *lp)
 {
+	spin_lock_irq(&lp->rx_cr_lock);
+
 	/* Start updating the Rx channel control register */
-	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
-			 XAXIDMA_COALESCE_SHIFT) |
-			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
-	/* Only set interrupt delay timer if not generating an interrupt on
-	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
-	 */
-	if (lp->coalesce_count_rx > 1)
-		lp->rx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_rx)
-					<< XAXIDMA_DELAY_SHIFT) |
-				 XAXIDMA_IRQ_DELAY_MASK;
+	lp->rx_dma_cr &= ~XAXIDMA_CR_RUNSTOP_MASK;
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
 
-	/* Start updating the Tx channel control register */
-	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
-			 XAXIDMA_COALESCE_SHIFT) |
-			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
-	/* Only set interrupt delay timer if not generating an interrupt on
-	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
-	 */
-	if (lp->coalesce_count_tx > 1)
-		lp->tx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_tx)
-					<< XAXIDMA_DELAY_SHIFT) |
-				 XAXIDMA_IRQ_DELAY_MASK;
-	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
-
 	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
 	 * halted state. This will make the Rx side ready for reception.
 	 */
@@ -285,6 +281,14 @@ static void axienet_dma_start(struct axienet_local *lp)
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
 	axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p +
 			     (sizeof(*lp->rx_bd_v) * (lp->rx_bd_num - 1)));
+	lp->rx_dma_started = true;
+
+	spin_unlock_irq(&lp->rx_cr_lock);
+	spin_lock_irq(&lp->tx_cr_lock);
+
+	/* Start updating the Tx channel control register */
+	lp->tx_dma_cr &= ~XAXIDMA_CR_RUNSTOP_MASK;
+	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
 
 	/* Write to the RS (Run-stop) bit in the Tx channel control register.
 	 * Tx channel is now ready to run. But only after we write to the
@@ -293,6 +297,9 @@ static void axienet_dma_start(struct axienet_local *lp)
 	axienet_dma_out_addr(lp, XAXIDMA_TX_CDESC_OFFSET, lp->tx_bd_p);
 	lp->tx_dma_cr |= XAXIDMA_CR_RUNSTOP_MASK;
 	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
+	lp->tx_dma_started = true;
+
+	spin_unlock_irq(&lp->tx_cr_lock);
 }
 
 /**
@@ -628,14 +635,22 @@ static void axienet_dma_stop(struct axienet_local *lp)
 	int count;
 	u32 cr, sr;
 
-	cr = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
+	spin_lock_irq(&lp->rx_cr_lock);
+
+	cr = lp->rx_dma_cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+	lp->rx_dma_started = false;
+
+	spin_unlock_irq(&lp->rx_cr_lock);
 	synchronize_irq(lp->rx_irq);
 
-	cr = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	cr &= ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
+	spin_lock_irq(&lp->tx_cr_lock);
+
+	cr = lp->tx_dma_cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK);
 	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+	lp->tx_dma_started = false;
+
+	spin_unlock_irq(&lp->tx_cr_lock);
 	synchronize_irq(lp->tx_irq);
 
 	/* Give DMAs a chance to halt gracefully */
@@ -975,11 +990,15 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (packets < budget && napi_complete_done(napi, packets)) {
+		unsigned long flags;
+
 		/* Re-enable TX completion interrupts. This should
 		 * cause an immediate interrupt if any TX packets are
 		 * already pending.
 		 */
+		spin_lock_irqsave(&lp->tx_cr_lock, flags);
 		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
+		spin_unlock_irqrestore(&lp->tx_cr_lock, flags);
 	}
 	return packets;
 }
@@ -1241,11 +1260,15 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 
 	if (packets < budget && napi_complete_done(napi, packets)) {
+		unsigned long flags;
+
 		/* Re-enable RX completion interrupts. This should
 		 * cause an immediate interrupt if any RX packets are
 		 * already pending.
 		 */
+		spin_lock_irqsave(&lp->rx_cr_lock, flags);
 		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
+		spin_unlock_irqrestore(&lp->rx_cr_lock, flags);
 	}
 	return packets;
 }
@@ -1283,10 +1306,14 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
 		/* Disable further TX completion interrupts and schedule
 		 * NAPI to handle the completions.
 		 */
-		u32 cr = lp->tx_dma_cr;
+		unsigned long flags;
+		u32 cr;
 
+		spin_lock_irqsave(&lp->tx_cr_lock, flags);
+		cr = lp->tx_dma_cr;
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
 		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+		spin_unlock_irqrestore(&lp->tx_cr_lock, flags);
 
 		napi_schedule(&lp->napi_tx);
 	}
@@ -1327,10 +1354,14 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		/* Disable further RX completion interrupts and schedule
 		 * NAPI receive.
 		 */
-		u32 cr = lp->rx_dma_cr;
+		u32 cr;
+		unsigned long flags;
 
+		spin_lock_irqsave(&lp->rx_cr_lock, flags);
+		cr = lp->rx_dma_cr;
 		cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
 		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+		spin_unlock_irqrestore(&lp->rx_cr_lock, flags);
 
 		napi_schedule(&lp->napi_rx);
 	}
@@ -1992,6 +2023,62 @@ axienet_ethtools_set_pauseparam(struct net_device *ndev,
 	return phylink_ethtool_set_pauseparam(lp->phylink, epauseparm);
 }
 
+/**
+ * axienet_update_coalesce_rx() - Update RX coalesce settings
+ * @lp: Device private data
+ */
+static void axienet_update_coalesce_rx(struct axienet_local *lp)
+{
+	u32 cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
+				 lp->coalesce_usec_rx);
+
+	spin_lock_irq(&lp->rx_cr_lock);
+	lp->rx_dma_cr &= XAXIDMA_CR_RUNSTOP_MASK;
+	lp->rx_dma_cr |= cr;
+	/* If DMA isn't started, then the settings will be applied the next
+	 * time dma_start() is called.
+	 */
+	if (lp->rx_dma_started) {
+		u32 reg = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+
+		/* Don't enable IRQs if they are disabled by NAPI */
+		if (reg & XAXIDMA_IRQ_ALL_MASK)
+			cr = lp->rx_dma_cr;
+		else
+			cr = lp->rx_dma_cr & ~XAXIDMA_IRQ_ALL_MASK;
+		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
+	}
+	spin_unlock_irq(&lp->rx_cr_lock);
+}
+
+/**
+ * axienet_update_coalesce_tx() - Update TX coalesce settings
+ * @lp: Device private data
+ */
+static void axienet_update_coalesce_tx(struct axienet_local *lp)
+{
+	u32 cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
+				 lp->coalesce_usec_tx);
+
+	spin_lock_irq(&lp->tx_cr_lock);
+	lp->tx_dma_cr &= XAXIDMA_CR_RUNSTOP_MASK;
+	lp->tx_dma_cr |= cr;
+	/* If DMA isn't started, then the settings will be applied the next
+	 * time dma_start() is called.
+	 */
+	if (lp->tx_dma_started) {
+		u32 reg = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+
+		/* Don't enable IRQs if they are disabled by NAPI */
+		if (reg & XAXIDMA_IRQ_ALL_MASK)
+			cr = lp->tx_dma_cr;
+		else
+			cr = lp->tx_dma_cr & ~XAXIDMA_IRQ_ALL_MASK;
+		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
+	}
+	spin_unlock_irq(&lp->tx_cr_lock);
+}
+
 /**
  * axienet_ethtools_get_coalesce - Get DMA interrupt coalescing count.
  * @ndev:	Pointer to net_device structure
@@ -2041,12 +2128,6 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 {
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	if (netif_running(ndev)) {
-		NL_SET_ERR_MSG(extack,
-			       "Please stop netif before applying configuration");
-		return -EBUSY;
-	}
-
 	if (ecoalesce->rx_max_coalesced_frames)
 		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
 	if (ecoalesce->rx_coalesce_usecs)
@@ -2056,6 +2137,8 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 	if (ecoalesce->tx_coalesce_usecs)
 		lp->coalesce_usec_tx = ecoalesce->tx_coalesce_usecs;
 
+	axienet_update_coalesce_rx(lp);
+	axienet_update_coalesce_tx(lp);
 	return 0;
 }
 
@@ -2840,10 +2923,16 @@ static int axienet_probe(struct platform_device *pdev)
 		axienet_set_mac_address(ndev, NULL);
 	}
 
+	spin_lock_init(&lp->rx_cr_lock);
+	spin_lock_init(&lp->tx_cr_lock);
 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
+	lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
+					lp->coalesce_usec_rx);
+	lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
+					lp->coalesce_usec_tx);
 
 	ret = axienet_mdio_setup(lp);
 	if (ret)
-- 
2.35.1.1320.gc452695387.dirty


