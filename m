Return-Path: <netdev+bounces-91317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369378B223D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3EC28216B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED82149C4F;
	Thu, 25 Apr 2024 13:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409F1494DA
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050652; cv=none; b=gE3etfIMKT+SWpUOSxkl4xUYyzjHX7WDW6o2a8z0xtfiptYKKQskV4TYs39Bf99EkYybDUHWUqWaLOIsZXRMhANtB09al4qtXS3NNeFv7OqykWYSC9CNlpuLvSv/E9QaGdrDGBWKmf5fyrK8OmjHLHM59n3VB4MOEeR2z5pVsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050652; c=relaxed/simple;
	bh=WJqKXTN/i2DRG1BIte/WnpOgm72ZeDEhDp3QHmRNSxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmqGSnTs/9+IUed0+ZZfS2THVPLrcik16+U5uiUUhSfym13CAAU2ntOS8begX92Xg0eURwrhjWmWvT+3q+ovG8vN4mwmlAT9199yl3e9Ae7RBgis4EKSh2YfuYdeMnL+LSiqWI7Q/uyQzjel4S/LnkWSG8wDexlCJJKU6EkWXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxV_BYVipmntACAA--.13303S3;
	Thu, 25 Apr 2024 21:10:48 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+91SVipmIRsFAA--.17935S3;
	Thu, 25 Apr 2024 21:10:46 +0800 (CST)
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
	siyanteng01@gmail.com
Subject: [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
Date: Thu, 25 Apr 2024 21:10:36 +0800
Message-Id: <b26258cae28b19c8d204beca691fea877b3bf537.1714046812.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx+91SVipmIRsFAA--.17935S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fGF4DWr1fKFW3Wr1UCFX_yoW5Wr4DpF
	ZxAa4YgrySgr1fWayDAay7XFyY9rWjv348Gw42kw1S9a4Yv34YqF15tFWjyr1xArZ5CFW3
	XryUCFW8uF4DuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0hjjDUUUUU==

Move res._irq to loongson_dwmac_config_legacy().
No function changes.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 56 +++++++++++--------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 1022bceaa680..df5899bec91a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -68,6 +68,38 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
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
+	return 0;
+}
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
@@ -136,28 +168,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 			goto err_disable_device;
 		}
 		plat->phy_interface = phy_mode;
-
-		res.irq = of_irq_get_byname(np, "macirq");
-		if (res.irq < 0) {
-			dev_err(&pdev->dev, "IRQ macirq not found\n");
-			ret = -ENODEV;
-			goto err_disable_msi;
-		}
-
-		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
-		if (res.wol_irq < 0) {
-			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
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
 	}
 
 	pci_enable_msi(pdev);
@@ -167,6 +177,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
 
+	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_disable_msi;
-- 
2.31.4


