Return-Path: <netdev+bounces-133107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0ED994D0F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773571F2421B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97E1DE8A0;
	Tue,  8 Oct 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jr+LQZcw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1918F2FA;
	Tue,  8 Oct 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392460; cv=none; b=sSddg0IZ5jkGQe35m/7bSCjj2N1LJpoqeZ2yLanngd6FjY8ekNdrB2wF2dlSj+8+8Zce8ajHhlX7zDcJ8syxSZGja7nCTo1oZpB9d23XOyCUugQuMluoS1JJgU1oQXUzRDAGYLjquposa6eMEBcBzgtqr2yCcDQtIT6HtKEUdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392460; c=relaxed/simple;
	bh=h0eqizrzvYl6Uq7wcFh5HCi7VcoChZjTWjuB7JRAYw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJQbpyB+axKR0R9Ac71cX1H92ZYE+JETlwuuyKxwS8ptjpS+hyUrhhsEBZa9JtBtAJVbMKCS52GlkvOqsku4k1z1/sz85YwjamrANPIiMSXPcwLpaidqpcZEf8rSAWBXPCVdMX768PqQu3mVoES1huCPexJtdsclmiVJx7Wlimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jr+LQZcw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=efcnzor9FQOZgn8Q7CqORQfIwqJ3qUcW4F3Xo2K+mYQ=; b=Jr+LQZcwGpvAIqdCVIyWaSeeLx
	+FWB4e1QxTJcCs1P7UO2dV4mpqu+5RQRwr4cdyHD5VAAHxF3y2kVJSyASrVn6WYK9z5zrtqpiv7m4
	rCE3RIwjFN97YvWg73XhE80Sju8BaUWx6Ik9heVUSKvR6Os9Zcob9ENm9bF/N2BfDDaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sy9pd-009N4E-PT; Tue, 08 Oct 2024 15:00:53 +0200
Date: Tue, 8 Oct 2024 15:00:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
 <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
 <20241008092557.50db7539@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008092557.50db7539@device-21.home>

> > So you have at least regulators under Linux control? Is that what you
> > mean by power down? Pulling the plug and putting it back again is
> > somewhat different to isolation. All its state is going to be lost,
> > meaning phylib needs to completely initialise it again. Or can you
> > hide this using PM? Just suspend/resume it?
> 
> Ah no, I wasn't referring to regulators but rather the BMCR PDOWN bit to
> just shut the PHY down, as in suspend.

Ah! I wounder what 802.3 says about PDOWN? Does it say anything about
it being equivalent to ISOLATE? That the pins go HI-Z? Are we talking
about something semi-reliable, or something which just happens to work
for this PHY?

> Indeed the state is lost. The way I'm supporting this is :
> 
>  - If one PHY has the link, it keeps it until link-down
>  - When link-down, I round-robin between the 2 phys: 
> 
>   - Attach the PHY to the netdev
>   - See if it can establish link and negotiate with LP
>   - If there's nothing after a given period ( 2 seconds default ), then
> I detach the PHY, attach the other one, and start again, until one of
> them has link.

This sounds pretty invasive to the MAC driver. I don't think you need
to attach/detach each cycle, since you don't need to send/receive any
packets. You could hide this all in phylib. But that should be
considered as part of the bigger picture.

I assume it is not actually 2 seconds, but some random number in the
range 1-3 seconds, so when both ends are searching they do eventually
find each other?

> > That explains the hardware, but what are the use cases? How did the
> > hardware designer envision this hardware being used?
> 
> The use-case is link redundancy, if one PHY loses the link, we hope
> that we still have link on the other one and switchover. This is one of
> the things I discussed at netdev 0x17.

> > If you need to power the PHY off, you cannot have dynamic behaviour
> > where the first to have link wins. But if you can have the media side
> > functional, you can do some dynamic behaviours.
> 
> True.
> 
> > Although, is it wise
> > for the link to come up, yet to be functionally dead because it has no
> > MAC connected?
> 
> Good point. What would you think ? I already deal with the identified
> issue which is that both PHYs are link-up with LP, both connected to
> the same switch. When we switch between the active PHYs, we send a
> gratuitous ARP on the new PHY to refresh the switch's FDB.

It seems odd to me you have redundant cables going to one switch? I
would have the cables going in opposite directions, to two different
switches, and have the switches in at a minimum a ring, or ideally a
mesh.

I don't think the ARP is necessary. The link peer switch should flush
its tables when the link goes down. But switches further away don't
see such link events, yet they learn about the new location of the
host. I would also expect the host sees a loss of carrier and then the
carrier restored, which probably flushes all its tables, so it is
going to ARP anyway.

> 
> Do you see that as being an issue, having the LP see link-up when the
> link cannot actually convey data ? Besides the energy detect feature
> you mention, I don't see what other options we can have unfortunately :(

Maybe see what 802.3 says about advertising with no link
modes. Autoneg should complete, in that the peers exchange messages,
but the result of the autoneg is that they have no common modes, so
the link won't come up. Is it clearly defined what should happen in
this case? But we are in a corner case, similar to ISOLATE, which i
guess rarely gets tested, so is often broken. I would guess power
detection would be more reliable when implemented. 

> > There are some Marvell Switches which support both internal Copper
> > PHYs and a SERDES port. The hardware allows first to get link to have
> > a functional MAC. But in Linux we have not supported that, and we
> > leave the unused part down so it does not get link.
> 
> My plan is to support these as well. For the end-user, it makes no
> difference wether the HW internally has 2 PHYs each with one port, or 1
> phy with 2 ports. So to me, if we want to support phy_mux, we should
> also support the case you mention above. I have some code to support
> this, but that's the part where I'm still getting things ironed-out,
> this is pretty tricky to represent that properly, especially in DT.
> 
> >
> > Maybe we actually want energy detect, not link, to decide which PHY
> > should get the MAC?  But i have no real idea what you can do with
> > energy detect, and it would also mean building out the read_status()
> > call to report additional things, etc.
> 
> Note that I'm trying to support a bigger set of use-cases besides the
> pure 2-PHY setup. One being that we have a MUX within the SoC on the
> SERDES lanes, allowing to steer the MII interface between a PHY and an
> SFP bus (Turris Omnia has such a setup). Is it possible to have an
> equivalent "energy detect" on all kinds of SFPs ?

The LOS pin, which indicates if there is light entering the SFP.

> As a note, I do see that both Russell and you may think you're being
> "drip-fed" (I learned that term today) information, that's not my
> intent at all, I wasn't expecting this discussion now, sorry about that.

It is a difficult set of problems, and you are addressing it from the
very niche end first using mechanisms which i expect are not reliably
implemented. So we are going to ask lots of questions.

You probably would of got less questions if you have started with the
use cases for the Turris Omnia and Marvell Ethernet switch, which are
more mainstream, and then extended it with your niche device. But i
can understand this order, you probably have a customer with this
niche device...

	Andrew

