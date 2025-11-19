Return-Path: <netdev+bounces-240110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF68C70A5F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D6F5E29556
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1262868AB;
	Wed, 19 Nov 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A4N7QLfJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08F3043A9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577027; cv=none; b=MBg3FAAP5TZSyuu19e+xtQTTXDnueVsj6sJeV3UgtMPuxqOdJQ2/eI8wglt3wtclJCMipXkUv0fPlvBzfOlTX92IBd7di5Mrq36/WxJqP1RgCro5Qz4xYVGTRvTv+Doq9xkybv65KyV9KCs/4ZlAof7GmnxgJtgXmthj8zrhgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577027; c=relaxed/simple;
	bh=lN9nyN/3G7eMVywyMfeydand0+5ngcK4G4Ss2yA0VkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqCWM66BWrBowfaXKVFFNb0xEu2pJC0646RjtIZ8bIXLfiq7gwWckpFH9VURob7vkc/ZOuI3YtqSpYXft4hzzA4MuJSxiwwTLakVGI3nI7E1rCXs9dPWp1BHp5KTk7BKy4UMk2BHv0PIYcYO9ZBd5+7X8575VNM6mW2yUgSjpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A4N7QLfJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6pnaV6JWgDzNsCyZKhR0VqUeC33GTerXyw6zIWUs3UQ=; b=A4N7QLfJC5Qo9ppAb63oxL8Viu
	cALkKNuqmk6LpGybKzBWreTn66o+LmtmsKuK3MrDJUw4axblq6n3oZW0WtlIi6Gx69cRVylI6Ex/P
	ha2itz9zZTHtQ/zLuC/rxNREZIVQyk+ZUzFIAi5zkjpGUCyvMtTWA4LQU6II3uim9NO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLmwY-00EXGm-Ad; Wed, 19 Nov 2025 19:30:14 +0100
Date: Wed, 19 Nov 2025 19:30:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <76b04a20-2e63-4ebf-841c-303371883094@lunn.ch>
References: <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
 <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
 <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch>
 <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>
 <0d462aaa-7f41-4649-a665-de8a30a5b514@lunn.ch>
 <CAKgT0UdH_t2FO7mXWyR3V2Lo0HzKUudUF8HciYjFrx7fNUJkyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdH_t2FO7mXWyR3V2Lo0HzKUudUF8HciYjFrx7fNUJkyA@mail.gmail.com>

> I think part of the issue is the fact that a PMA/PMD and a PHY get
> blurred due to the fact that a phylib driver will automatically bind
> to said PMA/PMD.

You have some control over that. When you create the MDIO bus, you can
set mii_bus->phy_mask to make it ignore addresses on the bus. Or,
since you don't have a real MDIO bus, set the ID registers to 0xffff
and it will decided there is no device there.

If you were using device tree, you could also bind an mdio_device
device to it, rather than a phy_device. This is how we handle Ethernet
switches on MDIO busses.

> A good metaphor for something like this would be taking a car for a
> test drive versus balancing the tires. In the case of the PRBS test we
> may want to take the individual lanes and test them one at a time and
> at various frequencies to deal with potential cross talk and such. It
> isn't until we have verified everything is good there that we would
> then want to take the combination of lanes, add FEC and a PCS, and try
> sending encoded traffic over it. That said, maybe I am arguing the
> generic phy version of this testing versus the Ethernet phy version of
> it.

I think you need to decide what your real use cases are.

> True. In our case we have both PCS capability for PRBS and generic phy
> capability for that. Being able to control those at either level would
> be useful. In my mind I was thinking it might be best for us to go
> after PCS first in the case of fbnic due to the fact that the PMD is
> managed by the firmware.

And hopefully the PCS code is a lot more reusable since it should work
for any PCS conforming to 802.3, once you have straightened out the
odd register mapping your hardware has.

> Really this gets at the more fundamental problem. We still don't have
> a good way to break out all the components within the link setup.
> Things like lanes are still an abstract concept in the network setup
> and aren't really represented at all in the phylink/phylib code. Part
> of the reason for me breaking out the generic PHY as a PMD in fbnic
> was because we needed a way to somehow include the training state for
> it into the total link state.
> 
> I suspect to some extent we would need to look at something similar
> for all the PRBS testing and such to provide a way for the PCS, FEC,
> etc to all play with a generic phy in the setup and have it make sense
> to it as a network device.

I think we probably do need to represent the lanes somehow. But there
are lots of open questions. Do we have one phylink_pcs per lane? Or
one phylink_pcs which can handle multiple lanes, all being configured
the same? What needs to be considered here is probably splitting, when
you create two netdev instances each with two lanes, or 4 netdev
instances each with one lane? That is probably easier when there is a
phylink_pcs per lane, or at least, some structure which represents a
lane within a PCS.

	Andrew

