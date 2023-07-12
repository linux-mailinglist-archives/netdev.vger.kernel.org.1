Return-Path: <netdev+bounces-17183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9EC750BDC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE031C211CF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467234CFB;
	Wed, 12 Jul 2023 15:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37734CF1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB97EC433CD;
	Wed, 12 Jul 2023 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689174461;
	bh=ACFNn7UNFr1+7nPIs/Klakd8MmbE6J0tasThf9jtVjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XX+TS6yvRMhFaKu16x0YVzksgpdcHrYmJbrR+DpywiJxsUSbv6DPRG0Yt0DBo128c
	 v0NWb1TKLGW4CA3CaSUOPniYAsxaWI3XPOTPyBt+p0zn4YT71JQuRr7nBVh2feIIca
	 ea3D6mCm4HELOQltn+6Iu0rUUk8azOCRzOlJtx//FIer47y95CulrcSVitNFzfhKPd
	 3eBSqorSvwXFhhicwYmFySsEvDxTAGv9G45B9ZTP5Ny6mtN545anE3Vm6FjxxCVrGX
	 BaQhoplvzPUCluXmyXEmxR/T15RWnpEixe70Hp+9VCW+HeJR3IfvARXvgLxybo7kYr
	 5Sg2e8d6OneSw==
From: Michael Walle <mwalle@kernel.org>
Date: Wed, 12 Jul 2023 17:07:03 +0200
Subject: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Xu Liang <lxu@maxlinear.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <simon.horman@corigine.com>, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2

Instead of tracing whether the PHY is a C45 one, use the method how the
PHY is accessed. For now, that is either by C22 or by C45 transactions.
There is no functional change, just a semantical difference.

This is a preparation patch to add a third access method C45-over-C22.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - use 22 and 45 as constants for the enum to catch errors
 - move enum in struct next to enum phy_state
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |  8 +++----
 drivers/net/mdio/fwnode_mdio.c                    |  6 +++--
 drivers/net/phy/mdio_bus.c                        |  9 +++----
 drivers/net/phy/nxp-tja11xx.c                     |  3 ++-
 drivers/net/phy/phy_device.c                      | 29 ++++++++++++++---------
 drivers/net/phy/sfp.c                             | 12 ++++++----
 include/linux/phy.h                               | 27 +++++++++++++++------
 7 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 928d934cb21a..74cd6197735b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -687,9 +687,9 @@ static int
 hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
 			u32 addr)
 {
+	enum phy_access_mode mode;
 	struct phy_device *phy;
 	const char *phy_type;
-	bool is_c45;
 	int rc;
 
 	rc = fwnode_property_read_string(mac_cb->fw_port,
@@ -698,13 +698,13 @@ hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
 		return rc;
 
 	if (!strcmp(phy_type, phy_modes(PHY_INTERFACE_MODE_XGMII)))
-		is_c45 = true;
+		mode = PHY_ACCESS_C45;
 	else if (!strcmp(phy_type, phy_modes(PHY_INTERFACE_MODE_SGMII)))
-		is_c45 = false;
+		mode = PHY_ACCESS_C22;
 	else
 		return -ENODATA;
 
-	phy = get_phy_device(mdio, addr, is_c45);
+	phy = get_phy_device(mdio, addr, mode);
 	if (!phy || IS_ERR(phy))
 		return -EIO;
 
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1183ef5e203e..972c8932c2fe 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr, is_c45);
+		phy = get_phy_device(bus, addr,
+				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
 	else
-		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
+		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
+					NULL);
 	if (IS_ERR(phy)) {
 		rc = PTR_ERR(phy);
 		goto clean_mii_ts;
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 8b3618d3da4a..a31eb1204f63 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -513,12 +513,13 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	return ret;
 }
 
-static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
+static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr,
+				       enum phy_access_mode mode)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
 	int err;
 
-	phydev = get_phy_device(bus, addr, c45);
+	phydev = get_phy_device(bus, addr, mode);
 	if (IS_ERR(phydev))
 		return phydev;
 
@@ -550,7 +551,7 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
  */
 struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, false);
+	return mdiobus_scan(bus, addr, PHY_ACCESS_C22);
 }
 EXPORT_SYMBOL(mdiobus_scan_c22);
 
@@ -568,7 +569,7 @@ EXPORT_SYMBOL(mdiobus_scan_c22);
  */
 static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, true);
+	return mdiobus_scan(bus, addr, PHY_ACCESS_C45);
 }
 
 static int mdiobus_scan_bus_c22(struct mii_bus *bus)
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b13e15310feb..1c6c1523540e 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -580,7 +580,8 @@ static void tja1102_p1_register(struct work_struct *work)
 		}
 
 		/* Real PHY ID of Port 1 is 0 */
-		phy = phy_device_create(bus, addr, PHY_ID_TJA1102, false, NULL);
+		phy = phy_device_create(bus, addr, PHY_ID_TJA1102,
+					PHY_ACCESS_C22, NULL);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "Can't create PHY device for Port 1: %i\n",
 				addr);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 44968ea447fc..6254212d65a5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -630,7 +630,7 @@ static int phy_request_driver_module(struct phy_device *dev, u32 phy_id)
 }
 
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
-				     bool is_c45,
+				     enum phy_access_mode mode,
 				     struct phy_c45_device_ids *c45_ids)
 {
 	struct phy_device *dev;
@@ -664,7 +664,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->autoneg = AUTONEG_ENABLE;
 
 	dev->pma_extable = -ENODATA;
-	dev->is_c45 = is_c45;
+	dev->access_mode = mode;
 	dev->phy_id = phy_id;
 	if (c45_ids)
 		dev->c45_ids = *c45_ids;
@@ -926,7 +926,7 @@ EXPORT_SYMBOL(fwnode_get_phy_id);
  *		    struct
  * @bus: the target MII bus
  * @addr: PHY address on the MII bus
- * @is_c45: If true the PHY uses the 802.3 clause 45 protocol
+ * @mode: Access mode of the PHY
  *
  * Probe for a PHY at @addr on @bus.
  *
@@ -940,7 +940,8 @@ EXPORT_SYMBOL(fwnode_get_phy_id);
  * Returns an allocated &struct phy_device on success, %-ENODEV if there is
  * no PHY present, or %-EIO on bus access error.
  */
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode)
 {
 	struct phy_c45_device_ids c45_ids;
 	u32 phy_id = 0;
@@ -950,10 +951,16 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	c45_ids.mmds_present = 0;
 	memset(c45_ids.device_ids, 0xff, sizeof(c45_ids.device_ids));
 
-	if (is_c45)
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
-	else
+	switch (mode) {
+	case PHY_ACCESS_C22:
 		r = get_phy_c22_id(bus, addr, &phy_id);
+		break;
+	case PHY_ACCESS_C45:
+		r = get_phy_c45_ids(bus, addr, &c45_ids);
+		break;
+	default:
+		return ERR_PTR(-EIO);
+	}
 
 	if (r)
 		return ERR_PTR(r);
@@ -963,15 +970,15 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	 * probe with C45 to see if we're able to get a valid PHY ID in the C45
 	 * space, if successful, create the C45 PHY device.
 	 */
-	if (!is_c45 && phy_id == 0 && bus->read_c45) {
+	if (mode == PHY_ACCESS_C22 && phy_id == 0 && bus->read_c45) {
 		r = get_phy_c45_ids(bus, addr, &c45_ids);
 		if (!r)
 			return phy_device_create(bus, addr, phy_id,
-						 true, &c45_ids);
+						 PHY_ACCESS_C45, &c45_ids);
 	}
 
-	return phy_device_create(bus, addr, phy_id, is_c45,
-				 !is_c45 ? NULL : &c45_ids);
+	return phy_device_create(bus, addr, phy_id, mode,
+				 mode == PHY_ACCESS_C22 ? NULL : &c45_ids);
 }
 EXPORT_SYMBOL(get_phy_device);
 
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d855a18308d7..e7f8decaf3ff 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1750,12 +1750,13 @@ static void sfp_sm_phy_detach(struct sfp *sfp)
 	sfp->mod_phy = NULL;
 }
 
-static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
+static int sfp_sm_probe_phy(struct sfp *sfp, int addr,
+			    enum phy_access_mode mode)
 {
 	struct phy_device *phy;
 	int err;
 
-	phy = get_phy_device(sfp->i2c_mii, addr, is_c45);
+	phy = get_phy_device(sfp->i2c_mii, addr, mode);
 	if (phy == ERR_PTR(-ENODEV))
 		return PTR_ERR(phy);
 	if (IS_ERR(phy)) {
@@ -1879,15 +1880,16 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
 		break;
 
 	case MDIO_I2C_MARVELL_C22:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, false);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, PHY_ACCESS_C22);
 		break;
 
 	case MDIO_I2C_C45:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, true);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, PHY_ACCESS_C45);
 		break;
 
 	case MDIO_I2C_ROLLBALL:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL,
+				       PHY_ACCESS_C45);
 		break;
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fdb3774e99fc..fb7481715c3b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -531,6 +531,17 @@ struct phy_c45_device_ids {
 struct macsec_context;
 struct macsec_ops;
 
+/**
+ * enum phy_access_mode - PHY register access mode definitions
+ *
+ * @PHY_ACCESS_C22: use 802.3 c22 MDIO transactions
+ * @PHY_ACCESS_C45: use 802.3 c45 MDIO transactions
+ */
+enum phy_access_mode {
+	PHY_ACCESS_C22 = 22,
+	PHY_ACCESS_C45 = 45,
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -539,8 +550,7 @@ struct macsec_ops;
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phy_id: UID for this device found during discovery
- * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
- * @is_c45:  Set to true if this PHY uses clause 45 addressing.
+ * @c45_ids: 802.3-c45 Device Identifiers if it's an C45 PHY.
  * @is_internal: Set to true if this PHY is internal to a MAC.
  * @is_pseudo_fixed_link: Set to true if this PHY is an Ethernet switch, etc.
  * @is_gigabit_capable: Set to true if PHY supports 1000Mbps
@@ -555,6 +565,7 @@ struct macsec_ops;
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
  * @state: State of the PHY for management purposes
+ * @access_mode:  MDIO access mode of the PHY.
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
  *      - Bits [15:0] are free to use by the PHY driver to communicate
@@ -638,7 +649,6 @@ struct phy_device {
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
-	unsigned is_c45:1;
 	unsigned is_internal:1;
 	unsigned is_pseudo_fixed_link:1;
 	unsigned is_gigabit_capable:1;
@@ -665,6 +675,7 @@ struct phy_device {
 	int rate_matching;
 
 	enum phy_state state;
+	enum phy_access_mode access_mode;
 
 	u32 dev_flags;
 
@@ -768,7 +779,7 @@ static inline struct phy_device *to_phy_device(const struct device *dev)
 
 static inline bool phy_has_c45_registers(struct phy_device *phydev)
 {
-	return phydev->is_c45;
+	return phydev->access_mode != PHY_ACCESS_C22;
 }
 
 /**
@@ -1624,7 +1635,7 @@ int phy_modify_paged(struct phy_device *phydev, int page, u32 regnum,
 		     u16 mask, u16 set);
 
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
-				     bool is_c45,
+				     enum phy_access_mode mode,
 				     struct phy_c45_device_ids *c45_ids);
 #if IS_ENABLED(CONFIG_PHYLIB)
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
@@ -1632,7 +1643,8 @@ struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
 struct phy_device *device_phy_find_device(struct device *dev);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode);
 int phy_device_register(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 #else
@@ -1664,7 +1676,8 @@ struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
 }
 
 static inline
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode)
 {
 	return NULL;
 }

-- 
2.39.2


