Return-Path: <netdev+bounces-186202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A3A9D70A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757963BAD21
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F981DF723;
	Sat, 26 Apr 2025 01:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957218DB2F;
	Sat, 26 Apr 2025 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745631395; cv=none; b=O0iu534cIO6KTidChmqgSnQbquKY8l402SCOzzaw/fo271gYd0SrUAsgZsudxoe920iALCd8XweYGAw3cnb7S9ShJAvG+sLOnRWGaPCz784z3V8V1HrERR0S0tvdEYIrIPm6ihOvU2p0KvdyXAVDdl8UWCBUbZV59Uy96LctS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745631395; c=relaxed/simple;
	bh=SMSNuUX7ZHc+q5C14GZZDuTM/OgTxpbj1zQTohnASTQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW0BHJn4Ws2JfVYMosnLr7Y1UGdDAIWeTymfn/YE04F8UGcAsHpjPwHIQksQVcj9w1TAPy39nYRbugqvStslNY1IO1ntn++Omn8Z1FmWnuDGBBexQbYeka48ixjeWReKnAeGYsnyXCye2aayQrCPIsBj0f6UT6+GOmNL4HmRWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u8UNB-000000007iz-3kmJ;
	Sat, 26 Apr 2025 01:36:25 +0000
Date: Sat, 26 Apr 2025 02:36:22 +0100
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
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix SER panic with 4GB+
 RAM
Message-ID: <aAw4lsGc_5HwBeiK@makrotopia.org>
References: <995df78417d6f117062d1d7ef63228426b97a26e.1745630570.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995df78417d6f117062d1d7ef63228426b97a26e.1745630570.git.daniel@makrotopia.org>

On Sat, Apr 26, 2025 at 02:25:23AM +0100, Daniel Golle wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> If the mtk_poll_rx() function detects the MTK_RESETTING flag, it will
> jump to release_desc and refill the high word of the SDP on the 4GB RFB.
> Subsequently, mtk_rx_clean will process an incorrect SDP, leading to a
> panic.
> 
> Add patch from Mediatek SDK to resolve this.
> 
> Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
> Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/11857ce2f90bf065b5e53211d182622d999a4542

The above link has to be replaced by
Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/71f47ea785699c6aa3b922d66c2bdc1a43da25b1

> Signed-off-by: Chad Monroe <chad@monroe.io>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 47807b202310..7bac5ccfb79c 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2252,14 +2252,17 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  		ring->data[idx] = new_data;
>  		rxd->rxd1 = (unsigned int)dma_addr;
>  release_desc:
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
> +			if (unlikely(dma_addr == DMA_MAPPING_ERROR))
> +				addr64 = FIELD_GET(RX_DMA_ADDR64_MASK, rxd->rxd2);
> +			else
> +				addr64 = RX_DMA_PREP_ADDR64(dma_addr);
> +		}
> +
>  		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
>  			rxd->rxd2 = RX_DMA_LSO;
>  		else
> -			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
> -
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA) &&
> -		    likely(dma_addr != DMA_MAPPING_ERROR))
> -			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
> +			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size) | addr64;
>  
>  		ring->calc_idx = idx;
>  		done++;
> -- 
> 2.49.0
> 
> 

