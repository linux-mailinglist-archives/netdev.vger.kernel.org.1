Return-Path: <netdev+bounces-112404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB32938DD0
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A7A2818C6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196216CD1F;
	Mon, 22 Jul 2024 11:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AC13D53A
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646091; cv=none; b=NUYpcrEZ/FVrN/2g+U1gLj1fhHCyXCrFJHXWtsD6RdDA150PL1W1Y7aMXTIp1rjkm5Ljp8jn5kbDej1s6gkPjRg6yj7A9mlpqG99DYd5SYmyPFNHL4bOh22CKirfU2ytCxGvIRxtm9wqLqCfD723ckgt2XatkRsDkvspZ7/eqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646091; c=relaxed/simple;
	bh=bM2FuHcLkyt0Fd2gdMA/I011HdrzkhhMFePwCFFK7RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sccOh+QvVFBCXpzatNYl0NOK3eWI9RjhRMlOVe8IyGizAfyJCqPq0QcknUOUjlUgV2dfylhD3D8Dl3/vu1codgO7jCXIe7RNAbF96zEUsrw9WQddesUAsr0Uu+/gnwP0/8qKFT70ZYqqUm31o/adjGL3hEI81MvBExQoKmmHszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxssT7O55mjxtUAA--.44095S4;
	Mon, 22 Jul 2024 19:01:20 +0800 (CST)
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
Subject: [PATCH net-next RFC v15 12/14] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
Date: Mon, 22 Jul 2024 19:01:10 +0800
Message-Id: <210517d4a8a2b63fd0aa9e57b1df91fcfe64fc2a.1721645682.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1721645682.git.siyanteng@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxssT7O55mjxtUAA--.44095S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr1DCF1kKr4UJr4fCw15Jwb_yoW8WF1UWo
	ZxXFn3ZrWrKw18Wrs7Krn5JFWUXr1rXws0yFWfCr4DX39ava15uFWfGa1fJ3WSyr1rKF9r
	AryfJ3WkGFZ3twn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOz7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbeyxtUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

The Loongson DWMAC driver currently supports the Loongson GMAC
devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
LS2K2000 SoC was released with the new version of the Loongson GMAC
synthesized in. The new controller is based on the DW GMAC v3.73a
IP-core with the AV-feature enabled, which implies the multi
DMA-channels support. The multi DMA-channels feature has the next
vendor-specific peculiarities:

1. Split up Tx and Rx DMA IRQ status/mask bits:
       Name              Tx          Rx
  DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
  DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
  DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
  DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
  DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
field. It's 0x10 while it should have been 0x37 in accordance with
the actual DW GMAC IP-core version.
3. There are eight DMA-channels available meanwhile the Synopsys DW
GMAC IP-core supports up to three DMA-channels.
4. It's possible to have each DMA-channel IRQ independently delivered.
The MSI IRQs must be utilized for that.

Thus in order to have the multi-channels Loongson GMAC controllers
supported let's modify the Loongson DWMAC driver in accordance with
all the peculiarities described above:

1. Create the multi-channels Loongson GMAC-specific
   stmmac_dma_ops::dma_interrupt()
   stmmac_dma_ops::init_chan()
   callbacks due to the non-standard DMA IRQ CSR flags layout.
2. Create the Loongson DWMAC-specific platform setup() method
which gets to initialize the DMA-ops with the dwmac1000_dma_ops
instance and overrides the callbacks described in 1. The method also
overrides the custom Synopsys ID with the real one in order to have
the rest of the HW-specific callbacks correctly detected by the driver
core.
3. Make sure the platform setup() method enables the flow control and
duplex modes supported by the controller.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 330 +++++++++++++++++-
 2 files changed, 329 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index cd36ff4da68c..684489156dce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -29,6 +29,7 @@
 /* Synopsys Core versions */
 #define	DWMAC_CORE_3_40		0x34
 #define	DWMAC_CORE_3_50		0x35
+#define	DWMAC_CORE_3_70		0x37
 #define	DWMAC_CORE_4_00		0x40
 #define DWMAC_CORE_4_10		0x41
 #define DWMAC_CORE_5_00		0x50
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index d7f3ff0fd6c1..b0287ef34b5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -8,8 +8,69 @@
 #include <linux/device.h>
 #include <linux/of_irq.h>
 #include "stmmac.h"
+#include "dwmac_dma.h"
+#include "dwmac1000.h"
+
+/* Normal Loongson Tx Summary */
+#define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
+/* Normal Loongson Rx Summary */
+#define DMA_INTR_ENA_NIE_RX_LOONGSON	0x00020000
+
+#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
+					 DMA_INTR_ENA_NIE_RX_LOONGSON | \
+					 DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE)
+
+/* Abnormal Loongson Tx Summary */
+#define DMA_INTR_ENA_AIE_TX_LOONGSON	0x00010000
+/* Abnormal Loongson Rx Summary */
+#define DMA_INTR_ENA_AIE_RX_LOONGSON	0x00008000
+
+#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
+					 DMA_INTR_ENA_AIE_RX_LOONGSON | \
+					 DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
+
+#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | \
+					 DMA_INTR_ABNORMAL_LOONGSON)
+
+/* Normal Loongson Tx Interrupt Summary */
+#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000
+/* Normal Loongson Rx Interrupt Summary */
+#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000
+
+/* Abnormal Loongson Tx Interrupt Summary */
+#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000
+/* Abnormal Loongson Rx Interrupt Summary */
+#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000
+
+/* Fatal Loongson Tx Bus Error Interrupt */
+#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000
+/* Fatal Loongson Rx Bus Error Interrupt */
+#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000
+
+#define DMA_STATUS_MSK_COMMON_LOONGSON	(DMA_STATUS_NIS_TX_LOONGSON | \
+					 DMA_STATUS_NIS_RX_LOONGSON | \
+					 DMA_STATUS_AIS_TX_LOONGSON | \
+					 DMA_STATUS_AIS_RX_LOONGSON | \
+					 DMA_STATUS_FBI_TX_LOONGSON | \
+					 DMA_STATUS_FBI_RX_LOONGSON)
+
+#define DMA_STATUS_MSK_RX_LOONGSON	(DMA_STATUS_ERI | DMA_STATUS_RWT | \
+					 DMA_STATUS_RPS | DMA_STATUS_RU  | \
+					 DMA_STATUS_RI  | DMA_STATUS_OVF | \
+					 DMA_STATUS_MSK_COMMON_LOONGSON)
+
+#define DMA_STATUS_MSK_TX_LOONGSON	(DMA_STATUS_ETI | DMA_STATUS_UNF | \
+					 DMA_STATUS_TJT | DMA_STATUS_TU  | \
+					 DMA_STATUS_TPS | DMA_STATUS_TI  | \
+					 DMA_STATUS_MSK_COMMON_LOONGSON)
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom ID */
+#define CHANNEL_NUM			8
+
+struct loongson_data {
+	u32 loongson_id;
+};
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
@@ -56,10 +117,26 @@ static void loongson_default_data(struct pci_dev *pdev,
 static int loongson_gmac_data(struct pci_dev *pdev,
 			      struct plat_stmmacenet_data *plat)
 {
+	struct loongson_data *ld;
+	int i;
+
+	ld = plat->bsp_priv;
+
 	loongson_default_data(pdev, plat);
 
-	plat->tx_queues_to_use = 1;
-	plat->rx_queues_to_use = 1;
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
+		plat->rx_queues_to_use = CHANNEL_NUM;
+		plat->tx_queues_to_use = CHANNEL_NUM;
+
+		/* Only channel 0 supports checksum,
+		 * so turn off checksum to enable multiple channels.
+		 */
+		for (i = 1; i < CHANNEL_NUM; i++)
+			plat->tx_queues_cfg[i].coe_unsupported = 1;
+	} else {
+		plat->tx_queues_to_use = 1;
+		plat->rx_queues_to_use = 1;
+	}
 
 	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
@@ -70,6 +147,235 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
 };
 
+static void loongson_dwmac_dma_init_channel(struct stmmac_priv *priv,
+					    void __iomem *ioaddr,
+					    struct stmmac_dma_cfg *dma_cfg,
+					    u32 chan)
+{
+	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
+	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
+	u32 value;
+
+	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	if (dma_cfg->pblx8)
+		value |= DMA_BUS_MODE_MAXPBL;
+
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
+	if (dma_cfg->atds)
+		value |= DMA_BUS_MODE_ATDS;
+
+	if (dma_cfg->aal)
+		value |= DMA_BUS_MODE_AAL;
+
+	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
+
+	/* Mask interrupts by writing to CSR7 */
+	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr +
+	       DMA_CHAN_INTR_ENA(chan));
+}
+
+static int loongson_dwmac_dma_interrupt(struct stmmac_priv *priv,
+					void __iomem *ioaddr,
+					struct stmmac_extra_stats *x,
+					u32 chan, u32 dir)
+{
+	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
+	u32 abnor_intr_status;
+	u32 nor_intr_status;
+	u32 fb_intr_status;
+	u32 intr_status;
+	int ret = 0;
+
+	/* read the status register (CSR5) */
+	intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
+
+	if (dir == DMA_DIR_RX)
+		intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
+	else if (dir == DMA_DIR_TX)
+		intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
+
+	nor_intr_status = intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
+		DMA_STATUS_NIS_RX_LOONGSON);
+	abnor_intr_status = intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
+		DMA_STATUS_AIS_RX_LOONGSON);
+	fb_intr_status = intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
+		DMA_STATUS_FBI_RX_LOONGSON);
+
+	/* ABNORMAL interrupts */
+	if (unlikely(abnor_intr_status)) {
+		if (unlikely(intr_status & DMA_STATUS_UNF)) {
+			ret = tx_hard_error_bump_tc;
+			x->tx_undeflow_irq++;
+		}
+		if (unlikely(intr_status & DMA_STATUS_TJT))
+			x->tx_jabber_irq++;
+		if (unlikely(intr_status & DMA_STATUS_OVF))
+			x->rx_overflow_irq++;
+		if (unlikely(intr_status & DMA_STATUS_RU))
+			x->rx_buf_unav_irq++;
+		if (unlikely(intr_status & DMA_STATUS_RPS))
+			x->rx_process_stopped_irq++;
+		if (unlikely(intr_status & DMA_STATUS_RWT))
+			x->rx_watchdog_irq++;
+		if (unlikely(intr_status & DMA_STATUS_ETI))
+			x->tx_early_irq++;
+		if (unlikely(intr_status & DMA_STATUS_TPS)) {
+			x->tx_process_stopped_irq++;
+			ret = tx_hard_error;
+		}
+		if (unlikely(fb_intr_status)) {
+			x->fatal_bus_error_irq++;
+			ret = tx_hard_error;
+		}
+	}
+	/* TX/RX NORMAL interrupts */
+	if (likely(nor_intr_status)) {
+		if (likely(intr_status & DMA_STATUS_RI)) {
+			u32 value = readl(ioaddr + DMA_INTR_ENA);
+			/* to schedule NAPI on real RIE event. */
+			if (likely(value & DMA_INTR_ENA_RIE)) {
+				u64_stats_update_begin(&stats->syncp);
+				u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+				u64_stats_update_end(&stats->syncp);
+				ret |= handle_rx;
+			}
+		}
+		if (likely(intr_status & DMA_STATUS_TI)) {
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+			u64_stats_update_end(&stats->syncp);
+			ret |= handle_tx;
+		}
+		if (unlikely(intr_status & DMA_STATUS_ERI))
+			x->rx_early_irq++;
+	}
+	/* Optional hardware blocks, interrupts should be disabled */
+	if (unlikely(intr_status &
+		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
+		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
+
+	/* Clear the interrupt by writing a logic 1 to the CSR5[19-0] */
+	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
+
+	return ret;
+}
+
+static struct mac_device_info *loongson_dwmac_setup(void *apriv)
+{
+	struct stmmac_priv *priv = apriv;
+	struct mac_device_info *mac;
+	struct stmmac_dma_ops *dma;
+	struct loongson_data *ld;
+	struct pci_dev *pdev;
+
+	ld = priv->plat->bsp_priv;
+	pdev = to_pci_dev(priv->device);
+
+	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
+	if (!mac)
+		return NULL;
+
+	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return NULL;
+
+	/* The Loongson GMAC devices are based on the DW GMAC
+	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
+	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
+	 * network controllers with the multi-channels feature
+	 * available to emphasize the differences: multiple DMA-channels,
+	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
+	 * original value so the correct HW-interface would be selected.
+	 */
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
+		priv->synopsys_id = DWMAC_CORE_3_70;
+		*dma = dwmac1000_dma_ops;
+		dma->init_chan = loongson_dwmac_dma_init_channel;
+		dma->dma_interrupt = loongson_dwmac_dma_interrupt;
+		mac->dma = dma;
+	}
+
+	priv->dev->priv_flags |= IFF_UNICAST_FLT;
+
+	/* Pre-initialize the respective "mac" fields as it's done in
+	 * dwmac1000_setup()
+	 */
+	mac->pcsr = priv->ioaddr;
+	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
+	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
+	mac->mcast_bits_log2 = 0;
+
+	if (mac->multicast_filter_bins)
+		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
+
+	/* Loongson GMAC doesn't support the flow control. */
+	mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
+
+	mac->link.duplex = GMAC_CONTROL_DM;
+	mac->link.speed10 = GMAC_CONTROL_PS;
+	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
+	mac->link.speed1000 = 0;
+	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
+	mac->mii.addr = GMAC_MII_ADDR;
+	mac->mii.data = GMAC_MII_DATA;
+	mac->mii.addr_shift = 11;
+	mac->mii.addr_mask = 0x0000F800;
+	mac->mii.reg_shift = 6;
+	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.clk_csr_shift = 2;
+	mac->mii.clk_csr_mask = GENMASK(5, 2);
+
+	return mac;
+}
+
+static int loongson_dwmac_msi_config(struct pci_dev *pdev,
+				     struct plat_stmmacenet_data *plat,
+				     struct stmmac_resources *res)
+{
+	int i, ret, vecs;
+
+	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
+	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "Failed to allocate MSI IRQs\n");
+		return ret;
+	}
+
+	res->irq = pci_irq_vector(pdev, 0);
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		res->rx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 1 + i * 2);
+	}
+
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		res->tx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 2 + i * 2);
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+
+	return 0;
+}
+
+static void loongson_dwmac_msi_clear(struct pci_dev *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
 static int loongson_dwmac_dt_config(struct pci_dev *pdev,
 				    struct plat_stmmacenet_data *plat,
 				    struct stmmac_resources *res)
@@ -146,6 +452,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
+	struct loongson_data *ld;
 	int ret, i;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
@@ -162,6 +469,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->dma_cfg)
 		return -ENOMEM;
 
+	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
+	if (!ld)
+		return -ENOMEM;
+
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret) {
@@ -185,6 +496,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
+	plat->bsp_priv = ld;
+	plat->setup = loongson_dwmac_setup;
+	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
+
 	info = (struct stmmac_pci_info *)id->driver_data;
 	ret = info->setup(pdev, plat);
 	if (ret)
@@ -197,6 +512,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (ret)
 		goto err_disable_device;
 
+	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_config(pdev, plat, &res);
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_plat_clear;
@@ -206,6 +525,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 err_plat_clear:
 	if (dev_of_node(&pdev->dev))
 		loongson_dwmac_dt_clear(pdev, plat);
+	else if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_clear(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 	return ret;
@@ -218,8 +539,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct loongson_data *ld;
 	int i;
 
+	ld = priv->plat->bsp_priv;
 	of_node_put(priv->plat->mdio_node);
 	stmmac_dvr_remove(&pdev->dev);
 
@@ -233,6 +556,9 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_clear(pdev);
+
 	pci_disable_device(pdev);
 }
 
-- 
2.31.4


