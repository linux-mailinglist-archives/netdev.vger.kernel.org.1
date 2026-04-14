Return-Path: <netdev+bounces-278600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJa3FDnQ3ml0IgAAu9opvQ
	(envelope-from <netdev+bounces-278600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3833FF19E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCCE3036D42
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A435C19D;
	Tue, 14 Apr 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kEv//FjR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5603CB2EA;
	Tue, 14 Apr 2026 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209916; cv=none; b=UcVwyIecbavsDbeEXAqHGpWRahQnbJ9uW0OrTnkFQnBE/2jdeELL6x67LysjdG0GU9JLumLJPHyI9Rs2MA0/ibnwrXpRbFw2oF8sf4sokMXGRwStFAznVJQlss8Mg1gJzDHwvH5EBss7FmdK06FrxGxwoQyEqlvSH6yNFYHezRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209916; c=relaxed/simple;
	bh=6WDWty/8aY0CpyFn2wQvvOFo01God1rk6PU0DkYmRH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML3mH1qqGrJP3D0IvSN7+0dXqrFFmAFMil5SkqgELuEtZEQYOIzqjQBzToK8tqR7WbgcMY2Roi4ecAb4qAa+S7dikrQ3dNB4Yaa2XGfOXD8t88lNJXL9m5GEKHn0I1YgKX9kGF51V/wh/AgR+1Dkn4JYrHrGE6SXAVIR32Htw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kEv//FjR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qsfu9lx4dXimVzqfgFepm2Tp9mFrZ4Nb+jaMnc5/0X4=; b=kEv//FjRuUw5o4UhL3TeCbPuWA
	p+MeVy8AyzkuRCdgqCCDcnaA5M1UdFz56HTv5huTaI3CkuPRMupExuBpJBHIZz73EC4F+4Tp552qW
	Tk497M0v1Eq2X+2bjhyKIKtOCVdM81KcBCVn05KMO9/UzLatmDjcbiQq4ZeTndKquH2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCnKv-00G6tv-0U; Wed, 15 Apr 2026 01:38:29 +0200
Date: Wed, 15 Apr 2026 01:38:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v9 03/10] net: phylink: Register a phy_port for
 MAC-driven SFP busses
Message-ID: <7838a71b-ae3a-4681-8516-c450ea8a5321@lunn.ch>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123755.175742-4-maxime.chevallier@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278600-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D3833FF19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This phy_port represents the SFP cage itself, and not the module

> +static int phylink_create_sfp_port(struct phylink *pl)

I'm thinking about naming here. If this represent the cage, why not
call this phylink_create_sfp_cage_port(). I assume as some point there
is going to be something for the module, and it seem like the naming
is going to be confusing.

> +{
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	if (!pl->netdev || !pl->sfp_bus)
> +		return 0;
> +
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->is_sfp = true;
> +	port->is_mii = true;
> +	port->active = true;

If this is a cage, not a module, does is_sfp = true make sense?

And what does an active cage mean?

	Andrew

