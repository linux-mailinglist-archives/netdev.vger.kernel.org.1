Return-Path: <netdev+bounces-21732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C8764845
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F71281E40
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0DBC12B;
	Thu, 27 Jul 2023 07:17:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712CC125
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:17:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 807B07AA1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:16:58 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8Cx5_HBGcJkcpsKAA--.26476S3;
	Thu, 27 Jul 2023 15:16:17 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ8y8GcJkkrY8AA--.56466S3;
	Thu, 27 Jul 2023 15:16:13 +0800 (CST)
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
Subject: [PATCH v2 01/10] net: stmmac: Pass stmmac_priv and chan in some callbacks
Date: Thu, 27 Jul 2023 15:15:45 +0800
Message-Id: <3aa0b91083da680e8a61bc4afb092fa4a8385673.1690439335.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1690439335.git.chenfeiyang@loongson.cn>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxJ8y8GcJkkrY8AA--.56466S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWDXw1kAF45Jry5Cry8tF4kZrc_yoWrWw1kKo
	WxAFnxt3WSqw18ur97KF18JFy3X3W3Ww1rCrZrCrs5uayxAa1Yvry2qrWfJ3WUXr1fWFW2
	va48ta1qyFW7Kw45l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Loongson GMAC and GNET have many extended features. To prepare for
that, pass stmmac_priv and chan to more callbacks, and adjust the
callbacks accordingly.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 20 +++--
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  9 ++-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  8 +-
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  9 ++-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 11 ++-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 19 ++---
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  8 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  3 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 11 ++-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 17 ++--
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  8 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    | 17 ++--
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 77 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/norm_desc.c   | 17 ++--
 .../net/ethernet/stmicro/stmmac/ring_mode.c   |  4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +-
 19 files changed, 145 insertions(+), 109 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index fb55efd52240..a95866871f3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -95,8 +95,9 @@ static unsigned int is_jumbo_frm(int len, int enh_desc)
 	return ret;
 }
 
-static void init_dma_chain(void *des, dma_addr_t phy_addr,
-				  unsigned int size, unsigned int extend_desc)
+static void init_dma_chain(struct stmmac_priv *priv, void *des,
+			   dma_addr_t phy_addr, unsigned int size,
+			   unsigned int extend_desc)
 {
 	/*
 	 * In chained mode the des3 points to the next element in the ring.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 1e714380d125..e4e1624f81f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -297,7 +297,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
 /* sun8i_dwmac_dma_init() - initialize the EMAC
  * Called from stmmac via stmmac_dma_ops->init
  */
-static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
+static void sun8i_dwmac_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
@@ -394,7 +394,8 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
 	writel(v, ioaddr + EMAC_TX_CTL1);
 }
 
-static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
+static void sun8i_dwmac_enable_dma_transmission(struct stmmac_priv *priv,
+						void __iomem *ioaddr, u32 chan)
 {
 	u32 v;
 
@@ -636,7 +637,8 @@ static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
  * All slot > 0 need to be enabled with MAC_ADDR_TYPE_DST
  * If addr is NULL, clear the slot
  */
-static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
+static void sun8i_dwmac_set_umac_addr(struct stmmac_priv *priv,
+				      struct mac_device_info *hw,
 				      const unsigned char *addr,
 				      unsigned int reg_n)
 {
@@ -657,7 +659,8 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
 	}
 }
 
-static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
+static void sun8i_dwmac_get_umac_addr(struct stmmac_priv *priv,
+				      struct mac_device_info *hw,
 				      unsigned char *addr,
 				      unsigned int reg_n)
 {
@@ -680,7 +683,8 @@ static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
 	return 1;
 }
 
-static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
+static void sun8i_dwmac_set_filter(struct stmmac_priv *priv,
+				   struct mac_device_info *hw,
 				   struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -698,13 +702,13 @@ static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
 	} else if (macaddrs <= hw->unicast_filter_entries) {
 		if (!netdev_mc_empty(dev)) {
 			netdev_for_each_mc_addr(ha, dev) {
-				sun8i_dwmac_set_umac_addr(hw, ha->addr, i);
+				sun8i_dwmac_set_umac_addr(priv, hw, ha->addr, i);
 				i++;
 			}
 		}
 		if (!netdev_uc_empty(dev)) {
 			netdev_for_each_uc_addr(ha, dev) {
-				sun8i_dwmac_set_umac_addr(hw, ha->addr, i);
+				sun8i_dwmac_set_umac_addr(priv, hw, ha->addr, i);
 				i++;
 			}
 		}
@@ -716,7 +720,7 @@ static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
 
 	/* Disable unused address filter slots */
 	while (i < hw->unicast_filter_entries)
-		sun8i_dwmac_set_umac_addr(hw, NULL, i++);
+		sun8i_dwmac_set_umac_addr(priv, hw, NULL, i++);
 
 	writel(v, ioaddr + EMAC_RX_FRM_FLT);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3927609abc44..b52793edf62f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -94,7 +94,8 @@ static void dwmac1000_dump_regs(struct mac_device_info *hw, u32 *reg_space)
 		reg_space[i] = readl(ioaddr + i * 4);
 }
 
-static void dwmac1000_set_umac_addr(struct mac_device_info *hw,
+static void dwmac1000_set_umac_addr(struct stmmac_priv *priv,
+				    struct mac_device_info *hw,
 				    const unsigned char *addr,
 				    unsigned int reg_n)
 {
@@ -103,7 +104,8 @@ static void dwmac1000_set_umac_addr(struct mac_device_info *hw,
 			    GMAC_ADDR_LOW(reg_n));
 }
 
-static void dwmac1000_get_umac_addr(struct mac_device_info *hw,
+static void dwmac1000_get_umac_addr(struct stmmac_priv *priv,
+				    struct mac_device_info *hw,
 				    unsigned char *addr,
 				    unsigned int reg_n)
 {
@@ -137,7 +139,8 @@ static void dwmac1000_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
 		       ioaddr + GMAC_EXTHASH_BASE + regs * 4);
 }
 
-static void dwmac1000_set_filter(struct mac_device_info *hw,
+static void dwmac1000_set_filter(struct stmmac_priv *priv,
+				 struct mac_device_info *hw,
 				 struct net_device *dev)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..ce0e6ca6f3a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -16,7 +16,8 @@
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
 
-static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
+static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
+			      struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + DMA_AXI_BUS_MODE);
 	int i;
@@ -70,7 +71,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
 
-static void dwmac1000_dma_init(void __iomem *ioaddr,
+static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
@@ -223,7 +224,8 @@ static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
 				readl(ioaddr + DMA_BUS_MODE + i * 4);
 }
 
-static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
+static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
+				    void __iomem *ioaddr,
 				    struct dma_features *dma_cap)
 {
 	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index a6e8d7bd9588..c03623edeb75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -59,7 +59,8 @@ static int dwmac100_irq_status(struct mac_device_info *hw,
 	return 0;
 }
 
-static void dwmac100_set_umac_addr(struct mac_device_info *hw,
+static void dwmac100_set_umac_addr(struct stmmac_priv *priv,
+				   struct mac_device_info *hw,
 				   const unsigned char *addr,
 				   unsigned int reg_n)
 {
@@ -67,7 +68,8 @@ static void dwmac100_set_umac_addr(struct mac_device_info *hw,
 	stmmac_set_mac_addr(ioaddr, addr, MAC_ADDR_HIGH, MAC_ADDR_LOW);
 }
 
-static void dwmac100_get_umac_addr(struct mac_device_info *hw,
+static void dwmac100_get_umac_addr(struct stmmac_priv *priv,
+				   struct mac_device_info *hw,
 				   unsigned char *addr,
 				   unsigned int reg_n)
 {
@@ -75,7 +77,8 @@ static void dwmac100_get_umac_addr(struct mac_device_info *hw,
 	stmmac_get_mac_addr(ioaddr, addr, MAC_ADDR_HIGH, MAC_ADDR_LOW);
 }
 
-static void dwmac100_set_filter(struct mac_device_info *hw,
+static void dwmac100_set_filter(struct stmmac_priv *priv,
+				struct mac_device_info *hw,
 				struct net_device *dev)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index 1c32b1788f02..e6ae230fa453 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -18,7 +18,7 @@
 #include "dwmac100.h"
 #include "dwmac_dma.h"
 
-static void dwmac100_dma_init(void __iomem *ioaddr,
+static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	/* Enable Application Access by writing to DMA CSR0 */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 03b1c5a97826..536928ccacf9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -330,7 +330,8 @@ static void dwmac4_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(pmt, ioaddr + GMAC_PMT);
 }
 
-static void dwmac4_set_umac_addr(struct mac_device_info *hw,
+static void dwmac4_set_umac_addr(struct stmmac_priv *priv,
+				 struct mac_device_info *hw,
 				 const unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -339,7 +340,8 @@ static void dwmac4_set_umac_addr(struct mac_device_info *hw,
 				   GMAC_ADDR_LOW(reg_n));
 }
 
-static void dwmac4_get_umac_addr(struct mac_device_info *hw,
+static void dwmac4_get_umac_addr(struct stmmac_priv *priv,
+				 struct mac_device_info *hw,
 				 unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -588,7 +590,8 @@ static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
 	}
 }
 
-static void dwmac4_set_filter(struct mac_device_info *hw,
+static void dwmac4_set_filter(struct stmmac_priv *priv,
+			      struct mac_device_info *hw,
 			      struct net_device *dev)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
@@ -664,7 +667,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 		int reg = 1;
 
 		netdev_for_each_uc_addr(ha, dev) {
-			dwmac4_set_umac_addr(hw, ha->addr, reg);
+			dwmac4_set_umac_addr(priv, hw, ha->addr, reg);
 			reg++;
 		}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 6a011d8633e8..98061986c5f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -175,7 +175,7 @@ static int dwmac4_wrback_get_rx_status(struct net_device_stats *stats,
 	return ret;
 }
 
-static int dwmac4_rd_get_tx_len(struct dma_desc *p)
+static int dwmac4_rd_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des2) & TDES2_BUFFER1_SIZE_MASK);
 }
@@ -296,8 +296,8 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
 	return 0;
 }
 
-static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				   int mode, int end, int bfsize)
+static void dwmac4_rd_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				   int disable_rx_ic, int mode, int end, int bfsize)
 {
 	dwmac4_set_rx_owner(p, disable_rx_ic);
 }
@@ -310,9 +310,9 @@ static void dwmac4_rd_init_tx_desc(struct dma_desc *p, int mode, int end)
 	p->des3 = 0;
 }
 
-static void dwmac4_rd_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				      bool csum_flag, int mode, bool tx_own,
-				      bool ls, unsigned int tot_pkt_len)
+static void dwmac4_rd_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				      int is_fs, int len, bool csum_flag, int mode,
+				      bool tx_own, bool ls, unsigned int tot_pkt_len)
 {
 	unsigned int tdes3 = le32_to_cpu(p->des3);
 
@@ -462,13 +462,14 @@ static void dwmac4_set_mss_ctxt(struct dma_desc *p, unsigned int mss)
 	p->des3 = cpu_to_le32(TDES3_CONTEXT_TYPE | TDES3_CTXT_TCMSSV);
 }
 
-static void dwmac4_set_addr(struct dma_desc *p, dma_addr_t addr)
+static void dwmac4_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
+			    dma_addr_t addr)
 {
 	p->des0 = cpu_to_le32(lower_32_bits(addr));
 	p->des1 = cpu_to_le32(upper_32_bits(addr));
 }
 
-static void dwmac4_clear(struct dma_desc *p)
+static void dwmac4_clear(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des0 = 0;
 	p->des1 = 0;
@@ -483,7 +484,7 @@ static void dwmac4_set_sarc(struct dma_desc *p, u32 sarc_type)
 	p->des3 |= cpu_to_le32(sarc_type & TDES3_SA_INSERT_CTRL_MASK);
 }
 
-static int set_16kib_bfsize(int mtu)
+static int set_16kib_bfsize(struct stmmac_priv *priv, int mtu)
 {
 	int ret = 0;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..97dad00dc850 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -15,7 +15,8 @@
 #include "dwmac4_dma.h"
 #include "stmmac.h"
 
-static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
+static void dwmac4_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
+			   struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
 	int i;
@@ -152,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
-static void dwmac4_dma_init(void __iomem *ioaddr,
+static void dwmac4_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
@@ -374,7 +375,8 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
 	writel(mtl_tx_op, ioaddr +  MTL_CHAN_TX_OP_MODE(dwmac4_addrs, channel));
 }
 
-static int dwmac4_get_hw_feature(void __iomem *ioaddr,
+static int dwmac4_get_hw_feature(struct stmmac_priv *priv,
+				 void __iomem *ioaddr,
 				 struct dma_features *dma_cap)
 {
 	u32 hw_cap = readl(ioaddr + GMAC_HW_FEATURE0);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 72672391675f..e7aef136824b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -152,7 +152,8 @@
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
 
-void dwmac_enable_dma_transmission(void __iomem *ioaddr);
+void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
+				   void __iomem *ioaddr, u32 chan);
 void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 chan, bool rx, bool tx);
 void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 0b6f999a8305..2dd457032187 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -27,7 +27,8 @@ int dwmac_dma_reset(void __iomem *ioaddr)
 }
 
 /* CSR1 enables the transmit DMA to check for new descriptor */
-void dwmac_enable_dma_transmission(void __iomem *ioaddr)
+void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
+				   void __iomem *ioaddr, u32 chan)
 {
 	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..640c1b4a0c14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -337,7 +337,8 @@ static void dwxgmac2_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(val, ioaddr + XGMAC_PMT);
 }
 
-static void dwxgmac2_set_umac_addr(struct mac_device_info *hw,
+static void dwxgmac2_set_umac_addr(struct stmmac_priv *priv,
+				   struct mac_device_info *hw,
 				   const unsigned char *addr,
 				   unsigned int reg_n)
 {
@@ -351,7 +352,8 @@ static void dwxgmac2_set_umac_addr(struct mac_device_info *hw,
 	writel(value, ioaddr + XGMAC_ADDRx_LOW(reg_n));
 }
 
-static void dwxgmac2_get_umac_addr(struct mac_device_info *hw,
+static void dwxgmac2_get_umac_addr(struct stmmac_priv *priv,
+				   struct mac_device_info *hw,
 				   unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -440,7 +442,8 @@ static void dwxgmac2_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
 		writel(mcfilterbits[regs], ioaddr + XGMAC_HASH_TABLE(regs));
 }
 
-static void dwxgmac2_set_filter(struct mac_device_info *hw,
+static void dwxgmac2_set_filter(struct stmmac_priv *priv,
+				struct mac_device_info *hw,
 				struct net_device *dev)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
@@ -485,7 +488,7 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 		int reg = 1;
 
 		netdev_for_each_uc_addr(ha, dev) {
-			dwxgmac2_set_umac_addr(hw, ha->addr, reg);
+			dwxgmac2_set_umac_addr(priv, hw, ha->addr, reg);
 			reg++;
 		}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 13c347ee8be9..e6fb47563fc0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -41,7 +41,7 @@ static int dwxgmac2_get_rx_status(struct net_device_stats *stats,
 	return good_frame;
 }
 
-static int dwxgmac2_get_tx_len(struct dma_desc *p)
+static int dwxgmac2_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des2) & XGMAC_TDES2_B1L);
 }
@@ -128,8 +128,8 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
 	return !ret;
 }
 
-static void dwxgmac2_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				  int mode, int end, int bfsize)
+static void dwxgmac2_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				  int disable_rx_ic, int mode, int end, int bfsize)
 {
 	dwxgmac2_set_rx_owner(p, disable_rx_ic);
 }
@@ -142,9 +142,9 @@ static void dwxgmac2_init_tx_desc(struct dma_desc *p, int mode, int end)
 	p->des3 = 0;
 }
 
-static void dwxgmac2_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				     bool csum_flag, int mode, bool tx_own,
-				     bool ls, unsigned int tot_pkt_len)
+static void dwxgmac2_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				     int is_fs, int len, bool csum_flag, int mode,
+				     bool tx_own, bool ls, unsigned int tot_pkt_len)
 {
 	unsigned int tdes3 = le32_to_cpu(p->des3);
 
@@ -241,13 +241,14 @@ static void dwxgmac2_set_mss(struct dma_desc *p, unsigned int mss)
 	p->des3 = cpu_to_le32(XGMAC_TDES3_CTXT | XGMAC_TDES3_TCMSSV);
 }
 
-static void dwxgmac2_set_addr(struct dma_desc *p, dma_addr_t addr)
+static void dwxgmac2_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
+			      dma_addr_t addr)
 {
 	p->des0 = cpu_to_le32(lower_32_bits(addr));
 	p->des1 = cpu_to_le32(upper_32_bits(addr));
 }
 
-static void dwxgmac2_clear(struct dma_desc *p)
+static void dwxgmac2_clear(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des0 = 0;
 	p->des1 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 070bd912580b..08b305f95f97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -19,7 +19,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 				  !(value & XGMAC_SWR), 0, 100000);
 }
 
-static void dwxgmac2_dma_init(void __iomem *ioaddr,
+static void dwxgmac2_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
@@ -81,7 +81,8 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
 }
 
-static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
+static void dwxgmac2_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
+			     struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
 	int i;
@@ -384,7 +385,8 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	return ret;
 }
 
-static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
+static int dwxgmac2_get_hw_feature(struct stmmac_priv *priv,
+				   void __iomem *ioaddr,
 				   struct dma_features *dma_cap)
 {
 	u32 hw_cap;
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index a91d8f13a931..1932a3a8e03c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -79,7 +79,7 @@ static int enh_desc_get_tx_status(struct net_device_stats *stats,
 	return ret;
 }
 
-static int enh_desc_get_tx_len(struct dma_desc *p)
+static int enh_desc_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des1) & ETDES1_BUFFER1_SIZE_MASK);
 }
@@ -255,8 +255,8 @@ static int enh_desc_get_rx_status(struct net_device_stats *stats,
 	return ret;
 }
 
-static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				  int mode, int end, int bfsize)
+static void enh_desc_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				  int disable_rx_ic, int mode, int end, int bfsize)
 {
 	int bfsize1;
 
@@ -314,9 +314,9 @@ static void enh_desc_release_tx_desc(struct dma_desc *p, int mode)
 		enh_desc_end_tx_desc_on_ring(p, ter);
 }
 
-static void enh_desc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				     bool csum_flag, int mode, bool tx_own,
-				     bool ls, unsigned int tot_pkt_len)
+static void enh_desc_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				     int is_fs, int len, bool csum_flag, int mode,
+				     bool tx_own, bool ls, unsigned int tot_pkt_len)
 {
 	unsigned int tdes0 = le32_to_cpu(p->des0);
 
@@ -441,12 +441,13 @@ static void enh_desc_display_ring(void *head, unsigned int size, bool rx,
 	pr_info("\n");
 }
 
-static void enh_desc_set_addr(struct dma_desc *p, dma_addr_t addr)
+static void enh_desc_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
+			      dma_addr_t addr)
 {
 	p->des2 = cpu_to_le32(addr);
 }
 
-static void enh_desc_clear(struct dma_desc *p)
+static void enh_desc_clear(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des2 = 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 6ee7cf07cfd7..ed083112c8f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -35,14 +35,14 @@ struct dma_edesc;
 /* Descriptors helpers */
 struct stmmac_desc_ops {
 	/* DMA RX descriptor ring initialization */
-	void (*init_rx_desc)(struct dma_desc *p, int disable_rx_ic, int mode,
-			int end, int bfsize);
+	void (*init_rx_desc)(struct stmmac_priv *priv, struct dma_desc *p,
+			int disable_rx_ic, int mode, int end, int bfsize);
 	/* DMA TX descriptor ring initialization */
 	void (*init_tx_desc)(struct dma_desc *p, int mode, int end);
 	/* Invoked by the xmit function to prepare the tx descriptor */
-	void (*prepare_tx_desc)(struct dma_desc *p, int is_fs, int len,
-			bool csum_flag, int mode, bool tx_own, bool ls,
-			unsigned int tot_pkt_len);
+	void (*prepare_tx_desc)(struct stmmac_priv *priv, struct dma_desc *p,
+			int is_fs, int len, bool csum_flag, int mode,
+			bool tx_own, bool ls, unsigned int tot_pkt_len);
 	void (*prepare_tso_tx_desc)(struct dma_desc *p, int is_fs, int len1,
 			int len2, bool tx_own, bool ls, unsigned int tcphdrlen,
 			unsigned int tcppayloadlen);
@@ -61,7 +61,7 @@ struct stmmac_desc_ops {
 			 struct stmmac_extra_stats *x,
 			 struct dma_desc *p, void __iomem *ioaddr);
 	/* Get the buffer size from the descriptor */
-	int (*get_tx_len)(struct dma_desc *p);
+	int (*get_tx_len)(struct stmmac_priv *priv, struct dma_desc *p);
 	/* Handle extra events on specific interrupts hw dependent */
 	void (*set_rx_owner)(struct dma_desc *p, int disable_rx_ic);
 	/* Get the receive frame size */
@@ -87,9 +87,10 @@ struct stmmac_desc_ops {
 	/* set MSS via context descriptor */
 	void (*set_mss)(struct dma_desc *p, unsigned int mss);
 	/* set descriptor skbuff address */
-	void (*set_addr)(struct dma_desc *p, dma_addr_t addr);
+	void (*set_addr)(struct stmmac_priv *priv, struct dma_desc *p,
+			dma_addr_t addr);
 	/* clear descriptor */
-	void (*clear)(struct dma_desc *p);
+	void (*clear)(struct stmmac_priv *priv, struct dma_desc *p);
 	/* RSS */
 	int (*get_rx_hash)(struct dma_desc *p, u32 *hash,
 			   enum pkt_hash_types *type);
@@ -103,11 +104,11 @@ struct stmmac_desc_ops {
 };
 
 #define stmmac_init_rx_desc(__priv, __args...) \
-	stmmac_do_void_callback(__priv, desc, init_rx_desc, __args)
+	stmmac_do_void_callback(__priv, desc, init_rx_desc, __priv, __args)
 #define stmmac_init_tx_desc(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, init_tx_desc, __args)
 #define stmmac_prepare_tx_desc(__priv, __args...) \
-	stmmac_do_void_callback(__priv, desc, prepare_tx_desc, __args)
+	stmmac_do_void_callback(__priv, desc, prepare_tx_desc, __priv, __args)
 #define stmmac_prepare_tso_tx_desc(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, prepare_tso_tx_desc, __args)
 #define stmmac_set_tx_owner(__priv, __args...) \
@@ -123,7 +124,7 @@ struct stmmac_desc_ops {
 #define stmmac_tx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, tx_status, __args)
 #define stmmac_get_tx_len(__priv, __args...) \
-	stmmac_do_callback(__priv, desc, get_tx_len, __args)
+	stmmac_do_callback(__priv, desc, get_tx_len, __priv, __args)
 #define stmmac_set_rx_owner(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
 #define stmmac_get_rx_frame_len(__priv, __args...) \
@@ -145,9 +146,9 @@ struct stmmac_desc_ops {
 #define stmmac_set_mss(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_mss, __args)
 #define stmmac_set_desc_addr(__priv, __args...) \
-	stmmac_do_void_callback(__priv, desc, set_addr, __args)
+	stmmac_do_void_callback(__priv, desc, set_addr, __priv, __args)
 #define stmmac_clear_desc(__priv, __args...) \
-	stmmac_do_void_callback(__priv, desc, clear, __args)
+	stmmac_do_void_callback(__priv, desc, clear, __priv, __args)
 #define stmmac_get_rx_hash(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_rx_hash, __args)
 #define stmmac_get_rx_header_len(__priv, __args...) \
@@ -170,8 +171,8 @@ struct dma_features;
 struct stmmac_dma_ops {
 	/* DMA core initialization */
 	int (*reset)(void __iomem *ioaddr);
-	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
-		     int atds);
+	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
+		     struct stmmac_dma_cfg *dma_cfg, int atds);
 	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
 	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -181,7 +182,8 @@ struct stmmac_dma_ops {
 			     struct stmmac_dma_cfg *dma_cfg,
 			     dma_addr_t phy, u32 chan);
 	/* Configure the AXI Bus Mode Register */
-	void (*axi)(void __iomem *ioaddr, struct stmmac_axi *axi);
+	void (*axi)(struct stmmac_priv *priv, void __iomem *ioaddr,
+		    struct stmmac_axi *axi);
 	/* Dump DMA registers */
 	void (*dump_regs)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  u32 *reg_space);
@@ -194,7 +196,8 @@ struct stmmac_dma_ops {
 	void (*dma_diagnostic_fr)(struct net_device_stats *stats,
 				  struct stmmac_extra_stats *x,
 				  void __iomem *ioaddr);
-	void (*enable_dma_transmission) (void __iomem *ioaddr);
+	void (*enable_dma_transmission)(struct stmmac_priv *priv,
+					void __iomem *ioaddr, u32 chan);
 	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			       u32 chan, bool rx, bool tx);
 	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -210,7 +213,7 @@ struct stmmac_dma_ops {
 	int (*dma_interrupt)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			     struct stmmac_extra_stats *x, u32 chan, u32 dir);
 	/* If supported then get the optional core features */
-	int (*get_hw_feature)(void __iomem *ioaddr,
+	int (*get_hw_feature)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			      struct dma_features *dma_cap);
 	/* Program the HW RX Watchdog */
 	void (*rx_watchdog)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -236,7 +239,7 @@ struct stmmac_dma_ops {
 };
 
 #define stmmac_dma_init(__priv, __args...) \
-	stmmac_do_void_callback(__priv, dma, init, __args)
+	stmmac_do_void_callback(__priv, dma, init, __priv, __args)
 #define stmmac_init_chan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
 #define stmmac_init_rx_chan(__priv, __args...) \
@@ -244,7 +247,7 @@ struct stmmac_dma_ops {
 #define stmmac_init_tx_chan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, init_tx_chan, __priv, __args)
 #define stmmac_axi(__priv, __args...) \
-	stmmac_do_void_callback(__priv, dma, axi, __args)
+	stmmac_do_void_callback(__priv, dma, axi, __priv, __args)
 #define stmmac_dump_dma_regs(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, dump_regs, __priv, __args)
 #define stmmac_dma_rx_mode(__priv, __args...) \
@@ -254,7 +257,7 @@ struct stmmac_dma_ops {
 #define stmmac_dma_diagnostic_fr(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
 #define stmmac_enable_dma_transmission(__priv, __args...) \
-	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
+	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __priv, __args)
 #define stmmac_enable_dma_irq(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
 #define stmmac_disable_dma_irq(__priv, __args...) \
@@ -270,7 +273,7 @@ struct stmmac_dma_ops {
 #define stmmac_dma_interrupt_status(__priv, __args...) \
 	stmmac_do_callback(__priv, dma, dma_interrupt, __priv, __args)
 #define stmmac_get_hw_feature(__priv, __args...) \
-	stmmac_do_callback(__priv, dma, get_hw_feature, __args)
+	stmmac_do_callback(__priv, dma, get_hw_feature, __priv, __args)
 #define stmmac_rx_watchdog(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, rx_watchdog, __priv, __args)
 #define stmmac_set_tx_ring_len(__priv, __args...) \
@@ -340,17 +343,21 @@ struct stmmac_ops {
 	int (*host_mtl_irq_status)(struct stmmac_priv *priv,
 				   struct mac_device_info *hw, u32 chan);
 	/* Multicast filter setting */
-	void (*set_filter)(struct mac_device_info *hw, struct net_device *dev);
+	void (*set_filter)(struct stmmac_priv *priv, struct mac_device_info *hw,
+			   struct net_device *dev);
 	/* Flow control setting */
 	void (*flow_ctrl)(struct mac_device_info *hw, unsigned int duplex,
 			  unsigned int fc, unsigned int pause_time, u32 tx_cnt);
 	/* Set power management mode (e.g. magic frame) */
 	void (*pmt)(struct mac_device_info *hw, unsigned long mode);
 	/* Set/Get Unicast MAC addresses */
-	void (*set_umac_addr)(struct mac_device_info *hw,
+	void (*set_umac_addr)(struct stmmac_priv *priv,
+			      struct mac_device_info *hw,
 			      const unsigned char *addr,
 			      unsigned int reg_n);
-	void (*get_umac_addr)(struct mac_device_info *hw, unsigned char *addr,
+	void (*get_umac_addr)(struct stmmac_priv *priv,
+			      struct mac_device_info *hw,
+			      unsigned char *addr,
 			      unsigned int reg_n);
 	void (*set_eee_mode)(struct mac_device_info *hw,
 			     bool en_tx_lpi_clockgating);
@@ -452,15 +459,15 @@ struct stmmac_ops {
 #define stmmac_host_mtl_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, host_mtl_irq_status, __priv, __args)
 #define stmmac_set_filter(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, set_filter, __args)
+	stmmac_do_void_callback(__priv, mac, set_filter, __priv, __args)
 #define stmmac_flow_ctrl(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, flow_ctrl, __args)
 #define stmmac_pmt(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pmt, __args)
 #define stmmac_set_umac_addr(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, set_umac_addr, __args)
+	stmmac_do_void_callback(__priv, mac, set_umac_addr, __priv, __args)
 #define stmmac_get_umac_addr(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, get_umac_addr, __args)
+	stmmac_do_void_callback(__priv, mac, get_umac_addr, __priv, __args)
 #define stmmac_set_eee_mode(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_eee_mode, __args)
 #define stmmac_reset_eee_mode(__priv, __args...) \
@@ -560,27 +567,27 @@ struct stmmac_rx_queue;
 
 /* Helpers to manage the descriptors for chain and ring modes */
 struct stmmac_mode_ops {
-	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
-		      unsigned int extend_desc);
+	void (*init) (struct stmmac_priv *priv, void *des, dma_addr_t phy_addr,
+		      unsigned int size, unsigned int extend_desc);
 	unsigned int (*is_jumbo_frm) (int len, int ehn_desc);
 	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 			 int csum);
-	int (*set_16kib_bfsize)(int mtu);
-	void (*init_desc3)(struct dma_desc *p);
+	int (*set_16kib_bfsize)(struct stmmac_priv *priv, int mtu);
+	void (*init_desc3)(struct stmmac_priv *priv, struct dma_desc *p);
 	void (*refill_desc3)(struct stmmac_rx_queue *rx_q, struct dma_desc *p);
 	void (*clean_desc3)(struct stmmac_tx_queue *tx_q, struct dma_desc *p);
 };
 
 #define stmmac_mode_init(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mode, init, __args)
+	stmmac_do_void_callback(__priv, mode, init, __priv, __args)
 #define stmmac_is_jumbo_frm(__priv, __args...) \
 	stmmac_do_callback(__priv, mode, is_jumbo_frm, __args)
 #define stmmac_jumbo_frm(__priv, __args...) \
 	stmmac_do_callback(__priv, mode, jumbo_frm, __args)
 #define stmmac_set_16kib_bfsize(__priv, __args...) \
-	stmmac_do_callback(__priv, mode, set_16kib_bfsize, __args)
+	stmmac_do_callback(__priv, mode, set_16kib_bfsize, __priv, __args)
 #define stmmac_init_desc3(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mode, init_desc3, __args)
+	stmmac_do_void_callback(__priv, mode, init_desc3, __priv, __args)
 #define stmmac_refill_desc3(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mode, refill_desc3, __args)
 #define stmmac_clean_desc3(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 350e6670a576..22b8f27edfab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -61,7 +61,7 @@ static int ndesc_get_tx_status(struct net_device_stats *stats,
 	return ret;
 }
 
-static int ndesc_get_tx_len(struct dma_desc *p)
+static int ndesc_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des1) & RDES1_BUFFER1_SIZE_MASK);
 }
@@ -122,8 +122,8 @@ static int ndesc_get_rx_status(struct net_device_stats *stats,
 	return ret;
 }
 
-static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
-			       int end, int bfsize)
+static void ndesc_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+			       int disable_rx_ic, int mode, int end, int bfsize)
 {
 	int bfsize1;
 
@@ -181,9 +181,9 @@ static void ndesc_release_tx_desc(struct dma_desc *p, int mode)
 		ndesc_end_tx_desc_on_ring(p, ter);
 }
 
-static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				  bool csum_flag, int mode, bool tx_own,
-				  bool ls, unsigned int tot_pkt_len)
+static void ndesc_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
+				  int is_fs, int len, bool csum_flag, int mode,
+				  bool tx_own, bool ls, unsigned int tot_pkt_len)
 {
 	unsigned int tdes1 = le32_to_cpu(p->des1);
 
@@ -292,12 +292,13 @@ static void ndesc_display_ring(void *head, unsigned int size, bool rx,
 	pr_info("\n");
 }
 
-static void ndesc_set_addr(struct dma_desc *p, dma_addr_t addr)
+static void ndesc_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
+			   dma_addr_t addr)
 {
 	p->des2 = cpu_to_le32(addr);
 }
 
-static void ndesc_clear(struct dma_desc *p)
+static void ndesc_clear(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des2 = 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index d218412ca832..49dd6ea07416 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -111,7 +111,7 @@ static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 }
 
 /* In ring mode we need to fill the desc3 because it is used as buffer */
-static void init_desc3(struct dma_desc *p)
+static void init_desc3(struct stmmac_priv *priv, struct dma_desc *p)
 {
 	p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
 }
@@ -128,7 +128,7 @@ static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 		p->des3 = 0;
 }
 
-static int set_16kib_bfsize(int mtu)
+static int set_16kib_bfsize(struct stmmac_priv *priv, int mtu)
 {
 	int ret = 0;
 	if (unlikely(mtu > BUF_SIZE_8KiB))
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..e8619853b6d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2499,7 +2499,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 				       true, priv->mode, true, true,
 				       xdp_desc.len);
 
-		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
@@ -4559,7 +4559,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4775,7 +4775,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		priv->xstats.tx_set_ic_bit++;
 	}
 
-	stmmac_enable_dma_transmission(priv, priv->ioaddr);
+	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
 	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	tx_q->cur_tx = entry;
-- 
2.39.3


