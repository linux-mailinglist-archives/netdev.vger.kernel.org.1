Return-Path: <netdev+bounces-183074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E46A8AD05
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DFA7A3FF9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FF1E1DF2;
	Wed, 16 Apr 2025 00:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E31DF260;
	Wed, 16 Apr 2025 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764713; cv=none; b=rWBJHgMzVyrQOM6OLQcTWZmZmNviWX+SWpbzK9qmSRDklBRHOaYPpPr+aKmLb5MB1V5FTqptQWK1E63D3CNOWStTqcuMt8gmPy7hK9599GKusKhGWekOGx2ciMt2BKuLEtrchY22+OOnCDblanWHfEfOTCxTfftaTAtWcy8jjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764713; c=relaxed/simple;
	bh=nedFzlo1ThOzEzq8Q9wypPgh1qcwkjJJlfY7f2AXPog=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtOlG09JYwms0fvoxATT8AXZJ50+RYULTQ5n/q9deaPadb4dPc1EAY+ZkEuvHWxPA+loW2eWBfuK35buGUvIFLRCfbIFyPRjOsNdsQXWc7NaX30E4zIWyjZpYjkVjejlJ7Sor2LknyLbd6QMSu/Wb07PwNJ12dZSg5bPxbP2GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4qxf-000000001Tx-3dKZ;
	Wed, 16 Apr 2025 00:51:45 +0000
Date: Wed, 16 Apr 2025 01:51:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 4/5] net: ethernet: mtk_eth_soc: net: revise NETSYSv3
 hardware configuration
Message-ID: <28929b5bb2bfd45e040a07c0efefb29e57a77513.1744764277.git.daniel@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

Change hardware configuration for the NETSYSv3.
 - Enable PSE dummy page mechanism for the GDM1/2/3
 - Enable PSE drop mechanism when the WDMA Rx ring full
 - Enable PSE no-drop mechanism for packets from the WDMA Tx
 - Correct PSE free drop threshold
 - Correct PSE CDMA high threshold

Fixes: 1953f134a1a8b ("net: ethernet: mtk_eth_soc: add NETSYS_V3 version support")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no change

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 20 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index bdb98c9d8b1c1..338849b488cae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4043,11 +4043,23 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
 	if (mtk_is_netsys_v3_or_greater(eth)) {
-		/* PSE should not drop port1, port8 and port9 packets */
-		mtk_w32(eth, 0x00000302, PSE_DROP_CFG);
+		/* PSE dummy page mechanism */
+		mtk_w32(eth, PSE_DUMMY_WORK_GDM(1) | PSE_DUMMY_WORK_GDM(2) |
+			PSE_DUMMY_WORK_GDM(3) | DUMMY_PAGE_THR, PSE_DUMY_REQ);
+
+		/* PSE free buffer drop threshold */
+		mtk_w32(eth, 0x00600009, PSE_IQ_REV(8));
+
+		/* PSE should not drop port8, port9 and port13 packets from WDMA Tx */
+		mtk_w32(eth, 0x00002300, PSE_DROP_CFG);
+
+		/* PSE should drop packets to port8, port9 and port13 on WDMA Rx ring full */
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(0));
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(1));
+		mtk_w32(eth, 0x00002300, PSE_PPE_DROP(2));
 
 		/* GDM and CDM Threshold */
-		mtk_w32(eth, 0x00000707, MTK_CDMW0_THRES);
+		mtk_w32(eth, 0x08000707, MTK_CDMW0_THRES);
 		mtk_w32(eth, 0x00000077, MTK_CDMW1_THRES);
 
 		/* Disable GDM1 RX CRC stripping */
@@ -4064,7 +4076,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 		mtk_w32(eth, 0x00000300, PSE_DROP_CFG);
 
 		/* PSE should drop packets to port 8/9 on WDMA Rx ring full */
-		mtk_w32(eth, 0x00000300, PSE_PPE0_DROP);
+		mtk_w32(eth, 0x00000300, PSE_PPE_DROP(0));
 
 		/* PSE Free Queue Flow Control  */
 		mtk_w32(eth, 0x01fa01f4, PSE_FQFC_CFG2);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 39709649ea8d1..eaa96c8483b70 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -151,7 +151,12 @@
 #define PSE_FQFC_CFG1		0x100
 #define PSE_FQFC_CFG2		0x104
 #define PSE_DROP_CFG		0x108
-#define PSE_PPE0_DROP		0x110
+#define PSE_PPE_DROP(x)		(0x110 + ((x) * 0x4))
+
+/* PSE Last FreeQ Page Request Control */
+#define PSE_DUMY_REQ		0x10C
+#define PSE_DUMMY_WORK_GDM(x)	BIT(16 + (x))
+#define DUMMY_PAGE_THR		0x1
 
 /* PSE Input Queue Reservation Register*/
 #define PSE_IQ_REV(x)		(0x140 + (((x) - 1) << 2))
-- 
2.49.0

