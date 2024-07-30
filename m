Return-Path: <netdev+bounces-114111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD5940FB9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D65B285990
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2819E81D;
	Tue, 30 Jul 2024 10:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C319E812;
	Tue, 30 Jul 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335819; cv=none; b=qAL9nSt5JfhYjUFur92JHouzXevKMtSNudDbT5lrz/XEVLAVEpFAFHaZfc6U3SykaTuGjhnjrt9NFelxAFPzcqlLrO5l88Vt04wwx1jESnq9lCKNhEMf0EO6CAZLHTB0miqeLja81tg+b4nkc/ZS/jCMUZsvR39nd1DCnMLeLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335819; c=relaxed/simple;
	bh=ETc4q9fG3Gz3Wa40kMG9naoXXXZm2HLJBKTB9l1Lh7E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TxIHqb0AovR7wATR0csE1CAQ/gMkP25/nPcPD669DY4YTDg4AhYm53S14ZVApBVCLuwGc+ngK0FkhffYWt4+p2MCC8fOPTHe2K4tGUIigCtiP5odlvdj9qZvGLQzqhfgCjbY8FvghkQFU3SM8VGw3nBQIybvywB87QsnIkwyJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYkDp-000000000le-27fR;
	Tue, 30 Jul 2024 10:36:49 +0000
Date: Tue, 30 Jul 2024 11:36:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3] net: ethernet: mtk_eth_soc: drop clocks unused
 by Ethernet driver
Message-ID: <b5faaf69b5c6e3e155c64af03706c3c423c6a1c9.1722335682.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Clocks for SerDes and PHY are going to be handled by standalone drivers
for each of those hardware components. Drop them from the Ethernet driver.

The clocks which are being removed for this patch are responsible for
the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
anyway not yet supported. Hence backwards compatibility is not an issue.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
The dt-bindings part has been taken care of already in commit
cc349b0771dc dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

Changes since v2:
Target net-next tree and drop Fixes: tag.

Changes since v1:
Improve commit message and explain why backward compatibility is not an issue,
as requested by Andrew Lunn. Patch content remains unchanged.

 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index eb1708b43aa3e..0d5225f1d3eef 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -724,12 +724,8 @@ enum mtk_clks_map {
 	MTK_CLK_ETHWARP_WOCPU2,
 	MTK_CLK_ETHWARP_WOCPU1,
 	MTK_CLK_ETHWARP_WOCPU0,
-	MTK_CLK_TOP_USXGMII_SBUS_0_SEL,
-	MTK_CLK_TOP_USXGMII_SBUS_1_SEL,
 	MTK_CLK_TOP_SGM_0_SEL,
 	MTK_CLK_TOP_SGM_1_SEL,
-	MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL,
-	MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL,
 	MTK_CLK_TOP_ETH_GMII_SEL,
 	MTK_CLK_TOP_ETH_REFCK_50M_SEL,
 	MTK_CLK_TOP_ETH_SYS_200M_SEL,
@@ -800,19 +796,9 @@ enum mtk_clks_map {
 				 BIT_ULL(MTK_CLK_GP3) | BIT_ULL(MTK_CLK_XGP1) | \
 				 BIT_ULL(MTK_CLK_XGP2) | BIT_ULL(MTK_CLK_XGP3) | \
 				 BIT_ULL(MTK_CLK_CRYPTO) | \
-				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU2) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU1) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU0) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_GMII_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_REFCK_50M_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_SYS_200M_SEL) | \
-- 
2.45.2


