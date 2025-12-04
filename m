Return-Path: <netdev+bounces-243578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF9CA3F2D
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6972305FE55
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB4273D66;
	Thu,  4 Dec 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w2wWwbli"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3023EAA0;
	Thu,  4 Dec 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857163; cv=none; b=Q2jIMmYecqsdDcSydgJ8julhkVn/RSL8OoJ9GQVUohqubu7CwRWln3WNd1I/69/97mvu+sk17tCGK7D2IWmAlU1BIlVazoyJYHimUHMFqGEB/UGnYvIvKdEi6JfzGcutKd2SMkprNIynIj3+0mx6J7rs1X6/HuFAE1plTird5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857163; c=relaxed/simple;
	bh=jhjgGxFnJJwCO/Dr1lqyMoCJYTGN5tgZCI2rZbeUzZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6torNMeAK9RnN2+jBHge5X+PI/yeuP6+03iDrK+BGqXgCELEG4fgFWiQyPwfKMHYZho5csLUuryVK0uo5FQKR6bk3zbjobGXDOYnIB5ZeQAKYQY376edOU4ZXvxd2fy6O7x7skYpzPZ5uBbF6yc/rZzdaAB0hZAIduv5LKiSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w2wWwbli; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HfRgrNu+Jy0KHcUlZ1ki4mGV+ZPLuJ1KAJBIldaUU78=; b=w2wWwblirnBXOL8A5PVg2e2lBE
	qLL6LTYCI2g+U8e+euP4o/sKm4/TNETuOzUl/XZXA4f/g4yKvzYPp6sbZQj34VhsNJabn+hmzGiAc
	vkDVGXx63Kz7Hnlwkw127SM+FEqdqFen6EpmxlYMpKFGQJZv6RJRaAOjxhI0gvtEsbJUe+xEeJbMP
	rDBE2bDwxRo4a7yvpqOumZL1n5uixP2zQv3jeaBaNLzR69xUupfzVd4TS8YAjtq5Z6P6tInbGp4jZ
	1aWU9cpfd/FpVW7MxXL7RJ8gbnEBfprTGcy9JOpN5sPCzf3syPIvGRVYkEeCd16f49ItdhQNjRGny
	SXkZdkAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vR9xp-000000003c2-3a3E;
	Thu, 04 Dec 2025 14:05:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vR9xl-0000000013p-28B4;
	Thu, 04 Dec 2025 14:05:41 +0000
Date: Thu, 4 Dec 2025 14:05:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <aTGVNfF618wssihg@shell.armlinux.org.uk>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
 <aTDGX5sUjaXzqRRn@makrotopia.org>
 <aTDdlibA99YLVSKV@shell.armlinux.org.uk>
 <aTGHyIdWL86qPUif@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTGHyIdWL86qPUif@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 04, 2025 at 01:08:24PM +0000, Daniel Golle wrote:
> On Thu, Dec 04, 2025 at 01:02:14AM +0000, Russell King (Oracle) wrote:
> > On Wed, Dec 03, 2025 at 11:23:11PM +0000, Daniel Golle wrote:
> > > On Wed, Dec 03, 2025 at 10:26:05PM +0200, Vladimir Oltean wrote:
> > > > Hi Daniel,
> > > > 
> > > > On Tue, Dec 02, 2025 at 11:37:13PM +0000, Daniel Golle wrote:
> > > > > Hi,
> > > > > 
> > > > > This series adds very basic DSA support for the MaxLinear MxL86252
> > > > > (5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
> > > > > validate and get feedback on the overall approach and driver structure,
> > > > > especially the firmware-mediated host interface.
> > > > > 
> > > > > MxL862xx integrates a firmware running on an embedded processor (Zephyr
> > > > > RTOS). Host interaction uses a simple API transported over MDIO/MMD.
> > > > > This series includes only what's needed to pass traffic between user
> > > > > ports and the CPU port: relayed MDIO to internal PHYs, basic port
> > > > > enable/disable, and CPU-port special tagging.
> > > > > 
> > > > > Thanks for taking a look.
> > > > 
> > > > I see no phylink_mac_ops in your patches.
> > > 
> > 
> > As you didn't respond to Vladimir's statement here, I will also echo
> > this. Why do you have no phylink_mac_ops ?
> > 
> > New DSA drivers are expected to always have phylink_mac_ops, and not
> > rely on the legacy fallback in net/dsa/port.c
> 
> All three phylink_mac_ops functions are no-ops for the internal PHYs,
> see also
> 
> https://github.com/frank-w/BPI-Router-Linux/blob/6.18-rc/drivers/net/dsa/mxl862xx/mxl862xx.c#L3242

While you may end up with the same three methods remaining empty,
please do not rely on the legacy fallback, even temporarily.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

