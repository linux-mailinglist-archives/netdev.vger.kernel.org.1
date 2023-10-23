Return-Path: <netdev+bounces-43656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278827D4283
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BFB1C20B6E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D68241E1;
	Mon, 23 Oct 2023 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udiHJnzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE623758
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 22:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F38C433CB;
	Mon, 23 Oct 2023 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698098495;
	bh=/yESy6tlRjnEfJqcc1ThpVP5hP3dBtZ4GgQzJxd7znI=;
	h=From:To:Cc:Subject:Date:From;
	b=udiHJnzcPSBotrNijVrjnm1FeIj7cZesuIcvpqAqfs0OkolQSpwp8pD5845UzKHMq
	 Q+KUAixV/gyFWILQhz5kQL8luBeOqs0i9yNjhusV5Dz+HDv2UFerdTEchj1YxyvrDQ
	 BL4q4pqUVYkAVVrsHy/xdM8kH72hjpkVMqC+CAvFKzNF9dpkMl8jc6vztTiOXe4sOG
	 Iks2yC8zFJiUUnLIDYotLefKjxY+apHXUyGtCTe+ngY/cJvX+hbECr+KDowPgpJ93B
	 zJAV7m3JI2ahVA0PazUbbSDpHPbuvipbIx07xgVJ8H6zZFjcVhvE6zLl6EphoeuFsZ
	 /n7JW7ldaMIqA==
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
Subject: [PATCH net-next] net: ethernet: mtk_wed: remove wo pointer in wo_r32/wo_w32 signature
Date: Tue, 24 Oct 2023 00:01:30 +0200
Message-ID: <530537db0872f7523deff21f0a5dfdd9b75fdc9d.1698098459.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wo pointer is no longer used in wo_r32 and wo_w32 routines so get rid of
it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index fee9c9d3a92f..ea0884186d76 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -32,12 +32,12 @@ static struct mtk_wed_wo_memory_region mem_region[] = {
 	},
 };
 
-static u32 wo_r32(struct mtk_wed_wo *wo, u32 reg)
+static u32 wo_r32(u32 reg)
 {
 	return readl(mem_region[MTK_WED_WO_REGION_BOOT].addr + reg);
 }
 
-static void wo_w32(struct mtk_wed_wo *wo, u32 reg, u32 val)
+static void wo_w32(u32 reg, u32 val)
 {
 	writel(val, mem_region[MTK_WED_WO_REGION_BOOT].addr + reg);
 }
@@ -373,13 +373,13 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 		boot_cr = MTK_WO_MCU_CFG_LS_WA_BOOT_ADDR_ADDR;
 	else
 		boot_cr = MTK_WO_MCU_CFG_LS_WM_BOOT_ADDR_ADDR;
-	wo_w32(wo, boot_cr, mem_region[MTK_WED_WO_REGION_EMI].phy_addr >> 16);
+	wo_w32(boot_cr, mem_region[MTK_WED_WO_REGION_EMI].phy_addr >> 16);
 	/* wo firmware reset */
-	wo_w32(wo, MTK_WO_MCU_CFG_LS_WF_MCCR_CLR_ADDR, 0xc00);
+	wo_w32(MTK_WO_MCU_CFG_LS_WF_MCCR_CLR_ADDR, 0xc00);
 
-	val = wo_r32(wo, MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR) |
+	val = wo_r32(MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR) |
 	      MTK_WO_MCU_CFG_LS_WF_WM_WA_WM_CPU_RSTB_MASK;
-	wo_w32(wo, MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR, val);
+	wo_w32(MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR, val);
 out:
 	release_firmware(fw);
 
-- 
2.41.0


