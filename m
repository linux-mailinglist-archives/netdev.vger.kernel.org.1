Return-Path: <netdev+bounces-184789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE26A97311
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7841E1B63BC6
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958952949EF;
	Tue, 22 Apr 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="32wF3wD4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EF2900A6
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340600; cv=none; b=ViKs5F3eJzUZTTaZT6t7OWVp4Tj2l1r7V2suz6xanuiCHuyC4ID/BbHSNLnDqqx0HU6AFLesXoXTxa+JqoIGOw2raOxBfCoD2GLOAMMk6JZzsrSQ4NKYEhK9ihnqKbHDTXngP5sAt2SXMZvX8OB3pJ7ikDkkS7HJgKAzQ1CGMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340600; c=relaxed/simple;
	bh=t9EV7kHXrhvOFKZMyAZcMQ+Ejk63ALSE52lqLlrRAY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXqQBW9UD5Rf/Xyo1CZKnbG+kqihVhg3Enyd+ViCJ77br3ASKoLOGo/59cmiKYGiXnOYFirtetLd6Vh6bvKbrpkZ0iTjzleBmEsZWNvGutAO/Wd4Dk8jz5X8eTrIsUQ3khaWYJT+7+7e3cBgmMmcs2DnIfWnfQHzs/N52/P+lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=32wF3wD4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LHiQ0GkTqRauloTKZk0nuaG2ou3x/n9K1hF95JDBAHI=; b=32wF3wD49oggi7CvWsfYntproH
	U18rt6+z916EahAALhZg00iPRMrXs9duAaMP54WkQIyGNCPbpm+2RH10yKojBHhVFxvwl0uEU9dty
	MtCeqgNJqfAdmTOxVsP3LCkIgFXu76+ZbrNUtne05hfp63KZi5XpYgmgujJJ5i174G+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7Gok-00AEOA-H7; Tue, 22 Apr 2025 18:49:54 +0200
Date: Tue, 22 Apr 2025 18:49:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422082806.6224c602@kernel.org>

> > The whole concept of a multi-host NIC is new to me. So i at least need
> > to get up to speed with it. I've no idea if Russell has come across it
> > before, since it is not a SoC concept.
> > 
> > I don't really want to agree to anything until i do have that concept
> > understood. That is part of why i asked about a standard. It is a
> > dense document answering a lot of questions. Without a standard, i
> > need to ask a lot of questions.
> 
> Don't hesitate to ask the questions, your last reply contains no
> question marks :)

O.K. Lets start with the basics. I assume the NIC has a PCIe connector
something like a 4.0 x4? Each of the four hosts in the system
contribute one PCIe lane. So from the host side it looks like a 4.0 x1
NIC?

There are not 4 host MACs connected to a 5 port switch. Rather, each
host gets its own subset of queues, DMA engines etc, for one shared
MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
bus, and blinky LEDs. Plus you have the BMC connected via an RMII like
interface.

You must have a minimum of firmware on the NIC to get the MAC into a
state the BMC can inject/receive frames, configure the PCS, gpios to
the SFP, enough I2C to figure out what the module is, what quirks are
needed etc.

NC-SI, with Linux controlling the hardware, implies you need to be
able to hand off control of the GPIOs, I2C, PCS to Linux. But with
multi-host, it makes no sense for all 4 hosts to be trying to control
the GPIOs, I2C, PCS, perform SFP firmware upgrade. So it seems more
likely to me, one host gets put in change of everything below the
queues to the MAC. The others just know there is link, nothing more.

This actually circles back to the discussion about fixed-link. The one
host in control of all the lower hardware has the complete
picture. The other 3 maybe just need a fixed link. They don't get to
see what is going on below the MAC, and as a result there is no
ethtool support to change anything, and so no conflicting
configuration? And since they cannot control any of that, they cannot
put the link down. So 3/4 of the problem is solved.

phylink is however not expecting that when phylink_start() is called,
it might or might not have to drive the hardware depending on if it
wins an election to control the hardware. And if it losses, it needs
to ditch all its configuration for a PCS, SPF, etc and swap to a
fixed-link. Do we want to teach phylink all this, or put all phylink
stuff into open(), rather than spread across probe() and open(). Being
in open(), you basically construct a different phylink configuration
depending on if you win the election or not.

Is one host in the position to control the complete media
configuration? Could you split the QSFP into four, each host gets its
own channel, and it gets to choose how to use that channel, different
FEC schemes, bit rates?

	Andrew

