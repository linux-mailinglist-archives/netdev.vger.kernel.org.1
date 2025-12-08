Return-Path: <netdev+bounces-244013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D093CAD4A2
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D963F3008046
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986F3115A2;
	Mon,  8 Dec 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uXmJwydk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9E2E9EA1;
	Mon,  8 Dec 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201096; cv=none; b=cxsG2Qx6BJKocMeIlCiIomLeJu3PXsRr6MP8Othpyu2d7k76bbvckAy4JscaeJJpLtrJFz2cy7F7GTBPv4x2XijtfFEhsWIIPsWfoXgrgNaVcnGFQEiMtfag4Avg0qwsQUpcZW9Y4c1u3//KJMwn205wrsk3n0LWcjaL2OY5Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201096; c=relaxed/simple;
	bh=yFY9to71CPFt/nq28a9y8pZQYlJVADl7WKsWnj7vnL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7yRKVJ2lyR6N+IiZGb5W/NnyiRRQrh129LA4cJZ3OQlaHusHO2oEmC9RCvyvGfZZoceIWOpb7kG+FGxBhH1O1rkshp+UHfa9r58mm0K9f4fAOnfxH0V5Tb4x/EGZ9vGF8Y0HOcPkkxy3YFIW1s9KKkhtlWTjOOylF5N9Z5zREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uXmJwydk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=97d03xXJcdYCispt3O0zsohG5XXYmOiyFrkqz4qQlBY=; b=uXmJwydk4LSjFMXAioq46UH9sG
	zQCqHT1EI4jCt3444t5IWZmLb9/iPIkacel0ItNSyZFz6hSeVtv/MexxOggq6lc8vg09D3Z4JvKvN
	LqiLGaS+cFCjqE6vSIETLUebLVu3al02BSzG97TSQz1+5FnFop4bVFQSPZRmOPt2ypFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vSbQo-00GNSL-Ne; Mon, 08 Dec 2025 14:37:38 +0100
Date: Mon, 8 Dec 2025 14:37:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <586e6fe2-60af-4a8f-9727-98ad7d6b9593@lunn.ch>
References: <c28947688b5fc90abe1a5ead6cfd78e128027447.1765156305.git.daniel@makrotopia.org>
 <aTbI99uWvg08wgV9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTbI99uWvg08wgV9@shell.armlinux.org.uk>

On Mon, Dec 08, 2025 at 12:47:51PM +0000, Russell King (Oracle) wrote:
> On Mon, Dec 08, 2025 at 01:27:04AM +0000, Daniel Golle wrote:
> >  static void gsw1xx_remove(struct mdio_device *mdiodev)
> >  {
> >  	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
> > +	struct gsw1xx_priv *gsw1xx_priv;
> >  
> >  	if (!priv)
> >  		return;
> >  
> > +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> > +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
> > +
> >  	gswip_disable_switch(priv);
> >  
> >  	dsa_unregister_switch(priv->ds);
> 
> Can we please pay attention to ->remove methods, and code them properly
> please?
> 
> There are two golden rules of driver programming.
> 
> 1. Do not publish the device during probe until hardware setup is
>    complete. If you publish before hardware setup is complete, userspace
>    is free to race with the hardware setup and start using the device.
>    This is especially true of recent systems which use hotplug events
>    via udev and systemd to do stuff.
> 
> 2. Do not start tearing down a device until the user interfaces have
>    been unpublished. Similar to (1), while the user interface is
>    published, uesrspace is completely free to interact with the device
>    in any way it sees fit.
> 
> In this case, what I'm concerned with is the call above to
> cancel_delayed_work_sync() before dsa_unregister_switch(). While
> cancel_delayed_work_sync() will stop this work and wait for the handler
> to finish running before returning (which is safe) there is a window
> between this call and dsa_unregister_switch() where the user _could_
> issue a badly timed ethtool command which invokes
> gsw1xx_pcs_an_restart(), which would re-schedule the delayed work,
> thus undoing the cancel_delayed_work_sync() effect in this path.

And this is why is was pushing for the much simpler msleep(10), or
io_poll.h polling to see if it self clears. It is hard to get that
wrong, where as delayed work is much easier to get wrong.

	Andrew

