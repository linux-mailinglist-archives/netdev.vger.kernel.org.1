Return-Path: <netdev+bounces-187613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F55AA8163
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E413AE0E9
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B521FF26;
	Sat,  3 May 2025 15:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11719DF66;
	Sat,  3 May 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285867; cv=none; b=la/0vJtm85z5ZCq/n5oG/8mkRMkEorEOTdek5qNHdXgACDkXVIPIGzOEocanDatDuLZTg3ukzOS3UGWVOpMpLdU0J5ui5M72Y77McPQsT6sGL8obp+KdgMijwSOuXegjDTzJyCnAWePnE7stQdTCv0JO1BdMTpVy12XFAW2LfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285867; c=relaxed/simple;
	bh=gSeBUIyCXbgUeJ1qEnFhiYYbVkUlzBClu5aLAvkWV8U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cv9Y+Poqc6lDTSmr5BVNPn6ubFYNaF4tqYeY7cv4kCPhDeZxpFwaCE30mdR84rl/JF5P6IrpQhy1vj6jfjg1qhskZ3loT65yiRMFNAsQTg1gOQGNG7Vxm01/K16T0RjZJUO/04Pw12bDMI/IdMYO7CtM2EsXrDeKzthjBM+4/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uBEd0-000000005hU-2PCp;
	Sat, 03 May 2025 15:24:06 +0000
Date: Sat, 3 May 2025 16:24:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Elad Yifee <eladwf@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 1/2] net: ethernet: mtk_eth_soc: reset all TX queues on
 DMA free
Message-ID: <27713d0004ead6e57d070f9e19c0d13709ba2512.1746285649.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The purpose of resetting the TX queue is to reset the
byte and packet count as well as to clear the software
flow control XOFF bit.

MediaTek developers pointed out that netdev_reset_queue would only
resets queue 0 of the network device.

Queues that are not reset may cause unexpected issues.

Packets may stop being sent after reset and "transmit timeout" log may
be displayed.

Import fix from MediaTek's SDK to resolve this issue.

Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/319c0d9905579a46dc448579f892f364f1f84818
Fixes: f63959c7eec31 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 217355d79bbb7..d6d4c2daebab0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3274,11 +3274,19 @@ static int mtk_dma_init(struct mtk_eth *eth)
 static void mtk_dma_free(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
-	int i;
+	int i, j, txqs = 1;
+
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
+		txqs = MTK_QDMA_NUM_QUEUES;
+
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		if (!eth->netdev[i])
+			continue;
+
+		for (j = 0; j < txqs; j++)
+			netdev_tx_reset_queue(netdev_get_tx_queue(eth->netdev[i], j));
+	}
 
-	for (i = 0; i < MTK_MAX_DEVS; i++)
-		if (eth->netdev[i])
-			netdev_reset_queue(eth->netdev[i]);
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
 				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
-- 
2.49.0

