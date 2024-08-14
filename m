Return-Path: <netdev+bounces-118491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF22951C56
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62274B22FF4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38B1B142C;
	Wed, 14 Aug 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BKwnKJ+2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B41AE031;
	Wed, 14 Aug 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643764; cv=none; b=buFmiNDhnSCg3k74FuH0n3l0lciCOta1rpdU/etCqOrEwP+AW1yQS1r/7GcYuEq885nZ+gyUiZj7JcFIoTBMBENI2eS23svqX63zs7K5MSuC4esJELG1QA35hGbkB2gZuCThezGlc6U+Iq0FN3TqM2cJa0kOYVxd3riIfxPZF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643764; c=relaxed/simple;
	bh=/rpKccHLFeMPwfh8/Z3y3vKNFKr0wxlFnLrbW9Ap9Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNmJjdFrFrl929iKQ8eTPqmV8pxrUDmsBChHvmRfr8glQk1KQhHLW3mBA8TXLQRazM9ZHQ+28p+cxxUA1QI7IBBPvIE34woLn6jQZ0g/AFbBBCd5I2Ec7B25feV1jzBvmW79kVgIhb1VaqJgqBpv9rq4XNJshu6YPzo3b4QfC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BKwnKJ+2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d7XSpVSeMThBLiB59+Xltez9tOwwh3c3sJ0sf1rJdMg=; b=BKwnKJ+2LVVEnDZ1xzaQphigK5
	L/qkHI/an1sVfcvLFqhR+12ngv9e3UgJh6KPsMz3rPLwIMJG+UdfD58p54B1em3noCC9kjHK2YoL+
	CZS1PkI+rhh2de4UJoLfk5EMWKL5d3PwDBh6OcR7qP7CMDZNLdjguxutlCHqlST1vWzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seETg-004ljl-0m; Wed, 14 Aug 2024 15:55:52 +0200
Date: Wed, 14 Aug 2024 15:55:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marex@denx.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Message-ID: <736f67be-a21a-40ba-9eeb-d94040d56dc2@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-4-Tristram.Ha@microchip.com>
 <301c5f90-0307-4c23-b867-6677d41dce47@lunn.ch>
 <BYAPR11MB3558DD354E8162D02E1FCC21EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558DD354E8162D02E1FCC21EC862@BYAPR11MB3558.namprd11.prod.outlook.com>

On Tue, Aug 13, 2024 at 10:24:52PM +0000, Tristram.Ha@microchip.com wrote:
> > > +static irqreturn_t ksz9477_handle_port_irq(struct ksz_device *dev, u8 port,
> > > +                                        u8 *data)
> > > +{
> > > +     struct dsa_switch *ds = dev->ds;
> > > +     struct phy_device *phydev;
> > > +     int cnt = 0;
> > > +
> > > +     phydev = mdiobus_get_phy(ds->user_mii_bus, port);
> > > +     if (*data & PORT_PHY_INT) {
> > > +             /* Handle the interrupt if there is no PHY device or its
> > > +              * interrupt is not registered yet.
> > > +              */
> > > +             if (!phydev || phydev->interrupts != PHY_INTERRUPT_ENABLED) {
> > > +                     u8 phy_status;
> > > +
> > > +                     ksz_pread8(dev, port, REG_PORT_PHY_INT_STATUS,
> > > +                                &phy_status);
> > > +                     if (phydev)
> > > +                             phy_trigger_machine(phydev);
> > > +                     ++cnt;
> > > +                     *data &= ~PORT_PHY_INT;
> > > +             }
> > > +     }
> > 
> > This looks like a layering violation. Why is this needed? An interrupt
> > controller generally has no idea what the individual interrupt is
> > about. It just calls into the interrupt core to get the handler
> > called, and then clears the interrupt. Why does that not work here?
> > 
> > What other DSA drivers do if they need to handle some of the
> > interrupts is just request the interrupt like any other driver:
> > 
> > https://elixir.bootlin.com/linux/v6.10.3/source/drivers/net/dsa/mv88e6xxx/pcs-
> > 639x.c#L95
> 
> The PHY and ACL interrupt handling can be removed, but the SGMII
> interrupt handling cannot as the SGMII port is simulated as having an
> internal PHY but the regular PHY interrupt processing will not clear the
> interrupt.
> 
> Furthermore, there will be a situation where the SGMII interrupt is
> triggered before the PHY interrupt handling function is registered.

This is one of the reasons i suggested a PCS driver. Look at
drivers/net/dsa/mv88e6xxx/pcs-6185.c as an example, how it handles
interrupts from the PCS. And it is a similar setup, the switch has an
interrupt controller, and the PCS driver requests the interrupt. PCS
drivers do not need to be complex. pcs-6185.c has an empty AN restart
callback, pcs_config does nothing, etc.

	  Andrew

