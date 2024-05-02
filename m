Return-Path: <netdev+bounces-93107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524188BA0E2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7796A1C20D91
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4D15FD1E;
	Thu,  2 May 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9+RWtmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595D59B56
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677018; cv=none; b=oBijcPz/K6P8vTO/jtRK5PIjXZEwLht/3+sVkX8EMjW86+FMm8cbPKdpezkSF7A+It8xz92oTNiEXLQoug7+A+37g6PyYS7mixMdHg3BbWtyKUo3/THxJ87j9nLjwVAmyqL/Q3qXwKHVjrBOZyZNYVSlDO+AirSwYnR14dPUYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677018; c=relaxed/simple;
	bh=xvV8wCpkQWDOheSGpJEOVnBn0wzT94mPfIIw59SsR/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVZeYRhhEHAe9Yv9i8/UvDRsqmqKTdg/L9A8HIzsNSH6cxodZ009OhFVrTMfxptmj56JeNPf89Qz1mqtdJcKn80z3nUrZ9Sfn4vAnQjEe/Hbt4tYvZVta6M34kM+GuGvKpb8WaxzEU753I1VieG0Xjwq1Ow6hjBcoZoYqn/qVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9+RWtmm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso1573919e87.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677014; x=1715281814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE/rc0O7BeqDEIfD36mqBed9qLVkgr6xORfkhay9ud0=;
        b=A9+RWtmmHF1GfA5IOtNhcQN5yBMluIFHBiKCqubUkuJO+4KeIQ7D74rv+eqGmXB/eG
         C1e+Sz7hxeXXItUSwB5IPjQ95CD7HMtlBfcaUenaW5i7NaC17c3kssT2qmh8Cqs8o1y8
         xSO06oi4TNn8npreHR8CZ1HOVAKEk8adbuBxfPUDggGTzt+0gf7hRU4fgNR5nzkusFHc
         9aCxKx90yFZC17VEKPTJKrPq7iXz91bBGSx6C92XzJOBbuKPSXY7oX9+FCi5yZQp9DmN
         0PSibkIMOKwL+4a28cbMKEiJ3RI1fBwIb8y3iAA0Csjkl3Uba3qMVS4LLrqPVqy7mpsV
         CJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677014; x=1715281814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE/rc0O7BeqDEIfD36mqBed9qLVkgr6xORfkhay9ud0=;
        b=Gl4OGr05sY4b9gj/yyI/2ulezSi0GJ1/sU6mfk5DnnSjf6hPufXe3S79bRQyvD2RrR
         fqrPkFEa7g4yaqip5dznZUO1wGLiOr57GMcgknFwu06KXvUOzwZISL7XOxcCDtWn8MQ8
         pZMaL5bfke9rUAiN4stRl/GM30KVR3ogCMp8sZvuNJFbj77AAv9EtagmlcvncnNXOA43
         BSFqH8j87/u7lFi2dkZJR6Rwdt3MOAwsplt//wJpkfAFXSle6C+6gHNhXvAztTiWYUG6
         wTTvkEniXmXjtrYGGCIkSeYzE9KVIiSbRVvnXpr5p2UJYsGcTVVpo+Bu1ui7RkLF6CN+
         zYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcjiELjZq5zgQv9QCH5dKSTmy9FOqUXh2TGWZkfOfSYylmRgqIDdJOiyOW7OYWFJrOdqy0IJa8Qbf3RW79fNTI5HZeS368
X-Gm-Message-State: AOJu0YxxFJJoemEsn1wFUWbYHSk/cEewtGqtvxPnid0iYbtsBA4bZQ4C
	X/JtWv5dwgqyLYkQPFOWTd8nrgDP9w1c9TwemlkygsB/dkWVAJbK
X-Google-Smtp-Source: AGHT+IGYsbkBLYaTX7FpP/Wovx7h6zx8sHDewMI7lcW0mbI50N/X5vidsnjR1N3W8CTNXuD5KsLNQA==
X-Received: by 2002:a05:6512:2039:b0:519:6e94:9b4d with SMTP id s25-20020a056512203900b005196e949b4dmr380632lfs.48.1714677013897;
        Thu, 02 May 2024 12:10:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h2-20020a19ca42000000b005189964a79dsm274578lfj.172.2024.05.02.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:10:13 -0700 (PDT)
Date: Thu, 2 May 2024 22:10:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 01/15] net: stmmac: Move the atds flag to
 the stmmac_dma_cfg structure
Message-ID: <3yllm6pibimhkuorn3djjn7wtvsvgsf4metobfhsrlnekettly@6lnq6fyac72a>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <3f9089bae8391d1263ef9c2b7a7c09de56308387.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9089bae8391d1263ef9c2b7a7c09de56308387.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:01:54PM +0800, Yanteng Si wrote:
> Alternate Descriptor Size (ATDS) is a part of the DMA-configs together
> with the PBL, ALL, AEME, etc so the structure is the most suitable
> place for it.

The better description would be:

"ATDS (Alternate Descriptor Size) is a part of the DMA Bus Mode configs
(together with PBL, ALL, EME, etc) of the DW GMAC controllers. Seeing
it's not changed at runtime but is activated as long as the IP-core
has it supported (at least due to the Type 2 Full Checksum Offload
Engine feature), move the respective parameter from the
stmmac_dma_ops::init() callback argument to the stmmac_dma_cfg
structure, which already have the rest of the DMA-related configs
defined.

Besides the being added in the next commit DW GMAC multi-channels
support will require to add the stmmac_dma_ops::init_chan() callback
and have the ATDS flag set/cleared for each channel in there. Having
the atds-flag in the stmmac_dma_cfg structure will make the parameter
accessible from stmmac_dma_ops::init_chan() callback too."

Other than that the change looks good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 5 ++---
>  include/linux/stmmac.h                              | 1 +
>  8 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index e1b761dcfa1d..d87079016952 100644
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index daf79cdbd3ec..bb82ee9b855f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -71,7 +71,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  }
>  
>  static void dwmac1000_dma_init(void __iomem *ioaddr,
> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> +			       struct stmmac_dma_cfg *dma_cfg)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
>  	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> @@ -98,7 +98,7 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
>  	if (dma_cfg->mixed_burst)
>  		value |= DMA_BUS_MODE_MB;
>  
> -	if (atds)
> +	if (dma_cfg->atds)
>  		value |= DMA_BUS_MODE_ATDS;
>  
>  	if (dma_cfg->aal)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> index dea270f60cc3..f861babc06f9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> @@ -19,7 +19,7 @@
>  #include "dwmac_dma.h"
>  
>  static void dwmac100_dma_init(void __iomem *ioaddr,
> -			      struct stmmac_dma_cfg *dma_cfg, int atds)
> +			      struct stmmac_dma_cfg *dma_cfg)
>  {
>  	/* Enable Application Access by writing to DMA CSR0 */
>  	writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..e0165358c4ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -153,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>  }
>  
>  static void dwmac4_dma_init(void __iomem *ioaddr,
> -			    struct stmmac_dma_cfg *dma_cfg, int atds)
> +			    struct stmmac_dma_cfg *dma_cfg)
>  {
>  	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index dd2ab6185c40..7840bc403788 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -20,7 +20,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>  }
>  
>  static void dwxgmac2_dma_init(void __iomem *ioaddr,
> -			      struct stmmac_dma_cfg *dma_cfg, int atds)
> +			      struct stmmac_dma_cfg *dma_cfg)
>  {
>  	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 90384db228b5..413441eb6ea0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -175,8 +175,7 @@ struct dma_features;
>  struct stmmac_dma_ops {
>  	/* DMA core initialization */
>  	int (*reset)(void __iomem *ioaddr);
> -	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> -		     int atds);
> +	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg);
>  	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
>  	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 59bf83904b62..188514ca6c47 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3006,7 +3006,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>  	struct stmmac_rx_queue *rx_q;
>  	struct stmmac_tx_queue *tx_q;
>  	u32 chan = 0;
> -	int atds = 0;
>  	int ret = 0;
>  
>  	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
> @@ -3015,7 +3014,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>  	}
>  
>  	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
> -		atds = 1;
> +		priv->plat->dma_cfg->atds = 1;
>  
>  	ret = stmmac_reset(priv, priv->ioaddr);
>  	if (ret) {
> @@ -3024,7 +3023,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>  	}
>  
>  	/* DMA Configuration */
> -	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg, atds);
> +	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
>  
>  	if (priv->plat->axi)
>  		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756..1b54b84a6785 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -100,6 +100,7 @@ struct stmmac_dma_cfg {
>  	bool eame;
>  	bool multi_msi_en;
>  	bool dche;
> +	bool atds;
>  };
>  
>  #define AXI_BLEN	7
> -- 
> 2.31.4
> 

