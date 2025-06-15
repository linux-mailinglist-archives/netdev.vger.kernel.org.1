Return-Path: <netdev+bounces-197869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD2ADA172
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32D5170EBC
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECEA202C40;
	Sun, 15 Jun 2025 09:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACE2F22;
	Sun, 15 Jun 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749979644; cv=none; b=TtYkkfravbzTAAIhzL5w26w8ue8dDPk6wCG9P2W8xUT1s8D633S7b5a3KRmJtkqg8Xw/7L8DcKIxB1y1fKS7sFg16MilBsKvIBFI69zbOqySU9QuEdmY1EbsQLIggnXUga7+P+pwb2gQpxPrflakrBZAL3i23ZAoKLn263y60K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749979644; c=relaxed/simple;
	bh=5s7KfjpnlZ6ExyOQP7wlpgJTKuKli30ZCxkEEQmiK54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDekzf7hy4xXSzO1sriRYU63iamKtc4JwFzKe7HMeVbKDTPGUPzsoFsarrkqy1r1mDD/S3C2qA+BJPQoMCnuKvJNBZJGTr2/tOj8vHeRubmu7liX5Zy81TwSlWD1eDZyzQALO4e0HBMwLIUbY2OToa7jgKyI6bnOLBmvBbKrTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uQjVM-0000000014M-10eE;
	Sun, 15 Jun 2025 09:27:02 +0000
Date: Sun, 15 Jun 2025 11:26:39 +0200
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
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <aE6Rz1l3kfeCFNdY@pidgin.makrotopia.org>
References: <20250615084521.32329-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615084521.32329-1-linux@fw-web.de>

On Sun, Jun 15, 2025 at 10:45:19AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add named interrupts and keep index based fallback for exiting devicetrees.
> 
> Currently only rx and tx IRQs are defined to be used with mt7988, but
> later extended with RSS/LRO support.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - move irqs loading part into own helper function
> - reduce indentation
> - place mtk_get_irqs helper before the irq_handler (note for simon)
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 39 +++++++++++++++------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index b76d35069887..81ae8a6fe838 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3337,6 +3337,30 @@ static void mtk_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  	schedule_work(&eth->pending_work);
>  }
>  
> +static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
> +{
> +	int i;
> +
> +	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
> +	eth->irq[2] = platform_get_irq_byname(pdev, "rx");

In addition to Lorenzo's comment to reduce the array to the actually used
IRQs, I think it would be nice to introduce precompiler macros for the irq
array index, ie. once the array is reduce to size 2 it could be something
like

#define MTK_ETH_IRQ_SHARED 0
#define MTK_ETH_IRQ_TX 0
#define MTK_ETH_IRQ_RX 1
#define __MTK_ETH_IRQ_MAX MTK_ETH_IRQ_RX

That would make all the IRQ code more readable than having to deal with
numerical values.

> +	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
> +		return 0;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> +			eth->irq[i] = eth->irq[0];
> +		else
> +			eth->irq[i] = platform_get_irq(pdev, i);
> +
> +		if (eth->irq[i] < 0) {
> +			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> +			return -ENXIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
>  {
>  	struct mtk_eth *eth = _eth;
> @@ -5106,17 +5130,10 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	for (i = 0; i < 3; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[0];
> -		else
> -			eth->irq[i] = platform_get_irq(pdev, i);
> -		if (eth->irq[i] < 0) {
> -			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> -			err = -ENXIO;
> -			goto err_wed_exit;
> -		}
> -	}
> +	err = mtk_get_irqs(pdev, eth);
> +	if (err)
> +		goto err_wed_exit;
> +
>  	for (i = 0; i < ARRAY_SIZE(eth->clks); i++) {
>  		eth->clks[i] = devm_clk_get(eth->dev,
>  					    mtk_clks_source_name[i]);
> -- 
> 2.43.0
> 

