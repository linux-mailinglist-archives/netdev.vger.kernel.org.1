Return-Path: <netdev+bounces-108922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FB9263DE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3761C22A12
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B917B51B;
	Wed,  3 Jul 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wNFCYmoN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEA17625D;
	Wed,  3 Jul 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018350; cv=none; b=pvL8cgFYPObsU+dZQpRO4yM63oGwBH/Y70f0kgzDuqadKTZ2poraqvGxOcdwT5U+/4wXxIfHv3lP2TOkwVFOoEz1+lDmSNJABhWZOcIxlgJA6O++ZMSNUTVkoIeeYvhg4YaughB0sy1s6lUBwMOykNQpyFXIuUl66EklmwBYmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018350; c=relaxed/simple;
	bh=p0/k9VQeW/IATPVXcdui0lUXFvcsx8iSSa/S+24EuLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1ZOG/aeajZcdYeOKK8LapasmsI72FrT8WTYEuP80uue/5mWyfMnsQsg2A13cDNl3soZHOOQnq4lLQycjozDbw4AZW0I8vV3eIlT5TKl/ZCMtHdOVFH1DaU+R4BgYBucvp+sdRLw1jceLZB2Z+tdz+phejk+YN7td8yRXomIQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wNFCYmoN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GJQEvoz0wIDeZIENvMBRDSvSZb0uYILKO4p51jsjWXc=; b=wNFCYmoNy49f91CpMZqn4/Iq1L
	KPLRCCAc3T61tv7x98xHEt73VD10OoEeAz/OADbqdIBgmLSCisoT/x0g4rwlJ2yTinMIW4sWg4McX
	7yPiHZWXr4wSWbyyKFsYPCSEaHlbv1ADF6sXlyJuKGsmRNQjsP7NEZStkLQZKPyduho3PWhOWINdc
	s5I/O1CUgzZgTZ5G4S4I4p0rtN3sLCeZVO+qYelKXUwCucRMAzqaeBEf+VLNT223H+5dIq1mArn2M
	rZ/nkoUeGzLHVwBEnRYSjjzQ64S6/TiuoILQo1YXS+1AQ+G1ZD3qS6AqpcL+e60LxqLDDCDj9L9OR
	sFxc4Tkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP1LC-0005hs-1a;
	Wed, 03 Jul 2024 15:52:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP1LA-00030B-8H; Wed, 03 Jul 2024 15:52:12 +0100
Date: Wed, 3 Jul 2024 15:52:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v15 07/14] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <ZoVlnLkXuJ0J/da3@shell.armlinux.org.uk>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
 <20240703140806.271938-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703140806.271938-8-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 04:07:57PM +0200, Maxime Chevallier wrote:
> +static int
> +ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_buff *skb)
> +{
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_device_node *pdn = req_info->pdn;
> +	struct phy_device *phydev = pdn->phy;
> +	enum phy_upstream ptype;
> +
> +	ptype = pdn->upstream_type;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
> +	    nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdio.dev)) ||
> +	    nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype) ||
> +	    nla_put_u32(skb, ETHTOOL_A_PHY_ID, phydev->phy_id))
> +		return -EMSGSIZE;

I'm really not sure that it is a good idea to export phydev->phy_id
through this API.

Clause 45-only PHYs don't have a phy_id, they have a whole bunch of
IDs (actually, two per MMD - a device ID and a package ID. I think
the package ID is supposed to be the same for all MMDs, but in
practice it isn't.

For example, 88x3310 uses:

MMD	devid		pkgid
1	002b09aa	002b09aa
3	002b09aa	002b09aa
4	01410daa	01410daa
7	002b09aa	002b09aa

So, if we want to report the ID of the PHY, then really we need to
report the clause 22 ID, and at least all the devids of each MMD in
a clause 45 PHY. Alternatively, we may decide it isn't worth the
effort of reporting any of these IDs.

However, reporting just the clause 22 ID would be a design error
IMHO.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

