Return-Path: <netdev+bounces-33861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9667A07DE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E9E281A4D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFB21354;
	Thu, 14 Sep 2023 14:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E921352;
	Thu, 14 Sep 2023 14:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44DC433C8;
	Thu, 14 Sep 2023 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702378;
	bh=NuGvozSv9WccAC4JHs7SvmzDslrfdkBPTRpl9vmfPbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XP/5j5UGQQIJMpHxUgBLukt0K67oVVXI9Tk1OgNH7LivXba9HAtQARD4VhfbvpzHP
	 P7+oJ0VKWOhl4zljq4U3styg8PcE8T5fiK99iQpgZ7QitUK9B3D2rw8Iq8FCHIaoBK
	 gewwfmLXfcWTDnJsoPt7M+Witqti9GaQV8R2u5qftw4nPpo7AHvM8X3qtUy4PNbt9u
	 wHrqsMmcxCQ4IYCXoBQiKbRDvljiqH7cwMSeWtolzOCapZvDpOXwAcRmHY7cBrSS8g
	 hkL/FLHa4k0p0F8OkFnXADaydGoVgwTy/ltnAbtokr4bj8SUiDGVs2TpjY3SNw35uC
	 ZfAq8tLVQwqLw==
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
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 08/15] net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware
Date: Thu, 14 Sep 2023 16:38:13 +0200
Message-ID: <0b85368e324422b99cd29d4c1dad2e93bb7ad660.1694701767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694701767.git.lorenzo@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove mtk_wed_wo_memory_region boot structure in mtk_wed_wo.
This is a preliminary patch to introduce WED support for MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 37 ++++++++++-----------
 drivers/net/ethernet/mediatek/mtk_wed_wo.h  |  1 -
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 4e48905ac70d..cc54fbd7380a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -16,14 +16,30 @@
 #include "mtk_wed_wo.h"
 #include "mtk_wed.h"
 
+static struct mtk_wed_wo_memory_region mem_region[] = {
+	[MTK_WED_WO_REGION_EMI] = {
+		.name = "wo-emi",
+	},
+	[MTK_WED_WO_REGION_ILM] = {
+		.name = "wo-ilm",
+	},
+	[MTK_WED_WO_REGION_DATA] = {
+		.name = "wo-data",
+		.shared = true,
+	},
+	[MTK_WED_WO_REGION_BOOT] = {
+		.name = "wo-boot",
+	},
+};
+
 static u32 wo_r32(struct mtk_wed_wo *wo, u32 reg)
 {
-	return readl(wo->boot.addr + reg);
+	return readl(mem_region[MTK_WED_WO_REGION_BOOT].addr + reg);
 }
 
 static void wo_w32(struct mtk_wed_wo *wo, u32 reg, u32 val)
 {
-	writel(val, wo->boot.addr + reg);
+	writel(val, mem_region[MTK_WED_WO_REGION_BOOT].addr + reg);
 }
 
 static struct sk_buff *
@@ -294,18 +310,6 @@ mtk_wed_mcu_run_firmware(struct mtk_wed_wo *wo, const struct firmware *fw,
 static int
 mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 {
-	static struct mtk_wed_wo_memory_region mem_region[] = {
-		[MTK_WED_WO_REGION_EMI] = {
-			.name = "wo-emi",
-		},
-		[MTK_WED_WO_REGION_ILM] = {
-			.name = "wo-ilm",
-		},
-		[MTK_WED_WO_REGION_DATA] = {
-			.name = "wo-data",
-			.shared = true,
-		},
-	};
 	const struct mtk_wed_fw_trailer *trailer;
 	const struct firmware *fw;
 	const char *fw_name;
@@ -319,11 +323,6 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 			return ret;
 	}
 
-	wo->boot.name = "wo-boot";
-	ret = mtk_wed_get_memory_region(wo, &wo->boot);
-	if (ret)
-		return ret;
-
 	/* set dummy cr */
 	wed_w32(wo->hw->wed_dev, MTK_WED_SCR0 + 4 * MTK_WED_DUMMY_CR_FWDL,
 		wo->hw->index + 1);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 7a1a2a28f1ac..8ed81761bf10 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -228,7 +228,6 @@ struct mtk_wed_wo_queue {
 
 struct mtk_wed_wo {
 	struct mtk_wed_hw *hw;
-	struct mtk_wed_wo_memory_region boot;
 
 	struct mtk_wed_wo_queue q_tx;
 	struct mtk_wed_wo_queue q_rx;
-- 
2.41.0


