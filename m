Return-Path: <netdev+bounces-89132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD2D8A9819
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9163428315A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9B15E1FF;
	Thu, 18 Apr 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3YJNmzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E515E7E7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438144; cv=none; b=DVNuWXFp6kSJf6Zyca9Urwxoc8lGbqKB5Si7Ws6dZu6es8IGm1VMZOv+wpiLHg7GNOC3yNp0gUFnFS4IHLO7CwOJXF8YWRA2QgjlY8JcntjUzGfPWzk3OIK4MPmzYPTMlkMNrJTDTpPC0kvrPawrmrhd02yV2xPVIQP54Hpvgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438144; c=relaxed/simple;
	bh=iT1Cx9NWao1mwMNKWpDOZtMRW2vJlOL5P5/5bBe9AyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/i1pndEMLrn97FEvhsdI4/QaAqF0aFqu0jb5bdzhpqqJLM/47jqYS3/xB1nz8MHJGx7uuPtumumRNd2Wb5lxk2d0DM9RC9W++s6kExanszcee9PJfR39Me3XpVkQLF1FWdrqFydZQ2aw2k2xY/kRBUrsj5ctFGRMa+2QvCI3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3YJNmzf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso10761421fa.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438138; x=1714042938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXg/FCxqxrEmmJbSP4Gm/sqVNgoPv34ZwJwn4YaiB7g=;
        b=G3YJNmzf2vNF1j9XlCYzaGMmbn/9kktOK1xAx6QMlv6B4lH8ERriULnAJS7vuY20xZ
         TKEBGpIqAO3jwmSLGY3D9o7O71oI08/9sxrk59XQ+D3d3aDj802WM1cSZSR/bYLMjZZK
         WIpzFkhfMTFWhz4UEPt2jLowMfB7WMEQuEx7IBOGg4fK/1+ziGF70k4rBP2bOOBW95dQ
         L1ljcdtqmj3NmIruOMngIjuYjfyjZRgVKwYX/h6rQ3hZWMEf7b+qBnVHaMxv7WsQ5N8B
         empXjOyh3Geqoo1xEKXwNiEKE8PLbI7wK1//9Ugrquf3uUi4P/8Xsq7xkotg8nAb5bYG
         5EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438138; x=1714042938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXg/FCxqxrEmmJbSP4Gm/sqVNgoPv34ZwJwn4YaiB7g=;
        b=dDAwN2fa6aXLAqGXsMDsFYhK60kis7u0HejI4ikIV3yZs2assWzLwwtfWWOzWiWLD/
         e6J/Su54BEzYKKuYggYrCL+OV2FuQFakiA0pP2RbEJAk807+zM9clqr+2FSdWfzJtxCb
         /5AwCg/dM2Sl/rZVZsJNoohbUNvxGdVnfQmRHf7dGfKabavqoix72X7ru9fTwatO3CoH
         2/57FS9XFTcIgc4cjfQZHmxAt71P0Q5S7cJ0Q5pm+Ur33vce6EWr+XUVqkgAUDG+Nihn
         QFveGXOhNQRucLvRFj90jj+6Wp/OpW3WTHhk/MYLBoZGb6Xc6AuHJ9wOsFPs82edj5Ix
         6wLA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrpobyifcH8yEPcopExCQlct6V1sLnVI/q1CPBykKU3RuUiLU5dLc7V+wnuAVLyAtywAmUrqi2kdY1AdIOmm8h2SIs1Wy
X-Gm-Message-State: AOJu0YxeFAWUZGrkgvF+iHxzb50T3bNa3f7qNuj2tXCv93Pf7j0gwAMn
	/3j+O76wkY+KqW7rYuDLk+YcihnWG9CuUzWit/JGEvRGa++oQ0jj
X-Google-Smtp-Source: AGHT+IHgX4sQVMTzP3tj/vlxIQgpW6HIp/ee3ciU9VSYdhLDTfJjGXFHuKeoDTOsQ2b6Vog/+3Qo8Q==
X-Received: by 2002:a2e:1f12:0:b0:2d8:3e07:5651 with SMTP id f18-20020a2e1f12000000b002d83e075651mr1827831ljf.34.1713438137760;
        Thu, 18 Apr 2024 04:02:17 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id p12-20020a2e740c000000b002d2e81c0f18sm154057ljc.45.2024.04.18.04.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:02:17 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:02:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 2/6] net: stmmac: Add multi-channel support
Message-ID: <5v6ypjjtbq72ovb437p6n4fkq2z5a3nhkv6spjct2flvjaxmgq@ykrdiv7kk4kq>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>

On Fri, Apr 12, 2024 at 07:28:07PM +0800, Yanteng Si wrote:
> DW GMAC v3.x multi-channels feature is implemented as multiple
> sets of the same CSRs. Here is only preliminary support, it will
> be useful for the driver further evolution and for the users
> having multi-channel DWGMAC v3.x devices.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 +--
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 34 ++++++++++---------
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 20 +++++++++--
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++---
>  include/linux/stmmac.h                        |  1 +
>  10 files changed, 65 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index e1b761dcfa1d..cc93f73a380e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -299,7 +299,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>   * Called from stmmac via stmmac_dma_ops->init
>   */
>  static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
> -				 struct stmmac_dma_cfg *dma_cfg, int atds)
> +				 struct stmmac_dma_cfg *dma_cfg)
>  {
>  	writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
>  	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
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
> index daf79cdbd3ec..f161ec9ac490 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
>  
> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> +				       void __iomem *ioaddr,

> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)

please create a pre-requisite/preparation patch with the atds argument
movement to the stmmac_dma_cfg structure as I suggested in v8:
https://lore.kernel.org/netdev/yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug/
That will make this patch looking simpler and providing a single
coherent change.

> [...]
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 72672391675f..7c8b3ad739f7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>
> [...]
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
> @@ -235,7 +235,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>  

>  	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));

I'll ask once again:

"Isn't the mask change going to be implemented in the framework of the
Loongson-specific DMA-interrupt handler in some of the further
patches?"

The rest of the changes look good. Thanks.

-Serge(y)

>
> [...]
>

