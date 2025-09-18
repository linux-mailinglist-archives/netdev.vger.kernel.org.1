Return-Path: <netdev+bounces-224503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6071B85A6F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ED55484EE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C630630E0FF;
	Thu, 18 Sep 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DQWGvp0p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427721B9C8;
	Thu, 18 Sep 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209695; cv=none; b=LoOmm/JleSd28q8KwyTUj61O4YCerlCDrzUIywMWAn14QLzniG0lZc+VGz7ksXMlDs7pMtC+wy3YpW0zNQsWYCZhQlMaQqxYLVop6x6QFht7dL4Q/Z5kNKAPPwWejllYMreFtCwXsldJbqHdty4xtICMIjt8CYiPbSSI90LVNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209695; c=relaxed/simple;
	bh=zpFVkb0lnhdGOYxmaSWK3NFzYVJkDSQXVNFp+JnGLtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5+OIqcTAfP9ctyulbUFrgsywVvqZSsE3EjQpMpP3FEggZejKIIKQjf0RJWCU8UqeTaMNana+QRRHuy9m1OUMEOsahWvBD6pCZ0VnXKE3d3TOnJ5s7tQVqM6tLv7ucVnu+mYSGWU/m743VZfw7ghZ7VK9XtdyijjuYOjpVghBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DQWGvp0p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=534+lwp2XT2+BE76GPOqNHw9H4NtzKsVjc9xzAvBcWw=; b=DQWGvp0pq6RVj00wUirYjFs+2y
	fORCEVeztn3KYnmhvxMZuL3pGJCZ5u2Pbwpx2PelEmLP3Bs/600/BAt624JQARAK0TjUifSWMdIcA
	wyxhY+8kEnaHts3bxEWdVPCtoTBxlw+oNDLdpClbdAl0TdQi/dm8aA/Zgun5JO+Ckuuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzGeY-008qQn-7z; Thu, 18 Sep 2025 17:34:34 +0200
Date: Thu, 18 Sep 2025 17:34:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
Message-ID: <46f9bdf8-a35c-4e94-9d4d-c87219444029@lunn.ch>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>

> > Andrew has previously suggested that MAC drivers should ask the PHY
> > whether WoL is supported, but this pre-supposes that PHY drivers are
> > coded correctly to only report WoL capabilities if they are really
> > capable of waking the system. As shown in your smsc PHY driver patch,
> > this may not be the case.
> 
> So how can we distinguish whether a PHY that implements WoL features
> is actually able (wired) to wake up the system? By adding the
> "wakeup-source" property to the PHY node?
> 
> Therefore, only set the "can wakeup" capability when both the PHY
> supports WoL and the property is present in the PHY node?

There are layering issue to solve, and backwards compatibility
problems, but basically yes.

I would prefer to keep the phylib API simple. Call get_wol() and it
returns an empty set if the PHY is definitely not capable of waking
the system. Calling set_wol() returns -EOPNOTSUPP, or maybe -EINVAL,
if it definitely cannot wake the system. 

However, 'wakeup-source' on its own is not sufficient. It indicates
the PHY definitely can wake the system. However, it being missing does
not tell us it cannot wake the system, because old DT blobs never had
it, but i assume some work, and some are broken.

We need the PHY driver involved as well. If the driver only supports
WoL via interrupts, and phy_interrupt_is_valid() returns False, it
cannot wake the system.

There other tests we can make, like device_can_wakeup(). In the end,
we probably have some cases where we know it should work, some cases
we know it will not work, and a middle ground, shrug our shoulders, it
might work, try it and see.

> However, this does not solve the actual static pin function
> configuration for pins that can, if correct alternate function is
> selected, generate interrupts, in PHY drivers.
> 
> It would be nice to be able to apply some kind of pinctrl to configure
> the PHY pins over the MDIO bus thanks to some kind of pinctrl hogging.

I don't think it needs to be hogging. From what i remember of pinctrl,
when a driver is probed, pinctrl-0 is activated. It is not limited to
pins which the driver directly uses. So if LED2 is connected to a pin,
pinctrl can at least select the needed function for that pin.

	Andrew

