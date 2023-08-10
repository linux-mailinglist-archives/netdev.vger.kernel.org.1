Return-Path: <netdev+bounces-26266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A87775E4
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027092820E0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8746BA;
	Thu, 10 Aug 2023 10:34:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D33D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:34:10 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784102130
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5kaI/CNj3IWBsWxacEmEPgNRGciYy8QTmVNTqNpB87o=; b=HODEMB3hcimIKPo02uaCKW8OdD
	qHp+7R1567ZmiEGzf6xCd9QnOB9GPoWDsJlTgui00Bql7xI5u8OhvXp9D8vfxwLggxnMAHec6abmC
	m3+sPyGBpzt2eNsKOpgS8b4Ed0qO1i/YtZbqZhd7Sehig48+YBkT49kZlKqiW9Hsss+8lSQrW4po0
	mLqlibDfVRC5ncePNzFzR3v0TW3gpJmEPtz2VDa4UAsOT/NOWsRjv8jqOVYX1siFv/GioJ9D1K16O
	dJh+INWg+HoET6UXCSNFOumZY8Qx7UX+Ts9E11GU6v19tg9IkOeKlQkzO6CIAoaIKZrl7ShKdpZPU
	rZnbkAkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47150)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU2zS-0003ou-1O;
	Thu, 10 Aug 2023 11:34:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU2zS-0001hK-B2; Thu, 10 Aug 2023 11:34:02 +0100
Date: Thu, 10 Aug 2023 11:34:02 +0100
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
Message-ID: <ZNS9GpMJEDi1zugk@shell.armlinux.org.uk>
References: <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNS1kalvEI6Y2Cs9@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:01:53AM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 10, 2023 at 02:49:55AM +0200, Marek Vasut wrote:
> > On 8/10/23 00:06, Andrew Lunn wrote:
> > > On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> > > > On 8/9/23 15:40, Andrew Lunn wrote:
> > > > > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > > > > PHY automatic hibernation as long as clock is acquired?
> > > > > > > 
> > > > > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > > > > will be more changes if we use clock provider/consume mechanism.
> > > > > 
> > > > > Less changes is not always best. What happens when a different PHY is
> > > > > used?
> > > > 
> > > > Then the system wouldn't be affected by this AR803x specific behavior.
> > > 
> > > Do you know it really is specific to the AR803x? Turning the clock off
> > > seams a reasonable thing to do when saving power, or when there is no
> > > link partner.
> > 
> > This hibernation behavior seem specific to this PHY, I haven't seen it on
> > another PHY connected to the EQoS so far.
> 
> Marvell PHYs can be programmed so that RXCLK stops when the PHY
> enters power down or energy-detect state, although it defaults to
> always keeping the RGMII interface powered (and thus providing a
> clock.)
> 
> One Micrel PHY - "To save more power, the KSZ9031RNX stops the RX_CLK
> clock output to the MAC after 10 or more RX_CLK clock
> cycles have occurred in the receive LPI state." which seems to imply
> if EEE is enabled, then the receive clock will be stopped when
> entering low-power state.
> 
> I've said this several times in this thread - I think we need a bit
> in the PHY device's dev_flags to allow the MAC to say "do not power
> down the receive clock" which is used by the PHY drivers to (a) program
> the hardware to prevent the receive clock being stopped in situations
> such as the AR803x hibernate mode, and (b) to program the hardware not
> to stop the receive clock when entering EEE low power. This does seem
> to be a generic thing and not specific to just one PHY - especially as
> the stopping of clocks when entering EEE low power is a IEEE 802.3
> defined thing.

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

