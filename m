Return-Path: <netdev+bounces-133121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD68994EFE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4944328381C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E61DF27F;
	Tue,  8 Oct 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i+s9elRp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CF1DF27A;
	Tue,  8 Oct 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393738; cv=none; b=NHQNxYvCE8F7mx+ngrEs0piQqDE2xpRXCajHF304ymRHunY2pX2KgOLeUx9KPZ4BbjXFnCaHl+R5LIjETOU3s87Av1bbmwkc2E1WeHqdvKTnVCnpzvy252O67l/qXF336zZSf1oI9dRQPXEN3lp3Bo+foVCN0+YPKoHb7c4UOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393738; c=relaxed/simple;
	bh=n5KaTdb4RXwSg1/RkCGR84Xy1C+XYkMPgjkmyycD7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8dFrO1bHGjdCwTGJkgKixgYbh50dKNXfQEsGi8m9OXVVYRnNW3njHTsEGjtFy6QNiUTxfHIBmqEepNEJcJIIFH5GHfCH0vpDpMc3XCZwQX6ryvW3fVpXCyRoeTmpcABYperg2n1fCf4fXcJNmXu6JNxVF64Nqscv53ng9qSRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i+s9elRp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XsnZnuK/j98Hu0L7nL5FXXyHsQqkZufHwDDBRdyu2JU=; b=i+s9elRpsJb5hGEfwU4vvoc2C5
	kSr3ZjFK2zYE66oZJWJGpYV1T9ZFN+eA73sKfKL9IFbDY/8kmA+WbXBJgHVnWoCi8/2CnsZ55tfpo
	LbSiEYwaQj5hpYTi52sH436uDw99WIU64TG8HyQO//MgkGzsfjNGRnUVprKUn1fCDSAKMBd7B9fPm
	PtikLNNI21KlVgiej1Gs8Sa24pwLtgkwn/dpY8wRGstcYrG03lEJMxS1Lb5YpZHL2aifVF/RWEsid
	U38pThea35D13bq7D2UR2x595yoMSpDUrMXtbtsott23Wz4HCVmjL+YbRg9dZlCgFWz/x5EB1ilc/
	yS5ct9FA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39156)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syAAE-0007WB-2p;
	Tue, 08 Oct 2024 14:22:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syAAA-0005Dr-0d;
	Tue, 08 Oct 2024 14:22:06 +0100
Date: Tue, 8 Oct 2024 14:22:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
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
Message-ID: <ZwUx_iQdZGvacH83@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
 <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
 <20241008092557.50db7539@device-21.home>
 <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 03:00:53PM +0200, Andrew Lunn wrote:
> > > So you have at least regulators under Linux control? Is that what you
> > > mean by power down? Pulling the plug and putting it back again is
> > > somewhat different to isolation. All its state is going to be lost,
> > > meaning phylib needs to completely initialise it again. Or can you
> > > hide this using PM? Just suspend/resume it?
> > 
> > Ah no, I wasn't referring to regulators but rather the BMCR PDOWN bit to
> > just shut the PHY down, as in suspend.
> 
> Ah! I wounder what 802.3 says about PDOWN? Does it say anything about
> it being equivalent to ISOLATE? That the pins go HI-Z? Are we talking
> about something semi-reliable, or something which just happens to work
> for this PHY?

"The specific behavior of a PHY in the power-down state is
implementation specific. While in the power-down state, the PHY shall
respond to management transactions. During the transition to the
power-down state and while in the power-down state, the PHY shall not
generate spurious signals on the MII or GMII."

So no, there is no requirement in 802.3 for the MII bus to go into
HI-Z state, the only requirement is to avoid creating spurious
signals. One way to achieve that would be to go into Hi-Z state,
but another way would be to drive the signals to an inactive state.
Thus, as it's not defined, setting 0.11 can't be relied upon to
allow two PHYs to be on the same MII bus.

It seems we're into implementation specifics and not generalities
here.

> > Indeed the state is lost. The way I'm supporting this is :
> > 
> >  - If one PHY has the link, it keeps it until link-down
> >  - When link-down, I round-robin between the 2 phys: 
> > 
> >   - Attach the PHY to the netdev
> >   - See if it can establish link and negotiate with LP
> >   - If there's nothing after a given period ( 2 seconds default ), then
> > I detach the PHY, attach the other one, and start again, until one of
> > them has link.
> 
> This sounds pretty invasive to the MAC driver. I don't think you need
> to attach/detach each cycle, since you don't need to send/receive any
> packets. You could hide this all in phylib. But that should be
> considered as part of the bigger picture.

Given that management transactions are permitted while PDOWN is set,
it seems we're again into an implementation specific behaviour where
setting this bit results in the PHY losing its brains. :(

> > > Although, is it wise
> > > for the link to come up, yet to be functionally dead because it has no
> > > MAC connected?
> > 
> > Good point. What would you think ? I already deal with the identified
> > issue which is that both PHYs are link-up with LP, both connected to
> > the same switch. When we switch between the active PHYs, we send a
> > gratuitous ARP on the new PHY to refresh the switch's FDB.
> 
> It seems odd to me you have redundant cables going to one switch? I
> would have the cables going in opposite directions, to two different
> switches, and have the switches in at a minimum a ring, or ideally a
> mesh.
> 
> I don't think the ARP is necessary. The link peer switch should flush
> its tables when the link goes down. But switches further away don't
> see such link events, yet they learn about the new location of the
> host. I would also expect the host sees a loss of carrier and then the
> carrier restored, which probably flushes all its tables, so it is
> going to ARP anyway.

The ARP will be necessary if you want to have the two links going to two
different switches - otherwise how does the switches upstream of those
two switches know to route packets to the MAC's ethernet address to the
different path... you'd have to wait for the higher level switches to
age their tables.

> > Note that I'm trying to support a bigger set of use-cases besides the
> > pure 2-PHY setup. One being that we have a MUX within the SoC on the
> > SERDES lanes, allowing to steer the MII interface between a PHY and an
> > SFP bus (Turris Omnia has such a setup). Is it possible to have an
> > equivalent "energy detect" on all kinds of SFPs ?
> 
> The LOS pin, which indicates if there is light entering the SFP.

Basically... no. You can't trust anything that SFPs give you. True fibre
SFPs as per the original design are way better at giving a RXLOS signal,
but everything else (including GPON) are a game.

GPON SFPs may even use the RXLOS as their UART transmit pin, wiggling it
at random times.

SFPs are a mess.

(Sorry, for what I feel is another incomplete reply...)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

