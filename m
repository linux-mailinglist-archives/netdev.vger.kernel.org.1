Return-Path: <netdev+bounces-56797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB186810DF3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0871F211D4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CF224D5;
	Wed, 13 Dec 2023 10:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D7E1A5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:12:42 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8CxO+mZg3llI6EAAA--.3858S3;
	Wed, 13 Dec 2023 18:12:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxguOPg3llXjMCAA--.15020S4;
	Wed, 13 Dec 2023 18:12:40 +0800 (CST)
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
Subject: [PATCH v6 2/9] net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
Date: Wed, 13 Dec 2023 18:12:24 +0800
Message-Id: <5891f7b463b7d884f98af600235321027b349043.1702458672.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8CxguOPg3llXjMCAA--.15020S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW5Kr17Xw1rWr48JFWkAFc_yoW7Gr43p3
	yfCasIgrWftry2kan5Zr4DZFyYyrWYk34fWr42kwn3Wa4qy34YqFyIgFWjyF97ArWkWw17
	XF1jkr48uF4DJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==

Add a setup() function to initialize data, and simplify code for
loongson_dwmac_probe().

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 68 +++++++++++++------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9e40c28d453a..56d1fd8c61e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -9,7 +9,12 @@
 #include <linux/of_irq.h>
 #include "stmmac.h"
 
-static int loongson_default_data(struct plat_stmmacenet_data *plat)
+struct stmmac_pci_info {
+	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+};
+
+static void loongson_default_data(struct pci_dev *pdev,
+				  struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
@@ -34,23 +39,38 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 
 	/* Disable RX queues routing by default */
 	plat->rx_queues_cfg[0].pkt_route = 0x0;
+}
+
+static int loongson_gmac_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(pdev, plat);
+
+	plat->multicast_filter_bins = 256;
+
+	plat->mdio_bus_data->phy_mask = 0;
 
-	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
 
-	plat->multicast_filter_bins = 256;
 	return 0;
 }
 
-static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static struct stmmac_pci_info loongson_gmac_pci_info = {
+	.setup = loongson_gmac_data,
+};
+
+static int loongson_dwmac_probe(struct pci_dev *pdev,
+				const struct pci_device_id *id)
 {
+	int ret, i, bus_id, phy_mode;
 	struct plat_stmmacenet_data *plat;
+	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct device_node *np;
-	int ret, i, phy_mode;
 
 	np = dev_of_node(&pdev->dev);
 
@@ -69,22 +89,22 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->mdio_bus_data)
 		return -ENOMEM;
 
+	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
+				     GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return -ENOMEM;
+
 	plat->mdio_node = of_get_child_by_name(np, "mdio");
 	if (plat->mdio_node) {
 		dev_info(&pdev->dev, "Found MDIO subnode\n");
 		plat->mdio_bus_data->needs_reset = true;
 	}
 
-	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
-	if (!plat->dma_cfg) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
+		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
+			__func__);
 		goto err_put_node;
 	}
 
@@ -98,9 +118,16 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		break;
 	}
 
-	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = pci_dev_id(pdev);
+	pci_set_master(pdev);
+
+	info = (struct stmmac_pci_info *)id->driver_data;
+	ret = info->setup(pdev, plat);
+	if (ret)
+		goto err_disable_device;
+
+	bus_id = of_alias_get_id(np, "ethernet");
+	if (bus_id >= 0)
+		plat->bus_id = bus_id;
 
 	phy_mode = device_get_phy_mode(&pdev->dev);
 	if (phy_mode < 0) {
@@ -110,11 +137,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	plat->phy_interface = phy_mode;
-	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
 
-	pci_set_master(pdev);
-
-	loongson_default_data(plat);
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
@@ -128,7 +151,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
 	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
+		dev_info(&pdev->dev,
+			 "IRQ eth_wake_irq not found, using macirq\n");
 		res.wol_irq = res.irq;
 	}
 
@@ -212,8 +236,10 @@ static int __maybe_unused loongson_dwmac_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 			 loongson_dwmac_resume);
 
+#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+
 static const struct pci_device_id loongson_dwmac_id_table[] = {
-	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
+	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


