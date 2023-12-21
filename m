Return-Path: <netdev+bounces-59576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FC81B6B0
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C22FB25F57
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60573198;
	Thu, 21 Dec 2023 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iItmko6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80C77F11
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cca5d81826so256421fa.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703163209; x=1703768009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19pXwZCShdha5tJ35ukqpBu0otaQvagtTsK1B3NRxNs=;
        b=iItmko6mlpm9mdiioYJ0gZiYLEpSLzz5+TqGlCHtw9flV+2CO/rch74WpszrT5n9P0
         EHmiPAiOuggDO3YosIrazVqsZcyJlER6dIiBMhe9uuxWvyuauwWjgTWQSXrZxnBop4SF
         zMKuPE9KKdCCyzslGKu8ZY0lMYEXG5reYy572299P8uetVRJXmfaFKFeWCh9jrcLngqb
         hEP5uILhsS4I9E7aZo+ygcM6IzZJvPt/mVOfMcb35wWRJOAmnNKAW4ScUtsk2+n09gin
         lu8C6qSOEg3hlLHzLXVyWf7bUBtnPAsHAoY3o1kKjaRGGOi9p3hpgrd+JQzHuyK7GcPz
         4pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163209; x=1703768009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19pXwZCShdha5tJ35ukqpBu0otaQvagtTsK1B3NRxNs=;
        b=nwZR3YXZA6+fl/TaKpq/kNhCO+Ze9oTdMcA45npcDPGCPVuLUU8Y4p6PqHV1uazD0x
         WRQDwHNn0gsRK5XRidfKIpsIzUm8PhWcZRVOo2NX7NTfMKK8hYxo3YzShwVn7AqMTUev
         P9xd+nisR14YQw36rHFctd8zdPWhFO/PvIi3ee7/azpgeg4xjQmsX63p+O6Vjao7lq3l
         v/2QgLDhmtee9ZGnLtJptln0Fp2zVH996YZPi8OhzyOAhQIcDNDw5l9RxGw339359v2W
         DJebN8O4AahbKSUBh7N2pHM6QjkakNnC7OEeD58rK/stPUvRv7+GHbFOHaqUGBVa6MXk
         Yg0g==
X-Gm-Message-State: AOJu0YxFIJJ3BFSja7EnCIugJLiEShwd1wHwCO79wABqzyeomxCxbSEN
	2KIcgG8T+jPIippPxnWnzaQ=
X-Google-Smtp-Source: AGHT+IHa6Zw6E2nLW+jL/su0+SHF5/Tvd03Oa5jRbUNRn6cpvaQHsUOmMfTe3wJb4oA8xm7G2zgHwQ==
X-Received: by 2002:a2e:3503:0:b0:2cc:a596:836a with SMTP id z3-20020a2e3503000000b002cca596836amr59782ljz.50.1703163209096;
        Thu, 21 Dec 2023 04:53:29 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x22-20020a05651c105600b002cc540b56f9sm255675ljm.3.2023.12.21.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 04:53:28 -0800 (PST)
Date: Thu, 21 Dec 2023 15:53:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 1/9] net: stmmac: Pass stmmac_priv and chan
 in some callbacks
Message-ID: <grfyq7hezxecs3q6lcqhpukc223pfh6cdyrsoddwelli76667d@47njoehuvkqo>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>
 <zjyo2kibcrgirfc5pcvbeqbq2dmhpjkilvq3zwsmugee2gc3cf@e7dhxkrr3ha2>
 <8eacd500-b092-4031-91d1-f2edccf18d21@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eacd500-b092-4031-91d1-f2edccf18d21@loongson.cn>

On Thu, Dec 21, 2023 at 07:50:08PM +0800, Yanteng Si wrote:
> 
> 在 2023/12/21 02:18, Serge Semin 写道:
> > Hi Yanteng
> > 
> > On Tue, Dec 19, 2023 at 10:17:04PM +0800, Yanteng Si wrote:
> > > Loongson GMAC and GNET have some special features. To prepare for that,
> > > pass stmmac_priv and chan to more callbacks, and adjust the callbacks
> > > accordingly.
> > > 
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > ---
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c |  2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  |  2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    |  2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     |  3 ++-
> > >   drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     |  3 ++-
> > >   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/hwif.h          | 11 ++++++-----
> > >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 +++---
> > >   9 files changed, 18 insertions(+), 15 deletions(-)
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
> > As Simon correctly noted this prototype is incomplete. Although AFAICS
> > you never use a pointer to stmmac_priv in this method. So I guess you
> > could fix the callback prototype instead.
> > 
> > >   {
> > >   	u32 v;
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > index daf79cdbd3ec..5e80d3eec9db 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > > @@ -70,7 +70,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> > >   	writel(value, ioaddr + DMA_AXI_BUS_MODE);
> > >   }
> > > -static void dwmac1000_dma_init(void __iomem *ioaddr,
> > > +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			       struct stmmac_dma_cfg *dma_cfg, int atds)
> > >   {
> > >   	u32 value = readl(ioaddr + DMA_BUS_MODE);
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> > > index dea270f60cc3..105e7d4d798f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> > > @@ -18,7 +18,7 @@
> > >   #include "dwmac100.h"
> > >   #include "dwmac_dma.h"
> > > -static void dwmac100_dma_init(void __iomem *ioaddr,
> > > +static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			      struct stmmac_dma_cfg *dma_cfg, int atds)
> > >   {
> > >   	/* Enable Application Access by writing to DMA CSR0 */
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > index 84d3a8551b03..dc54c4e793fd 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > @@ -152,7 +152,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
> > >   	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
> > >   }
> > > -static void dwmac4_dma_init(void __iomem *ioaddr,
> > > +static void dwmac4_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			    struct stmmac_dma_cfg *dma_cfg, int atds)
> > >   {
> > >   	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > index 72672391675f..e7aef136824b 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> > > @@ -152,7 +152,8 @@
> > >   #define NUM_DWMAC1000_DMA_REGS	23
> > >   #define NUM_DWMAC4_DMA_REGS	27
> > > -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> > > +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> > > +				   void __iomem *ioaddr, u32 chan);
> > >   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			  u32 chan, bool rx, bool tx);
> > >   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > index 7907d62d3437..2f0df16fb7e4 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> > > @@ -28,7 +28,8 @@ int dwmac_dma_reset(void __iomem *ioaddr)
> > >   }
> > >   /* CSR1 enables the transmit DMA to check for new descriptor */
> > > -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> > > +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> > > +				   void __iomem *ioaddr, u32 chan)
> > >   {
> > >   	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
> > >   }
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > > index 3cde695fec91..a06f9573876f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > > @@ -19,7 +19,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
> > >   				  !(value & XGMAC_SWR), 0, 100000);
> > >   }
> > > -static void dwxgmac2_dma_init(void __iomem *ioaddr,
> > > +static void dwxgmac2_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			      struct stmmac_dma_cfg *dma_cfg, int atds)
> > >   {
> > >   	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > index 7be04b54738b..a44aa3671fb8 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > @@ -175,8 +175,8 @@ struct dma_features;
> > >   struct stmmac_dma_ops {
> > >   	/* DMA core initialization */
> > >   	int (*reset)(void __iomem *ioaddr);
> > > -	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> > > -		     int atds);
> > > +	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > +		     struct stmmac_dma_cfg *dma_cfg, int atds);
> > There is a good chance this change is also unnecessary. I'll post my
> > comment about that to Patch 4/9.
> > 
> > >   	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
> > >   	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > @@ -198,7 +198,8 @@ struct stmmac_dma_ops {
> > >   	/* To track extra statistic (if supported) */
> > >   	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
> > >   				  void __iomem *ioaddr);
> > 
> > > -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> > > +	void (*enable_dma_transmission)(struct stmmac_priv *priv,
> > > +					void __iomem *ioaddr, u32 chan);
> > Why do you need the pointer to the stmmac_priv structure instance
> > here? I failed to find a place you using it in the subsequent patches.
> it's here：
> 
> @@ -70,7 +70,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct
> stmmac_axi *axi)
>      writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
> 


> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem

Em, my comment was about enable_dma_transmission() ! I don't see you
using the stmmac_priv pointer in any updates for that method.

> *ioaddr,
>                     struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>      u32 value = readl(ioaddr + DMA_BUS_MODE);
> 
> @@ -118,7 +118,10 @@ static void dwmac1000_dma_init(struct stmmac_priv
> *priv, void __iomem *ioaddr,
> 
>      u32 dma_intr_mask;
> 
>      /* Mask interrupts by writing to CSR7 */
> -    dma_intr_mask = DMA_INTR_DEFAULT_MASK;
> +    if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
> +        dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
> +    else
> +        dma_intr_mask = DMA_INTR_DEFAULT_MASK;
> 
>      dma_config(ioaddr + DMA_BUS_MODE, ioaddr + DMA_INTR_ENA,
> 
>                dma_cfg, dma_intr_mask, atds);
> 
> 

> Thank you for all your comments, I need some time to understand. :)

Don't hesitate to ask should any question arise in my comments regard.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > * Sigh, just a general note in case if somebody would wish to make
> > * things a bit more optimised and less complicated. The purpose of the
> > * enable_dma_transmission() callback is to re-activate the DMA-engine
> > * - exit from suspension and start poll-demanding the DMA descriptors.
> > * In QoS GMAC and XGMAC the same is done by updating the Tx tail
> > * pointer.  It's implemented in stmmac_set_tx_tail_ptr(). So basically
> > * both stmmac_enable_dma_transmission() and stmmac_set_tx_tail_ptr()
> > * should be almost always called side-by-side. Alas the current
> > * generic driver part doesn't do that. If it did in a some common way
> > * you wouldn't have needed the enable_dma_transmission() update
> > * because it would have already been updated to accept the
> > * channel/queue parameter.
> > 
> > -Serge(y)
> > 
> > >   	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > >   			       u32 chan, bool rx, bool tx);
> > >   	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > @@ -240,7 +241,7 @@ struct stmmac_dma_ops {
> > >   };
> > >   #define stmmac_dma_init(__priv, __args...) \
> > > -	stmmac_do_void_callback(__priv, dma, init, __args)
> > > +	stmmac_do_void_callback(__priv, dma, init, __priv, __args)
> > >   #define stmmac_init_chan(__priv, __args...) \
> > >   	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
> > >   #define stmmac_init_rx_chan(__priv, __args...) \
> > > @@ -258,7 +259,7 @@ struct stmmac_dma_ops {
> > >   #define stmmac_dma_diagnostic_fr(__priv, __args...) \
> > >   	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
> > >   #define stmmac_enable_dma_transmission(__priv, __args...) \
> > > -	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
> > > +	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __priv, __args)
> > >   #define stmmac_enable_dma_irq(__priv, __args...) \
> > >   	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
> > >   #define stmmac_disable_dma_irq(__priv, __args...) \
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 47de466e432c..d868eb8dafc5 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> > >   				       true, priv->mode, true, true,
> > >   				       xdp_desc.len);
> > > -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> > > +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > >   		xsk_tx_metadata_to_compl(meta,
> > >   					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> > > @@ -4679,7 +4679,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> > >   	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
> > > -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> > > +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> > >   	stmmac_flush_tx_descriptors(priv, queue);
> > >   	stmmac_tx_timer_arm(priv, queue);
> > > @@ -4899,7 +4899,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
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

