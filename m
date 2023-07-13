Return-Path: <netdev+bounces-17388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDDD75167C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A29281B7F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F14688;
	Thu, 13 Jul 2023 02:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356E1116
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:49:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9465D10EC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:49:06 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8CxNvEgZq9kTUAEAA--.12101S3;
	Thu, 13 Jul 2023 10:49:04 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxswbZq9khJgrAA--.34828S6;
	Thu, 13 Jul 2023 10:49:03 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [RFC PATCH 09/10] net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
Date: Thu, 13 Jul 2023 10:48:54 +0800
Message-Id: <0249cb14565bcc3e949c349b24df604adc1d5aeb.1689215889.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1689215889.git.chenfeiyang@loongson.cn>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxxswbZq9khJgrAA--.34828S6
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1UWryrKryUWF4xZFW7ZFc_yoW5Ww1Upr
	W3ZasrKrW8Xr1xXanxJw4DJF15JrWav3y8W3y7Kw1SkFWvyFyvqFykKFWxXFyxCrWkAF17
	XF4qyF48W3WDJFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set 64-Bit DMA for specific versions. Request allocation for multi-
vector interrupts for DWLGMAC_CORE_1_00. If it fails, fallback to
request allocation for single interrupts.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index dc0916f2e9b8..3732f90a79c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -72,11 +72,12 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 static int loongson_dwmac_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
-	int ret, i, bus_id, phy_mode;
+	int ret, i, bus_id, phy_mode, ch_cnt, vecs;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct device_node *np;
+	u32 version;
 
 	np = dev_of_node(&pdev->dev);
 	if (np && !of_device_is_compatible(np, "loongson, pci-gmac")) {
@@ -173,12 +174,59 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		res.wol_irq = pdev->irq;
 	}
 
+	version = readl(res.addr + GMAC_VERSION);
+	switch (version & 0xff) {
+	case DWLGMAC_CORE_1_00:
+		ch_cnt = 8;
+		plat->multi_msi_en = 1;
+		break;
+
+	case DWMAC_CORE_3_50:
+	case DWMAC_CORE_3_70:
+	default:
+		plat->multi_msi_en = 0;
+		if (version & 0x00008000) {
+			plat->host_dma_width = 64;
+			plat->dma_cfg->dma64 = true;
+		}
+		break;
+	}
+
+	if (plat->multi_msi_en) {
+		plat->rx_queues_to_use = ch_cnt;
+		plat->tx_queues_to_use = ch_cnt;
+
+		pci_disable_msi(pdev);
+
+		res.irq = pci_irq_vector(pdev, 0);
+		res.wol_irq = res.irq;
+		vecs = roundup_pow_of_two(ch_cnt * 2 + 1);
+		if (pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI) < 0) {
+			dev_info(&pdev->dev,
+				 "MSI enable failed, Fallback to line interrupt\n");
+			plat->multi_msi_en = 0;
+		} else {
+			/*
+			 * INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
+			 * --------- ----- -------- --------  ...  -------- --------
+			 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
+			 */
+			for (i = 0; i < ch_cnt; i++) {
+				res.rx_irq[ch_cnt - 1 - i] = pci_irq_vector(pdev, 1 + i * 2);
+				res.tx_irq[ch_cnt - 1 - i] = pci_irq_vector(pdev, 2 + i * 2);
+			}
+		}
+	}
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-		goto err_disable_msi;
+		goto err_free_irq_vectors;
 
 	return ret;
 
+err_free_irq_vectors:
+	if (plat->multi_msi_en)
+		pci_free_irq_vectors(pdev);
 err_disable_msi:
 	pci_disable_msi(pdev);
 err_disable_device:
@@ -204,6 +252,7 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
+	pci_free_irq_vectors(pdev);
 	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.39.3


