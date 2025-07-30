Return-Path: <netdev+bounces-211019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E600B16331
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA52918C6DC8
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA482D9EDF;
	Wed, 30 Jul 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ypZM6NTV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3562DAFC6
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887161; cv=none; b=C9N9TEO/zdFEK9s9i40G8O8glxKWjVL3t18FMzjeFvk12EpQMp16LPNZk6sQ3JLze/2JXCbUeaiQpiBBg3VIBmfO78+Xh7vxGnoDlJKBCXsSnoBsKu399lqt/074CtOxfbrk2uT7zr3cgudcQuZxh2xP0vOfZyf6qTvvViZnO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887161; c=relaxed/simple;
	bh=fLQiQzpmhB7RlWI+Ow/Ss807qj3Qsx/Lyp55O68nqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlKKO6Eb+IlhqTGFSkdD52/aDC3Eac/b9ESLWZ9lBYCSWttf2GDBjXfnxM1W19dRgkmI/BPtGghxuNEx8fXAFG6x+1zY2pxQvzoGKXXg0aGsjRsxo5GukTafAaqezhbwRQ8ISVy5FM3COnpY4xeZDcYQ4yQylbKgXQhM5EgQVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ypZM6NTV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8vIErx2k5iLS0e7y1aCzxBVqPv8wgmC5T4/L1t697sg=; b=ypZM6NTV3AtghxivKTkVCYhdRh
	VRYK1UOvfre/kW7CC7AsOnQI6XAM8Iy8DdDftLZ5M38Y4nJlOKWm6PQnaid8LXXrBnMqr+ogHHnQ5
	Aoq3ZYPAyyaHjjDn2BOVBnmEPMJE0aoRDtSNwrcZRIP8iVyfbUn4Qu03jfMIbqNcB4BQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh8AR-003Hxo-4w; Wed, 30 Jul 2025 16:52:31 +0200
Date: Wed, 30 Jul 2025 16:52:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Message-ID: <a1c121e1-cf56-4798-b255-96f29cab80ec@lunn.ch>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
 <27e10ba4-5656-40a8-a709-c1390fee251f@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e10ba4-5656-40a8-a709-c1390fee251f@foss.st.com>

> > 3) The PHY has a dedicated WoL output pin, which is connected directly
> > to a PMIC. No software involved, the pin toggling turns the power back
> > on.
> > 
> 
> Just my 2 cents:
> 
> In some cases like the LAN8742, there are some flags that need to be
> cleared when waking up in order to be able to handle another WoL event.
> It can be done either in the suspend()/resume() or in an interrupt
> handler of the PHY. In 3) This suggests that the interrupt is somehow
> forwarded to the Linux kernel.
> 
> This is what I was ultimately trying to do in two steps with the TEE
> notifying the kernel of that interrupt.
> 
> Moreover, if a WoL event occurs when the system is not in a low-power
> mode, then the flags will never be cleared and another WoL event cannot
> be detected while the system is in a low-power mode.
> 
> Maybe we can argue that these flags can be cleared in suspend() and
> and resume(). But then, if there's no interrupt to be handled by the
> kernel, how do we know that we have woken up from a WoL event?
> 
> IMHO, I think 3) may optionally declare another interrupt as well
> for WoL events.

The 3) i've seen is a Marvell based NAS box. It is a long time
ago. But as far as i remember, the SoC had no idea why it woke up, it
could not ask the PMIC why the power was turned on. So there was no
ability to invoke an interrupt handler.

I've also seen X86/BIOS platforms which are similar. The BIOS swallows
the interrupt, it never gets delivered to Linux once it is
running. And the BIOS itself might poke PHY registers.

> Eventually, 2) and 3) would have 1 interrupt(WoL) if PHY is in polling
> mode and 2 if not?

Nope. These NAS boxed often had 0 PHY interrupts, and polling was
used. If you have a single ethernet port, you don't care it takes a
while to know the link is dead. There is nothing you can do, you don't
have a second interface to fall back to.

     Andrew

