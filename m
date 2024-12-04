Return-Path: <netdev+bounces-149049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9E9E3FEC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C6CB38D80
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1920C48A;
	Wed,  4 Dec 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rYB0+3jl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623020C032;
	Wed,  4 Dec 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326911; cv=none; b=o1h4jhpLOHMpaoukS9S8BUwlfyd8nS6t6uG0YlwGIdIUGnoYwwsyP3rZDt3j1degwo6ENn9p/Szdu3xptCaO770FoPZEu9yFehkak6cspoxbjh/pf7TwrnqB/m441f8dSeNgWX7WtoiLXgt4grl9duw7/7n/aVX5epGDKy20bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326911; c=relaxed/simple;
	bh=9qC5XFIeEPv6fJHRL8DG9WVlABEvegbM6MfO+F5o+Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKD5CEfawMqiB6FUAIwHnmTX7ZWrAxTaWYicIAs84Xmm/WJT5WuvIBfHaegdfuUy0e7+mzkPRoAdAS0eOYfYBYldtD8UKUpYzvvAavNLXMy+35Z/17rv5ry/lIbd9XRP5H+4hONFzFzsM+9ynnYehhvHnfd7VSv4RIv7OthuM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rYB0+3jl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8JU87dSOgGQ075F3cYH/0T2VM64sEmEqoWMT1OVF2IM=; b=rYB0+3jlJp0NLAn7kVWU+IS3/b
	6J6OdNYPyDJWBkGBE5JB2BP1/4WXwZv/Hr9DUXjtex+ZKCa7ipsABYcqAGgMugEHhAz4UaJaNwZnJ
	WWEUa2B49PipFPPSnLJ/bZ4GwUesKkvcanU/UswuvCI+KR7oiLbuHOrnLoegi6BiJ23o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIrVN-00FE0Q-0y; Wed, 04 Dec 2024 16:41:33 +0100
Date: Wed, 4 Dec 2024 16:41:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 09/10] net: freescale: ucc_geth: Introduce a
 helper to check Reduced modes
Message-ID: <49fbbbf8-ec21-41a6-b87e-0172d0a4a2b3@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-10-maxime.chevallier@bootlin.com>
 <ce002489-2a88-47e3-ba9a-926c3a71dea9@lunn.ch>
 <20241204092232.02b8fb9a@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204092232.02b8fb9a@fedora.home>

On Wed, Dec 04, 2024 at 09:22:32AM +0100, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Wed, 4 Dec 2024 03:15:52 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static bool phy_interface_mode_is_reduced(phy_interface_t interface)
> > > +{
> > > +	return phy_interface_mode_is_rgmii(interface) ||
> > > +	       interface == PHY_INTERFACE_MODE_RMII ||
> > > +	       interface == PHY_INTERFACE_MODE_RTBI;
> > > +}  
> > 
> > I wounder if this is useful anywhere else? Did you take a look around
> > other MAC drivers? Maybe this should be in phy.h?
> 
> Yes I did consider it but it looks like ucc_geth is the only driver
> that has a configuration that applies to all R(MII/GMII/TBI) interfaces

O.K. What is important is you considered it. Thanks. Too many
developers are focus on just their driver and don't think about other
drivers and code reuse.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

