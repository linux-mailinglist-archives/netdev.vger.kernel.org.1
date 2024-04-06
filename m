Return-Path: <netdev+bounces-85412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4889AB11
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DF6B21637
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC8374C4;
	Sat,  6 Apr 2024 13:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4DD2C6B6
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409899; cv=none; b=A88rgfwTKogN4VtTpsUB2JKrzxFscxSp5tufn5v6NomP6WR91rBVq2u6hikbNKwlmMkX+Q+j/gICRMZrIw7nnqVs7EWQ2VesD+RIkxt2vQUlHDf+t+xXetM52wA2V08koszmm7veYhT4jDFk+z+a32XDpnWxS5D0pFYIw0tAjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409899; c=relaxed/simple;
	bh=iTC8yRRFnVhguWjrnQCN+NBR2PEpxN466MFd1SfF3is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOBUxZRhbJtGpB3Z9eF4kDyL+HakGmq0iiarS3WPEZ/s8JVSheHn4bFve89iJJbkEoManXNSiAH0345UTJHYV0krFeRVsltDA6kc56NVdHAi9C8wlv+pTe3/xh6H+MQVgC9huh4Z/hqSXJ7BoGZCr9QS7p9n7bbOpNfb74zqiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8BxOPAmTRFmmdgjAA--.17250S3;
	Sat, 06 Apr 2024 21:24:54 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXRMiTRFmjDp0AA--.28122S3;
	Sat, 06 Apr 2024 21:24:53 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: [PATCH net-next v9 5/6] net: stmmac: dwmac-loongson: Add full PCI support
Date: Sat,  6 Apr 2024 21:24:39 +0800
Message-Id: <26d22ccabf7b72c01c1e32203dde313179fc57a7.1712407009.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1712407009.git.siyanteng@loongson.cn>
References: <cover.1712407009.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXRMiTRFmjDp0AA--.28122S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jry7GFy8tw1DAw43AFykCrX_yoW7AFW7pa
	yfCasxtrZ5Jry7Wan5XF4UX3WY9rW29348G3y2k3s3uayYvryYqF1xKFyjyFyfAFWkCw1a
	gr1jqF48uF4DuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6rWOUUUUU=

Current dwmac-loongson only support LS2K in the "probed with PCI and
configured with DT" manner. Add LS7A support on which the devices are
fully PCI (non-DT).

Others:
LS2K is a SoC and LS7A is a bridge chip. In the current driving state,
they are both gmac and phy_interface is RGMII.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 103 +++++++++++-------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 20ddbf0dc6ab..84ead5edd6d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -9,9 +9,19 @@
 #include <linux/of_irq.h>
 #include "stmmac.h"
 
+#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+
+struct stmmac_pci_info {
+	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+};
+
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
+	/* Get bus_id, this can be overloaded later */
+	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
@@ -40,6 +50,7 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
@@ -54,19 +65,17 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 	return 0;
 }
 
+static struct stmmac_pci_info loongson_gmac_pci_info = {
+	.setup = loongson_gmac_data,
+};
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
+	int ret, i, bus_id, phy_mode;
+	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct device_node *np;
-	int ret, i, phy_mode;
-
-	np = dev_of_node(&pdev->dev);
-
-	if (!np) {
-		pr_info("dwmac_loongson_pci: No OF node\n");
-		return -ENODEV;
-	}
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -78,12 +87,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat->mdio_bus_data)
 		return -ENOMEM;
 
-	plat->mdio_node = of_get_child_by_name(np, "mdio");
-	if (plat->mdio_node) {
-		dev_info(&pdev->dev, "Found MDIO subnode\n");
-		plat->mdio_bus_data->needs_reset = true;
-	}
-
 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
 	if (!plat->dma_cfg) {
 		ret = -ENOMEM;
@@ -107,10 +110,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		break;
 	}
 
-	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = pci_dev_id(pdev);
-
 	phy_mode = device_get_phy_mode(&pdev->dev);
 	if (phy_mode < 0) {
 		dev_err(&pdev->dev, "phy_mode not found\n");
@@ -122,30 +121,56 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	pci_set_master(pdev);
 
-	loongson_gmac_data(pdev, plat);
-	pci_enable_msi(pdev);
-	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[0];
-
-	res.irq = of_irq_get_byname(np, "macirq");
-	if (res.irq < 0) {
-		dev_err(&pdev->dev, "IRQ macirq not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
+	info = (struct stmmac_pci_info *)id->driver_data;
+	ret = info->setup(pdev, plat);
+	if (ret)
+		goto err_disable_device;
 
-	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-	if (res.wol_irq < 0) {
-		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
-		res.wol_irq = res.irq;
+	if (np) {
+		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		if (plat->mdio_node) {
+			dev_info(&pdev->dev, "Found MDIO subnode\n");
+			plat->mdio_bus_data->needs_reset = true;
+		}
+
+		bus_id = of_alias_get_id(np, "ethernet");
+		if (bus_id >= 0)
+			plat->bus_id = bus_id;
+
+		phy_mode = device_get_phy_mode(&pdev->dev);
+		if (phy_mode < 0) {
+			dev_err(&pdev->dev, "phy_mode not found\n");
+			ret = phy_mode;
+			goto err_disable_device;
+		}
+		plat->phy_interface = phy_mode;
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
 	}
 
-	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res.lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
+	pci_enable_msi(pdev);
+	memset(&res, 0, sizeof(res));
+	res.addr = pcim_iomap_table(pdev)[0];
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-- 
2.31.4


