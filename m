Return-Path: <netdev+bounces-238339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BDC576BE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE2421DB7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA234DCDF;
	Thu, 13 Nov 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WdISzb/V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A212D879F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036670; cv=none; b=rI+7OIJfOX6RgXhi4XsJxLsqEB/KSIvDwBii9EaqQuKmQwyiqpT3nirx/GoIT7+4Y48SOHmayf8DuIYdFBQzzGTtVh8HKwhp36q4lb+uHczethbxMljC89jyJ0xiAmHFMjP+C/q7Xn26F5zRPYKYlEfjrd9Jvob1m3Gd3M7PkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036670; c=relaxed/simple;
	bh=OiaSKI/gwH6xBDrsZLRV1mCX59BeUnOJd/8xVyLsMxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnpVf8nU2iv/nEYhZdoZKd4eeYpoVIkQrxXDKmRly8uDtC7dMAYCCa5bVQky9+v+3m4/VdP15VyYFXW5ri3oUHfsXdBLv90Vu578JHeUlXeSV8wKPBVY/DAp/Zpd5lU9oQUn5uvEGrpUwxfhurrfRv8OcFfb+5omTnGMv0scSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WdISzb/V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v028MexFVxGg7dqN0kLCZuFV0UJ96du8FP7ul6zrcYY=; b=WdISzb/VqOuW3bFVncifcSvIyd
	K0aQw7JNzxxjf5cfRVBJAIP2rGex1VmQAtmwGPmmpNHbPuZL9MxcEKFmYLNf6lS/qTjb+8ZLmsefy
	43HA0n4/HX86DwTiuwssOjLyahfPKXkP/HMM8CBJnW/pL1irwnNpeBtYVjttpVF21vVs0vghbrknQ
	gpyK4pSBtRKLm7J9z395Yrf0QUaJ/B6e/V8YI+W8Rj4avpc8wtOL9V8GDSNshcIuLE7beXM69/2vT
	NmDkR5G0b0tq2Xibc4kmUSE3tIUbE73Aq6eM6lLmk20FtGZCQAchmvLL75qnaea0Uz5/VvUVKBT4X
	HwMfZ5+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJWN4-000000005Rg-1OuC;
	Thu, 13 Nov 2025 12:24:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJWN1-000000004r5-2MJW;
	Thu, 13 Nov 2025 12:24:11 +0000
Date: Thu, 13 Nov 2025 12:24:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <aRXN61oICP3Vkk84@shell.armlinux.org.uk>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 12:12:44PM +0000, Vadim Fedorenko wrote:
> On 13/11/2025 12:02, Russell King (Oracle) wrote:
> > On Thu, Nov 13, 2025 at 11:32:00AM +0000, Vadim Fedorenko wrote:
> > > PHY devices had lack of hwtstamp_get callback even though most of them
> > > are tracking configuration info. Introduce new call back to
> > > mii_timestamper.
> > > 
> > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > 
> > As part of my Marvell PTP work, I have a similar patch, but it's
> > way simpler. Is this not sufficient?
> > 
> > __phy_hwtstamp_get() is called via phylib_stubs struct and
> > phy_hwtstamp_get(), dev_get_hwtstamp_phylib(), dev_get_hwtstamp(),
> > and dev_ifsioc().
> > 
> > Using the phylib ioctl handler means we're implementing a path that
> > is already marked as legacy - see dev_get_hwtstamp():
> > 
> >          if (!ops->ndo_hwtstamp_get)
> >                  return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
> > 
> > So, I think the below would be the preferred implementation.
> 
> You mean do not add SIOCGHWTSTAMP case in phy_mii_ioctl() as we should
> never reach this legacy option?

We _can_ reach phy_mii_ioctl() for SIOCGHWTSTAMP where drivers do not
provide the ndo_hwtstamp_get() method. However, as this is legacy code,
the question is: should we add it?

> Technically, some drivers are (yet) not
> converted to ndo_hwtstamp callbacks and this part can potentially work
> for bnx2x driver, until the other series lands.

Right, but providing new features to legacy paths gives less reason for
people to stop using the legacy paths.

> I was planning to remove SIOCSHWTSTAMP/SIOCGHWTSTAMP dev_eth_ioctl calls
> later once everything has landed and we have tests confirming that ioctl
> and netlink interfaces work exactly the same way.

However, implementations that do populate non-legacy ndo_hwtstamp_get()
won't work correctly with your conversion, since we'll fall through to
the path which calls __phy_hwtstamp_get() which won't do anything.

So I disagree with your patch - it only adds support for legacy net
drivers to get the hwtstamp settings from the PHY. Non-legacy won't be
supported.

At minimum, we should be adding support for non-legacy, and _possibly_
legacy.

Let's wait for others to comment on my point about adding this for the
legacy drivers/code path.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

