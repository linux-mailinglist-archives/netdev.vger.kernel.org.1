Return-Path: <netdev+bounces-182400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD5AA88AC2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BB4177D66
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1228A1FE;
	Mon, 14 Apr 2025 18:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E02749E2;
	Mon, 14 Apr 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654325; cv=none; b=BVsAoXTL87wb35Tx2gPAGqSaF+9xTW+aGVyS9l0XUselCTkEpS8vTSngGJMrCSICGZIKmm868A334Im2UJKzgO85skDu5KJ5+c9tOeK7Ha79V29PdD96DCpqKZEQiDNXjD1N3VaStxkaGQSMU+l3Z1/FOqPuwyHL5r2qvKKezqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654325; c=relaxed/simple;
	bh=q9vsOQrwcZjPUlngcrXymalhbmU5PZ3/qEVkLmV4x/w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU/z1/xLTJ2GLOBg+GrKafpqP00r+g8EHsTlw9bHUM2S/Koh7XESqE8vSIv9HKiIcmk/Wo+hwF0O8/X2PvjN2WH38nKwW8X9U6o6ULSHvvOkhAPxOVyYCJCkeL/+3pIeEI87a3sgoFa+r+Zy/OTE0+SJJBOMmb3MY9IdBmwyeic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4OHk-000000003yA-45o4;
	Mon, 14 Apr 2025 18:11:57 +0000
Date: Mon, 14 Apr 2025 19:11:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Bo-Cun Chen <bc-bocun.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
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
Subject: [PATCH net 2/5] net: ethernet: mtk_eth_soc: correct the max weight
 of the queue limit for 100Mbps
Message-ID: <1de9eee56354294f04abec64215c7c5d99cb325e.1744654076.git.daniel@makrotopia.org>
References: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

Without this patch, the maximum weight of the queue limit will be
incorrect when linked at 100Mbps due to an apparent typo.

Fixes: f63959c7eec31 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fd643cc1b7dd2..6dff483d4e3aa 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -734,7 +734,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 		case SPEED_100:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 103) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3);
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
 			break;
 		case SPEED_1000:
@@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 		case SPEED_100:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
 			break;
 		case SPEED_1000:
-- 
2.49.0

