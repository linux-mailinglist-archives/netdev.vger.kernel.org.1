Return-Path: <netdev+bounces-233968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF9C1A991
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154591887A4C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A172877D0;
	Wed, 29 Oct 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nKqGe1Te"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5726B2D5;
	Wed, 29 Oct 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743024; cv=none; b=ahZ3BslY3RbsLyBg22TMU3jxdKuHY3HOBXp5zPCEGhmmMs3uL2idG/HUivOs1Auy++lL/JC6l6VPvj963h6BzUyRZq1DWoXbHOCuAPVU3bCnaajf6GT5YYmRrzVydFANc9BKpVv+lDPrkwThDy14s+xpXv5jukoPcqMjuBurMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743024; c=relaxed/simple;
	bh=3GZfxYY1lE9q6kPXQ4mdjc6k1cRrn7Z7T8r/CPfao5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbE5bNrlaVOTjmyoaePGAR8n4SF182PnJr0Nk0t++9Vh7XviGXZyo/Vh5QEgmXHqsqgQ4M158Tbul+1rPLQmhQEmbeC3Jj/0dE3E+76rE7hOxoOuZQBstiiMA8zKnE85KmDQ1KABdULCJu7hLRNYFFEGCIQmBCnYDm9Vu4RV7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nKqGe1Te; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=14vRFbB6EdU4ZT3decFu+xUDgwupG9tolVx3j09z9B0=; b=nKqGe1TegnnuCoD6I04XQSv9gP
	VUwnC9FfQ/Qg4gqC0eO4lqDeEj+IdcS6+mQfattlg1nVo3y4mdUFMKxy3za9lLsgfpyekgALpLRYZ
	EKzJVMcx9YzbCEEFvZlxIi/js9srhKgGs6AP3pnKmS2vJoyAXCLE5xEUcDnAz7znLkM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE5pq-00CPHI-Jz; Wed, 29 Oct 2025 14:03:30 +0100
Date: Wed, 29 Oct 2025 14:03:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/4] net: mdio: common handling of phy reset
 properties
Message-ID: <3a937e5c-0c0f-431f-a300-9d4c60f3a3ff@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <a96ac9a58165a4ea15b1c96cab3bbc5d568e9cba.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96ac9a58165a4ea15b1c96cab3bbc5d568e9cba.1761732347.git.buday.csaba@prolan.hu>

On Wed, Oct 29, 2025 at 11:23:41AM +0100, Buday Csaba wrote:
> Unify the handling of reset properties for an `mdio_device`.
> Replace mdiobus_register_gpiod() and mdiobus_register_reset() with
> mdio_device_register_reset() and mdio_device_unregister_reset(),
> and move them from mdio_bus.c to mdio_device.c, where they belong.

You should probably mention here that there are two sets of reset
properties. One set applies to the bus as a whole, and the second is
per device on the bus. You would expect the whole bus properties to be
handled in mdio_bus.c, where as the per device properties might make
more sense in mdio_device.c. So you can comment you are only moving
the per device reset code.

> 
> The new functions handle both reset-controllers and reset-gpios,
> and also read the corresponding firmware properties from the
> device tree, which were previously handled in fwnode_mdio.c.
> This makes tracking the reset properties easier.

Please split this patch.

It is normal when moving a function to just move it, make no
additional changes. That makes the change smaller, easier to review,
since it is all about, does the new location make sense?

Once it is in the new location, you can then have patches which
refactor it.

> -static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
> -{
> -	/* Deassert the optional reset signal */
> -	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
> -						 "reset", GPIOD_OUT_LOW);
> -	if (IS_ERR(mdiodev->reset_gpio))
> -		return PTR_ERR(mdiodev->reset_gpio);
> -
> -	if (mdiodev->reset_gpio)
> -		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
> -
> -	return 0;
> -}
> -

> +/**
> + * mdio_device_register_reset - Read and initialize the reset properties of
> + *				an mdio device
> + * @mdiodev: mdio_device structure
> + *
> + * Return: Zero if successful, negative error code on failure
> + */
> +int mdio_device_register_reset(struct mdio_device *mdiodev)
> +{
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdio_device_register_reset);

Before it did not require an EXPORT_SYMBOL, but now it does?  That
makes me wounder if it is in the correct place. This should be a core
function, why would something outside of the core need it?

Also, please use the _GPL variant.

	Andrew

