Return-Path: <netdev+bounces-155889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDBA0435F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F6A1635CC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DFD1E3DC5;
	Tue,  7 Jan 2025 14:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592080BFF
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261644; cv=none; b=LGRhrEa258pu2BYPo/sHX6KoCJieSbE/6BKN3tUyyo4djktFUv63fTGBeVGNUow75yJVf34x9Kc9WY49MmSbD0KahR6jMN2e06/DRqGYI/gWwH3nqd1Y5QVDX7WYUth+JrueREFhY+ZepHksWG0ARadyI8/ib8/3ITHNOI5pFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261644; c=relaxed/simple;
	bh=3bT1g3Gl+MHBM9Bc82K+UajTg+E4cnQ71b5tP/tg9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6PU7O/JH5ZqGOGBbPi5K/HCo8CR+fIBpYkeJYtfVsiTSdvze/yJi7RQJOyYxnhZvcpaDZGOulGtnu7JV+/DMmtwM8umq+7Udx9aL5kBbOrtiX7nxDYLO5fr2uXh63BtaB+8JKdLmXGgOQrVLqnktZg/PDYFw0t2eVP/mF8MWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAxy-00032F-BC; Tue, 07 Jan 2025 15:53:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAxx-007MWH-0E;
	Tue, 07 Jan 2025 15:53:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAxx-009auF-2K;
	Tue, 07 Jan 2025 15:53:57 +0100
Date: Tue, 7 Jan 2025 15:53:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Z31ABd8pdBjJtTiE@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z300BuATJoVDc_4S@pengutronix.de>
 <20250107154302.628e7982@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107154302.628e7982@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 03:43:02PM +0100, Kory Maincent wrote:
> On Tue, 7 Jan 2025 15:02:46 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> > > On Thu, 2 Jan 2025 18:03:52 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >   
> > > > On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote:  
> >  [...]  
> >  [...]  
> > > 
> > > Couldn't we begin with something simple like the following and add all the
> > > transformers and pairs information as you described later if the community
> > > feels we need it?
> > > 
> > > mdis {
> > > 
> > >     /* 1000BaseT Port with Ethernet and PoE */
> > >     mdi0: ethernet-mdi@0 {
> > >         reg = <0>; /* Port index */
> > >         label = "ETH0"; /* Physical label on the device */
> > >         connector = "RJ45"; /* Connector type */
> > >         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes
> > > */ lanes = <2>;
> > >         variant = "MDI-X"; /* MDI or MDI-X */
> > >         pse = <&pse1>;
> > >     };
> > > };  
> > This was only the pair swap. How to reflect the polarity swap withing
> > the pairs?
> 
> Indeed I see what you mean. Maybe we could add it later as optional binding and
> only focus for now on the current needs.
> According to Maxime proposition he wants the connector types and the
> supported modes (or number of lanes). On my side I am interested in the PSE
> phandle.
> 
> We could begin with this:
> mdis {
>     /* 1000BaseT Port with Ethernet and PoE */
>     mdi0: ethernet-mdi@0 {
>         reg = <0>; /* Port index */
>         label = "ETH0"; /* Physical label on the device */
>         connector = "RJ45"; /* Connector type */
>         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes */
>         pse = <&pse1>;
>     };
> };  
> 
> Your proposition will stay in our mind for future development on the subject.

Perfect :)

> I think we currently don't have enough time available to develop the full
> package.

Yes, no one do.

> What do you think?

Sounds good!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

