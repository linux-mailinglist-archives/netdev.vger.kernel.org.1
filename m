Return-Path: <netdev+bounces-244028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDECADB04
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2135309A7CC
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86D2E5B2D;
	Mon,  8 Dec 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tJKAjA38"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1C223DE7;
	Mon,  8 Dec 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209142; cv=none; b=Nt3tAjepEFOTd4lOZl5hCTbYq1VJIuKVp5fm33/+0YQHb09E641EKJ93b32Dxde/1FLTTCVmHUFZ9KzNMlQszqI/CMhQObw48DMXUbMnKKOe36iixUs5B6l2mIkO9QtPxKwSIFP7d1IJj6FrrU4ZUcF3vtn1CmXwy8dKpDbfc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209142; c=relaxed/simple;
	bh=TwbEzbePvq97Y0pGROSVAyXZY6rQqys6efBWftrqBqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsOKsjSFtNc2lhdLtgn4hUUrBq/u33ob/Sqgpv0gGckKAfYGJhgBjiHRb/3EGS9+3KtmSXvPCgNzmkbhvP+5XlCg9hz25eyEHR652MkWmBrSKsZ+YGuObZF44kBYMWjvOcSg7cQnb8bkXY+GYCR70n/uWbcNTADMmWOmvVoym0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tJKAjA38; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a26t6C/nRAo16aRF2+RTOX6y5voMDyYmxOI4/3sW4WM=; b=tJKAjA38y0Uhjy4JytDp/XDS/V
	/ya1Q+vblWV+9PtHz51sLkGAzKT6gIokCXgzQ08FF8+R6WzEa7B7AinXSNRjVbeTA0JCDtreK2G5m
	GMRLHypijQhy0IYYqe6TSZKTn/cPEEfofAdNUaZClKL3L2ajGQrXvHghD3m4zQ2l6aQiM5UBcS2Zc
	bpDYiJU3EI8ePllhFhsBzDDqG3AW5jn2BlVcMR7MVtoloO6P3z/V4qWlBcIgoElUArFx2EihWFrCE
	cfHa5qmFg/c07K9BILMg4SFB8HKXEyrhDG3vVqWl/GnNV7Y8j5W0yHgrO2FEu/Bge2dBlNPmCHOzf
	VMTaELmA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48002)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSdWx-000000007vD-36CQ;
	Mon, 08 Dec 2025 15:52:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSdWs-0000000059B-2Xwz;
	Mon, 08 Dec 2025 15:52:02 +0000
Date: Mon, 8 Dec 2025 15:52:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v3] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTb0IqktR9gbZFdn@shell.armlinux.org.uk>
References: <c28947688b5fc90abe1a5ead6cfd78e128027447.1765156305.git.daniel@makrotopia.org>
 <aTbI99uWvg08wgV9@shell.armlinux.org.uk>
 <586e6fe2-60af-4a8f-9727-98ad7d6b9593@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586e6fe2-60af-4a8f-9727-98ad7d6b9593@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 02:37:38PM +0100, Andrew Lunn wrote:
> On Mon, Dec 08, 2025 at 12:47:51PM +0000, Russell King (Oracle) wrote:
> > On Mon, Dec 08, 2025 at 01:27:04AM +0000, Daniel Golle wrote:
> > >  static void gsw1xx_remove(struct mdio_device *mdiodev)
> > >  {
> > >  	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
> > > +	struct gsw1xx_priv *gsw1xx_priv;
> > >  
> > >  	if (!priv)
> > >  		return;
> > >  
> > > +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> > > +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
> > > +
> > >  	gswip_disable_switch(priv);
> > >  
> > >  	dsa_unregister_switch(priv->ds);
> > 
> > Can we please pay attention to ->remove methods, and code them properly
> > please?
> > 
> > There are two golden rules of driver programming.
> > 
> > 1. Do not publish the device during probe until hardware setup is
> >    complete. If you publish before hardware setup is complete, userspace
> >    is free to race with the hardware setup and start using the device.
> >    This is especially true of recent systems which use hotplug events
> >    via udev and systemd to do stuff.
> > 
> > 2. Do not start tearing down a device until the user interfaces have
> >    been unpublished. Similar to (1), while the user interface is
> >    published, uesrspace is completely free to interact with the device
> >    in any way it sees fit.
> > 
> > In this case, what I'm concerned with is the call above to
> > cancel_delayed_work_sync() before dsa_unregister_switch(). While
> > cancel_delayed_work_sync() will stop this work and wait for the handler
> > to finish running before returning (which is safe) there is a window
> > between this call and dsa_unregister_switch() where the user _could_
> > issue a badly timed ethtool command which invokes
> > gsw1xx_pcs_an_restart(), which would re-schedule the delayed work,
> > thus undoing the cancel_delayed_work_sync() effect in this path.
> 
> And this is why is was pushing for the much simpler msleep(10), or
> io_poll.h polling to see if it self clears. It is hard to get that
> wrong, where as delayed work is much easier to get wrong.

It's not specific to delayed work. Looking at the context around
the ->remove() method, it's already wrong:

        gswip_disable_switch(priv);

        dsa_unregister_switch(priv->ds);

gswip_disable_switch() writes to a register:

	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);

and I wonder what that does in terms of MDIO bis accesses that will
still be active at this point (because the DSA switch is still
registered.)

I see that gswip_setup() enables the switch before it configures the
MDIO bus and registers it, so the disable-then-unregister looks very
suspicious to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

