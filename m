Return-Path: <netdev+bounces-243641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D49CA4B0D
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C811B307B991
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F352F7462;
	Thu,  4 Dec 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AEkizTfi"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94426C384;
	Thu,  4 Dec 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867944; cv=none; b=p2BwVgvj9fzIDcXJZ4Bq+uzjT/Mjn3m0JhVyspy7t2u0kv+QrMddjCBTGa8ZUyX8I+82yJFnGJQO9owUBKK13+TqMBMMdyg4u5CDwaEHkvV1XF+qBGLqODVt2SztLdOfNVsvzzsTeY3CyDvA3BuHUFaNyS/09TPk8V7NpAas8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867944; c=relaxed/simple;
	bh=ygHtWh8Gf175iMMJEadWemEqEwdp+GnKr3z3qXMSWNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNU4g6N3XuauDfX9M1HkAvNdhoXmNs/oXT1DFy31e5go0pFhPuMg/y4PNug7kIIx5VXBdx1xgjG9b36Z1nXw9tueSDgTUMCKvzpginTyuXMM4tgXGkkWtvCyFjRWLH8CXOf30dIuXZShy3ji8X3MywfJRqDECsWXHZW1uvZu26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AEkizTfi; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id CC2E6100610;
	Thu,  4 Dec 2025 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1764867543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9Ch57tOKhVufF9cmzjO6tWSgN0ZIChZXqQm0qwLh4=;
	b=AEkizTfiq+Ek0zhA8odeSzVQ01CK8NowWwnLNofbxgIf8NQOiqBN3e6iZHihAcezr70xAY
	qjjuN+KebBZ0GrCLyWJr/CqszVvyuIVMBrbysheqLU7G85Uc3B6RY+f8YV2I7HsvPa0zzJ
	2ks6ySFc/4vnaiWRn1q1MjIYRbiWilw=
Received: from frank-u24.. (fttx-pool-157.180.225.155.bambit.de [157.180.225.155])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 894C21226EB;
	Thu,  4 Dec 2025 16:59:02 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mason Chang <mason-cw.chang@mediatek.com>
Subject: [RFC v2 1/3] net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
Date: Thu,  4 Dec 2025 17:58:43 +0100
Message-ID: <20251204165849.8214-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204165849.8214-1-linux@fw-web.de>
References: <20251204165849.8214-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mason Chang <mason-cw.chang@mediatek.com>

Add definitions for Receive Side Scaling and Large Receive Offload support.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 23 +++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 32 +++++++++++++++------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e68997a29191..243ff16fd15e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -50,13 +50,18 @@ static const struct mtk_reg_map mtk_reg_map = {
 		.rx_ptr		= 0x0900,
 		.rx_cnt_cfg	= 0x0904,
 		.pcrx_ptr	= 0x0908,
+		.lro_ctrl_dw0   = 0x0980,
 		.glo_cfg	= 0x0a04,
 		.rst_idx	= 0x0a08,
 		.delay_irq	= 0x0a0c,
 		.irq_status	= 0x0a20,
 		.irq_mask	= 0x0a28,
 		.adma_rx_dbg0	= 0x0a38,
+		.lro_alt_score_delta	= 0x0a4c,
 		.int_grp	= 0x0a50,
+		.lro_rx1_dly_int	= 0x0a70,
+		.lro_ring_dip_dw0	= 0x0b04,
+		.lro_ring_ctrl_dw1	= 0x0b28,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x1800,
@@ -113,6 +118,7 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.tx_irq_mask		= 0x461c,
 	.tx_irq_status		= 0x4618,
 	.pdma = {
+		.rss_glo_cfg    = 0x2800,
 		.rx_ptr		= 0x4100,
 		.rx_cnt_cfg	= 0x4104,
 		.pcrx_ptr	= 0x4108,
@@ -123,6 +129,12 @@ static const struct mtk_reg_map mt7986_reg_map = {
 		.irq_mask	= 0x4228,
 		.adma_rx_dbg0	= 0x4238,
 		.int_grp	= 0x4250,
+		.int_grp3	= 0x422c,
+		.lro_ctrl_dw0	= 0x4180,
+		.lro_alt_score_delta	= 0x424c,
+		.lro_rx1_dly_int	= 0x4270,
+		.lro_ring_dip_dw0	= 0x4304,
+		.lro_ring_ctrl_dw1	= 0x4328,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
@@ -170,10 +182,21 @@ static const struct mtk_reg_map mt7988_reg_map = {
 		.glo_cfg	= 0x6a04,
 		.rst_idx	= 0x6a08,
 		.delay_irq	= 0x6a0c,
+		.rx_cfg		= 0x6a10,
 		.irq_status	= 0x6a20,
 		.irq_mask	= 0x6a28,
 		.adma_rx_dbg0	= 0x6a38,
 		.int_grp	= 0x6a50,
+		.int_grp3	= 0x6a58,
+		.tx_delay_irq	= 0x6ab0,
+		.rx_delay_irq	= 0x6ac0,
+		.lro_ctrl_dw0	= 0x6c08,
+		.lro_alt_score_delta	= 0x6c1c,
+		.lro_ring_dip_dw0	= 0x6c14,
+		.lro_ring_ctrl_dw1	= 0x6c38,
+		.lro_alt_dbg	= 0x6c40,
+		.lro_alt_dbg_data	= 0x6c44,
+		.rss_glo_cfg	= 0x7000,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0168e2fbc619..334625814b97 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1143,16 +1143,30 @@ struct mtk_reg_map {
 	u32	tx_irq_mask;
 	u32	tx_irq_status;
 	struct {
-		u32	rx_ptr;		/* rx base pointer */
-		u32	rx_cnt_cfg;	/* rx max count configuration */
-		u32	pcrx_ptr;	/* rx cpu pointer */
-		u32	glo_cfg;	/* global configuration */
-		u32	rst_idx;	/* reset index */
-		u32	delay_irq;	/* delay interrupt */
-		u32	irq_status;	/* interrupt status */
-		u32	irq_mask;	/* interrupt mask */
+		u32	rx_ptr;			/* rx base pointer */
+		u32	rx_cnt_cfg;		/* rx max count configuration */
+		u32	pcrx_ptr;		/* rx cpu pointer */
+		u32	pdrx_ptr;		/* rx dma pointer */
+		u32	glo_cfg;		/* global configuration */
+		u32	rst_idx;		/* reset index */
+		u32	rx_cfg;			/* rx dma configuration */
+		u32	delay_irq;		/* delay interrupt */
+		u32	irq_status;		/* interrupt status */
+		u32	irq_mask;		/* interrupt mask */
 		u32	adma_rx_dbg0;
-		u32	int_grp;
+		u32	int_grp;		/* interrupt group1 */
+		u32	int_grp3;		/* interrupt group3 */
+		u32	tx_delay_irq;		/* tx delay interrupt */
+		u32	rx_delay_irq;		/* rx delay interrupt */
+		u32	lro_ctrl_dw0;		/* lro ctrl dword0 */
+		u32	lro_alt_score_delta;	/* lro auto-learn score delta */
+		u32	lro_rx1_dly_int;	/* lro rx ring1 delay interrupt */
+		u32	lro_ring_dip_dw0;	/* lro ring dip dword0 */
+		u32	lro_ring_ctrl_dw1;	/* lro ring ctrl dword1 */
+		u32	lro_alt_dbg;		/* lro auto-learn debug */
+		u32	lro_alt_dbg_data;	/* lro auto-learn debug data */
+		u32	rss_glo_cfg;		/* rss global configuration */
+
 	} pdma;
 	struct {
 		u32	qtx_cfg;	/* tx queue configuration */
-- 
2.43.0


