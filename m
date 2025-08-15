Return-Path: <netdev+bounces-214133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31971B28562
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2488BA1A7B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFA9475;
	Fri, 15 Aug 2025 17:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68296317719;
	Fri, 15 Aug 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280139; cv=none; b=TONwGf2vjR2R08MQrskkmCFOfLPcfvgPbIGKXbkrRvqEbez7AMBdgtGqdPLrdCoArsd6XOgMwPKFeCe/c2s4QKzzHg0MI0gjWXn8kZtCLftcLih9w2tPrL2BeTJlrYfJHGQbg156tG27XZ93sMZJ8iS9MbgM3ma7oAOEjw9ZJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280139; c=relaxed/simple;
	bh=8UsUp87pcYFRfKrrE08HvzwHG0IosSf9+e8jl7yAVXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZTYJMEgZ78tfxsSKBRGK5lf7ZqYrkXLj3n3BCPAtjtawiszVNiT68RHE/ldZstzK8gUCd7VaAgk1m9dgqeogGZL0sTIKWVrZRdC6+GQziYKSZCsM1ZF+WyFZ/bHQCSTIFHfTBNWIEZ4SNc90MWKTHPU7gr3A+hTuzBUlIqmCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1umyXo-000000002yc-22OE;
	Fri, 15 Aug 2025 17:48:48 +0000
Date: Fri, 15 Aug 2025 18:48:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-86110: add basic support for
 MxL86111 PHY
Message-ID: <aJ9y_ETT9j82BzWk@pidgin.makrotopia.org>
References: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>
 <b8075cfa-599d-4648-8e33-68062b1a855f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8075cfa-599d-4648-8e33-68062b1a855f@lunn.ch>

On Fri, Aug 15, 2025 at 07:34:05PM +0200, Andrew Lunn wrote:
> > +	/* For fiber forced mode, power down/up to re-aneg */
> > +	if (modes != LINK_INBAND_DISABLE) {
> > +		__phy_modify(phydev, MII_BMCR, 0, BMCR_PDOWN);
> > +		usleep_range(1000, 1050);
> > +		__phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
> > +	}
> 
> Is a full power down required? To restart autoneg all you normally
> need to do it set BMCR_ANRESTART. See genphy_restart_aneg().

According to the vendor driver a full power down is required when
enabling in-band-an on the SerDes interface. BMCR_ANRESTART only
affects the UTP interface apparently.

> 
> > @@ -648,8 +928,24 @@ static struct phy_driver mxl_phy_drvs[] = {
> >  		.set_wol		= mxl86110_set_wol,
> >  		.led_brightness_set	= mxl86110_led_brightness_set,
> >  		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
> > -		.led_hw_control_get     = mxl86110_led_hw_control_get,
> > -		.led_hw_control_set     = mxl86110_led_hw_control_set,
> > +		.led_hw_control_get	= mxl86110_led_hw_control_get,
> > +		.led_hw_control_set	= mxl86110_led_hw_control_set,
> 
> That should really be in a different patch.

Ok, I will break it out into a patch prepending the other two.


