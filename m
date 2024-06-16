Return-Path: <netdev+bounces-103849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CE0909E1C
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112791F21453
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2A11184;
	Sun, 16 Jun 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MthR3XnK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656F9461;
	Sun, 16 Jun 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718551294; cv=none; b=NXRdIv6h7nIYI7BNOJz6ga8bn4D8URdDawZWYG4Mwc6Ez+hD9aDYQ3RBzhfD9Sywb0K0f6Fj6OoQZQX67wjeStLfNZuhLEAbh8ueZAjKJMcRNkQmH5fy0htBqS84A/wLu5sBwUtV1tfjW2nmPQYXai9Jpus41iTTtPwl9sIrK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718551294; c=relaxed/simple;
	bh=gpXR9z4u1IadXyxkjoOHHuiwgYbHsEZ1Qk3vd75QGrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tod5IzPmu61O6qC6G9ezvz9On2Y36qWMZBvIvjMgrBWWVgJKxoixeO4eS4aA/glMg4gBObudSspo8UDX4nUAGNLHFwFh93u5PciH0dq+EbE/Mt3AM0dloEaBNQqiYJpzAZDi7sioJh2TXGHTXkENUA8N364lJ71dguH1jl009DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MthR3XnK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cv+4A+MtSDByPUMzvTt0yBJQrxD+0ofdKxmwf8vdRss=; b=MthR3XnKAFPvoA3e2vljaoUJ+l
	PM399FWLVN86Ay4DSh/3eHWJeKSMs7FnHOcWRF/XfJrBzhavPtJyHQQf/k3fTu5ktpyJzkeib8sFB
	YN6k6CxxzsYqbL1BMkK5hEmCtqoEvJH6ob5XTdRVh9afpTREflurqry+JfULPWuZo59A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIrh8-000BdR-09; Sun, 16 Jun 2024 17:21:26 +0200
Date: Sun, 16 Jun 2024 17:21:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <9dbd5b23-c59d-4200-ab9c-f8a9d736fea6@lunn.ch>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
 <20240607071836.911403-6-maxime.chevallier@bootlin.com>
 <20240613182613.5a11fca5@kernel.org>
 <20240616180231.338c2e6c@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616180231.338c2e6c@fedora>

On Sun, Jun 16, 2024 at 06:02:31PM +0200, Maxime Chevallier wrote:
> Hello Jakub,
> 
> On Thu, 13 Jun 2024 18:26:13 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> > > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > > +			struct nlattr *phy_id;
> > > +
> > > +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> > > +			phydev = phy_link_topo_get_phy(dev,
> > > +						       nla_get_u32(phy_id));  
> > 
> > Sorry for potentially repeating question (please put the answer in the
> > commit message) - are phys guaranteed not to disappear, even if the
> > netdev gets closed? this has no rtnl protection
> 
> I'll answer here so that people can correct me if I'm wrong, but I'll
> also add it in the commit logs as well (and possibly with some fixes
> depending on how this discussion goes)
> 
> While a PHY can be attached to/detached from a netdevice at open/close,
> the phy_device itself will keep on living, as its lifetime is tied to
> the underlying mdio_device (however phy_attach/detach take a ref on the
> phy_device, preventing it from vanishing while it's attached to a
> netdev)

It gets interesting with copper SFP. They contain a PHY, and that PHY
can physically disappear at any time. What i don't know is when the
logical representation of the PHY will disappear after the hotunplug
event.

	Andrew

