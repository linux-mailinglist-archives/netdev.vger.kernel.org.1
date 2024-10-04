Return-Path: <netdev+bounces-132198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F2990F3C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DD81C208D0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505A1E8821;
	Fri,  4 Oct 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FXKqe7eL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705961DACBC;
	Fri,  4 Oct 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067367; cv=none; b=LanZcssal7onpBa4/0PwQeYlefaczRhnmmJbpo6uGU/wHZHf8DmuTMB/Pt+eCIySqd2Pa5JKp5u8xTHBoS4zEAW2Su4FBm216DI8QS796VwCqH/X8oids3EI6wil4jvOrhU9urkgqNKeBPNGylwnviA/O3FvWi+S/8qbHns84TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067367; c=relaxed/simple;
	bh=DVwVmCYlY2xYuTUAMRS287RHTSutmXYS2Obhz0TvmWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDcxQSCtlHCDWeZRlziH2WKWfD4bgtudm8+NtuBLobsUZJMGmfafrBPInmPLAA4aFblXBUQIS9SkvrKAZu0Nnr+Kq55Fcn8+pypny4XkltrPFMFrCbU7zVLjFI1fkqQHuSluur/XdME4ns1i4oDIqO5JG7bhdZIEH2ck5+JeUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FXKqe7eL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GBgC9Tb8pPsezOHqVbYJMt9DxjXu6D55yaLDt4AVW3A=; b=FXKqe7eL3fuCrKk/VvGwsO7NAb
	he2EKZoQxyZ9e8whbZl4MKnVqCQ/gWnBiVFdsB3egy7IxZOCQdN3BwEVUadgf6HgiIt4pp8JVGZ/a
	4mNzqjmyGyn428sBurI+dbrjtzW1LAeOTnM3PXLnzAtS+ujx67vrdyWEMiVOxeSpNKZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swnGE-0095Ce-Jl; Fri, 04 Oct 2024 20:42:42 +0200
Date: Fri, 4 Oct 2024 20:42:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004161601.2932901-8-maxime.chevallier@bootlin.com>

> +int phy_set_config(struct phy_device *phydev,
> +		   const struct phy_device_config *phy_cfg,
> +		   struct netlink_ext_ack *extack)
> +{
> +	bool isolate_change;
> +	int ret;
> +
> +	mutex_lock(&phydev->lock);
> +	isolate_change = (phy_cfg->isolate != phydev->isolated);
> +	mutex_unlock(&phydev->lock);
> +
> +	if (!isolate_change)
> +		return 0;
> +
> +	ret = phy_isolate(phydev, phy_cfg->isolate);
> +	if (ret)
> +		NL_SET_ERR_MSG(extack, "Error while configuring PHY isolation");

This seems overly simplistic to me. Don't you need to iterate over all
the other PHYs attached to this MAC and ensure they are isolated? Only
one can be unisolated at once.

It is also not clear to me how this is going to work from a MAC
perspective. Does the MAC call phy_connect() multiple times? How does
ndev->phydev work? Who is responsible for the initial configuration,
such that all but one PHY is isolated?

I assume you have a real board that needs this. So i think we need to
see a bit more of the complete solution, including the MAC changes and
the device tree for the board, so we can see the big picture.

	Andrew

