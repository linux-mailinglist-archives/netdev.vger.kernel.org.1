Return-Path: <netdev+bounces-68491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D35847055
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DD01F24673
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3CE145332;
	Fri,  2 Feb 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvrIHNkH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529018E11
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877041; cv=none; b=Aw4pf/y5hxY4xz4NJr685k0zp7TtjcIFqcrQ5hMjlLf1Ocz/4Qrln19yFU1wEaWPSL1Pvwxxf0H3n2MblJVrdCOZo3Sh5JD6hFfBOiwb7UoQN2uRjngK93e3ZEyniZB5MUsi5Oq0kYaEOjb5AVngEJKUoRVvA3hZWC9NUew2t6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877041; c=relaxed/simple;
	bh=UaAU9i93lDZWdhJaC6DSRimk9xF/tvH0/PSerlSbwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwHx88tJ0rZJ293Y7KsapFC7uZQSDKc24phhvT12DvmR5alDG4Vi7gu5i94BGIq76fcmSL4YgJzxvMpLg/b0wwJnwlnb99gsfTy29zRLvHLLc1dzA3FaSyvrwdL753u24WZAyS9v76xQNP8qtuy5LWXYJyaCmyOfAKl+gcXSEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvrIHNkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC2C433C7;
	Fri,  2 Feb 2024 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877040;
	bh=UaAU9i93lDZWdhJaC6DSRimk9xF/tvH0/PSerlSbwlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvrIHNkHwZa+B5APJfUFv21nIyFB0wd13fxP11z7031zFNQWBmQ5gA1EzQ5F8aUx1
	 2t8reyEXgYz+CcHMV7dYJi1u4AxkGCLDha3l81tjD6kwi5HslLgXTwEUnPrAoCyo+p
	 7KkH209fLq0vY96M42fhA6aGTi82zyXq9fpQg20rrm9J02Vw/rYzwK4dV5/BmFX5uH
	 /bNBMYp78JBGwVBGe3lfLIklVjkJc9kI5fNV0U//f0C+xrgrDM27kNHXvErvyLG6lr
	 KiITpEUj28vJnQp+q66YjjTwhOr1/WykyCTIn+tXru6YXzU6vpfA2zbWyI2x7TFdCO
	 +CetxYblRT5Cg==
Date: Fri, 2 Feb 2024 13:30:34 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Message-ID: <20240202123034.GO530335@kernel.org>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:43:21PM +0800, Yanteng Si wrote:
> DW GMAC v3.x multi-channels feature is implemented as multiple
> sets of the same CSRs. Here is only preliminary support, it will
> be useful for the driver further evolution and for the users
> having multi-channel DWGMAC v3.x devices.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>

...

> @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>  				  dma_addr_t dma_rx_phy, u32 chan)
>  {
>  	/* RX descriptor base address list must be written into DMA CSR3 */
> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));

nit: Networking code (still) prefers code to be 80 columns wide or less.


Please consider running checkpatch as it is run by the CI.

https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch/checkpatch.sh

>  }
>  
>  static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,


...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 72672391675f..593be79c46e1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -148,11 +148,14 @@
>  					 DMA_STATUS_TI | \
>  					 DMA_STATUS_MSK_COMMON)
>  
> +/* Following DMA defines are chanels oriented */

nit: channels

FWIIW, checkpatch also has a --codespell option which can be used to flag
spelling errors.

...

