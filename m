Return-Path: <netdev+bounces-48097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0579E7EC830
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1882280E09
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C863174E;
	Wed, 15 Nov 2023 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zH/neAjb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD13173C;
	Wed, 15 Nov 2023 16:12:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26347AD;
	Wed, 15 Nov 2023 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3agsLpsSM2d58FHz7b5hDOIxhzFLmj2e63YxikopHhQ=; b=zH/neAjbIjs/dCVDLjp/tyn0Hm
	D46MRYuvFBN3YS+CfmEu+uK3mDflXyPxOyXoNQW3mjIacteJRwkCOCyLYic8chi3Qi9GLwmvjJiyi
	PsgLEgOeTJuTy17cCqCzDgZ77KbhmsCTO7yA3RbjXrN9HwBLTNcQIRNFDBpJSgceQu4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3IUl-000GHP-EA; Wed, 15 Nov 2023 17:12:03 +0100
Date: Wed, 15 Nov 2023 17:12:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 6/8] net: phy: add calibration callbacks to
 phy_driver
Message-ID: <8bd7abff-9b6d-42ac-b98f-fbfe5f0d7c00@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-7-romain.gantois@bootlin.com>
 <a4dd8cb4-f662-4dc7-8311-712c64de6f21@lunn.ch>
 <2d4c7054-1aa8-1531-ffa3-7be342ed9a07@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4c7054-1aa8-1531-ffa3-7be342ed9a07@bootlin.com>

On Wed, Nov 15, 2023 at 04:31:07PM +0100, Romain Gantois wrote:
> On Tue, 14 Nov 2023, Andrew Lunn wrote:
> 
> > > +static inline
> > > +int phy_start_calibration(struct phy_device *phydev)
> > > +{
> > > +	if (!(phydev->drv &&
> > > +	      phydev->drv->calibration_start &&
> > > +	      phydev->drv->calibration_stop))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return phydev->drv->calibration_start(phydev);
> > > +}
> > > +
> > > +static inline
> > > +int phy_stop_calibration(struct phy_device *phydev)
> > > +{
> > > +	if (!(phydev->drv &&
> > > +	      phydev->drv->calibration_stop))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return phydev->drv->calibration_stop(phydev);
> > > +}
> > > +
> > 
> > What is the locking model?
> > 
> >      Andrew
> > 
> This driver currently uses an atomic flag to make sure that the calibration 
> doesn't run twice. It doesn't acquire any locks before calling 
> phy_start_calibration(), which is a mistake.
> 
> I think a good locking model for this would be similar to the one used for 
> phy_cable_test. The phy_start_calibration() and phy_stop_calibration() wrappers 
> would acquire a lock on the PHY device and then test phydev->state, to check for 
> an ongoing calibration. A new enum member such as PHY_CALIB could be defined for 
> this purpose. The lock would be released by the phylib wrapper once the 
> phy_driver callback returns.
> 
> The problem with this is that one calibration run can access multiple 
> phy_device instances at the same time, e.g. if a switch is linked to a multiport 
> PHY via a PSGMII link.
> 
> So acquiring a lock on a single phy device isn't enough. Ideally, these 
> calls could somehow acquire one lock on all the hardware resources of a 
> multiport PHY simultaneously. From what I've seen, there is no standard kernel 
> interface that allows MAC drivers to know about link-sharing between phy 
> devices. I'll have to do more research on this but if you know of an existing 
> interface that I can use for this, please tell me.

Lets get the switch parts merged first, then we can think about this
calibration problem. I need a better understanding of the requirements
before i can suggest something.

       Andrew


