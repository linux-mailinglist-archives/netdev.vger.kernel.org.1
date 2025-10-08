Return-Path: <netdev+bounces-228214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626EBC4DB5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE7619E1FEC
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7E24EAB2;
	Wed,  8 Oct 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOI2jsR8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E4224B15
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927056; cv=none; b=bLrrq2fGXllbo3OS2trOB3VXIdpmiPldG0ZRheA6xgj0M/6PwnQX2GwL9yo6nMGWm8OHPk/ChP/zhAtR7Z2ANWIecfGQzUy+7oSg8kTSO9LJ4Svi+tJgsrbfNvn0cPiU6F6oj9MHZUhuKdRkk2T4Fj4tY5VNkGg2GX9oxpcAYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927056; c=relaxed/simple;
	bh=la5UGkrChP41nMA8ubVJ6aDpaA9vwENHhK+zqCfr9go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6wmrTdYi4cEZ4hiLmIYpeZpWGhv9UqMAzqxCI2Z7GYzuh5K045/iwaHmBInxjy5CWXbGAkbvBYMfQ2toA0aI4zRxdT1gEsf90S8BvI3lij4BegG+6s8ToHgpWOHXYWroJENipU6nly3laeg2oZWMe+e7YYv9JL4XR7fYP8HV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOI2jsR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA3C4CEF4;
	Wed,  8 Oct 2025 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759927056;
	bh=la5UGkrChP41nMA8ubVJ6aDpaA9vwENHhK+zqCfr9go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOI2jsR8CxcKyy6uc5misn1Qu/ayWTCBtndON+96E7TP5Ye+qvksJGxAzH30GzNb5
	 gdln0W0RWs/qqI87aKJTjGG4zyp16K0qA8D1fEcplk6IIhiX21x+lMgEaFCytYdcD7
	 XhSOSOuZ1BpmTzSTtT9IPYT23B20TvmxvnRE4TjUP8KO79kHkL5qKbTkX9Ov+z0DBF
	 05s1D2kDjbQ3JQOwGPgirQeJjVo5uVE0bfEtXhFpvsbj3KxnYWlcC9N738wl+vzd27
	 tc7DtgdJxbKXBAitmEyLtZ6nBaKC4llBvDUh3F/8TwvMbBE3vBGpJ+fdQeLeliUXjT
	 othLSO+snPIxA==
Date: Wed, 8 Oct 2025 13:37:31 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>,
	Daniel Pawlik <pawlik.dan@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH net] net: mtk: wed: add dma mask limitation and GFP_DMA32
 for device with more than 4GB DRAM
Message-ID: <20251008123731.GR3060232@horms.kernel.org>
References: <20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org>

On Wed, Oct 08, 2025 at 12:48:05PM +0200, Lorenzo Bianconi wrote:
> From: Rex Lu <rex.lu@mediatek.com>
> 
> Limit tx/rx buffer address to 32-bit address space for board with more
> than 4GB DRAM.
> 

Hi Lorenzo, Rex, all,

As a fix for net a Fixes tag should probably go here.
> Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
> Tested-by: Matteo Croce <teknoraver@meta.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> @@ -2426,6 +2426,10 @@ mtk_wed_attach(struct mtk_wed_device *dev)
>  	dev->version = hw->version;
>  	dev->hw->pcie_base = mtk_wed_get_pcie_base(dev);
>  
> +	ret = dma_set_mask_and_coherent(hw->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;

I think 'goto out' is needed here to avoid leaking hw_lock.

> +
>  	if (hw->eth->dma_dev == hw->eth->dev &&
>  	    of_dma_is_coherent(hw->eth->dev->of_node))
>  		mtk_eth_set_dma_device(hw->eth, hw->dev);
> 

-- 
pw-bot: changes-requested

