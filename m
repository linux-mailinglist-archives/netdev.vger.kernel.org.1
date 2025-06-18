Return-Path: <netdev+bounces-199093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20076ADEE97
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947841BC1A23
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544C2EA72D;
	Wed, 18 Jun 2025 13:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33F2EA72C;
	Wed, 18 Jun 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254981; cv=none; b=JOsfPqBw8ZcEg7SLnJgVtbCRfNPYwqf8Hb2wvNNquu2H/hzPlDdh8bbL1pqFAL4ApLGU5OCv6yCEx3hjihhZmGN83bfP6yrzQgf7q1gt6sG5Vh5Id/7vQvglXDHsuSu1ozQ+V3g+ZmfO5EO/1RDPiH9sshpDChA2HOtQzn5Uqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254981; c=relaxed/simple;
	bh=v3ZpREMUhFIX9M7AGFK+DPGAOyAA6vhpBXi+PM2R62Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXizi5172s//yZDhKM/QMd+Xy8v4aZOgbdCsb8TOQy+E4kywN3CKzBcVqKdqwk5fUrzEn9DzlWAITec2Qu/+JvQQDKGi/qNFh0Syq3BL2AdrH5/rBJr2pP6MhFyE7MSQhpFerp9iDuoNnXcJSAT+hNb7SziRQMTgc6BOjIzmHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uRt8G-000000003fP-1YpV;
	Wed, 18 Jun 2025 13:55:58 +0000
Date: Wed, 18 Jun 2025 15:55:45 +0200
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
	linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>,
	arinc.unal@arinc9.com
Subject: Re: [net-next v5 1/3] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <aFLFYe8mq4tbLfdf@pidgin.makrotopia.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618130717.75839-2-linux@fw-web.de>

On Wed, Jun 18, 2025 at 03:07:12PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add named interrupts and keep index based fallback for existing
> devicetrees.
> 
> Currently only rx and tx IRQs are defined to be used with mt7988, but
> later extended with RSS/LRO support.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
>  
> +static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
> +{
> +	int i;
> +
> +	/* future SoCs beginning with MT7988 should use named IRQs in dts */
> +	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
> +	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
> +	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
> +		return 0;

I'd rather extend that logic and fall back to the legacy way only in case
of -ENXIO. Ie. add here:

if (eth->irq[1] != -ENXIO)
	return eth->irq[1];

if (eth->irq[2] != -ENXIO)
	return eth->irq[2];

Maybe also output a warning at this point in case MTK_SHARED_INT is no
set, to recommend users to update their device tree to named interrupts.

> +
> +	/* legacy way:
> +	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken
> +	 * from devicetree and used for both RX and TX - it is shared.
> +	 * On SoCs with non-shared IRQs the first entry is not used,
> +	 * the second is for TX, and the third is for RX.
> +	 */
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
> @@ -5106,17 +5137,10 @@ static int mtk_probe(struct platform_device *pdev)
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
> 

