Return-Path: <netdev+bounces-183073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7DA8AD03
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236333B3AC5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B01E3775;
	Wed, 16 Apr 2025 00:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228311DF744;
	Wed, 16 Apr 2025 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764697; cv=none; b=hz9MIuua/Owv8caeMvmvvTmiq/4wA5cRlJtkhuKxaqbpzB460HBwCvHNSbSSwneCLVHH5wMAQ9vkeUd0hhmG1GwoNlFE4ZZ8soG2dwzO6OyYWhGaujNESzLJUvCK6LGzQDzEzT2jK9xNAnEtcSDECvVbQmo1hd+RYvR8/sZY45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764697; c=relaxed/simple;
	bh=DZDv5MQF1/oui/8noBuhPphYWa01ysN3rUoC5gyz7kQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAtoCXNGq7UFfsOjj6g2Nc+rHgVoT9xxvh6Ghy+GMUzt9kqifjj90N11vdfUADX+8rgIvxQNw/0jrpBUXQNngL5qul2FzsJtFi4E5RCBQE1HtdhHdnBgYcJh1Hevrh3kw3PRsoRpFRXDo7l9m1vfCnhSJoYuS6Vs8dADjuCl8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4qxO-000000001TR-1n2c;
	Wed, 16 Apr 2025 00:51:28 +0000
Date: Wed, 16 Apr 2025 01:51:25 +0100
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
Subject: [PATCH net v2 3/5] net: ethernet: mtk_eth_soc: revise QDMA packet
 scheduler settings
Message-ID: <18040f60f9e2f5855036b75b28c4332a2d2ebdd8.1744764277.git.daniel@makrotopia.org>
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

The QDMA packet scheduler suffers from a performance issue.
Fix this by picking up changes from MediaTek's SDK which change to use
Token Bucket instead of Leaky Bucket and fix the SPEED_1000 configuration.

Fixes: 160d3a9b1929 ("net: ethernet: mtk_eth_soc: introduce MTK_NETSYS_V2 support")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no change
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5a3cfb8908a17..bdb98c9d8b1c1 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -762,8 +762,8 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 			break;
 		case SPEED_1000:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 10) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 6) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 10);
 			break;
 		default:
@@ -3320,7 +3320,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		if (mtk_is_netsys_v2_or_greater(eth))
 			val |= MTK_MUTLI_CNT | MTK_RESV_BUF |
 			       MTK_WCOMP_EN | MTK_DMAD_WR_WDONE |
-			       MTK_CHK_DDONE_EN | MTK_LEAKY_BUCKET_EN;
+			       MTK_CHK_DDONE_EN;
 		else
 			val |= MTK_RX_BT_32DWORDS;
 		mtk_w32(eth, val, reg_map->qdma.glo_cfg);
-- 
2.49.0

