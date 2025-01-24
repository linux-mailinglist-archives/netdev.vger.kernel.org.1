Return-Path: <netdev+bounces-160864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38EA1BE4B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFAC3A24FF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC51E9913;
	Fri, 24 Jan 2025 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TirayajO"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161B1EEA28
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756346; cv=none; b=uvNsoswpJXOzDoc5gN01njLSh+TiTPJER4mx7y1sg3EacoXJupqZTOcVznUCeL+hIdcwaZtbo2zPa7C7lpculphG4IC7p+SQ96vwzmIaBK7bFLtRd6mqN+rEGtGTdmwlM/Hr7D5mykf0++/2Do1i2iyFR26KxYH+nfVuHM3Pwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756346; c=relaxed/simple;
	bh=dfQP0WoauTKb6Py4vcA/XMasi9saWi6X8ysSGiKYQFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s248ANkuCrRo+m7LNtQV8/rSFXI4EE7S76JMXOFYr/vjJEoXSUurzJ8eonNZvVL5aKBG5+pHiEKuMRZn06AncOT1vV1DByYuqD+VIUbW/wX8DCT2X5oIUYxSV8uUpPAYRpGDEg6XC3sbmFmq1c/cRFGpAoSBV2qS5g4jc8884x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TirayajO; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MPpfoW73ud7QEvlwLua4h4ohdG+Bz8uoUYyGfb35tvM=; b=TirayajOP+NDxzOovgqTGAzAAz
	m41BH4GLYIyptrXRujJDIelm8z7YlmymMgdGKrpTQ37d6iptaouzw/JOWq/JUZ9Xvz+l6w5cZT3eH
	UCPVY8Vt89HMGbubSMEAD7ZLjgusjUGU2od5jF+UYUae91TVcVnpqVhnKnGOXtsArnQE=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tbRo5-000000005Ng-1VsY;
	Fri, 24 Jan 2025 23:05:41 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [RFC PATCH net-next v3 6/7] net: selftests: Export net_test_phy_loopback_*
Date: Fri, 24 Jan 2025 23:05:15 +0100
Message-Id: <20250124220516.113798-7-gerhard@engleder-embedded.com>
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

net_selftests() provides a generic set of selftests for netdevs with
PHY. Those selftests rely on an existing link to inherit the speed for
the loopback mode.

net_selftests() is not designed to extend existing selftests of drivers,
but with net_test_phy_loopback_* it contains useful test infrastructure.

Export net_test_phy_loopback_* to enable reuse in existing selftests of
other drivers. This also enables driver specific loopback modes, which
don't rely on an existing link.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/selftests.h | 19 +++++++++++++++++++
 net/core/selftests.c    |  9 ++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e65e8d230d33..38459af4962b 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -6,6 +6,10 @@
 
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
 
+int net_test_phy_loopback_udp(struct net_device *ndev);
+int net_test_phy_loopback_udp_mtu(struct net_device *ndev);
+int net_test_phy_loopback_tcp(struct net_device *ndev);
+
 void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 		  u64 *buf);
 int net_selftest_get_count(void);
@@ -13,6 +17,21 @@ void net_selftest_get_strings(u8 *data);
 
 #else
 
+static inline int net_test_phy_loopback_udp(struct net_device *ndev)
+{
+	return 0;
+}
+
+static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
+{
+	return 0;
+}
+
+static int net_test_phy_loopback_tcp(struct net_device *ndev)
+{
+	return 0;
+}
+
 static inline void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 				u64 *buf)
 {
diff --git a/net/core/selftests.c b/net/core/selftests.c
index e99ae983fca9..d4e0e2eff991 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -310,15 +310,16 @@ static int net_test_phy_loopback_disable(struct net_device *ndev)
 	return phy_loopback(ndev->phydev, false, 0);
 }
 
-static int net_test_phy_loopback_udp(struct net_device *ndev)
+int net_test_phy_loopback_udp(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
 	return __net_test_loopback(ndev, &attr);
 }
+EXPORT_SYMBOL_GPL(net_test_phy_loopback_udp);
 
-static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
+int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
@@ -326,8 +327,9 @@ static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
 	attr.max_size = ndev->mtu;
 	return __net_test_loopback(ndev, &attr);
 }
+EXPORT_SYMBOL_GPL(net_test_phy_loopback_udp_mtu);
 
-static int net_test_phy_loopback_tcp(struct net_device *ndev)
+int net_test_phy_loopback_tcp(struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
@@ -335,6 +337,7 @@ static int net_test_phy_loopback_tcp(struct net_device *ndev)
 	attr.tcp = true;
 	return __net_test_loopback(ndev, &attr);
 }
+EXPORT_SYMBOL_GPL(net_test_phy_loopback_tcp);
 
 static const struct net_test {
 	char name[ETH_GSTRING_LEN];
-- 
2.39.5


