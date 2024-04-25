Return-Path: <netdev+bounces-91320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9E8B2243
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F3C281C44
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569A149C4D;
	Thu, 25 Apr 2024 13:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890D149C42
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050709; cv=none; b=Gz0SRCKjPYEH3ysOxioL9Dl461XK0DazAPcIRRBlctugp/ibd74nJncUDY07QHujl/8GO0aZfAwBhCMIqZj5uValaSvkWAr0HWJR/ZBUZXnznSpOdx3MfxBDZ8I9YE4MJDub2QyiPCL588ANPhf73gTpNjh9Nwe6Cy11whjSBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050709; c=relaxed/simple;
	bh=fW73mrvVEMxPo4ilZawXeQQfpHNv7RHxQvc0tBg+bqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLuhTKsOAbaGiYa/mw4FLY7NVQuJv1TaWJIYTk0uEdRFIpwQKV6gvlY2+ZiReYcwd8Kj59z0YeuewnixHnLSvqNx0q2iR70ICZZ4hFE/wfa1kD8wiKQEz98HbFIymPdGSA4BZ4J1Z7yP1Asw4/Glj6sYKgvUt3fqx8HokPS0bSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxCuqQVipmuNACAA--.827S3;
	Thu, 25 Apr 2024 21:11:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnleKVipmWBsFAA--.13037S2;
	Thu, 25 Apr 2024 21:11:40 +0800 (CST)
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
Subject: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
Date: Thu, 25 Apr 2024 21:11:36 +0800
Message-Id: <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnleKVipmWBsFAA--.13037S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJr1rJry5GFW5AFWkJFy7Jwc_yoW8AFyDKo
	ZxZFnavrWrKw18Wrs7Krn5JFW5Xr1rXws0yFWxAr4DX39ava15ZFWfGw4fJ3Wayr4rKFyD
	AryfJ3WkGFZ2qrn5l-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgBOJUUUUU

There are two types of Loongson DWGMAC. The first type shares the same
register definitions and has similar logic as dwmac1000. The second type
uses several different register definitions, we think it is necessary to
distinguish rx and tx, so we split these bits into two.

Simply put, we split some single bit fields into double bits fileds:

     Name              Tx          Rx

DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
DMA_STATUS_FBI   = 0x00002000 | 0x00001000;

Therefore, when using, TX and RX must be set at the same time.

How to use them:
 1. Create the Loongson GNET-specific
 stmmac_dma_ops.dma_interrupt()
 stmmac_dma_ops.init_chan()
 methods in the dwmac-loongson.c driver. Adding all the
 Loongson-specific macros

 2. Create a Loongson GNET-specific platform setup method with the next
 semantics:
    + allocate stmmac_dma_ops instance and initialize it with
      dwmac1000_dma_ops.
    + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
      the pointers to the methods defined in 2.
    + allocate mac_device_info instance and initialize the
      mac_device_info.dma field with a pointer to the new
      stmmac_dma_ops instance.
    + initialize mac_device_info in a way it's done in
      dwmac1000_setup().

 3. Initialize plat_stmmacenet_data.setup() with the pointer to the
 method created in 2.

GNET features:

 Speeds: 10/100/1000Mbps
 DMA-descriptors type: enhanced
 L3/L4 filters availability: support
 VLAN hash table filter: support
 PHY-interface: GMII
 Remote Wake-up support: support
 Mac Management Counters (MMC): support
 Number of additional MAC addresses: 5
 MAC Hash-based filter: support
 Number of ash table size: 256
 DMA chennel number: 0x10 device is 8 and 0x37 device is 1

Others:

 GNET integrates both MAC and PHY chips inside.
 GNET device: LS2K2000, LS7A2000, the chip connection between the mac and
             phy of these devices is not normal and requires two rounds of
             negotiation; LS7A2000 does not support half-duplex and
             multi-channel;

             To enable multi-channel on LS2K2000, you need to turn off
             hardware checksum.

**Note**: Currently, only the LS2K2000's synopsys_id is 0x10, while the
synopsys_id of other devices are 0x37.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 381 +++++++++++++++++-
 2 files changed, 371 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 9cd62b2110a1..aed6ae80cc7c 100644
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
index a16bba389417..68de90c44feb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -8,9 +8,71 @@
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
 #define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
+#define LOONGSON_DWMAC_CORE_1_00	0x10	/* Loongson custom IP */
+#define CHANNEL_NUM			8
+
+struct loongson_data {
+	u32 gmac_verion;
+	struct device *dev;
+};
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
@@ -69,6 +131,168 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
 };
 
+static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
+					   void __iomem *ioaddr,
+					   struct stmmac_dma_cfg *dma_cfg,
+					   u32 chan)
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
+static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
+				       void __iomem *ioaddr,
+				       struct stmmac_extra_stats *x,
+				       u32 chan, u32 dir)
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
+	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
+	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
+
+	return ret;
+}
+
+static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
+				    unsigned int mode)
+{
+	struct loongson_data *ld = (struct loongson_data *)priv;
+	struct net_device *ndev = dev_get_drvdata(ld->dev);
+	struct stmmac_priv *ptr = netdev_priv(ndev);
+
+	/* The controller and PHY don't work well together.
+	 * We need to use the PS bit to check if the controller's status
+	 * is correct and reset PHY if necessary.
+	 * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
+	 */
+	if (speed == SPEED_1000) {
+		if (readl(ptr->ioaddr + MAC_CTRL_REG) &
+		    GMAC_CONTROL_PS)
+			/* Word around hardware bug, restart autoneg */
+			phy_restart_aneg(ndev->phydev);
+	}
+}
+
+static int loongson_gnet_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(pdev, plat);
+
+	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
+	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
+	plat->fix_mac_speed = loongson_gnet_fix_speed;
+
+	return 0;
+}
+
+static struct stmmac_pci_info loongson_gnet_pci_info = {
+	.setup = loongson_gnet_data,
+};
+
 static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
 					struct plat_stmmacenet_data *plat,
 					struct stmmac_resources *res,
@@ -101,12 +325,126 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_dwmac_config_msi(struct pci_dev *pdev,
+				     struct plat_stmmacenet_data *plat,
+				     struct stmmac_resources *res,
+				     struct device_node *np)
+{
+	int i, ret, vecs;
+
+	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
+	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_info(&pdev->dev,
+			 "MSI enable failed, Fallback to legacy interrupt\n");
+		return loongson_dwmac_config_legacy(pdev, plat, res, np);
+	}
+
+	res->irq = pci_irq_vector(pdev, 0);
+	res->wol_irq = 0;
+
+	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
+	 * --------- ----- -------- --------  ...  -------- --------
+	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
+	 */
+	for (i = 0; i < CHANNEL_NUM; i++) {
+		res->rx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 1 + i * 2);
+		res->tx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 2 + i * 2);
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+
+	return 0;
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
+	/* The original IP-core version is 0x37 in all Loongson GNET
+	 * (ls2k2000 and ls7a2000), but the GNET HW designers have changed the
+	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
+	 * ls2k2000 MAC to emphasize the differences: multiple DMA-channels,
+	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
+	 * original value so the correct HW-interface would be selected.
+	 */
+	if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00) {
+		priv->synopsys_id = DWMAC_CORE_3_70;
+		*dma = dwmac1000_dma_ops;
+		dma->init_chan = loongson_gnet_dma_init_channel;
+		dma->dma_interrupt = loongson_gnet_dma_interrupt;
+		mac->dma = dma;
+	}
+
+	mac->mac = &dwmac1000_ops;
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
+	/* The GMAC devices with PCI ID 0x7a03 does not support any pause mode.
+	 * The GNET devices without CORE ID 0x10 does not support half-duplex.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
+		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
+	} else {
+		if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00)
+			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					 MAC_10 | MAC_100 | MAC_1000;
+		else
+			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					 MAC_10FD | MAC_100FD | MAC_1000FD;
+	}
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
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
 	int ret, i, bus_id, phy_mode;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
+	struct loongson_data *ld;
 	struct device_node *np;
 
 	np = dev_of_node(&pdev->dev);
@@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		return -ENOMEM;
 
 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
-	if (!plat->dma_cfg) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!plat->dma_cfg)
+		return -ENOMEM;
+
+	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
+	if (!ld)
+		return -ENOMEM;
 
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
@@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		plat->phy_interface = phy_mode;
 	}
 
-	pci_enable_msi(pdev);
+	plat->bsp_priv = ld;
+	plat->setup = loongson_dwmac_setup;
+	ld->dev = &pdev->dev;
+
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
+	ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
+
+	switch (ld->gmac_verion) {
+	case LOONGSON_DWMAC_CORE_1_00:
+		plat->rx_queues_to_use = CHANNEL_NUM;
+		plat->tx_queues_to_use = CHANNEL_NUM;
+
+		/* Only channel 0 supports checksum,
+		 * so turn off checksum to enable multiple channels.
+		 */
+		for (i = 1; i < CHANNEL_NUM; i++)
+			plat->tx_queues_cfg[i].coe_unsupported = 1;
 
-	plat->tx_queues_to_use = 1;
-	plat->rx_queues_to_use = 1;
+		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
+		break;
+	default:	/* 0x35 device and 0x37 device. */
+		plat->tx_queues_to_use = 1;
+		plat->rx_queues_to_use = 1;
 
-	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
+		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
+		break;
+	}
 
 	/* GNET devices with dev revision 0x00 do not support manually
 	 * setting the speed to 1000.
@@ -189,12 +549,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-		goto err_disable_msi;
+		goto err_disable_device;
 
 	return ret;
 
-err_disable_msi:
-	pci_disable_msi(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 err_put_node:
@@ -262,6 +620,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
 	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


