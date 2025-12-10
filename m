Return-Path: <netdev+bounces-244282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6366CB3CB6
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D17300A6E5
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93104329385;
	Wed, 10 Dec 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lEAROqxL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B151E8320;
	Wed, 10 Dec 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765392992; cv=none; b=e7nA/YO7ONpG7WZ3EmD593GTQ/7W6EeeouVVwRt2eKut/ODAbSPMwsbvfgnnFQefmMUzDE92TzDCcjBxaXfq+f3vkdY7Qkesdp/uXf1zWKkcufrZBMQKA3tFTD2D4ZlmQVYDycNb6IB+hvuUOTBoERM+mwEAjANdYRrB3p5J8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765392992; c=relaxed/simple;
	bh=qrbbn3eV36Nw2ao+vEGVF7AYl3Qz8GtjAWg+Soyefbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6bUCBJWwHpHc8ChO9ESLBL4ETQBxfYLPlkMhaqolJYI/zm8nfvB/GVNW49qa+WQ/QF+5IfUKJlUPzDrnD4s2za6Dc4Fq7CU0g7Fq0YjkHyuResNObz1pXr4SK77Dk/rNW2j3qgF5rPx3fSXCU+BiCCyMlnFXx+em2FWySxc8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lEAROqxL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6IYETY9gTGhZvL1uGOVErqBQbdqL5dP9cyjhDBQlylc=; b=lEAROqxLv8AfIOKClV7r+5glYK
	OOuWL4J961SbYNouDqzvdzEafjmMNHj4Jiw+gik6DaiY0KN3aSVz4ObXXXoKocK9R9cKFc+bWq0ny
	TAeNk34FC4Hgxg6tlBBRjsomwfI8seEtpCh5VP1mIODQbJvX+iXNIxoRl6qktg2b32tw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTPMD-00GZKy-5X; Wed, 10 Dec 2025 19:56:13 +0100
Date: Wed, 10 Dec 2025 19:56:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
 <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
 <aTmPjw83jFQXgWQt@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTmPjw83jFQXgWQt@makrotopia.org>

> Imho it would be nice to introduce unlock __mdiodev_c45_* helpers in
> include/linux/mdio.h, ie.
> 
> static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
> 				     u16 regnum)
> {
> 	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
> }
> 
> static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
> 				      u16 regnum, u16 val)
> {
> 	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
> 				   val);
> }

https://elixir.bootlin.com/linux/v6.18/source/drivers/net/phy/mdio_bus.c#L531

> static int mxl862xx_reg_read(struct mxl862xx_priv *priv, u32 addr)
> {
> 	return __mdiodev_c45_read(priv->mdiodev, MDIO_MMD_VEND1, addr);
> }
> 
> static int mxl862xx_reg_write(struct mxl862xx_priv *priv, u32 addr, u16 data)
> {
> 	return __mdiodev_c45_write(priv->mdiodev, MDIO_MMD_VEND1, addr, data);
> }
> 
> static int mxl862xx_ctrl_read(struct mxl862xx_priv *priv)
> {
> 	return mxl862xx_reg_read(priv, MXL862XX_MMD_REG_CTRL);
> }
> 
> static int mxl862xx_busy_wait(struct mxl862xx_priv *priv)
> {
> 	int val;
> 
> 	return readx_poll_timeout(mxl862xx_ctrl_read, priv, val,
> 				  !(val & CTRL_BUSY_MASK), 15, 10000);
> }
> 
> Do you agree?

This part, yes.

> > > +	if (result < 0) {
> > > +		ret = result;
> > > +		goto out;
> > > +	}
> > 
> > If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> > register. It seems unlikely this is a Linux error code?
> 
> Only someone with insights into the use of error codes by the uC
> firmware can really answer that. However, as also Russell pointed out,
> the whole use of s16 here with negative values being interpreted as
> errors is fishy here, because in the end this is also used to read
> registers from external MDIO connected PHYs which may return arbitrary
> 16-bit values...
> Someone in MaxLinear will need to clarify here.

It looks wrong, and since different architectures use different error
code values, it is hard to get right. I would suggest you just return
EPROTO or EIO and add a netdev_err() to print the value of result.

> > > +#define MXL862XX_API_WRITE(dev, cmd, data) \
> > > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
> > > +#define MXL862XX_API_READ(dev, cmd, data) \
> > > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)
> > 
> > > +/* PHY access via firmware relay */
> > > +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> > > +				 int devadd, int reg)
> > > +{
> > > +	struct mdio_relay_data param = {
> > > +		.phy = port,
> > > +		.mmd = devadd,
> > > +		.reg = reg & 0xffff,
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
> > 
> > That looks a bit ugly, using a macro as a function name. I would
> > suggest tiny functions rather than macros. The compiler should do the
> > right thing.
> 
> The thing is that the macro way allows to use MXL862XX_API_* on
> arbitrary types, such as the packed structs. Using a function would
> require the type of the parameter to be defined, which would result
> in a lot of code duplication in this case.

How many different invocations of these macros are there? For MDIO you
need two. How many more are there? 

     Andrew


