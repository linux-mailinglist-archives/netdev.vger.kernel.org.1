Return-Path: <netdev+bounces-26335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100257778D1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4170B1C21548
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075201E1B4;
	Thu, 10 Aug 2023 12:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCE1E1A8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:51:24 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EECC2691
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 05:51:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qU58J-0000IF-91; Thu, 10 Aug 2023 14:51:19 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qU58H-0005MW-5P; Thu, 10 Aug 2023 14:51:17 +0200
Date: Thu, 10 Aug 2023 14:51:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek Vasut <marex@denx.de>, Andrew Lunn <andrew@lunn.ch>,
	Wei Fang <wei.fang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <20230810125117.GD13300@pengutronix.de>
References: <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
 <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:34:02AM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 10, 2023 at 11:01:53AM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 10, 2023 at 02:49:55AM +0200, Marek Vasut wrote:
> > > On 8/10/23 00:06, Andrew Lunn wrote:
> > > > On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> > > > > On 8/9/23 15:40, Andrew Lunn wrote:
> > > > > > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > > > > > PHY automatic hibernation as long as clock is acquired?
> > > > > > > > 
> > > > > > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > > > > > will be more changes if we use clock provider/consume mechanism.
> > > > > > 
> > > > > > Less changes is not always best. What happens when a different PHY is
> > > > > > used?
> > > > > 
> > > > > Then the system wouldn't be affected by this AR803x specific behavior.
> > > > 
> > > > Do you know it really is specific to the AR803x? Turning the clock off
> > > > seams a reasonable thing to do when saving power, or when there is no
> > > > link partner.
> > > 
> > > This hibernation behavior seem specific to this PHY, I haven't seen it on
> > > another PHY connected to the EQoS so far.
> > 
> > Marvell PHYs can be programmed so that RXCLK stops when the PHY
> > enters power down or energy-detect state, although it defaults to
> > always keeping the RGMII interface powered (and thus providing a
> > clock.)
> > 
> > One Micrel PHY - "To save more power, the KSZ9031RNX stops the RX_CLK
> > clock output to the MAC after 10 or more RX_CLK clock
> > cycles have occurred in the receive LPI state." which seems to imply
> > if EEE is enabled, then the receive clock will be stopped when
> > entering low-power state.
> > 
> > I've said this several times in this thread - I think we need a bit
> > in the PHY device's dev_flags to allow the MAC to say "do not power
> > down the receive clock" which is used by the PHY drivers to (a) program
> > the hardware to prevent the receive clock being stopped in situations
> > such as the AR803x hibernate mode, and (b) to program the hardware not
> > to stop the receive clock when entering EEE low power. This does seem
> > to be a generic thing and not specific to just one PHY - especially as
> > the stopping of clocks when entering EEE low power is a IEEE 802.3
> > defined thing.
> 
> Like this:
... 
>  
> +        phy_disable_interrupts(phydev);
> +
>  	/* Start out supporting everything. Eventually,
>  	 * a controller will attach, and may modify one
>  	 * or both of these values
> @@ -3333,16 +3335,6 @@ static int phy_remove(struct device *dev)
>  	return 0;
>  }
>  
> -static void phy_shutdown(struct device *dev)
> -{
> -	struct phy_device *phydev = to_phy_device(dev);
> -
> -	if (phydev->state == PHY_READY || !phydev->attached_dev)
> -		return;
> -
> -	phy_disable_interrupts(phydev);
> -}
> -

Except of shutdown part from other discussion, looks fine for me.

What will be the best way to solve this issue for DSA switches attached to
MAC with RGMII RXC requirements?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

