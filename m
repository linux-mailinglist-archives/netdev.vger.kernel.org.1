Return-Path: <netdev+bounces-69419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF884B196
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DE1285D4F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D112D17A;
	Tue,  6 Feb 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jenE+zGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907212D752
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212929; cv=none; b=DbGkNrfPAAw0MaUFX9FIDbhnyzqLK4/aqCqDPmn2NWrFctXK2res9CDAq3+5G4PSFbfwfQ2M3SvkwEBFqG1IsWhZ3ZYApTpqNyUyuDqi78AFKqJfNmQi1ZxXNlTpNwNsZbHTrtqD9UWROB4NKVOwPp6nOdU+qSSMqbUtRrrtll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212929; c=relaxed/simple;
	bh=flapyQrNUxHoc5dQ0sBphZFkEa8X2UuYOYII2iMqVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW2ullKU0DyKT0rZVNfSx8bdZzmZstnzuUAJ3hg2hk/ufgtOHdGjNIoLKetG7qKLDhSYyYXDfwWnOcwdCS61dgIldNV2C1/w1vT5KCN0Sc717k5Crc6LMMY1uQoW3eEwEmyoo8XYxExKfZRnaBLxc3PuO1leLOLW3wnCU1C6Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jenE+zGr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso66308041fa.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707212925; x=1707817725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSUP9v73ua/OFlNoClzdpkMzGQ/kuxGOm9W3zpDBw6k=;
        b=jenE+zGrRlcR6AgoFASGA2g70yi6mKkoKGpmNJxrUlSQF/y8fykcQkUX9vZegldAOC
         37hNreEtXa+MOSlkBWZyUuoJZztiMpBJ7JTugoVrY2607Gl+Uea2mHgFxwlx3K8Hozve
         +ue+p6czJkFnRUWK6LaXYqarZMJEczDCIz2A2hrOSaWKgHLF9HB5I/zr/8Z8d7U+hSe/
         3QoIX1bjxEt6amvmlVDVbXXWb1/ZGv39bBTnBu1+VR9zin/XCS9Vjvk3iZmujazkR39m
         UwPQRp5bDzdceid0iD1JcUIqh5LydBBcpcz2uZUn8kS3JORzhuryXJuwXoHMBas/nEWW
         hrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212925; x=1707817725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSUP9v73ua/OFlNoClzdpkMzGQ/kuxGOm9W3zpDBw6k=;
        b=rFwBe2uMGZcQoKbPbU5yCHKBjneZehTRvR2nHRTsAtT3sfeWavLyjuZPbo+gSfyzhI
         Oir9eXqynFv3jvhfs0KPqz5leV0e5VxtIHYRW0OP268sW2dP9j0AKYpUwPFtuiuZbvMP
         Jo1R2Nd6PGlew33gf419bRQKhtKBQjUO6/pLyvinX8w0uzpUuQ2hePyE/epF3aPtPE5j
         stsDxzR9zx4X/fJ7kDhpuIVFivgzknGT3agis+4Sc76lCGSFM/fyp++ImHnF3qloQO4S
         xZKLAtX+IV0oBa44cafgR8HneChnNSF7jRarGc99pX3UTgtJhhOfEnSIaaso+kHrr3Gb
         6ZKA==
X-Gm-Message-State: AOJu0YxyaWQGos6BWhGCdQJCiRyUkl7TRo2V1MTm49/P3gTISQz91sbD
	0PJMahuFHKw2j7G4olG/9VAWzBJvQV3za4ezkcCyurz99yUKDbUs
X-Google-Smtp-Source: AGHT+IEkv7znKk8wWIhtuNviOVOu1CVyr7lVOtRX2UlT/0jgf7LGu8YcIq806CU9IDIZW1oSnyJbRA==
X-Received: by 2002:a19:5506:0:b0:511:48aa:d621 with SMTP id n6-20020a195506000000b0051148aad621mr1274103lfe.66.1707212924990;
        Tue, 06 Feb 2024 01:48:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXt12VyH2ZcTcZZCXfocVFmxgVHH2225NRBdsqAzaGMn84q/1fmO/+Tb2pgSmYbOMnGQz4UIi3XWKTzRSsxWQ4p2rYbz+tN8LNL7s6boFEPg9/6+rPx9xj54shlO+HU8cBcOAP7QoTDm/pvlJ7nqpQzxjitRZ1S5dOlmxrt0JHKZzPidFigWmKGmz/lF2Pm9CN49W++RLAi8xAsh2/i5qYKmDtl37a+OHiCcgTpBSdU4SYO/jv9K+cuz6wPpydBaDQRAYMABG4X3v5WUp6N2uJmBeZzmcUpLzHw0708hBn/KaX0JqMhMvq0UFNka8EXN4sc/V38Wm1OcntBJh16xGTqzeOYwdiU1A8Vf0PEUHGxfz2NCUiE2xzjcCYS8zSV8C5bCgv7gw==
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512014200b0051145ebd75asm194229lfo.39.2024.02.06.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:48:44 -0800 (PST)
Date: Tue, 6 Feb 2024 12:48:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Message-ID: <fkhshxyt6efa2pykqnkr2kcib6vdzavse3blrwbhlf2efgzfa7@lvcmfnglvc56>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
 <f6b6aad5-7010-42a5-b17d-f0b95f5c94f0@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b6aad5-7010-42a5-b17d-f0b95f5c94f0@loongson.cn>

On Tue, Feb 06, 2024 at 05:02:29PM +0800, Yanteng Si wrote:
> 
> 在 2024/2/5 07:28, Serge Semin 写道:
> > On Tue, Jan 30, 2024 at 04:43:21PM +0800, Yanteng Si wrote:
> > > DW GMAC v3.x multi-channels feature is implemented as multiple
> > > sets of the same CSRs. Here is only preliminary support, it will
> > > be useful for the driver further evolution and for the users
> > > having multi-channel DWGMAC v3.x devices.
> > > 
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > ---
> > >   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
> > >   .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 36 ++++++++++---------
> > >   .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 19 +++++++++-
> > >   .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
> > >   drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
> > >   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
> > >   6 files changed, 58 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > index 137741b94122..7cdfa0bdb93a 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
> > >   	writel(v, ioaddr + EMAC_TX_CTL1);
> > >   }
> > > -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> > > +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
> > >   {
> > >   	u32 v;
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > index daf79cdbd3ec..5f7b82ad3ec2 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > @@ -70,15 +70,18 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> > >   	writel(value, ioaddr + DMA_AXI_BUS_MODE);
> > >   }
> > > -static void dwmac1000_dma_init(void __iomem *ioaddr,
> > > -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> > > +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> > > +				       void __iomem *ioaddr,
> > > +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_BUS_MODE);
> > > +	u32 value;
> > >   	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> > >   	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> > Reverse xmas tree please.
> OK!
> > 
> > > -	/*
> > > -	 * Set the DMA PBL (Programmable Burst Length) mode.
> > > +	/* common channel control register config */
> > Redundant comment. Please drop.
> OK!
> > 
> > > +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> > > +
> > > +	/* Set the DMA PBL (Programmable Burst Length) mode.
> > >   	 *
> > >   	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> > >   	 * post 3.5 mode bit acts as 8*PBL.
> > > @@ -98,16 +101,15 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
> > >   	if (dma_cfg->mixed_burst)
> > >   		value |= DMA_BUS_MODE_MB;
> > > -	if (atds)
> > > -		value |= DMA_BUS_MODE_ATDS;
> > > +	value |= DMA_BUS_MODE_ATDS;
> > No, just convert the stmmac_dma_ops.dma_init_channel() to accepting
> > the atds flag as I suggested in v7:
> > https://lore.kernel.org/netdev/vxcfrxtbfu4pya56m22icnizsyjzqqha5blzb7zpexqcur56uh@uv6vsjf77npa/
> > 
> > In order to simplify this patch you can provide the
> > stmmac_dma_ops.dma_init_channel() and
> > stmmac_dma_ops.enable_dma_transmission() prototype updates in a
> > pre-requisite/preparation patch.
> OK.
> > 
> > >   	if (dma_cfg->aal)
> > >   		value |= DMA_BUS_MODE_AAL;
> > > -	writel(value, ioaddr + DMA_BUS_MODE);
> > > +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> > >   	/* Mask interrupts by writing to CSR7 */
> > > -	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
> > > +	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
> > >   }
> > >   static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
> > > @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
> > >   				  dma_addr_t dma_rx_phy, u32 chan)
> > >   {
> > >   	/* RX descriptor base address list must be written into DMA CSR3 */
> > > -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
> > > +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
> > >   }
> > >   static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> > > @@ -125,7 +127,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> > >   				  dma_addr_t dma_tx_phy, u32 chan)
> > >   {
> > >   	/* TX descriptor base address list must be written into DMA CSR4 */
> > > -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
> > > +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
> > >   }
> > >   static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
> > > @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> > >   					    void __iomem *ioaddr, int mode,
> > >   					    u32 channel, int fifosz, u8 qmode)
> > >   {
> > > -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> > > +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> > >   	if (mode == SF_DMA_MODE) {
> > >   		pr_debug("GMAC: enable RX store and forward mode\n");
> > > @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> > >   	/* Configure flow control based on rx fifo size */
> > >   	csr6 = dwmac1000_configure_fc(csr6, fifosz);
> > > -	writel(csr6, ioaddr + DMA_CONTROL);
> > > +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> > >   }
> > >   static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> > >   					    void __iomem *ioaddr, int mode,
> > >   					    u32 channel, int fifosz, u8 qmode)
> > >   {
> > > -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> > > +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> > >   	if (mode == SF_DMA_MODE) {
> > >   		pr_debug("GMAC: enable TX store and forward mode\n");
> > > @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> > >   			csr6 |= DMA_CONTROL_TTC_256;
> > >   	}
> > > -	writel(csr6, ioaddr + DMA_CONTROL);
> > > +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> > >   }
> > >   static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
> > > @@ -271,12 +273,12 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
> > >   static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
> > >   				  void __iomem *ioaddr, u32 riwt, u32 queue)
> > >   {
> > > -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
> > > +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
> > >   }
> > >   const struct stmmac_dma_ops dwmac1000_dma_ops = {
> > >   	.reset = dwmac_dma_reset,
> > > -	.init = dwmac1000_dma_init,
> > > +	.init_chan = dwmac1000_dma_init_channel,
> > >   	.init_rx_chan = dwmac1000_dma_init_rx,
> > >   	.init_tx_chan = dwmac1000_dma_init_tx,
> > >   	.axi = dwmac1000_dma_axi,
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > index 72672391675f..593be79c46e1 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > @@ -148,11 +148,14 @@
> > >   					 DMA_STATUS_TI | \
> > >   					 DMA_STATUS_MSK_COMMON)
> > > +/* Following DMA defines are chanels oriented */    \
> > > +#define DMA_CHAN_OFFSET			0x100   |-------------+
> > > +                                                    /              |
> >                                                                        |
> > Please move all of these ---------------------------------------------+-------------------------+
> > to being defined just below the DMA_MISSED_FRAME_CTR macros definition.                         |
> > The point is to keep a coherency between dwmac_dma.h and dwmac4_dma.h.                          |
> > The later header file has first generic DMA-related macros defined                              |
> > (CSR addresses and flags) and then the channel-specific ones (CSR                               |
> > addresses and flags). Since in case of the DW GMAC v3.x the                                     |
> > multi-channels are implemented as a copy of all the DMA CSRs let's                              |
> > preserve the logic of having all CSR address defined first, then the                            |
> > CSR flags.                                                                                      |
> >                                                                                                  |
> > >   #define NUM_DWMAC100_DMA_REGS	9                                                       |
> > >   #define NUM_DWMAC1000_DMA_REGS	23                                                      |
> > >   #define NUM_DWMAC4_DMA_REGS	27                                                              |
> > >                                                                                                |
> > > -void dwmac_enable_dma_transmission(void __iomem *ioaddr);                                    |
> > > +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);                          |
> > >   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                    |
> > >   			  u32 chan, bool rx, bool tx);                                          |
> > >   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                   |
> > > @@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,  |
> > >   			struct stmmac_extra_stats *x, u32 chan, u32 dir);                       |
> > >   int dwmac_dma_reset(void __iomem *ioaddr);                                                   |
> > >                                                                                                |
> >                                                                                                  |
> > > +static inline u32 dma_chan_base_addr(u32 base, u32 chan)                                  \  |
> > > +{                                                                                          | |
> > > +	return base + chan * DMA_CHAN_OFFSET;                                                 | |
> > > +}                                                                                          | |
> > > +                                                                                           | |
> > > +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan) | |
> > > +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)        | |
> > > +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)         | |
> > > +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)          |-+
> > > +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)        |
> > > +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)           |
> > > +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)            |
> > > +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)             |
> > > +                                                                                           /
> OK.
> > >   #endif /* __DWMAC_DMA_H__ */
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > index 7907d62d3437..b37368137810 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > @@ -28,65 +28,65 @@ int dwmac_dma_reset(void __iomem *ioaddr)
> > >   }
> > >   /* CSR1 enables the transmit DMA to check for new descriptor */
> > > -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> > > +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
> > >   {
> > > -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
> > > +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
> > >   }
> > >   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			  u32 chan, bool rx, bool tx)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
> > >   	if (rx)
> > >   		value |= DMA_INTR_DEFAULT_RX;
> > >   	if (tx)
> > >   		value |= DMA_INTR_DEFAULT_TX;
> > > -	writel(value, ioaddr + DMA_INTR_ENA);
> > > +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
> > >   }
> > >   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			   u32 chan, bool rx, bool tx)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
> > >   	if (rx)
> > >   		value &= ~DMA_INTR_DEFAULT_RX;
> > >   	if (tx)
> > >   		value &= ~DMA_INTR_DEFAULT_TX;
> > > -	writel(value, ioaddr + DMA_INTR_ENA);
> > > +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
> > >   }
> > >   void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			u32 chan)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_CONTROL);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> > >   	value |= DMA_CONTROL_ST;
> > > -	writel(value, ioaddr + DMA_CONTROL);
> > > +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> > >   }
> > >   void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_CONTROL);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> > >   	value &= ~DMA_CONTROL_ST;
> > > -	writel(value, ioaddr + DMA_CONTROL);
> > > +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> > >   }
> > >   void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			u32 chan)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_CONTROL);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> > >   	value |= DMA_CONTROL_SR;
> > > -	writel(value, ioaddr + DMA_CONTROL);
> > > +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> > >   }
> > >   void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
> > >   {
> > > -	u32 value = readl(ioaddr + DMA_CONTROL);
> > > +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> > >   	value &= ~DMA_CONTROL_SR;
> > > -	writel(value, ioaddr + DMA_CONTROL);
> > > +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> > >   }
> > >   #ifdef DWMAC_DMA_DEBUG
> > > @@ -166,7 +166,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
> > >   	int ret = 0;
> > >   	/* read the status register (CSR5) */
> > > -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> > > +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
> > >   #ifdef DWMAC_DMA_DEBUG
> > >   	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> > > @@ -236,7 +236,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
> > >   	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> > > -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> > > +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> > Isn't the mask change going to be implemented in the framework of the
> > Loongson-specific DMA-interrupt handler in some of the further patches?
> Yes!
> > 
> > I'll get back to reviewing the series tomorrow (later today)...
> 
> OK, Thanks for your review!  I have read all your comments in others patch.
> 
> 
> I will modify the code as soon as possible according to your comments,
> 

> but in the next two weeks (Spring Festival), I will not be able to test on
> all devices.

Ok. Whenever you are ready I'll keep reviewing your series. Even at
the current state the patchset looks much much better than it was
initially. Some reordering, commit logs elaboration, a few more cycle
to polish out some details and I guess it will be ready for merging at
least from my point of view.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > >   	return ret;
> > >   }
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > index 7be04b54738b..b0db38396171 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > @@ -198,7 +198,7 @@ struct stmmac_dma_ops {
> > >   	/* To track extra statistic (if supported) */
> > >   	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
> > >   				  void __iomem *ioaddr);
> > > -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> > > +	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
> > >   	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			       u32 chan, bool rx, bool tx);
> > >   	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index b334eb16da23..5617b40abbe4 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> > >   				       true, priv->mode, true, true,
> > >   				       xdp_desc.len);
> > > -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> > > +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > >   		xsk_tx_metadata_to_compl(meta,
> > >   					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> > > @@ -4706,7 +4706,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> > >   	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
> > > -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> > > +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > >   	stmmac_flush_tx_descriptors(priv, queue);
> > >   	stmmac_tx_timer_arm(priv, queue);
> > > @@ -4926,7 +4926,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> > >   		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
> > >   	}
> > > -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> > > +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > >   	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
> > >   	tx_q->cur_tx = entry;
> > > -- 
> > > 2.31.4
> > > 
> 

