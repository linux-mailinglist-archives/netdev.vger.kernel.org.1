Return-Path: <netdev+bounces-26358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E635777976
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A511B280298
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6251E1D7;
	Thu, 10 Aug 2023 13:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524951E1A9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:58 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DCC10E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ox4LCOYp5d4aE7pl8Fs+ZghUp+ZrbbWXTbaXnH17VI0=; b=JQLxpV4Bu5ebE3JajWu+7mr6o/
	wbHN0ybqte9MSf+mdDJ7VXQNWx9bZQs8BjdsW/nKdrM4onvVL3RDDwcLfQ+dqsZXvbrzya9Doz3Dc
	pGnPkjt5Ngo2vRKBKbFMaQft/inim+8XSUL3iiNlFtjVUUGg4veC8qhrID+diDqkiD9bfhfPa/Yz8
	iGUbeEfh1dn2GqVFevR6uhe+pus6IvLg2c2uLvpYn5exDKhxm5oFez4D3IMcezPHytHaEG0EE1eU8
	thf/sYZZvV4NL37Rj4sC8mc1rjfMcFAq73ewjqd2a2tgOEAHKi0M9D1h7komq4ROJ1u+jo/u9JDKE
	vYq0UC7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU5X1-00041V-30;
	Thu, 10 Aug 2023 14:16:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU5X0-0001pJ-8p; Thu, 10 Aug 2023 14:16:50 +0100
Date: Thu, 10 Aug 2023 14:16:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <ZNTjQnufpCPMEEwd@shell.armlinux.org.uk>
References: <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
 <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
 <20230810125117.GD13300@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810125117.GD13300@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 02:51:17PM +0200, Oleksij Rempel wrote:
> On Thu, Aug 10, 2023 at 11:34:02AM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 10, 2023 at 11:01:53AM +0100, Russell King (Oracle) wrote:
> > > On Thu, Aug 10, 2023 at 02:49:55AM +0200, Marek Vasut wrote:
> > > > On 8/10/23 00:06, Andrew Lunn wrote:
> > > > > On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> > > > > > On 8/9/23 15:40, Andrew Lunn wrote:
> > > > > > > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > > > > > > PHY automatic hibernation as long as clock is acquired?
> > > > > > > > > 
> > > > > > > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > > > > > > will be more changes if we use clock provider/consume mechanism.
> > > > > > > 
> > > > > > > Less changes is not always best. What happens when a different PHY is
> > > > > > > used?
> > > > > > 
> > > > > > Then the system wouldn't be affected by this AR803x specific behavior.
> > > > > 
> > > > > Do you know it really is specific to the AR803x? Turning the clock off
> > > > > seams a reasonable thing to do when saving power, or when there is no
> > > > > link partner.
> > > > 
> > > > This hibernation behavior seem specific to this PHY, I haven't seen it on
> > > > another PHY connected to the EQoS so far.
> > > 
> > > Marvell PHYs can be programmed so that RXCLK stops when the PHY
> > > enters power down or energy-detect state, although it defaults to
> > > always keeping the RGMII interface powered (and thus providing a
> > > clock.)
> > > 
> > > One Micrel PHY - "To save more power, the KSZ9031RNX stops the RX_CLK
> > > clock output to the MAC after 10 or more RX_CLK clock
> > > cycles have occurred in the receive LPI state." which seems to imply
> > > if EEE is enabled, then the receive clock will be stopped when
> > > entering low-power state.
> > > 
> > > I've said this several times in this thread - I think we need a bit
> > > in the PHY device's dev_flags to allow the MAC to say "do not power
> > > down the receive clock" which is used by the PHY drivers to (a) program
> > > the hardware to prevent the receive clock being stopped in situations
> > > such as the AR803x hibernate mode, and (b) to program the hardware not
> > > to stop the receive clock when entering EEE low power. This does seem
> > > to be a generic thing and not specific to just one PHY - especially as
> > > the stopping of clocks when entering EEE low power is a IEEE 802.3
> > > defined thing.
> > 
> > Like this:
> ... 
> >  
> > +        phy_disable_interrupts(phydev);
> > +
> >  	/* Start out supporting everything. Eventually,
> >  	 * a controller will attach, and may modify one
> >  	 * or both of these values
> > @@ -3333,16 +3335,6 @@ static int phy_remove(struct device *dev)
> >  	return 0;
> >  }
> >  
> > -static void phy_shutdown(struct device *dev)
> > -{
> > -	struct phy_device *phydev = to_phy_device(dev);
> > -
> > -	if (phydev->state == PHY_READY || !phydev->attached_dev)
> > -		return;
> > -
> > -	phy_disable_interrupts(phydev);
> > -}
> > -
> 
> Except of shutdown part from other discussion, looks fine for me.

Sigh... clearly I can't cope with email, especially when most of the
subject line is hidden! All I see in the index is "Re: [PATCH] net: phy:
at803x: Improve hi" for this thread, and I can't remember what the
other thread was... and it's buried in email.

> What will be the best way to solve this issue for DSA switches attached to
> MAC with RGMII RXC requirements?

I have no idea - the problem there is the model that has been adopted
in Linux is that there is no direct relationship between the DSA switch
and the MAC like there is with a PHY.

The MAC sees only a fixed-link, as does the DSA switch. So from the
software perspective, it's:

MAC ---- fixed-link

Switch ---- fixed-link

And it just so happens that packets pass between the two by "magic".
With a PHY, there is a direct relationship:

MAC ---- PHY

The MAC has a direct relationship with the PHY to the extent that the
MAC driver is involved in managing the PHY through phylink/phylib.

The effect of that de-coupling is that the MAC driver becomes quite
independent of the switch driver - I don't believe the switch driver
can query the MAC driver at probe time, nor the other way. If I'm
mistaken about that, someone needs to say!

What that leaves us with is firmware telling the switch driver...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

