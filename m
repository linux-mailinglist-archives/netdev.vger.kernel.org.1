Return-Path: <netdev+bounces-132800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373D993398
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B61287098
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBF1DB52C;
	Mon,  7 Oct 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aQ1giZv7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81E1DB52D;
	Mon,  7 Oct 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319062; cv=none; b=MpThhTfsLoc90KFveIEzYj7JcY75AXsvJjX8UTbz7Ef+dOMcEPy2lTVPj1wp2QZ/DTokkzcbfJhDVoTRALdXO/BjczpiYfo9MQL1MOmzrlk6Fy6pjgkx9W0suxvA/ETeKEcULYM/S83x8KhlNv8CCYeqByg6II3pZ61Yw5y2S/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319062; c=relaxed/simple;
	bh=Lq/eNFVmbw//izU0negRbSA85YJCCc+D86S80+3pHKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9Lcplp+z7/5CPP/1aymL2KXOewpVR9Cqdys2hVc8tFuF3gKmsJuQwIPFiDfqatAbMi84uPk/rG46IbppVAfnPVC38e7ADNzb4qEZcIq7cQe6Q2MtBoiZ+wOOxBuNsoAWKMjlDUHa1/nMyNIx4hE4y5xqX3DljBcG1vr6KdZebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aQ1giZv7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8WQC+zge7I/36UTRcsd6tBHsBYEQ6bykbj8mleJfkbQ=; b=aQ1giZv7A1oM0cVEKUVVv4d+71
	fgDphdxDSVZsT/nz+3qZruToOl7AqOTNBNgnBJ9zBPbP9I7Ywj5iflbVHFIjDxwESW4F68LgzBy8m
	SEYQwelR3fhKNjBHhGqgYYyJzhornDZWRSF6WQGhAS2lVOSpzpUT2BRjg2BkRhXjKsWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxqjh-009Ht7-Cv; Mon, 07 Oct 2024 18:37:29 +0200
Date: Mon, 7 Oct 2024 18:37:29 +0200
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
Message-ID: <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007154839.4b9c6a02@device-21.home>

> That's a legit point. I mentioned in the cover for V1 that this in
> itself doesn't really bring anything useful. The only point being that
> it makes it easy to test if a PHY has a working isolation mode, but
> given that we'll assume that it doesn't by default, that whole point
> is moot.
> 
> I would therefore understand if you consider that having a kAPI for
> that isn't very interesting and that I shall include this work as part
> of the multi-PHY support.

kAPI add a lot of Maintenance burden. So we should not add them unless
they are justified. to me, there is not a good justification for this.

> Sure thing. There are multiple devices out-there that may have multiple
> PHYs accessible from the MAC, through muxers (I'm trying to be generic
> enough to address all cases, gpio muxers, mmio-controlled muxers, etc.),
> but let me describe the HW I'm working on that's a bit more problematic.
> 
> The first such platform I have has an fs_enet MAC, a pair of LXT973
> PHYs for which the isolate mode doesn't work, and no on-board circuitry to
> perform the isolation. Here, we have to power one PHY down when unused :
> 
>                 /--- LXT973
> fs_enet -- MII--|
>                 \--- LXT973

So you have at least regulators under Linux control? Is that what you
mean by power down? Pulling the plug and putting it back again is
somewhat different to isolation. All its state is going to be lost,
meaning phylib needs to completely initialise it again. Or can you
hide this using PM? Just suspend/resume it?

> The second board has a fs_enet MAC and a pair of KSZ8041 PHYs connected
> in MII.
> 
> The third one has a pair of KSZ8041 PHYs connected to a
> ucc_geth MAC in RMII.
> 
> On both these boards, we isolate the PHYs when unused, and we also
> drive a GPIO to toggle some on-board circuitry to disconnect the MII
> lines as well for the unused PHY. I'd have to run some tests to see if
> this circuitry could be enough, without relying at all on PHY
> isolation :
> 
>                    /--- KSZ8041
>                    |
>       MAC ------ MUX
>                  | | 
>   to SoC <-gpio--/ \--- KSZ8041
> 
> 
> One point is, if you look at the first case (no mux), we need to know
> if the PHYs are able to isolate or not in order to use the proper
> switching strategy (isolate or power-down).

That explains the hardware, but what are the use cases? How did the
hardware designer envision this hardware being used?

If you need to power the PHY off, you cannot have dynamic behaviour
where the first to have link wins. But if you can have the media side
functional, you can do some dynamic behaviours. Although, is it wise
for the link to come up, yet to be functionally dead because it has no
MAC connected?

There are some Marvell Switches which support both internal Copper
PHYs and a SERDES port. The hardware allows first to get link to have
a functional MAC. But in Linux we have not supported that, and we
leave the unused part down so it does not get link.

Maybe we actually want energy detect, not link, to decide which PHY
should get the MAC?  But i have no real idea what you can do with
energy detect, and it would also mean building out the read_status()
call to report additional things, etc.

	Andrew


