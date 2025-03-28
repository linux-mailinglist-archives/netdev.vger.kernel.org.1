Return-Path: <netdev+bounces-178073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35396A745DF
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDEE17822D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE25214236;
	Fri, 28 Mar 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bvedlF+W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69C214217;
	Fri, 28 Mar 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152376; cv=none; b=YYGoR64ZoFvdlDdm8rwsHO6E7GmHYRC0Fn3NSaktv7URuKfE/4eBGRXtMHDpLOf25/Bi2ugi6vzLMEm3ZLdfNjVojmNQX34PTj9RjZTPUrrkhzXD8YVnOPt29wPTCVZM9ebhfooRSJgN7RrIvEzQPD1rlektGKg84NwRlx2+KH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152376; c=relaxed/simple;
	bh=vckH85TCWtlpiEkZsVZxvAiOQglNq7EoGooS+6LrDyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiX84FEm+9ZFmVlwt1z6z+80ibZXn27t/xRpUEoBehELvqNfz9VOrBMSs64yv/8p6rcZA3OeGJsZfTqxtYlxD2Hub60cEVnBWYXACk0UDdIxQcfD3Q68+RjZLW8GtomlFtL5djOQUeFoljQBZZuCYtrPYmAzElmCxGEUPIDk7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bvedlF+W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Ed7x22gxcXzy6tcl8aXdoUEVTlRgFGdbAz/YQVnOSg=; b=bvedlF+WLf08RqHjdHuM2tFLzA
	MsjWFWDHOgXENVACMmNnah6z+UPBsoMYjvBEuhULeR1RI8LPt0xkm8wnT3xLzrjXzJC92r26X/B31
	UDBmYn5e0emo7eGHGdKNz9sOwdeFFrpI8aPQwbKAOD/3/Heczat6c28LHndYBVD1IZ6SRxn2AEsvb
	Lsous30maM4v+KKlJZ6UJEH/pqXNcyes4qAlNSelcR88iHyTDRMutMLiMJAitl7d3svDsfJTXUrWV
	bQLYApvpDKiFHecRUBQdgD9qAzRkkoFeQq1CDbo+aTAizJPXACedv/aEFPhSEcdSLiauDOjUT2gF1
	xEGrCQAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48142)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ty5Yf-0008Dc-0U;
	Fri, 28 Mar 2025 08:59:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ty5Ya-00073g-2P;
	Fri, 28 Mar 2025 08:59:16 +0000
Date: Fri, 28 Mar 2025 08:59:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
Message-ID: <Z-Zk5PPI8M551xti@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
 <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
 <67db005c.df0a0220.f7398.ba6b@mx.google.com>
 <Z9sbeNTNy0dYhCgu@shell.armlinux.org.uk>
 <67e58cd2.7b0a0220.289480.1e35@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e58cd2.7b0a0220.289480.1e35@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 06:37:19PM +0100, Christian Marangi wrote:
> On Wed, Mar 19, 2025 at 07:31:04PM +0000, Russell King (Oracle) wrote:
> > If we wish to take something away, then first, it must be
> > unpublished to prevent new users discovering the resource. Then
> > existing users need to be dealt with in a safe way. Only at that
> > point can we be certain that there are no users, and thus the
> > underlying device begin to be torn down.
> > 
> > It's entirely logical!
> 
> OK so (I think this was also suggested in the more specific PCS patch)
> - 1. unpublish the PCS from the provider
> - 2. put down the link...
> 
> I feel point 2 is the big effort here to solve. Mainly your problem is
> the fact that phylink_major_config should not handle PROBE_DEFER and
> should always have all the expected PCS available. (returned from
> mac_select_pcs)
> 
> So the validation MUST ALWAYS be done before reaching that code path.

Yes, but there's a sting in the tail - e.g. if we take away link modes
that are advertised on some media by a PCS going away.

Here's a theoretical situation:

- separate PCS for SGMII and 10GBASE-R with their own drivers, muxed
  onto the same pins.
- PHY which switches its host interface between these two modes.

when both PCS are available, the PHY could be advertising 10base-T,
100base-Tx, 1000base-T and 10000base-T.

If one of these two PCS drivers becomes no longer available, then we
need to revalidate and update the PHY's advertisement.

> That means that when a PCS is removed, the entire phylink should be
> refreshed and reevaluated. And at the same time lock userspace from
> doing anything fancy (as there might be a possibility for
> phylink_major_config)

Taking the rtnl lock prevents userspace interfering with the interface
configuration.

> Daniel at some point in the brainstorm process suggested that we might
> need something like phylink_impair() to lock it while it's getting
> ""refreshed"". Do you think that might be a good path for this?

Taking the rtnl should be sufficient.

> One of the first implementation of this called phylink_stop (not
> dev_stop) so maybe I should reconsider keeping everything phylink
> related. But that wouldn't put the interface down from userspace if I'm
> not wrong.
> 
> It's point 3 (of the old list) "the MAC driver needs to be notified that
> the PCS pointer it stashed is no longer valid, so it doesn't return it for
> mac_select_pcs()." my problem. I still feel MAC should not track PCS but
> only react on the presence (or absence) of them.
> 
> And this point is really connected to point 1 so I guess point 1 is the
> first to handle, before this. (I also feel it will magically solved once
> point 1 is handled)

I'm wondering whether the mac_select_pcs() interface needs to be
revised - it's going to be difficult to do because there's many drivers
that blindly return a PCS irrespective of the interface mode.

I'm thinking that MAC drivers should register a PCS against a set of
interface modes that it wants to use it for (the interface modes that
a PCS supports is not necessarily the interface modes a MAC driver
wants to use it for.) That means we could handle mac_select_pcs()
entirely within phylink, which avoids storing PCS pointers in the MAC
driver.

I don't think this fully addresses the issues though.

However..

> > > For point 1, additional entry like available_interface? And gets updated
> > > once a PCS gets removed??? Or if we don't like the parsing hell we map
> > > every interface to a PCS pointer? (not worth the wasted space IMHO)
> > 
> > At the moment, MAC drivers that I've updated will do things like:
> > 
> >                 phy_interface_or(priv->phylink_config.supported_interfaces,
> >                                  priv->phylink_config.supported_interfaces,
> >                                  pcs->supported_interfaces);
> > 
> > phylink_config.supported_interfaces is the set of interface modes that
> > the MAC _and_ PCS subsystem supports. It's not just the MAC, it's both
> > together.
> > 
> > So, if a PCS is going away, then clearing the interface modes that the
> > PCS was providing would make sense - but there's a problem here. What
> > if the PCS is a bought-in bit of IP where the driver supports many modes
> > but the MAC doesn't use it for all those modes. So... which interface
> > modes get cleared is up to the MAC driver to decide.

.. we would then know which modes to clear from
phylink_config.supported_interfaces.

> Should we add an OP to handle removal of PCS from a MAC? Like
> .mac_release_pcs ? I might be wrong but isn't that giving too much
> freedom to the driver?
> 
> I need to recheck how the interface validation work and what values are
> used but with this removal thing on the table, supported_interfaces OR
> with the PCS supported_interface might be problematic and maybe the
> original values should be stored somewhere.

That thought also crossed my mind too.

> > > > There's probably a bunch more that needs to happen, and maybe need
> > > > to consider how to deal with "pcs came back".. but I haven't thought
> > > > that through yet.
> > > 
> > > Current approach supports PCS came back as we check the global provider
> > > list and the PCS is reachable again there.
> > > (we tasted various scenario with unbind/bind while the interface was
> > > up/down)
> > 
> > ... because you look up the PCS in the mac_select_pcs() callback which
> > leads to a different race to what we have today, this time inside the
> > phylink code which thankfully phylink prints an error which is *NEVER*
> > supposed to happen.
> >
> 
> I want to make sure tho you are ok with the usage of .mac_select_pcs
> for re-evaluation task.
> 
> Maybe a better approach is to introduce .mac_get_pcs and enforce the
> usage only on validation phase? (aka in phylink_validate_mac_and_pcs)
> 
> AFAIK in that phase .mac_select_pcs can return errors if the requested
> interface is not possible for one reason or another.

The problem is that the validation phase could happen in the distant
past in relation to when we actually use the results.

Consider the above case with SGMII + 10GBASE-R. We're running at
10G speeds, so we're using the 10GBASE-R PCS, and have been running for
a year. The cabling deteriorates, and the PHY renegotiates switching to
1G speed now wanting to use the SGMII PCS but someone's removed the
driver! The validation would've happened before the 10G link came up
but the use is now a significant time in the future.

In that scenario, if the SGMII PCS driver is available, then switching
to 1G speed is possible. If the driver isn't available, then the result
is that the link has gone down. That's the same result if we stop
advertising the slower speeds - the PHY basically wouldn't be able to
establish link at a slower speed, so the link has gone down.

So, maybe than re-evaluate phylink, maybe just keep track of which
PHY interface modes we can no longer support, and if we attempt to
switch to one of those, force the link down. However, with:

f1ae32a709e0 ("net: phylink: force link down on major_config failure")

we now have the mechanics to do this - if mac_select_pcs returns an
error for the interface mode at major_config time, we force the link
down until such time that we do have a successful major configuration.
Maybe we should just rely on that rather than trying to do a full
re-evaluation and reprogram things like PHY advertisements.

Maybe in this case, we need a way to inform phylib - if I remember
correctly, there is a way to get the PHY to signal "remote fault" to
the link partner, and this kind of situation seems an ideal use, but
I'd need to check 802.3.

Yes, the MAC driver still needs to be aware of a PCS going away so it
can properly respond to mac_select_pcs().

Part of the issue here is that phylink wasn't designed from the start
to cope with PCS as separate drivers - it always assumed that the MAC
was in control of the PCS and would ensure that the PCS would remain
available. E.g. through a PCS specific create() method causing a direct
module relationship without the involvement of the driver model, or the
PCS driver being built-in to the MAC driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

