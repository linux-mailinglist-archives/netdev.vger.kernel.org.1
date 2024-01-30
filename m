Return-Path: <netdev+bounces-67031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF364841E50
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4DC283214
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D856745;
	Tue, 30 Jan 2024 08:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BF52F62
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604519; cv=none; b=dfZoqgdvQd8SftTy1e+gdfabul57kFlq4hTfLReKFQVdbhloZ8ysu1F92bbGlxA2epVEx0bK5+p84i4qpuWZCbOfKcCGNZZBDaglwv9MeQJ0IIZn8sEFsxogHD3y0Ins4zR3lsseHxaSAcopHNEc0W+/znJcABtz/YSQ0fBx3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604519; c=relaxed/simple;
	bh=Bek/3K/9Us8xj32L6nnIWfajBdqtH3d8wVxLIEnQY5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmeHFH9bYkd1xDQJeX7wDYpHu+wFFdAMqpxlD64EQOLnjfaZKYYov71FZi8+bPzd0RjK9QUqNRajO+ACztbDEF5jqt0HkpkqPYtaAWYLNrOUsfNGd5L/pzXocMRcPI++6LwdX7+eyzTnoAp7J5vA2WeZO1D1QWYomeguAxLHL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8AxqvDjt7hlU0UIAA--.25716S3;
	Tue, 30 Jan 2024 16:48:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhPet7hl0bAnAA--.34545S4;
	Tue, 30 Jan 2024 16:48:33 +0800 (CST)
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
Subject: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
Date: Tue, 30 Jan 2024 16:48:19 +0800
Message-Id: <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8CxrhPet7hl0bAnAA--.34545S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fGF45JrWfGw4kZry7urX_yoWrJr4fpr
	43Ca4agrW5tr1fXan8Ja15XFy5Ary3trW7WF4ayw1S9FZFy3sFvFn5Xay0yrWxCrWDAF13
	Xr4rCF48uF1UAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r4j6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UR7KxUUUUU=

Request allocation for MSI for specific versions.

Some features of Loongson platforms are bound to the GMAC_VERSION
register. We have to read its value in order to get the correct channel
number.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 57 +++++++++++++++----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 584f7322bd3e..60d0a122d7c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -98,10 +98,10 @@ static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
 	if (dma_cfg->aal)
 		value |= DMA_BUS_MODE_AAL;
 
-	writel(value, ioaddr + DMA_BUS_MODE);
+	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
 
 	/* Mask interrupts by writing to CSR7 */
-	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
+	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_CHAN_INTR_ENA(chan));
 }
 
 static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -238,6 +238,45 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
+					   struct plat_stmmacenet_data *plat,
+					   struct stmmac_resources *res,
+					   struct device_node *np,
+					   int channel_num)
+{
+	int i, ret, vecs;
+
+	vecs = roundup_pow_of_two(channel_num * 2 + 1);
+	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_info(&pdev->dev,
+			 "MSI enable failed, Fallback to legacy interrupt\n");
+		return loongson_dwmac_config_legacy(pdev, plat, res, np);
+	}
+
+	plat->rx_queues_to_use = channel_num;
+	plat->tx_queues_to_use = channel_num;
+
+	res->irq = pci_irq_vector(pdev, 0);
+	res->wol_irq = res->irq;
+
+	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
+	 * --------- ----- -------- --------  ...  -------- --------
+	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
+	 */
+	for (i = 0; i < channel_num; i++) {
+		res->rx_irq[channel_num - 1 - i] =
+			pci_irq_vector(pdev, 1 + i * 2);
+		res->tx_irq[channel_num - 1 - i] =
+			pci_irq_vector(pdev, 2 + i * 2);
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
+
+	return 0;
+}
+
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
@@ -296,11 +335,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
 				struct stmmac_resources *res,
 				struct device_node *np)
 {
-	int ret;
-
-	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
 
-	return ret;
+	return 0;
 }
 
 static struct stmmac_pci_info loongson_gmac_pci_info = {
@@ -380,11 +416,7 @@ static int loongson_gnet_config(struct pci_dev *pdev,
 				struct stmmac_resources *res,
 				struct device_node *np)
 {
-	int ret;
-
-	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
-
-	return ret;
+	return 0;
 }
 
 static struct stmmac_pci_info loongson_gnet_pci_info = {
@@ -483,6 +515,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
 
 		plat->setup = loongson_setup;
+		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
+	} else {
+		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
 	}
 
 	plat->bsp_priv = ld;
-- 
2.31.4


