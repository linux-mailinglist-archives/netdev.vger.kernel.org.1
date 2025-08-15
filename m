Return-Path: <netdev+bounces-214058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F6B28038
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE91605983
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68630146B;
	Fri, 15 Aug 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h4QI56Rd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06D24395C;
	Fri, 15 Aug 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262768; cv=none; b=YmSSQJNw2S2zDaBQZBF2f86HcqhGPSMtGcQc+dufNu8H87AT7wN4oMbdbZIWXjtrupbBSvRv/UCHb3EqCvUZLPTrUI9iaoTyjoSwdtUrcECU3LjRsF43x0H3vLpIWVsomTJuNO4geICTQLJhEmK2xv1jv4R9XAfsd2/wTM+oBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262768; c=relaxed/simple;
	bh=gGAyaHnJFqG3yEOMHo+9099n/xMwq45fZnZWGT3Npv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF+itnm86M6Tb1PUdyQ8o5SjAbeXrJz0Xpg11UkodYJmlhOhPjmnkcMrEFL+3ipkcif3495LPJD2193Ty/G1qV4BhcBz/nmGEY8+i9K3mEERFAEQI/u8R06tsUM9Mgs8aJTyN13g3XwwZ+MBSSgHO5pPv31zSgw6yEYmuExswHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h4QI56Rd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WxxMg2CpYRBJYb9noYcqcSAL3Z0uD1GOUX0iFK8kymE=; b=h4QI56RdN+OJNfEUm8boNTz1Js
	xC2T2k6zgAT4Fp2KI51rLoYAt+siWmkmEtWlqH6rdje3QsEn5M+IlOJswPKlN6WviQfWWSR2u3+5P
	d/uidX1zqxu61DpUYESdaRaETTSIQ/gOFJJBxXhaQaD09vLFW6Ax5iE59wQ+ZPYfiXgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umu1Y-004ox6-Dh; Fri, 15 Aug 2025 14:59:12 +0200
Date: Fri, 15 Aug 2025 14:59:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de,
	khalasa@piap.pl, o.rempel@pengutronix.de, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] net: usb: asix: avoid to call phylink_stop() a second
 time
Message-ID: <1c352c2f-c8b3-4cbe-9921-8ba5f0e4b433@lunn.ch>
References: <20250806083017.3289300-1-xu.yang_2@nxp.com>
 <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
 <e3oew536p4eghgtryz7luciuzg5wnwg27b6d3xn5btynmbjaes@dz46we4z4pzv>
 <c3e7m63qcff6dazjzualk7v2n3jtxujl43ynw7jtfuf34njt6w@5sml5vvq57gh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e7m63qcff6dazjzualk7v2n3jtxujl43ynw7jtfuf34njt6w@5sml5vvq57gh>

> > > Looking at ax88172a.c, lan78xx.c and smsc95xx.c, they don't have
> > > anything like this. Is asix special, or are all the others broken as
> > > well?
> > 
> > I have limited USB net devices. So I can't test others now.
> > 
> > But based on the error path, only below driver call phy_stop() or phylink_stop()
> > in their stop() callback:
> > 
> > drivers/net/usb/asix_devices.c
> >   ax88772_stop()
> >     phylink_stop()
> > 
> > drivers/net/usb/ax88172a.c
> >   ax88172a_stop()
> >     phy_stop()
> > 
> > drivers/net/usb/lan78xx.c
> >   lan78xx_stop()
> >     phylink_stop()
> > 
> > drivers/net/usb/smsc95xx.c
> >   smsc95xx_stop()
> >     phy_stop()
> > 
> > However, only asix_devices.c and lan78xx.c call phylink_suspend() in suspend()
> > callback. So I think lan78xx.c has this issue too.
> > 
> > Should I change usbnet common code like below?
> > 
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index c39dfa17813a..44a8d325dfb1 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
> >         pm = usb_autopm_get_interface(dev->intf);
> >         /* allow minidriver to stop correctly (wireless devices to turn off
> >          * radio etc) */
> > -       if (info->stop) {
> > +       if (info->stop && !dev->suspend_count) {
> >                 retval = info->stop(dev);
> >                 if (retval < 0)
> >                         netif_info(dev, ifdown, dev->net,
> 
> Do you mind sharing some suggestions on this? Thanks in advance!

It does look to be a common problem, so solving it in usbnet would be
best.

	Andrew

