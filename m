Return-Path: <netdev+bounces-245119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69595CC7185
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5517930378B9
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487138F25B;
	Wed, 17 Dec 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PnhuMenW"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514138F22A;
	Wed, 17 Dec 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967233; cv=none; b=QeDMrBl/3K/x8u9S3wvHiFjd4aczqJRo6p+s5z4vj+J54LwVZOwApFldOzPBrjEEwBxbsEVVtxjkKfyl4EwkM9Y92YLSR6WYkWWZKkH/r0BGLfDbzHBI7GoGi4m8CU23ktQykUUNGvL2NxjXWcr+3i5/okSKv9xl4Loq3HLWG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967233; c=relaxed/simple;
	bh=v9JdqY4ifacV5kOytaiQyo7M9BGnkz+jt+2N26nR5h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8NbzNdLXhYmT0Lrdd1+zUP+G8gfHjmNLLrrgcI3D8ZLepEO1qD2CPBul4M3DjLo3L2jHAngWWT6XzDJ2VGwA+oi40axr3RrK3mBRt0/gkeAYHu0SBsf/J1KIzg40nRHxcXFW01IVobeIoJil4JWhfCrjufgNZnllDPLB2FeFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PnhuMenW; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 77091100736;
	Wed, 17 Dec 2025 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1765967216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a759R9hBxnMNKen1Zmzcie2kya7DCUr45MDICWe7WgM=;
	b=PnhuMenWsRw7lcqN3muV6uVsxSyocEog9eFk5+cJ4bTc0BSV1hyyFat1mHCHdgwnCBulgb
	cMKHoZouxC/DkN2T25RZiMHAHXIY9y9h2FBClSq2uopt8o49B1J89hd7LCpWggqmr/s/fl
	D8GmCV0MXsNa3gS2A+9muOb8WO+GOX8=
Received: from frank-u24.. (fttx-pool-217.61.152.85.bambit.de [217.61.152.85])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2EDB3122725;
	Wed, 17 Dec 2025 10:26:56 +0000 (UTC)
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
Subject: [RFC net-next v4 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Date: Wed, 17 Dec 2025 11:26:44 +0100
Message-ID: <20251217102648.47093-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217102648.47093-1-linux@fw-web.de>
References: <20251217102648.47093-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mason Chang <mason-cw.chang@mediatek.com>

Add Large Receive Offload support to mediatek ethernet driver and
activate it for MT7988.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- fix lro reverse christmas tree and LRO params suggested by andrew
- drop mtk_hwlro_stats_ebl and unused IS_HW_LRO_RING (only used in
  properitary debugfs)

v2:
- drop link to commit for 6.6 patch
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 244 +++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  47 ++--
 2 files changed, 235 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 4dfff59a3c8a..301bdd6d0c14 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2772,7 +2772,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 	if (rx_flag == MTK_RX_FLAGS_HWLRO) {
 		rx_data_len = MTK_MAX_LRO_RX_LENGTH;
-		rx_dma_size = MTK_HW_LRO_DMA_SIZE;
+		rx_dma_size = MTK_HW_LRO_DMA_SIZE(eth);
 	} else {
 		rx_data_len = ETH_DATA_LEN;
 		rx_dma_size = soc->rx.dma_size;
@@ -2785,7 +2785,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	if (mtk_page_pool_enabled(eth) && rcu_access_pointer(eth->prog))  {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
@@ -2931,10 +2931,11 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 
 static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 {
-	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
-	int i;
 	u32 ring_ctrl_dw1 = 0, ring_ctrl_dw2 = 0, ring_ctrl_dw3 = 0;
+	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
+	const struct mtk_soc_data *soc = eth->soc;
 	u32 lro_ctrl_dw0 = 0, lro_ctrl_dw3 = 0;
+	int i, val;
 
 	/* set LRO rings to auto-learn modes */
 	ring_ctrl_dw2 |= MTK_RING_AUTO_LERAN_MODE;
@@ -2953,30 +2954,44 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 	ring_ctrl_dw2 |= MTK_RING_MAX_AGG_CNT_L;
 	ring_ctrl_dw3 |= MTK_RING_MAX_AGG_CNT_H;
 
-	for (i = 1; i < MTK_MAX_RX_RING_NUM; i++) {
+	for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++) {
 		mtk_w32(eth, ring_ctrl_dw1, MTK_LRO_CTRL_DW1_CFG(reg_map, i));
 		mtk_w32(eth, ring_ctrl_dw2, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
 		mtk_w32(eth, ring_ctrl_dw3, MTK_LRO_CTRL_DW3_CFG(reg_map, i));
 	}
 
 	/* IPv4 checksum update enable */
-	lro_ctrl_dw0 |= MTK_L3_CKS_UPD_EN;
+	lro_ctrl_dw0 |= MTK_L3_CKS_UPD_EN(eth);
 
 	/* switch priority comparison to packet count mode */
 	lro_ctrl_dw0 |= MTK_LRO_ALT_PKT_CNT_MODE;
 
 	/* bandwidth threshold setting */
-	mtk_w32(eth, MTK_HW_LRO_BW_THRE, MTK_PDMA_LRO_CTRL_DW2);
+	mtk_w32(eth, MTK_HW_LRO_BW_THRE, MTK_PDMA_LRO_CTRL_DW2(reg_map));
 
 	/* auto-learn score delta setting */
-	mtk_w32(eth, MTK_HW_LRO_REPLACE_DELTA, MTK_PDMA_LRO_ALT_SCORE_DELTA);
+	mtk_w32(eth, MTK_HW_LRO_REPLACE_DELTA, MTK_PDMA_LRO_ALT_SCORE_DELTA(reg_map));
 
 	/* set refresh timer for altering flows to 1 sec. (unit: 20us) */
 	mtk_w32(eth, (MTK_HW_LRO_TIMER_UNIT << 16) | MTK_HW_LRO_REFRESH_TIME,
 		MTK_PDMA_LRO_ALT_REFRESH_TIMER);
 
-	/* set HW LRO mode & the max aggregation count for rx packets */
-	lro_ctrl_dw3 |= MTK_ADMA_MODE | (MTK_HW_LRO_MAX_AGG_CNT & 0xff);
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		val = mtk_r32(eth, reg_map->pdma.rx_cfg);
+		mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + MTK_MAX_RX_LENGTH) <<
+			MTK_RX_CFG_SDL_OFFSET), reg_map->pdma.rx_cfg);
+
+		lro_ctrl_dw0 |= MTK_PDMA_LRO_SDL << MTK_CTRL_DW0_SDL_OFFSET;
+
+		/* enable cpu reason black list */
+		lro_ctrl_dw0 |= MTK_LRO_CRSN_BNW(eth);
+
+		/* no use PPE cpu reason */
+		mtk_w32(eth, 0xffffffff, MTK_PDMA_LRO_CTRL_DW1(reg_map));
+	} else {
+		/* set HW LRO mode & the max aggregation count for rx packets */
+		lro_ctrl_dw3 |= MTK_ADMA_MODE | (MTK_HW_LRO_MAX_AGG_CNT & 0xff);
+	}
 
 	/* the minimal remaining room of SDL0 in RXD for lro aggregation */
 	lro_ctrl_dw3 |= MTK_LRO_MIN_RXD_SDL;
@@ -2984,8 +2999,19 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 	/* enable HW LRO */
 	lro_ctrl_dw0 |= MTK_LRO_EN;
 
-	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3);
-	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3(reg_map));
+	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0(reg_map));
+
+	if (mtk_is_netsys_v2_or_greater(eth)) {
+		i = (soc->rx.desc_size == sizeof(struct mtk_rx_dma_v2)) ? 1 : 0;
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)), reg_map->pdma.int_grp);
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
+			reg_map->pdma.int_grp + 0x4);
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)), reg_map->pdma.int_grp3);
+	}
 
 	return 0;
 }
@@ -2993,16 +3019,16 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 static void mtk_hwlro_rx_uninit(struct mtk_eth *eth)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
-	int i;
 	u32 val;
+	int i;
 
 	/* relinquish lro rings, flush aggregated packets */
-	mtk_w32(eth, MTK_LRO_RING_RELINQUISH_REQ, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, MTK_LRO_RING_RELINQUISH_REQ(eth), MTK_PDMA_LRO_CTRL_DW0(reg_map));
 
 	/* wait for relinquishments done */
 	for (i = 0; i < 10; i++) {
-		val = mtk_r32(eth, MTK_PDMA_LRO_CTRL_DW0);
-		if (val & MTK_LRO_RING_RELINQUISH_DONE) {
+		val = mtk_r32(eth, MTK_PDMA_LRO_CTRL_DW0(reg_map));
+		if (val & MTK_LRO_RING_RELINQUISH_DONE(eth)) {
 			msleep(20);
 			continue;
 		}
@@ -3010,11 +3036,11 @@ static void mtk_hwlro_rx_uninit(struct mtk_eth *eth)
 	}
 
 	/* invalidate lro rings */
-	for (i = 1; i < MTK_MAX_RX_RING_NUM; i++)
+	for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++)
 		mtk_w32(eth, 0, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
 
 	/* disable HW LRO */
-	mtk_w32(eth, 0, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, 0, MTK_PDMA_LRO_CTRL_DW0(reg_map));
 }
 
 static void mtk_hwlro_val_ipaddr(struct mtk_eth *eth, int idx, __be32 ip)
@@ -3027,7 +3053,7 @@ static void mtk_hwlro_val_ipaddr(struct mtk_eth *eth, int idx, __be32 ip)
 	/* invalidate the IP setting */
 	mtk_w32(eth, (reg_val & ~MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
 
-	mtk_w32(eth, ip, MTK_LRO_DIP_DW0_CFG(idx));
+	mtk_w32(eth, ip, MTK_LRO_DIP_DW0_CFG(reg_map, idx));
 
 	/* validate the IP setting */
 	mtk_w32(eth, (reg_val | MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
@@ -3043,7 +3069,7 @@ static void mtk_hwlro_inval_ipaddr(struct mtk_eth *eth, int idx)
 	/* invalidate the IP setting */
 	mtk_w32(eth, (reg_val & ~MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
 
-	mtk_w32(eth, 0, MTK_LRO_DIP_DW0_CFG(idx));
+	mtk_w32(eth, 0, MTK_LRO_DIP_DW0_CFG(reg_map, idx));
 }
 
 static int mtk_hwlro_get_ip_cnt(struct mtk_mac *mac)
@@ -3059,6 +3085,65 @@ static int mtk_hwlro_get_ip_cnt(struct mtk_mac *mac)
 	return cnt;
 }
 
+static int mtk_hwlro_add_ipaddr_idx(struct net_device *dev, u32 ip4dst)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	const struct mtk_reg_map *reg_map;
+	struct mtk_eth *eth = mac->hw;
+	u32 reg_val;
+	int i;
+
+	reg_map = eth->soc->reg_map;
+
+	/* check for duplicate IP address in the current DIP list */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
+		if (reg_val == ip4dst)
+			break;
+	}
+
+	if (i < MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "Duplicate IP address at DIP(%d)!\n", i);
+		return -EEXIST;
+	}
+
+	/* find out available DIP index */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
+		if (reg_val == 0UL)
+			break;
+	}
+
+	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "DIP index is currently out of resource!\n");
+		return -EBUSY;
+	}
+
+	return i;
+}
+
+static int mtk_hwlro_get_ipaddr_idx(struct net_device *dev, u32 ip4dst)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	struct mtk_eth *eth = mac->hw;
+	u32 reg_val;
+	int i;
+
+	/* find out DIP index that matches the given IP address */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(eth->soc->reg_map, i));
+		if (reg_val == ip4dst)
+			break;
+	}
+
+	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "DIP address is not exist!\n");
+		return -ENOENT;
+	}
+
+	return i;
+}
+
 static int mtk_hwlro_add_ipaddr(struct net_device *dev,
 				struct ethtool_rxnfc *cmd)
 {
@@ -3067,15 +3152,19 @@ static int mtk_hwlro_add_ipaddr(struct net_device *dev,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	int hwlro_idx;
+	u32 ip4dst;
 
 	if ((fsp->flow_type != TCP_V4_FLOW) ||
 	    (!fsp->h_u.tcp_ip4_spec.ip4dst) ||
 	    (fsp->location > 1))
 		return -EINVAL;
 
-	mac->hwlro_ip[fsp->location] = htonl(fsp->h_u.tcp_ip4_spec.ip4dst);
-	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
+	ip4dst = htonl(fsp->h_u.tcp_ip4_spec.ip4dst);
+	hwlro_idx = mtk_hwlro_add_ipaddr_idx(dev, ip4dst);
+	if (hwlro_idx < 0)
+		return hwlro_idx;
 
+	mac->hwlro_ip[fsp->location] = ip4dst;
 	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
 
 	mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[fsp->location]);
@@ -3091,13 +3180,17 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	int hwlro_idx;
+	u32 ip4dst;
 
 	if (fsp->location > 1)
 		return -EINVAL;
 
-	mac->hwlro_ip[fsp->location] = 0;
-	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
+	ip4dst = mac->hwlro_ip[fsp->location];
+	hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, ip4dst);
+	if (hwlro_idx < 0)
+		return hwlro_idx;
 
+	mac->hwlro_ip[fsp->location] = 0;
 	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
 
 	mtk_hwlro_inval_ipaddr(eth, hwlro_idx);
@@ -3105,6 +3198,24 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
 	return 0;
 }
 
+static void mtk_hwlro_netdev_enable(struct net_device *dev)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	struct mtk_eth *eth = mac->hw;
+	int i, hwlro_idx;
+
+	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (mac->hwlro_ip[i] == 0)
+			continue;
+
+		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
+		if (hwlro_idx < 0)
+			continue;
+
+		mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[i]);
+	}
+}
+
 static void mtk_hwlro_netdev_disable(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -3112,8 +3223,14 @@ static void mtk_hwlro_netdev_disable(struct net_device *dev)
 	int i, hwlro_idx;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (mac->hwlro_ip[i] == 0)
+			continue;
+
+		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
+		if (hwlro_idx < 0)
+			continue;
+
 		mac->hwlro_ip[i] = 0;
-		hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + i;
 
 		mtk_hwlro_inval_ipaddr(eth, hwlro_idx);
 	}
@@ -3293,6 +3410,8 @@ static int mtk_set_features(struct net_device *dev, netdev_features_t features)
 
 	if ((diff & NETIF_F_LRO) && !(features & NETIF_F_LRO))
 		mtk_hwlro_netdev_disable(dev);
+	else if ((diff & NETIF_F_LRO) && (features & NETIF_F_LRO))
+		mtk_hwlro_netdev_enable(dev);
 
 	return 0;
 }
@@ -3350,8 +3469,8 @@ static int mtk_dma_init(struct mtk_eth *eth)
 		return err;
 
 	if (eth->hwlro) {
-		for (i = 1; i < MTK_MAX_RX_RING_NUM; i++) {
-			err = mtk_rx_alloc(eth, i, MTK_RX_FLAGS_HWLRO);
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			err = mtk_rx_alloc(eth, MTK_HW_LRO_RING(eth, i), MTK_RX_FLAGS_HWLRO);
 			if (err)
 				return err;
 		}
@@ -3413,8 +3532,8 @@ static void mtk_dma_free(struct mtk_eth *eth)
 
 	if (eth->hwlro) {
 		mtk_hwlro_rx_uninit(eth);
-		for (i = 1; i < MTK_MAX_RX_RING_NUM; i++)
-			mtk_rx_clean(eth, &eth->rx_ring[i], false);
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++)
+			mtk_rx_clean(eth, &eth->rx_ring[MTK_HW_LRO_RING(eth, i)], false);
 	}
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSS)) {
@@ -3609,16 +3728,21 @@ static int mtk_start_dma(struct mtk_eth *eth)
 			val |= MTK_RX_BT_32DWORDS;
 		mtk_w32(eth, val, reg_map->qdma.glo_cfg);
 
-		mtk_w32(eth,
-			MTK_RX_DMA_EN | rx_2b_offset |
-			MTK_RX_BT_32DWORDS | MTK_MULTI_EN,
-			reg_map->pdma.glo_cfg);
+		val = mtk_r32(eth, reg_map->pdma.glo_cfg);
+		val |= MTK_RX_DMA_EN | rx_2b_offset |
+		       MTK_RX_BT_32DWORDS | MTK_MULTI_EN;
+		mtk_w32(eth, val, reg_map->pdma.glo_cfg);
 	} else {
 		mtk_w32(eth, MTK_TX_WB_DDONE | MTK_TX_DMA_EN | MTK_RX_DMA_EN |
 			MTK_MULTI_EN | MTK_PDMA_SIZE_8DWORDS,
 			reg_map->pdma.glo_cfg);
 	}
 
+	if (eth->hwlro && mtk_is_netsys_v3_or_greater(eth)) {
+		val = mtk_r32(eth, reg_map->pdma.glo_cfg);
+		mtk_w32(eth, val | MTK_RX_DMA_LRO_EN, reg_map->pdma.glo_cfg);
+	}
+
 	return 0;
 }
 
@@ -3762,6 +3886,14 @@ static int mtk_open(struct net_device *dev)
 			}
 		}
 
+		if (eth->hwlro) {
+			for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+				napi_enable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+				mtk_rx_irq_enable(eth, MTK_RX_DONE_INT(eth,
+								       MTK_HW_LRO_RING(eth, i)));
+			}
+		}
+
 		refcount_set(&eth->dma_refcnt, 1);
 	} else {
 		refcount_inc(&eth->dma_refcnt);
@@ -3857,6 +3989,14 @@ static int mtk_stop(struct net_device *dev)
 		}
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			mtk_rx_irq_disable(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)));
+			napi_synchronize(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+			napi_disable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+		}
+	}
+
 	cancel_work_sync(&eth->rx_dim.work);
 	cancel_work_sync(&eth->tx_dim.work);
 
@@ -4256,6 +4396,14 @@ static int mtk_napi_init(struct mtk_eth *eth)
 		}
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			rx_napi = &eth->rx_napi[MTK_HW_LRO_RING(eth, i)];
+			rx_napi->eth = eth;
+			rx_napi->rx_ring = &eth->rx_ring[MTK_HW_LRO_RING(eth, i)];
+		}
+	}
+
 	return 0;
 }
 
@@ -4818,7 +4966,7 @@ static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
 		if (dev->hw_features & NETIF_F_LRO) {
-			cmd->data = MTK_MAX_RX_RING_NUM;
+			cmd->data = MTK_HW_LRO_RING_NUM(eth);
 			ret = 0;
 		} else if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSS)) {
 			cmd->data = MTK_RX_RSS_NUM(eth);
@@ -5523,6 +5671,21 @@ static int mtk_probe(struct platform_device *pdev)
 						goto err_free_dev;
 				}
 			}
+
+			if (eth->hwlro) {
+				for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+					irqname = devm_kasprintf(eth->dev, GFP_KERNEL,
+								 "%s LRO RX %d",
+								 dev_name(eth->dev), i);
+					err = devm_request_irq(eth->dev,
+							       eth->irq_pdma[MTK_HW_LRO_IRQ(eth, i)],
+							       mtk_handle_irq_rx, IRQF_SHARED,
+							       irqname,
+							       &eth->rx_napi[MTK_HW_LRO_RING(eth, i)]);
+					if (err)
+						goto err_free_dev;
+				}
+			}
 		} else {
 			irqname = devm_kasprintf(eth->dev, GFP_KERNEL, "%s RX",
 						 dev_name(eth->dev));
@@ -5594,6 +5757,13 @@ static int mtk_probe(struct platform_device *pdev)
 				       mtk_napi_rx);
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			netif_napi_add(eth->dummy_dev, &eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi,
+				       mtk_napi_rx);
+		}
+	}
+
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
 			      MTK_DMA_MONITOR_TIMEOUT);
@@ -5642,6 +5812,12 @@ static void mtk_remove(struct platform_device *pdev)
 		for (i = 1; i < MTK_RX_RSS_NUM(eth); i++)
 			netif_napi_del(&eth->rx_napi[MTK_RSS_RING(i)].napi);
 	}
+
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++)
+			netif_napi_del(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+	}
+
 	mtk_cleanup(eth);
 	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 1ef4a210a4cd..4bbce80e11a0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -35,7 +35,7 @@
 #define MTK_DMA_SIZE(x)		(SZ_##x)
 #define MTK_FQ_DMA_HEAD		32
 #define MTK_FQ_DMA_LENGTH	2048
-#define MTK_RX_ETH_HLEN		(ETH_HLEN + ETH_FCS_LEN)
+#define MTK_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
 #define MTK_RX_HLEN		(NET_SKB_PAD + MTK_RX_ETH_HLEN + NET_IP_ALIGN)
 #define MTK_DMA_DUMMY_DESC	0xffffffff
 #define MTK_DEFAULT_MSG_ENABLE	(NETIF_MSG_DRV | \
@@ -63,10 +63,9 @@
 
 #define MTK_QRX_OFFSET		0x10
 
-#define MTK_MAX_RX_RING_NUM	4
-#define MTK_HW_LRO_DMA_SIZE	8
-
-#define	MTK_MAX_LRO_RX_LENGTH		(4096 * 3)
+#define MTK_MAX_RX_RING_NUM	(8)
+#define MTK_HW_LRO_DMA_SIZE(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 64 : 8)
+#define	MTK_MAX_LRO_RX_LENGTH		(4096 * 3 + MTK_MAX_RX_LENGTH)
 #define	MTK_MAX_LRO_IP_CNT		2
 #define	MTK_HW_LRO_TIMER_UNIT		1	/* 20 us */
 #define	MTK_HW_LRO_REFRESH_TIME		50000	/* 1 sec. */
@@ -182,31 +181,35 @@
 #define MTK_CDMM_THRES		0x165c
 
 /* PDMA HW LRO Control Registers */
-#define MTK_PDMA_LRO_CTRL_DW0	0x980
-#define MTK_HW_LRO_RING_NUM(eth)		(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_DIP_NUM(eth)		(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_RING_NUM(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_RING(eth, x)		((x) + (mtk_is_netsys_v3_or_greater(eth) ? 4 : 1))
+#define MTK_HW_LRO_IRQ(eth, x)		((x) + (mtk_is_netsys_v3_or_greater(eth) ? 0 : 1))
+#define MTK_LRO_CRSN_BNW(eth)		BIT((mtk_is_netsys_v3_or_greater(eth) ? 22 : 6))
 #define MTK_LRO_EN			BIT(0)
 #define MTK_NON_LRO_MULTI_EN		BIT(2)
 #define MTK_LRO_DLY_INT_EN		BIT(5)
-#define MTK_L3_CKS_UPD_EN		BIT(7)
-#define MTK_L3_CKS_UPD_EN_V2		BIT(19)
+#define MTK_L3_CKS_UPD_EN(eth)		BIT(mtk_is_netsys_v3_or_greater(eth) ? 19 : 7)
 #define MTK_LRO_ALT_PKT_CNT_MODE	BIT(21)
-#define MTK_LRO_RING_RELINQUISH_REQ	(0x7 << 26)
-#define MTK_LRO_RING_RELINQUISH_REQ_V2	(0xf << 24)
-#define MTK_LRO_RING_RELINQUISH_DONE	(0x7 << 29)
-#define MTK_LRO_RING_RELINQUISH_DONE_V2	(0xf << 28)
-
-#define MTK_PDMA_LRO_CTRL_DW1	0x984
-#define MTK_PDMA_LRO_CTRL_DW2	0x988
-#define MTK_PDMA_LRO_CTRL_DW3	0x98c
+#define MTK_LRO_RING_RELINQUISH_REQ(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 0xf << 24 : 0x7 << 26)
+#define MTK_LRO_RING_RELINQUISH_DONE(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 0xf << 28 : 0x7 << 29)
+
+#define MTK_PDMA_LRO_CTRL_DW0(reg_map)	(reg_map->pdma.lro_ctrl_dw0)
+#define MTK_PDMA_LRO_CTRL_DW1(reg_map)	(reg_map->pdma.lro_ctrl_dw0 + 0x04)
+#define MTK_PDMA_LRO_CTRL_DW2(reg_map)	(reg_map->pdma.lro_ctrl_dw0 + 0x08)
+#define MTK_PDMA_LRO_CTRL_DW3(reg_map)	(reg_map->pdma.lro_ctrl_dw0 + 0x0c)
 #define MTK_ADMA_MODE		BIT(15)
 #define MTK_LRO_MIN_RXD_SDL	(MTK_HW_LRO_SDL_REMAIN_ROOM << 16)
 
+#define MTK_CTRL_DW0_SDL_OFFSET	(3)
+#define MTK_CTRL_DW0_SDL_MASK	BITS(3, 18)
+
 #define MTK_RX_DMA_LRO_EN	BIT(8)
 #define MTK_MULTI_EN		BIT(10)
 #define MTK_PDMA_SIZE_8DWORDS	(1 << 4)
 
 /* PDMA RSS Control Registers */
-#define MTK_RX_NAPI_NUM			(4)
+#define MTK_RX_NAPI_NUM			(8)
 #define MTK_RX_RSS_NUM(eth)		(eth->soc->rss_num)
 #define MTK_RSS_RING(x)			(x)
 #define MTK_RSS_EN			BIT(0)
@@ -242,11 +245,10 @@
 #define MTK_PDMA_DELAY_PTIME_MASK	0xff
 
 /* PDMA HW LRO Alter Flow Delta Register */
-#define MTK_PDMA_LRO_ALT_SCORE_DELTA	0xa4c
+#define MTK_PDMA_LRO_ALT_SCORE_DELTA(reg_map)	(reg_map->pdma.lro_alt_score_delta)
 
 /* PDMA HW LRO IP Setting Registers */
-#define MTK_LRO_RX_RING0_DIP_DW0	0xb04
-#define MTK_LRO_DIP_DW0_CFG(x)		(MTK_LRO_RX_RING0_DIP_DW0 + (x * 0x40))
+#define MTK_LRO_DIP_DW0_CFG(reg_map, x)	(reg_map->pdma.lro_ring_dip_dw0 + ((x) * 0x40))
 #define MTK_RING_MYIP_VLD		BIT(9)
 
 /* PDMA HW LRO Ring Control Registers */
@@ -1184,7 +1186,8 @@ enum mkt_eth_capabilities {
 
 #define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC2_2P5GPHY | \
 		      MTK_MUX_GMAC2_TO_2P5GPHY | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
-		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_PDMA_INT | MTK_RSS)
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_PDMA_INT | MTK_RSS | \
+		      MTK_HWLRO)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
-- 
2.43.0


