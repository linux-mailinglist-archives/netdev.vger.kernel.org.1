Return-Path: <netdev+bounces-163230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A73A29A2D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A673818836BD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C741FFC42;
	Wed,  5 Feb 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="v3/npVPq"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F95155335
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784093; cv=none; b=JxtSfz97F4g88E16OdUgzeLPNUlc2tUZKYwUp6mrDhUOxPsmUmZO8NayCRVGmHCIzbX2YMTemz0JbM2q03uZ+Dir+tJWUjf9n7VtgOYEZrEsfMiD4n+UtO35Fdzsrkk6ArvXjb7kujDLDihoWv2RH0QHu7mwr8uNYltFKvUuHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784093; c=relaxed/simple;
	bh=Vf6MgmQ+cAB6pVE6LuQE1Hci2f1mTFwxqKsctMTF6Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0G/TMT2eNh7V4p+cErGqLuEoi9j4SOd0SuXckmzr5r+34QHyrLCDqZdBsU7liPLggUmkOZoQQZZk3lAk0uB5zmr1R+yhrSD31sp3kX6fKosZN7FjPVSYOJ3o4IBM1dD5uRCih8opARBP9XIXTzTcLiFQPXwGvWE+CTeuCzFAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=v3/npVPq; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d00kdXkxGzpJFasIUHuiHU8O5NvLGRgMg5n39bdQfn4=; b=v3/npVPqTpDoGhOUsW3Cr3eyGa
	EDPgdk3bJwLYOKUrYgw9bfpdZOQggpCZir80/gah7mBGWlxbTc/LnJ7X1aA20jAgT2nRjJRCiMkvP
	GBPB9eEEfBe5WrDvm+/ONo4ZP7nvBBO7etiUWwLuNYE9ayb1pwWZMnaZ9FrwkeAMBQ2k=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfklH-0000000017b-0Gmq;
	Wed, 05 Feb 2025 20:08:36 +0100
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
Subject: [PATCH net-next v5 6/7] net: selftests: Export net_test_phy_loopback_*
Date: Wed,  5 Feb 2025 20:08:22 +0100
Message-Id: <20250205190823.23528-7-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205190823.23528-1-gerhard@engleder-embedded.com>
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
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
index e65e8d230d33..a13237c33e58 100644
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
+static inline int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
+{
+	return 0;
+}
+
+static inline int net_test_phy_loopback_tcp(struct net_device *ndev)
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


