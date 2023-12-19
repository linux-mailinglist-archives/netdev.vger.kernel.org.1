Return-Path: <netdev+bounces-58906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CF818995
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522E328905A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0A1B26C;
	Tue, 19 Dec 2023 14:17:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA91B274
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8DxVPD5pYFlvqICAA--.13474S3;
	Tue, 19 Dec 2023 22:17:29 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzuTypYFlAnIAAA--.3411S4;
	Tue, 19 Dec 2023 22:17:28 +0800 (CST)
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
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v7 2/9] net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
Date: Tue, 19 Dec 2023 22:17:05 +0800
Message-Id: <aee820a3c4293c8172edda27ad4eb9cf5eaead5e.1702990507.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1702990507.git.siyanteng@loongson.cn>
References: <cover.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxzuTypYFlAnIAAA--.3411S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW5Kr17Xw1rWr48JFWkAFc_yoW7Gr43p3
	yfCasIgrWftry2kan5Zr4DZFyYyrWYk34fWr42kwn3Wa4qy34YqFyIgFWjyF97ArWkWw17
	XF1jkr48uF4DJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

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


