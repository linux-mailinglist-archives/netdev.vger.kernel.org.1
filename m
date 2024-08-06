Return-Path: <netdev+bounces-116033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A0948D53
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DECC2867EE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509971C0DF9;
	Tue,  6 Aug 2024 10:59:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6017C203
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941954; cv=none; b=Bnjwa8z/BRFdJ6BcZHfCNDxkiFt7j+f+pae0AMWz4kM6SyHiZstiIqpmVNRAOTLzKOBKlJRBDMGcJ823cJGpke9tw/fpKIfxi8FzvXhpA01B5vekWSmIDl+259AkpWEIx4JKD6c8MPkKhxZvdt5uYVIzPBWBkqNqugw67RH0y7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941954; c=relaxed/simple;
	bh=N1ez8mnV5MhDJJMnpI/t1p084dljcdJDtSssEaKB/a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFB+qSqgrdqy4BNSPkb3o0xj/6/ZYfkUbIjnudanpzwn22ZW8Q8ZDtbEtB94rM1Dwhu0JtgfEpLMERw0EVs4fU6cs+L3i7qDL1VIoemM0b6xeLzxb7RdSmJRhZq20qXvKdc9rCy1yd6xQofUgAGSN6vB2CZHizl19AC6RTl4NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8BxKur_AbJm5q8IAA--.28866S3;
	Tue, 06 Aug 2024 18:59:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMAx4+H7AbJmIvgFAA--.31275S3;
	Tue, 06 Aug 2024 18:59:10 +0800 (CST)
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
Subject: [PATCH net-next v16 05/14] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
Date: Tue,  6 Aug 2024 18:58:55 +0800
Message-Id: <e412ad3063d222e668dedfd543ec83b973d47ba4.1722924540.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1722924540.git.siyanteng@loongson.cn>
References: <cover.1722924540.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx4+H7AbJmIvgFAA--.31275S3
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


