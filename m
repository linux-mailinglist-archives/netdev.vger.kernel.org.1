Return-Path: <netdev+bounces-23995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466F76E6DB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9953D1C20D2A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0C1E50F;
	Thu,  3 Aug 2023 11:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1691E501
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777BB198A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:02 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8AxZ+h7j8tktawPAA--.530S3;
	Thu, 03 Aug 2023 19:28:59 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCN1j8tk4R1HAA--.33555S5;
	Thu, 03 Aug 2023 19:28:58 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v3 03/16] net: stmmac: dwmac1000: Add multi-channel support
Date: Thu,  3 Aug 2023 19:28:05 +0800
Message-Id: <a40bf8242d1805c94a1ff1a8762b87c7622cc1af.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxLCN1j8tk4R1HAA--.33555S5
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr1fAF17KFWkJw4kuryUurX_yoWfCF4rpa
	yqy3s5JFy5tr4fZF4kJr4DXry5X345KryxWF4fGw1a9ay29r1a9an09ayjyF13CF47Ar9I
	qrs8tw17Wr1UZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6rWOUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms have dwmac1000 implementations that support multi-
channel. Extend the functions to add multi-channel support.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 70 +++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 37 ++++++----
 2 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 3996dea4b1e3..4cec78180556 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -114,15 +114,65 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(mask, ioaddr + DMA_INTR_ENA);
 }
 
+static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
+				       void __iomem *ioaddr,
+				       struct stmmac_dma_cfg *dma_cfg,
+				       u32 chan)
+{
+	u32 value;
+	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
+	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 mask = priv->plat->dwmac_regs->intr_ena->default_mask;
+
+	if (!priv->plat->multi_msi_en)
+		return;
+
+	/* common channel control register config */
+	value = readl(ioaddr + DMA_BUS_MODE + chan * offset);
+
+	/*
+	 * Set the DMA PBL (Programmable Burst Length) mode.
+	 *
+	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
+	 * post 3.5 mode bit acts as 8*PBL.
+	 */
+	if (dma_cfg->pblx8)
+		value |= DMA_BUS_MODE_MAXPBL;
+	value |= DMA_BUS_MODE_USP;
+	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
+	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+
+	/* Set the Fixed burst mode */
+	if (dma_cfg->fixed_burst)
+		value |= DMA_BUS_MODE_FB;
+
+	/* Mixed Burst has no effect when fb is set */
+	if (dma_cfg->mixed_burst)
+		value |= DMA_BUS_MODE_MB;
+
+	value |= DMA_BUS_MODE_ATDS;
+
+	if (dma_cfg->aal)
+		value |= DMA_BUS_MODE_AAL;
+
+	writel(value, ioaddr + DMA_BUS_MODE + chan * offset);
+
+	/* Mask interrupts by writing to CSR7 */
+	writel(mask, ioaddr + DMA_INTR_ENA + chan * offset);
+}
+
 static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
 				  void __iomem *ioaddr,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_rx_phy, u32 chan)
 {
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
 	u32 addr = priv->plat->dwmac_regs->addrs->rcv_base_addr;
 
 	/* RX descriptor base address list must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + addr);
+	writel(lower_32_bits(dma_rx_phy), ioaddr + addr + chan * offset);
 }
 
 static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
@@ -130,10 +180,11 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_tx_phy, u32 chan)
 {
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
 	u32 addr = priv->plat->dwmac_regs->addrs->tx_base_addr;
 
 	/* TX descriptor base address list must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + addr);
+	writel(lower_32_bits(dma_tx_phy), ioaddr + addr + chan * offset);
 }
 
 static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
@@ -161,7 +212,8 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 					    void __iomem *ioaddr, int mode,
 					    u32 channel, int fifosz, u8 qmode)
 {
-	u32 csr6 = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 csr6 = readl(ioaddr + DMA_CONTROL + channel * offset);
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
@@ -183,14 +235,15 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 	/* Configure flow control based on rx fifo size */
 	csr6 = dwmac1000_configure_fc(csr6, fifosz);
 
-	writel(csr6, ioaddr + DMA_CONTROL);
+	writel(csr6, ioaddr + DMA_CONTROL + channel * offset);
 }
 
 static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
 					    void __iomem *ioaddr, int mode,
 					    u32 channel, int fifosz, u8 qmode)
 {
-	u32 csr6 = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 csr6 = readl(ioaddr + DMA_CONTROL + channel * offset);
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable TX store and forward mode\n");
@@ -217,7 +270,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
 			csr6 |= DMA_CONTROL_TTC_256;
 	}
 
-	writel(csr6, ioaddr + DMA_CONTROL);
+	writel(csr6, ioaddr + DMA_CONTROL + channel * offset);
 }
 
 static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
@@ -280,12 +333,15 @@ static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
 static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
 				  void __iomem *ioaddr, u32 riwt, u32 queue)
 {
-	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+
+	writel(riwt, ioaddr + DMA_RX_WATCHDOG + queue * offset);
 }
 
 const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.reset = dwmac_dma_reset,
 	.init = dwmac1000_dma_init,
+	.init_chan = dwmac1000_dma_init_channel,
 	.init_rx_chan = dwmac1000_dma_init_rx,
 	.init_tx_chan = dwmac1000_dma_init_tx,
 	.axi = dwmac1000_dma_axi,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 6411be0f3612..cf9e3e7b6b3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -103,63 +103,71 @@ int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
 				   void __iomem *ioaddr, u32 chan)
 {
-	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+
+	writel(1, ioaddr + DMA_XMT_POLL_DEMAND + chan * offset);
 }
 
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + DMA_INTR_ENA);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_INTR_ENA + chan * offset);
 
 	if (rx)
 		value |= DMA_INTR_DEFAULT_RX;
 	if (tx)
 		value |= DMA_INTR_DEFAULT_TX;
 
-	writel(value, ioaddr + DMA_INTR_ENA);
+	writel(value, ioaddr + DMA_INTR_ENA + chan * offset);
 }
 
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx)
 {
-	u32 value = readl(ioaddr + DMA_INTR_ENA);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_INTR_ENA + chan * offset);
 
 	if (rx)
 		value &= ~DMA_INTR_DEFAULT_RX;
 	if (tx)
 		value &= ~DMA_INTR_DEFAULT_TX;
 
-	writel(value, ioaddr + DMA_INTR_ENA);
+	writel(value, ioaddr + DMA_INTR_ENA + chan * offset);
 }
 
 void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_CONTROL + chan * offset);
 	value |= DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CONTROL + chan * offset);
 }
 
 void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_CONTROL + chan * offset);
 	value &= ~DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CONTROL + chan * offset);
 }
 
 void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_CONTROL + chan * offset);
 	value |= DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CONTROL + chan * offset);
 }
 
 void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
+	u32 value = readl(ioaddr + DMA_CONTROL + chan * offset);
 	value &= ~DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	writel(value, ioaddr + DMA_CONTROL + chan * offset);
 }
 
 #ifdef DWMAC_DMA_DEBUG
@@ -238,9 +246,10 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
 	const struct dwmac_dma_status *status = priv->plat->dwmac_regs->status;
+	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
 	int ret = 0;
 	/* read the status register (CSR5) */
-	u32 intr_status = readl(ioaddr + DMA_STATUS);
+	u32 intr_status = readl(ioaddr + DMA_STATUS + chan * offset);
 
 #ifdef DWMAC_DMA_DEBUG
 	/* Enable it to monitor DMA rx/tx status in case of critical problems */
-- 
2.39.3


