Return-Path: <netdev+bounces-184800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA08A9739C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695B7189EBF1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F381519A6;
	Tue, 22 Apr 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GmYtNHPJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBD28382
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343036; cv=none; b=f/0Bx2w+lNtq1jk7DQSLrefoBYvrVht4j+yYPMzHEQh3RAZ3lo5/mcRV9HYLQIQvLQNpIkKxrdQVr6lWRnu2wP9nBxzOW1r1pFGmMA6wioSe26wfsfed71dm4S5LWpZItsa49ORmtmgjhMbn733L3od+EMwahJIbw7n3QffZJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343036; c=relaxed/simple;
	bh=1CKUVZSXC3l7C12StwyD6xRcRr5R1P7889PykMzs4YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBf5q4EP9gp+W/qObe54xfcyRJV2CqVTe7WVyYTGkL6TO63YPcOqyMH25lfqM1lzs2AIuN80Z3aSOqjYYICDkkQTAnS7ktxlf1yUgd9yXTyFpMiEdBYEgigMPYSB/fdUHVj/YYx4VZVzpnsKACTn0MxDnPtqUeN9armdg4BE98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GmYtNHPJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/bmOUlKw6ea5zoFQo+oUHS8Le0h6+cK5sNV3EpakRIk=; b=GmYtNHPJMHivSmxYipw25U7X3q
	tW+Mu8hJedvBR5S3LpzAxxH8iBl9fKh1lfAz607Ki6DrPefa+q5yEMoAQjDgbqKFMcsBjaWfoXHYg
	VExmGzBCTdxbIQW5Gs1Fxb1jRWs1BgHL+6ZZFOP1adPXavKwGM1YzUIrWvJYjm62KLaNK86e19kzT
	LTDgK8nUcIkMvWjyYuzNWCv82/C8s+yH/0MXbCc7POOKRjIaY/AwK/4we2kR8J0ESLwM/nwzLsPXh
	D07b4pI60HxSxUbz2aF23Uu4J1XWbfiV9KrB/KL4RtPvuD6ux29vkPNuw0geu01p6r8q8KJki/MC5
	d//UnHPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52938)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7HS1-0004m1-0u;
	Tue, 22 Apr 2025 18:30:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7HRy-0007ev-2q;
	Tue, 22 Apr 2025 18:30:26 +0100
Date: Tue, 22 Apr 2025 18:30:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <aAfSMh_kNre5mxyT@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 06:49:54PM +0200, Andrew Lunn wrote:
> > > The whole concept of a multi-host NIC is new to me. So i at least need
> > > to get up to speed with it. I've no idea if Russell has come across it
> > > before, since it is not a SoC concept.
> > > 
> > > I don't really want to agree to anything until i do have that concept
> > > understood. That is part of why i asked about a standard. It is a
> > > dense document answering a lot of questions. Without a standard, i
> > > need to ask a lot of questions.
> > 
> > Don't hesitate to ask the questions, your last reply contains no
> > question marks :)
> 
> O.K. Lets start with the basics. I assume the NIC has a PCIe connector
> something like a 4.0 x4? Each of the four hosts in the system
> contribute one PCIe lane. So from the host side it looks like a 4.0 x1
> NIC?
> 
> There are not 4 host MACs connected to a 5 port switch. Rather, each
> host gets its own subset of queues, DMA engines etc, for one shared
> MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
> bus, and blinky LEDs. Plus you have the BMC connected via an RMII like
> interface.
> 
> You must have a minimum of firmware on the NIC to get the MAC into a
> state the BMC can inject/receive frames, configure the PCS, gpios to
> the SFP, enough I2C to figure out what the module is, what quirks are
> needed etc.

This all makes sense, but at this point, I have to ask something that
seems to be fundamental to me:

  Should any of the hosts accessing the NIC through those PCIe x1
  interfaces have any knowledge or control of anything behind "their"
  view of the MAC?

I would say no, they should not, because if they do, they can interfere
with other hosts. Surely only the BMC should have permission to access
the layers of hardware behind the MAC?

What should a host know about the setup? Maybe the speed of their
network connection through the MAC. I state it that way rather than
"the speed of the media" because if there is some control over the
traffic from each "host" then the media speed is irrelevant.

> NC-SI, with Linux controlling the hardware, implies you need to be
> able to hand off control of the GPIOs, I2C, PCS to Linux. But with
> multi-host, it makes no sense for all 4 hosts to be trying to control
> the GPIOs, I2C, PCS, perform SFP firmware upgrade. So it seems more
> likely to me, one host gets put in change of everything below the
> queues to the MAC. The others just know there is link, nothing more.

Ouch. Yes - if we have four independent hosts trying to access the same
I2C hardware as another host on the same hardware, then that sounds
like a recipe for a trainwreck.

> This actually circles back to the discussion about fixed-link. The one
> host in control of all the lower hardware has the complete
> picture. The other 3 maybe just need a fixed link. They don't get to
> see what is going on below the MAC, and as a result there is no
> ethtool support to change anything, and so no conflicting
> configuration? And since they cannot control any of that, they cannot
> put the link down. So 3/4 of the problem is solved.

Should one host have control, or should the BMC have control? I don't
actually know what you're talking about w.r.t. DSP0222 or whatever it
was, nor NC-SI - I don't have these documents.

> phylink is however not expecting that when phylink_start() is called,
> it might or might not have to drive the hardware depending on if it
> wins an election to control the hardware. And if it losses, it needs
> to ditch all its configuration for a PCS, SPF, etc and swap to a
> fixed-link. Do we want to teach phylink all this, or put all phylink
> stuff into open(), rather than spread across probe() and open(). Being
> in open(), you basically construct a different phylink configuration
> depending on if you win the election or not.

That sounds very complicated and all very new stuff.

> Is one host in the position to control the complete media
> configuration? Could you split the QSFP into four, each host gets its
> own channel, and it gets to choose how to use that channel, different
> FEC schemes, bit rates?

Yes, each channel in a QSFPs have separate LOS status bits accessible
over I2C. It's been a while since I looked at this, but I seem to
remember there aren't hardware pins for LOS, TX_DISABLE etc - that's
all over I2C.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

