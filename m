Return-Path: <netdev+bounces-67025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DC841E34
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119391F2D666
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF6359161;
	Tue, 30 Jan 2024 08:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D55914F
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604231; cv=none; b=Qd4CfrV3B3vribHwvXpEQq0KU4hpxxPgKvb1l/qAVKIu1i3Z5+Tx/N095L9p34dlzuSRopLpY78WJbXI+U6zuhbBFEpQTz9+WJj5ReLJenr5N82JUERdyIpJiYqAdNH6MjLtoCdopn+eapuWYj7L+bFSwYAbMy9yvDpb9JvC/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604231; c=relaxed/simple;
	bh=1VPI48f9pS4DJnFwCXIlCqtyx112ysTzwhCbKvxTT6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpa3skdpmvleQZkq0wjH52xAwykig1SHaMWDrtug0ewlwMgl0/Vxskvkd8moEkvvyLWfoNhRv6zFgwnqSIsedbOpeCZSA0Yx86q+03pIoa9ZU8D/r/jeIxTjz7ov6QHBx0IsacmQCJHsgzpvTZjuqII2HhpVd0Mkp3C0dQRXcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8BxOPDDtrhlt0MIAA--.25601S3;
	Tue, 30 Jan 2024 16:43:47 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZMy+trhltK4nAA--.30345S3;
	Tue, 30 Jan 2024 16:43:45 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Date: Tue, 30 Jan 2024 16:43:21 +0800
Message-Id: <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1706601050.git.siyanteng@loongson.cn>
References: <cover.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZMy+trhltK4nAA--.30345S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr17Cr17uw17AFyUXr15Jrc_yoW8GrykKo
	WfJrn0gryagw18uF97Kr1ktry5XrnxX34rCFZ7ur4kua97Zay5Z3y0q393G3W7AF47uFZ0
	v348X3WqyF45tF1Ul-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

DW GMAC v3.x multi-channels feature is implemented as multiple
sets of the same CSRs. Here is only preliminary support, it will
be useful for the driver further evolution and for the users
having multi-channel DWGMAC v3.x devices.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 36 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 19 +++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
 6 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 137741b94122..7cdfa0bdb93a 100644
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
index daf79cdbd3ec..5f7b82ad3ec2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -70,15 +70,18 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
 
-static void dwmac1000_dma_init(void __iomem *ioaddr,
-			       struct stmmac_dma_cfg *dma_cfg, int atds)
+static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
+				       void __iomem *ioaddr,
+				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_BUS_MODE);
+	u32 value;
 	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 
-	/*
-	 * Set the DMA PBL (Programmable Burst Length) mode.
+	/* common channel control register config */
+	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	/* Set the DMA PBL (Programmable Burst Length) mode.
 	 *
 	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
 	 * post 3.5 mode bit acts as 8*PBL.
@@ -98,16 +101,15 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
 	if (dma_cfg->mixed_burst)
 		value |= DMA_BUS_MODE_MB;
 
-	if (atds)
-		value |= DMA_BUS_MODE_ATDS;
+	value |= DMA_BUS_MODE_ATDS;
 
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
index 72672391675f..593be79c46e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -148,11 +148,14 @@
 					 DMA_STATUS_TI | \
 					 DMA_STATUS_MSK_COMMON)
 
+/* Following DMA defines are chanels oriented */
+#define DMA_CHAN_OFFSET			0x100
+
 #define NUM_DWMAC100_DMA_REGS	9
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
-void dwmac_enable_dma_transmission(void __iomem *ioaddr);
+void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir);
 int dwmac_dma_reset(void __iomem *ioaddr);
 
+static inline u32 dma_chan_base_addr(u32 base, u32 chan)
+{
+	return base + chan * DMA_CHAN_OFFSET;
+}
+
+#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
+#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
+#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
+#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
+#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
+#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
+#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
+#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
+
 #endif /* __DWMAC_DMA_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 7907d62d3437..b37368137810 100644
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
@@ -166,7 +166,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	int ret = 0;
 	/* read the status register (CSR5) */
-	u32 intr_status = readl(ioaddr + DMA_STATUS);
+	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
 
 #ifdef DWMAC_DMA_DEBUG
 	/* Enable it to monitor DMA rx/tx status in case of critical problems */
@@ -236,7 +236,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
 
 	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
-	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
+	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7be04b54738b..b0db38396171 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -198,7 +198,7 @@ struct stmmac_dma_ops {
 	/* To track extra statistic (if supported) */
 	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
 				  void __iomem *ioaddr);
-	void (*enable_dma_transmission) (void __iomem *ioaddr);
+	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
 	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b334eb16da23..5617b40abbe4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 				       true, priv->mode, true, true,
 				       xdp_desc.len);
 
-		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
@@ -4706,7 +4706,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4926,7 +4926,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 	}
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
-- 
2.31.4


