Return-Path: <netdev+bounces-156380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13704A063AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EF0163619
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39FF200B96;
	Wed,  8 Jan 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZMDQNnh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8A200130;
	Wed,  8 Jan 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358450; cv=none; b=vD12F/2Nrex27g5aQLBpZrQZNTG7nImQzd9EFn8/jpgVBPVLGEaq7qWZq2JUcA96aiLi6iemOTJDAfTlkDM82e39MCP7kzXRUJN5+k54BJOarUJGamm2JLcv76PmYsPpMilgu6cmylKGYWw3ma0G8Gq0Sit2VLKquUo/8K7mBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358450; c=relaxed/simple;
	bh=HkKfMhGO6eJvxXHBAcCwOG3GitMhNBicxP3a+OK651Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq4IfJNWvSO14rEK3dCHDBlf5zNIkdD+eyW9JQXeCJYfcLceq8WHwZbUvHugHr1OYGBEbJFpyXoN9rikr7tcKF5AkDMlbYAaX075YQHN3kWCexz8uoV0wFJvKaIjk6JoUUTWBtWMO4o/+jYot+zSfZHRNt9aHHH17gN0p0r5GyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZMDQNnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D2C4CEDF;
	Wed,  8 Jan 2025 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358450;
	bh=HkKfMhGO6eJvxXHBAcCwOG3GitMhNBicxP3a+OK651Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZMDQNnhpu6ydPKPJUwaJqTEOHeJHSC7qNwLQ/VbPn3mOOo17hLF/Gb0dAF3qnjLA
	 l/LQ0+o/SKRjTvxle4oDUrKDiTtYLjxySaAOC0Ni0UEDER/y1IX9PP9/YldzOJIw0Y
	 s2HhYxSVOcz1UO1suQ75WINZwfo1tQzBvKqCh4gFDhLoBiv4R6v2cOQgXblmJK2/sN
	 S+YK/MasV529M4jwv73Ka4Rw3ktkCdjrdbteFQEfCumLmx9KCQ2ilHBwoWO2Lm9QQ4
	 NRgONhZgscZUns/3Qc2FKXo7abGEA3vxUIP6wFKDkRpCQC71fUE3c+Mp4QdcNKBy2g
	 ykMjXdMEsLCbw==
Date: Wed, 8 Jan 2025 09:47:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250108094728.077d7bc9@kernel.org>
In-Reply-To: <20250108172456.522517ff@fedora.home>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
	<20250106083301.1039850-3-o.rempel@pengutronix.de>
	<20250107180216.5802e941@kernel.org>
	<Z35ApuS2S1heAqXe@pengutronix.de>
	<95111e20-d08a-42e5-b8cc-801e34d15040@lunn.ch>
	<20250108172456.522517ff@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 17:24:56 +0100 Maxime Chevallier wrote:
> > > On one side I need to address the request to handle phydev specific
> > > thing withing the PHYlib framework. On other side, I can't do it without
> > > openen a pandora box of build dependencies. It will be a new main-side-quest
> > > to resolve build dependency of net/ethtool/ and PHYlib. The workaround is to
> > > put this functions to the header.    
> > 
> > Yes, the code is like this because phylib can be a module, and when it
> > is, you would end up with unresolved symbols if ethtool code is built
> > in. There are circular dependence as well, if both ethtool and phylib
> > are module. The inlines help solve this.
> > 
> > However, the number of these inline functions keeps growing. At some
> > point, we might want a different solution. Maybe phylib needs to
> > register a structure of ops with ethtool when it loads?  
> 
> Isn't it already the case with the ethtool_phy_ops singleton ? Maybe we
> can add wrap the get_phy_stats / get_link_ext_stats ops to the
> ethtool_phy_ops ? My understanding was that this singleton served this
> purpose.

Right, or for tiny pieces of code like this we could as well always
build them in? Isn't drivers/net/phy/stubs.c already always built in?

