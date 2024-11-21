Return-Path: <netdev+bounces-146651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A39D4EA6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC50EB26987
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0D1D8A08;
	Thu, 21 Nov 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="npEi2vOd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530C20330;
	Thu, 21 Nov 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199140; cv=none; b=f86lYBJVOfu0XS1MCxToJOrTFqOKLxmXIsyzty8JufmU835c996TziwbjiuLMKYorv1utD0b8Qzrk2PerPAhGIvFuuyoPVkpudlfRCFqkJJjL1nonjUWNVJLSsFlpuUibU+Oyi5xZ9csAmXc+mtKPAmgwm+9f6eryGEPs8SPcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199140; c=relaxed/simple;
	bh=/xoURug9mFlPXUzDX/hahpXmfY+g2zn4YGL+kl59M5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2GI00hRjZEWzRWLJeSJdrE1Q4OjW6UWdpTZiEzJjGfXDe8KvpfjPdUfRz4lY4Yqhl0oyuhv9kx19VHZNglQ7WH31QyeVeDNAVlQ/pLS2tezFuxb26SlbRqTQ9m3bh+f3sWkUbwZwC/8enI+taA+Rgxk/BSABNfI+QHyOCUfGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=npEi2vOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eKS76cxQEKPIR4MEzycu9OJBS5rxGLqkxBAvZUIpwVY=; b=np
	Ei2vOdB6W7Zu4BhKLa323a/lO6SQZ8TcrZ6ky4luNxD9+wHZKN+Z/mn9zLt0LPN1U6G31mm6W2qqc
	cnStju9YD4aum2igneGTkuOlV4kWSLux0KTLZyCwgEyygQ2xpO9aNVJI4+1fNT7dZnqMaXpQ7hkJR
	/JyeuCitN9EV9EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tE87g-00E3vg-8B; Thu, 21 Nov 2024 15:25:32 +0100
Date: Thu, 21 Nov 2024 15:25:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] usbnet_link_change() fails to call netif_carrier_on()
Message-ID: <b1888530-1bf8-4ced-948d-d3989f9896b6@lunn.ch>
References: <m34j43gwto.fsf@t19.piap.pl>
 <9baf4f17-bae6-4f5c-b9a1-92dc48fd7a8d@lunn.ch>
 <m3plmpf5ar.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3plmpf5ar.fsf@t19.piap.pl>

On Thu, Nov 21, 2024 at 07:51:24AM +0100, Krzysztof Hałasa wrote:
> Hi Andrew,
> thanks for a looking at this.
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
> >> {
> >>       /* update link after link is reseted */
> >>       if (link && !need_reset)
> >>               netif_carrier_on(dev->net);
> >>       else
> >>               netif_carrier_off(dev->net);
> >>
> >>       if (need_reset && link)
> >>               usbnet_defer_kevent(dev, EVENT_LINK_RESET);
> >>       else
> >>               usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
> >> }
> >
> > This device is using phylink to manage the PHY. phylink will than
> > manage the carrier. It assumes it is solely responsible for the
> > carrier. So i think your fix is wrong. You probably should be removing
> > all code in this driver which touches the carrier.
> 
> Ok, I wasn't aware that phylink manages netdev's carrier state.
> 
> Then, is the patch wrong just because the asix driver shouldn't use the
> function, or is it wrong because the function should work differently
> (i.e., the semantics are different)?
> 
> Surely the function is broken, isn't it? Calling netif_carrier_off()
> on link up event can't be right?
> 
> 
> Now the ASIX driver, I'm looking at it for some time now. It consists
> of two parts linked together. The ax88172a.c part doesn't use phylink,
> while the main asix_devices.c does. So I'm leaving ax88172a.c alone for
> now (while it could probably be better ported to the same framework,
> i.e., phylink).
> 
> The main part uses usbnet.c, which does netif_carrier_{on,off}() in the
> above usbnet_link_change(). I guess I can make it use directly
> usbnet_defer_kevent() only so it won't be a problem.
> 
> Also, usbnet.c calls usbnet_defer_kevent() and thus netif_carrier_off()
> in usbnet_probe, removing FLAG_LINK_INTR from asix_devices.c will stop
> that.
> 
> The last place interacting with carrier status is asix_status(), called
> about 8 times a second by usbnet.c intr_complete(). This is independent
> of any MDIO traffic. Should I now remove this as well? I guess removing
> asix_status would suffice.

I've not looked at this driver in detail, nor usbnet. So i can only
make general comments. I do see there are a number of drivers which
re-invent the wheel and do their own PHY handling, when they should
allow Linux to do it via phylib/phylink.

When the MAC driver is using phylink, or phylib, it should not touch
the carrier, nor access the PHY directly. The exception can be during
probe, when it can turn the carrier off. What the MAC driver should be
doing is exposing its MDIO bus as a Linux MDIO bus. phylib will then
enumerate the bus and find the PHYs on it. The MAC driver which does
not have access to device tree then typically uses phy_find_first() to
find a PHY on the bus, and uses phy_connect() to bind the PHY to the
MAC. The MAC driver then uses phy_start() when the interface is
opened. phylib will poll the PHY for changing in link status, and call
the callback function registered via phy_connect() to let the MAC know
about what the PHY has negotiated. Other than that, the MAC driver
does nothing with the PHY.

It could well be there are historical discrepancies in usbnet, in that
having Linux drive the PHY is somewhat new for usbnet, historically
the wheel was reinvented, and maybe part of that is in the usbnet
core.

	Andrew

