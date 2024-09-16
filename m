Return-Path: <netdev+bounces-128578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBB97A6FC
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2098FB2B501
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194115B130;
	Mon, 16 Sep 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iTQF4lK7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91F143C63;
	Mon, 16 Sep 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508628; cv=none; b=PqxVAwgEK2P1+ibNN/C8Qk4y25e77uVphDmakel/HHR4mJVW+wJa2uhCURSg5Dc3LRwrpth50/yHsAblJi0pt6jf+01WKGnyyRtHRAzT5Lbg/nYdq7cRAs2bSMB+XVek9Ee7dCm2MzrI4XfAdwV+FgYSjB2zDrC0JV+ZkNyuIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508628; c=relaxed/simple;
	bh=KOrj1glTVkqZfzN7jpQeoOXrqtcK+L4YVkbuaoHF4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgZF02xcGc2vPkYvujOr1X8g3RgP0PHC4D3bCS83i6j8WB9hEF54kbah7aXpHWumWoX10dW55d/+qc++cV1OjIq4HRfTzNG6IHqdYn8oLooGRHZBF7/7Xq6RGng/sijpfNnK5y9mTk501WceR/WQWA0OsKGgqjDnRI8+IWZnqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iTQF4lK7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mm+bDHmUaq8HaKf0sURJ3ejU1UzGZC0kfOb+q2zY2Lw=; b=iTQF4lK7F5r4s+UX/zLu+v5WRQ
	gHfAV3qH4nLwBBxnt/SA1mKfBhFuoh2liVnnOGCRttwZF++ZTS6WGzezvvWdchKPrGvqVrK/95/jt
	api0irbjh+Ns75tOnrXnYwJuG6rpsjZ/5EW23ZN4ckT9vZLPZCYYYKsI784sfp4hfa0pN+gOcwIq3
	9HLBkoIVbRvX2o8MjvFzjwBDkWMYpwzBsjEnf1t3DPE+orDWP2YeM7FTI3DuPInjUlVaHfytxiLhE
	5vqyHVxP/cq+vyCrjROLIc83NcvKQX/T5VyrNJpsUxEAeecVjQRsHxFn9h/BE1mSFZOhp8xAK/369
	ayJoYNUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44830)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqFcu-0006F4-1R;
	Mon, 16 Sep 2024 18:35:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqFcp-00078Y-1R;
	Mon, 16 Sep 2024 18:34:59 +0100
Date: Mon, 16 Sep 2024 18:34:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <ZuhsQxHA+SJFPa5S@shell.armlinux.org.uk>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
 <ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 16, 2024 at 06:03:35PM +0200, Andrew Lunn wrote:
> On Mon, Sep 16, 2024 at 04:36:47PM +0100, Daniel Golle wrote:
> > Hi,
> > 
> > I'm wondering how (or rahter: when?) one is supposed to apply ethtool
> > settings, such as modifying advertisement of speed, duplex, ..., with
> > SFP modules containing a PHY.
> 
> It should actually be more generic than that. You might also want to
> change the settings for Fibre modules. You have a 2.5G capable module
> and MAC, but the link partner can only do 1G. You need to force it
> down to 1G in order to get link.

Exactly. If the SFP gets changed, what it's connected to could be
something radically different.

There's also a _big_ problem here - there are SFPs that auto-detect
what the host is doing when they are inserted, and they adapt to
that. At least some *PON SFPs do this. Changing the settings (by any
method) of the link after the module has successfully established
synchronisation on the host side likely would result in the link
going down.

> > Do you think it would make sense to keep the user selection of
> > advertised modes for each networking device accross removal or insertion
> > of an SFP module?
> 
> No, you have no idea if the same module has been inserted, at least
> with the current code. You could maybe stash the EEPROM contents and
> see if it is the same, but that does not seem reliable to me, what do
> you do when it is different?

Quite. I think if we had a way to notify userspace that something with
the netdev hardware has changed, userspace could e.g. read the SFP
EEPROM itself and decide what settings it wishes to use - thereby
putting the policy decisions about what to do when a SFP is inserted
squarely in userspace's court.

The problem, as we all know, is that SFP EEPROM contents are a law to
themselves, and I wouldn't even think of trying to detect "has a
different module been plugged in from the previous module" by looking
for different EEPROM contents. Yes, the EEPROM has a serial number.
You can bet that there are vendors who program their modules with a
standard content that's the same for each module.

> > Alternatively we could of course also introduce a dedicated NETLINK_ROUTE
> > event which fires exactly one time once a new is PHY attached.
> 
> Something like that. I would probably also do it on remove.
> 
> It does not seem too unreasonable to call netdev_state_change() on
> module insert/remove. But maybe also add an additional property
> indicating if the SFP cage is empty/occupied. The plumbing for that is
> a bit more interesting.

Remember that the SFP code itself doesn't have visibility of the
netdev - that's handled at the higher levels by the PHY driver (if
the network connectivity is via a PHY) or via phylink if it's direct
to the MAC/PCS.

However, things get very complicated. We can't simply just change
configuration when the SFP is inserted.

In order to keep the laser/transmitter in fibre SFPs turned off, we
ensure that TX_DISABLE is asserted when the socket is inactive. I
view this as a safety measure as it avoids the potential for eye
sight damage by reflections.

However, for many copper SFPs, TX_DISABLE seems to be used to hold
the PHY in reset, making it unresponsive via I2C. So, at "module
insert" we don't even know if we have a PHY or not - we can only
take a best guess at whether the module _may_ have a PHY. Remember
that there are modules which do have a PHY, but the PHY is
completely inaccessible.

So, triggering userspace to do something when a module is inserted
is too early - we don't know at that point whether it has a PHY or
what the PHY is, what the capabilities of that PHY are, or anything
like that.

The best place to decide to notify userspace would be at the
module_start() callback - this happens when a module is present,
and the netdev has been brought up. Note that this call will happen
each and every time the netdev is brought up.

module_stop() is module_start()'s opposite method.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

