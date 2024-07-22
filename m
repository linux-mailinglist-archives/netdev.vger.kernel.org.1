Return-Path: <netdev+bounces-112406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482F0938DD3
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40482810DF
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89916CD11;
	Mon, 22 Jul 2024 11:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118A16B399
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646113; cv=none; b=r0RtlfIcLoxIN4qp/Mf+oUKsQXMu75Ao6iX8ZlWThADEUGzAPJRbLdZmU/oR8fwcCxMhEYxJj2u2M8NWykzaQBaYPMU3VNUnHXx/SnXGtpJGCr66DN5rmF8UhqSipv30vNaU+8tzzXPRcGbyk2DSZcy6v5TW2ec6h6Ey/Kr+Xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646113; c=relaxed/simple;
	bh=CnznKxJzCJXRos/E2ax1yI8yoFrj3YuU/LwSw91i6LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tChiVnOXqLKQM5mR/6qSI2rsXybmQRgHkMJfP4imE4LLVzdi78Q/qe79PwGEglgNIITEC/nXAyx7K7gzaXSv4aq7fVs/0ZBj2wlmfHi3oBGS5H7jwDJZR/Gs2RV154RM4ueNeOI+BMs8Kvu8XmnuFC0uD8CVltFvowprn6wLSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMMQTPJ5mtBtUAA--.19050S2;
	Mon, 22 Jul 2024 19:01:41 +0800 (CST)
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
Subject: [PATCH net-next RFC v15 13/14] net: stmmac: dwmac-loongson: Add Loongson GNET support
Date: Mon, 22 Jul 2024 19:01:38 +0800
Message-Id: <b1e950d2e6c518dc985248fd4185ff34d5c59354.1721645682.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxMMQTPJ5mtBtUAA--.19050S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4UWrW8Xr13GF4fGF4xtFb_yoWxJr4Dpa
	y3Aa9Fgrs8JF4Ykan5t3yDZFy5ArZaqrZ7Ga17AwnFkFnFk34UX34YkFWqvrWxur4kuF12
	qrWvkr48uFs8Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUjDKsUUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

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
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 75 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index b0287ef34b5f..f84b8c573be6 100644
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
@@ -292,7 +348,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (!dma)
 		return NULL;
 
-	/* The Loongson GMAC devices are based on the DW GMAC
+	/* The Loongson GMAC and GNET devices are based on the DW GMAC
 	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
 	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
 	 * network controllers with the multi-channels feature
@@ -321,8 +377,19 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
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
@@ -498,6 +565,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 
 	info = (struct stmmac_pci_info *)id->driver_data;
@@ -602,6 +670,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
 	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


