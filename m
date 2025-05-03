Return-Path: <netdev+bounces-187614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C6AA8165
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B0F1B62A08
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7627A45B;
	Sat,  3 May 2025 15:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CD19DF66;
	Sat,  3 May 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285871; cv=none; b=alZDVQ8wKO/9b5iLqa6A6dtZ3D/5AmQcXebZxktg8D3IeqDA5y5LQy5aUZVDDUJivd+bTbUDKypUMU6ynd9RcJd1f8EwKQUdIw+bNkl3wAbdkMWSBWuisWyF2cPKDlYkIszzDaU2Q8m8hJBrettleh8CE1vkkwxlG89bSvk8AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285871; c=relaxed/simple;
	bh=tmbnxlsppWiYguxYb+RlfQKZJApep4Se6ntHEGHoW4Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx2MMYXbpvvMXYNj73S0deHdkEzYSwSuHkCX9iVLm2yZFGiSp8UoZ3RSa1GV8tGsoo9n2DfiiL6b1/CB6cRKeosRrEALfqp4vMxLntJoac7cVyGAK3hmPKoGAnfm/BdUnZIu1qYAWRsI+M5pPg24wGSTGhRgsfl3UdUZ5QXjIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uBEdI-000000005ht-3H7E;
	Sat, 03 May 2025 15:24:24 +0000
Date: Sat, 3 May 2025 16:24:21 +0100
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
Subject: [PATCH net 2/2] net: mediatek: do not reset PSE when seting FE
 register
Message-ID: <226fada6d179db1655751e689ab30a1cbd682f49.1746285649.git.daniel@makrotopia.org>
References: <27713d0004ead6e57d070f9e19c0d13709ba2512.1746285649.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27713d0004ead6e57d070f9e19c0d13709ba2512.1746285649.git.daniel@makrotopia.org>

From: Frank Wunderlich <frank-w@public-files.de>

Remove redundant PSE reset.
When setting FE register there is no need to reset PSE,
doing so may cause FE to work abnormal.

Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/3a5223473e086a4b54a2b9a44df7d9ddcc2bc75a
Fixes: dee4dd10c79aa ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d6d4c2daebab0..6b5f36ccb3fec 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3561,9 +3561,6 @@ static int mtk_open(struct net_device *dev)
 			}
 			mtk_gdm_config(eth, target_mac->id, gdm_config);
 		}
-		/* Reset and enable PSE */
-		mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
-		mtk_w32(eth, 0, MTK_RST_GL);
 
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
-- 
2.49.0

