Return-Path: <netdev+bounces-140109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D89B540A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896C7285052
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50320E007;
	Tue, 29 Oct 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QZcROyti"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27620CCE8;
	Tue, 29 Oct 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234166; cv=none; b=NXJzddqsndMAbcpj0fb7tak59LI0b87iP63zNqpWOZz5MrgXsdkPFU/SI/aHldag6x5UbZOecbbXVeo8NAERjjS4/cAE9mKYrrAeVtxIIxBAWlzux8fxQ0F/8IbsRotZlFEq/JsfdT3KhVeo371KPTLwoeRAh9qCfueRHp5cysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234166; c=relaxed/simple;
	bh=BZmrs4S9k39IJJULoU81FPP8LRG2DOiE5NO6ktXbR1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GihkUxtSE+d321DjlBXgyMhaD/EOe4Upx4gbH+lT+xg4MqaetywthTC2wcmXG2K7Uq+IqbrbbO/G1Tm9tWMJ/32GTcvO8bo7w5PZ8qEbMrZ92CCq8oTirfeV6kuooXa5cF6lxQWh/UxMJM1bD2Mr52Dc/H6KpbTiJUWrFuFlRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QZcROyti; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TGIE8EDbEDiCSNt9NYlYRAJD3YqeUTSIjpPX0liXfr0=; b=QZcROytiBRWYnrJR+BgvG0nRyQ
	jGUHXyIKLEehXwEYUVq2wGr/edkRUv2vZ+OhjnkDOzONDFey6nf6/z+RtjeL3irxiH6N7/CY3fcnD
	HFSI7nMBmiVCVgEXNz26NXwUMR2/knlYHNqPf2/bTY4od1KduCFIf26NxL4AefAXVNNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5swO-00Bcqh-Q0; Tue, 29 Oct 2024 21:35:48 +0100
Date: Tue, 29 Oct 2024 21:35:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH net-next v2 2/5] dt-bindings: net: dsa: ksz: add
 mdio-parent-bus property for internal MDIO
Message-ID: <2b03f429-9ae2-4c7a-9cec-0bc2f3c6e816@lunn.ch>
References: <20241029110732.1977064-1-o.rempel@pengutronix.de>
 <20241029110732.1977064-3-o.rempel@pengutronix.de>
 <20241029123107.ssvggsn2b5w3ehoy@skbuf>
 <ZyDe_ObZ-laVk8c2@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyDe_ObZ-laVk8c2@pengutronix.de>

> > I'm not saying whether this is good or bad, I'm just worried about
> > mixing quantities having different measurement units into the same
> > address space.
> > 
> > Just like in the case of an mdio-mux, there is no address space isolation
> > between the parent bus and the child bus. AKA you can't have this,
> > because there would be clashes:
> > 
> > 	host_bus: mdio@abcd {
> > 		ethernet-phy@2 {
> > 			reg = <2>;
> > 		};
> > 	};
> > 
> > 	child_bus: mdio@efgh {
> > 		mdio-parent-bus = <&host_bus>;
> > 
> > 		ethernet-phy@2 {
> > 			reg = <2>;
> > 		};
> > 	};
> > 
> > But there is a big difference. With an mdio-mux, you could statically
> > detect address space clashes by inspecting the PHY addresses on the 2
> > buses. But with the lan937x child MDIO bus, in this design, you can't,
> > because the "reg" values don't represent MDIO addresses, but switch port
> > numbers (this is kind of important, but I don't see it mentioned in the
> > dt-binding).
> 
> In current state, the driver still require properly configured addresses
> in the devicetree. So, it will be visible in the DT.

This is not what i was expecting, especially from mv88e6xxx
perspective. The older generation of devices had the PHYs available on
the 'host bus', as well as the 'child bus', using a 1:1 address
mapping. You could in theory even skip the 'child bus' and list the
PHYs on the 'host bus' and phy-handle would make it work. However i
see from a later comment that does not work here, you need some
configuration done over SPI, which mv88e6xx does not need. 

> 
> > These are translated by lan937x_create_phy_addr_map() using
> > the CASCADE_ID/VPHY_ADD pin strapping information read over SPI.
> > I.e. with the same device tree, you may or may not have address space
> > clashes depending on pin strapping. No way to tell.
> 
> The PHY address to port mapping in the driver is needed to make the
> internal switch interrupt controller assign interrupts to proper PHYs.

You are talking about:

			ds->user_mii_bus->irq[phy] = irq;

in ksz_irq_phy_setup.

I naively expect 'phy' to be the 'reg' value in DT, and the 'dev'
value which passed to mdiobus_read_nested(bus, dev, reg) ?

	Andrew

