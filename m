Return-Path: <netdev+bounces-39215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85D7BE56B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9D51C20CD3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE6374FC;
	Mon,  9 Oct 2023 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="momwC1vz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF6374DE
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:51:59 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298EE0;
	Mon,  9 Oct 2023 08:51:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B157C1C0015;
	Mon,  9 Oct 2023 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696866715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCGdAto1+QXVw1w1qLCsJMnj81jolLUsBwWTGbRy+0Y=;
	b=momwC1vzc2IU8ca67lLfPkk/qA++etY65cxvjh3z3R/UngLPjgKgKSkYIZ1brHy7Y8XDp+
	dEHVGEAh/llfcpGbTx+VdnYfXwnv45AY20bAKciaCxUqoJ+OZMuL9/i5bV9Cl4My42QDm3
	Rm45KIHuB+sQ+pelfIgcKT37ErI9ERYo4FdsFhbhtffgQTiJNb1+YN3twFcsv5bhYJ5DH5
	oncTiKDNer+TTVsSYsaiCsQ074hCKSuvcY4/+Mp4o+92uFjH0RXMiKj6uiNRxg4Szg+SnL
	NMyHd6+vObOzuU9FUvmzJRSyXBkcAegX1v6WZbN8GCyQR1aSmhVf9RffmOMfJA==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 03/16] net: ethtool: Refactor identical get_ts_info implementations.
Date: Mon,  9 Oct 2023 17:51:25 +0200
Message-Id: <20231009155138.86458-4-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Richard Cochran <richardcochran@gmail.com>

The vlan, macvlan and the bonding drivers call their "real" device driver
in order to report the time stamping capabilities.  Provide a core
ethtool helper function to avoid copy/paste in the stack.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v5:
- Fixe typo
---
 drivers/net/bonding/bond_main.c | 27 ++-------------------------
 drivers/net/macvlan.c           | 14 +-------------
 include/linux/ethtool.h         |  8 ++++++++
 net/8021q/vlan_dev.c            | 15 +--------------
 net/ethtool/common.c            |  6 ++++++
 5 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ed7212e61c54..18af563d20b2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5763,29 +5763,12 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	rcu_read_unlock();
 
 	if (real_dev) {
-		ops = real_dev->ethtool_ops;
-		phydev = real_dev->phydev;
-
-		if (phy_has_tsinfo(phydev)) {
-			ret = phy_ts_info(phydev, info);
-			goto out;
-		} else if (ops->get_ts_info) {
-			ret = ops->get_ts_info(real_dev, info);
-			goto out;
-		}
+		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
-			ret = -1;
-			ops = slave->dev->ethtool_ops;
-			phydev = slave->dev->phydev;
-
-			if (phy_has_tsinfo(phydev))
-				ret = phy_ts_info(phydev, &ts_info);
-			else if (ops->get_ts_info)
-				ret = ops->get_ts_info(slave->dev, &ts_info);
-
+			ret = ethtool_get_ts_info_by_layer(slave->dev, &ts_info);
 			if (!ret && (ts_info.so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE)) {
 				sw_tx_support = true;
 				continue;
@@ -5797,15 +5780,9 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 		rcu_read_unlock();
 	}
 
-	ret = 0;
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
 	if (sw_tx_support)
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 
-	info->phc_index = -1;
-
-out:
 	dev_put(real_dev);
 	return ret;
 }
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 02bd201bc7e5..759406fbaea8 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1086,20 +1086,8 @@ static int macvlan_ethtool_get_ts_info(struct net_device *dev,
 				       struct ethtool_ts_info *info)
 {
 	struct net_device *real_dev = macvlan_dev_real_dev(dev);
-	const struct ethtool_ops *ops = real_dev->ethtool_ops;
-	struct phy_device *phydev = real_dev->phydev;
 
-	if (phy_has_tsinfo(phydev)) {
-		return phy_ts_info(phydev, info);
-	} else if (ops->get_ts_info) {
-		return ops->get_ts_info(real_dev, info);
-	} else {
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
-	}
-
-	return 0;
+	return ethtool_get_ts_info_by_layer(real_dev, info);
 }
 
 static netdev_features_t macvlan_fix_features(struct net_device *dev,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..1159daac776e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1043,6 +1043,14 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
 	return -EINVAL;
 }
 
+/**
+ * ethtool_get_ts_info_by_layer - Obtains time stamping capabilities from the MAC or PHY layer.
+ * @dev: pointer to net_device structure
+ * @info: buffer to hold the result
+ * Returns zero on success, non-zero otherwise.
+ */
+int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info);
+
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
  * @data: Pointer to start of string to update
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 2a7f1b15714a..407b2335f091 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -702,20 +702,7 @@ static int vlan_ethtool_get_ts_info(struct net_device *dev,
 				    struct ethtool_ts_info *info)
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	const struct ethtool_ops *ops = vlan->real_dev->ethtool_ops;
-	struct phy_device *phydev = vlan->real_dev->phydev;
-
-	if (phy_has_tsinfo(phydev)) {
-		return phy_ts_info(phydev, info);
-	} else if (ops->get_ts_info) {
-		return ops->get_ts_info(vlan->real_dev, info);
-	} else {
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
-	}
-
-	return 0;
+	return ethtool_get_ts_info_by_layer(vlan->real_dev, info);
 }
 
 static void vlan_dev_get_stats64(struct net_device *dev,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..e2315e24d695 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -661,6 +661,12 @@ int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
 }
 EXPORT_SYMBOL(ethtool_get_phc_vclocks);
 
+int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info)
+{
+	return __ethtool_get_ts_info(dev, info);
+}
+EXPORT_SYMBOL(ethtool_get_ts_info_by_layer);
+
 const struct ethtool_phy_ops *ethtool_phy_ops;
 
 void ethtool_set_ethtool_phy_ops(const struct ethtool_phy_ops *ops)
-- 
2.25.1


