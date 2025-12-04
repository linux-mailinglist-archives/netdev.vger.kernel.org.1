Return-Path: <netdev+bounces-243490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC15CA2142
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 02:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92103002B1C
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCF1E32CF;
	Thu,  4 Dec 2025 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hULWwiei"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5D1465B4;
	Thu,  4 Dec 2025 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764810148; cv=none; b=oNgHuc0x/I9TqRXyfhKsaO6yfa0a1YA3j4UVTs3Qbd9U0UcJOQaSfCn5kA2OhP0ywSrDIE1/1TVcigzNoNDjUeuFfAeFXXD0sOItuouApzwBPRg36S2I4iwH9z3ZlHcwMYbbeNp+1wATwAEUshgxw630nsVXPfZbgD4lc+9asdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764810148; c=relaxed/simple;
	bh=bg88pLMr9CMYzkHaGdi+LhvOj97+QHA/B2ATzDj7aGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZbctjlCJ9NDpoWc7TmqhLPiMGy6VAGYdKZgTW1NeaEKwQfyhwvD1sPw4DJaFNR7HFf97SDfbBEkLRqZ0EmM+y/XE/0Y/Hhucm+JIhFzWkmMkNaJx9w1R8l6DZHoWNYCFVNMo17OD5Qn7RWVYs2BunPelFsgP9K/8rZx17aT7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hULWwiei; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wAIbeQSPfCT7r8tmW2D+4WrIu0ifhLWF/0TXZLA3tpI=; b=hULWwieiAhju9D/LhlU3sKTreh
	zktUwShzm0/KTWJ8HljfJq1hS2EfH5T+jeayJAbkRNUUMtWdxqSKsSHdOHiN9MfayukeWlJpP+CfE
	ca9+Lc0k/RDtbEdEr2Z+nM7XlaKAsKsiEP1FZWdiH2JJCxI2XdW7K0T6GuEU2C6Ikb8HdB+PzyE6b
	C5KFsJLJ641Uiabe3l7eUfpv+ZaO9iwz+NUdfq9H4CYbz5iGfTiQI421SVkamZQQxzadhG1HY5bSR
	f4feuGf0wNhh3arFTE0XDG/u7ZXV55HxxF5qoSl/jwC1uSy4YcjMSMAckgINay2Ai2MTlfY6dE2Mo
	FErjGqWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQxjc-0000000031r-3auy;
	Thu, 04 Dec 2025 01:02:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQxja-000000000WL-41JF;
	Thu, 04 Dec 2025 01:02:15 +0000
Date: Thu, 4 Dec 2025 01:02:14 +0000
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
Message-ID: <aTDdlibA99YLVSKV@shell.armlinux.org.uk>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
 <aTDGX5sUjaXzqRRn@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTDGX5sUjaXzqRRn@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 03, 2025 at 11:23:11PM +0000, Daniel Golle wrote:
> On Wed, Dec 03, 2025 at 10:26:05PM +0200, Vladimir Oltean wrote:
> > Hi Daniel,
> > 
> > On Tue, Dec 02, 2025 at 11:37:13PM +0000, Daniel Golle wrote:
> > > Hi,
> > > 
> > > This series adds very basic DSA support for the MaxLinear MxL86252
> > > (5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
> > > validate and get feedback on the overall approach and driver structure,
> > > especially the firmware-mediated host interface.
> > > 
> > > MxL862xx integrates a firmware running on an embedded processor (Zephyr
> > > RTOS). Host interaction uses a simple API transported over MDIO/MMD.
> > > This series includes only what's needed to pass traffic between user
> > > ports and the CPU port: relayed MDIO to internal PHYs, basic port
> > > enable/disable, and CPU-port special tagging.
> > > 
> > > Thanks for taking a look.
> > 
> > I see no phylink_mac_ops in your patches.
> 

As you didn't respond to Vladimir's statement here, I will also echo
this. Why do you have no phylink_mac_ops ?

New DSA drivers are expected to always have phylink_mac_ops, and not
rely on the legacy fallback in net/dsa/port.c

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

