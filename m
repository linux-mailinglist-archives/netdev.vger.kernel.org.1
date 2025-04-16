Return-Path: <netdev+bounces-183341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC4A906C7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807A58A01FB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709E1F4C9D;
	Wed, 16 Apr 2025 14:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912C1F2BB8;
	Wed, 16 Apr 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814573; cv=none; b=etI3qF7pJo4fbf0IPOuLrJAZo7gb6lEMBYHB++homD2n6gmz99W1SWW2P0rfulE653u7lYPasptBbW4Qz8tjicnm7Gw+RC7r8X8vgRzK9kqEymggF6O3118wGJ7EeKhRWk1UNW8zHOYwh7wFE/QZJ0QXYjBcbeDErr5t500bSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814573; c=relaxed/simple;
	bh=4QC304UZRaZYpi2dRIDuDbd2dOUMYYMzpbi/RjMh71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9jQOKPSLRGeuBS/+SqBNSCZMiBDh/wFxbsL0Rk7qh34ay09/pGcTiuhKdW+IrVA1+Wg061NteP7O1L9yLveVLWs23Ysj4xnXHn6O5lE4jeELqWqfLFf1LdyaQpwjLshp9VHW+viVt621PKDFFvW1IQAvWd7sIroQAojWvinbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8CxyuDnwf9nX_y_AA--.56104S3;
	Wed, 16 Apr 2025 22:42:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMBx2xqowf9nLD2GAA--.2909S4;
	Wed, 16 Apr 2025 22:42:44 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Lunn <andrew@lunn.ch>,
	Henry Chen <chenx97@aosc.io>,
	Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH net-next V2 2/3] net: stmmac: dwmac-loongson: Add new multi-chan IP core support
Date: Wed, 16 Apr 2025 22:41:31 +0800
Message-ID: <20250416144132.3857990-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250416144132.3857990-1-chenhuacai@loongson.cn>
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx2xqowf9nLD2GAA--.2909S4
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWxAFy3CFW5Zw4xKFyxXrc_yoWxJF43pa
	y3Aay2grWrWF4Y9an5X3yUAr15ArWFq3srXF42kw1vkF90yry2v34rKFWYkrZ7CFZYyF47
	ZFyvvr4kWF4UC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

Add a new multi-chan IP core (0x12) support which is used in Loongson-
2K3000/Loongson-3B6000M. Compared with the 0x10 core, the new 0x12 core
reduces channel numbers from 8 to 4, but checksum is supported for all
channels.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Henry Chen <chenx97@aosc.io>
Tested-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 62 +++++++++++--------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2fb7a137b312..57917f26ab4d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -68,10 +68,11 @@
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 #define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
-#define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom ID */
-#define CHANNEL_NUM			8
+#define DWMAC_CORE_MULTICHAN_V1	0x10	/* Loongson custom ID 0x10 */
+#define DWMAC_CORE_MULTICHAN_V2	0x12	/* Loongson custom ID 0x12 */
 
 struct loongson_data {
+	u32 multichan;
 	u32 loongson_id;
 	struct device *dev;
 };
@@ -119,18 +120,29 @@ static void loongson_default_data(struct pci_dev *pdev,
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
 
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
-		plat->rx_queues_to_use = CHANNEL_NUM;
-		plat->tx_queues_to_use = CHANNEL_NUM;
+	switch (ld->loongson_id) {
+	case DWMAC_CORE_MULTICHAN_V1:
+		ld->multichan = 1;
+		plat->rx_queues_to_use = 8;
+		plat->tx_queues_to_use = 8;
 
 		/* Only channel 0 supports checksum,
 		 * so turn off checksum to enable multiple channels.
 		 */
-		for (int i = 1; i < CHANNEL_NUM; i++)
+		for (int i = 1; i < 8; i++)
 			plat->tx_queues_cfg[i].coe_unsupported = 1;
-	} else {
+
+		break;
+	case DWMAC_CORE_MULTICHAN_V2:
+		ld->multichan = 1;
+		plat->rx_queues_to_use = 4;
+		plat->tx_queues_to_use = 4;
+		break;
+	default:
+		ld->multichan = 0;
 		plat->tx_queues_to_use = 1;
 		plat->rx_queues_to_use = 1;
+		break;
 	}
 }
 
@@ -328,14 +340,14 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 		return NULL;
 
 	/* The Loongson GMAC and GNET devices are based on the DW GMAC
-	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
-	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
-	 * network controllers with the multi-channels feature
+	 * v3.50a and v3.73a IP-cores. But the HW designers have changed
+	 * the GMAC_VERSION.SNPSVER field to the custom 0x10/0x12 value
+	 * on the network controllers with the multi-channels feature
 	 * available to emphasize the differences: multiple DMA-channels,
 	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
 	 * original value so the correct HW-interface would be selected.
 	 */
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
+	if (ld->multichan) {
 		priv->synopsys_id = DWMAC_CORE_3_70;
 		*dma = dwmac1000_dma_ops;
 		dma->init_chan = loongson_dwmac_dma_init_channel;
@@ -356,13 +368,13 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
-	/* Loongson GMAC doesn't support the flow control. LS2K2000
-	 * GNET doesn't support the half-duplex link mode.
+	/* Loongson GMAC doesn't support the flow control. Loongson GNET
+	 * without multi-channel doesn't support the half-duplex link mode.
 	 */
 	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
 		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
 	} else {
-		if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+		if (ld->multichan)
 			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 					 MAC_10 | MAC_100 | MAC_1000;
 		else
@@ -391,9 +403,11 @@ static int loongson_dwmac_msi_config(struct pci_dev *pdev,
 				     struct plat_stmmacenet_data *plat,
 				     struct stmmac_resources *res)
 {
-	int i, ret, vecs;
+	int i, ch_num, ret, vecs;
 
-	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
+	ch_num = min(plat->tx_queues_to_use, plat->rx_queues_to_use);
+
+	vecs = roundup_pow_of_two(ch_num * 2 + 1);
 	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_warn(&pdev->dev, "Failed to allocate MSI IRQs\n");
@@ -402,14 +416,12 @@ static int loongson_dwmac_msi_config(struct pci_dev *pdev,
 
 	res->irq = pci_irq_vector(pdev, 0);
 
-	for (i = 0; i < plat->rx_queues_to_use; i++) {
-		res->rx_irq[CHANNEL_NUM - 1 - i] =
-			pci_irq_vector(pdev, 1 + i * 2);
+	for (i = 0; i < ch_num; i++) {
+		res->rx_irq[ch_num - 1 - i] = pci_irq_vector(pdev, 1 + i * 2);
 	}
 
-	for (i = 0; i < plat->tx_queues_to_use; i++) {
-		res->tx_irq[CHANNEL_NUM - 1 - i] =
-			pci_irq_vector(pdev, 2 + i * 2);
+	for (i = 0; i < ch_num; i++) {
+		res->tx_irq[ch_num - 1 - i] = pci_irq_vector(pdev, 2 + i * 2);
 	}
 
 	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
@@ -571,7 +583,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		goto err_disable_device;
 
 	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+	if (ld->multichan)
 		loongson_dwmac_msi_config(pdev, plat, &res);
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
@@ -583,7 +595,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 err_plat_clear:
 	if (dev_of_node(&pdev->dev))
 		loongson_dwmac_dt_clear(pdev, plat);
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+	if (ld->multichan)
 		loongson_dwmac_msi_clear(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
@@ -602,7 +614,7 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	if (dev_of_node(&pdev->dev))
 		loongson_dwmac_dt_clear(pdev, priv->plat);
 
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+	if (ld->multichan)
 		loongson_dwmac_msi_clear(pdev);
 
 	pci_disable_device(pdev);
-- 
2.47.1


