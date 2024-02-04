Return-Path: <netdev+bounces-68999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEA8491A7
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360741F21DB6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA300BE5A;
	Sun,  4 Feb 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y++owWb/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2972C122
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089314; cv=none; b=enjGwRJDrH4ZCAtV2Fgj10KByR4wvLM5UfJCNt7gGwUZCIq5cBvZrPxCiaYd5TCiv5rD7PK2e6kJ7mYfhwAHkKRxZCYpJwFygLIrSKWJ1DUwY350peRxMovUkR8CKhhqOIgTB3M5dVxMlhz+KncwEcME63EHhVuewlmFj2wi0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089314; c=relaxed/simple;
	bh=M9ywaHbalSoKkZabB796b4jVNcTdCfQc4rf9DtdVuVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBcE7xOAEa2wJQAsP23RBfByOR6qKTxSxDpZ9MdIG8c1di7tvbFEp0tFj0mHgBuToo2vBU0a+2gWibsVeVRT5FDszWGccAk1qyl71XuvnyP71+Wa/+HWahrksUe5Z1BcYWV+5g9lRGS0alPoxOSCRUOWMnr3E4Rp4l+eulM1GCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y++owWb/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5113a97a565so2837879e87.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 15:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089311; x=1707694111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc01QFnFpyfplvlDEErpT/xTTXou1X9ADdcQPxDXnPM=;
        b=Y++owWb/lvwslxV9EEY/c2twjzMGrr9zOdYGpxuIQ9FdTVTEUDfcR2R/brR6hfzwgY
         h1hGD+u5OaTo0RBe/8IGUzrAlEQhwGILWeAdb9/xFlsSuB0HFqnqrJ3gplnDz1/n35y7
         zPZE/jaUkSBugGh5wBmqxxsrzad+slWHc00dQkkknyMgWlhP2gPLGTdZTgoizZrD3anI
         0+YyGmEyFYIy/Z7q9CrAtRcZ9KdoQxTZHMWzjEYHEtLK7CS1jWO3lPPEmRfbvV1TXAmq
         jkP6ApQFU1TCIDz+ctukTYzOoYmwB00Uzho4weNFo0xP9+EG38xL/KFsNDSXZkUnj0On
         shwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089311; x=1707694111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc01QFnFpyfplvlDEErpT/xTTXou1X9ADdcQPxDXnPM=;
        b=N1mPJeL8NmIraOeLYeDN2+2GZm+hXk3LLi8gvBr1VYIHhvfElLITXQnpuuOy45vcJ5
         Jn1K34/52aWl4YSRhswpfa/b53d3RdPH1z1qgCSBQ7npfIfQfzKiavnZh9Xa5ofeBsL0
         M1YlzYjcKnAZ3AArpeaEML8H4MaFiqcbg0G+9CRa8lo1bZuYicVKakJdNkcfEqaVzFiK
         EdZExf/WP7Pn0i4X81NvTWZrD1MazTYcYy/NsdTwtWErnc/zXj8WOcB1avTqUXXy8zYG
         wCnJUC67hn1BE+mcMouduA55rHI3fkrza7Z/G/iMXu31AhF5Ck+cTeX8x/tAz4jUjgpg
         TUxA==
X-Gm-Message-State: AOJu0YzvLhtUpzk9VqXioIAgQdNRguIHTl3Tl3cNmdkgpMfKao4/j66u
	arv1hWJtqKD3znkkAxl057rN+8mEPN+m+hjnGH/RZyKmgn3LbV1P
X-Google-Smtp-Source: AGHT+IExYnqYwi8XuqGUyWfj+QSTrqWxf1CA8R6NSlDyLSYX+xsDyvlPiRZVlW8jEsdi6oXp6blHXg==
X-Received: by 2002:a05:6512:11ed:b0:511:297f:2732 with SMTP id p13-20020a05651211ed00b00511297f2732mr7055909lfs.31.1707089310388;
        Sun, 04 Feb 2024 15:28:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaBL6JxgsZ4JIg2OMKyVBF70KRqFPnojdHZ6t1PLQX3nHh5L06psxnk/FUoMzUaazsfHmyEUnVMVk86Y+fc/IkU0UOwTXcRzzRjy5ABZDPOFuYED/wITWn1Eu9zACidpJ38YgHERC6vcuO3grsfwhMhlYbYredBW+AUHN/cWsiGNy72xR0EcBjcvAPkq0YfpBrjAsqe8c91++iu3UY2R3MmwydxiAASy/up29GsjPiPAG4+4HH1WEa9J/iP2IzkTRGPVB2X0zPX0xjMnkja2rlAiZDM7ZI0l5h6Q+70/1d9CvgS691DwAtFdRH7ckYPaWZFn8WwaOkEqWJrL+xIfJp6+C9t+MAlr1p82U0JPlZ8ICvrOVT2X1R1pG7SxBF6U4K3U3iXQ==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id f38-20020a0565123b2600b005115317395dsm22871lfv.7.2024.02.04.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:28:29 -0800 (PST)
Date: Mon, 5 Feb 2024 02:28:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Message-ID: <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
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

Reverse xmas tree please.

>  
> -	/*
> -	 * Set the DMA PBL (Programmable Burst Length) mode.

> +	/* common channel control register config */

Redundant comment. Please drop.

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

No, just convert the stmmac_dma_ops.dma_init_channel() to accepting
the atds flag as I suggested in v7:
https://lore.kernel.org/netdev/vxcfrxtbfu4pya56m22icnizsyjzqqha5blzb7zpexqcur56uh@uv6vsjf77npa/

In order to simplify this patch you can provide the
stmmac_dma_ops.dma_init_channel() and
stmmac_dma_ops.enable_dma_transmission() prototype updates in a
pre-requisite/preparation patch.

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

> +/* Following DMA defines are chanels oriented */    \
> +#define DMA_CHAN_OFFSET			0x100   |-------------+
> +                                                    /              |
                                                                      |
Please move all of these ---------------------------------------------+-------------------------+
to being defined just below the DMA_MISSED_FRAME_CTR macros definition.                         |
The point is to keep a coherency between dwmac_dma.h and dwmac4_dma.h.                          |
The later header file has first generic DMA-related macros defined                              |
(CSR addresses and flags) and then the channel-specific ones (CSR                               |
addresses and flags). Since in case of the DW GMAC v3.x the                                     |
multi-channels are implemented as a copy of all the DMA CSRs let's                              |
preserve the logic of having all CSR address defined first, then the                            |
CSR flags.                                                                                      |
                                                                                                |
>  #define NUM_DWMAC100_DMA_REGS	9                                                       |
>  #define NUM_DWMAC1000_DMA_REGS	23                                                      |
>  #define NUM_DWMAC4_DMA_REGS	27                                                              |
>                                                                                               |
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);                                    |
> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);                          |
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                    |
>  			  u32 chan, bool rx, bool tx);                                          |
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                   |
> @@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,  |
>  			struct stmmac_extra_stats *x, u32 chan, u32 dir);                       |
>  int dwmac_dma_reset(void __iomem *ioaddr);                                                   |
>                                                                                               |
                                                                                                |
> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)                                  \  |
> +{                                                                                          | |
> +	return base + chan * DMA_CHAN_OFFSET;                                                 | |
> +}                                                                                          | |
> +                                                                                           | |
> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan) | |
> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)        | |
> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)         | |
> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)          |-+
> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)        |
> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)           |
> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)            |
> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)             |
> +                                                                                           /

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

Isn't the mask change going to be implemented in the framework of the
Loongson-specific DMA-interrupt handler in some of the further patches?


I'll get back to reviewing the series tomorrow (later today)...

-Serge(y)

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

