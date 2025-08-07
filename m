Return-Path: <netdev+bounces-212051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7555B1D86A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCC81AA409C
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885622561D1;
	Thu,  7 Aug 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aWNGyfuI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DC214813;
	Thu,  7 Aug 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571493; cv=none; b=a088UQBF3A/d52MVg2glJwKMTf0vAUBXkPjcgJRppi8ZdS0t3+xszmIAK5Ps5COuShRGsgnw4WVXBkgiMfU+AQDV4HwBfd5rwPI3o/FykLnULQZGB4U2MD3CM3wersc4Ch8xdwpW2lkzWzPvN4L9iCx/lrw3Kycl5nFoVeMz/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571493; c=relaxed/simple;
	bh=+GiEi5fx67ekIT8julrx4RFZSPiNtm6xOyQGY0aZCf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBbIiWHR2bVPNT+JjBe/HUuyrA5Zt7hQXU996O6EZsWV2qTcOf72IUpnMlpNQbKrRqvOqPLBLUhIWwKEITKyQUVaY2oyaYsxeBAdIhUawa0zu30s/x/th+o8yCcZ/VHJMIUvZZZlcO7htlzUvmqPgpwIjnhskD/kBijwz/nLUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aWNGyfuI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aGy12hdeb0T0FjvhNhxL30PNOwV/0qscO7Mccamc3ts=; b=aWNGyfuI6aCddNgTzdLOWfFKZF
	QKEIO2PRl0y1yQaTk/6Sgeit7uzgEFku87zor86s5yhyAynvrKsT2JPVgzYF2sWX4d1zz1TC73EHu
	XtFj6X/pPN8Sm24IIgMY7yq3DurP9doKknvpZfX9DDtv0Eyqn1Nj7lJf+vv/eWxbHslo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uk0C5-003yA0-QI; Thu, 07 Aug 2025 14:58:05 +0200
Date: Thu, 7 Aug 2025 14:58:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>, hkallweit1@gmail.com,
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <d137518b-604b-4be3-9eb1-96d49123a251@lunn.ch>
References: <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
 <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
 <aJSf0JaBl4cKphFi@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSf0JaBl4cKphFi@pengutronix.de>

> Hm, I guess, with this change there will be a subtile regression.
> In case of an external PHYs the ax88772_init_phy() is using PHYlib to
> suspend the internal PHY.
> 
> May be:
>   priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));

I looked at that:

	ret = asix_read_phy_addr(dev, true);
	if (ret < 0)
		return ret;

	priv->phy_addr = ret;
	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);

So priv->phy_addr has to be the address of the internal PHY, so this
should just work without anything special for the embedded PHY.

	Andrew

