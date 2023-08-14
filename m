Return-Path: <netdev+bounces-27527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F2477C3FB
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 01:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA1B2812A5
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C7A95E;
	Mon, 14 Aug 2023 23:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862EA925
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:33:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DDCE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h0KuYupQDWy9AIoQnB8r4MYUDNZdRTRRg+2c7DiEF6k=; b=1MxDvCb+o9wPMgQJlnoHzAJ3BM
	uWnp4E4vGI/cJ+2CPhzJVEhXlvnUagcbHvSuBcGs2T6ctgBeetQA1oJsWsHw2vm6M0qVJj4WfOMpu
	vj7Udd28WtUZ+zo+pfUXJXqdTvrZsQGNz18SzQIQorXI3nXmr7P8tOcCbH+or/keIRss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVh3w-0046Lk-8F; Tue, 15 Aug 2023 01:33:28 +0200
Date: Tue, 15 Aug 2023 01:33:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <d6149814-f772-418c-8fee-729d8665a8f2@lunn.ch>
References: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This will be using the interface mode set in the switch port's
> configuration, rather than the interface mode that is in the CPU
> MAC node to which it is connected. This is different.
> 
> Essentially, when an ethernet driver connects to a PHY:
> 
>    MAC <---------------------------------> PHY
>     v					    v
> dt-mac-node {				dt-phy-node {
>   phy-mode = "rgmii-foo";		  /* contains no phy-mode */
> };					};
> 
> parses phy mode
> configures for RGMII mode
> ignores RGMII delays associated
>  with phy-mode
> applies any delays configured
>  by rx-internal-delay-ps and
>  tx-internal-delay-ps properties
> calls phy_attach(..., mode);
> phylib sets phy_dev->interface
> 					PHY driver uses phy_dev->interface
> 					 to configure RGMII delays
> 
> So, in this case, the dt-mac-node phy-mode property determines the
> delays at the PHY.

Mostly. There is at least one MAC driver which looks at phy-mode,
enables delays in the MAC based on the phy-mode. It then masks
phy-mode to remove the delays it has added, and passes phy_attach()
the masked value. This was i think done historically because there was
a board with a PHY which could not add the delays and the MAC
could. And that driver has got extended to other versions of the MAC
and has kept to this way of doing it.

I always push back against any new instances of this, and i don't
think any more have been added while i've been watching for it.

> The host MAC phy-mode property still has zero effect what so ever on
> the RGMII delay settings at the host MAC end of the link - and can be
> *any* of the four RGMII interface types. It really doesn't matter.

Except for the one case i outlined above.

> So, to summarise...
> 
> A host MAC connected to a phylib PHY, the host MAC's phy-mode property
> defines the RGMII delays at device on other end of the RGMII bus - which
> is the phylib PHY.

Except for the one case i outlined above. Unfortunately.

> A host MAC connected to a DSA switch, the host MAC's phy-mode property
> is irrelevant as far as RGMII delays are concerned, they have no
> effect on the device on the end of the RGMII bus.

I'm don't know if said MAC is every connected to a DSA switch....

> The big problem with RGMII delays has been this in the documentation:
> 
> "The PHY library offers different types of PHY_INTERFACE_MODE_RGMII*
> values to let the PHY driver and optionally the MAC driver, implement
> the required delay. The values of phy_interface_t must be understood
> from the perspective of the PHY device itself, leading to the
> following:"

I suspect this documentation was written to take into the account the
one oddball MAC.

> Note "and optionally the MAC driver". Well, no, there is nothing
> optional about this if one wants consistency of implementation - and
> I'll explain why in a moment, but first lets see what is expected of
> the PHY itself for each of these RGMII modes:
> 
> "* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
>    internal delay by itself, it assumes that either the Ethernet MAC (if
>    capable) or the PCB traces insert the correct 1.5-2ns delay
> 
>  * PHY_INTERFACE_MODE_RGMII_TXID: the PHY should insert an internal delay
>    for the transmit data lines (TXD[3:0]) processed by the PHY device
> 
>  * PHY_INTERFACE_MODE_RGMII_RXID: the PHY should insert an internal delay
>    for the receive data lines (RXD[3:0]) processed by the PHY device

I guess 50% of PHYs get these two swapped around, simply because they
are never tested.

>  * PHY_INTERFACE_MODE_RGMII_ID: the PHY should insert internal delays for
>    both transmit AND receive data lines from/to the PHY device"
> 
> This is quite clear where the delay is inserted - by the *PHY* device.
> The above pre-dates my involvement in PHYLIB, and comes from a commit
> by Florian in November 2016, yet I seem to be often attributed with it.
> 
> Now, going back to that "optionally the MAC driver". Consider if we
> have, say, a PHY driver that is using host MAC M1 that has decided not
> to implement the delays (hey, they're optional!) Using
> PHY_INTERFACE_MODE_RGMII_TXID, to satisfy the above, the PHY is
> expected to insert the required delay for the transmit data lines.
> 
> Now lets say that the very same PHY driver uses host MAC M2, but that
> MAC driver has decided to implement these delays (hey, they're
> optional!) Using again PHY_INTERFACE_MODE_RGMII_TXID, the MAC driver
> decided to add delay to the transmit path. The PHY, however, also
> sees PHY_INTERFACE_MODE_RGMII_TXID and adds its own delay to the
> transmit data lines as it always has done. Now we have a double delay.

The one example of a MAC which does this also masks the value passed
to the PHY, so that PHY gets PHY_INTERFACE_MODE_RGMII. And it then all
works.

What we might want to do is document this masking. 

> So, that "and optionally the MAC driver" is what has historically led
> to problems with the various RGMII modes, with new implementations
> popping up and finding that host MAC M2 that's been in use for years
> with PHY device P1 (that hasn't implemented RGMII delays because the
> MAC driver did) now doesn't work with PHY device P2 (which does
> implement RGMII delays) that has also been in use for years.

I would actually say most problems have come about because the PHY has
not always implemented all four modes correctly. PHYs have silently
accepted one of the modes but not changed the hardware to actual do
what is requested, and kept with strapping defaults. Sometime later,
that mode has been correctly implemented, overwriting the strapping,
and breaking stuff. So it is on my checklist to ensure all four modes
set the hardware, or return -EOPNOTSUPP.

I would agree that reviewing and consistency has got better over time,
which is why we see less problems.

     Andrew

