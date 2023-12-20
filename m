Return-Path: <netdev+bounces-59263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8A81A1D7
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AF1C20C8D
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD83DB9C;
	Wed, 20 Dec 2023 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GldJfvYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2A3FB04
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829DC433C8;
	Wed, 20 Dec 2023 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703084934;
	bh=LyOF3M995Rdu4eqFMThvs28tuauoK4Tc2ZQnpozOGGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GldJfvYovXFW6y9cNgA0FMsMjdIXGH3d7bVLW1L3sYDPtxnuSr181b/CTipnTY5nn
	 QASOviQ93CIlK3aQMY6HyC041sR3R//un0wgd3FZRsG1T9mdgm9lHYOzXIQfq9g7QY
	 BTjmgEpU033gEZrgc2CIBKX9gjEp7gswrNmWy4h9hGcbrBF8Yh6ePJ0998DHbDcPVe
	 wn23Ow+YKCV1G0Ilp3yve74AML6j36A+TBgvgYUDGaRuPpaz+X356u18i320eUoQJr
	 GE4z5lCEuxmdJCxyZLABJdpBZKJqvfncD88OoqveuZVbkZXnyihRwJ4LsjFXI5dUHC
	 68n8WRszMTehw==
Date: Wed, 20 Dec 2023 16:08:46 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 1/9] net: stmmac: Pass stmmac_priv and chan
 in some callbacks
Message-ID: <20231220150846.GL882741@kernel.org>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>

On Tue, Dec 19, 2023 at 10:17:04PM +0800, Yanteng Si wrote:
> Loongson GMAC and GNET have some special features. To prepare for that,
> pass stmmac_priv and chan to more callbacks, and adjust the callbacks
> accordingly.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     |  3 ++-
>  drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     |  3 ++-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h          | 11 ++++++-----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 +++---
>  9 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 137741b94122..7cdfa0bdb93a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>  	writel(v, ioaddr + EMAC_TX_CTL1);
>  }
>  
> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>  {
>  	u32 v;
>  

Hi Yanteng Si,

perhaps dwmac-sun8i.c needs to be further updated for this change?

  .../dwmac-sun8i.c:568:10: error: incompatible function pointer types initializing 'void (*)(struct stmmac_priv *, void *, struct stmmac_dma_cfg *, int)' with an expression of type 'void (void *, struct stmmac_dma_cfg *, int)' [-Wincompatible-function-pointer-types]
    568 |         .init = sun8i_dwmac_dma_init,
        |                 ^~~~~~~~~~~~~~~~~~~~
  .../dwmac-sun8i.c:574:29: error: incompatible function pointer types initializing 'void (*)(struct stmmac_priv *, void *, u32)' (aka 'void (*)(struct stmmac_priv *, void *, unsigned int)') with an expression of type 'void (void *, u32)' (aka 'void (void *, unsigned int)') [-Wincompatible-function-pointer-types]
    574 |         .enable_dma_transmission = sun8i_dwmac_enable_dma_transmission,
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  2 errors generated.

