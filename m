Return-Path: <netdev+bounces-112059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B075F934C22
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D488A1C20EE3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABE8061C;
	Thu, 18 Jul 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrCzCMPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DE639
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300564; cv=none; b=WE8Y47DQYxtUndFXJJ98DguYQu2fGkkqi3717Rpi1mmA6/g5YhQG0g88dr6Y/r+ZqKiRPUZ4nZw/RxuEsuPPnbhiRCFp3Y/SIWjT7BBp4TFS67Wt0JgbXtRtCMU7bq95lm1vgiV0TO2vp0UzCPMNFJrCTMVOcTzJqDwI7ZPmn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300564; c=relaxed/simple;
	bh=TaYB3LhIeyxOCzdc340ZrAaImiM6Bman/GrzG9WV5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxIfYJuixnosRbAKNhcJl3B+d9WO/J7uGc1juhamWMFPFScsna7VajWxEE849McfYn8EjkFDVHXnRMbCFNLjoYs5Iu04XzF5RY8LraeaOCisifaCQ5ZALNfBOhUFGpJuKCKOkCXiNjEXdTqzl9Ys7ls0J27Z5+KKYRIt4bLZkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrCzCMPr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af8062039so448797b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721300562; x=1721905362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAxo4Q6ToJBbiXHO1m9H9HC+/SI0nduLl/hFpjwgHTs=;
        b=jrCzCMPrI/MqIf6S8w51dVZf14F5O2CJGJZe0eB/KXlNujcrZzx6Q2zZin01b8Gn2R
         tqjQcFD8pwJQydFnBGY/JqkN+Tbe/m1/85j+3j95G1TE2O44oeWXXjqQTM0QfXyErUVr
         H/MgaPdpDAXiwjB4tJr6GAc9uEMVFWiWz4HHnUZUcQOfpDELfOWN9PmcRvHy49PNawHW
         IZcLGnEF0EWVGKR99SnKusaQSg7pe8ALRkJgR1onFK57PB85fWVzaphgzLTLsbtVwERa
         pl4xMfbjioWSNm4S5AaoUNWg7GIKMA1rhvI9oWZmbFL8isUlKTQXi9wHSGwHXYH9aAR/
         blDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721300562; x=1721905362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAxo4Q6ToJBbiXHO1m9H9HC+/SI0nduLl/hFpjwgHTs=;
        b=KAmCFVUaJubkkd3vK22Box9omIt+atimESSYSA7HtYm5BJv6lv+kmUVOfUSMtjgfFf
         VwMT64F3vmyELQHNJs/8Bt484nYY1NKT9623UI7wlcMBDZID23diHwpOuaW1enqddrrs
         2j4oV8HP+giJPXeem7lgCKVQc2AgQKf1ZUZ8v01rJQG+5NvS5Mj3NBTYupQ7KGa2e42K
         hRgNX1JgkTNwnd8oS3ZyZXiw+jXHrQssS2JWJCLcmml4H9N0/MHktwTXq5yX7ZGCjyLz
         egybVhQeXVqfghyOzLUNEg/wWJtt+xTRTgEKSvXODgmL4Fcyczko9keD1SJKQJAmlKHm
         C+bw==
X-Forwarded-Encrypted: i=1; AJvYcCU3dJbVzcGwaDg7ZLCTuxHdb7pAI2AA10JT5wZvMfeBb67Im9aol0K8nv1Y1Gzq3t13MhWOVSsiML5Kzfycnk3IhaNPyL5l
X-Gm-Message-State: AOJu0YwXEKRdvs766W9kYd04GOcB+q+YogSVdL+NcHBaZQoyWLWJIFyI
	hTuUJH1NpJMqgWAKai0cyEA7aWJ2SRyT+/nclUZxrAQHi9ZO5uE3
X-Google-Smtp-Source: AGHT+IE+NB6oo95AktU4NNKiwvlFNxYLR1CqZlJMeq3raDrrHE6Tt53JRi2AYfNXTJyXZQvwOHDPzw==
X-Received: by 2002:a05:6a20:1588:b0:1c0:e68a:9876 with SMTP id adf61e73a8af0-1c3fddffe3bmr5459197637.50.1721300561934;
        Thu, 18 Jul 2024 04:02:41 -0700 (PDT)
Received: from mobilestation ([176.15.242.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb69a6sm9730267b3a.62.2024.07.18.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:02:41 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:02:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 02/14] net: stmmac: Add multi-channel support
Message-ID: <qbedemdqhkyt2yjis6rqdszok4wzfyjy2fq6iovvp5jr3l5jw7@ptk6v3c7c6po>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <fdf3c921d443b7fbe49dc92b2233e889d2097b6c.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf3c921d443b7fbe49dc92b2233e889d2097b6c.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:34:09PM +0800, Yanteng Si wrote:
> DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
> enables transmission of time-sensitive traffic over bridged local area
> networks (DWC Ethernet QoS Product). In that case there can be up to two
> additional DMA-channels available with no Tx COE support (unless there is
> vendor-specific IP-core alterations). Each channel is implemented as a
> separate Control and Status register (CSR) for managing the transmit and
> receive functions, descriptor handling, and interrupt handling.
> 
> Add the multi-channels DW GMAC controllers support just by making sure the
> already implemented DMA-configs are performed on the per-channel basis.
> 
> Note the only currently known instance of the multi-channel DW GMAC
> IP-core is the LS2K2000 GNET controller, which has been released with the
> vendor-specific feature extension of having eight DMA-channels. The device
> support will be added in one of the following up commits.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Looking good now. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 32 ++++++++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 27 +++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 30 ++++++++---------
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++----
>  6 files changed, 68 insertions(+), 39 deletions(-)
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
> index 984b809105af..b3d7eff53b18 100644
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
> index 72672391675f..5d9c18f5bbf5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -22,6 +22,31 @@
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
> +#define DMA_CHAN_BUS_MODE(chan)	dma_chan_base_addr(DMA_BUS_MODE, chan)
> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	\
> +				dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
> +#define DMA_CHAN_RCV_POLL_DEMAND(chan)	\
> +				dma_chan_base_addr(DMA_RCV_POLL_DEMAND, chan)
> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	\
> +				dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
> +#define DMA_CHAN_TX_BASE_ADDR(chan)	\
> +				dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
> +#define DMA_CHAN_STATUS(chan)	dma_chan_base_addr(DMA_STATUS, chan)
> +#define DMA_CHAN_CONTROL(chan)	dma_chan_base_addr(DMA_CONTROL, chan)
> +#define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
> +#define DMA_CHAN_MISSED_FRAME_CTR(chan)	\
> +				dma_chan_base_addr(DMA_MISSED_FRAME_CTR, chan)
> +#define DMA_CHAN_RX_WATCHDOG(chan)	\
> +				dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
> +
>  /* SW Reset */
>  #define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
>  
> @@ -152,7 +177,7 @@
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
>  
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
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
> index dc6dbb6ce50a..b0bb9cdc335a 100644
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
> index 5aa0c776757d..ff62c3b7f03d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2367,9 +2367,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
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
> @@ -2553,7 +2555,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  				       true, priv->mode, true, true,
>  				       xdp_desc.len);
>  
> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  		xsk_tx_metadata_to_compl(meta,
>  					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> @@ -4753,7 +4755,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	stmmac_flush_tx_descriptors(priv, queue);
>  	stmmac_tx_timer_arm(priv, queue);
> @@ -4980,7 +4982,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
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

