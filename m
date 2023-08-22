Return-Path: <netdev+bounces-29568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E97783D30
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD70C280FF2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB41B7D0;
	Tue, 22 Aug 2023 09:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7E1ADF9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:41:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 444751B2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:41:04 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
	by gateway (Coremail) with SMTP id _____8CxLOutguRkEuAaAA--.49500S3;
	Tue, 22 Aug 2023 17:41:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6pguRkkDVgAA--.38101S5;
	Tue, 22 Aug 2023 17:41:00 +0800 (CST)
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
	guyinggang@loongson.cn,
	siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v4 07/11] net: stmmac: dwmac-loongson: Add 64-bit DMA and MSI support
Date: Tue, 22 Aug 2023 17:40:56 +0800
Message-Id: <aa516a43999f43a29e3df24e9bb9968747b38438.1692696115.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1692696115.git.chenfeiyang@loongson.cn>
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxrM6pguRkkDVgAA--.38101S5
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr17KF1rZry5Aw47Gw1rAFc_yoW7tF4xpr
	W3Aa4agrW0gry3WaykZayUXF1YyrWava48trW2kwnakayYyr9YqF18tFy2yryxCrZ5Cw43
	WFZ8KFW8ua1DAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jVD73UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set 64-Bit DMA and request allocation for MSI for specific versions.
Some features of Loongson platforms are bound to the GMAC_VERSION
register. We have to read its value in order to get the correct
channel number and DMA configuration.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 153 ++++++++++++++----
 1 file changed, 123 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index dd7e9f262ca6..0748bafd3aec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -6,13 +6,108 @@
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include "stmmac.h"
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
+		      struct stmmac_resources *res, struct device_node *np);
 };
 
+static void loongson_dwmac_config_dma64(struct plat_stmmacenet_data *plat)
+{
+	plat->host_dma_width = 64;
+	plat->dma_cfg->dma64 = true;
+}
+
+static u32 get_irq_type(struct device_node *np)
+{
+	struct of_phandle_args oirq;
+
+	if (np && of_irq_parse_one(np, 0, &oirq) == 0 && oirq.args_count == 2)
+		return oirq.args[1];
+
+	return IRQF_TRIGGER_RISING;
+}
+
+static int loongson_dwmac_config_single_irq(struct pci_dev *pdev,
+					    struct plat_stmmacenet_data *plat,
+					    struct stmmac_resources *res,
+					    struct device_node *np)
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
+	plat->multi_msi_en = 0;
+	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
+		 __func__);
+
+	return 0;
+}
+
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
+		return loongson_dwmac_config_single_irq(pdev, plat, res, np);
+	}
+
+	plat->rx_queues_to_use = channel_num;
+	plat->tx_queues_to_use = channel_num;
+	plat->irq_flags = get_irq_type(np);
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
+	plat->multi_msi_en = 1;
+	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
+
+	return 0;
+}
+
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
@@ -66,8 +161,32 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_gmac_config(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat,
+				struct stmmac_resources *res,
+				struct device_node *np)
+{
+	int ret;
+	u32 version = readl(res->addr + GMAC_VERSION);
+
+	if (version & 0x00008000)
+		loongson_dwmac_config_dma64(plat);
+
+	switch (version & 0xff) {
+	case DWEGMAC_CORE_1_00:
+		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
+		break;
+	default:
+		ret = loongson_dwmac_config_single_irq(pdev, plat, res, np);
+		break;
+	}
+
+	return ret;
+}
+
 static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
+	.config = loongson_gmac_config,
 };
 
 static int loongson_dwmac_probe(struct pci_dev *pdev,
@@ -140,44 +259,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		plat->phy_interface = phy_mode;
 	}
 
-	pci_enable_msi(pdev);
-
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
@@ -201,7 +295,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
-	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.39.3


