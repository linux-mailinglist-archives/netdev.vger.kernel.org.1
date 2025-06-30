Return-Path: <netdev+bounces-202568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C64AEE490
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86BC7A6C96
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E558291C05;
	Mon, 30 Jun 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWS6p1Zq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCD290D9C;
	Mon, 30 Jun 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301007; cv=none; b=P15rIAduxD9IG7rqGRdA4lLU5mmMhU9Ty0oYehBXxVxDaMlAlqG7rut2b2GpAlkNHUrpvdtyyCIKZjuA6YPWd91tAUVu4exGDXUcYz7Mz7o3ZNFx3Wz8q7tonQuZtZkGy0l5FLscWni7/K8AShODIu4O03PRf+i34d+g9L5WGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301007; c=relaxed/simple;
	bh=0HxkYgJxPovw38S/ncV1y0Tb+2e4bvKdNpiGuJwX7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELoba10+obbUhEY+bXiMUVeIBG30mWWwbA3Y8mEh+3DlqtfyrZItuV3iwJ9GYcZ2kzBY+rX6wCvNJef9xSq8Xigdl8mMJ5neN8DPqKYfB+0rPwayhbyZjZrotoe5HV2huySukQMT58RNBcAR3VbFR7FFIV+1ixVmF3OuOTK3xHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWS6p1Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14FC4CEE3;
	Mon, 30 Jun 2025 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751301006;
	bh=0HxkYgJxPovw38S/ncV1y0Tb+2e4bvKdNpiGuJwX7+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWS6p1ZqJY1wyPDCa5Q+4k7uUZFH7e1dhC6M0vVyKzT0AWn1SyJC1X1g/4Hqu/63a
	 3WJAloRinPotqkJKcJxkD7KgWvhkyIcaKT8cfy6pTMBVbKyFRUTqRrNd51K/P+gy3G
	 8Yp58LunVtmh0MFDS+s35dAS32ijVX60vAV6hmVTY0b2dHAbKmPBb7v1XH58A29SGo
	 H3hoDDjwJ5fUR/VD9TgSokq65t0ANmV6I8CsnYSpRaJmBF/i7wY3OS+jRqqxRiefw/
	 qzfYVjeL+W/AC+4ihwgUS1oDXrhHGh9KWunYqEVkUDgyXYkIoQDFOg+b98ZAZmbje9
	 Vdsgs/5TwzvlQ==
Date: Mon, 30 Jun 2025 17:29:59 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
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
Subject: Re: [PATCH net-next v2 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <20250630162959.GA57523@horms.kernel.org>
References: <cover.1751229149.git.daniel@makrotopia.org>
 <61897c7a3dcc0b2976ec2118226c06c220b00a80.1751229149.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61897c7a3dcc0b2976ec2118226c06c220b00a80.1751229149.git.daniel@makrotopia.org>

On Sun, Jun 29, 2025 at 11:22:44PM +0100, Daniel Golle wrote:
> Use a dedicated "mmio-sram" and the genpool allocator instead of
> open-coding SRAM allocation for DMA rings.
> Keep support for legacy device trees but notify the user via a
> warning to update.
> 
> Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: fix return type of mtk_dma_ring_alloc() in case of error
> 
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 120 +++++++++++++-------
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |   4 +-
>  2 files changed, 84 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

...

> @@ -5117,16 +5148,27 @@ static int mtk_probe(struct platform_device *pdev)
>  			err = -EINVAL;
>  			goto err_destroy_sgmii;
>  		}
> +
>  		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
> -			if (mtk_is_netsys_v3_or_greater(eth)) {
> -				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -				if (!res_sram) {
> -					err = -EINVAL;
> -					goto err_destroy_sgmii;
> +			eth->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> +			if (!eth->sram_pool) {
> +				if (!mtk_is_netsys_v3_or_greater(eth)) {
> +					/*
> +					 * Legacy support for missing 'sram' node in DT.
> +					 * SRAM is actual memory and supports transparent access
> +					 * just like DRAM. Hence we don't require __iomem being
> +					 * set and don't need to use accessor functions to read from
> +					 * or write to SRAM.
> +					 */
> +					eth->sram_base = (void __force *)eth->base +
> +							 MTK_ETH_SRAM_OFFSET;
> +					eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
> +					dev_warn(&pdev->dev,
> +						 "legacy DT: using hard-coded SRAM offset.\n");
> +				} else {
> +					dev_err(&pdev->dev, "Could not get SRAM pool\n");
> +					return -ENODEV;

Hi Daniel,

Rather than returning, should this
jump to err_destroy_sgmii to avoid leaking resources?

Flagged by Smatch.

>  				}
> -				eth->phy_scratch_ring = res_sram->start;
> -			} else {
> -				eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
>  			}
>  		}
>  	}

