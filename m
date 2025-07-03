Return-Path: <netdev+bounces-203909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF673AF8043
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20621584522
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512132F5499;
	Thu,  3 Jul 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKXi/4on"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D412F2C59;
	Thu,  3 Jul 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567701; cv=none; b=Nm5OoPODprCT5+N1WBZ9lK1o5AeDFyEJPHHJYnWD0+x0/6KLJdIlAQO76fL9dNONXaIRn8YUM8kjzDysiXym024XJLug4Ez6Xq75r0opq/jVlTEXsu2KzploMflN1Qf+6WIg6mlIx+EN93FGh6yoKPibvPBkpr65ApwxjBgBOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567701; c=relaxed/simple;
	bh=YJKKfyjeTLipLIbW9YUX7ZZw5bOsRg+ciBYcLvfmROM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0JWHtWJ/dgH3DhAQRz6qBk6XxDDHASa423HZVJPL421HhoczYo8WdBO92HoK6SnL09gNKHlTZ1A2tFJcOkIS36sUEywfTTr1u74/+Qp55gx2Sti40VS/fIfAeyWMsWJHZQGDL55wrKFh6M9MtR3xcY2M2R1Y5ypBxfVeauqroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKXi/4on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2872C4CEE3;
	Thu,  3 Jul 2025 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567701;
	bh=YJKKfyjeTLipLIbW9YUX7ZZw5bOsRg+ciBYcLvfmROM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKXi/4onZSUjyQ1OleUJcYE4YmFwEh7X0nbKrfMVKwEdb+WXMe+PLMK0RKlWDNMKC
	 YE2zVZ0LYm6EHbDuszGdMQlTDTfwKO5t/6iLAEKWdVw9ueQF59Zv40YOrbBgc+uz1Q
	 l8OxmobvEIGzFLRgysUpM+9RJe/Q/h4amADhuSfztU3fUOxteU3y/rXq2Q82APsT/J
	 7Oxe5n4nPWhns8rAza+Vzf7GuTI3RmSLC4kBdKpKx+cEF4BLaV0PHb6RpkHYLk2PK2
	 gJ4o/B3a440ZAytJe204t2wQF+DF9ivpfiyDXnKyxaLOpIdwtPTSkxS2zW9NVCLjge
	 JQLSDIdM5QfBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alex Elder <elder@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"
Date: Thu,  3 Jul 2025 13:34:57 -0500
Message-ID: <20250703183459.2074381-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added of_reserved_mem_region_to_resource{_byname}()
functions to handle "memory-region" properties.

The error handling is a bit different for mtk_wed_mcu_load_firmware().
A failed match of the "memory-region-names" would skip the entry, but
then other errors in the lookup and retrieval of the address would not
skip the entry. However, that distinction is not really important.
Either the region is available and usable or it is not. So now, errors
from of_reserved_mem_region_to_resource() are ignored so the region is
simply skipped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c    | 25 ++++++----------
 drivers/net/ethernet/mediatek/mtk_wed.c     | 24 ++++------------
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 32 +++++++--------------
 drivers/net/ipa/ipa_main.c                  | 12 ++------
 4 files changed, 27 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 0e5b8c21b9aa..4e8deb87f751 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -161,7 +161,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 }
 
 static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
-				   struct reserved_mem *rmem)
+				   struct resource *res)
 {
 	const struct firmware *fw;
 	void __iomem *addr;
@@ -178,7 +178,7 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 		goto out;
 	}
 
-	addr = devm_ioremap(dev, rmem->base, rmem->size);
+	addr = devm_ioremap_resource(dev, res);
 	if (!addr) {
 		ret = -ENOMEM;
 		goto out;
@@ -474,9 +474,8 @@ static const struct regmap_config regmap_config = {
 static int airoha_npu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct reserved_mem *rmem;
 	struct airoha_npu *npu;
-	struct device_node *np;
+	struct resource res;
 	void __iomem *base;
 	int i, irq, err;
 
@@ -498,15 +497,9 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (IS_ERR(npu->regmap))
 		return PTR_ERR(npu->regmap);
 
-	np = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (!np)
-		return -ENODEV;
-
-	rmem = of_reserved_mem_lookup(np);
-	of_node_put(np);
-
-	if (!rmem)
-		return -ENODEV;
+	err = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	if (err)
+		return err;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -539,12 +532,12 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = airoha_npu_run_firmware(dev, base, rmem);
+	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
 		return dev_err_probe(dev, err, "failed to run npu firmware\n");
 
 	regmap_write(npu->regmap, REG_CR_NPU_MIB(10),
-		     rmem->base + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
+		     res.start + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
 	regmap_write(npu->regmap, REG_CR_NPU_MIB(11), 0x40000); /* SRAM 256K */
 	regmap_write(npu->regmap, REG_CR_NPU_MIB(12), 0);
 	regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 1);
@@ -552,7 +545,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 
 	/* setting booting address */
 	for (i = 0; i < NPU_NUM_CORES; i++)
-		regmap_write(npu->regmap, REG_CR_BOOT_BASE(i), rmem->base);
+		regmap_write(npu->regmap, REG_CR_BOOT_BASE(i), res.start);
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 351dd152f4f3..73c26fcfd85e 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1318,26 +1318,14 @@ mtk_wed_rro_ring_alloc(struct mtk_wed_device *dev, struct mtk_wed_ring *ring,
 static int
 mtk_wed_rro_alloc(struct mtk_wed_device *dev)
 {
-	struct reserved_mem *rmem;
-	struct device_node *np;
-	int index;
+	struct resource res;
+	int ret;
 
-	index = of_property_match_string(dev->hw->node, "memory-region-names",
-					 "wo-dlm");
-	if (index < 0)
-		return index;
-
-	np = of_parse_phandle(dev->hw->node, "memory-region", index);
-	if (!np)
-		return -ENODEV;
-
-	rmem = of_reserved_mem_lookup(np);
-	of_node_put(np);
-
-	if (!rmem)
-		return -ENODEV;
+	ret = of_reserved_mem_region_to_resource_byname(dev->hw->node, "wo-dlm", &res);
+	if (ret)
+		return ret;
 
-	dev->rro.miod_phys = rmem->base;
+	dev->rro.miod_phys = res.start;
 	dev->rro.fdbk_phys = MTK_WED_MIOD_COUNT + dev->rro.miod_phys;
 
 	return mtk_wed_rro_ring_alloc(dev, &dev->rro.ring,
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index c06e5ad18b01..8498b35ec7a6 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -234,25 +234,19 @@ int mtk_wed_mcu_msg_update(struct mtk_wed_device *dev, int id, void *data,
 }
 
 static int
-mtk_wed_get_memory_region(struct mtk_wed_hw *hw, int index,
+mtk_wed_get_memory_region(struct mtk_wed_hw *hw, const char *name,
 			  struct mtk_wed_wo_memory_region *region)
 {
-	struct reserved_mem *rmem;
-	struct device_node *np;
-
-	np = of_parse_phandle(hw->node, "memory-region", index);
-	if (!np)
-		return -ENODEV;
-
-	rmem = of_reserved_mem_lookup(np);
-	of_node_put(np);
+	struct resource res;
+	int ret;
 
-	if (!rmem)
-		return -ENODEV;
+	ret = of_reserved_mem_region_to_resource_byname(hw->node, name, &res);
+	if (ret)
+		return 0;
 
-	region->phy_addr = rmem->base;
-	region->size = rmem->size;
-	region->addr = devm_ioremap(hw->dev, region->phy_addr, region->size);
+	region->phy_addr = res.start;
+	region->size = resource_size(&res);
+	region->addr = devm_ioremap_resource(hw->dev, &res);
 
 	return !region->addr ? -EINVAL : 0;
 }
@@ -319,13 +313,7 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 
 	/* load firmware region metadata */
 	for (i = 0; i < ARRAY_SIZE(mem_region); i++) {
-		int index = of_property_match_string(wo->hw->node,
-						     "memory-region-names",
-						     mem_region[i].name);
-		if (index < 0)
-			continue;
-
-		ret = mtk_wed_get_memory_region(wo->hw, index, &mem_region[i]);
+		ret = mtk_wed_get_memory_region(wo->hw, mem_region[i].name, &mem_region[i]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index f25f6e2cf58c..25500c5a6928 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
@@ -586,7 +586,6 @@ static void ipa_deconfig(struct ipa *ipa)
 static int ipa_firmware_load(struct device *dev)
 {
 	const struct firmware *fw;
-	struct device_node *node;
 	struct resource res;
 	phys_addr_t phys;
 	const char *path;
@@ -594,14 +593,7 @@ static int ipa_firmware_load(struct device *dev)
 	void *virt;
 	int ret;
 
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (!node) {
-		dev_err(dev, "DT error getting \"memory-region\" property\n");
-		return -EINVAL;
-	}
-
-	ret = of_address_to_resource(node, 0, &res);
-	of_node_put(node);
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
 	if (ret) {
 		dev_err(dev, "error %d getting \"memory-region\" resource\n",
 			ret);
-- 
2.47.2


