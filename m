Return-Path: <netdev+bounces-99348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887228D4977
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99D11C21CA6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA57169AEC;
	Thu, 30 May 2024 10:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D8183998
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064368; cv=none; b=PLxdRoP2xJUc2s+zUPBpbPZ+NzgI3StrcaExU7qXV/NCywGbhwXlw7OdNm4tISrDXnVoGgjCz9wA3BH8CMGN3o0reEFCL6rhPpEomZ5nRnZxqCVWih+HZZ49AHxfp73CJEkGrwzg83BRSS5oN+Gc2CxHtk0bUo8im6xoxqm8F1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064368; c=relaxed/simple;
	bh=6S9MRbrEqxJXTa7St2/QPR36zqpXQIavMNVMgePLivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSE+l51YKTtdzSw4GpAln0vzdUZK0zKBq8IEnDalx6BQBkN3WuVRxI9BRLLQlyVhXzmojRS3wq0Z23jeSs+b6TnfqbElzJAKUC7dPWBwtXzNHa4/kLkVSklSRxN28hqQWIAoTMtLMwgTwDQ0E8I57PhP5ENqy/DbnONELxAxctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCcsQ-000000006cy-0LqN;
	Thu, 30 May 2024 10:19:18 +0000
Date: Thu, 30 May 2024 11:19:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lorenzo.bianconi@redhat.com,
	sujuan.chen@mediatek.com, Elad Yifee <eladwf@gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: add support for devices
 with more than 4GB of dram
Message-ID: <ZlhSn8Z6E2Dc1khG@makrotopia.org>
References: <1c7efdf5d384ea7af3c0209723e40b2ee0f956bf.1700239272.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c7efdf5d384ea7af3c0209723e40b2ee0f956bf.1700239272.git.lorenzo@kernel.org>

Hi!

On Fri, Nov 17, 2023 at 05:42:59PM +0100, Lorenzo Bianconi wrote:
> Introduce WED offloading support for boards with more than 4GB of
> memory.
> 
> [...]

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 3cf6589cfdac..a6e91573f8da 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1159,15 +1159,18 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
>  	phy_ring_tail = eth->phy_scratch_ring + soc->txrx.txd_size * (cnt - 1);
>  
>  	for (i = 0; i < cnt; i++) {
> +		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
>  		struct mtk_tx_dma_v2 *txd;
>  
>  		txd = eth->scratch_ring + i * soc->txrx.txd_size;
> -		txd->txd1 = dma_addr + i * MTK_QDMA_PAGE_SIZE;
> +		txd->txd1 = addr;
>  		if (i < cnt - 1)
>  			txd->txd2 = eth->phy_scratch_ring +
>  				    (i + 1) * soc->txrx.txd_size;
>  
>  		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
> +		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
> +			txd->txd3 |= TX_DMA_PREP_ADDR64(addr);
>  		txd->txd4 = 0;
>  		if (mtk_is_netsys_v2_or_greater(eth)) {
>  			txd->txd5 = 0;

The above part of the patch should also be applied to 'net' tree as fix
for commit 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA
addressing on MT7988").

It should have probably been a separate commit in first place, but it is
how it is now and I'm glad that it fixes the remaining issues on devices
devices with 4 GiB of RAM or more (and hence exceeding the 32-bit
addressing range given that DRAM starts at 0x40000000; the commit
message here states that only boards with more than 4 GiB are affected,
but in reality it's boards with more then 3 GiB because of the DRAM
start offset).

Reported-by: Elad Yifee <eladwf@gmail.com>

