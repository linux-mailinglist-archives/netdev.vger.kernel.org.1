Return-Path: <netdev+bounces-116029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B345948D4C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC991C22698
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D691C0DEF;
	Tue,  6 Aug 2024 10:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E21C0DCC
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941853; cv=none; b=iwcH4h6ItcdD49wPg3reipm6laUFg57Mw7V0QPFgdnatLHQ+EuJrYUjZzTCh6a555BocOE/V6j6T9tkG3imzAQbHyB/NY4lsHBCvN0TkfQR/BxWvnxZmdaCs+t/NwhZW3D3/b4mPBv2adXsMvJdBTNo3wtAR3vfbZD3s1ZFSzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941853; c=relaxed/simple;
	bh=VxGc1hKkvSZPjzBuvdUIVdQRNwcREFNSzaeCcPNqkvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXQBr7AV2Aqdcj47ewEdz3iz11d4cQnn5IJIz9+Z1cvxuEtIoTrXww3MtNnUeUXlc/GZWp2KEEL3FtFJrzSiAVxy/l16YItBFaVRNhcupoKI3ikN4HyHTg4ROXgFa4q9ioZIWEKovw9nAypQft3evA9aTn3xy6qPZfK+xgofrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8Axz+uTAbJmUq8IAA--.29055S3;
	Tue, 06 Aug 2024 18:57:23 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMBxNOKMAbJmp_cFAA--.31158S4;
	Tue, 06 Aug 2024 18:57:22 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net-next v16 02/14] net: stmmac: Add multi-channel support
Date: Tue,  6 Aug 2024 18:57:05 +0800
Message-Id: <06582d601884ab401862aef6b5c37d92e2d624ff.1722924540.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1722924540.git.siyanteng@loongson.cn>
References: <cover.1722924540.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxNOKMAbJmp_cFAA--.31158S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFyUJr1kXw43Cry5uw1Dtwc_yoW8Xr13uo
	Z3A3s0g34agw18uF97Kr1ktryUXrnxWw1rCrWxurWkua97Zay5ZrW0q393G3W7AF47uF4a
	v348X3WqyF45tF15l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=

DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
enables transmission of time-sensitive traffic over bridged local area
networks (DWC Ethernet QoS Product). In that case there can be up to two
additional DMA-channels available with no Tx COE support (unless there is
vendor-specific IP-core alterations). Each channel is implemented as a
separate Control and Status register (CSR) for managing the transmit and
receive functions, descriptor handling, and interrupt handling.

Add the multi-channels DW GMAC controllers support just by making sure the
already implemented DMA-configs are performed on the per-channel basis.

Note the only currently known instance of the multi-channel DW GMAC
IP-core is the LS2K2000 GNET controller, which has been released with the
vendor-specific feature extension of having eight DMA-channels. The device
support will be added in one of the following up commits.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 32 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 27 +++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 30 ++++++++---------
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++----
 6 files changed, 68 insertions(+), 39 deletions(-)

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
index 984b809105af..b3d7eff53b18 100644
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
index 72672391675f..5d9c18f5bbf5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -22,6 +22,31 @@
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
+#define DMA_CHAN_BUS_MODE(chan)	dma_chan_base_addr(DMA_BUS_MODE, chan)
+#define DMA_CHAN_XMT_POLL_DEMAND(chan)	\
+				dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
+#define DMA_CHAN_RCV_POLL_DEMAND(chan)	\
+				dma_chan_base_addr(DMA_RCV_POLL_DEMAND, chan)
+#define DMA_CHAN_RCV_BASE_ADDR(chan)	\
+				dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
+#define DMA_CHAN_TX_BASE_ADDR(chan)	\
+				dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
+#define DMA_CHAN_STATUS(chan)	dma_chan_base_addr(DMA_STATUS, chan)
+#define DMA_CHAN_CONTROL(chan)	dma_chan_base_addr(DMA_CONTROL, chan)
+#define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
+#define DMA_CHAN_MISSED_FRAME_CTR(chan)	\
+				dma_chan_base_addr(DMA_MISSED_FRAME_CTR, chan)
+#define DMA_CHAN_RX_WATCHDOG(chan)	\
+				dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
+
 /* SW Reset */
 #define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
 
@@ -152,7 +177,7 @@
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
-void dwmac_enable_dma_transmission(void __iomem *ioaddr);
+void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
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
index 1c99c99f4627..7e90f34b8c88 100644
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
index 9f1286835550..d9fca8d1227c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2367,9 +2367,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
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
@@ -2553,7 +2555,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 				       true, priv->mode, true, true,
 				       xdp_desc.len);
 
-		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
@@ -4753,7 +4755,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4980,7 +4982,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
-- 
2.31.4


