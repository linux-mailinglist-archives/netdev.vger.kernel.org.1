Return-Path: <netdev+bounces-234007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBACC1B700
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF7622A3E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB22D29A9;
	Wed, 29 Oct 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="e30NhYV5"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA62C08BB;
	Wed, 29 Oct 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746404; cv=none; b=bd+lN7YmwGbmlUHLWJeRoLqKraMc6ricvuZxG3YCnMIt5li/VsrYD8L+JpYUvohi6whwhat/RbB9O6/sbQgbcfUHjYMuxP7md3FAmfV0/SQOyQBUYo4LJMdX51HIaDgWrNHrEwruqrS43g2ise7wcZrzDB7xTFPjPmdOqUF+SLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746404; c=relaxed/simple;
	bh=B9N5m4FMkeZUHUzR55GjpsvD3RNy4NqgzEWOKwz8dgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+xisBf19E6sBwt7Jf+V3bJgcUJTMxY2P6AFvusVtUWHhmyup8PODh9LtsaKW01k73MeN64tc7Tvwsne6HM70v9PBWA6lLaF043KCfiqwkGyvy0XwaG8GvUBQ5C7xhDbzTLWfaXAuKeltucoO/IDdS8urgh9BXr3MpzHxstq5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=e30NhYV5; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C77E7A1477;
	Wed, 29 Oct 2025 14:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=Th5b5crsMjrM5576TzmgnufvSOw4CYAbIgMlncT6eYE=; b=
	e30NhYV55d72/DmQIXSob8phZ2V1oXf6zxY+J8wp5scQfdlVBX323YgYdFcBN9dI
	/awjtjLN2r27xTce5tMNHCBKO4gh0fg9JorD1lSR/ja59xy1KtGdLrlYw1tJxkzE
	stFz+hJhB5V79rdYLM59HgbgsltcpF8EzfX1c6rmsXLetQT4w+fPMusiIMn+Zh6X
	FIXoAg3rjeJu4V7QN2KM+gA5LJ7yddCP6Cu4mDRBLsAkoo+ieVsw03NXR2tc96+W
	872DjeeqbfmypePYMRsYVXQ76J6aamXhJ8wFOBfO5H6R3EkUbrXgEYS0miAP2VXh
	LH2LbyxV6WNP6mxZ+ySxSMgYB9CaLVQuhb1spMFUGOdfWTjBvHEgPmDxKV82endi
	ydJXasIOGmliexAKJ3rQi081oQldTWk2FAWOMU3G+DHdfO2bEtkky55ILNwppsnA
	EKHBfDxgRWJ4xltO8qZUXzVHczK47WRuI0+zCzwVX8tkWDRtKu9MZk5acHFjlpC1
	vTyoR2ihhOsrpfNR2Mb/a2YfjeQKpnjXAsMgU9OE2jBuLz+jkzZ3NjKtS187eX8B
	9pys1d9Y4pE9Yoy2+wgjcxXS9TzVjArjipHQ9xswg+VaCisosNFGPCTVh6Crg5af
	BqBtJI8n+qjHMwK1PKu9SjSC+gfiwIJPRJ16drVp4hI=
Date: Wed, 29 Oct 2025 14:59:58 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/4] net: mdio: common handling of phy reset
 properties
Message-ID: <aQId3lVoDBE0557D@debianbuilder>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <a96ac9a58165a4ea15b1c96cab3bbc5d568e9cba.1761732347.git.buday.csaba@prolan.hu>
 <3a937e5c-0c0f-431f-a300-9d4c60f3a3ff@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3a937e5c-0c0f-431f-a300-9d4c60f3a3ff@lunn.ch>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761746399;VERSION=8000;MC=3337100537;ID=153779;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677362

On Wed, Oct 29, 2025 at 02:03:30PM +0100, Andrew Lunn wrote:
> On Wed, Oct 29, 2025 at 11:23:41AM +0100, Buday Csaba wrote:
> > Unify the handling of reset properties for an `mdio_device`.
> > Replace mdiobus_register_gpiod() and mdiobus_register_reset() with
> > mdio_device_register_reset() and mdio_device_unregister_reset(),
> > and move them from mdio_bus.c to mdio_device.c, where they belong.
> 
> You should probably mention here that there are two sets of reset
> properties. One set applies to the bus as a whole, and the second is
> per device on the bus. You would expect the whole bus properties to be
> handled in mdio_bus.c, where as the per device properties might make
> more sense in mdio_device.c. So you can comment you are only moving
> the per device reset code.
> 

Okay, I will do that.

> > 
> > The new functions handle both reset-controllers and reset-gpios,
> > and also read the corresponding firmware properties from the
> > device tree, which were previously handled in fwnode_mdio.c.
> > This makes tracking the reset properties easier.
> 
> Please split this patch.
> 
> It is normal when moving a function to just move it, make no
> additional changes. That makes the change smaller, easier to review,
> since it is all about, does the new location make sense?
> 
> Once it is in the new location, you can then have patches which
> refactor it.

Understood, I will change it accordingly.

> 
> > -static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
> > -{
> > -	/* Deassert the optional reset signal */
> > -	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
> > -						 "reset", GPIOD_OUT_LOW);
> > -	if (IS_ERR(mdiodev->reset_gpio))
> > -		return PTR_ERR(mdiodev->reset_gpio);
> > -
> > -	if (mdiodev->reset_gpio)
> > -		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
> > -
> > -	return 0;
> > -}
> > -
> 
> > +/**
> > + * mdio_device_register_reset - Read and initialize the reset properties of
> > + *				an mdio device
> > + * @mdiodev: mdio_device structure
> > + *
> > + * Return: Zero if successful, negative error code on failure
> > + */
> > +int mdio_device_register_reset(struct mdio_device *mdiodev)
> > +{
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(mdio_device_register_reset);
> 
> Before it did not require an EXPORT_SYMBOL, but now it does?  That
> makes me wounder if it is in the correct place. This should be a core
> function, why would something outside of the core need it?

I am using these in the third patch in fwnode_mdio.c, so I assumed it was
necessary. But you are right, neither can be in a module. I will remove it.

> 
> Also, please use the _GPL variant.
> 
> 	Andrew
> 

Csaba


