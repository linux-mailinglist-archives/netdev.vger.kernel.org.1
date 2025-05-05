Return-Path: <netdev+bounces-187667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765DAA8A8D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742BC7A3CAF
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AB518BC36;
	Mon,  5 May 2025 01:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7318BC0C;
	Mon,  5 May 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746407289; cv=none; b=eX9ocGX1IxjNj/WEFeCwYRQYeCV2rqFi1GuaGpp1WOv/soyKp2FC/Wp68EmH63F1dTdQtNK/9fYCSPyM9nmKL+bPwZefj/X+ehHbfUU0HO5r+EPg5MbEWGzgCeteJzVrzkwxS9c2wDDp1lc6TDlTrqj+CZfgbaiLViJ3vd+w/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746407289; c=relaxed/simple;
	bh=75zWhaHAfd/PZq0supYaQZWq1w+BXA7M2wpBQeb1kh4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn9di+5NGHln9+gc3fEDPBsjs1BXscaEBvDtf7n4Cm3TyLd9fnCiHXBPa09fSKLdUQ3yAT+LCemlg3YYDdEWlLme3PMWE42qPfAB4cETZxg6ZOA4aTMZC8/seBc3NuMiSAC9U2fdEIbaDj9jlrz4xbvTRlfWDE+0GJ86jrMRbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uBkDd-000000004Zc-3m28;
	Mon, 05 May 2025 01:08:01 +0000
Date: Mon, 5 May 2025 02:07:58 +0100
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
Subject: [PATCH net v2 2/2] net: ethernet: mtk_eth_soc: do not reset PSE when
 setting FE
Message-ID: <18f0ac7d83f82defa3342c11ef0d1362f6b81e88.1746406763.git.daniel@makrotopia.org>
References: <c9ff9adceac4f152239a0f65c397f13547639175.1746406763.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ff9adceac4f152239a0f65c397f13547639175.1746406763.git.daniel@makrotopia.org>

From: Frank Wunderlich <frank-w@public-files.de>

Remove redundant PSE reset.
When setting FE register there is no need to reset PSE,
doing so may cause FE to work abnormal.

Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/3a5223473e086a4b54a2b9a44df7d9ddcc2bc75a
Fixes: dee4dd10c79aa ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2: fix commit title

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53c39561b6d9a..22a532695fb0d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3473,9 +3473,6 @@ static int mtk_open(struct net_device *dev)
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

