Return-Path: <netdev+bounces-56804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFD810E1F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56AA1F2121C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636F224DF;
	Wed, 13 Dec 2023 10:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F3111A
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:15:07 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8AxZfAohHlluKEAAA--.3978S3;
	Wed, 13 Dec 2023 18:15:04 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXeEnhHllQjQCAA--.14860S2;
	Wed, 13 Dec 2023 18:15:03 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v6 7/9] net: stmmac: dwmac-loongson: Add GNET support
Date: Wed, 13 Dec 2023 18:15:00 +0800
Message-Id: <bb70f5be5e48f252d460042d85d5cd8fa425d191.1702458672.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702458672.git.siyanteng@loongson.cn>
References: <cover.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxXeEnhHllQjQCAA--.14860S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryktFyrKF1rWw1UXF1UArc_yoWrKryxpw
	43AasF9rW7tF1xKws5Jws8AFyYkFZxKrZ7WrW7twnIgFZFy34FqryjgFW2yry7CrWDury3
	Xr4qkr48uFs8CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=

Add Loongson GNET (GMAC with PHY) support. Current GNET does not support
half duplex mode, and GNET on LS7A only supports ANE when speed is set to
1000M.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
 include/linux/stmmac.h                        |  2 +
 3 files changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2c08d5495214..9e4953c7e4e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -168,6 +168,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.config = loongson_gmac_config,
 };
 
+static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct net_device *ndev = dev_get_drvdata(priv);
+	struct stmmac_priv *ptr = netdev_priv(ndev);
+
+	/* The controller and PHY don't work well together.
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
+	loongson_default_data(pdev, plat);
+
+	plat->multicast_filter_bins = 256;
+
+	plat->mdio_bus_data->phy_mask = 0xfffffffb;
+
+	plat->phy_addr = 2;
+	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
+
+	plat->bsp_priv = &pdev->dev;
+	plat->fix_mac_speed = loongson_gnet_fix_speed;
+
+	plat->dma_cfg->pbl = 32;
+	plat->dma_cfg->pblx8 = true;
+
+	plat->clk_ref_rate = 125000000;
+	plat->clk_ptp_rate = 125000000;
+
+	return 0;
+}
+
+static int loongson_gnet_config(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat,
+				struct stmmac_resources *res,
+				struct device_node *np)
+{
+	int ret;
+	u32 version = readl(res->addr + GMAC_VERSION);
+
+	switch (version & 0xff) {
+	case DWLGMAC_CORE_1_00:
+		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
+		break;
+	default:
+		ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
+		break;
+	}
+
+	switch (pdev->revision) {
+	case 0x00:
+		plat->flags |=
+			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
+			FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
+		break;
+	case 0x01:
+		plat->flags |=
+			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static struct stmmac_pci_info loongson_gnet_pci_info = {
+	.setup = loongson_gnet_data,
+	.config = loongson_gnet_config,
+};
+
 static int loongson_dwmac_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
@@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
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
index f628411ae4ae..646a1af12705 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -410,6 +410,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 		return 0;
 	}
 
+	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg != AUTONEG_ENABLE)
+			return -EOPNOTSUPP;
+	}
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f07f79d50b06..067030cdb60f 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -222,6 +222,8 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
 #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
+#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
+#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


