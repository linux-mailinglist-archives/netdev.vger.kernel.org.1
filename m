Return-Path: <netdev+bounces-228710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12584BD2E43
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4091F189E054
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA222475CF;
	Mon, 13 Oct 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsAxw18d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9F1F582B;
	Mon, 13 Oct 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356919; cv=none; b=FYoJv8sLLDCFdXzKVuH/sSLfcBOYwuo5g0J1nwh6oW0t8wjoPOrVdvZVuHPrQEVhPcMGAfWrJkaQDBFjey0ESW/uJhjtkQ03iv7GHmmnFkiTObBvXdPI28H8k9irDtP+tZatxUi4MBJuLUR18aXfYYOVdwtdcm5wmz5YXSsuGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356919; c=relaxed/simple;
	bh=enYvefS/Tikr/Df0tXu3N3tbv+xh83SSpDgp+gSP1uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnPqRnbX8cY+vtOe8MtbgHzUK70jGYlheWVWnC8Gj632tmXSUpvTlIvvhRS1vdiVvxUxviDUnGZ1SMfMgH1qNR/9LSEIfiI8SoAJAt7zuHrKS/vOKjYgI/pu3oUEtVLEO1cgrYKKI3iPUMo3KIDJCUhKDV7jHCVnvgb6lbXh/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsAxw18d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BE4C4CEF8;
	Mon, 13 Oct 2025 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760356918;
	bh=enYvefS/Tikr/Df0tXu3N3tbv+xh83SSpDgp+gSP1uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsAxw18d3PhgxxvJaH7gROC84TX83T9iXdI0WW3ryh6GyGpvb2HybHDhYwaksZIIX
	 OZHcBEKDRss5TPORXs4HIusjwGIcokEs6oLikvf3cf8zE+5SSOEkdI4IZB5rVm64w2
	 I7yBw8baqbvGjLcIQUmuByGrjP3cGe6wcwDdn3ZrkvPMckqVMjHi59CMurDQtUn/Td
	 8nrb6KA1wUnJoPtYa2lJiSqKU+DJBneu4qjVETnFv/2X3/bU0UQfnfvjiCovDKOC0v
	 vGrMBaQ4CxRoBmEooLgLQ2uyj+ZsVUMqPaFxqd8qvZnTsxijPXBJ8CxyBHD26nBxHb
	 v+EdaYr1041hg==
Date: Mon, 13 Oct 2025 13:01:54 +0100
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix fdb hash size
 configuration
Message-ID: <aOzqMj1TbzJCZrRk@horms.kernel.org>
References: <20251013085925.1391999-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013085925.1391999-1-m-malladi@ti.com>

On Mon, Oct 13, 2025 at 02:29:25PM +0530, Meghana Malladi wrote:
> The ICSSG driver does the initial FDB configuration which
> includes setting the control registers. Other run time
> management like learning is managed by the PRU's. The default
> FDB hash size used by the firmware is 512 slots which is not
> aligned with the driver's configuration. Update the driver
> FDB config to fix it.
> 
> Fixes: abd5576b9c57f ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> Please refer trm [1] 6.4.14.12.17 section
> on how the FDB config register gets configured.
> 
> [1]: https://www.ti.com/lit/pdf/spruim2

Thanks for the link!
And thanks to TI for publishing this document.

> 
>  drivers/net/ethernet/ti/icssg/icssg_config.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index da53eb04b0a4..3f8237c17d09 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -66,6 +66,9 @@
>  #define FDB_GEN_CFG1		0x60
>  #define SMEM_VLAN_OFFSET	8
>  #define SMEM_VLAN_OFFSET_MASK	GENMASK(25, 8)
> +#define FDB_HASH_SIZE_MASK	GENMASK(6, 3)
> +#define FDB_HASH_SIZE_SHIFT	3
> +#define FDB_HASH_SIZE		3

I am slightly confused about this.

The patch description says "The default FDB hash size used by the firmware
is 512 slots which is not aligned with the driver's configuration."
And above FDB_HASH_SIZE is 3, which is the value that the driver will
now set hash size to.

But table 6-1404 (on page 4049) of [1] describes 3 as setting
the FDB hash size to 512 slots. I would have expected a different
value based on my understanding of the patch description.

>  
>  #define FDB_GEN_CFG2		0x64
>  #define FDB_VLAN_EN		BIT(6)
> @@ -463,6 +466,8 @@ void icssg_init_emac_mode(struct prueth *prueth)
>  	/* Set VLAN TABLE address base */
>  	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>  			   addr <<  SMEM_VLAN_OFFSET);
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
> +			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
>  	/* Set enable VLAN aware mode, and FDBs for all PRUs */
>  	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
>  	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
> @@ -484,6 +489,8 @@ void icssg_init_fw_offload_mode(struct prueth *prueth)
>  	/* Set VLAN TABLE address base */
>  	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>  			   addr <<  SMEM_VLAN_OFFSET);
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
> +			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
>  	/* Set enable VLAN aware mode, and FDBs for all PRUs */
>  	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
>  	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
> 
> base-commit: 68a052239fc4b351e961f698b824f7654a346091
> -- 
> 2.43.0
> 

