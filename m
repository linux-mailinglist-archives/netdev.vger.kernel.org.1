Return-Path: <netdev+bounces-76185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167486CB00
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A082868F7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0551419A7;
	Thu, 29 Feb 2024 14:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831514A0AB
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215709; cv=none; b=r/GidOVNq5Hfs08mBrqf3+WHXf8KfLaU6NzfdS/dfv33xmlzykr9d6sgMVMKFz+MxTK2y+ZUFIIgMrwWwlMlAhFkVXFireVlXIymJC6y/f711mn2+nMSWovdPbR/8efjeWeLNqJMJkfJhaqkd9EiTxYFrN6r6aUyLw0e1zhoilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215709; c=relaxed/simple;
	bh=2gdb8QFpvX/+BfbeE/tU8fiuiVqBgFxh855Pe4Pdm2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpvcBqh4C7Pliy+10GH9qabzbvgU/0CDLdWHvhDV4+dDsG1LyZzCpFIXCxY5Px+/g1kucwwBz6MmC3ECnVmlsRFyipXw+Cla1l4K5z9obnR0N4MK1pEQmR+SQkd7XtEXTNYqvoipPdki9zzs6nd2NRbXvSYn1QKBWG+91TY+5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4t-0000Sv-MW; Thu, 29 Feb 2024 15:08:03 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-003bZx-Sy; Thu, 29 Feb 2024 15:08:01 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-00ELmU-2C;
	Thu, 29 Feb 2024 15:08:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v7 4/8] net: phy: Keep track of EEE configuration
Date: Thu, 29 Feb 2024 15:07:56 +0100
Message-Id: <20240229140800.3420180-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229140800.3420180-1-o.rempel@pengutronix.de>
References: <20240229140800.3420180-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Have phylib keep track of the EEE configuration. This simplifies the
MAC drivers, in that they don't need to store it.

Future patches to phylib will also make use of this information to
further simplify the MAC drivers.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v6: add @ in front of eee_cfg
---
 drivers/net/phy/phy.c | 7 +++++--
 include/linux/phy.h   | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index ab18b0d9beb47..f0ed07c74a36e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1660,8 +1660,8 @@ EXPORT_SYMBOL(phy_get_eee_err);
  * @phydev: target phy_device struct
  * @data: ethtool_keee data
  *
- * Description: it reportes the Supported/Advertisement/LP Advertisement
- * capabilities.
+ * Description: reports the Supported/Advertisement/LP Advertisement
+ * capabilities, etc.
  */
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
@@ -1672,6 +1672,7 @@ int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_get_eee(phydev, data);
+	eeecfg_to_eee(&phydev->eee_cfg, data);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
@@ -1694,6 +1695,8 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
+	if (!ret)
+		eee_to_eeecfg(data, &phydev->eee_cfg);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 432c561f58098..c315928357c8c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -30,6 +30,7 @@
 #include <linux/refcount.h>
 
 #include <linux/atomic.h>
+#include <net/eee.h>
 
 #define PHY_DEFAULT_FEATURES	(SUPPORTED_Autoneg | \
 				 SUPPORTED_TP | \
@@ -595,6 +596,7 @@ struct macsec_ops;
  * @advertising_eee: Currently advertised EEE linkmodes
  * @eee_enabled: Flag indicating whether the EEE feature is enabled
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
+ * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
  * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
@@ -715,6 +717,7 @@ struct phy_device {
 	/* Energy efficient ethernet modes which should be prohibited */
 	u32 eee_broken_modes;
 	bool enable_tx_lpi;
+	struct eee_config eee_cfg;
 
 #ifdef CONFIG_LED_TRIGGER_PHY
 	struct phy_led_trigger *phy_led_triggers;
-- 
2.39.2


