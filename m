Return-Path: <netdev+bounces-194086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C4AC7495
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 01:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C73716CFD7
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B024D221DAD;
	Wed, 28 May 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o6hlCw7m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058A1FBCAD;
	Wed, 28 May 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476040; cv=none; b=G1tNrvi9ocUSIaUqWUzqN6M8NB/53gxIhwzchu+dKfxqC596D8pLrFa7+I9ePRIKKEx/4LaeWaT1cwp2uQGVs9Wg0OOF4+g5GWZs6mqab4llznzUYSkA2J01DOGoR0WqDXyk5DlgyqtP3Jgb2biB879FmZj0LWQORyz3f3LeN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476040; c=relaxed/simple;
	bh=LFoWHYcE2Gk1LHYov5wjtLUX2xeOzIToMTaMzE7i65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL6WqPKf4d8zisBVB6NfZoRihZ4bNo/yiq3jLiPe39o9OhTM5jREJcwpRYt6eDHShc5zVrpJbXz5N2U8tDlCqz3AlDjnLCCwvIdvdhEx2UbZLUiMUYDCkOHWZl4PdinkTdrKOOvBds6sL58TiX+/VLaHtZEAHwusbP0gktY1gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o6hlCw7m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9A6NOAoXkPb4medfypRE/loheYUcbcMxOqq+Oi8Kdr0=; b=o6hlCw7mvqwNkor+nhEqb5a8iW
	WGypf7rK2YXmDxrWO2N/pFUYHNgiw9AFnEJnMusiQo7Y+NUbi612SxuzM4kgkjdlEXrw2JL0odRHk
	ivMxyEAm0Ujad0H5cs0aX/A4wL6xceHx0gEfSi1J7N2tYdsvl3lmwpRLhqIwaLr38SAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKQUF-00EDZZ-M2; Thu, 29 May 2025 01:47:07 +0200
Date: Thu, 29 May 2025 01:47:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org,
	netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <0c7a1602-61d3-4840-83f2-72a74ffd52b8@lunn.ch>
References: <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
 <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch>
 <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
 <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch>
 <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>
 <0bf48878-a3d0-455c-9110-5c67d29073c9@lunn.ch>
 <CADvTj4qab272xTpZGRoPnCstufK_3e9CY99Og+2mey2co6u5dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qab272xTpZGRoPnCstufK_3e9CY99Og+2mey2co6u5dg@mail.gmail.com>

> > Or, as Russell suggested, you give the bootloader both .dtb blobs, and
> > it can pick the correct one to pass to the kernel. Or the bootloader
> > can patch the .dtb blob to make it fit the hardware.
> 
> This is what I'm really trying to avoid since it requires special
> handling in the bootloader and therefore will result in a lot of broken
> systems since most people doing ports to H616 based boards will only
> ever test against one PHY variant.

Which in some ways is good. They will then issue four letter words at
Allwinner, and go find a better SoC vendor.

> > > > Do you have examples of boards where the SoC variant changed during
> > > > the boards production life?
> > >
> > > Yes, the boards I'm working for example, but this is likely an issue for
> > > other boards as well(vendor BSP auto detects PHY variants):
> > > https://www.zeusbtc.com/ASIC-Miner-Repair/Parts-Tools-Details.asp?ID=1139
> >
> > Mainline generally does not care what vendors do, because they often
> > do horrible things. Which is O.K, it is open source, they can do what
> > they want in their fork of the kernel.
> 
> That's not really true IMO, mainline implements all sorts of workarounds
> for various vendor hardware quicks/weirdness.
> 
> > But for Mainline, we expect a high level of quality, and a uniform way
> > of doing things.
> 
> Sure, and I'm trying to do that here rather than do some super hacky
> unmaintainable bootloader based device tree selector.
> 
> > This can also act as push back on SoC vendors, for doing silly things
> > like changing the PHY within a SoC without changing its name/number.
> 
> It won't here, because Allwinner doesn't care about non-BSP kernels.

It can be indirect pressure. There are some OEMs which care about
Mainline. They will do their due diligence, find that user report
Mainline if flaky on these devices, and go find a different
vendor. There will be some OEM which get burnt by this mess, and when
they come to their second generation device, they will switch vendor
and tell the old vendor why. It could well be Allwinner can support
their bottom line without caring about Mainline, so really don't
care. But Mainline can help point OEMs away from them to those which
are more Mainline friendly.

We also need to think about this as a two way street. What does this
SoC bring to Mainline? Why should Mainline care about it? It has some
major design issues, do we want to say that is O.K? Do we want other
vendors to think we are O.K. with bad designs? Worse still, this is
stmmac, which lots of vendors already abuse in lots of different
ways. Russell has put in a lot of effort recently to clean up some of
that abuse, and we are pushing back hard on new abusers.

If you can hide this mess away in the bootloader, it just looks like a
regular device, we are likely to accept it. If you try to do something
different to the normal for PHYs, we are very likely to reject it.

	Andrew

