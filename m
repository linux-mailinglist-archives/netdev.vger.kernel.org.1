Return-Path: <netdev+bounces-249265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF221D16697
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38CA63024D7B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDF276058;
	Tue, 13 Jan 2026 03:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0A27C842;
	Tue, 13 Jan 2026 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273933; cv=none; b=KtctI9ia7Blf06dbxPaJRnbgzlt16Yr+mB3zDrybxNAzzdgvec010ivhjzZuyz/wflChlZJ9ll8S1F3NVUIkLxecip5cAhPvTZzOEti2EoqumqsbwxbZdk8x6QnUbBarfsOR5zyT9bUC+il1NaHh+1GYNpefAUpRUQCrFtZ/1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273933; c=relaxed/simple;
	bh=hYtrC6CqMzCEhOo5HQm6y0KnZ/lCq8yocMt3wSJx9Xo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QN7S4pUvxQVc4AXnSNQSLOkjmFcaZcghgaerd9XBx46FJv3gLr4dCSiAN2SuDqYU7r7sOQ3646o8MPvTSSp43vj1HJZra8ng+QMQdVgVXG/H9J/quQtGxtzv5IFBC1wa36HvoNSSagOtAX2HkZg4YLdjEDTHaA6/2dSwoiU3d8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfUp4-000000001Go-14dU;
	Tue, 13 Jan 2026 03:11:58 +0000
Date: Tue, 13 Jan 2026 03:11:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: support using
 non-MediaTek DSA switches
Message-ID: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

MediaTek's Ethernet Frame Engine is tailored for use with their
switches. This broke checksum and VLAN offloading when attaching a
DSA switch which does not use MediaTek special tag format.

As a work-around, make sure checksum offloading is disabled and
make sure bits instructing the FE to parse or modify MTK special
tags aren't set if the attached DSA switch isn't using the
MediaTek special tag format.

Note that this currently also disables checksum and VLAN offloading
when using DSA switches using 802.1Q-based tags, though that those
do work fine and can benefit from the offloading features of the
Ethernet Frame Engine. This is why more feedback from DSA maintainers
regarding this issue would be very welcome.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 44 +++++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e68997a29191b..654b707ee27a1 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1459,6 +1459,26 @@ static void setup_tx_buf(struct mtk_eth *eth, struct mtk_tx_buf *tx_buf,
 	}
 }
 
+static bool mtk_uses_dsa(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	return netdev_uses_dsa(dev) &&
+	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
+#else
+	return false;
+#endif
+}
+
+static bool non_mtk_uses_dsa(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	return netdev_uses_dsa(dev) &&
+	       dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK;
+#else
+	return false;
+#endif
+}
+
 static void mtk_tx_set_dma_desc_v1(struct net_device *dev, void *txd,
 				   struct mtk_tx_dma_desc_info *info)
 {
@@ -1531,7 +1551,7 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
 		/* tx checksum offload */
 		if (info->csum)
 			data |= TX_DMA_CHKSUM_V2;
-		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
+		if (mtk_is_netsys_v3_or_greater(eth) && mtk_uses_dsa(dev))
 			data |= TX_DMA_SPTAG_V3;
 	}
 	WRITE_ONCE(desc->txd5, data);
@@ -2350,7 +2370,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		 * hardware treats the MTK special tag as a VLAN and untags it.
 		 */
 		if (mtk_is_netsys_v1(eth) && (trxd.rxd2 & RX_DMA_VTAG) &&
-		    netdev_uses_dsa(netdev)) {
+		    mtk_uses_dsa(netdev)) {
 			unsigned int port = RX_DMA_VPID(trxd.rxd3) & GENMASK(2, 0);
 
 			if (port < ARRAY_SIZE(eth->dsa_meta) &&
@@ -3192,6 +3212,14 @@ static netdev_features_t mtk_fix_features(struct net_device *dev,
 		}
 	}
 
+	if ((features & NETIF_F_IP_CSUM) &&
+	    non_mtk_uses_dsa(dev))
+		features &= ~NETIF_F_IP_CSUM;
+
+	if ((features & NETIF_F_IPV6_CSUM) &&
+	    non_mtk_uses_dsa(dev))
+		features &= ~NETIF_F_IPV6_CSUM;
+
 	return features;
 }
 
@@ -3508,23 +3536,13 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
 
 	val |= config;
 
-	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
+	if (eth->netdev[id] && mtk_uses_dsa(eth->netdev[id]))
 		val |= MTK_GDMA_SPECIAL_TAG;
 
 	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
 }
 
 
-static bool mtk_uses_dsa(struct net_device *dev)
-{
-#if IS_ENABLED(CONFIG_NET_DSA)
-	return netdev_uses_dsa(dev) &&
-	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
-#else
-	return false;
-#endif
-}
-
 static int mtk_device_event(struct notifier_block *n, unsigned long event, void *ptr)
 {
 	struct mtk_mac *mac = container_of(n, struct mtk_mac, device_notifier);
-- 
2.52.0

