Return-Path: <netdev+bounces-127857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F63976E47
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437611C231B5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BC1AD25F;
	Thu, 12 Sep 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A9gI7mt5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39281898F8;
	Thu, 12 Sep 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156710; cv=none; b=Xv2wkhvW0LTQiqVXIEORpaitem/rkTOnUP9IywZBb3IlAUkzack2R6KKG/8bhjbhUTMlJAmmUkgmspEpO7DEwltcAxrqgXwpVzciobjSwDgCCx7o4xEUOTMoQ+7DOr8DYbSGKveA6ym7SgrRuV1c/d/mycXjU9XKAFVwb8rBM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156710; c=relaxed/simple;
	bh=1Ko5Dls2c1hX5w2NRaDx//iGt1OVI1HCAjuDj8EumLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXArTx8eDhqPQbZKkr9DeAfEN7KRt1EMI7oHWpZAimnezPfemZ+QsE+DtOTD4xLXH9q4C89lrPQQG/dqkzs6YAlWgUl/q2hgaJqTxXqIZubhPPFKcs9c0F/78zWyVzhN+hBkBefo6pWRN9iy20SEsrP8UbI6YzhlCP+lBBJoPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A9gI7mt5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IVv1rGK6/cvSY2NOa9yHoyQQRJMjdh5Sedz2/XGUvsw=; b=A9gI7mt58YP+mQ4LWZMeYkziIy
	rxehZaiam3eGsSZ8JwZd7ITzJmGHQ2vuMs19suQBw/eofyF3bIhGz94r4jqlRzY3YxGNPHCg/wPCu
	3QTmUxu5gVFq8zoSMM7bicyWCJ2kgY0IF6g1K+042uMjIZCZjB9HP9vJkuaJwfPQFXYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1somD0-007JzN-F8; Thu, 12 Sep 2024 17:58:14 +0200
Date: Thu, 12 Sep 2024 17:58:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, Daniel.Machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <ad0813aa-1a11-4a26-8bc7-528ef51cf0c2@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
 <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
 <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
 <PH8PR11MB7965848234A8DF14466E49C095642@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB7965848234A8DF14466E49C095642@PH8PR11MB7965.namprd11.prod.outlook.com>

> > > > > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > > > > +         adapter->is_sfp_support_en) {
> > > > > +             netif_err(adapter, drv, adapter->netdev,
> > > > > +                       "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> > > > > +             return -EINVAL;
> > > >
> > > > is_sgmii_en actually means PCS? An SFP might need 1000BaseX or
> > > > SGMII,
> > >
> > > No, not really.
> > > The PCI11010/PCI1414 chip can support either an RGMII interface or an
> > > SGMII/1000Base-X/2500Base-X interface.
> > 
> > A generic name for SGMII/1000Base-X/2500Base-X would be PCS, or maybe SERDES. To me, is_sgmii_en
> > means SGMII is enabled, but in fact it actually means SGMII/1000Base-X/2500Base-X is enabled. I just
> > think this is badly named. It would be more understandable if it was is_pcs_en.
> > 
> > > According to the datasheet,
> > > the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
> > > Therefore, the flag is named "is_sgmii_en".
> > 
> > Just because the datasheet uses a bad name does not mean the driver has to also use it.
> > 
> >         Andrew
> 
> The hardware architect, who is a very bright guy (it's not me :-), just called the strap SGMII_EN in order not to make the name too long and to contrast it with the opposite polarity of the bit which means the interface is set to RGMII; but in the description of the strap he clearly stated what it is:
> 	SGMII_EN_STRAP
> 	0 = RGMII
> 	1 = SGMII / 1000/2500BASE-X
> 
> I don't think PCS or Serdes (both of which get used in other technologies - some of which are also included in this chip and are therefore bound to create even more confusion if used) are good choices either.

SERDES i understand, PCI itself is a SERDES. But what are the other
uses of PCS? At least in the context of networking, PCS is reasonably
well understood.

> That being said, if it makes it more we can certainly call this flag "is_sgmii_basex_en". How's that sound ?

Better. But i still think PCS is better.

But you need to look at the wider context:

> > > > > +                       "Invalid eeprom cfg: sfp enabled with sgmii disabled");

SGMII is wrong here as well. You could flip it around:

> > > > > +                       "Invalid eeprom cfg: sfp enabled with RGMII");

In terms of reviewing this code, i have to ask myself the question,
does it really mean SGMII when it says SGMII? When you are talking
about Base-T, i don't know of any 1000BaseX PHYs, so you can be sloppy
with the term SGMII. But as soon as SFPs come into the mix, SGMII vs
1000BaseX becomes important, so you want the code to really mean SGMII
when it says SGMII.

     Andrew

