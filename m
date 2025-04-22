Return-Path: <netdev+bounces-184901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E939FA97A7A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC27B3A7443
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41C262FF3;
	Tue, 22 Apr 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RZXs55jY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4D298CA1
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360780; cv=none; b=KISqOQ0Pq/CmN3qVCcgq69gqC8JPNJZF4avC8fa/UAhSJzzVpg6gbKzcVgBDghyvRHnRjREG9vXd/5zHfOhAmeEdaYYFdO+T4lhAuZXomGyTkoHKziia/5ExLmd92hkR12cICS2QwM/KD8d7FUMSmk+yhXDaERzInFmqWHQKVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360780; c=relaxed/simple;
	bh=8N+ljb1Mf8JwjZbSUuDoeFyLz9hjjOjHtU5QG+cHB9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK/I+GANK1M/yNb1PGWX76fKH9YNEiHHUqVyG2nx5vXXl6xm0slCw8Pm5naAmpK7GCvuJbQJRYOdBCJv0lQaLie3JsWt+3DHbkGOIfJYm2CYmUqTFBbHImR62lNVbEjB9vuhXeZr+e8P9jBE/4iO4cqbj18Yp1s5tEC5Tu3yjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RZXs55jY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NfB4sgEiDjZTxE0okuiNW5UGM2G+13soTZTXGqG+n70=; b=RZ
	Xs55jYXah5cWs0Rj5RGcWxp5K2MkKgOh2Q17KYmUTORlscP75jzZLgEeYbq+ctElBK1uYf720qLKw
	D2A8/Pw4ISqmBc+SW4o3apmT1UPUjllSqV/QZ4XhNq86ufAf/IsRX0WgFudMOpA14RmRRK++0sdA5
	rDdQ9werHvZtPvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7M4C-00AGj1-A0; Wed, 23 Apr 2025 00:26:12 +0200
Date: Wed, 23 Apr 2025 00:26:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch>
References: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>

On Tue, Apr 22, 2025 at 02:29:48PM -0700, Alexander Duyck wrote:
> On Tue, Apr 22, 2025 at 9:50 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > The whole concept of a multi-host NIC is new to me. So i at least need
> > > > to get up to speed with it. I've no idea if Russell has come across it
> > > > before, since it is not a SoC concept.
> > > >
> > > > I don't really want to agree to anything until i do have that concept
> > > > understood. That is part of why i asked about a standard. It is a
> > > > dense document answering a lot of questions. Without a standard, i
> > > > need to ask a lot of questions.
> > >
> > > Don't hesitate to ask the questions, your last reply contains no
> > > question marks :)
> >
> > O.K. Lets start with the basics. I assume the NIC has a PCIe connector
> > something like a 4.0 x4? Each of the four hosts in the system
> > contribute one PCIe lane. So from the host side it looks like a 4.0 x1
> > NIC?
> 
> More like 5.0 x16 split in to 4 5.0 x4 NICs.

O.K. Same thing, different scale.

> > There are not 4 host MACs connected to a 5 port switch. Rather, each
> > host gets its own subset of queues, DMA engines etc, for one shared
> > MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
> > bus, and blinky LEDs. Plus you have the BMC connected via an RMII like
> > interface.
> 
> Yeah, that is the setup so far. Basically we are using one QSFP cable
> and slicing it up. So instead of having a 100CR4 connection we might
> have 2x50CR2 operating on the same cable, or 4x25CR.

But for 2x50CR2 you have two MACs? And for 4x25CR 4 MACs?

Or is there always 4 MACs, each MAC has its own queues, and you need
to place frames into the correct queue, and with a 2x50CR2 you also
need to load balance across those two queues?

I guess the queuing does not matter much to phylink, but how do you
represent multiple PCS lanes to phylink? Up until now, one netdev has
had one PCS lane. It now has 1, 2, or 4 lanes. None of the
phylink_pcs_op have a lane indicator.
 
> > NC-SI, with Linux controlling the hardware, implies you need to be
> > able to hand off control of the GPIOs, I2C, PCS to Linux. But with
> > multi-host, it makes no sense for all 4 hosts to be trying to control
> > the GPIOs, I2C, PCS, perform SFP firmware upgrade. So it seems more
> > likely to me, one host gets put in change of everything below the
> > queues to the MAC. The others just know there is link, nothing more.
> 
> Things are a bit simpler than that. With the direct-attach we don't
> need to take any action on the SFP. Essentially the I2C and GPIOs are
> all shared. As such we can read the QSFP state, but cannot modify it
> directly. We aren't taking any actions to write to the I2C other than
> bank/page which is handled all as a part of the read call.

That might work for direct-attach, but what about the general case? We
need to ensure whatever we add supports the general case.

The current SFP code expects a Linux I2C bus. Given how SFPs are
broken, it does 16 bytes reads at the most. When it needs to read more
than 16 bytes, i expect it will set the page once, read it back to
ensure the SFP actually implements the page, and then do multiple I2C
reads to read all the data it wants from that page. I don't see how
this is going to work when the I2C bus is shared.

> > This actually circles back to the discussion about fixed-link. The one
> > host in control of all the lower hardware has the complete
> > picture. The other 3 maybe just need a fixed link. They don't get to
> > see what is going on below the MAC, and as a result there is no
> > ethtool support to change anything, and so no conflicting
> > configuration? And since they cannot control any of that, they cannot
> > put the link down. So 3/4 of the problem is solved.
> 
> Yeah, this is why I was headed down that path for a bit. However our
> links are independent with the only shared bit being the PMD and the
> SFP module.

Yours might be, but what is the general case?

	Andrew

