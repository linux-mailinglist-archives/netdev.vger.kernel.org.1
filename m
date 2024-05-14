Return-Path: <netdev+bounces-96375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFAE8C57FF
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A721F23501
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAED17B4F4;
	Tue, 14 May 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gcmhjIcP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030817B511
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697171; cv=none; b=uHQY3CUskLqFz2bQWQABopzAaFfcsDcQyW/waLPzslZ/Hpr41nX1ScTRT5znSi1kZ/MFRS9aVZYe8LoBAsR9tcHMP5anfeyrPmDBhyCL0+zet4dy8pw5a7ESRGodgieY+8iqSX7AqFZzmGHYF/XAMmvKwx8qjP/i3jV9Fad/zHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697171; c=relaxed/simple;
	bh=71zuJEDtVqfHpuEPjL0MSi/jgtbqqyAIdlP2WSvJ3ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtHp7icDZ3U4bR+Y1N1IBghoee0Zl1AIOQMNZjmgNNL9w7csylgd09EIF3D/Jr8VWJ/gPMTnfv7EtTJg3iBB+tBBwIO+XA+hnPIthTFOivVJ39MSazgdPQQqXAwIH2FnIr9Sds5LQQYbhSbMx+863v4SYKUJ8rXgYcIrj+0zK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gcmhjIcP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/xN8COSsVzk9D4Vt79fY6DF4VWKozFVJ2KKqCvScurs=; b=gc
	mhjIcPkRAPcXdKU36sKJNBa7VrWk6hDz6FqADkOJicpG5wC7mkCk+vd6klFgvEqd4mppDbK4GDcgy
	cBzsyZjzzGybjKw1HLcqudWQIypWKVZmJPhaf8p4fYTeQJQPY94Y0+mHXScU5tVnWXuzdyfVmMcga
	RAgVhs60630u8g8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6tCk-00FOOi-RU; Tue, 14 May 2024 16:32:34 +0200
Date: Tue, 14 May 2024 16:32:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] net: ethernet: cortina: Implement
 .set_pauseparam()
Message-ID: <c086a2e5-87e7-4926-bf80-c0b406c2c8e9@lunn.ch>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org>
 <9d7d7e8b-8838-410b-a694-2f2da21602c1@lunn.ch>
 <CACRpkdZnhH=OvivSK0=e_NUEB3M--v+MawjuZZOPNoRCWn1NhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZnhH=OvivSK0=e_NUEB3M--v+MawjuZZOPNoRCWn1NhA@mail.gmail.com>

On Tue, May 14, 2024 at 10:55:18AM +0200, Linus Walleij wrote:
> On Mon, May 13, 2024 at 7:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > On Mon, May 13, 2024 at 03:38:52PM +0200, Linus Walleij wrote:
> > > The Cortina Gemini ethernet can very well set up TX or RX
> > > pausing, so add this functionality to the driver in a
> > > .set_pauseparam() callback.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  drivers/net/ethernet/cortina/gemini.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> > > index 85a9777083ba..4ae25a064407 100644
> > > --- a/drivers/net/ethernet/cortina/gemini.c
> > > +++ b/drivers/net/ethernet/cortina/gemini.c
> > > @@ -2146,6 +2146,20 @@ static void gmac_get_pauseparam(struct net_device *netdev,
> > >       pparam->autoneg = true;
> > >  }
> > >
> > > +static int gmac_set_pauseparam(struct net_device *netdev,
> > > +                            struct ethtool_pauseparam *pparam)
> > > +{
> > > +     struct phy_device *phydev = netdev->phydev;
> > > +
> > > +     if (!pparam->autoneg)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     gmac_set_flow_control(netdev, pparam->tx_pause, pparam->rx_pause);
> >
> > It is not obvious to my why you need this call here?
> 
> I don't know if I don't understand the flow of code here...
> 
> The Datasheet says that these registers shall be programmed to
> match what is set up in the PHY.

I expect the registers should match what the PHY has negotiated, not
what it is advertising. So i would expect to see
gmac_set_flow_control() only in the adjust link callback once
negotiation has completed.

	Andrew

