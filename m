Return-Path: <netdev+bounces-128115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B2978103
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3406DB2581F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9B41DB550;
	Fri, 13 Sep 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DkWCPtPH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3C1DA2FF;
	Fri, 13 Sep 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233595; cv=none; b=DT1BoP02D+2DWigMr30QGN0uOaqdoD3XckP8Q3U/OfX52FbLsc341uRb/vdXA86O4UlVlwu9sc8jvz7QBdQ3nn2kANcCfbMP/tnsY6uVPBFb1ry4JU9CGrKaEHXeqOIa/SslXrR0gQ4oskXgZybZfxO44KvR2B0UyAqeoi0J8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233595; c=relaxed/simple;
	bh=sNEmhx/N8+AwKemCx9RJEvLGlPu/MZXKY6FL6UOSbb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glTgI5okaiG8GUcXme9YBhhA+52JxdrzTlhA7cuwMg/14Wo3q/cLYnumEJNLkZQzftKxc7mnrCSsd6Wj60T4BmJZwxDJK6OopQpcDUSVwPeSVr5soqfS33eQx3bTKC1Ltek70BNIcMjoeyW5LKDYGccfoOFUGI5Vo1A9x4oWnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DkWCPtPH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tz1Z35ih+B7Hopu+zVSSe+Xlz6B1z7J1dHcxircymEQ=; b=DkWCPtPHN4YkI+BV7UjkhIZjQf
	7t54woOn0CgZ3mJBKwVaX7fmZWoLHerLy5RyZ/O9d1zDgeMurNe5MZk3pvpJrsaT9f1O7QKBc+7Lv
	x/PrH5RaTD3SShz5YeNcMtZcbNOQ5A0lkODxoZlXQnC8pfJDE75k3VuKflbOVj4BKix0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp6D5-007OYf-MB; Fri, 13 Sep 2024 15:19:39 +0200
Date: Fri, 13 Sep 2024 15:19:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
Cc: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>,
	UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	Steen Hegelund - M31857 <Steen.Hegelund@microchip.com>,
	Daniel Machon - M70577 <Daniel.Machon@microchip.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>

> It's my mistake. We don't need 2 MDIO buses. 
> If SFP present, XPC's MDIO bus can use,
> If not sfp, LAN743x MDIO bus can use. 

I still think this is wrong. Don't focus on 'sfp present'.

Other MAC drivers don't even know there is an SFP cage connected vs a
PHY. They just tell phylink the list of link modes they support, and
phylink tells it which one to use when the media has link.

You have a set of hardware building blocks, A MAC, a PCS, an MDIO bus.
Use the given abstractions in Linux to export them to the core, and
then let Linux combine them as needed.

Back to my question about EEPROM vs fuses. I assume it is an EEPROM,
and the PCS always exists. So always instantiate an MDIO bus and
instantiate the PCS. The MDIO bus always exists, so instantiate an
MDIO bus.

The driver itself should not really need to take any notice of the
EEPROM contents. All the EEPROM is used for is to indicate what
swnodes to create. It is a replacement of DT. Look at other drivers,
they don't parse DT to see if there is an SFP and so instantiate
different blocks.

As a silicon vendor, you want to export all the capabilities of the
device, and then sit back and watch all the weird and wonderful ways
you never even imagined it could be used come to life.

One such use case: What you can express in the EEPROM is very
limited. I would not be too surprised if somebody comes along and adds
DT overlay support. Look at what is going on with MikrotekBus and the
RPI add on chip RP1. Even microchip itself is using DT overlays with
some of its switch chips.

	Andrew

