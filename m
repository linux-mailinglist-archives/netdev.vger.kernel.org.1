Return-Path: <netdev+bounces-157188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F1A0944F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2A17A45B3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AA2116E0;
	Fri, 10 Jan 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="NhZLACGx"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E382116FA
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520536; cv=none; b=JDpCHbXWvZa9+xSugNxnRA93G6kjNBPjxhv4F1SsSfTXM3blPaEjCFag7T2/kFpARN6lqG5j4tBKskOHa44XeofhBreqVEZodUlbdKxCFr3oyRfa/y4s1M16YAC2yTz8UvQlNbkflU1W7ycig5cShXjyZqiIH/Xm8xPyRStajvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520536; c=relaxed/simple;
	bh=RP4iAOMiYWPmZfvfi6JYM5Rulo7FN1lLtRDLhDzde+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhazEDzcyPo//tTS7fuh9xnLgLE3feOTC8G7Q0xlEr39dDZnkDIT7Jbt5axLm4RwoNsw5Rjsyod0NNbbC7MtSMg/x4rwJsE2R1Qg0cP6ej4t+0OnLL9f4R0WdwuLMfOqbCd0BS3w5ZuiqPGS1HuCIDVHzvfkuBNun/LqS97Iivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=NhZLACGx; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qiXKnp0/R+VzL4hPDH8IkATHqdh0qsfStNlOsPcKIRU=; b=NhZLACGx73zd1dSQ5+MF8Dgnc9
	+GS/TFsZarABSUsM6T7qzRK6eiFkY0MHkLuxnidXKMP/w8J0NQ5gndz//BgZfCsv6xqijO1QfcKaO
	WRM6RMSDUQqDEvy6C6TGsySD1AzhNpig9RBLAtb8Dw8p3wXXhgbFzoHZIMY6ZLEfKzgY=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWGJe-000000006oP-3EN2;
	Fri, 10 Jan 2025 15:48:50 +0100
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
Subject: [PATCH net-next v2 5/5] tsnep: Add PHY loopback selftests
Date: Fri, 10 Jan 2025 15:48:28 +0100
Message-Id: <20250110144828.4943-6-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110144828.4943-1-gerhard@engleder-embedded.com>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
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
 .../net/ethernet/engleder/tsnep_selftests.c   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep_selftests.c b/drivers/net/ethernet/engleder/tsnep_selftests.c
index 8a9145f93147..0a3f92ac35cd 100644
--- a/drivers/net/ethernet/engleder/tsnep_selftests.c
+++ b/drivers/net/ethernet/engleder/tsnep_selftests.c
@@ -10,6 +10,7 @@ enum tsnep_test {
 	TSNEP_TEST_TAPRIO,
 	TSNEP_TEST_TAPRIO_CHANGE,
 	TSNEP_TEST_TAPRIO_EXTENSION,
+	TSNEP_TEST_PHY_LOOPBACK,
 };
 
 static const char tsnep_test_strings[][ETH_GSTRING_LEN] = {
@@ -17,6 +18,7 @@ static const char tsnep_test_strings[][ETH_GSTRING_LEN] = {
 	"TAPRIO                (offline)",
 	"TAPRIO change         (offline)",
 	"TAPRIO extension      (offline)",
+	"PHY loopback          (offline)",
 };
 
 #define TSNEP_TEST_COUNT (sizeof(tsnep_test_strings) / ETH_GSTRING_LEN)
@@ -754,6 +756,98 @@ static bool tsnep_test_taprio_extension(struct tsnep_adapter *adapter)
 	return false;
 }
 
+static bool loopback(struct tsnep_adapter *adapter, int speed)
+{
+	struct phy_device *phydev = adapter->phydev;
+	int retval;
+
+	retval = phy_loopback(phydev, true, speed);
+	if (retval || !phydev->loopback_enabled || !phydev->link || phydev->speed != speed)
+		return false;
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
+static bool tsnep_test_phy_loopback(struct tsnep_adapter *adapter)
+{
+	/* 1000Mbps loopback */
+	if (!loopback(adapter, 1000))
+		goto failed;
+
+	/* 100Mbps loopback */
+	if (!loopback(adapter, 100))
+		goto failed;
+
+	/* 1000Mbps loopback after autonegotiation */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 1000))
+		goto failed;
+
+	/* 100Mbps loopback after autonegotiation */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 100))
+		goto failed;
+
+	/* 1000Mbps loopback after 100Mbps fixed speed */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 1000))
+		goto failed;
+
+	/* 100Mbps loopback after 100Mbps fixed speed */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 100))
+		goto failed;
+
+	/* 1000Mbps loopback after 1000Mbps fixed speed */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 1000))
+		goto failed;
+
+	/* 100Mbps loopback after 1000Mbps fixed speed */
+	if (!set_speed(adapter, 0))
+		goto failed;
+	if (!loopback(adapter, 100))
+		goto failed;
+
+	return true;
+
+failed:
+	phy_loopback(adapter->phydev, false, 0);
+	return false;
+}
+
 int tsnep_ethtool_get_test_count(void)
 {
 	return TSNEP_TEST_COUNT;
@@ -777,6 +871,7 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 		data[TSNEP_TEST_TAPRIO] = 0;
 		data[TSNEP_TEST_TAPRIO_CHANGE] = 0;
 		data[TSNEP_TEST_TAPRIO_EXTENSION] = 0;
+		data[TSNEP_TEST_PHY_LOOPBACK] = 0;
 
 		return;
 	}
@@ -808,4 +903,11 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 		eth_test->flags |= ETH_TEST_FL_FAILED;
 		data[TSNEP_TEST_TAPRIO_EXTENSION] = 1;
 	}
+
+	if (tsnep_test_phy_loopback(adapter)) {
+		data[TSNEP_TEST_PHY_LOOPBACK] = 0;
+	} else {
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+		data[TSNEP_TEST_PHY_LOOPBACK] = 1;
+	}
 }
-- 
2.39.5


