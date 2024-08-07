Return-Path: <netdev+bounces-116480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D749394A8DB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F928737A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6C16D33D;
	Wed,  7 Aug 2024 13:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF01E2122
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038439; cv=none; b=NtOC1iuJpAGo8oxXo5C2wiCm6kfvSG2Aig86FAzM0klTNg0RuVfxlqxl1S5/oNvfwfjw8lfb4cB+uzdchPRALkAodNRFzP/fPFq69yovKe3ipqLQDn9z1z2vfCus5XW9xBFYGGLbzNqnmj1shOGXCO9zNljmSWixmShOhzdMSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038439; c=relaxed/simple;
	bh=N1ez8mnV5MhDJJMnpI/t1p084dljcdJDtSssEaKB/a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tg+nFrvhD1vwKg1KJ2Q9+nxas1SuxScJjGi7Z2vsXu8zDq+2XWueZqKmhIs1U6OkV0XcCK98SLmSZ8Ws/fCbyLPamHFx1cp1tIzSdp/C+yC8f8Fwvb3z+6q8bMmZm2zAQHmaNvcg/Ej043hNhVndj7lSXb54xSTgqlfojWSwVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8BxKurkerNmkXYKAA--.32568S3;
	Wed, 07 Aug 2024 21:47:16 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMAxVODferNm9B0IAA--.41070S3;
	Wed, 07 Aug 2024 21:47:15 +0800 (CST)
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
Subject: [PATCH net-next v17 05/14] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
Date: Wed,  7 Aug 2024 21:47:08 +0800
Message-Id: <eba4736ee5ac89f46d9c149c0f147b32a81b5c0c.1723014611.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1723014611.git.siyanteng@loongson.cn>
References: <cover.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVODferNm9B0IAA--.41070S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1xXFWfKF13AFy3Kw1DCFX_yoW8tr48pF
	sxAa4Fgry0qry7ua1DZr4UXFy5XrW7t397GF4jkw1F939ay34vqF1rtFyjvFyxAFWkG3W7
	XrWqyr18uF4kC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=

The Loongson GMAC driver currently doesn't utilize the MSI IRQs, but
retrieves the IRQs specified in the device DT-node. Let's drop the
direct pci_enable_msi()/pci_disable_msi() calls then as redundant

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9dbd11766364..32814afdf321 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -114,7 +114,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	pci_set_master(pdev);
 
 	loongson_default_data(plat);
-	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
@@ -122,7 +121,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (res.irq < 0) {
 		dev_err(&pdev->dev, "IRQ macirq not found\n");
 		ret = -ENODEV;
-		goto err_disable_msi;
+		goto err_disable_device;
 	}
 
 	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
@@ -135,17 +134,15 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (res.lpi_irq < 0) {
 		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
 		ret = -ENODEV;
-		goto err_disable_msi;
+		goto err_disable_device;
 	}
 
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
@@ -169,7 +166,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
-	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.31.4


