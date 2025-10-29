Return-Path: <netdev+bounces-233801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A1C18B5F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4351CC03E3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6130E856;
	Wed, 29 Oct 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ualg0jDe"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234252F6187;
	Wed, 29 Oct 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722681; cv=none; b=uarQQUUdWe3Gbyy7HUbasULupgPt7NMqEEyFgwD/YiDXLnQEGolrb7qmuek/LY/ghzw0db9dFyJkObARuhbcsO16Wvgtcoo350fhHWEZshOoSpDQf2D0wZB8g+JZyzzZ/5mOPlRdK0RNsKJVejhfkqAblXCTBeEVOWQrcNFp9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722681; c=relaxed/simple;
	bh=0GWIkJWV64B/4sVqOqYffExzCyyC5rCoFh2TvigNj/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZZOKJYlIeVJX2VrwjhjeHNON+4QewCo+OT9JEDb0Cc69QjIdfEeDywppZsKhBIaNcnJHcmG3TDQX/obcvPMsNhLi+3w1YQ22QqW9yh9+S8E8b12xKyKVAN/2KGcx0H/0McdEcSwxeE6WZmwd9vCzehUzC98co2BC/Ks5XULTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ualg0jDe; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6DA5EA0439;
	Wed, 29 Oct 2025 08:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=DeVVNyLNqKE4Ecf5DaOa6ywawPCDzZ6btyldSlmyF/k=; b=
	Ualg0jDe4fxNSM08c+2QhvPK2q6/qHw0TScNmS87UiMOCnFj2ME2dT/uab0+Wiba
	bkV0txAlmnUHKNBWv2tzWWZ7I8kVBV93B6jfhL14pdrfXGMYebO8GA0WDjitLb9F
	KldrZKxW2q2JhYUgi6Hqp/D5wC6hDLgxxsrBUXdsa3iA0LzfKPChwvdNNSDGMjZt
	W7jzlvtnWh3tDoxTWi9LbGfhp5iCSg5/mXlzOz+Y8doKf3GYS9Qpbqz4fCazFCZZ
	nDTzysxggkJvVA43BP+jvsbTg9RhFfNIDhr3I7Es58ClvbosihjIXfLbbhD44CmD
	PQGko4GmU1mryNcJnc3BcFGHfeklBFd2h7r62i55ZVdsJJF/pyCvG049+sRg8z/Q
	fzg25CmsBnAb7Y3hhAdtd76PXwFJ0XCShvsyy8H4vyczEmVWe1yZAQWHBkpwch0b
	PJTTlrutC09uGRdBRywbNxcGw7eSZrVdiPNvgB1FDAPr2+SPXTNo/shlUgCZc3lp
	NJwgwJd9E9rrcnItdMgfimB1v17e/KszQLM5EUll53xYKLC0nA5Hn2/4MujYFQEb
	2h7zDhZdn3a4RWWTn6F6pc5kdHaM3/60NJfsdHRkxvKx7Gwq5rEXg/20+4MCszkS
	27+K1vd5I+x2QtxJHQaX48ou5kmgS0dFTV9d5AALHXY=
Date: Wed, 29 Oct 2025 08:24:26 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <aQHBKitU6Gyjk37e@debianbuilder>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
 <bebbaef2c6801f6973ea00500a594ed934e40e47.1761124022.git.buday.csaba@prolan.hu>
 <20251028182605.06840664@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028182605.06840664@kernel.org>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761722666;VERSION=8000;MC=3785898708;ID=145001;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

On Tue, Oct 28, 2025 at 06:26:05PM -0700, Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 11:08:53 +0200 Buday Csaba wrote:
> > +/* Hard-reset a PHY before registration */
> > +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> > +			    struct fwnode_handle *phy_node)
> > +{
> > +	struct mdio_device *tmpdev;
> > +	int err;
> > +
> > +	tmpdev = mdio_device_create(bus, addr);
> > +	if (IS_ERR(tmpdev))
> > +		return PTR_ERR(tmpdev);
> > +
> > +	fwnode_handle_get(phy_node);
> > +	device_set_node(&tmpdev->dev, phy_node);
> > +	err = mdio_device_register_reset(tmpdev);
> > +	if (err) {
> > +		mdio_device_free(tmpdev);
> > +		return err;
> 
> Should we worry about -EPROBE_DEFER on any of the error paths here?
> If not maybe consider making this function void? We can add errors
> back if the caller starts to care.

That is a very valid point, thanks! I think I can handle that correctly,
by propagating that (or any other) error codes to the caller of
fwnode_mdiobus_register_phy(). fwnode_reset_phy() does nothing that
would not be expected to occur during the normal registration, so if
it fails here, it would fail later as well.

> 
> > +	}
> > +
> > +	if (mdio_device_has_reset(tmpdev)) {
> > +		dev_info(&bus->dev,
> > +			 "PHY device at address %d not detected, resetting PHY.",
> > +			 addr);
> 
> IDK if this is still strictly necessary but I guess \n at the end of
> the info msg would be idiomatic
> 

I will separate the error message to another patch, then the maintainers
can decide wheter to merge it or not.

Thanks for the feedback!
I should be able to send v5 soon.

Csaba


