Return-Path: <netdev+bounces-169196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A50A42ECB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B341C1892429
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46971DDC18;
	Mon, 24 Feb 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="v1qS+TuY"
X-Original-To: netdev@vger.kernel.org
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA781DDA00
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431759; cv=none; b=czwdwSB23l2VBbotsOaV9DtG0c8JsRGa4MDT3jrGyuciPaOYtDUOPtYBCV5FmMK7k8O9G7oRi0uA7zMvILf8wFGspJ8Sa/g/rdhHUP1u4bEoTcuGyTcVUmsf6iiGh+ZShw15eXwbCYvstEQVAiIgelKFlOUKoN6PD9V4jjOB0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431759; c=relaxed/simple;
	bh=JG88TSCoxq8ilYitRgQ6gzdrooc5CgxUsszDiKez0Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/OcVfr1E9DfZxqM/rtgvnNLpOSz9OHxYK7xnbnAVpTlUaYjv/D9ovlXprjlcIp8ZStPwCIxE6aggeVGCmKx8Z5T+pcK+RvBXdWSHi8twFDYclwsXWg00Hrna06iFfxUkQhrHubqMRuJ8wN8iaJ4DIckYsOwVx3i9NI2X+HJmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=v1qS+TuY; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z0YkePKYmtexFo833UA8Awy1Dlr6/NsKbPPZaF3Qjz0=; b=v1qS+TuY4ckiyb6OUee4MuhHOY
	kV30rNsfgAHrM1wSwLyXIq/44ZNwAdNcZsyHaxiblu+y2v+JyGqUmXr6/Ty+0dSGw5DsjSo3WKTqe
	9cBxUaqJhB/53hVHsCixmA8o+/5tXV1WTBSVydpSBG2//TDM6pNqfV31S4TxocDlFpxo=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tmfnu-000000000wu-1Vt2;
	Mon, 24 Feb 2025 22:15:54 +0100
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
Subject: [PATCH net-next v8 7/8] net: selftests: Add selftests sets with fixed speed
Date: Mon, 24 Feb 2025 22:15:30 +0100
Message-Id: <20250224211531.115980-8-gerhard@engleder-embedded.com>
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

Add PHY loopback selftest set which uses the speed argument to select a
fixed speed.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 include/net/selftests.h |  2 ++
 net/core/selftests.c    | 46 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e97aaebaf51a..d9450c0352a4 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -7,9 +7,11 @@
 /**
  * enum net_selftest - selftest set ID
  * @NET_SELFTEST_LOOPBACK_CARRIER: Loopback tests based on carrier speed
+ * @NET_SELFTEST_LOOPBACK_SPEED: Loopback tests with fixed speed
  */
 enum net_selftest {
 	NET_SELFTEST_LOOPBACK_CARRIER = 0,
+	NET_SELFTEST_LOOPBACK_SPEED,
 };
 
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 4a7022a1e931..b6ad711136b4 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -16,6 +16,7 @@
 
 struct net_test_ctx {
 	u8 next_id;
+	int speed;
 };
 
 struct net_packet_attrs {
@@ -305,6 +306,16 @@ struct net_test {
 		.fn = net_test_##_name##_fn,	\
 	}
 
+/**
+ * NET_SELFTEST_LOOPBACK_SPEED - Define a selftest which enables loopback with a fixed speed.
+ * @_name: Selftest name.
+ */
+#define NET_SELFTEST_LOOPBACK_SPEED(_name)	\
+	struct net_test net_test_##_name = {	\
+		.fn = net_test_##_name##_fn,	\
+		.loopback_speed = true,		\
+	}
+
 static int net_test_netif_carrier_fn(struct net_test_ctx *ctx,
 				     struct net_device *ndev)
 {
@@ -332,6 +343,17 @@ static int net_test_phy_loopback_enable_fn(struct net_test_ctx *ctx,
 
 static const NET_SELFTEST(phy_loopback_enable, "PHY loopback enable");
 
+static int net_test_phy_loopback_speed_enable_fn(struct net_test_ctx *ctx,
+						 struct net_device *ndev)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_loopback(ndev->phydev, true, ctx->speed);
+}
+
+static const NET_SELFTEST_LOOPBACK_SPEED(phy_loopback_speed_enable);
+
 static int net_test_phy_loopback_disable_fn(struct net_test_ctx *ctx,
 					    struct net_device *ndev)
 {
@@ -388,11 +410,22 @@ static const struct net_test *net_selftests_carrier[] = {
 	&net_test_phy_loopback_disable,
 };
 
+static const struct net_test *net_selftests_speed[] = {
+	&net_test_phy_phydev,
+	&net_test_phy_loopback_speed_enable,
+	&net_test_phy_loopback_udp,
+	&net_test_phy_loopback_udp_mtu,
+	&net_test_phy_loopback_tcp,
+	&net_test_phy_loopback_disable,
+};
+
 static const struct net_test **net_selftests_set_get(int set)
 {
 	switch (set) {
 	case NET_SELFTEST_LOOPBACK_CARRIER:
 		return net_selftests_carrier;
+	case NET_SELFTEST_LOOPBACK_SPEED:
+		return net_selftests_speed;
 	}
 
 	return NULL;
@@ -403,7 +436,7 @@ void net_selftest_set(int set, int speed, struct net_device *ndev,
 {
 	const struct net_test **selftests = net_selftests_set_get(set);
 	int count = net_selftest_set_get_count(set);
-	struct net_test_ctx ctx = { 0 };
+	struct net_test_ctx ctx = { .speed = speed };
 	int i;
 
 	memset(buf, 0, sizeof(*buf) * count);
@@ -427,6 +460,8 @@ int net_selftest_set_get_count(int set)
 	switch (set) {
 	case NET_SELFTEST_LOOPBACK_CARRIER:
 		return ARRAY_SIZE(net_selftests_carrier);
+	case NET_SELFTEST_LOOPBACK_SPEED:
+		return ARRAY_SIZE(net_selftests_speed);
 	default:
 		return -EINVAL;
 	}
@@ -440,8 +475,13 @@ void net_selftest_set_get_strings(int set, int speed, u8 **data)
 	int i;
 
 	/* right pad strings for aligned ethtool output */
-	for (i = 0; i < count; i++)
-		ethtool_sprintf(data, "%-30s", selftests[i]->name);
+	for (i = 0; i < count; i++) {
+		if (selftests[i]->loopback_speed)
+			ethtool_sprintf(data, "PHY loopback %-17s",
+					phy_speed_to_str(speed));
+		else
+			ethtool_sprintf(data, "%-30s", selftests[i]->name);
+	}
 }
 EXPORT_SYMBOL_GPL(net_selftest_set_get_strings);
 
-- 
2.39.5


