Return-Path: <netdev+bounces-116489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF094A8FE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A4FB25FC4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A65200121;
	Wed,  7 Aug 2024 13:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9951E7A38
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038555; cv=none; b=FgFQtFTf0zW0H8AScjhJOwoH+ownR/583fubACakkWqyym6sD3FbQWIPUH6ktZI7YBJVXlwW+bCQ5JjT4X6MzzSCTNyHWSMWTUbcozFxtggAiZMm4XELieZi+u6QDXIzdflgbp85RRB5ldYqGUpXF1v52+HzDen3Hm8r7kcFxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038555; c=relaxed/simple;
	bh=qxJ6qLO4/QSg24ZnMwGgI2nWPylplCd2iM05AsTSqNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHKDCtUnbgJP+yPtJqROujj9nmQeFwT3X/WZ//0ZVdaKqgPrveZrLi+JAWmda1xSruwDm2GqAJDh8Vt408tl6aL3CjrZdeZ+JwERjPie/rGNAmEBZV8JRFkV7rmCYN52Tkhay3iLT4QtTggm2eWtiCUue8Hdu94/JJmUvG+ln5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8DxCepXe7NmWXcKAA--.32475S3;
	Wed, 07 Aug 2024 21:49:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMAxYeFSe7NmmB4IAA--.40675S3;
	Wed, 07 Aug 2024 21:49:10 +0800 (CST)
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
Subject: [PATCH net-next v17 13/14] net: stmmac: dwmac-loongson: Add Loongson GNET support
Date: Wed,  7 Aug 2024 21:48:55 +0800
Message-Id: <48579065f4226fcc928015139d194ca373248011.1723014611.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1723014611.git.siyanteng@loongson.cn>
References: <cover.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxYeFSe7NmmB4IAA--.40675S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4UWrW8XrW7ZFWDAry7Jwc_yoWxWFyrpa
	y3AasFgrZ8JF1Y9an5J3yDZFy3ArWFqrZ7Wa17Aw1YkFnIk34UX348KFWqvrWxur4kWF12
	qryqkr48uFs8G3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Gryq6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bVL05UUUUU=

The new generation Loongson LS2K2000 SoC and LS7A2000 chipset are
equipped with the network controllers called Loongson GNET. It's the
single and multi DMA-channels Loongson GMAC but with a PHY attached.
Here is the summary of the DW GMAC features the controller has:

   DW GMAC IP-core: v3.73a
   Speeds: 10/100/1000Mbps
   Duplex: Full (both versions), Half (LS2K2000 GNET only)
   DMA-descriptors type: enhanced
   L3/L4 filters availability: Y
   VLAN hash table filter: Y
   PHY-interface: GMII (PHY is integrated into the chips)
   Remote Wake-up support: Y
   Mac Management Counters (MMC): Y
   Number of additional MAC addresses: 5
   MAC Hash-based filter: Y
   Hash Table Size: 256
   AV feature: Y (LS2K2000 GNET only)
   DMA channels: 8 (LS2K2000 GNET), 1 (LS7A2000 GNET)

Let's update the Loongson DWMAC driver to supporting the new Loongson
GNET controller. The change is mainly trivial: the driver shall be
bound to the PCIe device with DID 0x7a13, and the device-specific
setup() method shall be called for it. The only peculiarity concerns
the integrated PHY speed change procedure. The PHY has a weird problem
with switching from the low speeds to 1000Mbps mode. The speedup
procedure requires the PHY-link re-negotiation. So the suggested
change provide the device-specific fix_mac_speed() method to overcome
the problem.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 77 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 48c92ba826d9..949e349ef856 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -65,11 +65,13 @@
 					 DMA_STATUS_MSK_COMMON_LOONGSON)
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
 #define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom ID */
 #define CHANNEL_NUM			8
 
 struct loongson_data {
 	u32 loongson_id;
+	struct device *dev;
 };
 
 struct stmmac_pci_info {
@@ -147,6 +149,60 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
 };
 
+static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
+				    unsigned int mode)
+{
+	struct loongson_data *ld = (struct loongson_data *)priv;
+	struct net_device *ndev = dev_get_drvdata(ld->dev);
+	struct stmmac_priv *ptr = netdev_priv(ndev);
+
+	/* The integrated PHY has a weird problem with switching from the low
+	 * speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
+	 * re-negotiation.
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
+	struct loongson_data *ld;
+	int i;
+
+	ld = plat->bsp_priv;
+
+	loongson_default_data(pdev, plat);
+
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
 static void loongson_dwmac_dma_init_channel(struct stmmac_priv *priv,
 					    void __iomem *ioaddr,
 					    struct stmmac_dma_cfg *dma_cfg,
@@ -279,8 +335,10 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	struct mac_device_info *mac;
 	struct stmmac_dma_ops *dma;
 	struct loongson_data *ld;
+	struct pci_dev *pdev;
 
 	ld = priv->plat->bsp_priv;
+	pdev = to_pci_dev(priv->device);
 
 	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
 	if (!mac)
@@ -290,7 +348,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (!dma)
 		return NULL;
 
-	/* The Loongson GMAC devices are based on the DW GMAC
+	/* The Loongson GMAC and GNET devices are based on the DW GMAC
 	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
 	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
 	 * network controllers with the multi-channels feature
@@ -319,8 +377,19 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
-	/* Loongson GMAC doesn't support the flow control. */
-	mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
+	/* Loongson GMAC doesn't support the flow control. LS2K2000
+	 * GNET doesn't support the half-duplex link mode.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
+		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
+	} else {
+		if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
+			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					 MAC_10 | MAC_100 | MAC_1000;
+		else
+			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					 MAC_10FD | MAC_100FD | MAC_1000FD;
+	}
 
 	mac->link.duplex = GMAC_CONTROL_DM;
 	mac->link.speed10 = GMAC_CONTROL_PS;
@@ -497,6 +566,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 
 	info = (struct stmmac_pci_info *)id->driver_data;
@@ -597,6 +667,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
 	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


