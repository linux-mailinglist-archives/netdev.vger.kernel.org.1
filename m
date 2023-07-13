Return-Path: <netdev+bounces-17386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0FE751677
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF771C21232
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF3EBD;
	Thu, 13 Jul 2023 02:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F1A52
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:49:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D69410EC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:49:02 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8DxqOocZq9kE0AEAA--.2346S3;
	Thu, 13 Jul 2023 10:49:00 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxswbZq9khJgrAA--.34828S2;
	Thu, 13 Jul 2023 10:48:59 +0800 (CST)
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
Subject: [RFC PATCH 05/10] net: stmmac: dwmac1000: Add 64-bit DMA support
Date: Thu, 13 Jul 2023 10:48:50 +0800
Message-Id: <ef2c246c8f4ca60d979148024681825f945d4cdc.1689215889.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1689215889.git.chenfeiyang@loongson.cn>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxxswbZq9khJgrAA--.34828S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJw4DtF47GF1xCw4UGry7CFX_yoW8CFykKo
	ZrtFnay3yfXw1kX3yDKr1kJrnFqFnxW3s3C3yxC3yku39xZw1Yv3y7W3yrAw4Ykr1aqayU
	C3W8JFZ7ZFW7Kw1Dl-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYt7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some platforms have dwmac1000 implementations that support 64-bit
DMA. Extend the functions to add 64-bit DMA support.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  23 +++-
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 ++
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  49 ++++++---
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  30 ++++--
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  21 +++-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   | 101 ++++++++++++++----
 include/linux/stmmac.h                        |   1 +
 7 files changed, 183 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index a95866871f3e..c8d77cbd51bc 100644
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
@@ -110,7 +119,11 @@ static void init_dma_chain(struct stmmac_priv *priv, void *des,
 		struct dma_extended_desc *p = (struct dma_extended_desc *)des;
 		for (i = 0; i < (size - 1); i++) {
 			dma_phy += sizeof(struct dma_extended_desc);
-			p->basic.des3 = cpu_to_le32((unsigned int)dma_phy);
+			if (priv->plat->dma_cfg->dma64) {
+				p->des6 = cpu_to_le32((unsigned int)dma_phy);
+				p->des7 = cpu_to_le32(upper_32_bits(dma_phy));
+			} else
+				p->basic.des3 = cpu_to_le32((unsigned int)dma_phy);
 			p++;
 		}
 		p->basic.des3 = cpu_to_le32((unsigned int)phy_addr);
@@ -130,6 +143,9 @@ static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 {
 	struct stmmac_priv *priv = rx_q->priv_data;
 
+	if (priv->plat->dma_cfg->dma64)
+		return;
+
 	if (priv->hwts_rx_en && !priv->extend_desc)
 		/* NOTE: Device will overwrite des3 with timestamp value if
 		 * 1588-2002 time stamping is enabled, hence reinitialize it
@@ -146,6 +162,9 @@ static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->dirty_tx;
 
+	if (priv->plat->dma_cfg->dma64)
+		return;
+
 	if (tx_q->tx_skbuff_dma[entry].last_segment && !priv->extend_desc &&
 	    priv->hwts_tx_en)
 		/* NOTE: Device will overwrite des3 with timestamp value if
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
index 40f7f2da9c5e..c5e7f2e5aee8 100644
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
@@ -39,15 +45,26 @@ static inline void enh_desc_end_tx_desc_on_ring(struct dma_desc *p, int end)
 		p->des0 &= cpu_to_le32(~ETDES0_END_RING);
 }
 
-static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
+static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len,
+					       bool dma64)
 {
 	if (unlikely(len > BUF_SIZE_4KiB)) {
-		p->des1 |= cpu_to_le32((((len - BUF_SIZE_4KiB)
-					<< ETDES1_BUFFER2_SIZE_SHIFT)
-			    & ETDES1_BUFFER2_SIZE_MASK) | (BUF_SIZE_4KiB
-			    & ETDES1_BUFFER1_SIZE_MASK));
-	} else
-		p->des1 |= cpu_to_le32((len & ETDES1_BUFFER1_SIZE_MASK));
+		if (dma64)
+			p->des1 |= cpu_to_le32((((len - BUF_SIZE_8KiB)
+						<< E64TDES1_BUFFER2_SIZE_SHIFT)
+				    & E64TDES1_BUFFER2_SIZE_MASK) | (BUF_SIZE_8KiB
+				    & E64TDES1_BUFFER1_SIZE_MASK));
+		else
+			p->des1 |= cpu_to_le32((((len - BUF_SIZE_4KiB)
+						<< ETDES1_BUFFER2_SIZE_SHIFT)
+				    & ETDES1_BUFFER2_SIZE_MASK) | (BUF_SIZE_4KiB
+				    & ETDES1_BUFFER1_SIZE_MASK));
+	} else {
+		if (dma64)
+			p->des1 |= cpu_to_le32((len & E64TDES1_BUFFER1_SIZE_MASK));
+		else
+			p->des1 |= cpu_to_le32((len & ETDES1_BUFFER1_SIZE_MASK));
+	}
 }
 
 /* Normal descriptors */
@@ -98,9 +115,13 @@ static inline void enh_desc_end_tx_desc_on_chain(struct dma_desc *p)
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
index efb219999a20..632c4f110d01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct stmmac_axi *axi)
@@ -109,6 +110,9 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	/* Mask interrupts by writing to CSR7 */
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
+
+	if (dma_cfg->dma64)
+		writel(0x100, ioaddr + DMA_FUNC_CONFIG);
 }
 
 void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -163,9 +167,16 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_rx_phy, u32 chan)
 {
-	/* RX descriptor base address list must be written into DMA CSR3 */
-	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR +
-		chan * DMA_CHAN_OFFSET);
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR +
+		       chan * DMA_CHAN_OFFSET);
+		writel(upper_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR_HI +
+		       chan * DMA_CHAN_OFFSET);
+	} else {
+		/* RX descriptor base address list must be written into DMA CSR3 */
+		writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR +
+		       chan * DMA_CHAN_OFFSET);
+	}
 }
 
 static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
@@ -173,9 +184,16 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
 				  struct stmmac_dma_cfg *dma_cfg,
 				  dma_addr_t dma_tx_phy, u32 chan)
 {
-	/* TX descriptor base address list must be written into DMA CSR4 */
-	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR +
-		chan * DMA_CHAN_OFFSET);
+	if (dma_cfg->dma64) {
+		writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR +
+		       chan * DMA_CHAN_OFFSET);
+		writel(upper_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR_HI +
+		       chan * DMA_CHAN_OFFSET);
+	} else {
+		/* TX descriptor base address list must be written into DMA CSR4 */
+		writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR +
+		       chan * DMA_CHAN_OFFSET);
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 49dd6ea07416..2b664a51a4f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -21,10 +21,14 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
 	unsigned int bmax, len, des2;
+	unsigned int bmax2, len2;
+	struct dma_extended_desc *edesc;
 	struct dma_desc *desc;
 
-	if (priv->extend_desc)
-		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
+	if (priv->extend_desc) {
+		edesc = tx_q->dma_etx + entry;
+		desc = (struct dma_desc *)edesc;
+	}
 	else
 		desc = tx_q->dma_tx + entry;
 
@@ -33,23 +37,37 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	else
 		bmax = BUF_SIZE_2KiB;
 
-	len = nopaged_len - bmax;
+	if (priv->plat->dma_cfg->dma64) {
+		bmax2 = bmax * 2;
+		len2 = bmax2;
+	} else {
+		bmax2 = bmax;
+		len2 = BUF_SIZE_8KiB;
+	}
+	len = nopaged_len - bmax2;
 
-	if (nopaged_len > BUF_SIZE_8KiB) {
+	if (nopaged_len > len2) {
 
-		des2 = dma_map_single(priv->device, skb->data, bmax,
+		des2 = dma_map_single(priv->device, skb->data, bmax2,
 				      DMA_TO_DEVICE);
 		desc->des2 = cpu_to_le32(des2);
+		if (priv->plat->dma_cfg->dma64)
+			desc->des3 = cpu_to_le32(upper_32_bits(des2));
 		if (dma_mapping_error(priv->device, des2))
 			return -1;
 
 		tx_q->tx_skbuff_dma[entry].buf = des2;
-		tx_q->tx_skbuff_dma[entry].len = bmax;
+		tx_q->tx_skbuff_dma[entry].len = bmax2;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 
-		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
+		if (priv->plat->dma_cfg->dma64) {
+			edesc->des6 = cpu_to_le32(des2 + bmax);
+			edesc->des7 = cpu_to_le32(upper_32_bits(edesc->des6));
+		} else
+			desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
-				STMMAC_RING_MODE, 0, false, skb->len);
+				STMMAC_RING_MODE, priv->plat->dma_cfg->dma64,
+				false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
 		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 
@@ -61,13 +79,19 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		des2 = dma_map_single(priv->device, skb->data + bmax, len,
 				      DMA_TO_DEVICE);
 		desc->des2 = cpu_to_le32(des2);
+		if (priv->plat->dma_cfg->dma64)
+			desc->des3 = cpu_to_le32(upper_32_bits(des2));
 		if (dma_mapping_error(priv->device, des2))
 			return -1;
 		tx_q->tx_skbuff_dma[entry].buf = des2;
 		tx_q->tx_skbuff_dma[entry].len = len;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 
-		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
+		if (priv->plat->dma_cfg->dma64) {
+			edesc->des6 = cpu_to_le32(des2 + bmax);
+			edesc->des7 = cpu_to_le32(upper_32_bits(edesc->des6));
+		} else
+			desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
 				STMMAC_RING_MODE, 1, !skb_is_nonlinear(skb),
 				skb->len);
@@ -82,8 +106,8 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
-				STMMAC_RING_MODE, 0, !skb_is_nonlinear(skb),
-				skb->len);
+				STMMAC_RING_MODE, priv->plat->dma_cfg->dma64,
+				!skb_is_nonlinear(skb), skb->len);
 	}
 
 	tx_q->cur_tx = entry;
@@ -103,36 +127,69 @@ static unsigned int is_jumbo_frm(int len, int enh_desc)
 
 static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 {
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
 	struct stmmac_priv *priv = rx_q->priv_data;
 
-	/* Fill DES3 in case of RING mode */
-	if (priv->dma_conf.dma_buf_sz == BUF_SIZE_16KiB)
-		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
+	if (priv->plat->dma_cfg->dma64) {
+		if (priv->dma_conf.dma_buf_sz >= BUF_SIZE_8KiB) {
+			edesc->des6 = cpu_to_le32(le32_to_cpu(edesc->basic.des2) +
+						BUF_SIZE_8KiB);
+			edesc->des7 = cpu_to_le32(le32_to_cpu(edesc->basic.des3));
+		}
+	} else {
+		/* Fill DES3 in case of RING mode */
+		if (priv->dma_conf.dma_buf_sz == BUF_SIZE_16KiB)
+			p->des3 = cpu_to_le32(le32_to_cpu(p->des2) +
+					BUF_SIZE_8KiB);
+	}
 }
 
 /* In ring mode we need to fill the desc3 because it is used as buffer */
 static void init_desc3(struct stmmac_priv *priv, struct dma_desc *p)
 {
-	p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
+
+	if (priv->plat->dma_cfg->dma64) {
+		edesc->des6 = cpu_to_le32(le32_to_cpu(edesc->basic.des2) +
+					BUF_SIZE_8KiB);
+		edesc->des7 = cpu_to_le32(le32_to_cpu(edesc->basic.des3));
+	} else
+		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) +
+				BUF_SIZE_8KiB);
 }
 
 static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 {
+	struct dma_extended_desc *edesc = (struct dma_extended_desc *)p;
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->dirty_tx;
 
-	/* des3 is only used for jumbo frames tx or time stamping */
-	if (unlikely(tx_q->tx_skbuff_dma[entry].is_jumbo ||
-		     (tx_q->tx_skbuff_dma[entry].last_segment &&
-		      !priv->extend_desc && priv->hwts_tx_en)))
-		p->des3 = 0;
+	if (priv->plat->dma_cfg->dma64) {
+		if (unlikely(tx_q->tx_skbuff_dma[entry].is_jumbo)) {
+			edesc->des6 = 0;
+			edesc->des7 = 0;
+		}
+	} else {
+		/* des3 is only used for jumbo frames tx or time stamping */
+		if (unlikely(tx_q->tx_skbuff_dma[entry].is_jumbo ||
+			     (tx_q->tx_skbuff_dma[entry].last_segment &&
+			      !priv->extend_desc && priv->hwts_tx_en)))
+			p->des3 = 0;
+	}
 }
 
 static int set_16kib_bfsize(struct stmmac_priv *priv, int mtu)
 {
 	int ret = 0;
-	if (unlikely(mtu > BUF_SIZE_8KiB))
-		ret = BUF_SIZE_16KiB;
+
+	if (priv->plat->dma_cfg->dma64) {
+		if (unlikely(mtu >= BUF_SIZE_8KiB))
+			ret = BUF_SIZE_16KiB;
+	} else {
+		if (unlikely(mtu > BUF_SIZE_8KiB))
+			ret = BUF_SIZE_16KiB;
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ff539681a3a4..f9af24f760d4 100644
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


