Return-Path: <netdev+bounces-174339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF8A5E55B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FACC189A9A6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58F1EDA12;
	Wed, 12 Mar 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xDfCS03g"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CD1E7C25
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811425; cv=none; b=tD0q6i+vjUKbgulnIE7F0as5IKHO7n1/Jj169pDD3DuTkcp0S+62dS+ASwV5jGbPExc0MuWtSiK7F1G+oYK+NFDhpUuG/I+tIEWWpvZGx2iQUqLDHKHF0D6LygbbAzg3dkX+MvQEsl772gPYuSD+kHEc7aqchD/MHyYyvsTCi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811425; c=relaxed/simple;
	bh=OqOYWDjAzCc8KbwVOpYAIFYPwgo3oD8X+vno87uGxY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYBzLbjrW+yDQCjpfRGovk6BGfIWrs4k2ov1xyfmBD+LKDbJpLhoiIDcRpujS+1Iu4JumAv/dKAUQ0Y28irALikY3O3AQ5AMhNVnvtlanWRMJMabG3ZfOlGbWzrn3kEMJHXE4ifm0pka8bXpnGgVb1+oMObQGslSZaa8L7CjwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=xDfCS03g; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CXcy78PjBXIFJn3owN7v094WaL5ABIAPiot6Klic6uY=; b=xDfCS03gDcEkXSof91SR43OoVb
	ujXAkkjQjP54m0ACRzPsQO6K1w/9xQKosGiKCB/1062huVLe/vQhAOYGt7kg//u4cgkVZT+0/D/kl
	sfYmDChRO2xQIvsdRQN+q/ZDuKSUR4nyO3s5tnL+o9zGrUaUwgV2bAYKseRlrErNHYH4=;
Received: from 80-121-79-4.adsl.highway.telekom.at ([80.121.79.4] helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tsSiT-000000006Ue-3cry;
	Wed, 12 Mar 2025 21:30:14 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v10 1/5] net: phy: Allow loopback speed selection for PHY drivers
Date: Wed, 12 Mar 2025 21:30:06 +0100
Message-Id: <20250312203010.47429-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312203010.47429-1-gerhard@engleder-embedded.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

PHY drivers support loopback mode, but it is not possible to select the
speed of the loopback mode. The speed is chosen by the set_loopback()
operation of the PHY driver. Same is valid for genphy_loopback().

There are PHYs that support loopback with different speeds. Extend
set_loopback() to make loopback speed selection possible.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/adin1100.c          |  5 ++++-
 drivers/net/phy/dp83867.c           |  5 ++++-
 drivers/net/phy/marvell.c           |  8 +++++++-
 drivers/net/phy/mxl-gpy.c           | 11 +++++++----
 drivers/net/phy/phy-c45.c           |  5 ++++-
 drivers/net/phy/phy_device.c        | 12 +++++++++---
 drivers/net/phy/xilinx_gmii2rgmii.c |  7 ++++---
 include/linux/phy.h                 | 16 ++++++++++++----
 8 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 6bb469429b9d..bd7a47a903ac 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -215,8 +215,11 @@ static int adin_resume(struct phy_device *phydev)
 	return adin_set_powerdown_mode(phydev, false);
 }
 
-static int adin_set_loopback(struct phy_device *phydev, bool enable)
+static int adin_set_loopback(struct phy_device *phydev, bool enable, int speed)
 {
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
 	if (enable)
 		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_10T1L_CTRL,
 					BMCR_LOOPBACK);
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index c1451df430ac..063266cafe9c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1009,8 +1009,11 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int dp83867_loopback(struct phy_device *phydev, bool enable)
+static int dp83867_loopback(struct phy_device *phydev, bool enable, int speed)
 {
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
 	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
 			  enable ? BMCR_LOOPBACK : 0);
 }
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index dd254e36ca8a..f2ad675537d1 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -2131,13 +2131,19 @@ static void marvell_get_stats_simple(struct phy_device *phydev,
 		data[i] = marvell_get_stat_simple(phydev, i);
 }
 
-static int m88e1510_loopback(struct phy_device *phydev, bool enable)
+static int m88e1510_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	int err;
 
 	if (enable) {
 		u16 bmcr_ctl, mscr2_ctl = 0;
 
+		if (speed == SPEED_10 || speed == SPEED_100 ||
+		    speed == SPEED_1000)
+			phydev->speed = speed;
+		else if (speed)
+			return -EINVAL;
+
 		bmcr_ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
 		err = phy_write(phydev, MII_BMCR, bmcr_ctl);
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 94d9cb727121..a6cca8d43253 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -813,7 +813,7 @@ static void gpy_get_wol(struct phy_device *phydev,
 	wol->wolopts = priv->wolopts;
 }
 
-static int gpy_loopback(struct phy_device *phydev, bool enable)
+static int gpy_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	struct gpy_priv *priv = phydev->priv;
 	u16 set = 0;
@@ -822,6 +822,9 @@ static int gpy_loopback(struct phy_device *phydev, bool enable)
 	if (enable) {
 		u64 now = get_jiffies_64();
 
+		if (speed)
+			return -EOPNOTSUPP;
+
 		/* wait until 3 seconds from last disable */
 		if (time_before64(now, priv->lb_dis_to))
 			msleep(jiffies64_to_msecs(priv->lb_dis_to - now));
@@ -845,15 +848,15 @@ static int gpy_loopback(struct phy_device *phydev, bool enable)
 	return 0;
 }
 
-static int gpy115_loopback(struct phy_device *phydev, bool enable)
+static int gpy115_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	struct gpy_priv *priv = phydev->priv;
 
 	if (enable)
-		return gpy_loopback(phydev, enable);
+		return gpy_loopback(phydev, enable, speed);
 
 	if (priv->fw_minor > 0x76)
-		return gpy_loopback(phydev, 0);
+		return gpy_loopback(phydev, 0, 0);
 
 	return genphy_soft_reset(phydev);
 }
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0bcbdce38107..8a0ffc3174ec 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1228,8 +1228,11 @@ int gen10g_config_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(gen10g_config_aneg);
 
-int genphy_c45_loopback(struct phy_device *phydev, bool enable)
+int genphy_c45_loopback(struct phy_device *phydev, bool enable, int speed)
 {
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
 	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
 			      MDIO_PCS_CTRL1_LOOPBACK,
 			      enable ? MDIO_PCS_CTRL1_LOOPBACK : 0);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b2d32fbc8c85..b6828019c34c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1837,9 +1837,9 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 	}
 
 	if (phydev->drv->set_loopback)
-		ret = phydev->drv->set_loopback(phydev, enable);
+		ret = phydev->drv->set_loopback(phydev, enable, 0);
 	else
-		ret = genphy_loopback(phydev, enable);
+		ret = genphy_loopback(phydev, enable, 0);
 
 	if (ret)
 		goto out;
@@ -2608,12 +2608,18 @@ int genphy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_resume);
 
-int genphy_loopback(struct phy_device *phydev, bool enable)
+int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	if (enable) {
 		u16 ctl = BMCR_LOOPBACK;
 		int ret, val;
 
+		if (speed == SPEED_10 || speed == SPEED_100 ||
+		    speed == SPEED_1000)
+			phydev->speed = speed;
+		else if (speed)
+			return -EINVAL;
+
 		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
 		phy_modify(phydev, MII_BMCR, ~0, ctl);
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7c51daecf18e..2024d8ef36d9 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -64,15 +64,16 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable)
+static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable,
+				     int speed)
 {
 	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
 	int err;
 
 	if (priv->phy_drv->set_loopback)
-		err = priv->phy_drv->set_loopback(phydev, enable);
+		err = priv->phy_drv->set_loopback(phydev, enable, speed);
 	else
-		err = genphy_loopback(phydev, enable);
+		err = genphy_loopback(phydev, enable, speed);
 	if (err < 0)
 		return err;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c4a6385faf41..e8e42888f3e1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1136,8 +1136,16 @@ struct phy_driver {
 	int (*set_tunable)(struct phy_device *dev,
 			    struct ethtool_tunable *tuna,
 			    const void *data);
-	/** @set_loopback: Set the loopback mood of the PHY */
-	int (*set_loopback)(struct phy_device *dev, bool enable);
+	/**
+	 * @set_loopback: Set the loopback mode of the PHY
+	 * enable selects if the loopback mode is enabled or disabled. If the
+	 * loopback mode is enabled, then the speed of the loopback mode can be
+	 * requested with the speed argument. If the speed argument is zero,
+	 * then any speed can be selected. If the speed argument is > 0, then
+	 * this speed shall be selected for the loopback mode or EOPNOTSUPP
+	 * shall be returned if speed selection is not supported.
+	 */
+	int (*set_loopback)(struct phy_device *dev, bool enable, int speed);
 	/** @get_sqi: Get the signal quality indication */
 	int (*get_sqi)(struct phy_device *dev);
 	/** @get_sqi_max: Get the maximum signal quality indication */
@@ -1930,7 +1938,7 @@ int genphy_read_status(struct phy_device *phydev);
 int genphy_read_master_slave(struct phy_device *phydev);
 int genphy_suspend(struct phy_device *phydev);
 int genphy_resume(struct phy_device *phydev);
-int genphy_loopback(struct phy_device *phydev, bool enable);
+int genphy_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_soft_reset(struct phy_device *phydev);
 irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);
 
@@ -1972,7 +1980,7 @@ int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev);
 int genphy_c45_read_status(struct phy_device *phydev);
 int genphy_c45_baset1_read_status(struct phy_device *phydev);
 int genphy_c45_config_aneg(struct phy_device *phydev);
-int genphy_c45_loopback(struct phy_device *phydev, bool enable);
+int genphy_c45_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_c45_pma_resume(struct phy_device *phydev);
 int genphy_c45_pma_suspend(struct phy_device *phydev);
 int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable);
-- 
2.39.5


