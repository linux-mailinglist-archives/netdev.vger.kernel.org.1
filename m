Return-Path: <netdev+bounces-34515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9B7A472C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BEB1C20C98
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A31D555;
	Mon, 18 Sep 2023 10:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C423778;
	Mon, 18 Sep 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E3C433C7;
	Mon, 18 Sep 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033024;
	bh=y6yDaYvJ/bA5abRx1KNylEBwaNNnEQUvQMq0/2yBjhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM9Hwgqt4ldAT5PDQkEnKdoi3HAZP9uFDQXCRm3QuKBguFhqwULJ8e2XEDMmHWMnE
	 tUMubFaQ5NtWYxcwk3uHcNTyXLyuZqjlqwJta04W9gsMbo5Wi8bHoXMbVD2P8Zv62y
	 jSckyRX54AKlFKABz9jrP29PC5hnDWkOlHG4I0P+wCOpCQ+wuaLYT7t2B4LB5Oh0G2
	 jjQplZ2rcD0PJN3zz+6IhTfSrIrDjgyxZHPxd8izic0UMjbE1JlngXydP2XQfXDEbE
	 rHLfQS7dxs820QGYKFgdgwV4sJ/DIeU9eKb/lUFKa6qhyeRNDnqYyAG6LXxAQKiXp5
	 olLMBUtH+WJhA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 08/17] net: ethernet: mtk_wed: make memory region optional
Date: Mon, 18 Sep 2023 12:29:10 +0200
Message-ID: <bb6ee94f05a6e1afa952b213e419599a6cba8529.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mtk_wed_wo_memory_region optionals.
This is a preliminary patch to introduce Wireless Ethernet Dispatcher
support for MT7988 SoC since MT7988 WED fw image will have a different
layout.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 23 ++++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index cc54fbd7380a..e53531252bd9 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -234,19 +234,13 @@ int mtk_wed_mcu_msg_update(struct mtk_wed_device *dev, int id, void *data,
 }
 
 static int
-mtk_wed_get_memory_region(struct mtk_wed_wo *wo,
+mtk_wed_get_memory_region(struct mtk_wed_hw *hw, int index,
 			  struct mtk_wed_wo_memory_region *region)
 {
 	struct reserved_mem *rmem;
 	struct device_node *np;
-	int index;
 
-	index = of_property_match_string(wo->hw->node, "memory-region-names",
-					 region->name);
-	if (index < 0)
-		return index;
-
-	np = of_parse_phandle(wo->hw->node, "memory-region", index);
+	np = of_parse_phandle(hw->node, "memory-region", index);
 	if (!np)
 		return -ENODEV;
 
@@ -258,7 +252,7 @@ mtk_wed_get_memory_region(struct mtk_wed_wo *wo,
 
 	region->phy_addr = rmem->base;
 	region->size = rmem->size;
-	region->addr = devm_ioremap(wo->hw->dev, region->phy_addr, region->size);
+	region->addr = devm_ioremap(hw->dev, region->phy_addr, region->size);
 
 	return !region->addr ? -EINVAL : 0;
 }
@@ -271,6 +265,9 @@ mtk_wed_mcu_run_firmware(struct mtk_wed_wo *wo, const struct firmware *fw,
 	const struct mtk_wed_fw_trailer *trailer;
 	const struct mtk_wed_fw_region *fw_region;
 
+	if (!region->phy_addr || !region->size)
+		return 0;
+
 	trailer_ptr = fw->data + fw->size - sizeof(*trailer);
 	trailer = (const struct mtk_wed_fw_trailer *)trailer_ptr;
 	region_ptr = trailer_ptr - trailer->num_region * sizeof(*fw_region);
@@ -318,7 +315,13 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 
 	/* load firmware region metadata */
 	for (i = 0; i < ARRAY_SIZE(mem_region); i++) {
-		ret = mtk_wed_get_memory_region(wo, &mem_region[i]);
+		int index = of_property_match_string(wo->hw->node,
+						     "memory-region-names",
+						     mem_region[i].name);
+		if (index < 0)
+			continue;
+
+		ret = mtk_wed_get_memory_region(wo->hw, index, &mem_region[i]);
 		if (ret)
 			return ret;
 	}
-- 
2.41.0


