Return-Path: <netdev+bounces-98967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E798D3458
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCEC28655D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C608169ADB;
	Wed, 29 May 2024 10:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3415B138
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977917; cv=none; b=vGHo5a35RthX/hCxAPSvlsngMZ8PLF3BfYIhuZGhwedaqLK/b8miOuHETalXW8Rr/j56CDUMN3omKO6e0wfNNFAkpvt96mkjYHATeAL8kcEQIY8bYy1OiaeYV+jIU/BoADiTyPmJdmn0v+ZcRK5eyna5rGxA0+uT+2zP2hqevB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977917; c=relaxed/simple;
	bh=k7zoqzyWbWGzbjCGQtTe7E/y4aLtNhYwCU32WKU4itQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAKqkL/JorZbgmjNmc6tcEnx1DD7WLt3g5RhJ8sNkyUsEb1TCrX/cH7j1dsb1qm7VhluzJmXpJpKUvK9P5yGw0gAjn32TSnhx65sQ+wvyD4aCkC5AG87uWLkEXYaj3c3QP+XjPkqhUvsTemdUDoNyYlADdQH34DiqN5bjnI5SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8DxzOr5AFdmqBgBAA--.4683S3;
	Wed, 29 May 2024 18:18:33 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMX1AFdmaN4MAA--.23140S3;
	Wed, 29 May 2024 18:18:32 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 02/15] net: stmmac: Add multi-channel support
Date: Wed, 29 May 2024 18:18:18 +0800
Message-Id: <b4ab0f87284b5f2b0f03961b76878dcc000830c2.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMX1AFdmaN4MAA--.23140S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr1xZw45XF4fJr4DXr1UJwc_yoW8GF13Xo
	WfAr90gFyagw18ur97Kr1ktry5XrnxX345CrZ7urWkua97Zay5ZrW0q393G3W7AF47uFWY
	v348X3WqyF4UtF1Ul-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUtVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAKsUUUUUU=

DW GMAC v3.x multi-channels feature is implemented as multiple
sets of the same CSRs. Here is only preliminary support, it will
be useful for the driver further evolution and for the users
having multi-channel DWGMAC v3.x devices.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 32 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 20 ++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 30 ++++++++---------
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++----
 6 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index d87079016952..cc93f73a380e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
 	writel(v, ioaddr + EMAC_TX_CTL1);
 }
 
-static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
+static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
 {
 	u32 v;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index bb82ee9b855f..f161ec9ac490 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
 
-static void dwmac1000_dma_init(void __iomem *ioaddr,
-			       struct stmmac_dma_cfg *dma_cfg)
+static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
+				       void __iomem *ioaddr,
+				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_BUS_MODE);
 	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
+	u32 value;
 
-	/*
-	 * Set the DMA PBL (Programmable Burst Length) mode.
+	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	/* Set the DMA PBL (Programmable Burst Length) mode.
 	 *
 	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
 	 * post 3.5 mode bit acts as 8*PBL.
@@ -104,10 +106,10 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
 	if (dma_cfg->aal)
 		value |= DMA_BUS_MODE_AAL;
 
-	writel(value, ioaddr + DMA_BUS_MODE);
+	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
 
 	/* Mask interrupts by writing to CSR7 */
-	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
+	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
 }
 
 static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
@@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
 				  dma_addr_t dma_rx_phy, u32 chan)
 {
 	/* RX descriptor base address list must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
+	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
 }
 
 static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
@@ -125,7 +127,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
 				  dma_addr_t dma_tx_phy, u32 chan)
 {
 	/* TX descriptor base address list must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
+	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
 }
 
 static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
@@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 					    void __iomem *ioaddr, int mode,
 					    u32 channel, int fifosz, u8 qmode)
 {
-	u32 csr6 = readl(ioaddr + DMA_CONTROL);
+	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
@@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 	/* Configure flow control based on rx fifo size */
 	csr6 = dwmac1000_configure_fc(csr6, fifosz);
 
-	writel(csr6, ioaddr + DMA_CONTROL);
+	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
 }
 
 static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
 					    void __iomem *ioaddr, int mode,
 					    u32 channel, int fifosz, u8 qmode)
 {
-	u32 csr6 = readl(ioaddr + DMA_CONTROL);
+	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable TX store and forward mode\n");
@@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
 			csr6 |= DMA_CONTROL_TTC_256;
 	}
 
-	writel(csr6, ioaddr + DMA_CONTROL);
+	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
 }
 
 static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
@@ -271,12 +273,12 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
 static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
 				  void __iomem *ioaddr, u32 riwt, u32 queue)
 {
-	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
+	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
 }
 
 const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.reset = dwmac_dma_reset,
-	.init = dwmac1000_dma_init,
+	.init_chan = dwmac1000_dma_init_channel,
 	.init_rx_chan = dwmac1000_dma_init_rx,
 	.init_tx_chan = dwmac1000_dma_init_tx,
 	.axi = dwmac1000_dma_axi,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 72672391675f..363a85469594 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -22,6 +22,23 @@
 #define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
 #define DMA_MISSED_FRAME_CTR	0x00001020	/* Missed Frame Counter */
 
+/* Following DMA defines are channels oriented */
+#define DMA_CHAN_BASE_OFFSET			0x100
+
+static inline u32 dma_chan_base_addr(u32 base, u32 chan)
+{
+	return base + chan * DMA_CHAN_BASE_OFFSET;
+}
+
+#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
+#define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
+#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
+#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
+#define DMA_CHAN_BUS_MODE(chan)	dma_chan_base_addr(DMA_BUS_MODE, chan)
+#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
+#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
+#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
+
 /* SW Reset */
 #define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
 
@@ -152,7 +169,7 @@
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
-void dwmac_enable_dma_transmission(void __iomem *ioaddr);
+void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -168,5 +185,4 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir);
 int dwmac_dma_reset(void __iomem *ioaddr);
-
 #endif /* __DWMAC_DMA_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 85e18f9a22f9..4846bf49c576 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -28,65 +28,65 @@ int dwmac_dma_reset(void __iomem *ioaddr)
 }
 
 /* CSR1 enables the transmit DMA to check for new descriptor */
-void dwmac_enable_dma_transmission(void __iomem *ioaddr)
+void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
 {
-	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
+	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
 }
 
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + DMA_INTR_ENA);
+	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
 
 	if (rx)
 		value |= DMA_INTR_DEFAULT_RX;
 	if (tx)
 		value |= DMA_INTR_DEFAULT_TX;
 
-	writel(value, ioaddr + DMA_INTR_ENA);
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
 }
 
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + DMA_INTR_ENA);
+	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
 
 	if (rx)
 		value &= ~DMA_INTR_DEFAULT_RX;
 	if (tx)
 		value &= ~DMA_INTR_DEFAULT_TX;
 
-	writel(value, ioaddr + DMA_INTR_ENA);
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
 }
 
 void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
 	value |= DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
 }
 
 void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
 	value &= ~DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
 }
 
 void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
 	value |= DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
 }
 
 void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
 	value &= ~DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
 }
 
 #ifdef DWMAC_DMA_DEBUG
@@ -165,7 +165,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	int ret = 0;
 	/* read the status register (CSR5) */
-	u32 intr_status = readl(ioaddr + DMA_STATUS);
+	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
 
 #ifdef DWMAC_DMA_DEBUG
 	/* Enable it to monitor DMA rx/tx status in case of critical problems */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 413441eb6ea0..d807ee4b066e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -197,7 +197,7 @@ struct stmmac_dma_ops {
 	/* To track extra statistic (if supported) */
 	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
 				  void __iomem *ioaddr);
-	void (*enable_dma_transmission) (void __iomem *ioaddr);
+	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
 	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 99da314508c3..0eef95c15cd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2370,9 +2370,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	if (txfifosz == 0)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
-	/* Adjust for real per queue fifo size */
-	rxfifosz /= rx_channels_count;
-	txfifosz /= tx_channels_count;
+	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
+		rxfifosz /= rx_channels_count;
+		txfifosz /= tx_channels_count;
+	}
 
 	if (priv->plat->force_thresh_dma_mode) {
 		txmode = tc;
@@ -2556,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 				       true, priv->mode, true, true,
 				       xdp_desc.len);
 
-		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
@@ -4752,7 +4754,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4979,7 +4981,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
-- 
2.31.4


