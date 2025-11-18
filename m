Return-Path: <netdev+bounces-239348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65889C670B6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9F96B24270
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC238327798;
	Tue, 18 Nov 2025 02:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8612D0631;
	Tue, 18 Nov 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433857; cv=none; b=dgTgrLfKhkSQ6cdmq1Ftx0TATScw1QG8BrhLe/FmBi8gj2ZALy+GDycqPJN6SKyEjFuQGASfEQYykrhdbM17dBWLi+gabXjVBskHDY/DaSlUYlxf9oa1WkxMgLdhf0LA53NEM3samUKsYdvNzM1WaHCEibn2qQaBOAhfClPK3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433857; c=relaxed/simple;
	bh=yUCY5RXHtv4MfMtZ2NRPs4k6yDKbRkNz9OStVLEyHAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0R3DigkMGIr8HDxIvbIFxuGOA+P2y27PgaccIc/aoBbXFoH0Sf8CgIkVE13WuCdueGfX5fkTk90iKHOh/zBfc8mNDDEvo1F51vIJ9zH4eXGhqiLMj8UQfDiap7ZQA1wyM0OEU8X+l0keIyNfQWLfgqS8mnezVQz68dYnpCMotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vLBhM-0000000052Y-26KM;
	Tue, 18 Nov 2025 02:44:04 +0000
Date: Tue, 18 Nov 2025 02:43:55 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-gpy: add MxL862xx support
Message-ID: <aRvdaxBjIOzspkCa@makrotopia.org>
References: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
 <5e61cac4897c8deec35a4032b5be8f85a5e45650.1762813829.git.daniel@makrotopia.org>
 <e064f831-1fe9-42d2-96fc-d901c5be66a4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e064f831-1fe9-42d2-96fc-d901c5be66a4@lunn.ch>

On Tue, Nov 11, 2025 at 02:32:38AM +0100, Andrew Lunn wrote:
> On Mon, Nov 10, 2025 at 10:35:00PM +0000, Daniel Golle wrote:
> > Add PHY driver support for Maxlinear 86252 and 86282 switches.
> > The PHYs built-into those switches are just like any other GPY 2.5G PHYs
> > with the exception of the temperature sensor data being encoded in a
> > different way.
> 
> Is there a temperature sensor per PHY, or just one for the whole
> package?
> 
> Marvell did something similar for there SoHo switches. The temperature
> sensor is mapped to each of internal PHYs register space, but in fact
> there is a single sensor, not one per PHY.

It very much looks like it is also done in the way your are describing.
The temperature reading on all 8 PHYs is almost exactly the same, even
if eg. port 1 and 2 are connected to 2.5G link partners and doing some
traffic and all other ports are disconnected the temperature stays the
same value for all of them.

Should this hence be implemented as a single sensor of the phy package?

> 
> > @@ -541,7 +581,7 @@ static int gpy_update_interface(struct phy_device *phydev)
> >  	/* Interface mode is fixed for USXGMII and integrated PHY */
> >  	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
> >  	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
> > -		return -EINVAL;
> > +		return 0;
> 
> This change is not obvious. There is no mention of it in the commit
> message. Why has something which was an error become not an error?

The interface mode doesn't need to be updated on PHYs connected with
USXGMII and integrated PHYs, and gpy_update_interface() should just
return 0 in this case rather than -EINVAL, which has wrongly been
introduced by commit 7a495dde27ebc ("net: phy: mxl-gpy: Change
gpy_update_interface() function return type"), as this breaks support
for those PHYs. The result is that read_status() will always return
-EINVAL for those interface modes.

I'll move this change into a separate patch with an appropriate
Fixes:-tag as the before mentioned commit actually breaks things.

