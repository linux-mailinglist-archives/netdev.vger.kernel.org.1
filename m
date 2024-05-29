Return-Path: <netdev+bounces-98978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B78D3475
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4BDB23187
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191F17B42A;
	Wed, 29 May 2024 10:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED1169ADB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978047; cv=none; b=gp2s8ris2qUFLHcVvHJI6CbfGggG2ENlU0X8P7xQeMyt+N/KLjfUQSusCB49fTLEIORqyh5N8L8fgxLimsWNtWy0BwlkkxOys1nLkqgElHnqaz7+SB54qU6CAS7FoiVnzDDjFkAK4AXwRgd17RgrFk0ffhFd+HRxpN90TXHRJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978047; c=relaxed/simple;
	bh=q365SbXezDLkUhAU8z6bdnMEWaoUMCsVEEClE8Ey+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbWRYKw9X8YL2iOU5BMj3oL2hbciwycl/tkuIpM0sSU+d6PmjdZPBE4GSt5/84TYLGDfLbLwaqmmK82cYkf+1OlHJPekuRh0LR6zP6sQ+YuLhvUz/BXHMj7gy/1gOHG+78fIwg3Fv0sSvh2/hR+HKcj3FDQ3hSCvAa3L/sBRsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8DxSup7AVdmKhkBAA--.4766S3;
	Wed, 29 May 2024 18:20:43 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqsZ2AVdmwt4MAA--.33803S2;
	Wed, 29 May 2024 18:20:39 +0800 (CST)
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
Subject: [PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
Date: Wed, 29 May 2024 18:20:26 +0800
Message-Id: <fa22df795219256b093659195c4609445a175a1d.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxqsZ2AVdmwt4MAA--.33803S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFWkZr4UtFW7AF4kXF15Jrc_yoW7ZrWUpa
	yfCasxtr93KryIgan5JFWUZF1YkrW2v348Ga12k34fuayYqr1YqF1UtFWjyFyxAFWkWw1a
	qr1jqF48uF4DuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bY5rxUUUUU=

The Loongson GMAC driver currently supports the network controllers
installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
devices are required to be defined in the platform device tree source.
Let's extend the driver functionality with the case of having the
Loongson GMAC probed on the PCI bus with no device tree node defined
for it. That requires to make the device DT-node optional, to rely on
the IRQ line detected by the PCI core and to have the MDIO bus ID
calculated using the PCIe Domain+BDF numbers.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 105 +++++++++---------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index fec2aa0607d4..8bcf9d522781 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -12,11 +12,15 @@
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 
 struct stmmac_pci_info {
-	int (*setup)(struct plat_stmmacenet_data *plat);
+	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
 };
 
-static void loongson_default_data(struct plat_stmmacenet_data *plat)
+static void loongson_default_data(struct pci_dev *pdev,
+				  struct plat_stmmacenet_data *plat)
 {
+	/* Get bus_id, this can be overwritten later */
+	plat->bus_id = pci_dev_id(pdev);
+
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
@@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
 	plat->dma_cfg->pblx8 = true;
 }
 
-static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
+static int loongson_gmac_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
 {
-	loongson_default_data(plat);
+	loongson_default_data(pdev, plat);
 
 	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
@@ -68,15 +73,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct device_node *np;
-	int ret, i, phy_mode;
+	int ret, i;
 
 	np = dev_of_node(&pdev->dev);
 
-	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
-		return -ENODEV;
-	}
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
@@ -87,17 +87,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->mdio_bus_data)
 		return -ENOMEM;
 
-	plat->mdio_node = of_get_child_by_name(np, "mdio");
-	if (plat->mdio_node) {
-		dev_info(&pdev->dev, "Found MDIO subnode\n");
-		plat->mdio_bus_data->needs_reset = true;
-	}
-
 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
-	if (!plat->dma_cfg) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!plat->dma_cfg)
+		return -ENOMEM;
 
 	/* Enable pci device */
 	ret = pci_enable_device(pdev);
@@ -117,49 +109,58 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	info = (struct stmmac_pci_info *)id->driver_data;
-	ret = info->setup(plat);
+	ret = info->setup(pdev, plat);
 	if (ret)
 		goto err_disable_device;
 
-	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = pci_dev_id(pdev);
+	pci_set_master(pdev);
 
-	phy_mode = device_get_phy_mode(&pdev->dev);
-	if (phy_mode < 0) {
-		dev_err(&pdev->dev, "phy_mode not found\n");
-		ret = phy_mode;
-		goto err_disable_device;
-	}
+	if (np) {
+		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		if (plat->mdio_node) {
+			dev_info(&pdev->dev, "Found MDIO subnode\n");
+			plat->mdio_bus_data->needs_reset = true;
+		}
 
-	plat->phy_interface = phy_mode;
+		ret = of_alias_get_id(np, "ethernet");
+		if (ret >= 0)
+			plat->bus_id = ret;
 
-	pci_set_master(pdev);
+		ret = device_get_phy_mode(&pdev->dev);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_mode not found\n");
+			goto err_disable_device;
+		}
+
+		plat->phy_interface = ret;
+
+		res.irq = of_irq_get_byname(np, "macirq");
+		if (res.irq < 0) {
+			dev_err(&pdev->dev, "IRQ macirq not found\n");
+			ret = -ENODEV;
+			goto err_disable_msi;
+		}
+
+		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
+		if (res.wol_irq < 0) {
+			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
+			res.wol_irq = res.irq;
+		}
+
+		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
+		if (res.lpi_irq < 0) {
+			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
+			ret = -ENODEV;
+			goto err_disable_msi;
+		}
+	} else {
+		res.irq = pdev->irq;
+	}
 
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
-	res.irq = of_irq_get_byname(np, "macirq");
-	if (res.irq < 0) {
-		dev_err(&pdev->dev, "IRQ macirq not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
-
-	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
-		res.wol_irq = res.irq;
-	}
-
-	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res.lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
-
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
 
-- 
2.31.4


