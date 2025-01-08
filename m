Return-Path: <netdev+bounces-156324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D1A06107
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C713A1C4E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC821F869E;
	Wed,  8 Jan 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z4BhATwE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FA15B99E;
	Wed,  8 Jan 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352221; cv=none; b=JxUi/QeYH4PsVNt1EdKxwQxGtV1rb6ZO8kKrUty0O8AuVJyz7vbN6AY+bzCIr2ERzC5EaDeiPgzMBQ5rRs6kQ4BsDBm34Y4vHbeSkd4etgUd3B4aZ+mnPuN6FYgLtv9Db+a781WsCDEbWQlyOJSBazLrInc5Jc7pJZHjbXb+HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352221; c=relaxed/simple;
	bh=cp2K3EpYyAD2o1j3KiY+dnteSXDX9YyRSCUIZWm7hqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMYvgtVjbE07S+m3QtJPKbgVBdceIxZEsjT/AktM6LHTkaxNV190MEE9KEO9iy7rETOhxhcLYddgvW0fzfWJpgfl2xr0myuMWDzq2T6ZMIX3/4VpgT1nNbrLUz3lpdifbr94Rsrj2dnHhL7LZp+2PaGRLJFzTmtSpTIQONr7yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z4BhATwE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=15fRbm0+VBTh5S+8bPx1R7uz49/ddOCKkhD2SgaFBcg=; b=z4BhATwE9ks3ZAv2xOs92d+cRn
	u0NafwcD95atdJURa1dXPc9hinHse4iWcSfmAyGwpbPcj2Gzc2ae1JEWIhiyYr8C0suZWrNmRPPYT
	j1FwjA+UDeayNWK8nUFUtxJJ6ukiC0DQjvNjcZSS7KzdbGONGfy+plxN4gUJD9mTRenU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVYWj-002c5B-6A; Wed, 08 Jan 2025 17:03:25 +0100
Date: Wed, 8 Jan 2025 17:03:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <95111e20-d08a-42e5-b8cc-801e34d15040@lunn.ch>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
 <20250106083301.1039850-3-o.rempel@pengutronix.de>
 <20250107180216.5802e941@kernel.org>
 <Z35ApuS2S1heAqXe@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35ApuS2S1heAqXe@pengutronix.de>

On Wed, Jan 08, 2025 at 10:08:54AM +0100, Oleksij Rempel wrote:
> On Tue, Jan 07, 2025 at 06:02:16PM -0800, Jakub Kicinski wrote:
> > On Mon,  6 Jan 2025 09:32:55 +0100 Oleksij Rempel wrote:
> > > +/**
> > > + * phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
> > > + * @phydev: Pointer to the PHY device
> > > + * @link_stats: Pointer to the structure to store extended link statistics
> > > + *
> > > + * Populates the ethtool_link_ext_stats structure with link down event counts
> > > + * and additional driver-specific link statistics, if available.
> > > + */
> > > +static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
> > > +				    struct ethtool_link_ext_stats *link_stats)
> > > +{
> > > +	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
> > > +
> > > +	if (!phydev->drv || !phydev->drv->get_link_stats)
> > > +		return;
> > > +
> > > +	mutex_lock(&phydev->lock);
> > > +	phydev->drv->get_link_stats(phydev, link_stats);
> > > +	mutex_unlock(&phydev->lock);
> > > +}
> > 
> > Do these have to be static inlines?
> > 
> > Seemds like it will just bloat the header, and make alignment more
> > painful.
> 
> On one side I need to address the request to handle phydev specific
> thing withing the PHYlib framework. On other side, I can't do it without
> openen a pandora box of build dependencies. It will be a new main-side-quest
> to resolve build dependency of net/ethtool/ and PHYlib. The workaround is to
> put this functions to the header.

Yes, the code is like this because phylib can be a module, and when it
is, you would end up with unresolved symbols if ethtool code is built
in. There are circular dependence as well, if both ethtool and phylib
are module. The inlines help solve this.

However, the number of these inline functions keeps growing. At some
point, we might want a different solution. Maybe phylib needs to
register a structure of ops with ethtool when it loads? Or we give up
with phylib being modular and only allow it to be built in.

	Andrew

