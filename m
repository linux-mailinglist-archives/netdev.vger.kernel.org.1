Return-Path: <netdev+bounces-162216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6FA26358
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48994163E9B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E420A5CF;
	Mon,  3 Feb 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="kHIEYBQT"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603C20B20E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609905; cv=none; b=K4G7+TPnc+2O9UOdm54KwV547k5A+pheYiVYyYezy10InmRSbA7w02S76VlK4R1dSS7xSE3QOG7Yp75B43cRBbhuPOSrv1TVzYlrWT6Is8J/QrmQvGlVxS/9s+9J7U1fCByooK811aswe8eOnhURSbtwj2C4GHoQ2Se0YbTs2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609905; c=relaxed/simple;
	bh=vS4sQVfb16y9DLPEwlNhNIiEXXsLUpY2oHAQ+Oa7gG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSkc5jpykSiliep3LwfAnfCVVpffG7rLH/OhJ32tXqH5Kj7d1ihiBbqJdyitMgcUgtFwc7EMpPJmTZQTJAL4qiUGw9NQN9CH+JzTc25zDSfPxlx4u9kvrS/8oTtd7FusplqKuWAOjmreiP+oQKR2mKEMFT5L98Dax7g0Qyz1OwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=kHIEYBQT; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2D5GiUUykY89hChn3aAP5ndnXdPq65QEBMcFLEpBzdc=; b=kHIEYBQTYK76+LvBCCe1xfoiGZ
	ZcSdgGAiipD6fke9q7+iCPx0w+FlJ+k5OZgd5Lw75keBUoe+Ql9LNYpqwW+Ap+Ioc70rwuwWYTOtc
	DjND3XW5uX06gLh8P8qH41eU0JWv7No2BcUWqcUlDVdIt7XoFvLRDfvA7oLRxFZqF0NQ=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tf1r9-000000004RY-1oCF;
	Mon, 03 Feb 2025 20:11:39 +0100
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
Subject: [PATCH net-next v4 7/7] tsnep: Add PHY loopback selftests
Date: Mon,  3 Feb 2025 20:10:57 +0100
Message-Id: <20250203191057.46351-8-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203191057.46351-1-gerhard@engleder-embedded.com>
References: <20250203191057.46351-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Add loopback selftests on PHY level. This enables quick testing of
loopback functionality to ensure working loopback for testing.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/Kconfig         |   1 +
 .../net/ethernet/engleder/tsnep_selftests.c   | 153 +++++++++++++++++-
 2 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethernet/engleder/Kconfig
index 3df6bf476ae7..8245a9c4377d 100644
--- a/drivers/net/ethernet/engleder/Kconfig
+++ b/drivers/net/ethernet/engleder/Kconfig
@@ -32,6 +32,7 @@ config TSNEP_SELFTESTS
 	bool "TSN endpoint self test support"
 	default n
 	depends on TSNEP
+	imply NET_SELFTESTS
 	help
 	  This enables self test support within the TSN endpoint driver.
 
diff --git a/drivers/net/ethernet/engleder/tsnep_selftests.c b/drivers/net/ethernet/engleder/tsnep_selftests.c
index 8a9145f93147..c9857e5a8033 100644
--- a/drivers/net/ethernet/engleder/tsnep_selftests.c
+++ b/drivers/net/ethernet/engleder/tsnep_selftests.c
@@ -4,12 +4,15 @@
 #include "tsnep.h"
 
 #include <net/pkt_sched.h>
+#include <net/selftests.h>
 
 enum tsnep_test {
 	TSNEP_TEST_ENABLE = 0,
 	TSNEP_TEST_TAPRIO,
 	TSNEP_TEST_TAPRIO_CHANGE,
 	TSNEP_TEST_TAPRIO_EXTENSION,
+	TSNEP_TEST_PHY_1000_LOOPBACK,
+	TSNEP_TEST_PHY_100_LOOPBACK,
 };
 
 static const char tsnep_test_strings[][ETH_GSTRING_LEN] = {
@@ -17,6 +20,8 @@ static const char tsnep_test_strings[][ETH_GSTRING_LEN] = {
 	"TAPRIO                (offline)",
 	"TAPRIO change         (offline)",
 	"TAPRIO extension      (offline)",
+	"PHY 1000Mbps loopback (offline)",
+	"PHY 100Mbps loopback  (offline)",
 };
 
 #define TSNEP_TEST_COUNT (sizeof(tsnep_test_strings) / ETH_GSTRING_LEN)
@@ -754,6 +759,133 @@ static bool tsnep_test_taprio_extension(struct tsnep_adapter *adapter)
 	return false;
 }
 
+static bool test_loopback(struct tsnep_adapter *adapter, int speed)
+{
+	struct phy_device *phydev = adapter->phydev;
+	int retval;
+
+	retval = phy_loopback(phydev, true, speed);
+	if (retval || !phydev->loopback_enabled || !phydev->link ||
+	    phydev->speed != speed)
+		return false;
+
+	retval = net_test_phy_loopback_udp(adapter->netdev);
+	if (retval)
+		return false;
+
+	retval = net_test_phy_loopback_udp_mtu(adapter->netdev);
+	if (retval)
+		return false;
+
+	retval = net_test_phy_loopback_tcp(adapter->netdev);
+	if (retval)
+		return false;
+
+	retval = phy_loopback(phydev, false, 0);
+	if (retval || phydev->loopback_enabled)
+		return false;
+
+	return true;
+}
+
+static bool set_speed(struct tsnep_adapter *adapter, int speed)
+{
+	struct ethtool_link_ksettings cmd;
+	int retval;
+
+	retval = tsnep_ethtool_ops.get_link_ksettings(adapter->netdev, &cmd);
+	if (retval)
+		return false;
+
+	if (speed) {
+		cmd.base.speed = speed;
+		cmd.base.duplex = DUPLEX_FULL;
+		cmd.base.autoneg = AUTONEG_DISABLE;
+	} else {
+		cmd.base.autoneg = AUTONEG_ENABLE;
+	}
+
+	retval = tsnep_ethtool_ops.set_link_ksettings(adapter->netdev, &cmd);
+	if (retval)
+		return false;
+
+	return true;
+}
+
+static bool tsnep_test_phy_1000_loopback(struct tsnep_adapter *adapter)
+{
+	if (!adapter->netdev->phydev)
+		return false;
+
+	if (!test_loopback(adapter, 1000))
+		goto failed;
+
+	/* after autonegotiation */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!test_loopback(adapter, 1000))
+		goto failed;
+
+	/* after 100Mbps fixed speed */
+	if (!set_speed(adapter, 100))
+		goto failed;
+	if (!test_loopback(adapter, 1000))
+		goto failed;
+
+	/* after 1000Mbps fixed speed */
+	if (!set_speed(adapter, 1000))
+		goto failed;
+	if (!test_loopback(adapter, 1000))
+		goto failed;
+
+	if (!set_speed(adapter, 0))
+		goto failed;
+
+	return true;
+
+failed:
+	phy_loopback(adapter->phydev, false, 0);
+	set_speed(adapter, 0);
+	return false;
+}
+
+static bool tsnep_test_phy_100_loopback(struct tsnep_adapter *adapter)
+{
+	if (!adapter->netdev->phydev)
+		return false;
+
+	if (!test_loopback(adapter, 100))
+		goto failed;
+
+	/* after autonegotiation */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!test_loopback(adapter, 100))
+		goto failed;
+
+	/* 100Mbps fixed speed */
+	if (!set_speed(adapter, 100))
+		goto failed;
+	if (!test_loopback(adapter, 100))
+		goto failed;
+
+	/* 1000Mbps fixed speed */
+	if (!set_speed(adapter, 1000))
+		goto failed;
+	if (!test_loopback(adapter, 100))
+		goto failed;
+
+	if (!set_speed(adapter, 0))
+		goto failed;
+
+	return true;
+
+failed:
+	phy_loopback(adapter->phydev, false, 0);
+	set_speed(adapter, 0);
+	return false;
+}
+
 int tsnep_ethtool_get_test_count(void)
 {
 	return TSNEP_TEST_COUNT;
@@ -768,15 +900,14 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 			     struct ethtool_test *eth_test, u64 *data)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
+	int i;
 
 	eth_test->len = TSNEP_TEST_COUNT;
 
 	if (eth_test->flags != ETH_TEST_FL_OFFLINE) {
 		/* no tests are done online */
-		data[TSNEP_TEST_ENABLE] = 0;
-		data[TSNEP_TEST_TAPRIO] = 0;
-		data[TSNEP_TEST_TAPRIO_CHANGE] = 0;
-		data[TSNEP_TEST_TAPRIO_EXTENSION] = 0;
+		for (i = 0; i < TSNEP_TEST_COUNT; i++)
+			data[i] = 0;
 
 		return;
 	}
@@ -808,4 +939,18 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 		eth_test->flags |= ETH_TEST_FL_FAILED;
 		data[TSNEP_TEST_TAPRIO_EXTENSION] = 1;
 	}
+
+	if (tsnep_test_phy_1000_loopback(adapter)) {
+		data[TSNEP_TEST_PHY_1000_LOOPBACK] = 0;
+	} else {
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+		data[TSNEP_TEST_PHY_1000_LOOPBACK] = 1;
+	}
+
+	if (tsnep_test_phy_100_loopback(adapter)) {
+		data[TSNEP_TEST_PHY_100_LOOPBACK] = 0;
+	} else {
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+		data[TSNEP_TEST_PHY_100_LOOPBACK] = 1;
+	}
 }
-- 
2.39.5


