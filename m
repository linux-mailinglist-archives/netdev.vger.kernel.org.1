Return-Path: <netdev+bounces-87349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40F8A2D61
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FCC1F21455
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC654BE8;
	Fri, 12 Apr 2024 11:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9E53818
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921310; cv=none; b=t9oCKrwD0HpWEDPKTbhC3L6hV0m6SaUgI53bX/rjZpzML7uXGFDMC3cuGEyH8Sy/p7bXHduX7DUPdfvVL+H4gqzUYEu2KGaROhZFZepgpXDCgSVfxCshcFvsk+AFeyIlvr4XmY7+LnrmE8qfmZWxoZ+TA0PEf+3b8PrKgQWULos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921310; c=relaxed/simple;
	bh=B/fJQdkwgSK8m6oxtBjgoeHfnAowdlZBw6qyb259Bik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIzc3CkQ68o4TPpFtfzWbaeW+QptcmwmFuYpMbbkLL0ojgUzxkVacIHlP6taqXwSdNab2qQnWjhm1eES3PK0xrdRO+t+dDRAs4eeNO8XjT3Ftq82g2lLQFfY6MRvzV4rGG75GVkvf74waN9HB0YwDJ1+iSgJjMwpkBbJGrHA8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxfevaGhlmYl4mAA--.21912S3;
	Fri, 12 Apr 2024 19:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhPSGhlmSLV4AA--.45677S4;
	Fri, 12 Apr 2024 19:28:25 +0800 (CST)
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
	siyanteng01@gmail.com
Subject: [PATCH net-next v11 2/6] net: stmmac: Add multi-channel support
Date: Fri, 12 Apr 2024 19:28:07 +0800
Message-Id: <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1712917541.git.siyanteng@loongson.cn>
References: <cover.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhPSGhlmSLV4AA--.45677S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr17Cr17uw17AFyUXr15Jrc_yoW8AFWxKo
	Z3AFn0gryagw18ur97Kr1kJry3XrnxXw1rCrZ7ur4kua97Zay5Z340q393G3W7AF4xurZI
	v340q3WqvF4UKF1Ul-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
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
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

DW GMAC v3.x multi-channels feature is implemented as multiple
sets of the same CSRs. Here is only preliminary support, it will
be useful for the driver further evolution and for the users
having multi-channel DWGMAC v3.x devices.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 +--
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 34 ++++++++++---------
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 20 +++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++---
 include/linux/stmmac.h                        |  1 +
 10 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index e1b761dcfa1d..cc93f73a380e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -299,7 +299,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
  * Called from stmmac via stmmac_dma_ops->init
  */
 static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
-				 struct stmmac_dma_cfg *dma_cfg, int atds)
+				 struct stmmac_dma_cfg *dma_cfg)
 {
 	writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
 	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
@@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
 	writel(v, ioaddr + EMAC_TX_CTL1);
 }
 
-static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
+static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
 {
 	u32 v;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..f161ec9ac490 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
 
-static void dwmac1000_dma_init(void __iomem *ioaddr,
-			       struct stmmac_dma_cfg *dma_cfg, int atds)
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
@@ -98,16 +100,16 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
 	if (dma_cfg->mixed_burst)
 		value |= DMA_BUS_MODE_MB;
 
-	if (atds)
+	if (dma_cfg->atds)
 		value |= DMA_BUS_MODE_ATDS;
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index dea270f60cc3..f861babc06f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -19,7 +19,7 @@
 #include "dwmac_dma.h"
 
 static void dwmac100_dma_init(void __iomem *ioaddr,
-			      struct stmmac_dma_cfg *dma_cfg, int atds)
+			      struct stmmac_dma_cfg *dma_cfg)
 {
 	/* Enable Application Access by writing to DMA CSR0 */
 	writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..e0165358c4ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -153,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 }
 
 static void dwmac4_dma_init(void __iomem *ioaddr,
-			    struct stmmac_dma_cfg *dma_cfg, int atds)
+			    struct stmmac_dma_cfg *dma_cfg)
 {
 	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 72672391675f..7c8b3ad739f7 100644
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
+#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
+#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
+#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
+#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
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
index 85e18f9a22f9..7570f01838a8 100644
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
@@ -235,7 +235,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
 
 	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
-	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
+	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dd2ab6185c40..7840bc403788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -20,7 +20,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 }
 
 static void dwxgmac2_dma_init(void __iomem *ioaddr,
-			      struct stmmac_dma_cfg *dma_cfg, int atds)
+			      struct stmmac_dma_cfg *dma_cfg)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7be04b54738b..3b20fb7f3a61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -175,8 +175,7 @@ struct dma_features;
 struct stmmac_dma_ops {
 	/* DMA core initialization */
 	int (*reset)(void __iomem *ioaddr);
-	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
-		     int atds);
+	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg);
 	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
 	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -198,7 +197,7 @@ struct stmmac_dma_ops {
 	/* To track extra statistic (if supported) */
 	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
 				  void __iomem *ioaddr);
-	void (*enable_dma_transmission) (void __iomem *ioaddr);
+	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
 	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index af16efeedf4a..45e28f9211df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2556,7 +2556,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 				       true, priv->mode, true, true,
 				       xdp_desc.len);
 
-		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
@@ -3006,7 +3006,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
 	u32 chan = 0;
-	int atds = 0;
 	int ret = 0;
 
 	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
@@ -3015,7 +3014,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
-		atds = 1;
+		priv->plat->dma_cfg->atds = 1;
 
 	ret = stmmac_reset(priv, priv->ioaddr);
 	if (ret) {
@@ -3024,7 +3023,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	/* DMA Configuration */
-	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg, atds);
+	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
 
 	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
@@ -4753,7 +4752,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4980,7 +4979,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..1b54b84a6785 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -100,6 +100,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	bool multi_msi_en;
 	bool dche;
+	bool atds;
 };
 
 #define AXI_BLEN	7
-- 
2.31.4


