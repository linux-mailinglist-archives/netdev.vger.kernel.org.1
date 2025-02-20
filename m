Return-Path: <netdev+bounces-168177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24231A3DEA0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C23842382D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8221204844;
	Thu, 20 Feb 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ndlJCNnt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886011E9B12;
	Thu, 20 Feb 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065367; cv=none; b=G7GxQGgf9hzvafxjD6E3SOCcC2xsTg3keU7KNqG5DkDh1nngwXAdrsManXqFztN+JWKwE9594wFuExlXigFA8LmK1pWFu4Meitp4NpuDXpd/y/+IJuNOaK4Kb4y0gXTDE7/BJyyCVvcff7syORhgWs5uWwWPZUjswjFIniiGEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065367; c=relaxed/simple;
	bh=JYf1Ya8/CyfiemDxGThXCwlg5i8rbP/VIeDg9O4gBDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fickCxXyqfLyI+f2+32SOSaRn/+6tq3oRyb5pJp+DM6wzAWTVVj7bxq752pI2MsALInAqQIo+kx1iYrtumxpbO7364BcbKN5RIgr9EcNPlLvO9FAwbN+6CDw+X4YGx4n0bcqC2ecN1fPqYZSsXjx3mMsLssqGp52C2sNmxgiYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ndlJCNnt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CcJP8ksRnf3qKh0YWjDzBD4E7z4Wn6EhKqjBJn9G/OU=; b=ndlJCNntkmM/DRZ0gG4+H/dNDm
	07HBM5inyUCips2IfypxxuGmwf0o3iDTg63voCApCvbdKi0IldOZgwmK5DXTU/iQ08bCNXMTR0T5q
	hscY0LO67/kB3mDALYADHmeciWnFkIaGwpBE1VZcP1KQ3esnpCeE2p5QvDyCxGQrvILFIyODDA5w8
	wvK3mCori91Ke6hJTio8u2bkJ7EdjXG7vgw8RgNW8/h7sBsRxRS2kh/NK86SiyctyrawW9wcLlBIx
	x/kpI4lz0O23y44dY0MQqARCzmcBKj+nrb4sv3wco6jCSrrU/6ezHUuB5sSXfzUsiC3VTZ73Y7TZ6
	5b3axhdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39386)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tl8UD-0001Se-1y;
	Thu, 20 Feb 2025 15:29:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tl8UA-000151-1q;
	Thu, 20 Feb 2025 15:29:10 +0000
Date: Thu, 20 Feb 2025 15:29:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: marvell-88q2xxx: Prevent hwmon
 access with asserted reset
Message-ID: <Z7dKRrXIUCaVeRfH@shell.armlinux.org.uk>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
 <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
 <Z7b3sU0w2daShkBH@shell.armlinux.org.uk>
 <20250220152214.GA40326@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152214.GA40326@debian>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 20, 2025 at 04:22:14PM +0100, Dimitri Fedrau wrote:
> Hi Russell,
> 
> Am Thu, Feb 20, 2025 at 09:36:49AM +0000 schrieb Russell King (Oracle):
> > On Thu, Feb 20, 2025 at 09:11:12AM +0100, Dimitri Fedrau wrote:
> > > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > > This might happen if the user admins down the interface and wants to read
> > > the temperature. Prevent reading the temperature in this case and return
> > > with an network is down error. Write operations are ignored by the device
> > > when reset is asserted, still return a network is down error in this
> > > case to make the user aware of the operation gone wrong.
> > 
> > If we look at where mdio_device_reset() is called from:
> > 
> > 1. mdio_device_register() -> mdiobus_register_device() asserts reset
> >    before adding the device to the device layer (which will then
> >    cause the driver to be searched for and bound.)
> > 
> > 2. mdio_probe(), deasserts the reset signal before calling the MDIO
> >    driver's ->probe method, which will be phy_probe().
> > 
> > 3. after a probe failure to re-assert the reset signal.
> > 
> > 4. after ->remove has been called.
> > 
> 
> There is also phy_device_reset that calls mdio_device_reset.

Ok, thanks for pointing that out.

> > That is the sum total. So, while the driver is bound to the device,
> > phydev->mdio.reset_state is guaranteed to be zero.
> > 
> > Therefore, is this patch fixing a real observed problem with the
> > current driver?
> >
> Yes, when I admin up and afterwards down the network device then the PHYs
> reset is asserted. In this case phy_detach is called which calls
> phy_device_reset(phydev, 1), ...

I'm still concerned that this solution is basically racy - the
netdev can come up/down while hwmon is accessing the device. I'm
also unconvinced that ENETDOWN is a good idea here.

While I get the "describe the hardware" is there a real benefit to
describing this?

What I'm wondering is whether manipulating the reset signal in this
case provides more pain than gain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

