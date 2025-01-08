Return-Path: <netdev+bounces-156177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14573A0550C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03284161417
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B971B422F;
	Wed,  8 Jan 2025 08:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7B1B394F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323939; cv=none; b=O/5ZIMMGVeDSrqb7kG1GwO4MzqHFmtbya7TdNnNTp2J42IgOvN1UubY/lxF7CbMOunC1eDd94OLh9nTXwyU1TIKVHphppOWQhFv1tn7XwwZPQVk7fLFI8HZ6OOs6QHUAv9YmInwR6cGSvP+bmj+uE7Ym1o2LDvmHR9yH7fH8DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323939; c=relaxed/simple;
	bh=dstrdyco9ngn9JXwzXxta98AX5DVgvA+BJ20rGUzN+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+JIw+9fT3LHdgW1RX7PZlnuPQvFl2beKROWv8duJ9DwlFfD5UctG1rdTqKHCarB7LqhreXBQe0iEYRb2D8GfuKohgG+oKW/33jezzb74x08ouaKWByonMEkTFu1dwbyrIQwQMnbTrrWTSJdfjmAPMFRvTIF1EARlhKQChAzpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVRAa-0002TW-VK; Wed, 08 Jan 2025 09:12:04 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVRAY-007U1v-0v;
	Wed, 08 Jan 2025 09:12:03 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVRAY-00BPlU-31;
	Wed, 08 Jan 2025 09:12:02 +0100
Date: Wed, 8 Jan 2025 09:12:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <Z34zUuUkx2bWXYfW@pengutronix.de>
References: <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
 <20250107171507.06908d71@fedora.home>
 <601067b3-2f8a-4080-9141-84a069db276e@lunn.ch>
 <Z31ZOjLcE34CNj0S@pengutronix.de>
 <20250108082507.0402f158@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108082507.0402f158@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jan 08, 2025 at 08:25:07AM +0100, Maxime Chevallier wrote:
> On Tue, 7 Jan 2025 17:41:30 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Tue, Jan 07, 2025 at 05:22:51PM +0100, Andrew Lunn wrote:
> > > >   I have however seen devices that have a 1G PHY connected to a RJ45
> > > > port with 2 lanes only, thus limiting the max achievable speed to 100M.
> > > > Here, we would explicietly describe the port has having 2 lanes.   
> > 
> > I can confirm existence of this kind of designs. One industrial real life
> > example: a SoC connected to 3 port Gigabit KSZ switch. One port is
> > typical RJ45 connector. Other port is RJ11 connector.
> > 
> > The speed can be reduced by using max-speed property. But i can't
> > provide any user usable diagnostic information just by saying pair A or
> > B is broken.
> > 
> > This is one of the reasons why i propose detailed description.
> 
> While I get the point, I'm wondering if it's relevant to expose this
> diag information for the user. As this is a HW design feature we're
> representing, and it's described in devicetree, the information that the
> HW design is wrong or uncommon is already known. So, exposing this to
> the user ends-up being a pretty way to display plain devicetree data,
> without much added value from the PHY stack ? Or am I missing the point
> ?

Correct. The same kind of information, such as whether the connector is RJ45 or
an industrial one with a proprietary layout, or what label this port will have
on the box, is essential. This information helps the user to manage, repair, or
connect devices in the field - even after 30 years of operation, when no paper
manual has survived being eaten by animals and the vendor's websites no longer
exist.

Here is one example of an industrial switch with PoE support:                                                                                       
https://www.westermo.com/-/media/Files/User-guides/westermo_ug_6641-22501_viper-x12a-poe_revo.pdf?rev=083148a9e565416a9044e9a4e379635f              
                                                                                                                                                    
Please pay attention to the difference for Gbit and 100Mbit ports and signal
layout within this ports.

> I would see some value if we could detect that pairs are miswired or
> disconnected at runtime, then report this to user. Here the information
> is useful.

Ack.
 
> The minimal information needed by software is in that case "how many
> working pairs are connected between the PHY and the connector", and
> possibly "are they swapped ?"

In case of home and enterprise type of devices - yes.
In case of industrial - the devices can be certified to operate in some
specific link mode.

For example device certified for explosive environments. These device should
operate in 10BaseT1L-Vpp1 mode only, and discard any link attempts to
devices which advertise 10BaseT1L-Vpp2 support in addition to 10BaseT1L-Vpp1:
https://www.pepperl-fuchs.com/germany/de/classid_260.htm?view=productdetails&prodid=118298

My point is, if we will need to set limit for the link modes, soon or later,
we will need a supported linkmodes property and this property will partially
duplicated the lanes property. At same time, if we use supported linkmodes
instead of lanes, we solve the problem with multimode PHYs which support
twisted pair and fiber modes.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

