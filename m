Return-Path: <netdev+bounces-80634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1359880132
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8245BB238DC
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C65657B2;
	Tue, 19 Mar 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM+tvmRh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D60651BB
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863613; cv=none; b=ISZj6fu3fWsTMJJPSlZdMYVsN63lJprWmFgNEiPj5o2lsZ9QrfNeK/PkJ3OYae5ct2C1Yz4JSL2lcVzIJMVGej5r4orHoAUufbo+mfRUvm3yHIFHCxXAsioWWZuTR2TLuHGOGBfoNLwotTzJerwMEppjytGwp36VFBgm52RSv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863613; c=relaxed/simple;
	bh=BRjHKvX+dZ1znZmOwfhjEQwBK/dwYZvJleAinl5LA54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA9VxSrXA4NRml3RwvfI8rDX3oMjmukCB9NoK32eMzTwrcTu+PNEO0AR1A9atwvx6pHxPjTR2dxCc9K2n1Ws5uC/kfo8Ue8zC+GgZkKDYn3tpNYe43UXDbtIbXPeJQiEw08e6oeZVbUkMiw6ydNbo//Q0a5tk+ATTF01fY/S6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM+tvmRh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512f892500cso6395636e87.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710863610; x=1711468410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EteZ6T2vrpZazaAzh4xRrIZ2uaRVPaqJmDFJA2Uwx+k=;
        b=mM+tvmRhSZNahq7Dt980taoxTUyjb/WVP2ptTzJZm1BoMC5MoruhW0wecsHk3csMoC
         sTtSKtS/n3tYPKy6NcuucPcDP8xlb2456+jm3XJtZdAujvUwEpjMFFId0lQFNuZwyD6E
         qglLqVos6ugV4vdFJuakw+V3kk5TdYHCklzMdfdw1BiCf/NASoSqqHz3sL+Z79NeYiRg
         ftz73ULMugBdM6F5TMxZn96ZG07aymkIl/trN11fqr4JG0FYhnyYMEC5PnDr63HXg8y3
         XS8Dpul8fmQhpS82Bucpah3RYmKEluZo0CFk/iqB6Wa6UV4ivYupv+NJiDDkDBd5/C39
         smsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710863610; x=1711468410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EteZ6T2vrpZazaAzh4xRrIZ2uaRVPaqJmDFJA2Uwx+k=;
        b=b+nEWbh2tGJByRVp/jTIB0axpd6oOZmX6S64Ud4KukEsTMTAeAdkT4hnLv7uSmYrNO
         3S91stL8/ZXSNNzZQe2ZpFCLmM0tEo7hlloa/q2XLukkU2aS9tR10B5ZQXDnefwPE78E
         z8WjbxSReqhT35Rmb8dD3ezc1PtOvZFPDADvx9DxiSIDfA52HQkNfM8pnz6FkUFFNvee
         ptlQY7hGBE5A8vGMAolDTh9wMH7HcyTHN9UuCktNqmj3T9uKEC3zzE8PNgyIg4SJbFpV
         +E/bDUEMoceQ84EJa+6UEwcxm+z1EXchiws80vq0Ip942lonK1P5xw45mEQ628ZibSx7
         N5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW+PV9EYManSq6/FQbRZNsjz2AfaCJJL5fRTYd7/wlQ9IbPaNTrLzrtdFuPOCtf74msTjqBENVkXoNMhmYJAUE8D8rSBHHy
X-Gm-Message-State: AOJu0YzF4F5pNGIT4zZiwulpdUIkzmrFkObHVlW4hu7WnyiL9KCdN8og
	44Em6/TX5FN2DsQSwYoeoo/Qn4p5fKORuydhJPH5hqMuPiPLtBik
X-Google-Smtp-Source: AGHT+IGDj0ApWd4yb3FUKMSoXCt+yCwJrb76494oIiR06zsbcPM1oG8kMd4eRXOEqibww4S+X9aL2A==
X-Received: by 2002:ac2:491b:0:b0:513:cfcd:f25f with SMTP id n27-20020ac2491b000000b00513cfcdf25fmr7740214lfi.54.1710863609536;
        Tue, 19 Mar 2024 08:53:29 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a26-20020a195f5a000000b005139c3c584bsm1321093lfj.241.2024.03.19.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:53:28 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:53:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
Message-ID: <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>

On Thu, Mar 14, 2024 at 09:13:58PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/14 17:33, Yanteng Si 写道:
> > 在 2024/2/6 05:28, Serge Semin 写道:
> > > On Tue, Jan 30, 2024 at 04:48:19PM +0800, Yanteng Si wrote:
> > >> Request allocation for MSI for specific versions.
> > >>
> > > Please elaborate what is actually done in the patch. What device
> > > version it is dedicated for (Loongson GNET?), what IRQs the patch
> > > adds, etc.
> > gnet_device   core IP    IRQ
> > 7a2000        0x37    legacy
> > 2k2000        0x10    multi_msi
> > >
> > > BTW will GNET device work without this patch? If no you need to either
> > > merge it into the patch introducing the GNET-device support or place
> > > it before that patch (6/11).
> > OK, GNET device work need this patch.
> > >   >> Some features of Loongson platforms are bound to the GMAC_VERSION
> > >> register. We have to read its value in order to get the correct channel
> > >> number.
> > > This message seems misleading. I don't see you doing that in the patch below...
> > Because part of our gnet hardware (7a2000) core IP is 0x37
> > >
> > >> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
> > >> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
> > >> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
> > >> ---
> > >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 57 +++++++++++++++----
> > >>   1 file changed, 46 insertions(+), 11 deletions(-)
> > >>
> > >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> index 584f7322bd3e..60d0a122d7c9 100644
> > >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > >> @@ -98,10 +98,10 @@ static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
> > >>   	if (dma_cfg->aal)
> > >>   		value |= DMA_BUS_MODE_AAL;
> > >>
> > >   >> -	writel(value, ioaddr + DMA_BUS_MODE);
> > >> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> > >>   >>   	/* Mask interrupts by writing to CSR7 */
> > >> -	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
> > >> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_CHAN_INTR_ENA(chan));
> > > Em, why is this here? There is a patch
> > > [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add Loongson-specific register definitions
> > > in this series which was supposed to introduce the fully functional
> > > GNET-specific callbacks. Move this change in there.
> > OK.
> > >
> > >>   }
> > >>   >>   static int dwlgmac_dma_interrupt(struct stmmac_priv *priv,
> > void __iomem *ioaddr,
> > >> @@ -238,6 +238,45 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> > >>   	return 0;
> > >>   }
> > >>   >> +static int loongson_dwmac_config_multi_msi(struct pci_dev
> > *pdev,
> > > This method seems like the GNET-specific one. What about using the
> > > appropriate prefix then?
> > OK. loongson_gnet_config_multi_msi()
> > 
> > >
> > >> +					   struct plat_stmmacenet_data *plat,
> > >> +					   struct stmmac_resources *res,
> > >> +					   struct device_node *np,
> > >> +					   int channel_num)
> > > Why do you need this parametrization? Since this method is
> > > GNET-specific what about defining a macro with the channels amount and
> > > using it here?
> > 
> > OK.
> > 
> > #define CHANNEL_NUM    8
> > 
> > >
> > >> +{
> > >> +	int i, ret, vecs;
> > >> +
> > >> +	vecs = roundup_pow_of_two(channel_num * 2 + 1);
> > >> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > >> +	if (ret < 0) {
> > >> +		dev_info(&pdev->dev,
> > >> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> > >> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > In what conditions is this possible? Will the
> > > loongson_dwmac_config_legacy() method work in that case? Did you test
> > > it out?

> > Failed to apply for msi interrupt when the interrupt number is not enough，For
> > example, there are a large number of devices。

Then those platforms will _require_ to have the DT-node specified. This
will define the DT-bindings which I doubt you imply here. Am I wrong?

Once again have you tested the loongson_dwmac_config_legacy() method
working in the case of the pci_alloc_irq_vectors() failure?
	

> > >> +	}
> > >> +
> > >> +	plat->rx_queues_to_use = channel_num;
> > >> +	plat->tx_queues_to_use = channel_num;
> > > This is supposed to be initialized in the setup() methods. Please move
> > > it to the dedicated patch.

> > No, referring to my previous reply, only the 0x10 gnet device has 8 channels,
> > and the 0x37 device has a single channel.

Yes. You have a perfectly suitable method for it. It's
loongson_gnet_data(). Init the number of channels there based on the
value read from the GMAC_VERSION.SNPSVER field. Thus the
loongson_gnet_config_multi_msi() will get to be more coherent setting
up the MSI IRQs only.

Am I missing something in the last two notes chunks regard? If yes,
let's submit v9 as you see it. We'll get back to this part there then.

-Serge(y)

> > >
> > >> +
> > >> +	res->irq = pci_irq_vector(pdev, 0);
> > >> +	res->wol_irq = res->irq;
> > > Once again. wol_irq is optional. If there is no dedicated WoL IRQ
> > > leave the field as zero.
> > OK.
> > 
> > res->wol_irq = 0;
> > 
> > >
> > >> +
> > >> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > >> +	 * --------- ----- -------- --------  ...  -------- --------
> > >> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > >> +	 */
> > >> +	for (i = 0; i < channel_num; i++) {
> > >> +		res->rx_irq[channel_num - 1 - i] =
> > >> +			pci_irq_vector(pdev, 1 + i * 2);
> > >> +		res->tx_irq[channel_num - 1 - i] =
> > >> +			pci_irq_vector(pdev, 2 + i * 2);
> > >> +	}
> > >> +
> > >> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > >> +	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
> > > What's the point in printing this message especially with the __func__
> > > prefix?  You'll always be able to figure out the allocated IRQs by
> > > means of procfs. I suggest to drop it.
> > 
> > OK.
> > 
> > >
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >>   static void loongson_default_data(struct pci_dev *pdev,
> > >>   				  struct plat_stmmacenet_data *plat)
> > >>   {
> > >> @@ -296,11 +335,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
> > >>   				struct stmmac_resources *res,
> > >>   				struct device_node *np)
> > >>   {
> > >> -	int ret;
> > >> -
> > >> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > >>   >> -	return ret;
> > >> +	return 0;
> > >>   }
> > >>   >>   static struct stmmac_pci_info loongson_gmac_pci_info = {
> > >> @@ -380,11 +416,7 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> > >>   				struct stmmac_resources *res,
> > >>   				struct device_node *np)
> > >>   {
> > >> -	int ret;
> > >> -
> > >> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > >> -
> > >> -	return ret;
> > >> +	return 0;
> > >>   }
> > > Here you are dropping the changes you just introduced leaving the
> > > config() methods empty... Why not to place the
> > > loongson_dwmac_config_legacy() invocation in the probe() method right
> > > at the patches introducing the config() functions and not to add the
> > > config() callback in the first place?
> > OK, I will try.
> > 
> > Thanks,
> > 
> > Yanteng
> > 
> > >
> > > -Serge(y)
> > >
> > >>   >>   static struct stmmac_pci_info loongson_gnet_pci_info = {
> > >> @@ -483,6 +515,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> > >>   		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> > >>   >>   		plat->setup = loongson_setup;
> > >> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
> > >> +	} else {
> > >> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> > >>   	}
> > >>   >>   	plat->bsp_priv = ld;
> > >> -- >> 2.31.4
> > >>
> 

