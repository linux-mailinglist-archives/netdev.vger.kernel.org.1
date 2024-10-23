Return-Path: <netdev+bounces-138189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7252D9AC89C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFBAB22EEC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8F1AB530;
	Wed, 23 Oct 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3nkyUXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D521AB521;
	Wed, 23 Oct 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681664; cv=none; b=DSxxhzJyxeMiawJ/bsmiqagkECaJ7eg/PmclYwiOBGncPEJHxMI2K8uScEnlVENeCyIOxnkKLMwVsqGg4M4gnYAZOotcL+pm7Ml46G6NLXtFG93vAL0E/emO1NTAPy8NNrmqFLS/qdg0FMV9NemhJ+dGtk4C5UabVJB0lE8cd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681664; c=relaxed/simple;
	bh=lVH6MnxKITbbLVTwdZBysRiSQtubnhnYeW4+iV/DjdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cahPAeM3/0uQZ4NZrQyHk8qf45uABT2Dphc+R7f/Aki1dCybOfzEMc+boqtB8AdDZ7K+SIFeYEYvlzXHgfHfT9WXnkIkEHF4tpxDLsk3bVDSvTTIm0/Bda5miNY/NT605KALEcCyU45PVivXANbDR8AJEybouBoUPA8MxXczkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3nkyUXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF01C4CEC6;
	Wed, 23 Oct 2024 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729681663;
	bh=lVH6MnxKITbbLVTwdZBysRiSQtubnhnYeW4+iV/DjdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3nkyUXpCIUw60Ut1ahkxfsb6ko2wlwoKm8v7ip68Yc9G/pNXB9f5GYPYI+nxDgJB
	 Myycd0ohPbxwgWoYNYuiTI6HXwa7kUnO0MXVz8kx6NiOk3q2xTNv6XfqYEWU/nIhzA
	 KwjW+P0DjmO0t00/ja5zTvi+NyD0WXlygeRP9noMs171EY/zM5p0u/zctG9N4qZfSa
	 oCIt4meSaexNvxxqb5cwZZUUydunkS2Iyn7ue/56NR2hCE++w2kuOdnFZC43Gkfsst
	 WXxWPh+Z8hP0tBFaP9UPc/OcR7IZXPqSgs5xSsg8RABN9bfysnxqJ7vs8tighnobeW
	 JQkCZmiwbttlw==
Date: Wed, 23 Oct 2024 12:07:38 +0100
From: Simon Horman <horms@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com, Corentin Labbe <clabbe.montjoie@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net v3] net: stmmac: dwmac4: Fix high address display by
 updating reg_space[] from register values
Message-ID: <20241023110738.GM402847@kernel.org>
References: <20241021054625.1791965-1-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021054625.1791965-1-leyfoon.tan@starfivetech.com>

+ Corentin, Giuseppe, Maxime, Andrew, linux-arm-kernel, linux-stm32

  As per output of get_maintainers.pl FILE.patch
  Please consider doing likewise in future.

On Mon, Oct 21, 2024 at 01:46:25PM +0800, Ley Foon Tan wrote:
> The high address will display as 0 if the driver does not set the
> reg_space[]. To fix this, read the high address registers and
> update the reg_space[] accordingly.
> 
> Fixes: fbf68229ffe7 ("net: stmmac: unify registers dumps methods")
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
> - Split the patch series to net and net-next. Submit this patch for net.
> - Rebased to net https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> 
> v2: https://patchwork.kernel.org/project/netdevbpf/cover/20241016031832.3701260-1-leyfoon.tan@starfivetech.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 8 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index e0165358c4ac..77b35abc6f6f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -203,8 +203,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
>  		readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_RX_CONTROL(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, channel));
> +	reg_space[DMA_CHAN_TX_BASE_ADDR_HI(default_addrs, channel) / 4] =
> +		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR_HI(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_TX_BASE_ADDR(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_TX_BASE_ADDR(dwmac4_addrs, channel));
> +	reg_space[DMA_CHAN_RX_BASE_ADDR_HI(default_addrs, channel) / 4] =
> +		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR_HI(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_RX_BASE_ADDR(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_RX_BASE_ADDR(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_TX_END_ADDR(default_addrs, channel) / 4] =
> @@ -225,8 +229,12 @@ static void _dwmac4_dump_dma_regs(struct stmmac_priv *priv,
>  		readl(ioaddr + DMA_CHAN_CUR_TX_DESC(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_CUR_RX_DESC(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_CUR_RX_DESC(dwmac4_addrs, channel));
> +	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR_HI(default_addrs, channel) / 4] =
> +		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR_HI(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_CUR_TX_BUF_ADDR(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_CUR_TX_BUF_ADDR(dwmac4_addrs, channel));
> +	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR_HI(default_addrs, channel) / 4] =
> +		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR_HI(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_CUR_RX_BUF_ADDR(default_addrs, channel) / 4] =
>  		readl(ioaddr + DMA_CHAN_CUR_RX_BUF_ADDR(dwmac4_addrs, channel));
>  	reg_space[DMA_CHAN_STATUS(default_addrs, channel) / 4] =
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 17d9120db5fe..4f980dcd3958 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -127,7 +127,9 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  #define DMA_CHAN_SLOT_CTRL_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x3c)
>  #define DMA_CHAN_CUR_TX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x44)
>  #define DMA_CHAN_CUR_RX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4c)
> +#define DMA_CHAN_CUR_TX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x50)
>  #define DMA_CHAN_CUR_TX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x54)
> +#define DMA_CHAN_CUR_RX_BUF_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x58)
>  #define DMA_CHAN_CUR_RX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x5c)
>  #define DMA_CHAN_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x60)
>  
> -- 
> 2.34.1
> 
> 

