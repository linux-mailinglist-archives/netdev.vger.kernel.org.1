Return-Path: <netdev+bounces-160869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA5A1BE6E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930916E4C6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5241EEA2C;
	Fri, 24 Jan 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="jsIentGE"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1091EEA28
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757943; cv=none; b=qlBg/zCSm5IXT4PnkiafrtvbmjAAggXF061Gf5mZt/ug3kLEwvslNV8ObC76E6PrmMwhPpIxeiFi+wsG/raXcQFAo/G2FLj6u0mLu/ApWWVYAOcEykgxbsb6LWhSa8YKPFdh/hl0CIT/PYA/0l5V9U1aDlo5YoccL5PBVWgqR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757943; c=relaxed/simple;
	bh=Pf8YxtFwo9EOKCrQ0vyUm3DOfXzF0dgB4pi4/36ysjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imVSA9pOjzcbM9I0tcfxYzUhMZFOyTPn00VDXNxs8rfwBwPpxHsLYpNnKHxWjslltNTpLNkRGr4fC6DCjWgOOihTw/hWPPYr3Zaf8VRl9RbQZpIYsmU+KnQlUmn1voq2z/n0R3tSCbOv8+yaTVbRjBkJScxdzDqIejtBWqujsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=jsIentGE; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r5ZZKWI0odZXRg8ljY3tN+GWITlBmL3GldUOdCkK6nE=; b=jsIentGEGXRW2BuSQIOSMxzQf0
	OsqTvBOvy9vCZSA0tk0fn9aXX/OJXC17weoavY3SPBgQ3v2aQ5S0H9YsMqRZg4TWTynMTNWMur31k
	nWaRJI2mMGW1lJEhigQ5JJ9zWMC6DLBwUshvP1FTE2Z/Uk7RiT/BsfmLTovA7evD8Plc=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tbRnw-000000005Ng-0skn;
	Fri, 24 Jan 2025 23:05:32 +0100
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
Subject: [RFC PATCH net-next v3 2/7] net: phy: Support speed selection for PHY loopback
Date: Fri, 24 Jan 2025 23:05:11 +0100
Message-Id: <20250124220516.113798-3-gerhard@engleder-embedded.com>
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

phy_loopback() leaves it to the PHY driver to select the speed of the
loopback mode. Thus, the speed of the loopback mode depends on the PHY
driver in use.

Add support for speed selection to phy_loopback() to enable loopback
with defined speeds. Ensure that link up is signaled if speed changes
as speed is not allowed to change during link up. Link down and up is
necessary for a new speed.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c    |  2 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |  8 +-
 drivers/net/phy/phy.c                         | 76 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  | 35 ---------
 include/linux/phy.h                           |  2 +-
 net/core/selftests.c                          |  4 +-
 9 files changed, 89 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 18df6a5cbfc6..a16b12137edb 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -230,7 +230,7 @@ static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 {
 	int retval;
 
-	retval = phy_loopback(adapter->phydev, enable);
+	retval = phy_loopback(adapter->phydev, enable, 0);
 
 	/* PHY link state change is not signaled if loopback is enabled, it
 	 * would delay a working loopback anyway, let's ensure that loopback
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 6c458f037262..60a586a951a0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -266,9 +266,9 @@ static int hns_nic_config_phy_loopback(struct phy_device *phy_dev, u8 en)
 		if (err)
 			goto out;
 
-		err = phy_loopback(phy_dev, true);
+		err = phy_loopback(phy_dev, true, 0);
 	} else {
-		err = phy_loopback(phy_dev, false);
+		err = phy_loopback(phy_dev, false, 0);
 		if (err)
 			goto out;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index db7845009252..3826b982fef8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7875,7 +7875,7 @@ static int hclge_enable_phy_loopback(struct hclge_dev *hdev,
 	if (ret)
 		return ret;
 
-	return phy_loopback(phydev, true);
+	return phy_loopback(phydev, true, 0);
 }
 
 static int hclge_disable_phy_loopback(struct hclge_dev *hdev,
@@ -7883,7 +7883,7 @@ static int hclge_disable_phy_loopback(struct hclge_dev *hdev,
 {
 	int ret;
 
-	ret = phy_loopback(phydev, false);
+	ret = phy_loopback(phydev, false, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 80079657afeb..9a456ebf9b7c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -258,7 +258,7 @@ void hclge_mac_start_phy(struct hclge_dev *hdev)
 	if (!phydev)
 		return;
 
-	phy_loopback(phydev, false);
+	phy_loopback(phydev, false, 0);
 
 	phy_start(phydev);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 3ca1c2a816ff..a01bc394d1ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -382,14 +382,14 @@ static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
 	if (!priv->dev->phydev)
 		return -EOPNOTSUPP;
 
-	ret = phy_loopback(priv->dev->phydev, true);
+	ret = phy_loopback(priv->dev->phydev, true, 0);
 	if (ret)
 		return ret;
 
 	attr.dst = priv->dev->dev_addr;
 	ret = __stmmac_test_loopback(priv, &attr);
 
-	phy_loopback(priv->dev->phydev, false);
+	phy_loopback(priv->dev->phydev, false, 0);
 	return ret;
 }
 
@@ -1985,7 +1985,7 @@ void stmmac_selftest_run(struct net_device *dev,
 		case STMMAC_LOOPBACK_PHY:
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, true);
+				ret = phy_loopback(dev->phydev, true, 0);
 			if (!ret)
 				break;
 			fallthrough;
@@ -2018,7 +2018,7 @@ void stmmac_selftest_run(struct net_device *dev,
 		case STMMAC_LOOPBACK_PHY:
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, false);
+				ret = phy_loopback(dev->phydev, false, 0);
 			if (!ret)
 				break;
 			fallthrough;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c008fe050245..b16ffdf79832 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1703,6 +1703,82 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_loopback - Configure loopback mode of PHY
+ * @phydev: target phy_device struct
+ * @enable: enable or disable loopback mode
+ * @speed: enable loopback mode with speed
+ *
+ * Configure loopback mode of PHY and signal link down and link up if speed is
+ * changing.
+ */
+int phy_loopback(struct phy_device *phydev, bool enable, int speed)
+{
+	bool link_up = false;
+	int ret = 0;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+
+	if (enable && phydev->loopback_enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!enable && !phydev->loopback_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (enable) {
+		/*
+		 * Link up is signaled with a defined speed. If speed changes,
+		 * then first link down and after that link up needs to be
+		 * signaled.
+		 */
+		if (phydev->link && phydev->state == PHY_RUNNING) {
+			/* link is up and signaled */
+			if (speed && phydev->speed != speed) {
+				/* signal link down and up for new speed */
+				phydev->link = false;
+				phydev->state = PHY_NOLINK;
+				phy_link_down(phydev);
+
+				link_up = true;
+			}
+		} else {
+			/* link is not signaled */
+			if (speed) {
+				/* signal link up for new speed */
+				link_up = true;
+			}
+		}
+	}
+
+	if (phydev->drv->set_loopback)
+		ret = phydev->drv->set_loopback(phydev, enable, speed);
+	else
+		ret = genphy_loopback(phydev, enable, speed);
+
+	if (ret)
+		goto out;
+
+	if (link_up) {
+		phydev->link = true;
+		phydev->state = PHY_RUNNING;
+		phy_link_up(phydev);
+	}
+
+	phydev->loopback_enabled = enable;
+
+out:
+	mutex_unlock(&phydev->lock);
+	return ret;
+}
+EXPORT_SYMBOL(phy_loopback);
+
 /**
  * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
  * @phydev: target phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 19f4deac59a6..d98ac0bd6d48 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2102,41 +2102,6 @@ int phy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_resume);
 
-int phy_loopback(struct phy_device *phydev, bool enable)
-{
-	int ret = 0;
-
-	if (!phydev->drv)
-		return -EIO;
-
-	mutex_lock(&phydev->lock);
-
-	if (enable && phydev->loopback_enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	if (!enable && !phydev->loopback_enabled) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (phydev->drv->set_loopback)
-		ret = phydev->drv->set_loopback(phydev, enable, 0);
-	else
-		ret = genphy_loopback(phydev, enable, 0);
-
-	if (ret)
-		goto out;
-
-	phydev->loopback_enabled = enable;
-
-out:
-	mutex_unlock(&phydev->lock);
-	return ret;
-}
-EXPORT_SYMBOL(phy_loopback);
-
 /**
  * phy_reset_after_clk_enable - perform a PHY reset if needed
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fe61ae958a6c..868798b6d9e8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1904,7 +1904,7 @@ int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
-int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_loopback(struct phy_device *phydev, bool enable, int speed);
 int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 8f801e6e3b91..e99ae983fca9 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -299,7 +299,7 @@ static int net_test_phy_loopback_enable(struct net_device *ndev)
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
 
-	return phy_loopback(ndev->phydev, true);
+	return phy_loopback(ndev->phydev, true, 0);
 }
 
 static int net_test_phy_loopback_disable(struct net_device *ndev)
@@ -307,7 +307,7 @@ static int net_test_phy_loopback_disable(struct net_device *ndev)
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
 
-	return phy_loopback(ndev->phydev, false);
+	return phy_loopback(ndev->phydev, false, 0);
 }
 
 static int net_test_phy_loopback_udp(struct net_device *ndev)
-- 
2.39.5


