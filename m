Return-Path: <netdev+bounces-167847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA01A3C905
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1943B2183
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F122AE42;
	Wed, 19 Feb 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="s1WyTNsh"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFA21C9E5
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994152; cv=none; b=qPc3LIO7WvvQeDVcagV28Q+yY9WJCjxccwra9DpBsHkyXyVcZQ6A/+H1WQa6Iwq3M8z0EHgn2iQAl3veEDaWbKOqxLTPJ718lrbEs5oTLaucgygJVUGDKMFID0xALBE7KUbfQN6eXJWG4X3hkKO/MUWS/HuLtY9yBlsCDizk2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994152; c=relaxed/simple;
	bh=+pvgzGgR29YlwgpcA1b3/w29dCZWpHGbhvKDb9QYVOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4RlHbgD1psZmRXCmbqWdfEnVl8RIc0b0vAAtqei5X/VmRYkg/+93ZbLKhxGgpGnqzcCzQzz6HipJjO/x0WUdqsBXFqbWj8LYTM1hDFvb+SVKaMhtX2LhsFfXbXeIukDQPlbI3S8yKBBUuLlJm/GPuOdoi1KufZNRU0slI8CZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=s1WyTNsh; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SppyZ9N4iBYEdqDLftkZGDqyE3Ludi9Aj2kWbyOUpBw=; b=s1WyTNshRj1Ay0oowX/U4pCCCW
	xL0sLr2Ped+9JrlxVtn8gYWWyzOoHYyNpUqHHEaDvYb6xiZ1IuQLZrKxpjzrqEt6i8CvTl+GCAqJv
	6rIuUmPCv5koJ3a1Oye77CSCREydUXJyWSazDWyOC1RXlmRslwX+PxW2YpROnBlcfBnI=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tkpxj-000000003mi-1WUX;
	Wed, 19 Feb 2025 20:42:27 +0100
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
Subject: [PATCH net-next v7 7/8] net: selftests: Add selftests sets with fixed speed
Date: Wed, 19 Feb 2025 20:42:12 +0100
Message-Id: <20250219194213.10448-8-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219194213.10448-1-gerhard@engleder-embedded.com>
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Add PHY loopback selftest sets with fixed 100 Mbps and 1000 Mbps speed.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 include/net/selftests.h |  4 ++++
 net/core/selftests.c    | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index a3e9bb959e3d..ba781fa6249a 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -7,9 +7,13 @@
 /**
  * enum net_selftest_set - selftest set ID
  * @NET_SELFTEST_CARRIER: Loopback tests based on carrier speed
+ * @NET_SELFTEST_100: Loopback tests with 100 Mbps
+ * @NET_SELFTEST_1000: Loopback tests with 1000 Mbps
  */
 enum net_selftest_set {
 	NET_TEST_LOOPBACK_CARRIER = 0,
+	NET_TEST_LOOPBACK_100,
+	NET_TEST_LOOPBACK_1000,
 };
 
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 3a597a38566e..3149bd1f15d3 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -324,6 +324,26 @@ static int net_test_phy_loopback_enable_fn(struct net_device *ndev)
 
 static const NET_TEST(phy_loopback_enable, "PHY loopback enable");
 
+static int net_test_phy_loopback_100_enable_fn(struct net_device *ndev)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_loopback(ndev->phydev, true, 100);
+}
+
+static const NET_TEST(phy_loopback_100_enable, "PHY loopback 100 Mbps");
+
+static int net_test_phy_loopback_1000_enable_fn(struct net_device *ndev)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_loopback(ndev->phydev, true, 1000);
+}
+
+static const NET_TEST(phy_loopback_1000_enable, "PHY loopback 1000 Mbps");
+
 static int net_test_phy_loopback_disable_fn(struct net_device *ndev)
 {
 	if (!ndev->phydev)
@@ -376,11 +396,33 @@ static const struct net_test *net_selftests_carrier[] = {
 	&net_test_phy_loopback_disable,
 };
 
+static const struct net_test *net_selftests_100[] = {
+	&net_test_phy_phydev,
+	&net_test_phy_loopback_100_enable,
+	&net_test_phy_loopback_udp,
+	&net_test_phy_loopback_udp_mtu,
+	&net_test_phy_loopback_tcp,
+	&net_test_phy_loopback_disable,
+};
+
+static const struct net_test *net_selftests_1000[] = {
+	&net_test_phy_phydev,
+	&net_test_phy_loopback_1000_enable,
+	&net_test_phy_loopback_udp,
+	&net_test_phy_loopback_udp_mtu,
+	&net_test_phy_loopback_tcp,
+	&net_test_phy_loopback_disable,
+};
+
 static const struct net_test **net_selftests_set_get(int set)
 {
 	switch (set) {
 	case NET_TEST_LOOPBACK_CARRIER:
 		return net_selftests_carrier;
+	case NET_TEST_LOOPBACK_100:
+		return net_selftests_100;
+	case NET_TEST_LOOPBACK_1000:
+		return net_selftests_1000;
 	}
 
 	return NULL;
@@ -415,6 +457,10 @@ int net_selftest_set_get_count(int set)
 	switch (set) {
 	case NET_TEST_LOOPBACK_CARRIER:
 		return ARRAY_SIZE(net_selftests_carrier);
+	case NET_TEST_LOOPBACK_100:
+		return ARRAY_SIZE(net_selftests_100);
+	case NET_TEST_LOOPBACK_1000:
+		return ARRAY_SIZE(net_selftests_1000);
 	default:
 		return -EINVAL;
 	}
-- 
2.39.5


