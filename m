Return-Path: <netdev+bounces-26267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDAC7775E6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EE61C21577
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DB1BB32;
	Thu, 10 Aug 2023 10:34:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9A46BA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:34:52 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A21702
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eQ3yOEuYcarpMtx1f4Lyq+Ons/1Yk5XPK3S+XnZfTJU=; b=GU96q2NS4uquQ2w0ReQ1+rd8gJ
	qBt6cNVPZmVbmpy1vLL4wD2D2cbHYBLar4xP8u8BnE79hmY/LEcCCkOZ8gRBoTrZUOh6yGNrevlby
	Pd9Asa8cSiSeqkh41YIBKUO+kgWxVhPN6+L4NnM5erVAC6BBq+qsSpF4HQ4jK/jguP4MVkYu72UzU
	0a28tQ/Du6DWTXg54Lw1iAVVd0LmEzBfWuFYeDI2kCvdwf+RzQ0U8y6eiYcDptfdp2umd67EeR4Z+
	1xbQFiK3GOz5nOeV7YWqElt4AnfShfdposh37xsrkjTgeOQy1eCs/Eh4Qc2qREnWpbaJaGeY5sFJA
	r8V7mKSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU30B-0003p9-18;
	Thu, 10 Aug 2023 11:34:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU30B-0001hS-Cq; Thu, 10 Aug 2023 11:34:47 +0100
Date: Thu, 10 Aug 2023 11:34:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marex@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNS9RwMnE7ZsGsCk@shell.armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <ZNQeAl9KYme8iItv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNQeAl9KYme8iItv@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 12:15:14AM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> > On 8/9/23 15:40, Andrew Lunn wrote:
> > > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > > PHY automatic hibernation as long as clock is acquired?
> > > > > 
> > > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > > will be more changes if we use clock provider/consume mechanism.
> > > 
> > > Less changes is not always best. What happens when a different PHY is
> > > used?
> > 
> > Then the system wouldn't be affected by this AR803x specific behavior.
> 
> I don't think it is AR803x specific behaviour. I think it is an
> interesting stmmac behaviour, where it requires the clock from
> the PHY in order to do even the most trivial things (like reset
> itself.) That is a very interesting design decision.
> 
> how does stmmac hardware complete a power-on reset if it needs
> the external clock from a PHY that itself might be in the process
> of powering itself up and establishing its clocks...
> 
> There have been *hacks* to phylink requested over the years to
> work around this peculiar behaviour by stmmac - and it seems that
> it's not common behaviour.
> 
> This kind of thing might affect Cadence's macb driver as well, but
> rather than it being a clock from the ethernet PHY, it seems to be
> from the serdes PHY built in to the SoC - if I understand what's
> reported in the proposed patch commit log (which I don't fully.)
> 
> In the case of stmmac, I don't think it's fair to blame the AR803x.
> It's a hardware integration issue - the AR803x implementation which
> works fine elsewhere has a problem with the stmmac implementation,
> because design decisions made in both implementations end up being
> incompatible with each other.
> 
> However, pair them with different implementations, and they're fine.
> 
> Given that stmmac requires a clock from the PHY, I'm of the opinion
> that we need to have a way to tell phylib that "hey, this MAC must
> always have a receive clock from the PHY, please arrange for that
> to happen". AR803x needs to check that and arrange for the receive
> clock to always be output. phylib can also use that to ensure that
> when EEE mode is active in the PHY, clock-stop support is disabled...
> and that's actually a key part to getting EEE properly implemented.
> 
> Clearly, the IEEE 802.3 folk catered for this issue when specifying
> EEE, where some MACs must always be fed a receive clock, and so I
> think phylib in Linux needs to recognise that this is A Thing that
> it should allow MACs to specify.

Like this:

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fcab363d8dfa..a954f1d61709 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1254,6 +1254,11 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 			~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	priv->phylink_config.mac_managed_pm = true;
 
+	/* stmmac always requires a receive clock in order for things like
+	 * hardware reset to work.
+	 */
+	priv->phylink_config.mac_requires_rxc = true;
+
 	phylink = phylink_create(&priv->phylink_config, fwnode,
 				 mode, &stmmac_phylink_mac_ops);
 	if (IS_ERR(phylink))
diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 13c4121fa309..619a63a0d14f 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -990,7 +990,8 @@ static int at803x_hibernation_mode_config(struct phy_device *phydev)
 	/* The default after hardware reset is hibernation mode enabled. After
 	 * software reset, the value is retained.
 	 */
-	if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE))
+	if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE) &&
+	    !(phydev->dev_flags & PHY_F_RXC_ALWAYS_ON))
 		return 0;
 
 	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3e9909b30938..4d1a37487923 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
 			goto out;
 	}
 
+        phy_disable_interrupts(phydev);
+
 	/* Start out supporting everything. Eventually,
 	 * a controller will attach, and may modify one
 	 * or both of these values
@@ -3333,16 +3335,6 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
-static void phy_shutdown(struct device *dev)
-{
-	struct phy_device *phydev = to_phy_device(dev);
-
-	if (phydev->state == PHY_READY || !phydev->attached_dev)
-		return;
-
-	phy_disable_interrupts(phydev);
-}
-
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3376,7 +3368,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4f1c8bb199e9..6568a2759101 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1830,6 +1830,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 			      phy_interface_t interface)
 {
+	u32 flags = 0;
+
 	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
 		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
 		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
@@ -1838,7 +1840,10 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 	if (pl->phydev)
 		return -EBUSY;
 
-	return phy_attach_direct(pl->netdev, phy, 0, interface);
+	if (pl->config.mac_requires_rxc)
+		flags |= PHY_F_RXC_ALWAYS_ON;
+
+	return phy_attach_direct(pl->netdev, phy, flags, interface);
 }
 
 /**
@@ -1941,6 +1946,9 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 		pl->link_config.interface = pl->link_interface;
 	}
 
+	if (pl->config.mac_requires_rxc)
+		flags |= PHY_F_RXC_ALWAYS_ON;
+
 	ret = phy_attach_direct(pl->netdev, phy_dev, flags,
 				pl->link_interface);
 	phy_device_free(phy_dev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ba08b0e60279..79df5e01707d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -761,6 +761,7 @@ struct phy_device {
 
 /* Generic phy_device::dev_flags */
 #define PHY_F_NO_IRQ		0x80000000
+#define PHY_F_RXC_ALWAYS_ON	BIT(30)
 
 static inline struct phy_device *to_phy_device(const struct device *dev)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 789c516c6b4a..a83c1a77338f 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -204,6 +204,7 @@ enum phylink_op_type {
  * @poll_fixed_state: if true, starts link_poll,
  *		      if MAC link is at %MLO_AN_FIXED mode.
  * @mac_managed_pm: if true, indicate the MAC driver is responsible for PHY PM.
+ * @mac_requires_rxc: if true, the MAC always requires a receive clock from PHY.
  * @ovr_an_inband: if true, override PCS to MLO_AN_INBAND
  * @get_fixed_state: callback to execute to determine the fixed link state,
  *		     if MAC link is at %MLO_AN_FIXED mode.
@@ -216,6 +217,7 @@ struct phylink_config {
 	enum phylink_op_type type;
 	bool poll_fixed_state;
 	bool mac_managed_pm;
+	bool mac_requires_rxc;
 	bool ovr_an_inband;
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

