Return-Path: <netdev+bounces-103608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F7908C7E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DFE28A19F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2D63B;
	Fri, 14 Jun 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmC/5q0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374F17D2
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371888; cv=none; b=TlQguiilpNZCwThWrrp4m+7yZ7Hu55mdjdfX3AdI2hMS4ILkBYbsUr13Twkl5nwF7gFW2dx305wd8LJ51Eb8tnxWrjCRx/gGZm/+t0k5PnRcXRk+HDRDZV72a6WOCQbJZ6VGt0vC+sVC+9DREBqWfn5vSXp4IlyZxCi132jBw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371888; c=relaxed/simple;
	bh=it62vQX57boSAMMVFKKGm+Q4ILzNle+Aw2AfmrE7gcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUeZhAP3z+hpNwSqNMlHwTnsTGvNnhIFb8s6mF2vQfda4Bnd+UzJHSJu9hmgwbsaGy1kMJMH+IM7SY1xyRfuIenBVhUdsMavp/GT9rGOtAR+tNzkC6psPWY5PrH/Y0+7OdYij+MMsTabsa6GuYecm2vcEmng7GD/5ldQPZ+YQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmC/5q0g; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso35624371fa.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718371884; x=1718976684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8cNtJ0KAG7AoCM0lxu+9LqGYW69eFGTTDu4sYYR7Ys=;
        b=bmC/5q0gTQa/UjgaAHBEYVh3MXzxIjGN2CmF/nLYCh2M5/Qi0DbzOz6A1FE1jTe/sU
         2LSyfGHoyC45SeYengoVb3XEzF5x+NZrHglq/UKepGwt3yEDbxdotfUwFlpnPQ5mjEjD
         Cg803Tae9i9VtCgk3J+FzBqNKQFMHNEW8picy5mALNnw1CBzmPvhO+iqCN9C3jdoEv2l
         XUtpwY4+0oyKpoPeRj9bYMDgsFOwVj83Zsbxbp4fPpxTLAh63Or2Gyk9svy7oiocotSJ
         6UTmzLvzKZxy6D0HpkPXKQ8bDV/KSL3xcfDu27AcgaA0ypZB4e5GykF5mrPg81PcOgfq
         dA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718371884; x=1718976684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8cNtJ0KAG7AoCM0lxu+9LqGYW69eFGTTDu4sYYR7Ys=;
        b=NYlSYjsFLMeam1RW+dXBnncj1ABBCyT4CzjGyIh3BbQdq+HEyM08yvee8W4JM7eYWa
         tWb61IvESnfBn2ncI90SI5sdOQrJ7Q0icJM0nBoML5dslMwvB4Rs6q+099JGzJJHCRVN
         gLff54XSioplDCf96aLCBM1wxg0ETGCPapStRBDNFKC5TYvUtY7+K6yFLlA7pdkPccik
         tmWfWYRYUTRRdctLp7z2xOTME91DrRvbsOVblFG19QHnvHmKkwJwCLggIDxqoH9J0urV
         aVaEx4MZcRPnwfI6eCONIcYY1jAHyvIXoh5z+1RxMHXZnIQdOLIfB2zzTHRoncT96Zlw
         nGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeUFJa8DhZDtepjswU051vy44lNPrRMs9c8Y0P4kn+pDuEMX7hOELqguuz01feMKBgP1h3o/wWjNswgvUplEa1iEMvQVED
X-Gm-Message-State: AOJu0YxLYCNgmqB8waR/gPbQrtegWIXeNX8sQ425dxIJKblHqHZsU+yU
	zkaNpinc7XzjtcZVtMoXR7u5yf1d6vyixUqn5bcwuV/MOgVq9Ytw
X-Google-Smtp-Source: AGHT+IH5bGJmHo6XG1RqtGjED13vixzWP1Ir+X6Jz/jBmZdz8PWTgDsIwVjSoZx+ktWMD8lwMSGbdQ==
X-Received: by 2002:a2e:8099:0:b0:2eb:dced:71aa with SMTP id 38308e7fff4ca-2ec0e4826e6mr21094901fa.15.1718371883694;
        Fri, 14 Jun 2024 06:31:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c99e96sm5390391fa.128.2024.06.14.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:31:23 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:31:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 02/15] net: stmmac: Add multi-channel support
Message-ID: <s2nglkzifuhqwfop5ztdaep3cag23s4z2re3s7wvmnf6vkuidi@jnywporyoay7>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b4ab0f87284b5f2b0f03961b76878dcc000830c2.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ab0f87284b5f2b0f03961b76878dcc000830c2.1716973237.git.siyanteng@loongson.cn>

Hi Yanteng

On Wed, May 29, 2024 at 06:18:18PM +0800, Yanteng Si wrote:
> DW GMAC v3.x multi-channels feature is implemented as multiple
> sets of the same CSRs. Here is only preliminary support, it will
> be useful for the driver further evolution and for the users
> having multi-channel DWGMAC v3.x devices.

Why haven't you picked up the commit log suggested on v12? It has more
details about the feature and the change context. Please use it:

"DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
enables transmission of time-sensitive traffic over bridged local area
networks (DWC Ethernet QoS Product). In that case there can be up to two
additional DMA-channels available with no Tx COE support (unless there is
vendor-specific IP-core alterations). Each channel is implemented as a
separate Control and Status register (CSR) for managing the transmit and
receive functions, descriptor handling, and interrupt handling.

Add the multi-channels DW GMAC controllers support just by making sure the
already implemented DMA-configs are performed on the per-channel basis.

Note the only currently known instance of the multi-channel DW GMAC
IP-core is the LS2K2000 GNET controller, which has been released with the
vendor-specific feature extension of having eight DMA-channels. The device
support will be added in one of the following up commits."

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 32 ++++++++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 20 ++++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 30 ++++++++---------
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++----
>  6 files changed, 60 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index d87079016952..cc93f73a380e 100644
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
> index bb82ee9b855f..f161ec9ac490 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
>  
> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> -			       struct stmmac_dma_cfg *dma_cfg)
> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> +				       void __iomem *ioaddr,
> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_BUS_MODE);
>  	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>  	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> +	u32 value;
>  
> -	/*
> -	 * Set the DMA PBL (Programmable Burst Length) mode.
> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Set the DMA PBL (Programmable Burst Length) mode.
>  	 *
>  	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
>  	 * post 3.5 mode bit acts as 8*PBL.
> @@ -104,10 +106,10 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
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
> index 72672391675f..363a85469594 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -22,6 +22,23 @@
>  #define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
>  #define DMA_MISSED_FRAME_CTR	0x00001020	/* Missed Frame Counter */
>  
> +/* Following DMA defines are channels oriented */
> +#define DMA_CHAN_BASE_OFFSET			0x100
> +
> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)
> +{
> +	return base + chan * DMA_CHAN_BASE_OFFSET;
> +}
> +

> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
> +#define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
> +#define DMA_CHAN_BUS_MODE(chan)	dma_chan_base_addr(DMA_BUS_MODE, chan)
> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
> +

Please re-define the macros in the address ascending order:
DMA_CHAN_BUS_MODE()
DMA_CHAN_XMT_POLL_DEMAND()
DMA_CHAN_RCV_POLL_DEMAND()
DMA_CHAN_RCV_BASE_ADDR()
DMA_CHAN_TX_BASE_ADDR()
DMA_CHAN_STATUS()
DMA_CHAN_CONTROL()
DMA_CHAN_INTR_ENA()
DMA_CHAN_MISSED_FRAME_CTR()
DMA_CHAN_RX_WATCHDOG()

* Please don't forget DMA_CHAN_RCV_POLL_DEMAND() and
DMA_CHAN_MISSED_FRAME_CTR() macros you've missed in your patch.

>  /* SW Reset */
>  #define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
>  
> @@ -152,7 +169,7 @@
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
>  
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -168,5 +185,4 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			struct stmmac_extra_stats *x, u32 chan, u32 dir);
>  int dwmac_dma_reset(void __iomem *ioaddr);

> -

What has been wrong with this empty line so you decided to remove it?)

-Serge(y) 

>  #endif /* __DWMAC_DMA_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 85e18f9a22f9..4846bf49c576 100644
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
> @@ -165,7 +165,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
>  	int ret = 0;
>  	/* read the status register (CSR5) */
> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>  
>  #ifdef DWMAC_DMA_DEBUG
>  	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 413441eb6ea0..d807ee4b066e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -197,7 +197,7 @@ struct stmmac_dma_ops {
>  	/* To track extra statistic (if supported) */
>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>  				  void __iomem *ioaddr);
> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> +	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       u32 chan, bool rx, bool tx);
>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 99da314508c3..0eef95c15cd0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2370,9 +2370,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>  	if (txfifosz == 0)
>  		txfifosz = priv->dma_cap.tx_fifo_size;
>  
> -	/* Adjust for real per queue fifo size */
> -	rxfifosz /= rx_channels_count;
> -	txfifosz /= tx_channels_count;
> +	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
> +	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
> +		rxfifosz /= rx_channels_count;
> +		txfifosz /= tx_channels_count;
> +	}
>  
>  	if (priv->plat->force_thresh_dma_mode) {
>  		txmode = tc;
> @@ -2556,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  				       true, priv->mode, true, true,
>  				       xdp_desc.len);
>  
> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  		xsk_tx_metadata_to_compl(meta,
>  					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> @@ -4752,7 +4754,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	stmmac_flush_tx_descriptors(priv, queue);
>  	stmmac_tx_timer_arm(priv, queue);
> @@ -4979,7 +4981,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		u64_stats_update_end(&txq_stats->q_syncp);
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

