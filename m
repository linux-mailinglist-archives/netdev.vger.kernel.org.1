Return-Path: <netdev+bounces-209743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B4B10AE5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67C51CE0604
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90A2D63E5;
	Thu, 24 Jul 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MX21IWN3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DF2D5C9E;
	Thu, 24 Jul 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362276; cv=none; b=GIafN1HEOqBesslExpQK7ttnGWXF6I56xPzQ73CceL6m6sxDdvMpnANASGu39MIH2nbyO4j1viOrIZiblyX1pFSd0esvS9Jadu1aDPren3hqS80rsnQH+Jy+KUuesdirPy5QV74tBO3MXyXWJBuw80toY0jkbc4IahxHI90KyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362276; c=relaxed/simple;
	bh=YqndJdzevr/o8/D1lSHMdx6vOXlt/yYGMpa2a9IrOF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyh6ixSw5iKPKdtVOHcXTpwEq3VygSHaYDcoCgsGbY+lXgKYMyPeC6rVopO81fuHuIWJwQ6mmLTL77OQLK5BjJ9cHq50qRu+ID738IdreCi7YWIDCtdomkyVeYvpePDCDIS/NtfiAfZFzxqywzZ7eLffUvO4UF4uzFgfGeL89Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MX21IWN3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Pry+UWl4/PhjwuL0w/0sUZRIxTvRnGADRC+HIcDB7CM=; b=MX
	21IWN3VrE6rdcjbsKU9L27IlOde7srx59LJG4qgzkhuFu0gJuTCUQrYiLRd4oPsQuHLMeL6HXO/Mg
	wEnM9kP2V5Ui1HWdBowHjNR9SEy9Z3+IVfrmu5hseZc7owCvxt4PXhSNygTJce23VEoa/m6olhQ9e
	DOT5zrabggA85wk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uevcS-002lGI-P8; Thu, 24 Jul 2025 15:04:20 +0200
Date: Thu, 24 Jul 2025 15:04:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
Message-ID: <623de96b-61f8-45af-a3aa-520f61e318a4@lunn.ch>
References: <20250723100056.6651-1-yangtiezhu@loongson.cn>
 <20250723100056.6651-2-yangtiezhu@loongson.cn>
 <f65deb0d-29d1-4820-95e9-f1dd94967957@lunn.ch>
 <b98a5351-f711-ecb1-75fa-68c69263e950@loongson.cn>
 <5ef8ae99-256e-8ff7-861f-025e7b7cfb6f@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef8ae99-256e-8ff7-861f-025e7b7cfb6f@loongson.cn>

On Thu, Jul 24, 2025 at 05:05:57PM +0800, Tiezhu Yang wrote:
> On 2025/7/24 上午10:26, Tiezhu Yang wrote:
> > On 2025/7/23 下午10:53, Andrew Lunn wrote:
> > > On Wed, Jul 23, 2025 at 06:00:55PM +0800, Tiezhu Yang wrote:
> > > > If the MAC controller does not connect to any PHY interface, there is a
> > > > missing clock, then the DMA reset fails.
> 
> ...
> 
> > > > +    if (value & DMA_BUS_MODE_SFT_RESET)
> > > > +        return -EINVAL;
> > > 
> > > What happens with this return value? Do you get an error message which
> > > gives a hint the PHY clock is missing? Would a netdev_err() make sense
> > > here?
> > 
> > Yes, I will use dev_err() rather than netdev_err() (because there is no
> > net_device member here) to do something like this:
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 6d10077666c7..4a7b2b11ecce 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -513,8 +513,11 @@ static int loongson_dwmac_fix_reset(void *priv,
> > void __iomem *ioaddr)
> >   {
> >          u32 value = readl(ioaddr + DMA_BUS_MODE);
> > 
> > -       if (value & DMA_BUS_MODE_SFT_RESET)
> > +       if (value & DMA_BUS_MODE_SFT_RESET) {
> > +               struct plat_stmmacenet_data *plat = priv;
> > +               dev_err(&plat->pdev->dev, "the PHY clock is missing\n");
> >                  return -EINVAL;
> > +       }
> > 
> >          value |= DMA_BUS_MODE_SFT_RESET;
> >          writel(value, ioaddr + DMA_BUS_MODE);
> 
> Oops, the above changes can not work well.
> 
> It can not use netdev_err() or dev_err() to print message with device info
> in loongson_dwmac_fix_reset() directly, this is because the type of "priv"
> argument is struct plat_stmmacenet_data and the "pdev" member of "priv" is
> NULL here, it will lead to the fatal error "Unable to handle kernel paging
> request at virtual address" when printing message.

Maybe it would be better to change fix_soc_reset() to have struct
stmmac_priv * as its first parameter. There are not too many user of
it, so it is not too big a change.

>         ret = stmmac_reset(priv, priv->ioaddr);
>         if (ret) {
> +               if (ret == -EINVAL)
> +                       netdev_err(priv->dev, "the PHY clock is missing\n");
> +

The problem with this is, you have no idea if EINVAL might of come
from somewhere else.

	Andrew

