Return-Path: <netdev+bounces-179431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD54A7C9C0
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A059179B33
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31941CD1F;
	Sat,  5 Apr 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fRUmw2JH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E846FC3
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743864707; cv=none; b=iKCylpATX4bcQv5QXe4Zt2IukgDedC03u2RuPydk4ZqHqyW9N0A0maT+8LsaMJDLgUDLuutNGdbPBF+JIBbNOMpfj3K+/0nONiHOv6xICWESKPkpexkCekI1+YnDRQXguKqOVOS7CJyJikzBlsoJY9H8KAI1clFhxE16r5L64/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743864707; c=relaxed/simple;
	bh=lVS8NG/WW8Dgiuz1mUDWt3Q1RcE7vy7nq26q1HaYRaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xoi6zVC1WRImc+be4wWW3wNiX5eDA/exzy1CPG0Q57uEbA5O8OY51sOJmH+c33u67Xza5nu9EK93PtWbracEqGuF6UvFmTuKXdmEQKjKm376SA7OIzVr8BlN503gp9YR+5Z7ot4UNpxaJVQ067IDM2TNtHSsMpcIjBbrk3xWSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fRUmw2JH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ig/Qieq34fEJAEvoha2/8ZSw5WTFebYKjCsCHnYmXGo=; b=fRUmw2JHSTw0yIQMlaf3thkFrW
	H0ipu5PK1NpNMZLVUwxbFQ7VCZBn0dwEJk8OSLcXycRlx14Se66TibeZ6Td0FIUTL1l5sWcwVfWwG
	EDiHfH7pOzM8Yw+mHjaTAwl6ahZDy8BxzBx105pssQZsuv7nsfbjl527pOg+k6NYP3sI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u14rq-0087O5-QI; Sat, 05 Apr 2025 16:51:30 +0200
Date: Sat, 5 Apr 2025 16:51:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <eb115770-a8b1-4806-b8b9-ec98f44a98ee@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
 <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>

> > So for us, we have:
> >
> > MAC - PHY
> > MAC - PCS - PHY
> > MAC - PCS - SFP cage
> > MAC - PCS - PHY - SFP cage
> 
> Is this last one correct? I would have thought it would be MAC - PCS -
> SFP cage - PHY. At least that is how I remember it being with some of
> the igb setups I worked on back in the day.

This PHY is acting as an MII converter. What comes out of the PCS
cannot be directly connected to the SFP cage, it needs a
translation. The Marvell 10G PHY can do this, you see this with some
of the Marvell reference designs.

There could also be a PHY inside the SFP cage, if the media is
Base-T. Linux is not great at describing that situation, multiple PHYs
for one link, but it is getting better at that, thanks to the work
Bootlin is doing.

> 
> > This is why i keep saying you are pushing the envelope. SoC currently
> > top out at 10GbaseX. There might be 4 lanes to implement that 10G, or
> > 1 lane, but we don't care, they all get connected to a PHY, and BaseT
> > comes out the other side.
> 
> I know we are pushing the envelope. That was one of the complaints we
> had when you insisted that we switch this over to phylink. If anything
> 50G sounds like it will give the 2500BaseX a run for its money in
> terms of being even more confusing and complicated.

Well, 2500BaseX itself it straight forward. It is the vendors that
make it complex by having broken implementations.

Does your 50G mode follow the standard?

SoC vendors tend to follow the standard, which is why there is so much
code sharing possible. They often just purchase IP to implement the
boring parts like the PCS, there is no magic sauce there, all the
vendor differentiation is in the MAC, if they try to differentiate at
all in networking.

The current market is SoCs have 10G. Microchip does have a 25G link in
its switches, which uses phylink. We might see more 25G, or we might
see a jump to 40G.

I know your register layout does not follow the standard, but i hope
the registers themselves do. So i guess what will happen is when
somebody else has a 40G PCS, maybe even the same licensed IP, they
will write a translation layer on top of yours to make your registers
standards compliment, and then reuse your driver. This assumes you are
following the standard, plus/minus some integration quirks.

If you have thrown the standard out the window, and nothing is going
to be reusable then maybe you should hide it away in the MAC
driver.

> If anything we most closely resemble the setup with just the SFP cage
> and no PHY. So I suspect we will probably need that whole set in place
> in order for things to function as expected.

That is how we have seen new link modes added. Going from 2.5G to 5G
to 10G is not that big, so the patchsets are reasonably small. But the
jump from 10G to 40G is probably bigger.

If you internally use fixed-link as a development crutch, that is not
a problem. If however you want it in mainline, then we need to look at
the big picture, does it fit with what fixed-link is meant to be?

What is also going to make things complex is the BMC. SoCs and
switches don't have BMCs, Linux via phylink and all the other pieces
of the puzzle are in complete control of driving the hardware. We
don't have a good story for when Linux is only partially in control of
the hardware, because the BMC is also controlling some of it.

	Andrew

