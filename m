Return-Path: <netdev+bounces-169213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67302A42FB8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46307A87BA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D21C32EA;
	Mon, 24 Feb 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Y4xdoEw2"
X-Original-To: netdev@vger.kernel.org
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598A8C11
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434516; cv=none; b=EaJQxwXFGwRXl4zneBIpm4pGclgwXAEueAd9FilEecey+Fs5H5yUma4SRSkQHgql4A+cUF+FYj5hsebbK13waqjcWz0BhfzZ+J5wSMiDaJDV9sQYKbqqt2EVPuxacbpE3KlI6hFj/tg/WdEnWQ5Ai7vERAP8qoxldZg3kymhzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434516; c=relaxed/simple;
	bh=DiyfeZznG3Y/3tYbp1JNq7xJmytB3do4e9ioGJmbv+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s37hqLYdTXtWjYue/rh+fRbmzUVcaSSosv1r3OV4lop4eDlVwU1lQKdvb/yJfIWRhG1PnB+/yq8vWldN+ls4geZwuNj/blfrLTdClMK0/J239NKCQWfoWTbMpVeYJMHwbluhY119fh+kTpywPBmr1Mg4X3BcV/5TgB6/2PtiQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Y4xdoEw2; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vhXDZTLqdu7IJW4noakGN2b7sjwsAcQ4Qd/URI3PMF0=; b=Y4xdoEw2v8+XkV1Fa/apPDbTrF
	Xp3QYOSSx+BwPdCEGid/lAZHbLaBxvjr9krc5qT4O4TeJkXarZW5yS+eEVdULbw+Xrd7zaw5WKwK7
	NzEREjQhfpTp8Y/+slqC7qr0zIA+8TNkz5QjZDYJlZRPAY0fSkc4KGMQAW5KDo27eMTk=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tmfnl-000000000wu-3Uix;
	Mon, 24 Feb 2025 22:15:46 +0100
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
Subject: [PATCH net-next v8 2/8] net: phy: Support speed selection for PHY loopback
Date: Mon, 24 Feb 2025 22:15:25 +0100
Message-Id: <20250224211531.115980-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224211531.115980-1-gerhard@engleder-embedded.com>
References: <20250224211531.115980-1-gerhard@engleder-embedded.com>
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
 drivers/net/phy/phy.c                         | 87 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  | 35 --------
 include/linux/phy.h                           |  2 +-
 net/core/selftests.c                          |  4 +-
 9 files changed, 100 insertions(+), 48 deletions(-)

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
index 3f17b3073e50..f8161d6eb152 100644
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
index 831b36839627..f1ff5542de1d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1722,6 +1722,93 @@ void phy_mac_interrupt(struct phy_device *phydev)
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
+ *
+ * Return: 0 on success, negative error code on failure.
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
+	if (ret) {
+		if (enable) {
+			/* try to restore link if enabling loopback fails */
+			if (phydev->drv->set_loopback)
+				phydev->drv->set_loopback(phydev, false, 0);
+			else
+				genphy_loopback(phydev, false, 0);
+		}
+
+		goto out;
+	}
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
  * phy_eee_tx_clock_stop_capable() - indicate whether the MAC can stop tx clock
  * @phydev: target phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6487b19970b4..5130d0f3f4c3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2052,41 +2052,6 @@ int phy_resume(struct phy_device *phydev)
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
index 73d81cc9e5e1..dcd96e623e31 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1870,7 +1870,7 @@ int phy_init_hw(struct phy_device *phydev);
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


