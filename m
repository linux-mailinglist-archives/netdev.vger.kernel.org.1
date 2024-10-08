Return-Path: <netdev+bounces-133213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D787599553B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1427C1C2484A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA817BB1E;
	Tue,  8 Oct 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BvRLTc98"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB026F2F3;
	Tue,  8 Oct 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406950; cv=none; b=eSRfED6mwEcXyJCoC3mBpJzVs7A5tApmT8Dd6gIrOXQo3OpEBoGz+MTeewVfsGq+36y1ypQxldK7VHYa/i2koHS129RDAjvaxChvnn+bokDqNTuiepq4E7tynSG/UHkjV8m4F9NMUXsAWI4vxk71yy2woPgdJUCKoEc1AX9dMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406950; c=relaxed/simple;
	bh=fgEN0PVbg51E78WWmHJQVcw9mVrCW7a9PjfY+dKOZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSCsKCmOjODrZLuR8I3DbQto9ZxNVXERjsJM8h6vQqF9ftH/JaE9FZ2FBx+/OGqB6hBaXtmqOrvy9RaipoeEbleFl0YBnSoybh+Ta5l51QN/WuZ7g/N+BctZ+SCDGK5TKdM9pXL/pw2gacJfD2m761qfjYP4UmOKEDC8vUr64ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BvRLTc98; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LVqwtJiH59AwTPCCe1LAxfi3a8eGWm0tAbr4rEugXwQ=; b=BvRLTc98UxPG7Ong218w31h2zP
	gi9kIN5SDowu9TH31FZ9+sDchwP60bnJQpsepdaHfNS7PlOi4nVA1XDRQiEtI15J4znvxheSi9Wt+
	1k/bS//tcD4KHS33Je8T0MSYpND39Mo7lSclqkyqj1CSHzvVIz6GZDAakYLPc8P4ElUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syDbG-009OVn-WD; Tue, 08 Oct 2024 19:02:19 +0200
Date: Tue, 8 Oct 2024 19:02:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence
 before registering
Message-ID: <9ed5fd73-b4e8-4be1-9642-9dbeb8bfd892@lunn.ch>
References: <20241004183312.14829-1-ansuelsmth@gmail.com>
 <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>
 <67053002.050a0220.63ee8.6d11@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67053002.050a0220.63ee8.6d11@mx.google.com>

On Tue, Oct 08, 2024 at 03:13:34PM +0200, Christian Marangi wrote:
> On Tue, Oct 08, 2024 at 03:08:32PM +0200, Andrew Lunn wrote:
> > > +	/* Check if the PHY driver have at least an OP to
> > > +	 * set the LEDs.
> > > +	 */
> > > +	if (!phydev->drv->led_brightness_set &&
> > > +	    !phydev->drv->led_blink_set &&
> > > +	    !phydev->drv->led_hw_control_set) {
> > 
> > I think this condition is too strong. All that should be required is
> > led_brightness_set(). The rest can be done in software.
> >
> 
> Mhh the idea was really to check if one of the 3 is declared. Ideally to
> future proof case where some led will only expose led_hw_control_set or
> only led_blink_set?

Ah, i read it wrong. Sorry.

Maybe apply De Morgan's laws to make it more readable?

+	if (!(phydev->drv->led_brightness_set ||
+	      phydev->drv->led_blink_set ||
+	      phydev->drv->led_hw_control_set)) {

However, it is correct as is.

    Andrew

