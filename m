Return-Path: <netdev+bounces-93126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3D8BA2F3
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E106A1C20C81
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FAA57C92;
	Thu,  2 May 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAsjtEFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913D57C81
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687350; cv=none; b=ILTdtInHJns4SAijcYH8evAtHBQHPIws2Gfb1nudU8scm/PfL8ZctG2hMYxErTJQuEK+z6btWoYYsPE0Ji6v/uGV/YWBNgJoZqurC01MgUdqCXApUaDQ7Jffjf2nlD7FS+4sozKnRTtMylHidvaKvmOCVwR80SkIQFqt5QiyHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687350; c=relaxed/simple;
	bh=Y+9p0c88l6zDkfly2hsc9ywRoZj4RWQpfBQ0UhZjq2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ49T1IiykGxblfh37D7VxpxNE63yFSZgYXlSuWODdNx3cotBUQNJAsHdmUOHdNtLIlWgEeLk/t0zGiTMmCB/1+UwNwXhbD5KUdtmU71sgPNkoybysdVe6Ibvu83KEpZcIG0Jr6xe+2zALUluT8s0avVi1I1H+3jGd+cRB6hiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAsjtEFw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f60817e34so908724e87.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714687347; x=1715292147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSSR3uvqF46P3lGQKY6lcTqogolqtGc9plYC4Sfz2jo=;
        b=QAsjtEFwzbp5todey4bCFYdISJZf2YTU4+uVbQzbx3JBtOGLvXDUrJ5Hp64LyyASrQ
         LO/GyJCNfcBKLvopQU+V5ZevpOvxH0n1/DzC41dJtb/X8Jdy4jHaBVxmrVDtdkkPPnWy
         LGh5OrnxCFnPXYPKlLKYo062Dlc5OKQ8NA6cTwyNOXATu0soVexdzFQtFXfQEFGRTo4n
         /R2mhrv9NuEPAqZDfdjPwPMuN8Rl1q4AXFaYVcIjVy+PO7SBY4+zDecX8xfB47PSndPw
         DUCaUCwf4wsCd9Ioy0ncdNF2nrbz88dO+Q5RhH3vnSJwHzFqSaDmxoyVzIIoDi+7ung/
         Pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714687347; x=1715292147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSSR3uvqF46P3lGQKY6lcTqogolqtGc9plYC4Sfz2jo=;
        b=Aj3ZzNW9IVtE8jZNupAvZOY6SW/cbMCqTxMyyMZmBksVwSDdTbFpMb8n783RdHgbPa
         I/M9+/Zxtm3d1ggFWtrp05GiCfE8Zw2bJLZD90kQ+iy8Zq6FnGChMA10MJsw/JJuF7ay
         N/OidPgI65G2HgX3ixCtoSgyo9DxwTrpWN2N/9SKir1gu52Mqhk7wgX3SNWkrdNe1a2g
         KM23c/PcS9XICCykaHui0JrQ0XZsrC6/JezcXh8WnSor/SdRmYfrCFrMCDgsmYG11Bse
         INosU0tAUJezGHIi37P86T+g6i/rzMu3qutiK3IlENF35mXbfnFXF0zo0vQJGJUndo1w
         PSRA==
X-Forwarded-Encrypted: i=1; AJvYcCVYtBHL3tVqkrm+s39VbErwYzQjxZ/UTQcFQIaJuoWYvTdUYeNa1LNSd8TSLQIWHhACATklDfhrRpX8+zRwxOvoCSwhEWgL
X-Gm-Message-State: AOJu0Yxw9AVeb/CWrXbGKZWf4uV6lUgj/pqAC6LuETWADIfaKGFwe4rQ
	8nMQquYswBooYohKKcvPIQMYwxVzGksLxD1C+oBsfmDd0OOAXuSz3tbsKQ==
X-Google-Smtp-Source: AGHT+IG3Kv94uINqDDDESIsSYabe8VsBKe64L8GINvFEL+l8tfdQewV+PXCzk5r/25PX3Rl5jAIfLg==
X-Received: by 2002:a05:6512:3b87:b0:51e:f68b:d266 with SMTP id g7-20020a0565123b8700b0051ef68bd266mr878429lfv.50.1714687346850;
        Thu, 02 May 2024 15:02:26 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id d9-20020a196b09000000b0051f03ad2093sm318299lfa.280.2024.05.02.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:02:26 -0700 (PDT)
Date: Fri, 3 May 2024 01:02:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 02/15] net: stmmac: Add multi-channel support
Message-ID: <zbs5vkzyuoyte5mr2pprf7xxahhuxlinvxe24h4oc6jeshwii5@ivqr45z27ef4>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <5409facf916c0123e39a913c8342cc0ce8ed93db.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5409facf916c0123e39a913c8342cc0ce8ed93db.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:01:55PM +0800, Yanteng Si wrote:
> DW GMAC v3.x multi-channels feature is implemented as multiple
> sets of the same CSRs. Here is only preliminary support, it will
> be useful for the driver further evolution and for the users
> having multi-channel DWGMAC v3.x devices.

Why do you call it "preliminary"? AFAICS it's a fully functional
support with no restrictions. Am I wrong?

I would reformulate the commit message as:

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
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
>  6 files changed, 55 insertions(+), 37 deletions(-)
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

Just figured out that besides of the channel-related changes you also need
to have the stmmac_dma_operation_mode() method fixed. So one wouldn't
redistribute the detected Tx/Rx FIFO between the channels. Each DW GMAC
channel has separate FIFO of the same size. The databook explicitly says
about that:

"The Tx FIFO size of all selected Transmit channels is always same.
Similarly, the Rx FIFO size of all selected Receive channels is same.
These channels cannot be of different sizes."

-Serge(y)

> [...] 

