Return-Path: <netdev+bounces-79629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B528187A4A6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA51C21B7F
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5C1B95E;
	Wed, 13 Mar 2024 09:11:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FACC1B273
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321068; cv=none; b=dqN92oJPXU5QSUFSZJxEeCbt9xD0JleV9/By9vF4u2boorlTtJlxnmYx7CxpbTSkb8JYu5Q3euN0cZBdsXiONPgmkoi55+txVRqM9RsyRlhqGdXTNWkG/d4CGJ+1nxBJPMkMZIeyF0R1yd2qtxNIk3edim73ZOiu/qAy1OZcq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321068; c=relaxed/simple;
	bh=Mk801R0W+7O2cl/MvFtm7kGHqw0scaMPDNxdWDcS1bg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HA88Gg/pcB3o36YYaCJy3EUFT5nvpTOc8Z5DQQ0c+E5jel+VsNTlvCkidFND/g8vzIie9aYBUHvZZut1xAnHY4egiqkkCUXYaRzBpmt/UAiMRcY0JI/ePWq2kOLXSVwGF14YuXaW3n474FRblelDKi81Vl3YPPA6b8noZXx3BSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8CxifCkbfFly1kYAA--.59699S3;
	Wed, 13 Mar 2024 17:11:00 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs2ebfFlgWFYAA--.33686S3;
	Wed, 13 Mar 2024 17:10:54 +0800 (CST)
Message-ID: <034d1f08-a110-4e68-abf5-35e7714ea5ae@loongson.cn>
Date: Wed, 13 Mar 2024 17:10:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
 <673510eb-21a8-47ca-b910-476b9b09e2bf@loongson.cn>
 <yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug>
 <ee2ffb6a-fe34-47a1-9734-b0e6697a5f09@loongson.cn>
In-Reply-To: <ee2ffb6a-fe34-47a1-9734-b0e6697a5f09@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs2ebfFlgWFYAA--.33686S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfWF1DtryfXr45Ar1kZF15Jrc_yoW5Zw1fJo
	WfAFnxWF4agw1Uur97Kw1kJryaq3sxXw1rCrWDGr4kuaySyay5Z3y2q393Ja17JF17CrZr
	Z348Xa1qvF47KF15l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=

Hi Serge

在 2024/3/13 15:01, Yanteng Si 写道:
> 在 2024/2/21 21:48, Serge Semin 写道:
> > Hi Yanteng
> >
> > On Mon, Feb 19, 2024 at 07:02:24PM +0800, Yanteng Si wrote:
> >> Hi Serge
> >>
> >> 在 2024/2/5 07:28, Serge Semin 写道:
> >>> On Tue, Jan 30, 2024 at 04:43:21PM +0800, Yanteng Si wrote:
> >>>> DW GMAC v3.x multi-channels feature is implemented as multiple
> >>>> sets of the same CSRs. Here is only preliminary support, it will
> >>>> be useful for the driver further evolution and for the users
> >>>> having multi-channel DWGMAC v3.x devices.
> >>>>
> >>>> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> >>>> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> >>>> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> >>>> ---
> >>>>    .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
> >>>>    .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 36 ++++++++++---------
> >>>>    .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 19 +++++++++-
> >>>>    .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
> >>>>    drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
> >>>>    .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
> >>>>    6 files changed, 58 insertions(+), 39 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>>> index 137741b94122..7cdfa0bdb93a 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >>>> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
> >>>>    	writel(v, ioaddr + EMAC_TX_CTL1);
> >>>>    }
> >>>> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> >>>> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
> >>>>    {
> >>>>    	u32 v;
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >>>> index daf79cdbd3ec..5f7b82ad3ec2 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >>>> @@ -70,15 +70,18 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> >>>>    	writel(value, ioaddr + DMA_AXI_BUS_MODE);
> >>>>    }
> >>>> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> >>>> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
> >>>> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> >>>> +				       void __iomem *ioaddr,
> >>>> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_BUS_MODE);
> >>>> +	u32 value;
> >>>>    	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> >>>>    	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> >>> Reverse xmas tree please.
> >>>
> >>>> -	/*
> >>>> -	 * Set the DMA PBL (Programmable Burst Length) mode.
> >>>> +	/* common channel control register config */
> >>> Redundant comment. Please drop.
> >>>
> >>>> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> >>>> +
> >>>> +	/* Set the DMA PBL (Programmable Burst Length) mode.
> >>>>    	 *
> >>>>    	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> >>>>    	 * post 3.5 mode bit acts as 8*PBL.
> >>>> @@ -98,16 +101,15 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
> >>>>    	if (dma_cfg->mixed_burst)
> >>>>    		value |= DMA_BUS_MODE_MB;
> >>>> -	if (atds)
> >>>> -		value |= DMA_BUS_MODE_ATDS;
> >>>> +	value |= DMA_BUS_MODE_ATDS;
> >>> No, just convert the stmmac_dma_ops.dma_init_channel() to accepting
> >>> the atds flag as I suggested in v7:
> >>> https://lore.kernel.org/netdev/vxcfrxtbfu4pya56m22icnizsyjzqqha5blzb7zpexqcur56uh@uv6vsjf77npa/
> >>>
> >>> In order to simplify this patch you can provide the
> >>> stmmac_dma_ops.dma_init_channel() and
> >>> stmmac_dma_ops.enable_dma_transmission() prototype updates in a
> >>> pre-requisite/preparation patch.
> >> Sorry to keep you waiting for so long, I finally got the machine again.
> >> Regarding atds, is this how it is implemented?
> >>
> >> On the basis of applying PATCH v8:
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >> b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >> index 0323f0a5049c..ce99f4a1b320 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> >> @@ -72,7 +72,8 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct
> >> stmmac_axi *axi)
> >>
> >>   static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> >>                          void __iomem *ioaddr,
> >> -                       struct stmmac_dma_cfg *dma_cfg, u32 chan)
> >> +                       struct stmmac_dma_cfg *dma_cfg,
> >> +                       int atds, u32 chan)
> >>   {
> >>       u32 value;
> >>       int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> >> @@ -101,7 +102,8 @@ static void dwmac1000_dma_init_channel(struct
> >> stmmac_priv *priv,
> >>       if (dma_cfg->mixed_burst)
> >>           value |= DMA_BUS_MODE_MB;
> >>
> >> -    value |= DMA_BUS_MODE_ATDS;
> >> +    if (atds)
> >> +        value |= DMA_BUS_MODE_ATDS;
> >>
> >>       if (dma_cfg->aal)
> >>           value |= DMA_BUS_MODE_AAL;
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> >> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> >> index 84d3a8551b03..8a79c154b553 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> >> @@ -117,7 +117,8 @@ static void dwmac4_dma_init_tx_chan(struct stmmac_priv
> >> *priv,
> >>
> >>   static void dwmac4_dma_init_channel(struct stmmac_priv *priv,
> >>                       void __iomem *ioaddr,
> >> -                    struct stmmac_dma_cfg *dma_cfg, u32 chan)
> >> +                    struct stmmac_dma_cfg *dma_cfg,
> >> +                                    int atds, u32 chan)
> >>   {
> >>       const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
> >>       u32 value;
> >> @@ -135,7 +136,8 @@ static void dwmac4_dma_init_channel(struct stmmac_priv
> >> *priv,
> >>
> >>   static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
> >>                         void __iomem *ioaddr,
> >> -                      struct stmmac_dma_cfg *dma_cfg, u32 chan)
> >> +                      struct stmmac_dma_cfg *dma_cfg,
> >> +                                      int atds, u32 chan)
> >>   {
> >>       const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
> >>       u32 value;
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> >> b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> >> index dd2ab6185c40..d1627b2e50c8 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> >> @@ -35,7 +35,8 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
> >>
> >>   static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> >>                      void __iomem *ioaddr,
> >> -                   struct stmmac_dma_cfg *dma_cfg, u32 chan)
> >> +                   struct stmmac_dma_cfg *dma_cfg,
> >> +                                   int atds, u32 chan)
> >>   {
> >>       u32 value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >> index b0db38396171..fb27ad0e97e8 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >> @@ -178,7 +178,7 @@ struct stmmac_dma_ops {
> >>       void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> >>                int atds);
> >>       void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> >> -              struct stmmac_dma_cfg *dma_cfg, u32 chan);
> >> +              struct stmmac_dma_cfg *dma_cfg, int atds, u32 chan);
> >>       void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>                    struct stmmac_dma_cfg *dma_cfg,
> >>                    dma_addr_t phy, u32 chan);
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> index 3eed202d1f1c..8705e04913d1 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> @@ -3039,7 +3039,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv
> >> *priv)
> >>
> >>       /* DMA CSR Channel configuration */
> >>       for (chan = 0; chan < dma_csr_ch; chan++) {
> >> -        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> >> +        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, atds,
> >> chan);
> >>           stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> >>       }
> >>
> >> @@ -6963,6 +6963,7 @@ int stmmac_xdp_open(struct net_device *dev)
> >>       u32 buf_size;
> >>       bool sph_en;
> >>       u32 chan;
> >> +     int atds;
> >>       int ret;
> >>
> >>       ret = alloc_dma_desc_resources(priv, &priv->dma_conf);
> >> @@ -6981,9 +6982,12 @@ int stmmac_xdp_open(struct net_device *dev)
> >>
> >>       stmmac_reset_queues_param(priv);
> >>
> >> +    if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
> >> +        atds = 1;
> >> +
> >>       /* DMA CSR Channel configuration */
> >>       for (chan = 0; chan < dma_csr_ch; chan++) {
> >> -        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> >> +        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, atds,
> >> chan);
> >>           stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> >>       }
> > Looking more thoroughly at this part I suggest to act a bit
> > differently. Let's move the atds flag to the stmmac_dma_cfg structure.
> > Alternate Descriptor Size (ATDS) is a part of the DMA-configs together
> > with the PBL, ALL, AEME, etc so the structure is the most suitable
> > place for it. Here is what should be done for that:
> > 1. Add stmmac_dma_cfg::atds boolean field.
> > 2. Drop atds argument from the stmmac_dma_ops::init() callback and use
> > the stmmac_dma_cfg::atds field in the callback implementations.
> > 3. Alter stmmac_init_dma_engine() to updating the dma_cfg->atds field
> > instead of the local variable.
> >
> > Please implement that update in a pre-requisite/preparation patch.
> >
> > After that you can freely use the stmmac_dma_cfg::atds field in the
> > stmmac_init_chan() method too.
>
> OK.
>
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index b57e1325ce62..dabd6a3772f2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -66,8 +66,7 @@ struct loongson_data {
>
>    static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
>                         void __iomem *ioaddr,
> -                     struct stmmac_dma_cfg *dma_cfg,
> -                                     int atds, u32 chan)
> +                     struct stmmac_dma_cfg *dma_cfg, u32 chan)
>    {
>        int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>        int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> @@ -96,7 +95,7 @@ static void loongson_gnet_dma_init_channel(struct stmmac_priv
> *priv,
>        if (dma_cfg->mixed_burst)
>            value |= DMA_BUS_MODE_MB;
>
> -    if (atds)
> +    if (dma_cfg->atds)
>            value |= DMA_BUS_MODE_ATDS;
>
>        if (dma_cfg->aal)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 7001a86425ea..ae9240736e64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -299,7 +299,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>     * Called from stmmac via stmmac_dma_ops->init
>     */
>    static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
> -                 struct stmmac_dma_cfg *dma_cfg, int atds)
> +                 struct stmmac_dma_cfg *dma_cfg)
>    {
>        writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
>        writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index fd5ecc043251..66c0c22908b1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -72,8 +72,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct
> stmmac_axi *axi)
>
>    static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
>                           void __iomem *ioaddr,
> -                       struct stmmac_dma_cfg *dma_cfg,
> -                       int atds, u32 chan)
> +                       struct stmmac_dma_cfg *dma_cfg, u32 chan)
>    {
>        int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>        int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> @@ -101,7 +100,7 @@ static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
>        if (dma_cfg->mixed_burst)
>            value |= DMA_BUS_MODE_MB;
>
> -    if (atds)
> +    if (dma_cfg->atds)
>            value |= DMA_BUS_MODE_ATDS;
>
>        if (dma_cfg->aal)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> index dea270f60cc3..f861babc06f9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> @@ -19,7 +19,7 @@
>    #include "dwmac_dma.h"
>
>    static void dwmac100_dma_init(void __iomem *ioaddr,
> -                  struct stmmac_dma_cfg *dma_cfg, int atds)
> +                  struct stmmac_dma_cfg *dma_cfg)
>    {
>        /* Enable Application Access by writing to DMA CSR0 */
>        writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 8a79c154b553..e0165358c4ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -117,8 +117,7 @@ static void dwmac4_dma_init_tx_chan(struct stmmac_priv *priv,
>
>    static void dwmac4_dma_init_channel(struct stmmac_priv *priv,
>                        void __iomem *ioaddr,
> -                    struct stmmac_dma_cfg *dma_cfg,
> -                                    int atds, u32 chan)
> +                    struct stmmac_dma_cfg *dma_cfg, u32 chan)
>    {
>        const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
>        u32 value;
> @@ -136,8 +135,7 @@ static void dwmac4_dma_init_channel(struct stmmac_priv *priv,
>
>    static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>                          void __iomem *ioaddr,
> -                      struct stmmac_dma_cfg *dma_cfg,
> -                                      int atds, u32 chan)
> +                      struct stmmac_dma_cfg *dma_cfg, u32 chan)
>    {
>        const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
>        u32 value;
> @@ -155,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>    }
>
>    static void dwmac4_dma_init(void __iomem *ioaddr,
> -                struct stmmac_dma_cfg *dma_cfg, int atds)
> +                struct stmmac_dma_cfg *dma_cfg)
>    {
>        u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index d1627b2e50c8..7840bc403788 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -20,7 +20,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>    }
>
>    static void dwxgmac2_dma_init(void __iomem *ioaddr,
> -                  struct stmmac_dma_cfg *dma_cfg, int atds)
> +                  struct stmmac_dma_cfg *dma_cfg)
>    {
>        u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
>
> @@ -35,8 +35,7 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>
>    static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
>                       void __iomem *ioaddr,
> -                   struct stmmac_dma_cfg *dma_cfg,
> -                                   int atds, u32 chan)
> +                   struct stmmac_dma_cfg *dma_cfg, u32 chan)
>    {
>        u32 value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index fb27ad0e97e8..3b20fb7f3a61 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -175,10 +175,9 @@ struct dma_features;
>    struct stmmac_dma_ops {
>        /* DMA core initialization */
>        int (*reset)(void __iomem *ioaddr);
> -    void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> -             int atds);
> +    void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg);
>        void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> -              struct stmmac_dma_cfg *dma_cfg, int atds, u32 chan);
> +              struct stmmac_dma_cfg *dma_cfg, u32 chan);
>        void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>                     struct stmmac_dma_cfg *dma_cfg,
>                     dma_addr_t phy, u32 chan);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7c656f970575..957dfabc663d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3013,7 +3013,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>        struct stmmac_rx_queue *rx_q;
>        struct stmmac_tx_queue *tx_q;
>        u32 chan = 0;
> -    int atds = 0;
>        int ret = 0;
>
>        if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
> @@ -3022,7 +3021,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>        }
>
>        if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
> -        atds = 1;
> +        priv->plat->dma_cfg->atds = 1;
>
>        ret = stmmac_reset(priv, priv->ioaddr);
>        if (ret) {
> @@ -3031,14 +3030,14 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>        }
>
>        /* DMA Configuration */
> -    stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg, atds);
> +    stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
>
>        if (priv->plat->axi)
>            stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
>
>        /* DMA CSR Channel configuration */
>        for (chan = 0; chan < dma_csr_ch; chan++) {
> -        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, atds, chan);
> +        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
>            stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
>        }
>
> @@ -6962,7 +6961,6 @@ int stmmac_xdp_open(struct net_device *dev)
>        u32 buf_size;
>        bool sph_en;
>        u32 chan;
> -        int atds;
>        int ret;
>
>        ret = alloc_dma_desc_resources(priv, &priv->dma_conf);
> @@ -6981,12 +6979,9 @@ int stmmac_xdp_open(struct net_device *dev)
>
>        stmmac_reset_queues_param(priv);
>
> -    if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
> -        atds = 1;
> -
>        /* DMA CSR Channel configuration */
>        for (chan = 0; chan < dma_csr_ch; chan++) {
> -        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, atds, chan);
> +        stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
>            stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
>        }
>
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 23bfe3c1465f..c827dc1213b9 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -100,6 +100,7 @@ struct stmmac_dma_cfg {
>        bool eame;
>        bool multi_msi_en;
>        bool dche;
> +    bool atds;
>    };
>
>    #define AXI_BLEN    7
>
>
> Thanks,
>
> Yanteng
>
> >
> > -Serge(y)
> >
> >>
> >> Thanks,
> >>
> >> Yanteng
> >>
> >>>>    	if (dma_cfg->aal)
> >>>>    		value |= DMA_BUS_MODE_AAL;
> >>>> -	writel(value, ioaddr + DMA_BUS_MODE);
> >>>> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> >>>>    	/* Mask interrupts by writing to CSR7 */
> >>>> -	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
> >>>> +	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
> >>>>    }
> >>>>    static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
> >>>> @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
> >>>>    				  dma_addr_t dma_rx_phy, u32 chan)
> >>>>    {
> >>>>    	/* RX descriptor base address list must be written into DMA CSR3 */
> >>>> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
> >>>> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
> >>>>    }
> >>>>    static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> >>>> @@ -125,7 +127,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> >>>>    				  dma_addr_t dma_tx_phy, u32 chan)
> >>>>    {
> >>>>    	/* TX descriptor base address list must be written into DMA CSR4 */
> >>>> -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
> >>>> +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
> >>>>    }
> >>>>    static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
> >>>> @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> >>>>    					    void __iomem *ioaddr, int mode,
> >>>>    					    u32 channel, int fifosz, u8 qmode)
> >>>>    {
> >>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> >>>>    	if (mode == SF_DMA_MODE) {
> >>>>    		pr_debug("GMAC: enable RX store and forward mode\n");
> >>>> @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> >>>>    	/* Configure flow control based on rx fifo size */
> >>>>    	csr6 = dwmac1000_configure_fc(csr6, fifosz);
> >>>> -	writel(csr6, ioaddr + DMA_CONTROL);
> >>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> >>>>    }
> >>>>    static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> >>>>    					    void __iomem *ioaddr, int mode,
> >>>>    					    u32 channel, int fifosz, u8 qmode)
> >>>>    {
> >>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> >>>>    	if (mode == SF_DMA_MODE) {
> >>>>    		pr_debug("GMAC: enable TX store and forward mode\n");
> >>>> @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> >>>>    			csr6 |= DMA_CONTROL_TTC_256;
> >>>>    	}
> >>>> -	writel(csr6, ioaddr + DMA_CONTROL);
> >>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> >>>>    }
> >>>>    static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
> >>>> @@ -271,12 +273,12 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
> >>>>    static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
> >>>>    				  void __iomem *ioaddr, u32 riwt, u32 queue)
> >>>>    {
> >>>> -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
> >>>> +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
> >>>>    }
> >>>>    const struct stmmac_dma_ops dwmac1000_dma_ops = {
> >>>>    	.reset = dwmac_dma_reset,
> >>>> -	.init = dwmac1000_dma_init,
> >>>> +	.init_chan = dwmac1000_dma_init_channel,
> >>>>    	.init_rx_chan = dwmac1000_dma_init_rx,
> >>>>    	.init_tx_chan = dwmac1000_dma_init_tx,
> >>>>    	.axi = dwmac1000_dma_axi,
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> >>>> index 72672391675f..593be79c46e1 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> >>>> @@ -148,11 +148,14 @@
> >>>>    					 DMA_STATUS_TI | \
> >>>>    					 DMA_STATUS_MSK_COMMON)
> >>>> +/* Following DMA defines are chanels oriented */    \
> >>>> +#define DMA_CHAN_OFFSET			0x100   |-------------+
> >>>> +                                                    /              |
> >>>                                                                         |
> >>> Please move all of these ---------------------------------------------+-------------------------+
> >>> to being defined just below the DMA_MISSED_FRAME_CTR macros definition.                         |
> >>> The point is to keep a coherency between dwmac_dma.h and dwmac4_dma.h.                          |
> >>> The later header file has first generic DMA-related macros defined                              |
> >>> (CSR addresses and flags) and then the channel-specific ones (CSR                               |
> >>> addresses and flags). Since in case of the DW GMAC v3.x the                                     |
> >>> multi-channels are implemented as a copy of all the DMA CSRs let's                              |
> >>> preserve the logic of having all CSR address defined first, then the                            |
> >>> CSR flags.                                                                                      |
> >>>                                                                                                   |
> >>>>    #define NUM_DWMAC100_DMA_REGS	9                                                       |
> >>>>    #define NUM_DWMAC1000_DMA_REGS	23                                                      |
> >>>>    #define NUM_DWMAC4_DMA_REGS	27                                                              |
> >>>>                                                                                                 |
> >>>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);                                    |
> >>>> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);                          |
> >>>>    void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                    |
> >>>>    			  u32 chan, bool rx, bool tx);                                          |
> >>>>    void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                   |
> >>>> @@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,  |
> >>>>    			struct stmmac_extra_stats *x, u32 chan, u32 dir);                       |
> >>>>    int dwmac_dma_reset(void __iomem *ioaddr);                                                   |
> >>>>                                                                                                 |
> >>>                                                                                                   |
> >>>> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)                                  \  |
> >>>> +{                                                                                          | |
> >>>> +	return base + chan * DMA_CHAN_OFFSET;                                                 | |
> >>>> +}                                                                                          | |
> >>>> +                                                                                           | |
> >>>> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan) | |
> >>>> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)        | |
> >>>> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)         | |
> >>>> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)          |-+
> >>>> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)        |
> >>>> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)           |
> >>>> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)            |
> >>>> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)             |
> >>>> +                                                                                           /
> >>>>    #endif /* __DWMAC_DMA_H__ */
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> >>>> index 7907d62d3437..b37368137810 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> >>>> @@ -28,65 +28,65 @@ int dwmac_dma_reset(void __iomem *ioaddr)
> >>>>    }
> >>>>    /* CSR1 enables the transmit DMA to check for new descriptor */
> >>>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> >>>> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
> >>>>    {
> >>>> -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
> >>>> +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
> >>>>    }
> >>>>    void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    			  u32 chan, bool rx, bool tx)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
> >>>>    	if (rx)
> >>>>    		value |= DMA_INTR_DEFAULT_RX;
> >>>>    	if (tx)
> >>>>    		value |= DMA_INTR_DEFAULT_TX;
> >>>> -	writel(value, ioaddr + DMA_INTR_ENA);
> >>>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
> >>>>    }
> >>>>    void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    			   u32 chan, bool rx, bool tx)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
> >>>>    	if (rx)
> >>>>    		value &= ~DMA_INTR_DEFAULT_RX;
> >>>>    	if (tx)
> >>>>    		value &= ~DMA_INTR_DEFAULT_TX;
> >>>> -	writel(value, ioaddr + DMA_INTR_ENA);
> >>>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
> >>>>    }
> >>>>    void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    			u32 chan)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    	value |= DMA_CONTROL_ST;
> >>>> -	writel(value, ioaddr + DMA_CONTROL);
> >>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    }
> >>>>    void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    	value &= ~DMA_CONTROL_ST;
> >>>> -	writel(value, ioaddr + DMA_CONTROL);
> >>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    }
> >>>>    void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    			u32 chan)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    	value |= DMA_CONTROL_SR;
> >>>> -	writel(value, ioaddr + DMA_CONTROL);
> >>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    }
> >>>>    void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
> >>>>    {
> >>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
> >>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    	value &= ~DMA_CONTROL_SR;
> >>>> -	writel(value, ioaddr + DMA_CONTROL);
> >>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
> >>>>    }
> >>>>    #ifdef DWMAC_DMA_DEBUG
> >>>> @@ -166,7 +166,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
> >>>>    	int ret = 0;
> >>>>    	/* read the status register (CSR5) */
> >>>> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> >>>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
> >>>>    #ifdef DWMAC_DMA_DEBUG
> >>>>    	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> >>>> @@ -236,7 +236,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
> >>>>    	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> >>>> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> >>>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> >>> Isn't the mask change going to be implemented in the framework of the
> >>> Loongson-specific DMA-interrupt handler in some of the further patches?
> >>>
> >>>
> >>> I'll get back to reviewing the series tomorrow (later today)...
> >>>
> >>> -Serge(y)
> >>>
> >>>>    	return ret;
> >>>>    }
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >>>> index 7be04b54738b..b0db38396171 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> >>>> @@ -198,7 +198,7 @@ struct stmmac_dma_ops {
> >>>>    	/* To track extra statistic (if supported) */
> >>>>    	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
> >>>>    				  void __iomem *ioaddr);
> >>>> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> >>>> +	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
> >>>>    	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>>    			       u32 chan, bool rx, bool tx);
> >>>>    	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >>>> index b334eb16da23..5617b40abbe4 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >>>> @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
> >>>>    				       true, priv->mode, true, true,
> >>>>    				       xdp_desc.len);
> >>>> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> >>>> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> >>>>    		xsk_tx_metadata_to_compl(meta,
> >>>>    					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> >>>> @@ -4706,7 +4706,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>    	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
> >>>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> >>>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> >>>>    	stmmac_flush_tx_descriptors(priv, queue);
> >>>>    	stmmac_tx_timer_arm(priv, queue);
> >>>> @@ -4926,7 +4926,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> >>>>    		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
> >>>>    	}
> >>>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> >>>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> >>>>    	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
> >>>>    	tx_q->cur_tx = entry;
> >>>> -- 
> >>>> 2.31.4
> >>>>


