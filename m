Return-Path: <netdev+bounces-43654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F77D4279
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0483281382
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691F23755;
	Mon, 23 Oct 2023 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5l4EQVe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7701859
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 22:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EED0C433C8;
	Mon, 23 Oct 2023 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698098425;
	bh=qSCtDp4iUw/OU24fpGyAO6rded2YxSCqsEhzpDTpkLk=;
	h=From:To:Cc:Subject:Date:From;
	b=l5l4EQVe0L7QrJNdI1lK+H0pEaThlHsMUV6cksLN5WGTTHuMzVvRBcNmf2ybFldvT
	 saNwzYMOftsHJqNlXjuhHzn3skZb3T3DeFIcJhSOeSZUWNIMSSDNAYMvOTE7YvodkC
	 nGUEBZaxz2eMScWULgjc5BjQgBSRNtYZlf6EE5D7nH4CKaFZocRpbxumLBlgStbVk2
	 j7MKMTCo2dfkRvqpyETuR4JPQLPGjHuLxbmdV5IkKcxnPTaz56gjO62aO9bCv2N7KI
	 9BrQn0S5hQCu4urL15LRSImz4JOCCuV4v1hXfft/niFGnJaaLRUhlM74VkgrVn+oEv
	 HFuaciW4pDgBQ==
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
	frank-w@public-files.de,
	daniel@makrotopia.org
Subject: [PATCH net-next] net: ethernet: mtk_wed: fix firmware loading for MT7986 SoC
Date: Tue, 24 Oct 2023 00:00:19 +0200
Message-ID: <d983cbfe8ea562fef9264de8f0c501f7d5705bd5.1698098381.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WED mcu firmware does not contain all the memory regions defined in
the dts reserved_memory node (e.g. MT7986 WED firmware does not contain
cpu-boot region).
Reverse the mtk_wed_mcu_run_firmware() logic to check all the fw
sections are defined in the dts reserved_memory node.

Fixes: c6d961aeaa77 ("net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware")
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 48 +++++++++++----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 65a78e274009..fee9c9d3a92f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -258,16 +258,12 @@ mtk_wed_get_memory_region(struct mtk_wed_hw *hw, int index,
 }
 
 static int
-mtk_wed_mcu_run_firmware(struct mtk_wed_wo *wo, const struct firmware *fw,
-			 struct mtk_wed_wo_memory_region *region)
+mtk_wed_mcu_run_firmware(struct mtk_wed_wo *wo, const struct firmware *fw)
 {
 	const u8 *first_region_ptr, *region_ptr, *trailer_ptr, *ptr = fw->data;
 	const struct mtk_wed_fw_trailer *trailer;
 	const struct mtk_wed_fw_region *fw_region;
 
-	if (!region->phy_addr || !region->size)
-		return 0;
-
 	trailer_ptr = fw->data + fw->size - sizeof(*trailer);
 	trailer = (const struct mtk_wed_fw_trailer *)trailer_ptr;
 	region_ptr = trailer_ptr - trailer->num_region * sizeof(*fw_region);
@@ -275,33 +271,41 @@ mtk_wed_mcu_run_firmware(struct mtk_wed_wo *wo, const struct firmware *fw,
 
 	while (region_ptr < trailer_ptr) {
 		u32 length;
+		int i;
 
 		fw_region = (const struct mtk_wed_fw_region *)region_ptr;
 		length = le32_to_cpu(fw_region->len);
-
-		if (region->phy_addr != le32_to_cpu(fw_region->addr))
+		if (first_region_ptr < ptr + length)
 			goto next;
 
-		if (region->size < length)
-			goto next;
+		for (i = 0; i < ARRAY_SIZE(mem_region); i++) {
+			struct mtk_wed_wo_memory_region *region;
 
-		if (first_region_ptr < ptr + length)
-			goto next;
+			region = &mem_region[i];
+			if (region->phy_addr != le32_to_cpu(fw_region->addr))
+				continue;
 
-		if (region->shared && region->consumed)
-			return 0;
+			if (region->size < length)
+				continue;
 
-		if (!region->shared || !region->consumed) {
-			memcpy_toio(region->addr, ptr, length);
-			region->consumed = true;
-			return 0;
+			if (region->shared && region->consumed)
+				break;
+
+			if (!region->shared || !region->consumed) {
+				memcpy_toio(region->addr, ptr, length);
+				region->consumed = true;
+				break;
+			}
 		}
+
+		if (i == ARRAY_SIZE(mem_region))
+			return -EINVAL;
 next:
 		region_ptr += sizeof(*fw_region);
 		ptr += length;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static int
@@ -360,11 +364,9 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 	dev_info(wo->hw->dev, "MTK WED WO Chip ID %02x Region %d\n",
 		 trailer->chip_id, trailer->num_region);
 
-	for (i = 0; i < ARRAY_SIZE(mem_region); i++) {
-		ret = mtk_wed_mcu_run_firmware(wo, fw, &mem_region[i]);
-		if (ret)
-			goto out;
-	}
+	ret = mtk_wed_mcu_run_firmware(wo, fw);
+	if (ret)
+		goto out;
 
 	/* set the start address */
 	if (!mtk_wed_is_v3_or_greater(wo->hw) && wo->hw->index)
-- 
2.41.0


