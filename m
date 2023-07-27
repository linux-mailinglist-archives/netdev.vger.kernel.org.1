Return-Path: <netdev+bounces-21741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D5764862
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C150280D03
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A36C8F3;
	Thu, 27 Jul 2023 07:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CCC14D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:19:01 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096802726
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:18:58 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8CxtPBhGsJkipwKAA--.26952S3;
	Thu, 27 Jul 2023 15:18:57 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uReGsJkn7c8AA--.31333S4;
	Thu, 27 Jul 2023 15:18:56 +0800 (CST)
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
Subject: [PATCH v2 10/10] net: stmmac: dwmac-loongson: Add GNET support
Date: Thu, 27 Jul 2023 15:18:53 +0800
Message-Id: <20aa37fdfd4b03b9614befe1c8f78ffc0ac5dead.1690439335.git.chenfeiyang@loongson.cn>
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
X-CM-TRANSID:AQAAf8Ax8uReGsJkn7c8AA--.31333S4
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryDGFyxtw17tw4DAw4fJFc_yoWrur1rp3
	y7Aa47Wr97XF13Xws8Jw4DZFyYkrW3trZrWFWxKw43WFZFkrZ0qrySgFW5AF17Cr4DWF1a
	qr4jkr4UuF4DCwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNeODUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add GNET support. Current GNET does not support half duplex mode,
and GNET on LS7A only supports ANE when speed is set to 1000M.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 51 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 include/linux/stmmac.h                        |  2 +
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2d6567f0da23..1519c90cf9cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -70,6 +70,55 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
 };
 
+static void loongson_gnet_fix_speed(void *priv, unsigned int speed)
+{
+	struct net_device *ndev = (struct net_device *)(*(unsigned long *)priv);
+	struct stmmac_priv *ptr = netdev_priv(ndev);
+
+	/*
+	 * The controller and PHY don't work well together.
+	 * We need to use the PS bit to check if the controller's status
+	 * is correct and reset PHY if necessary.
+	 */
+	if (speed == SPEED_1000)
+		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
+			phy_restart_aneg(ndev->phydev);
+}
+
+static int loongson_gnet_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
+{
+	common_default_data(pdev, plat);
+
+	plat->mdio_bus_data->phy_mask = 0xfffffffb;
+
+	plat->phy_addr = 2;
+	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
+
+	plat->fix_mac_speed = loongson_gnet_fix_speed;
+
+	/* Get netdev pointer address */
+	plat->bsp_priv = &(pdev->dev.driver_data);
+
+	switch (pdev->revision) {
+	case 0x00:
+		plat->disable_half_duplex = true;
+		plat->disable_force_1000 = true;
+		break;
+	case 0x01:
+		plat->disable_half_duplex = true;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct stmmac_pci_info loongson_gnet_pci_info = {
+	.setup = loongson_gnet_data,
+};
+
 static int loongson_dwmac_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
@@ -291,9 +340,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 			 loongson_dwmac_resume);
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
 	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2ae73ab842d4..066f42ecf832 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -404,6 +404,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 		return 0;
 	}
 
+	if (priv->plat->disable_force_1000) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg != AUTONEG_ENABLE)
+			return -EOPNOTSUPP;
+	}
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4f69cad0be42..d0248effdc2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1240,7 +1240,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	}
 
 	/* Half-Duplex can only work with single queue */
-	if (priv->plat->tx_queues_to_use > 1)
+	if (priv->plat->tx_queues_to_use > 1 || priv->plat->disable_half_duplex)
 		priv->phylink_config.mac_capabilities &=
 			~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	priv->phylink_config.mac_managed_pm = true;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 54b9f308aabb..e6852dcfd0c0 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -346,5 +346,7 @@ struct plat_stmmacenet_data {
 	bool dwmac_is_loongson;
 	int has_lgmac;
 	bool disable_flow_control;
+	bool disable_half_duplex;
+	bool disable_force_1000;
 };
 #endif
-- 
2.39.3


