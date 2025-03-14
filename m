Return-Path: <netdev+bounces-174964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8ABA61AC3
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF035189B589
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9515C140;
	Fri, 14 Mar 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pQoRp/7P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89A7CF16;
	Fri, 14 Mar 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980914; cv=none; b=NdkRplAsJyad5l09/TB7yEk74cU/UX7BXZ/oUdLdGGedub9bFKSmuV3MCQWYrNhlGkAEsyJL+NrJRSaYkgjO7bAdbV8SUkoHtvbMaVO2koGaR/EYQmrQE0KzZk3/n77/wHxurRKPR8pQEjx8NplhZ75+9hYgV6px/qzhhzLZwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980914; c=relaxed/simple;
	bh=vYaI8TNAD0wf8G3xgVt/LG69aIHxTT4jJn0bM9w+O5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmswjLuz3Oana9FJa0NJ6SJTZL1YK5URIHatFWoxCKxA532gITB/5SoRpAoTLKUP8BQLQb/WpKYIZPbhYnhTRdYN8/Uk8cVzzDabhjzLKSNVZF1xRVe8pBcAn32NzI0q1q3wKiAWwlRR3LOwjpPzysZxO10Dt4YNvhtlLVkN/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pQoRp/7P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g9UiPlgUHg/BOEsx5e3OD0q6bWRlSXKycrwmYgrT/Zs=; b=pQoRp/7P+Sr7BTNSui6T0CDG8p
	jN222Pv7h5IjEgKbvugzirzqLvVNQUI9zxKCuJIeyOnNOM4SE0lQy1k1Zc8iKo83nf1vgblKfhqrR
	96eHsQOxH+/mIY+dWa/H8z+bNST8C3BjfhE2kQhKlbB4jiUFe6KMtd9B3Kh7wvibDh68=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ttAo6-005O1r-Na; Fri, 14 Mar 2025 20:34:58 +0100
Date: Fri, 14 Mar 2025 20:34:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Jones <lee@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 09/13] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <49d2cfed-cb31-438d-9736-6d8e0bb24041@lunn.ch>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-10-ansuelsmth@gmail.com>
 <20250314113551.GK3890718@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113551.GK3890718@google.com>

> > +static int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
> > +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> > +{
> > +	struct mii_bus *bus = priv->bus;
> > +	int ret;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
> 
> Calling functions with '__' is a red flag.

In this case, it is correct. It was probably a bad decision to call
this __mdiobus_write() in the first place, but we were not expecting
it to be used in real driver code, just in core code, where calls to
it are wrapped with a mutex lock/unlock.

But drivers started to need to perform multiple read/write operations
in an atomic sequence, so they started doing there own taking of the
lock, and using these unlocked low level helpers.

We should probably rename __mdiobus_write() to _mdiobus_write() to
avoid compiler namespace issues.

> > +	if (ret < 0)
> > +		dev_err_ratelimited(&bus->dev,
> > +				    "failed to set an8855 mii page\n");
> 
> Use 100-chars if it avoids these kind of line breaks.

I _guess_ the code is following networking coding style, even though
it is outside of normal networking directories. netdev keeps with the
old 80 limit.

> > +static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 addr = priv->switch_addr;
> > +	int ret;
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> 
> guard()?

netdev people consider guard() too magical. scoped_guard() is however
O.K.

> > +	return ret < 0 ? ret : 0;
> 
> Doesn't the caller already expect possible >0 results?

It should not happen. Networking has a very small number of functions
which do return 1 on a different sort of success. Such functions are
generally called foo_changed(), e.g. mdiobus_modify_changed(). This
will do a read/modify/write. If it did not need to modify anything,
because of the current value, it will return 0. If something did
actually change, it returns 1. If something did actually change, you
sometimes need to take further actions. But many callers don't care,
so we have wrappers e.g. mdiobus_modify() calls
mdiobus_modify_changed() and then converts 0 or 1 to just 0. I'm
guessing this code copied such a helper when it should not of done.

	Andrew

