Return-Path: <netdev+bounces-67028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB1841E36
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30C21F2D5D1
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027059B49;
	Tue, 30 Jan 2024 08:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD759147
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604236; cv=none; b=GDUNCPFQu0HMTS4ECShw0mvvjvoM9TYmuy9pagBGnkFPr12yjV5ws4svsi8eQ9US238pWjoYhtU5+zd2sqcuS9s0+I5GmTURj+B9EnJjFw9oMn5xxqsUtIn8HZp6hBdNGYRiESD766YJtASeC7rbbIz0oD4BVSiC+tkgfh12SB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604236; c=relaxed/simple;
	bh=xmZa9csnLOVchW4yd1z5hn9BvKoEDByX2Y7V1JSkMoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yj+BWxS584EkSdGuQwtxtVVXVn2g3m72X7/E52JgatvlC5l7Ga2l9+mVZsCvidD5nQFE0Za3oScacwCRKT8Z+4LWKrjXAV3N6SY+KNqbIjJM2iinwLrBPjtB2SxJI1lL1h80m9Zxw24TlelIoO2GceOu137TGGqgn7YSMTARhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8Dx6ujItrhlzUMIAA--.5885S3;
	Tue, 30 Jan 2024 16:43:52 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZMy+trhltK4nAA--.30345S6;
	Tue, 30 Jan 2024 16:43:50 +0800 (CST)
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
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v8 04/11] net: stmmac: dwmac-loongson: Move irq config to loongson_gmac_config
Date: Tue, 30 Jan 2024 16:43:24 +0800
Message-Id: <776bfe84003b203ebe320dc7bf6b98707a667fa9.1706601050.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1706601050.git.siyanteng@loongson.cn>
References: <cover.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZMy+trhltK4nAA--.30345S6
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4rXFW5Gw43Ar1DXFy7urX_yoWrXry7pr
	y3Aa4YgrySgry3Wa98ZFWUXFyYvrW2v348K3y2kw1S9a4YyasYqF1rtFyjyr1xArZ5GF13
	XrWUKFW8uF4DCFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6rWOUUUUU=

Add loongson_dwmac_config and moving irq config related
code to loongson_dwmac_config.

Removing MSI to prepare for adding loongson multi-channel
support later.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 85 ++++++++++++-------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 979c9b6dab3f..e7ce027cc14e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,8 +11,46 @@
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
+		      struct stmmac_resources *res, struct device_node *np);
 };
 
+static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
+					struct plat_stmmacenet_data *plat,
+					struct stmmac_resources *res,
+					struct device_node *np)
+{
+	if (np) {
+		res->irq = of_irq_get_byname(np, "macirq");
+		if (res->irq < 0) {
+			dev_err(&pdev->dev, "IRQ macirq not found\n");
+			return -ENODEV;
+		}
+
+		res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
+		if (res->wol_irq < 0) {
+			dev_info(&pdev->dev,
+				 "IRQ eth_wake_irq not found, using macirq\n");
+			res->wol_irq = res->irq;
+		}
+
+		res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
+		if (res->lpi_irq < 0) {
+			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
+			return -ENODEV;
+		}
+	} else {
+		res->irq = pdev->irq;
+		res->wol_irq = res->irq;
+	}
+
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
+		 __func__);
+
+	return 0;
+}
+
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
@@ -66,8 +104,21 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_gmac_config(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat,
+				struct stmmac_resources *res,
+				struct device_node *np)
+{
+	int ret;
+
+	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
+
+	return ret;
+}
+
 static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
+	.config = loongson_gmac_config,
 };
 
 static int loongson_dwmac_probe(struct pci_dev *pdev,
@@ -139,44 +190,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		plat->phy_interface = phy_mode;
 	}
 
-	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
-	if (np) {
-		res.irq = of_irq_get_byname(np, "macirq");
-		if (res.irq < 0) {
-			dev_err(&pdev->dev, "IRQ macirq not found\n");
-			ret = -ENODEV;
-			goto err_disable_msi;
-		}
-
-		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-		if (res.wol_irq < 0) {
-			dev_info(&pdev->dev,
-				 "IRQ eth_wake_irq not found, using macirq\n");
-			res.wol_irq = res.irq;
-		}
-
-		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-		if (res.lpi_irq < 0) {
-			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-			ret = -ENODEV;
-			goto err_disable_msi;
-		}
-	} else {
-		res.irq = pdev->irq;
-		res.wol_irq = pdev->irq;
-	}
+	ret = info->config(pdev, plat, &res, np);
+	if (ret)
+		goto err_disable_device;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-		goto err_disable_msi;
+		goto err_disable_device;
 
 	return ret;
 
-err_disable_msi:
-	pci_disable_msi(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 err_put_node:
@@ -200,7 +226,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
-	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.31.4


