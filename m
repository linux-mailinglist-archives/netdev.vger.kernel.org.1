Return-Path: <netdev+bounces-47204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06827E8C75
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3841C20401
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120A1C2A3;
	Sat, 11 Nov 2023 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YDiCQIw2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FD1D531
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 20:07:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC9A3860
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=epdP1eeJfxKhTnMiLjGxxeK/gnzrN+A6/Al/K9H9mvE=; b=YDiCQIw2F5SfIvC+hLXBztik7B
	pJm1omkAT871BIPq9EldzSXNf9eG/RxczSL+Q7BMZxuc8a69ntR3sqp5LH9GI3n8zlynvoLm6je9H
	4KzF4p6MA9c17QuMtk7lPU91Zynk+JEumFjdedCRWzB+vK94NfcohxYIxAkTOCGOwzYw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1uG4-001N8R-5o; Sat, 11 Nov 2023 21:07:08 +0100
Date: Sat, 11 Nov 2023 21:07:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>

> +#ifdef	CONFIG_DWMAC_LOONGSON
> +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_AIE | \
> +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
> +#else
>  #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
>  				DMA_INTR_ENA_UNE)
> +#endif

The aim is to produce one kernel which runs on all possible
variants. So we don't like to see this sort of #ifdef. Please try to
remove them.

> @@ -167,7 +167,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>  	int ret = 0;
>  	/* read the status register (CSR5) */
> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>  

Please break this patch up. Changes like the above are simple to
understand. So have one patch which just adds these macros and makes
use of them.

>  #ifdef DWMAC_DMA_DEBUG
>  	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> @@ -182,7 +182,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  		intr_status &= DMA_STATUS_MSK_TX;
>  
>  	/* ABNORMAL interrupts */
> -	if (unlikely(intr_status & DMA_STATUS_AIS)) {
> +	if (unlikely(intr_status & DMA_ABNOR_INTR_STATUS)) {

However, this is not obviously correct. You need to explain in the
commit message why this change is needed.

Lots of small patches make the understanding easier.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7371713c116d..aafc75fa14a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7062,6 +7062,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	/* dwmac-sun8i only work in chain mode */
>  	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
>  		chain_mode = 1;
> +
>  	priv->chain_mode = chain_mode;

Please avoid white space changes.

       Andrew

