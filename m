Return-Path: <netdev+bounces-24006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2E76E6F4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704021C2157B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73218B1A;
	Thu,  3 Aug 2023 11:30:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272A1EA74
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:30:52 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330501981
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:30:51 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8AxFvHpj8tkX60PAA--.36312S3;
	Thu, 03 Aug 2023 19:30:49 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTSPoj8tkyR5HAA--.34056S2;
	Thu, 03 Aug 2023 19:30:49 +0800 (CST)
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
Subject: [PATCH v3 13/16] net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
Date: Thu,  3 Aug 2023 19:30:34 +0800
Message-Id: <48ceed6b5d7b32c2e46b79fa597466b9212f745e.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTSPoj8tkyR5HAA--.34056S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1UWryrKryUWF1kXw4UJrc_yoWrWr17pF
	ZxAa47KrW8Jr17Wan8Aw4DAF1YyrWav3y0grWakwnakayqkr9YqFyvqFWIvryxCrWkGF17
	XF4DKF48W3WUJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	DU0xZFpf9x07bOfHUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set 64-Bit DMA for specific versions. Request allocation for multi-
vector interrupts for DWLGMAC_CORE_1_00. If it fails, fallback to
request allocation for single interrupts.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 83 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index c7790f73fe18..18bca996e1cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -6,11 +6,15 @@
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/of_irq.h>
+#include "dwmac1000.h"
 #include "stmmac.h"
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
+	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
+		      struct stmmac_resources *res);
 };
 
 static void loongson_default_data(struct pci_dev *pdev,
@@ -66,14 +70,54 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_gmac_config(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat,
+				struct stmmac_resources *res)
+{
+	u32 version = readl(res->addr + GMAC_VERSION);
+
+	switch (version & 0xff) {
+	case DWLGMAC_CORE_1_00:
+		plat->multi_msi_en = 1;
+		plat->rx_queues_to_use = 8;
+		plat->tx_queues_to_use = 8;
+		plat->fix_channel_num = true;
+		break;
+	case DWMAC_CORE_3_50:
+	case DWMAC_CORE_3_70:
+		if (version & 0x00008000) {
+			plat->host_dma_width = 64;
+			plat->dma_cfg->dma64 = true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	plat->dma_reset_times = 5;
+
+	return 0;
+}
+
 static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.setup = loongson_gmac_data,
+	.config = loongson_gmac_config,
 };
 
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
 static int loongson_dwmac_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
-	int ret, i, bus_id, phy_mode;
+	int ret, i, bus_id, phy_mode, ch_cnt, vecs;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
@@ -170,12 +214,46 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		res.wol_irq = pdev->irq;
 	}
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
+	ret = info->config(pdev, plat, &res);
 	if (ret)
 		goto err_disable_msi;
 
+	if (plat->multi_msi_en) {
+		ch_cnt = plat->rx_queues_to_use;
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
+			/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
+			 * --------- ----- -------- --------  ...  -------- --------
+			 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
+			 */
+			for (i = 0; i < ch_cnt; i++) {
+				res.rx_irq[ch_cnt - 1 - i] = pci_irq_vector(pdev, 1 + i * 2);
+				res.tx_irq[ch_cnt - 1 - i] = pci_irq_vector(pdev, 2 + i * 2);
+			}
+
+			plat->control_value = GMAC_CONTROL_ACS;
+			plat->irq_flags = get_irq_type(np);
+		}
+	}
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
+	if (ret)
+		goto err_free_irq_vectors;
+
 	return ret;
 
+err_free_irq_vectors:
+	if (plat->multi_msi_en)
+		pci_free_irq_vectors(pdev);
 err_disable_msi:
 	pci_disable_msi(pdev);
 err_disable_device:
@@ -201,6 +279,7 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 		break;
 	}
 
+	pci_free_irq_vectors(pdev);
 	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.39.3


