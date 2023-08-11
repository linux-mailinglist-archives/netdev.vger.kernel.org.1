Return-Path: <netdev+bounces-26826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB337779206
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32349281BE3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE47499;
	Fri, 11 Aug 2023 14:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11876FDA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:39:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC81A2728
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=u0elVA+yHsWRBFvnYLi8GrehuhXpLeDvIBoM4eNKZco=; b=Nn
	QJnezIvYNO13gjnj/NOXl9KtTYW4YBbUTFNLQ+mFBwvp8Xts95DEdEKlb1JFWEmXnGamRKTdGewS7
	gIh8Oj/xuoNn+vQ7KCOMbRNxBFDiFG7LQ0jhUmDFzD3y1S5zB5dCRX0QiwMeZ0zHRHJPzt0Zzr3jJ
	GoVjmBKwWPeEE7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qUTHm-003oUo-1C; Fri, 11 Aug 2023 16:38:42 +0200
Date: Fri, 11 Aug 2023 16:38:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Andre Edich <andre.edich@microchip.com>,
	Antoine Tenart <atenart@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Divya Koppera <Divya.Koppera@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mathias Kresin <dev@kresin.me>, Maxim Kochetkov <fido_max@inbox.ru>,
	Michael Walle <michael@walle.cc>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Willy Liu <willy.liu@realtek.com>,
	Yuiko Oshino <yuiko.oshino@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix IRQ-based wake-on-lan over hibernate /
 power off
Message-ID: <e4c4a448-2f3f-4693-bc5e-1d39ad76d233@lunn.ch>
References: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 11:26:30AM +0100, Russell King (Oracle) wrote:
> Uwe reports:
> "Most PHYs signal WoL using an interrupt. So disabling interrupts [at
> shutdown] breaks WoL at least on PHYs covered by the marvell driver."
> 
> Discussing with Ioana, the problem which was trying to be solved was:
> "The board in question is a LS1021ATSN which has two AR8031 PHYs that
> share an interrupt line. In case only one of the PHYs is probed and
> there are pending interrupts on the PHY#2 an IRQ storm will happen
> since there is no entity to clear the interrupt from PHY#2's registers.
> PHY#1's driver will get stuck in .handle_interrupt() indefinitely."
> 
> Further confirmation that "the two AR8031 PHYs are on the same MDIO
> bus."
> 
> With WoL using interrupts to wake the system, in such a case, the
> system will begin booting with an asserted interrupt. Thus, we need to
> cope with an interrupt asserted during boot.
> 
> Solve this instead by disabling interrupts during PHY probe. This will
> ensure in Ioana's situation that both PHYs of the same type sharing an
> interrupt line on a common MDIO bus will have their interrupt outputs
> disabled when the driver probes the device, but before we hook in any
> interrupt handlers - thus avoiding the interrupt storm.
> 
> A better fix would be for platform firmware to disable the interrupting
> devices at source during boot, before control is handed to the kernel.
> 
> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> Link: 20230804071757.383971-1-u.kleine-koenig@pengutronix.de
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

