Return-Path: <netdev+bounces-175717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0AA673BD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B419175387
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33120C00F;
	Tue, 18 Mar 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IsEE+qqa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7021AA1E0;
	Tue, 18 Mar 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300481; cv=none; b=ZePTrnX8p02phOxqvHWkBhVqt/hr/GGaJr2RMER0TP8s3S9MuNXyxo2MqFuhNdSXeo9tXklAuppDz+LAcZaWz10qmeExxPAR3NBBceKUtMlCwlvL23kBDjwOCXNp/EmPIGaP44A88wI3OpGdGmxltsA0U49nKQmV+H8a0mGhJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300481; c=relaxed/simple;
	bh=6ALjYvF/O42KdGcchquum6zpm07Omg1WOKoHwFJKn/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxZnfayCrMuUPJqnge2/AbgRitQZptovoyicquK6bK729Zn1oMcTx7milTrBinB4UIiX4zI85j+/zLRr9pH97boo467DLhgOLOlhspA/H9bfLdQ9xmKMGXJLryIWlxOiyZUkb4KZuVsj7hsxBjN82jA2rtm/8Jd/I15wgxpzX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IsEE+qqa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+zjV6XdBd5X1tEuWbRLub514oy+JKUJQiiTkqqEfuZE=; b=IsEE+qqaotC8toCr05sN5Q3m3I
	NiEkDskOfw0+dHNrOhebC9od93kxiFu23n1VLYjtFb03k8jFELhS0gZI5BPH0EahqakI34Su0OVZV
	LJeVXIv9EaxTG5ociT45LPZu4k54+qfhbFN8L/+UM6YT3rZ9GjPxPWANA2sD9D+gkOZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuVwR-006Fuj-9W; Tue, 18 Mar 2025 13:21:07 +0100
Date: Tue, 18 Mar 2025 13:21:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <b199d9e2-1b95-468a-b826-08abe1795557@lunn.ch>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
 <1653ddbd-af37-4ed1-8419-06d17424b894@lunn.ch>
 <20250318092551.3beed50d@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318092551.3beed50d@fedora.home>

On Tue, Mar 18, 2025 at 09:25:51AM +0100, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Mon, 17 Mar 2025 22:34:09 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Fri, Mar 14, 2025 at 05:23:16PM +0100, Maxime Chevallier wrote:
> > > Hello everyone,
> > > 
> > > This is V3 for the single-byte SMBus support for SFP cages as well as
> > > embedded PHYs accessed over mdio-i2c.  
> > 
> > Just curious, what hardware is this? And does it support bit-banging
> > the I2C pins? If it does, you get a choice, slow but correct vs fast
> > but broken and limited?
> 
> The HW is a VSC8552 PHY that includes a so-called "i2c mux", which in
> reality is that smbus interface.
> 
>              +---------+
>  +-----+     |         |     +-----+
>  | MAC | --- | VSC8552 | --- | SFP |
>  +-----+     |         |     +-----+
>     |        |         |        |
>     +-mdio---|         |-smbus--+
>              +---------+
> 
> it has 4 SCL and 1 SDA lines, that you can connect to 4 different SFP
> cages.
> 
> You perform transfers by using 2 dedicated MDIO registers , one
> register contains xfer info such as the address to access over smbus,
> the direction of the xfer, and the other one contains data :
>  - lower byte is write data
>  - upper byte is read-back data
> 
> and that's all you have :( so the HW can only really do one single byte
> transfer at a time, then you re-configure the 2 registers above, rinse
> and repeat.
> 
> Looks like the datasheet is publicly available :
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/60001809A.pdf
> 
> The whole xfer protocol is described in page 35.
> 
> On the board itself, the i2c for the SFP cage is connected to that PHY
> smbus.
> 
> Now it looks like there's some pinmux within the PHY and we can use the
> PHY as a gpio controller, so we could consider using a bitbang approach
> indeed (provided that SFP is on PHY smbus bus 0 or 1).
> 
> I didn't consider that, it's probably worth giving a try, even if as
> you say it's probably be very slow, each bit being set amounting to a
> mdio xfer towards the PHY.

This going to be very slow. My guess is people will live with limited
functionality. But it could be interesting to implement the GPIO
support and see how slow it is.

It might also be worth pointing out to microchip how broken this is,
and see if they can do anything about it in the firmware running in
PHY. 2 byte SMBUS would solve the problems.

> Do we still want the current series ? Looks like some other people were
> interested in that.

Yes, it is useful.

	Andrew

