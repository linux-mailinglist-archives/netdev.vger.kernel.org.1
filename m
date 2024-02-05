Return-Path: <netdev+bounces-69014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DE849223
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 02:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5290E1F214BD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC565C;
	Mon,  5 Feb 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chZX0K/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26179CF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707095508; cv=none; b=lt5Ek1yBJPyzY13kIiqLBQSsuqYA5oBxBxpU1MdZ4HHVTig8S/X3eAtvrDrly9exkkzVgvy+/GdtvMuJT8PkNVl0mGLFJCB7J3M5cgDYfBpk9xH2+IuA2DKo5xUpLrTKuwprdiA0kZ+EdlhU/8AU5WTnX35mxcmLWBDc58Vx+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707095508; c=relaxed/simple;
	bh=6DCqONGrqjM5TKbQCZ3uCKjFrHig8JwTLbyuP98fuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRwJMVvZr3jm6xWRhsOfMDIe3cKUHhiyLdbRgjafukmENsYblJCsm+2nAL4Jsotm5GTKTRvNK2QIHModNpzQClTg1ainPIwFsAudskBuEQkVbzSqyxfyJaX5VSr4u9wg+dd1agqXtNwfiob7MKCiNTWKC9pwUnJmbrwchKyY/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chZX0K/U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5113303e664so3844078e87.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 17:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707095504; x=1707700304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QK+GVIRbtse7RLgJTZXdeDbEDM/jhe2IXWQlxDc9yFI=;
        b=chZX0K/UCVzR0znWJ+Angy9uPoVQ/ayHiZefQwHi6Lz0eD+ZoLlQ/orctv9CubGirL
         kfw+vDXsNP2Fo589ajiI9iqb2/Oa6AuOHkNpl07NSDvyYSROX0KeJv8q64Um8rwrCPY0
         8Rmip2swFA9wecUGueMeWl2lheXlgteu4o3hXK6B1U1Dzf93HVGcfNkPEN8vSM304SY4
         X5eooxgUUqyE8k5mXf+GjSIwbQxJG/uMdU1Ey/q7xPPX3cgajO6xy0KAonDHDtiB/wHj
         tWex2r55YDNlLxhEVl9VxJ1sYKAKfeq17Y9eaEgSn7y5DrCxsxRyd1mqSySG/nOcnSzM
         8q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707095504; x=1707700304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK+GVIRbtse7RLgJTZXdeDbEDM/jhe2IXWQlxDc9yFI=;
        b=cnfc3KsIHVmIcAMumku+12/98nwhx2NMWAccS8HYBk7lRWgSdLospNocdzP0KOUeOV
         MrKjkB2hNBbNTvA1r71rJDTUTOg03tzptxKRrclU4AVOkaE8c3/661pmnPzfkVmZFzGl
         3r71vBT4xDAW8qhWBaJsir5wLtsrRdrwv4JKrwaudc3E49UgOg6ndo6m1uygiOzFvxiz
         REougEuBWOYqvscu9oTYlAtXl0ZEbnP81R8DaAGOka1BFduICFjWqXa3/1hrN+j1jbqB
         PDUinLhEkM2Dk7zPjvtFXMVUDLvtY4z+e5Ag6hF9WxvdDGa/LYdOYfQaMpCskItLzIUI
         JIig==
X-Gm-Message-State: AOJu0YwyE4w60iQPKsiNuPuZ7ZtiRmaundeO5Tit/GvL7lb5SbVB5Igv
	m1pWkOT5MwFeqC5OYW2uzma+wh+bLJG7VQjvB86NR3esfBU0qQZZ
X-Google-Smtp-Source: AGHT+IHVnR5tRT0sUyMQbkwPSR5j5IzVg5Wo3qTm2AIsfD3vxxK9DyUNA7n3AfWqntlpZxct3w9rRA==
X-Received: by 2002:a05:6512:693:b0:511:467f:dbc7 with SMTP id t19-20020a056512069300b00511467fdbc7mr3647151lfe.36.1707095503966;
        Sun, 04 Feb 2024 17:11:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjBx/WxgB9pQonik9CmgT6Mrma5M5x9C/W+1V+Y7hOUkqeu7cY3laWd13hdYAas52qw0SS+NwwpGaPSuZ+gbYuryWv6WV++5JXHq8MEufJwEtgJ8RtXUDbI0jWaY97uOKj6dMix48VCnGTinWv1m+84wYasocdCmExmP3wtyh0mafouIeTC06Lueo9MaC7q72z+M3eeW5nTjPAr7YXyckcg9M3SGEUjJJU1y2m4t1O2p2IjyDvpbzXLaLqyu+HrAP6/9GLUoixsG9Y+mPvlmiX2eP66EWZjqgVEPTLorz88B9IoRRYtCJrSFLh1OSLOtfFOkA6P1t8nsVMEVcTKDxyj8KtQ7Cvwg1mys+Pk6zZrEeBST3A0bSIBo2Ly9fZux5HrUSOZw==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24842000000b005101ee22b84sm1053787lfy.1.2024.02.04.17.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 17:11:43 -0800 (PST)
Date: Mon, 5 Feb 2024 04:11:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Message-ID: <g5sbjl7hvmukmyg7bikveeyqeayw55xg6necamsvqlymtgobiz@jpdtl43gtqe6>
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
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 36 ++++++++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 19 +++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
>  6 files changed, 58 insertions(+), 39 deletions(-)
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index daf79cdbd3ec..5f7b82ad3ec2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -70,15 +70,18 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
>  
> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> +				       void __iomem *ioaddr,
> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_BUS_MODE);
> +	u32 value;
>  	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>  	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
>  
> -	/*
> -	 * Set the DMA PBL (Programmable Burst Length) mode.
> +	/* common channel control register config */
> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Set the DMA PBL (Programmable Burst Length) mode.
>  	 *
>  	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
>  	 * post 3.5 mode bit acts as 8*PBL.
> @@ -98,16 +101,15 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
>  	if (dma_cfg->mixed_burst)
>  		value |= DMA_BUS_MODE_MB;
>  
> -	if (atds)
> -		value |= DMA_BUS_MODE_ATDS;
> +	value |= DMA_BUS_MODE_ATDS;
>  
>  	if (dma_cfg->aal)
>  		value |= DMA_BUS_MODE_AAL;
>  
> -	writel(value, ioaddr + DMA_BUS_MODE);
> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
>  
>  	/* Mask interrupts by writing to CSR7 */
> -	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
> +	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
>  }
>  
>  static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
> @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>  				  dma_addr_t dma_rx_phy, u32 chan)
>  {
>  	/* RX descriptor base address list must be written into DMA CSR3 */
> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
>  }
>  
>  static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> @@ -125,7 +127,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>  				  dma_addr_t dma_tx_phy, u32 chan)
>  {
>  	/* TX descriptor base address list must be written into DMA CSR4 */
> -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
> +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
>  }
>  
>  static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
> @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  					    void __iomem *ioaddr, int mode,
>  					    u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>  
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable RX store and forward mode\n");
> @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  	/* Configure flow control based on rx fifo size */
>  	csr6 = dwmac1000_configure_fc(csr6, fifosz);
>  
> -	writel(csr6, ioaddr + DMA_CONTROL);
> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>  }
>  
>  static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>  					    void __iomem *ioaddr, int mode,
>  					    u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>  
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable TX store and forward mode\n");
> @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>  			csr6 |= DMA_CONTROL_TTC_256;
>  	}
>  
> -	writel(csr6, ioaddr + DMA_CONTROL);
> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>  }
>  
>  static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
> @@ -271,12 +273,12 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
>  static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
>  				  void __iomem *ioaddr, u32 riwt, u32 queue)
>  {
> -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
> +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
>  }
>  
>  const struct stmmac_dma_ops dwmac1000_dma_ops = {
>  	.reset = dwmac_dma_reset,
> -	.init = dwmac1000_dma_init,
> +	.init_chan = dwmac1000_dma_init_channel,
>  	.init_rx_chan = dwmac1000_dma_init_rx,
>  	.init_tx_chan = dwmac1000_dma_init_tx,
>  	.axi = dwmac1000_dma_axi,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 72672391675f..593be79c46e1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -148,11 +148,14 @@
>  					 DMA_STATUS_TI | \
>  					 DMA_STATUS_MSK_COMMON)
>  

> +/* Following DMA defines are chanels oriented */

One more time:
s/chanels/channels

> +#define DMA_CHAN_OFFSET			0x100

Once again:
DMA_CHAN_BASE_OFFSET? to be looking the same as in DW QoS Eth GMAC
v4.x/v5.x (dwmac4_dma.h).

Please be more attentive to the review notes.

-Serge(y)

> +
>  #define NUM_DWMAC100_DMA_REGS	9
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
>  
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			struct stmmac_extra_stats *x, u32 chan, u32 dir);
>  int dwmac_dma_reset(void __iomem *ioaddr);
>  
> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)
> +{
> +	return base + chan * DMA_CHAN_OFFSET;
> +}
> +
> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
> +
>  #endif /* __DWMAC_DMA_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 7907d62d3437..b37368137810 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> @@ -28,65 +28,65 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>  }
>  
>  /* CSR1 enables the transmit DMA to check for new descriptor */
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>  {
> -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
> +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>  }
>  
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx)
>  {
> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>  
>  	if (rx)
>  		value |= DMA_INTR_DEFAULT_RX;
>  	if (tx)
>  		value |= DMA_INTR_DEFAULT_TX;
>  
> -	writel(value, ioaddr + DMA_INTR_ENA);
> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>  }
>  
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			   u32 chan, bool rx, bool tx)
>  {
> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>  
>  	if (rx)
>  		value &= ~DMA_INTR_DEFAULT_RX;
>  	if (tx)
>  		value &= ~DMA_INTR_DEFAULT_TX;
>  
> -	writel(value, ioaddr + DMA_INTR_ENA);
> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>  }
>  
>  void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value |= DMA_CONTROL_ST;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value &= ~DMA_CONTROL_ST;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value |= DMA_CONTROL_SR;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value &= ~DMA_CONTROL_SR;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  #ifdef DWMAC_DMA_DEBUG
> @@ -166,7 +166,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>  	int ret = 0;
>  	/* read the status register (CSR5) */
> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>  
>  #ifdef DWMAC_DMA_DEBUG
>  	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> @@ -236,7 +236,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>  
>  	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>  
>  	return ret;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7be04b54738b..b0db38396171 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -198,7 +198,7 @@ struct stmmac_dma_ops {
>  	/* To track extra statistic (if supported) */
>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>  				  void __iomem *ioaddr);
> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> +	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       u32 chan, bool rx, bool tx);
>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b334eb16da23..5617b40abbe4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  				       true, priv->mode, true, true,
>  				       xdp_desc.len);
>  
> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  		xsk_tx_metadata_to_compl(meta,
>  					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> @@ -4706,7 +4706,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	stmmac_flush_tx_descriptors(priv, queue);
>  	stmmac_tx_timer_arm(priv, queue);
> @@ -4926,7 +4926,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>  	}
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
>  	tx_q->cur_tx = entry;
> -- 
> 2.31.4
> 

