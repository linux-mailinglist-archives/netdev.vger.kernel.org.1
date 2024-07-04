Return-Path: <netdev+bounces-109242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E281A927843
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF61F24B39
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2501AEFF9;
	Thu,  4 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZQT63EZy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E11AEFF5;
	Thu,  4 Jul 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103084; cv=none; b=J6T4tcL6vCesS18fxFemVzC6Hl8xBQWe+lFKpZ1tqkETty9vMJyBK/kgXEVWEkPE3QfQy0RtO7pUkyhxYpsvqZx47ynPz5DYpFYNT7QG1Crz+G20l/i8GFzlr1jm0HavP/mjvhQzZzH+EXFKjxjFi7/YovZQ4lTErlKLUDectoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103084; c=relaxed/simple;
	bh=WkASUccS1iaI0JkyEUG7v6JqDw0zQ1RrOOfIwZhPcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO2h7nR0YlJbRObyCVq0syhw1fFQGxsiVD3hUMdupSEt6+0bKlMvd+QWV6gwOozRJijh+8lGYXWCJs9VxIz1IW3Z6oEngf0uERCDutwWfD+pSW7OSdzbORsTMJsssRcr+2ZtjGnjgNJnVLlO+y22n7s9PAefPoNNapo3KG9j2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZQT63EZy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xe3YJWWLCTD5Uj3YuzCc3NRG9utaZux7QG2xA/rd4XM=; b=ZQ
	T63EZytTgwDmnKkR6YBG7Kvn3tXnOx1bs54ZZEmFEadHyBeluMIogHjFIUShwN9PuUttSdWntHLmX
	p7R+JxJlZJFUAE5WpTMihYrdAii1Cl9MqCH/9YV8PaOjO4Srx/fkozqTRWxl9pO7r3SCjQGpc9a60
	5OKLTMJNHdhzdNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPNNn-001oh6-Oq; Thu, 04 Jul 2024 16:24:23 +0200
Date: Thu, 4 Jul 2024 16:24:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <f598ebe0-4e43-45e9-878e-49ec06383ef3@lunn.ch>
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-5-kamilh@axis.com>
 <5a77ba27-1a0e-4f29-bf94-04effb37eefb@lunn.ch>
 <26dcc3ee-6ea8-435e-b9e9-f22c712e5b4c@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26dcc3ee-6ea8-435e-b9e9-f22c712e5b4c@axis.com>

On Thu, Jul 04, 2024 at 04:01:13PM +0200, Kamil Horák (2N) wrote:
> 
> On 6/22/24 21:12, Andrew Lunn wrote:
> > On Fri, Jun 21, 2024 at 01:26:33PM +0200, Kamil Horák (2N) wrote:
> > > Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> > > Create set of functions alternative to IEEE 802.3 to handle
> > > configuration of these modes on compatible Broadcom PHYs.
> > What i've not seen anywhere is a link between BroadR-Reach and LRE.
> > Maybe you could explain the relationship here in the commit message?
> > And maybe also how LDS fits in.
> 
> Tried to extend it a bit... LRE should be for "Long Reach Ethernet" but
> Broadcom
> 
> only uses the acronym in the datasheets... LDS is "Long-Distance Signaling",
> really screwed
> 
> term for a link auto-negotiation...

You are allowed to ignore the data sheet. If using AN makes the code
more understandable, use AN. Just add a comment in the commit message.

> > > +static int bcm54811_read_abilities(struct phy_device *phydev)
> > > +{
> > > +	int i, val, err;
> > > +	u8 brr_mode;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
> > > +		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
> > I think that needs a comment since it is not clear what is going on
> > here. What set these bits in supported?
> 
> This is an equivalent of genphy_read_abilities for an IEEE PHY, that is, it
> fills the phydev->supported bit array exactly
> 
> as genphy_read_abilities does. The genphy_read_abilities is even called if
> the PHY is not in BRR mode.

I lost the context. But genphy_read_abilities() is only called if
phydrv->get_features is not set. Don't you make use of this
bcm54811_read_abilities for get_features? So i'm wondering, what set
these bits in the first place?


> > > +
> > > +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (brr_mode) {
> > I would expect the DT property to be here somewhere. If the DT
> > property is present, set phydev->supported to only the BRR modes,
> > otherwise set it to the standard baseT modes. That should then allow
> > the core to do most of the validation. This is based on my
> > understanding the coupling hardware makes the two modes mutually
> > exclusive?
> 
> From my point of view relying on DT property only would imply to validate
> the setting with what is read from the PHY on
> 
> all code locations where it is currently read by bcm5481x_get_brrmode.

In general, the DT value is the source of truth. It does not matter
how the PHY is strapped etc, we should reconfigure it how the DT
property indicates. So i really would set phydev->supported based on
it.

> > > +	/* With BCM54811, BroadR-Reach implies no autoneg */
> > > +	if (brr)
> > > +		phydev->autoneg = 0;
> > So long as phydev->supported does not indicate autoneg, this should
> > not happen.
> 
> I also thought so but unfortunately our batch of bcm54811 indicates possible
> autoneg in its status register
> 
>  (LRESR_LDSABILITY) but refuses to negotiate. So this is rather a
> preparation for bcm54810 full support. Unlike bcm54811,

If the hardware is broke, feel free to ignore the bit. I would also
keep it KISS. If somebody does want bcm54810 to auto-neg, they can add
the feature, and ask you to test for regressions with the bcm54811.

	Andrew

