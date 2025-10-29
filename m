Return-Path: <netdev+bounces-234008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B27BCC1B68D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA1745685ED
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25F25229C;
	Wed, 29 Oct 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hMxSONcS"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D88254AE1;
	Wed, 29 Oct 2025 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747332; cv=none; b=VQffQ4xEPlN4HYY8kge84OH3RdqbV6u/Gz0z8Pwuzgyir15z1mkjthz5VbpbbznSWOoGH89Xj6QWPuQa+kTZ4FTKXcNe3otN8Zlc0y+tPlE6QXs4sl/Yq7OQtast5L1RwMDa0X3Kzjk5eoznZW7GqVprIL3TsjxG72LqxJgsOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747332; c=relaxed/simple;
	bh=RZm6bZIS4bNLDUlPnk4g887+82E7lvxrRpfpy6mBLtE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8PRAas1J5Ah9hjVeTjSTJMp/8vZV7f1j6ea/oMYJRZKF5kaCtoEENgljAPK8dPEghItFef167xarFWo6xi6waIY9wJ06pDCIsez/RTUkJXt3q69yrQV2G0O6dzLk42NTugiaEZPMtvJWKsy35MlezMMC7BqjcHrr3dXqGt94Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hMxSONcS; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2CD66A103D;
	Wed, 29 Oct 2025 15:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=S6KdbNwAQ7YpbZD9A84wYipdmyYEdIHycsiERqFOZJc=; b=
	hMxSONcS++SGDe0QWqHBdwTHBHSJ0/QPvJguHK3Chras0irk42VtLSKpYYMxJXpt
	BbrEhVf42ipJSHJdtCdc55vm9eyHKPHVo/sWfHviBtGtqJ/rqFeo2/CsSLTd5aHB
	RlJRdnCik1WOu62Wi0+udkzydUGIQZpXwIq1NWKkUnueBAyvaLN9IeCPZIkU0IUe
	mP2ofuTmwGC3T9oFwcV+4OS+opkEvntKr+/LS+58WWiJMedZJjKnPTZ25OF2yZSq
	AKPRoG0L3pXL5JhA5P6B/7yAqiwlaNJeD1ZoMER9ol/0f4Q3XhRG435NCOktKy//
	xCNwGWUPmWKNrUzJ1VAay1BQIRL5HAWe/DF1n25pElNE5YJyJbg/AtoBpOIowCkx
	ibLpmoI+RZlHYMyHdBNAytwcONMnSHOOrXDh2X7RQCvWs6ThzBSiLqVaLkWzGO3f
	3u6a+b4K382OlLzSoNOufJ2SAKHu8Y9Ft7RW5rsZOg1QD/rTjcTzbh8JYF8/ixHB
	m+/P7ww0NtOI867MoS3wIvHZKmoXqdaWk/kz2H3hiHNbiZ938TiGB8WQoL0XdnP4
	8i7ksBTgBCxk4t7YJpPw3obPnuBIb1z9q5htPUYDl6V3mnOPpyCJpUI3gK8fj1mL
	4uWE9jfrfQRWvXma+utowZ0Q5yH+lJyj8JrUtXZ/7EA=
Date: Wed, 29 Oct 2025 15:15:27 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <aQIhf3dXOxS4vd2W@debianbuilder>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>
 <e61e1c1c-083b-472f-8edd-b16832ca578e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e61e1c1c-083b-472f-8edd-b16832ca578e@lunn.ch>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761747327;VERSION=8000;MC=1979873367;ID=153868;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677362

On Wed, Oct 29, 2025 at 02:20:14PM +0100, Andrew Lunn wrote:
> > +/* Hard-reset a PHY before registration */
> > +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> > +			    struct fwnode_handle *phy_node)
> > +{
> > +	struct mdio_device *tmpdev;
> > +	int rc;
> > +
> > +	tmpdev = mdio_device_create(bus, addr);
> > +	if (IS_ERR(tmpdev))
> > +		return PTR_ERR(tmpdev);
> > +
> > +	fwnode_handle_get(phy_node);
> 
> You add a _get() here. Where is the corresponding _put()?

When mdio_device_free() is called, it eventually invokes
mdio_device_release(). There is the corresponding _put(), that will
release the reference. I also verified this with a stack trace.

> 
> Also, fwnode_handle_get() returns a handle. Why do you throw it away?
> What is the point of this get?
>

I copied this initialization stub from of_mdiobus_register_device()
in of_mdio.c. The same pattern is used there:

	fwnode_handle_get(fwnode);
	device_set_node(&mdiodev->dev, fwnode);

It is kind of awkward that we need to half-establish a device, just
to assert the reset, but I could not think of any better solution, that
does not lead to a large amount of code duplication.

> > +	device_set_node(&tmpdev->dev, phy_node);
> > +	rc = mdio_device_register_reset(tmpdev);
> > +	if (rc) {
> > +		mdio_device_free(tmpdev);
> > +		return rc;
> > +	}
> > +
> > +	mdio_device_reset(tmpdev, 1);
> > +	mdio_device_reset(tmpdev, 0);
> > +
> > +	mdio_device_unregister_reset(tmpdev);
> > +	mdio_device_free(tmpdev);
> > +
> > +	return 0;
> > +}
> > +
> 
> 	Andrew
> 

Csaba


