Return-Path: <netdev+bounces-186200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8050A9D703
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E30F4C76E5
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42019CC0A;
	Sat, 26 Apr 2025 01:25:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B6191F95;
	Sat, 26 Apr 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745630751; cv=none; b=apq/u8iD2uN1YHxnMimUXF+KMF9AokVgG2QaInHH1X/fdBKb8hvxpNd5XQF5yOPtmtj+NWC0QkEdgkf5CaWlBAdK08Bk+rvx8phXchyFVyltDwrgYrlQ/JoN2MXrFbBRuIpTWD0aIkt3wbwSFBty9L2nhP4njc6jimIKmFag3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745630751; c=relaxed/simple;
	bh=Uh7YOaFa/GauQw+D1Y5cRdQi24/8GwgNBQ94AKUSAVY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZOt3nmilsnKmzv4WmUh2AFCFEKLz71nICkzLnGRSk/e7mnLO+Ze5AyDKctbQH6NBuITyM9fZjb9V7EJC//ww+n+AU1g4umZ3xdYa6PQIUxalomohR5E6bLopymvCOdP333DtOltdWEcVdQnMdcg6o8ktkmFYA2/kBiGNUkJbOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u8UCc-000000007gz-3myq;
	Sat, 26 Apr 2025 01:25:30 +0000
Date: Sat, 26 Apr 2025 02:25:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Chad Monroe <chad@monroe.io>, Felix Fietkau <nbd@nbd.name>,
	Bc-Bocun Chen <bc-bocun.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM
Message-ID: <995df78417d6f117062d1d7ef63228426b97a26e.1745630570.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Chad Monroe <chad@monroe.io>

If the mtk_poll_rx() function detects the MTK_RESETTING flag, it will
jump to release_desc and refill the high word of the SDP on the 4GB RFB.
Subsequently, mtk_rx_clean will process an incorrect SDP, leading to a
panic.

Add patch from Mediatek SDK to resolve this.

Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/11857ce2f90bf065b5e53211d182622d999a4542
Signed-off-by: Chad Monroe <chad@monroe.io>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 47807b202310..7bac5ccfb79c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2252,14 +2252,17 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		ring->data[idx] = new_data;
 		rxd->rxd1 = (unsigned int)dma_addr;
 release_desc:
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
+			if (unlikely(dma_addr == DMA_MAPPING_ERROR))
+				addr64 = FIELD_GET(RX_DMA_ADDR64_MASK, rxd->rxd2);
+			else
+				addr64 = RX_DMA_PREP_ADDR64(dma_addr);
+		}
+
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 			rxd->rxd2 = RX_DMA_LSO;
 		else
-			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
-
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA) &&
-		    likely(dma_addr != DMA_MAPPING_ERROR))
-			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
+			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size) | addr64;
 
 		ring->calc_idx = idx;
 		done++;
-- 
2.49.0


