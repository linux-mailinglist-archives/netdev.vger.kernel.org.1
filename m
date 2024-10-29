Return-Path: <netdev+bounces-139930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1A9B4AA4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397FAB22265
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF21DF243;
	Tue, 29 Oct 2024 13:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE2BE49
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207511; cv=none; b=Bk+nGwTSmtLIBKLS3a8a6dITXMQIxb3s/AJzSJ3mDesLCiBSWtqqffgU2r6B2fNHVmfGcV+bpLtpgopl33ReltyMy+dOmgrPHJLVZV+Vx6uaVG/dgM6XwvbkBkd4y5pY8g78ILFTPU9Z4tBdmt8N5j+bRSknpLKoKgJHa/sZEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207511; c=relaxed/simple;
	bh=XzgorTedaw2znQGGv24V6WZlw0DFo07D2KZBoPXv/LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFSC3lLmW24jVegfHDtHM4SUJtzrptignQMB2lroTGN+ILsgY9YD2Ct5EfUj6fpsTfPSH9us7g1OCm8EorIvzzxNB3ZXK2yauXLORgM7X/uQVC5sj804nhmysAgHF4moHrIklwqQLtpiu4VLtuYQJldogSAwbFfRfXBd3ASmUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t5m0M-000489-C2; Tue, 29 Oct 2024 14:11:26 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5m0K-00120t-1M;
	Tue, 29 Oct 2024 14:11:24 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5m0K-002aPG-0y;
	Tue, 29 Oct 2024 14:11:24 +0100
Date: Tue, 29 Oct 2024 14:11:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <ZyDe_ObZ-laVk8c2@pengutronix.de>
References: <20241029110732.1977064-1-o.rempel@pengutronix.de>
 <20241029110732.1977064-3-o.rempel@pengutronix.de>
 <20241029123107.ssvggsn2b5w3ehoy@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029123107.ssvggsn2b5w3ehoy@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Oct 29, 2024 at 02:31:07PM +0200, Vladimir Oltean wrote:
> On Tue, Oct 29, 2024 at 12:07:29PM +0100, Oleksij Rempel wrote:
> > Introduce `mdio-parent-bus` property in the ksz DSA bindings to
> > reference the parent MDIO bus when the internal MDIO bus is attached to
> > it, bypassing the main management interface.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml       | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > index a4e463819d4d7..121a4bbd147be 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > @@ -84,6 +84,15 @@ properties:
> >    mdio:
> >      $ref: /schemas/net/mdio.yaml#
> >      unevaluatedProperties: false
> > +    properties:
> > +      mdio-parent-bus:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description:
> > +          Phandle pointing to the MDIO bus controller connected to the
> > +          secondary MDIO interface. This property should be used when
> > +          the internal MDIO bus is accessed via a secondary MDIO
> > +          interface rather than the primary management interface.
> > +
> >      patternProperties:
> >        "^ethernet-phy@[0-9a-f]$":
> >          type: object
> > -- 
> > 2.39.5
> > 
> 
> I'm not saying whether this is good or bad, I'm just worried about
> mixing quantities having different measurement units into the same
> address space.
> 
> Just like in the case of an mdio-mux, there is no address space isolation
> between the parent bus and the child bus. AKA you can't have this,
> because there would be clashes:
> 
> 	host_bus: mdio@abcd {
> 		ethernet-phy@2 {
> 			reg = <2>;
> 		};
> 	};
> 
> 	child_bus: mdio@efgh {
> 		mdio-parent-bus = <&host_bus>;
> 
> 		ethernet-phy@2 {
> 			reg = <2>;
> 		};
> 	};
> 
> But there is a big difference. With an mdio-mux, you could statically
> detect address space clashes by inspecting the PHY addresses on the 2
> buses. But with the lan937x child MDIO bus, in this design, you can't,
> because the "reg" values don't represent MDIO addresses, but switch port
> numbers (this is kind of important, but I don't see it mentioned in the
> dt-binding).

In current state, the driver still require properly configured addresses
in the devicetree. So, it will be visible in the DT.

> These are translated by lan937x_create_phy_addr_map() using
> the CASCADE_ID/VPHY_ADD pin strapping information read over SPI.
> I.e. with the same device tree, you may or may not have address space
> clashes depending on pin strapping. No way to tell.

The PHY address to port mapping in the driver is needed to make the
internal switch interrupt controller assign interrupts to proper PHYs.

It would be possible to assign interrupts per devicetree, but the driver
was previously implemented to not need it, so i decided to follow this
design pattern.

The driver can be extended to validate DT addresses, but I was not sure
that my current decisions are the way to go.

> Have you considered putting the switch's internal PHYs directly under
> the host MDIO bus node, with their 'real' MDIO bus computed statically
> by the DT writer based on the pin straps? Yes, I'm aware that this means
> different pin straps mean different device trees.

Yes, i tried this. In this case, the host MDIO registration procedure
will fail to find the PHYs, because they are not accessible before
switch driver initialization. I had in mind some different variants to
handle it, like:
- use compatible property in the PHY nodes in the host MDIO node.
- trigger MDIO re-scan from the switch
- mimic the MDIO mux. 

The last variant seems to be more or less better fit for this use case.

> Under certain circumstances I could understand this dt-binding design
> with an mdio-parent-bus, like for example if the MDIO addresses at which
> the internal PHYs respond would be configurable over SPI, from the switch
> registers. But I'm not led to believe that here, this is the case.

ack.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

