Return-Path: <netdev+bounces-160868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9CA1BE6D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AB81890087
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A081DB138;
	Fri, 24 Jan 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="w/US+93Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFF1E98FC
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757939; cv=none; b=ZtSKTgo0f8U4zGgjbK3MtEqC5FcLgt+hMFIive0G0xybGIN4JYWhAdun5T+wzprwKAuCKGgci6yWpsjRtlVP3pTGLPCaTc9mTZIXkq0BZdmeNFLikddkN2inC1fi6Kv0CkFf4WMEYrs/Z1it1KyelVXKd2YyDs9bATkL73a8uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757939; c=relaxed/simple;
	bh=xdXwkAGyAlsxSKy/kmwlzfZ9HMEg8WhkwCfzFxHFsLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdiUzbIXV2EzPnx+GUeMmSc1NLL2H8ap+bJM95mPGFz/1nbSS31k2RSAq8kWP/Npp9QXACbMEqd0rqIQvmC1SIEluiHC1sGJl6/iiSxmGwFbpPSBQkaiERbg9PK+NAuDZXU91fF1Ylxqq3p4pLP4oxqjBOfZuD1Zl5vNsyaVS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=w/US+93Q; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LIyg/QQgFIPrTGKoX9Ccwm4JDKA/xTAf+3XCS+ERIeE=; b=w/US+93Qr+ThJbApvx2YtnZ9oq
	0+OpEczCpDfXCMPy3gc2qnEM7k3jQoBlgybU/U3GkEiaAj9GuSLpZpPgx3VBtqYRYpx+xP7Z9hjdn
	ddLGapc2HT5A6WHJksNGX5sHwcuto0dSBw8+XtP0QdRjvyO0NoL1NY424CNZrOkF4GXY=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tbRnt-000000005Ng-3hTG;
	Fri, 24 Jan 2025 23:05:30 +0100
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
Subject: [RFC PATCH net-next v3 1/7] net: phy: Allow loopback speed selection for PHY drivers
Date: Fri, 24 Jan 2025 23:05:10 +0100
Message-Id: <20250124220516.113798-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124220516.113798-1-gerhard@engleder-embedded.com>
References: <20250124220516.113798-1-gerhard@engleder-embedded.com>
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
index 44e1927de499..4ed7ec1be74f 100644
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
index 0dac08e85304..84c24e8847c3 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1230,8 +1230,11 @@ int gen10g_config_aneg(struct phy_device *phydev)
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
index 5b34d39d1d52..19f4deac59a6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2122,9 +2122,9 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 	}
 
 	if (phydev->drv->set_loopback)
-		ret = phydev->drv->set_loopback(phydev, enable);
+		ret = phydev->drv->set_loopback(phydev, enable, 0);
 	else
-		ret = genphy_loopback(phydev, enable);
+		ret = genphy_loopback(phydev, enable, 0);
 
 	if (ret)
 		goto out;
@@ -2893,12 +2893,18 @@ int genphy_resume(struct phy_device *phydev)
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
index afaae74d0949..fe61ae958a6c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1207,8 +1207,16 @@ struct phy_driver {
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
@@ -2011,7 +2019,7 @@ int genphy_read_status(struct phy_device *phydev);
 int genphy_read_master_slave(struct phy_device *phydev);
 int genphy_suspend(struct phy_device *phydev);
 int genphy_resume(struct phy_device *phydev);
-int genphy_loopback(struct phy_device *phydev, bool enable);
+int genphy_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_soft_reset(struct phy_device *phydev);
 irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);
 
@@ -2053,7 +2061,7 @@ int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev);
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


