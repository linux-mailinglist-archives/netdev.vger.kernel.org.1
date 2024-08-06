Return-Path: <netdev+bounces-116041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB253948D5D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086D91C23901
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DBE1C0DE8;
	Tue,  6 Aug 2024 11:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB401C0DE9
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942030; cv=none; b=YEP3Xa1GVLqdP4qnFFsjegX6oZyOXq8S9CyzLTusllp+md4en+ICyx5dpWASyMGHiuz2irInVZrEqzsJnNR8Tocf6Rct4lOQHreGelaF07mJtSQEynPx8JxKiF+Mk/rJFpM+KkAAvo1xCZt8FKaK257VDCX77A0u3LPImgP6Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942030; c=relaxed/simple;
	bh=U4TXH1BQFEFPpG/YNSia1jUCySgXTLjUduezMVljAi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRz+w2Dfl0WmJawdaq9dv0IgLtwaI6Ru/QEbhkuJ8u7KBNIUhU3i17NmONjEc4punsVP9hbVK788dRjLgIJ+Pr0S9BX8U1VL+6ZWyFxPEsIzkQjMznzTVfbS2dWZ9Ml2Gyl6oHorcRXiqxdpemsxfvhtwfb4fkuHWXgrqQhATmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8DxSupKArJmZbAIAA--.28923S3;
	Tue, 06 Aug 2024 19:00:26 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMAxz2dIArJmo_gFAA--.20216S2;
	Tue, 06 Aug 2024 19:00:25 +0800 (CST)
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
Subject: [PATCH net-next v16 12/14] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
Date: Tue,  6 Aug 2024 19:00:22 +0800
Message-Id: <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:qMiowMAxz2dIArJmo_gFAA--.20216S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Cr1DCF1kKrW5JrykJr4DZFc_yoW8Wry3Wo
	ZxXFnavrWrKw18Wrs7Krn5JFWUXr1rXws0yFWfCr4DX39ava15ZFWfGa1fJ3WSyr1rKF9x
	AryfJ3WkGFWSqwn5l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVW8Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUtVW8ZwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUYhtxDUUUUU==

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
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 325 +++++++++++++++++-
 2 files changed, 324 insertions(+), 2 deletions(-)

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
index 6ba4674bc076..8417f2a67054 100644
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
 
@@ -70,6 +147,233 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
+
+	ld = priv->plat->bsp_priv;
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
@@ -146,6 +450,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
+	struct loongson_data *ld;
 	int ret, i;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
@@ -162,6 +467,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->dma_cfg)
 		return -ENOMEM;
 
+	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
+	if (!ld)
+		return -ENOMEM;
+
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret) {
@@ -184,6 +493,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
+	plat->bsp_priv = ld;
+	plat->setup = loongson_dwmac_setup;
+	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
+
 	info = (struct stmmac_pci_info *)id->driver_data;
 	ret = info->setup(pdev, plat);
 	if (ret)
@@ -196,6 +509,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (ret)
 		goto err_disable_device;
 
+	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		loongson_dwmac_msi_config(pdev, plat, &res);
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_plat_clear;
@@ -205,6 +522,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 err_plat_clear:
 	if (dev_of_node(&pdev->dev))
 		loongson_dwmac_dt_clear(pdev, plat);
+	loongson_dwmac_msi_clear(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 	return ret;
@@ -214,12 +532,15 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct loongson_data *ld;
 	int i;
 
+	ld = priv->plat->bsp_priv;
 	stmmac_dvr_remove(&pdev->dev);
 
 	if (dev_of_node(&pdev->dev))
 		loongson_dwmac_dt_clear(pdev, priv->plat);
+	loongson_dwmac_msi_clear(pdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
-- 
2.31.4


