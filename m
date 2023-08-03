Return-Path: <netdev+bounces-23999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A676E6E3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5701C2152A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDBF1ED44;
	Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA131ED39
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AD851990
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:36 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8AxZ+ifj8tk6KwPAA--.534S3;
	Thu, 03 Aug 2023 19:29:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM6dj8tkKx5HAA--.52441S2;
	Thu, 03 Aug 2023 19:29:33 +0800 (CST)
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
Subject: [PATCH v3 04/16] net: stmmac: dwmac1000: Add 64-bit DMA support
Date: Thu,  3 Aug 2023 19:29:24 +0800
Message-Id: <fdcf0180a8ae0791bfbc7edb033f0d0cbd8f25ac.1691047285.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxzM6dj8tkKx5HAA--.52441S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfCw4rGw43Xr1xtrWDWw1UCFX_yoW8Zw13Zo
	ZrtFn3JayrJw1kXrZrKr1ktFy2qFnxW3s7C3y7C395u3yIvwn0q347Z3yrAw4Yyr1Fqay7
	Z3W8JFZrZFW7tr1Dl-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYZ7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWrXDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms have dwmac1000 implementations that support 64-bit
DMA. Add and extend the functions to add 64-bit DMA support.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  24 ++-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  47 +++++-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  32 +++-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  21 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   5 +-
 .../net/ethernet/stmicro/stmmac/ring_mode64.c | 159 ++++++++++++++++++
 include/linux/stmmac.h                        |   1 +
 10 files changed, 277 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/ring_mode64.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7dd3d388068b..10f32ded2bd9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o \
+	      stmmac_xdp.o ring_mode64.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index a95866871f3e..f363a2fb56f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -36,6 +36,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	des2 = dma_map_single(priv->device, skb->data,
 			      bmax, DMA_TO_DEVICE);
 	desc->des2 = cpu_to_le32(des2);
+	if (priv->plat->dma_cfg->dma64)
+		desc->des3 = cpu_to_le32(upper_32_bits(des2));
+
 	if (dma_mapping_error(priv->device, des2))
 		return -1;
 	tx_q->tx_skbuff_dma[entry].buf = des2;
@@ -54,12 +57,16 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 					      (skb->data + bmax * i),
 					      bmax, DMA_TO_DEVICE);
 			desc->des2 = cpu_to_le32(des2);
+			if (priv->plat->dma_cfg->dma64)
+				desc->des3 = cpu_to_le32(upper_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
 				return -1;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
 			tx_q->tx_skbuff_dma[entry].len = bmax;
 			stmmac_prepare_tx_desc(priv, desc, 0, bmax, csum,
-					STMMAC_CHAIN_MODE, 1, false, skb->len);
+					       STMMAC_CHAIN_MODE,
+					       !priv->plat->dma_cfg->dma64,
+					       false, skb->len);
 			len -= bmax;
 			i++;
 		} else {
@@ -67,6 +74,8 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 					      (skb->data + bmax * i), len,
 					      DMA_TO_DEVICE);
 			desc->des2 = cpu_to_le32(des2);
+			if (priv->plat->dma_cfg->dma64)
+				desc->des3 = cpu_to_le32(upper_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
 				return -1;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
@@ -110,7 +119,12 @@ static void init_dma_chain(struct stmmac_priv *priv, void *des,
 		struct dma_extended_desc *p = (struct dma_extended_desc *)des;
 		for (i = 0; i < (size - 1); i++) {
 			dma_phy += sizeof(struct dma_extended_desc);
-			p->basic.des3 = cpu_to_le32((unsigned int)dma_phy);
+			if (priv->plat->dma_cfg->dma64) {
+				p->des6 = cpu_to_le32((unsigned int)dma_phy);
+				p->des7 = cpu_to_le32(upper_32_bits(dma_phy));
+			} else {
+				p->basic.des3 = cpu_to_le32((unsigned int)dma_phy);
+			}
 			p++;
 		}
 		p->basic.des3 = cpu_to_le32((unsigned int)phy_addr);
@@ -130,6 +144,9 @@ static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 {
 	struct stmmac_priv *priv = rx_q->priv_data;
 
+	if (priv->plat->dma_cfg->dma64)
+		return;
+
 	if (priv->hwts_rx_en && !priv->extend_desc)
 		/* NOTE: Device will overwrite des3 with timestamp value if
 		 * 1588-2002 time stamping is enabled, hence reinitialize it
@@ -146,6 +163,9 @@ static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->dirty_tx;
 
+	if (priv->plat->dma_cfg->dma64)
+		return;
+
 	if (tx_q->tx_skbuff_dma[entry].last_segment && !priv->extend_desc &&
 	    priv->hwts_tx_en)
 		/* NOTE: Device will overwrite des3 with timestamp value if
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 16e67c18b6f7..90a7784f71cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -563,6 +563,7 @@ void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable);
 void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr);
 
 extern const struct stmmac_mode_ops ring_mode_ops;
+extern const struct stmmac_mode_ops ring_mode64_ops;
 extern const struct stmmac_mode_ops chain_mode_ops;
 extern const struct stmmac_desc_ops dwmac4_desc_ops;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/descs.h b/drivers/net/ethernet/stmicro/stmmac/descs.h
index 49d6a866244f..223b77f0271c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs.h
@@ -56,6 +56,9 @@
 #define ERDES1_BUFFER2_SIZE_SHIFT	16
 #define	ERDES1_DISABLE_IC		BIT(31)
 
+#define	E64RDES1_BUFFER1_SIZE_MASK	GENMASK(13, 0)
+#define	E64RDES1_BUFFER2_SIZE_MASK	GENMASK(29, 16)
+
 /* Normal transmit descriptor defines */
 /* TDES0 */
 #define	TDES0_DEFERRED			BIT(0)
@@ -122,6 +125,10 @@
 #define	ETDES1_BUFFER2_SIZE_MASK	GENMASK(28, 16)
 #define	ETDES1_BUFFER2_SIZE_SHIFT	16
 
+#define	E64TDES1_BUFFER1_SIZE_MASK	GENMASK(13, 0)
+#define	E64TDES1_BUFFER2_SIZE_MASK	GENMASK(28, 15)
+#define	E64TDES1_BUFFER2_SIZE_SHIFT	15
+
 /* Extended Receive descriptor definitions */
 #define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(6, 2)
 #define	ERDES4_IP_HDR_ERR		BIT(3)
diff --git a/drivers/net/ethernet/stmicro/stmmac/descs_com.h b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
index 40f7f2da9c5e..24f27088f7c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -20,12 +20,18 @@
 
 /* Enhanced descriptors */
 static inline void ehn_desc_rx_set_on_ring(struct dma_desc *p, int end,
-					   int bfsize)
+					   int bfsize, bool dma64)
 {
-	if (bfsize == BUF_SIZE_16KiB)
-		p->des1 |= cpu_to_le32((BUF_SIZE_8KiB
-				<< ERDES1_BUFFER2_SIZE_SHIFT)
-			   & ERDES1_BUFFER2_SIZE_MASK);
+	if (bfsize == BUF_SIZE_16KiB) {
+		if (dma64)
+			p->des1 |= cpu_to_le32((BUF_SIZE_8KiB
+					<< ERDES1_BUFFER2_SIZE_SHIFT)
+				   & E64RDES1_BUFFER2_SIZE_MASK);
+		else
+			p->des1 |= cpu_to_le32((BUF_SIZE_8KiB
+					<< ERDES1_BUFFER2_SIZE_SHIFT)
+				   & ERDES1_BUFFER2_SIZE_MASK);
+	}
 
 	if (end)
 		p->des1 |= cpu_to_le32(ERDES1_END_RING);
@@ -39,7 +45,7 @@ static inline void enh_desc_end_tx_desc_on_ring(struct dma_desc *p, int end)
 		p->des0 &= cpu_to_le32(~ETDES0_END_RING);
 }
 
-static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
+static inline void enh_set_tx_desc32_len_on_ring(struct dma_desc *p, int len)
 {
 	if (unlikely(len > BUF_SIZE_4KiB)) {
 		p->des1 |= cpu_to_le32((((len - BUF_SIZE_4KiB)
@@ -50,6 +56,27 @@ static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
 		p->des1 |= cpu_to_le32((len & ETDES1_BUFFER1_SIZE_MASK));
 }
 
+static inline void enh_set_tx_desc64_len_on_ring(struct dma_desc *p, int len)
+{
+	if (unlikely(len > BUF_SIZE_4KiB)) {
+		p->des1 |= cpu_to_le32((((len - BUF_SIZE_8KiB)
+					<< E64TDES1_BUFFER2_SIZE_SHIFT)
+			    & E64TDES1_BUFFER2_SIZE_MASK) | (BUF_SIZE_8KiB
+			    & E64TDES1_BUFFER1_SIZE_MASK));
+	} else {
+		p->des1 |= cpu_to_le32((len & E64TDES1_BUFFER1_SIZE_MASK));
+	}
+}
+
+static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len,
+					       bool dma64)
+{
+	if (dma64)
+		enh_set_tx_desc64_len_on_ring(p, len);
+	else
+		enh_set_tx_desc32_len_on_ring(p, len);
+}
+
 /* Normal descriptors */
 static inline void ndesc_rx_set_on_ring(struct dma_desc *p, int end, int bfsize)
 {
@@ -98,9 +125,13 @@ static inline void enh_desc_end_tx_desc_on_chain(struct dma_desc *p)
 	p->des0 |= cpu_to_le32(ETDES0_SECOND_ADDRESS_CHAINED);
 }
 
-static inline void enh_set_tx_desc_len_on_chain(struct dma_desc *p, int len)
+static inline void enh_set_tx_desc_len_on_chain(struct dma_desc *p, int len,
+						bool dma64)
 {
-	p->des1 |= cpu_to_le32(len & ETDES1_BUFFER1_SIZE_MASK);
+	if (dma64)
+		p->des1 |= cpu_to_le32(len & E64TDES1_BUFFER1_SIZE_MASK);
+	else
+		p->des1 |= cpu_to_le32(len & ETDES1_BUFFER1_SIZE_MASK);
 }
 
 /* Normal descriptors */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 4cec78180556..4773779b7be5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -112,6 +112,9 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	/* Mask interrupts by writing to CSR7 */
 	writel(mask, ioaddr + DMA_INTR_ENA);
+
+	if (dma_cfg->dma64)
+		writel(0x100, ioaddr + DMA_FUNC_CONFIG);
 }
 
 static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
@@ -168,11 +171,25 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_rx_phy, u32 chan)
 {
+	const struct dwmac_dma_addrs *addrs = priv->plat->dwmac_regs->addrs;
 	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
-	u32 addr = priv->plat->dwmac_regs->addrs->rcv_base_addr;
 
-	/* RX descriptor base address list must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + addr + chan * offset);
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_rx_phy), ioaddr + addrs->rcv_base_addr +
+		       chan * offset);
+		writel(upper_32_bits(dma_rx_phy), ioaddr + addrs->rcv_base_addr +
+		       0x4 + chan * offset);
+		if (addrs->rcv_base_addr_shadow1)
+			writel(upper_32_bits(dma_rx_phy),
+			       ioaddr + addrs->rcv_base_addr_shadow1);
+		if (addrs->rcv_base_addr_shadow2)
+			writel(upper_32_bits(dma_rx_phy),
+			       ioaddr + addrs->rcv_base_addr_shadow2);
+	} else {
+		/* RX descriptor base address list must be written into DMA CSR3 */
+		writel(lower_32_bits(dma_rx_phy), ioaddr + addrs->rcv_base_addr +
+		       chan * offset);
+	}
 }
 
 static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
@@ -183,8 +200,13 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
 	u32 offset = priv->plat->dwmac_regs->addrs->chan_offset;
 	u32 addr = priv->plat->dwmac_regs->addrs->tx_base_addr;
 
-	/* TX descriptor base address list must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + addr + chan * offset);
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_tx_phy), ioaddr + addr + chan * offset);
+		writel(upper_32_bits(dma_tx_phy), ioaddr + addr + 0x4 + chan * offset);
+	} else {
+		/* TX descriptor base address list must be written into DMA CSR4 */
+		writel(lower_32_bits(dma_tx_phy), ioaddr + addr + chan * offset);
+	}
 }
 
 static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 1932a3a8e03c..ee07006c97c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -11,6 +11,7 @@
 #include <linux/stmmac.h>
 #include "common.h"
 #include "descs_com.h"
+#include "stmmac.h"
 
 static int enh_desc_get_tx_status(struct net_device_stats *stats,
 				  struct stmmac_extra_stats *x,
@@ -81,7 +82,10 @@ static int enh_desc_get_tx_status(struct net_device_stats *stats,
 
 static int enh_desc_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
 {
-	return (le32_to_cpu(p->des1) & ETDES1_BUFFER1_SIZE_MASK);
+	if (priv->plat->dma_cfg->dma64)
+		return (le32_to_cpu(p->des1) & E64TDES1_BUFFER1_SIZE_MASK);
+	else
+		return (le32_to_cpu(p->des1) & ETDES1_BUFFER1_SIZE_MASK);
 }
 
 static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
@@ -263,12 +267,15 @@ static void enh_desc_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 
 	bfsize1 = min(bfsize, BUF_SIZE_8KiB);
-	p->des1 |= cpu_to_le32(bfsize1 & ERDES1_BUFFER1_SIZE_MASK);
+	if (priv->plat->dma_cfg->dma64)
+		p->des1 |= cpu_to_le32(bfsize1 & E64RDES1_BUFFER1_SIZE_MASK);
+	else
+		p->des1 |= cpu_to_le32(bfsize1 & ERDES1_BUFFER1_SIZE_MASK);
 
 	if (mode == STMMAC_CHAIN_MODE)
 		ehn_desc_rx_set_on_chain(p);
 	else
-		ehn_desc_rx_set_on_ring(p, end, bfsize);
+		ehn_desc_rx_set_on_ring(p, end, bfsize, priv->plat->dma_cfg->dma64);
 
 	if (disable_rx_ic)
 		p->des1 |= cpu_to_le32(ERDES1_DISABLE_IC);
@@ -321,9 +328,9 @@ static void enh_desc_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *
 	unsigned int tdes0 = le32_to_cpu(p->des0);
 
 	if (mode == STMMAC_CHAIN_MODE)
-		enh_set_tx_desc_len_on_chain(p, len);
+		enh_set_tx_desc_len_on_chain(p, len, priv->plat->dma_cfg->dma64);
 	else
-		enh_set_tx_desc_len_on_ring(p, len);
+		enh_set_tx_desc_len_on_ring(p, len, priv->plat->dma_cfg->dma64);
 
 	if (is_fs)
 		tdes0 |= ETDES0_FIRST_SEGMENT;
@@ -445,11 +452,15 @@ static void enh_desc_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
 			      dma_addr_t addr)
 {
 	p->des2 = cpu_to_le32(addr);
+	if (priv->plat->dma_cfg->dma64)
+		p->des3 = cpu_to_le32(upper_32_bits(addr));
 }
 
 static void enh_desc_clear(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des2 = 0;
+	if (priv->plat->dma_cfg->dma64)
+		p->des3 = 0;
 }
 
 const struct stmmac_desc_ops enh_desc_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 93cead5613e3..c5768bbec38e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -46,7 +46,10 @@ static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
 	} else {
 		dev_info(priv->device, "Ring mode enabled\n");
 		priv->mode = STMMAC_RING_MODE;
-		mac->mode = &ring_mode_ops;
+		if (priv->plat->dma_cfg->dma64)
+			mac->mode = &ring_mode64_ops;
+		else
+			mac->mode = &ring_mode_ops;
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode64.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode64.c
new file mode 100644
index 000000000000..ab23f1498b20
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode64.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*******************************************************************************
+  Specialised functions for managing Ring mode
+
+  It defines all the functions used to handle the normal/enhanced
+  descriptors in case of the DMA is configured to work in chained or
+  in ring mode.
+
+  Based on code taken from ring_mode.c which is:
+
+  Copyright(C) 2011  STMicroelectronics Ltd
+
+  Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
+*******************************************************************************/
+
+#include "stmmac.h"
+
+static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
+		     int csum)
+{
+	unsigned int nopaged_len = skb_headlen(skb);
+	struct stmmac_priv *priv = tx_q->priv_data;
+	unsigned int entry = tx_q->cur_tx;
+	struct dma_extended_desc *edesc;
+	unsigned int bmax, len, des2;
+	struct dma_desc *desc;
+
+	if (priv->extend_desc) {
+		edesc = tx_q->dma_etx + entry;
+		desc = (struct dma_desc *)edesc;
+	} else {
+		desc = tx_q->dma_tx + entry;
+	}
+
+	bmax = BUF_SIZE_8KiB;
+
+	len = nopaged_len - bmax * 2;
+
+	if (nopaged_len > bmax * 2) {
+		des2 = dma_map_single(priv->device, skb->data, bmax * 2,
+				      DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		desc->des3 = cpu_to_le32(upper_32_bits(des2));
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = bmax * 2;
+		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
+
+		edesc->des6 = cpu_to_le32(des2 + bmax);
+		edesc->des7 = cpu_to_le32(upper_32_bits(des2 + bmax));
+		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
+				       STMMAC_RING_MODE, 1, false, skb->len);
+
+		tx_q->tx_skbuff[entry] = NULL;
+		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		edesc = tx_q->dma_etx + entry;
+		desc = &edesc->basic;
+
+		des2 = dma_map_single(priv->device, skb->data + bmax, len,
+				      DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		desc->des3 = cpu_to_le32(upper_32_bits(des2));
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = len;
+		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
+
+		edesc->des6 = cpu_to_le32(des2 + bmax);
+		edesc->des7 = cpu_to_le32(upper_32_bits(des2 + bmax));
+		stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
+				       STMMAC_RING_MODE, 1, !skb_is_nonlinear(skb),
+				       skb->len);
+	} else {
+		des2 = dma_map_single(priv->device, skb->data,
+				      nopaged_len, DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		desc->des3 = cpu_to_le32(upper_32_bits(des2));
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = nopaged_len;
+		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
+		edesc->des6 = cpu_to_le32(des2 + bmax);
+		edesc->des7 = cpu_to_le32(upper_32_bits(des2 + bmax));
+		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
+				       STMMAC_RING_MODE, 1, !skb_is_nonlinear(skb),
+				       skb->len);
+	}
+
+	tx_q->cur_tx = entry;
+
+	return entry;
+}
+
+static unsigned int is_jumbo_frm(int len, int enh_desc)
+{
+	unsigned int ret = 0;
+
+	if (len >= BUF_SIZE_4KiB)
+		ret = 1;
+
+	return ret;
+}
+
+static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
+{
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
+	struct stmmac_priv *priv = rx_q->priv_data;
+
+	/* Fill DES3 in case of RING mode */
+	if (priv->dma_conf.dma_buf_sz >= BUF_SIZE_8KiB) {
+		edesc->des6 = cpu_to_le32(le32_to_cpu(edesc->basic.des2) +
+					  BUF_SIZE_8KiB);
+		edesc->des7 = cpu_to_le32(le32_to_cpu(edesc->basic.des3));
+	}
+}
+
+/* In ring mode we need to fill the desc3 because it is used as buffer */
+static void init_desc3(struct dma_desc *p)
+{
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
+
+	edesc->des6 = cpu_to_le32(le32_to_cpu(edesc->basic.des2) +
+				  BUF_SIZE_8KiB);
+	edesc->des7 = cpu_to_le32(le32_to_cpu(edesc->basic.des3));
+}
+
+static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
+{
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
+	unsigned int entry = tx_q->dirty_tx;
+
+	if (unlikely(tx_q->tx_skbuff_dma[entry].is_jumbo)) {
+		edesc->des6 = 0;
+		edesc->des7 = 0;
+	}
+}
+
+static int set_16kib_bfsize(int mtu)
+{
+	int ret = 0;
+
+	if (unlikely(mtu >= BUF_SIZE_8KiB))
+		ret = BUF_SIZE_16KiB;
+
+	return ret;
+}
+
+const struct stmmac_mode_ops ring_mode64_ops = {
+	.is_jumbo_frm = is_jumbo_frm,
+	.jumbo_frm = jumbo_frm,
+	.refill_desc3 = refill_desc3,
+	.init_desc3 = init_desc3,
+	.clean_desc3 = clean_desc3,
+	.set_16kib_bfsize = set_16kib_bfsize,
+};
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ab979efd57bf..7aca9171b3a8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -98,6 +98,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	bool multi_msi_en;
 	bool dche;
+	bool dma64;
 };
 
 #define AXI_BLEN	7
-- 
2.39.3


