Return-Path: <netdev+bounces-178169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FDA75227
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 22:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC753B1D3E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF083199EB2;
	Fri, 28 Mar 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O2ZbY+Kz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4D17A310;
	Fri, 28 Mar 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198316; cv=none; b=STM/z3w7wOL2E8YT7eI5jdY78+BBlfF3UW/o6O+Exj2OQLHBpT9XIgWXQdXxqmJuvcxOQhQdHAVG2ud0WMop1LF2wnp72H3S5JJ3QtkivqJHYytSG9rMxKPFKZfsziRZDlQa+dXXWsu5qzweP+JdTkNf6S2IHGPctlpk1jyjZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198316; c=relaxed/simple;
	bh=qaPneDFbYXj2gMm8GbHRGcEIXZ/r6KdEtj1iNzgBglE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN6uvvFZAoe+bsNRASSCuOwXrRD+6U1IcgZt4S3m3Mp3M8Ai+W3oKrNQW+JPmbW2GSEB26DbCK1ZqaxNe197bfajU2WnA3cajrPm3vmOGhluM/45Jb5lSUgSQjFjmBNou37D1VS2lx/WvH9uQru+VxvH1tmaLC8nubwqAi/LA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O2ZbY+Kz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kqdvm7Y6OFuCO5TFEpOyK4zaILywfGPCSEV3cMDCKcg=; b=O2ZbY+KzYXZozBXClpZ0NH4MtR
	iltpvlQnKQTnKV8CgGDzpMtyrsPeGt5FrZziT8gVe+1v5vzkOErhu1hiG5NpFyrWtBGbm2rTGge7E
	zwHJo5mYWo3h3OKNarJOrNumjyRmxia1xTA+LHD5aCzVVW1JoyLl9otytTxeIQ3YDz1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tyHVh-007OT4-T3; Fri, 28 Mar 2025 22:45:05 +0100
Date: Fri, 28 Mar 2025 22:45:05 +0100
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
Message-ID: <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home>
 <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>

> Also I am not sure it makes sense to say we can't support multiple
> modes on a fixed connection. For example in the case of SerDes links
> and the like it isn't unusual to see support for CR/KR advertised at
> the same speed on the same link and use the exact same configuration
> so a fixed config could support both and advertise both at the same
> time if I am not mistaken.

Traditionally, fixed link has only supported one mode. The combination
of speed and duplex fully describes a base-T link. Even more
traditionally, it was implemented as an emulated C22 PHY, using the
genphy driver, so limited to just 1G. With multigige PHY we needed to
be a bit more flexible, so phylink gained its own fixed link
implementation which did not emulate a PHY, just the results of
talking to a multigige PHY.

But i don't think you are actually talking about a PHY. I think you
mean the PCS advertises CR/KR, and you want to emulate a fixed-link
PCS? That is a different beast.

	Andrew

