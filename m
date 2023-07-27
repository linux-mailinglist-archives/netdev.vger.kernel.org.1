Return-Path: <netdev+bounces-21729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB17647D6
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2482A1C214EF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3EABE72;
	Thu, 27 Jul 2023 07:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21AA93C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC64C433C9;
	Thu, 27 Jul 2023 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690441667;
	bh=nkqYB2knoCzlEvF6jW0h/juV9QZgwxlp4sjHBUVKHc4=;
	h=From:To:Cc:Subject:Date:From;
	b=iRk50RgDafROpdSxyg7XYs9RiGqPZK9Pvf5mO/ki6SMlCr6tVotd2u8z1xSHW3fn6
	 lBrvZICb+P2rYU9IW7iqXZM78WLDpn1t/xTv4TSP/oy9yOlF0vtMoc6apCHYUiMak4
	 z3r25med/dXzmb2bAeDp9rn9DGXZBhz1r196nJGCnJ9lzm46fu0lBtwlmJVHmeKjku
	 g7z8YLAn5FmrIH+v+9ppmkwLo8iiDTE/IREyFVrkRqQdBG3u1wfVSfhtAcoFy/XCef
	 d/0CB+e0z8/1lwqDnUvML0rHucEN65Lo9wLm9DM8KiYoOOqPpBQwibY2Vgan3R/RT7
	 hwoDn8Hw8Syjw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	daniel@makrotopia.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: enable nft hw flowtable_offload for MT7988 SoC
Date: Thu, 27 Jul 2023 09:07:28 +0200
Message-ID: <5e86341b0220a49620dadc02d77970de5ded9efc.1690441576.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable hw Packet Process Engine (PPE) for MT7988 SoC.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  3 +++
 drivers/net/ethernet/mediatek/mtk_ppe.c     | 19 +++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_ppe.h     | 19 ++++++++++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d6750a58a71f..95978cf4d6a2 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5061,6 +5061,9 @@ static const struct mtk_soc_data mt7988_data = {
 	.required_clks = MT7988_CLKS_BITMAP,
 	.required_pctl = false,
 	.version = 3,
+	.offload_version = 2,
+	.hash_offset = 4,
+	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma_v2),
 		.rxd_size = sizeof(struct mtk_rx_dma_v2),
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 2f0e682449ef..bf1ecb0c1c10 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -423,13 +423,22 @@ int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 	struct mtk_foe_mac_info *l2 = mtk_foe_entry_l2(eth, entry);
 	u32 *ib2 = mtk_foe_entry_ib2(eth, entry);
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	switch (eth->soc->version) {
+	case 3:
+		*ib2 &= ~MTK_FOE_IB2_PORT_MG_V2;
+		*ib2 |=  FIELD_PREP(MTK_FOE_IB2_RX_IDX, txq) |
+			 MTK_FOE_IB2_WDMA_WINFO_V2;
+		l2->w3info = FIELD_PREP(MTK_FOE_WINFO_WCID_V3, wcid) |
+			     FIELD_PREP(MTK_FOE_WINFO_BSS_V3, bss);
+		break;
+	case 2:
 		*ib2 &= ~MTK_FOE_IB2_PORT_MG_V2;
 		*ib2 |=  FIELD_PREP(MTK_FOE_IB2_RX_IDX, txq) |
 			 MTK_FOE_IB2_WDMA_WINFO_V2;
 		l2->winfo = FIELD_PREP(MTK_FOE_WINFO_WCID, wcid) |
 			    FIELD_PREP(MTK_FOE_WINFO_BSS, bss);
-	} else {
+		break;
+	default:
 		*ib2 &= ~MTK_FOE_IB2_PORT_MG;
 		*ib2 |= MTK_FOE_IB2_WDMA_WINFO;
 		if (wdma_idx)
@@ -437,6 +446,7 @@ int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 		l2->vlan2 = FIELD_PREP(MTK_FOE_VLAN2_WINFO_BSS, bss) |
 			    FIELD_PREP(MTK_FOE_VLAN2_WINFO_WCID, wcid) |
 			    FIELD_PREP(MTK_FOE_VLAN2_WINFO_RING, txq);
+		break;
 	}
 
 	return 0;
@@ -964,8 +974,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 	mtk_ppe_init_foe_table(ppe);
 	ppe_w32(ppe, MTK_PPE_TB_BASE, ppe->foe_phys);
 
-	val = MTK_PPE_TB_CFG_ENTRY_80B |
-	      MTK_PPE_TB_CFG_AGE_NON_L4 |
+	val = MTK_PPE_TB_CFG_AGE_NON_L4 |
 	      MTK_PPE_TB_CFG_AGE_UNBIND |
 	      MTK_PPE_TB_CFG_AGE_TCP |
 	      MTK_PPE_TB_CFG_AGE_UDP |
@@ -981,6 +990,8 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_ENTRIES_SHIFT);
 	if (mtk_is_netsys_v2_or_greater(ppe->eth))
 		val |= MTK_PPE_TB_CFG_INFO_SEL;
+	if (!mtk_is_netsys_v3_or_greater(ppe->eth))
+		val |= MTK_PPE_TB_CFG_ENTRY_80B;
 	ppe_w32(ppe, MTK_PPE_TB_CFG, val);
 
 	ppe_w32(ppe, MTK_PPE_IP_PROTO_CHK,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index fb6bf58172d9..e3d0ec72bc69 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -85,6 +85,17 @@ enum {
 #define MTK_FOE_WINFO_BSS		GENMASK(5, 0)
 #define MTK_FOE_WINFO_WCID		GENMASK(15, 6)
 
+#define MTK_FOE_WINFO_BSS_V3		GENMASK(23, 16)
+#define MTK_FOE_WINFO_WCID_V3		GENMASK(15, 0)
+
+#define MTK_FOE_WINFO_PAO_USR_INFO	GENMASK(15, 0)
+#define MTK_FOE_WINFO_PAO_TID		GENMASK(19, 16)
+#define MTK_FOE_WINFO_PAO_IS_FIXEDRATE	BIT(20)
+#define MTK_FOE_WINFO_PAO_IS_PRIOR	BIT(21)
+#define MTK_FOE_WINFO_PAO_IS_SP		BIT(22)
+#define MTK_FOE_WINFO_PAO_HF		BIT(23)
+#define MTK_FOE_WINFO_PAO_AMSDU_EN	BIT(24)
+
 enum {
 	MTK_FOE_STATE_INVALID,
 	MTK_FOE_STATE_UNBIND,
@@ -106,8 +117,13 @@ struct mtk_foe_mac_info {
 	u16 pppoe_id;
 	u16 src_mac_lo;
 
+	/* netsys_v2 */
 	u16 minfo;
 	u16 winfo;
+
+	/* netsys_v3 */
+	u32 w3info;
+	u32 wpao;
 };
 
 /* software-only entry type */
@@ -218,6 +234,7 @@ struct mtk_foe_ipv6_6rd {
 
 #define MTK_FOE_ENTRY_V1_SIZE	80
 #define MTK_FOE_ENTRY_V2_SIZE	96
+#define MTK_FOE_ENTRY_V3_SIZE	128
 
 struct mtk_foe_entry {
 	u32 ib1;
@@ -228,7 +245,7 @@ struct mtk_foe_entry {
 		struct mtk_foe_ipv4_dslite dslite;
 		struct mtk_foe_ipv6 ipv6;
 		struct mtk_foe_ipv6_6rd ipv6_6rd;
-		u32 data[23];
+		u32 data[31];
 	};
 };
 
-- 
2.41.0


