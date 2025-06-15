Return-Path: <netdev+bounces-197891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E65ADA337
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 21:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388237A7753
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4C1E493C;
	Sun, 15 Jun 2025 19:50:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC6282EE;
	Sun, 15 Jun 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750017046; cv=none; b=APIfdFdry8y9+y4HhtHtW9Htw8PBZIbDTUZGBsgA9ZDXwNmexvS4+U2w4lcVDnY26VaQdI4zoRaxSUC9M1DJtZ9m0srQ5u0J5ptJvHh+jmb5SZHZhJXTFxmn3R6GpyPTWH/XEjCuheJ5eCGoVob93Jxqmw6Gu7BbRl+NhvfMgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750017046; c=relaxed/simple;
	bh=xVoFJaYK8AIAM7TxB++aBqqnCN5SmkPjJ5jYcWc7I9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg1pTm4IJ6i5/vCjscmj8ZTg3RuWEaYYWF3yWoBAUH7qSS36WSORHr+ckdPlss8vatWCDUdcMZpNtH2yfZaLBn8h4lvDHjLogqd4Kf/rwuexaD9Ikerj1ynWC4B8QBfJ0kxuwjygOv2y2114DJKckoXy+rwQRK/eseB6G2PaFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uQtEf-000000002Zg-1Dyq;
	Sun, 15 Jun 2025 19:50:27 +0000
Date: Sun, 15 Jun 2025 21:49:43 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v3 3/3] net: ethernet: mtk_eth_soc: change code to
 skip first IRQ completely
Message-ID: <aE8ja1fbAtvWx2GN@pidgin.makrotopia.org>
References: <20250615150333.166202-1-linux@fw-web.de>
 <20250615150333.166202-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615150333.166202-4-linux@fw-web.de>

On Sun, Jun 15, 2025 at 05:03:18PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
> IRQ (eth->irq[0]) was read but never used. Skip reading it now too.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 11 ++++++++---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 9aec67c9c6d7..4d7de282b940 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3346,10 +3346,15 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  		return 0;
>  
>  	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
> +			if (i == 0)
> +				eth->irq[MTK_ETH_IRQ_SHARED] = platform_get_irq(pdev, i);
> +			else
> +				eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> +		} else if (i < 2)  //skip the 1st and 4th IRQ on !MTK_SHARED_INT

Please use conformant comment style, ie. do not use '//' but always use
'/* ... */' instead, on a dedicated line.

> +			eth->irq[i] = platform_get_irq(pdev, i + 1);
>  		else
> -			eth->irq[i] = platform_get_irq(pdev, i);
> +			continue;
>  
>  		if (eth->irq[i] < 0) {
>  			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 6b1208d05f79..ff2ae3c80179 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -643,8 +643,8 @@
>  #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
>  
>  #define MTK_ETH_IRQ_SHARED	0
> -#define MTK_ETH_IRQ_TX		1
> -#define MTK_ETH_IRQ_RX		2
> +#define MTK_ETH_IRQ_TX		0
> +#define MTK_ETH_IRQ_RX		1
>  #define MTK_ETH_IRQ_MAX		3

Shouldn't MAX be 1 now?
 

