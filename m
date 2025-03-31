Return-Path: <netdev+bounces-178303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84545A7679A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D2B1889C3C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FC210F65;
	Mon, 31 Mar 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jtIWmmTk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0317A2E2;
	Mon, 31 Mar 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430631; cv=none; b=FJ3jjq6EPKRjq7hageBLZDc63Lesc75KEAwW+3lfYRkukc0R53le2Xj6xeVG4q7y0oyJLD3McHYjlZ7VuPd2bDqh/b/ypUhbWC0OfeCdhcs19iqb2/Jhm0gKZgwNafKWX4liucbmjK6b2Hk15jB25HeoIsTHUdpXh9LookxxI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430631; c=relaxed/simple;
	bh=MWgYKnOz2M7yTVHLLeQ7sOWAf7q+a3kJKSHe6cvrYmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIer7XcHDBNGwRJ2BCNo/RNKKU5JlwFNgKgFMfnpdXPoksK5XWfVP0nJ3zSXVHSuARJqFk1fFmD4gVbKjDwUhiEvzzl59RxHld9oQqjnZkSWVT7NbDhvbMSztOwpcqaREw9T3oPfSPBZt5w6RipJ3fDKlzYKSKJBQI7mb45i8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jtIWmmTk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oeAm+G0R8MwSbWTJUOg8OxTZOg3adOagbUoCj/whS9U=; b=jt
	IWmmTkOYvq5tnXXTHiFjP32orY6aWMgPaJ6IiadRAbGsb/eYsHINOrGMDFqPZVYEvagQJ1mXKxPYY
	e4t+nTkrwXHa/ID0YCxKhsLl84AiYph7N+w1w01fE1C26rYmeQf197u18Aa5XlqYgSjYFQfKW8wZZ
	pdsnrwq+1P4/ioA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzFwk-007aEo-6c; Mon, 31 Mar 2025 16:17:02 +0200
Date: Mon, 31 Mar 2025 16:17:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <02c401a4-d255-4f1b-beaf-51a43cc087c5@lunn.ch>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home>
 <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
 <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
 <CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>

On Fri, Mar 28, 2025 at 04:26:04PM -0700, Alexander Duyck wrote:
> On Fri, Mar 28, 2025 at 2:45 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Also I am not sure it makes sense to say we can't support multiple
> > > modes on a fixed connection. For example in the case of SerDes links
> > > and the like it isn't unusual to see support for CR/KR advertised at
> > > the same speed on the same link and use the exact same configuration
> > > so a fixed config could support both and advertise both at the same
> > > time if I am not mistaken.
> >
> > Traditionally, fixed link has only supported one mode. The combination
> > of speed and duplex fully describes a base-T link. Even more
> > traditionally, it was implemented as an emulated C22 PHY, using the
> > genphy driver, so limited to just 1G. With multigige PHY we needed to
> > be a bit more flexible, so phylink gained its own fixed link
> > implementation which did not emulate a PHY, just the results of
> > talking to a multigige PHY.
> >
> > But i don't think you are actually talking about a PHY. I think you
> > mean the PCS advertises CR/KR, and you want to emulate a fixed-link
> > PCS? That is a different beast.
> >
> >         Andrew
> 
> A serdes PHY is part of it, but not a traditional twisted pair PHY as
> we are talking about 25R, 50R(50GAUI & LAUI), and 100P interfaces. I
> agree it is a different beast, but are we saying that the fixed-link
> is supposed to be a twisted pair PHY only?

With phylink, the PCS enumerates its capabilities, the PHY enumerates
its capabilities, and the MAC enumerates it capabilities. phylink then
finds the subset which all support.

As i said, historically, fixed_link was used in place of a PHY, since
it emulated a PHY. phylinks implementation of fixed_link is however
different. Can it be used in place of both a PCS and a PHY? I don't
know.

You are pushing the envelope here, and maybe we need to take a step
back and consider what is a fixed link, how does it fit into the MAC,
PCS, PHY model of enumeration? Maybe fixed link should only represent
the PHY and we need a second sort of fixed_link object to represent
the PCS? I don't know?

> In addition one advantage is that it makes it possible to support
> speeds that don't yet have a type in the phy_interface_t, so as I was
> enabling things it allowed some backwards compatibility with older
> kernels.

I don't like the sound of that. I would simply not support the older
kernels, rather than do some hacks.

	 Andrew

