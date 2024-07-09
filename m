Return-Path: <netdev+bounces-110196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB292B402
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E503CB20F69
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B3155385;
	Tue,  9 Jul 2024 09:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6013C687
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517869; cv=none; b=LEI8wgfcyx1SXTaLui6vDwaS5fHywdYkVDbGQA8hgxocShfJ0mZ1sZb2r/BCVLz3sdkLinB2it32rOa9G7asqARNg+IDnEuReILqEXrUH1p1M7QBIKGeZ5Y3IHDVnHXH/o/IgcSPiVbgk3giprGX6AILnHQUigr1RTsc8u4Amo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517869; c=relaxed/simple;
	bh=2p8Ye4a0lMwlrO70ZKqfbOcVjgjxNH6mbiD5cTNXLow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYHMZE6OCLH4BfK2bxg2Zc2ya3fBcnnEFuIMuw/85Jk8gtC4oo/pWoCnERsavsWFS9sWAiyRE/2Odf/COHdb4S+PpNk0oLMzvIzOqvvU5lM0V3A1K8BDZ/vlzw8/bw9ytlwNND5at/Ju9Mkj6h6Y7pjuuGGepEZcoKFkMpImoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8BxHOvpBI1mt14CAA--.7157S3;
	Tue, 09 Jul 2024 17:37:45 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnsfmBI1mU9hAAA--.18765S3;
	Tue, 09 Jul 2024 17:37:44 +0800 (CST)
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
	si.yanteng@linux.dev
Subject: [PATCH net-next v14 13/14] net: stmmac: dwmac-loongson: Add Loongson GNET support
Date: Tue,  9 Jul 2024 17:37:36 +0800
Message-Id: <1ec55fa80200609384b6be35312d9f61dd414d6d.1720512634.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1720512634.git.siyanteng@loongson.cn>
References: <cover.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnsfmBI1mU9hAAA--.18765S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4UWrW8XrW7ZFWDAry7Jwc_yoW7ZF4xpa
	y3Aa9FgrZxJF4Ykan5trWDZFy5ArZaqrZ7Wa17Cw15KFnIk34jq34YkFWqvrWxurs7uF12
	qrWqkr4xuFs8GacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r126r1DMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgqNtDUUUU

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
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 72 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ed45d6e56de2..3fed7292b755 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -65,6 +65,7 @@
 					 DMA_STATUS_MSK_COMMON_LOONGSON)
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
 #define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom IP */
 #define CHANNEL_NUM			8
 
@@ -148,6 +149,60 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
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
@@ -293,7 +348,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (!dma)
 		return NULL;
 
-	/* The Loongson GMAC devices are based on the DW GMAC
+	/* The Loongson GMAC and GNET devices are based on the DW GMAC
 	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
 	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
 	 * network controllers with the multi-channels feature
@@ -322,9 +377,19 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
-	/* Loongson GMAC doesn't support the flow control. */
-	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC)
+	/* Loongson GMAC doesn't support the flow control. LS2K2000
+	 * GNET doesn't support the half-duplex link mode.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
 		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
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
@@ -591,6 +656,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
 	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


