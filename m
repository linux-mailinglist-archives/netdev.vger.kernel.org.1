Return-Path: <netdev+bounces-170423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F3A48A72
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693A9188B0DB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA503270EC8;
	Thu, 27 Feb 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="wpTLl/+2"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30C270ED4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691607; cv=none; b=l9txEM8DJ7yfViVITP5waWqtmvIasFW10vmTOWpI/rQFBa5sY/MJRPBMrAOYdj+vRNDjXH+ubAdJAKQ/teRutBhg9Ac+D29jJDhQr/I17BKG01qHr6fNzMyuvhI3Y+3mm3y4V68Zsx53HGD4jjR0stuMZhZBKao6/iATkcp11l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691607; c=relaxed/simple;
	bh=05OOCTGqbqzms4vFMMs4+AUsEAMSiM/z04Et/ZtT0kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB4kFC2H/awx+lgOL3FOAD7NCV8lOocvTlPMbmHbNZ3bc56efBYbsV27vET14VHQMWeLl42AMrj0y+WPVZN+m3RgXO8SW7ojKhyCeWEmMtV/mJjVi/cYkdaCxeAt4MuJjg2PRpP2gsWTWwa67aE0J5D3kDhvWVhO9ceFtNP9Y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=wpTLl/+2; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ACASLdfQL3GBfLahuWvqtKWUOhF+EIQUWqOxtGmus7k=; b=wpTLl/+256dapxwRCt0fJqqrNM
	ABK18QSgvj87FuQW0/h1kcE7UMvtiIouMIM6cCkU+x66CQEauilKSiQZygB6/4QdUwE9S9V1F8G0V
	WkjCDGN3XbJCf76uxMdubPHwuJ565muz+KfqH7o8VXVu6EcAl2h1BYtwYDxwmZfLwx9A=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkXu-000000000iA-3X6Q;
	Thu, 27 Feb 2025 21:31:51 +0100
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
Subject: [PATCH net-next v9 6/8] net: selftests: Support selftest sets
Date: Thu, 27 Feb 2025 21:31:36 +0100
Message-Id: <20250227203138.60420-7-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227203138.60420-1-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Currently only one test set is supported. Extend selftests to support
multiple test sets with different speeds which can be combined by network
drivers.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/selftests.h |  27 +++++++
 net/core/selftests.c    | 171 ++++++++++++++++++++++++++--------------
 2 files changed, 141 insertions(+), 57 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e65e8d230d33..23721815f4bd 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -4,6 +4,14 @@
 
 #include <linux/ethtool.h>
 
+/**
+ * enum net_selftest - selftest set ID
+ * @NET_SELFTEST_LOOPBACK_CARRIER: Loopback tests based on carrier speed
+ */
+enum net_selftest {
+	NET_SELFTEST_LOOPBACK_CARRIER = 0,
+};
+
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
 
 void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
@@ -11,6 +19,11 @@ void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 int net_selftest_get_count(void);
 void net_selftest_get_strings(u8 *data);
 
+void net_selftest_set(int set, int speed, struct net_device *ndev,
+		      struct ethtool_test *etest, u64 *buf);
+int net_selftest_set_get_count(int set);
+void net_selftest_set_get_strings(int set, int speed, u8 **data);
+
 #else
 
 static inline void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
@@ -27,5 +40,19 @@ static inline void net_selftest_get_strings(u8 *data)
 {
 }
 
+static inline void net_selftest_set(int set, int speed, struct net_device *ndev,
+				    struct ethtool_test *etest, u64 *buf)
+{
+}
+
+static inline int net_selftest_set_get_count(int set)
+{
+	return 0;
+}
+
+static inline void net_selftest_set_get_strings(int set, int speed, u8 **data)
+{
+}
+
 #endif
 #endif /* _NET_SELFTESTS */
diff --git a/net/core/selftests.c b/net/core/selftests.c
index e99ae983fca9..ec9bb149a378 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -14,6 +14,10 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 
+struct net_test_ctx {
+	u8 next_id;
+};
+
 struct net_packet_attrs {
 	const unsigned char *src;
 	const unsigned char *dst;
@@ -44,14 +48,13 @@ struct netsfhdr {
 	u8 id;
 } __packed;
 
-static u8 net_test_next_id;
-
 #define NET_TEST_PKT_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
 			   sizeof(struct netsfhdr))
 #define NET_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
 #define NET_LB_TIMEOUT		msecs_to_jiffies(200)
 
-static struct sk_buff *net_test_get_skb(struct net_device *ndev,
+static struct sk_buff *net_test_get_skb(struct net_test_ctx *ctx,
+					struct net_device *ndev,
 					struct net_packet_attrs *attr)
 {
 	struct sk_buff *skb = NULL;
@@ -141,8 +144,8 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	shdr = skb_put(skb, sizeof(*shdr));
 	shdr->version = 0;
 	shdr->magic = cpu_to_be64(NET_TEST_PKT_MAGIC);
-	attr->id = net_test_next_id;
-	shdr->id = net_test_next_id++;
+	attr->id = ctx->next_id;
+	shdr->id = ctx->next_id++;
 
 	if (attr->size)
 		skb_put(skb, attr->size);
@@ -237,7 +240,8 @@ static int net_test_loopback_validate(struct sk_buff *skb,
 	return 0;
 }
 
-static int __net_test_loopback(struct net_device *ndev,
+static int __net_test_loopback(struct net_test_ctx *ctx,
+			       struct net_device *ndev,
 			       struct net_packet_attrs *attr)
 {
 	struct net_test_priv *tpriv;
@@ -258,7 +262,7 @@ static int __net_test_loopback(struct net_device *ndev,
 	tpriv->packet = attr;
 	dev_add_pack(&tpriv->pt);
 
-	skb = net_test_get_skb(ndev, attr);
+	skb = net_test_get_skb(ctx, ndev, attr);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -284,17 +288,40 @@ static int __net_test_loopback(struct net_device *ndev,
 	return ret;
 }
 
-static int net_test_netif_carrier(struct net_device *ndev)
+struct net_test {
+	const char *name;
+	int (*fn)(struct net_test_ctx *ctx, struct net_device *ndev);
+};
+
+/**
+ * NET_SELFTEST - Define a selftest.
+ * @_name: Selftest name.
+ * @_string: Selftest string.
+ */
+#define NET_SELFTEST(_name, _string)		\
+	struct net_test net_test_##_name = {	\
+		.name = _string,		\
+		.fn = net_test_##_name##_fn,	\
+	}
+
+static int net_test_netif_carrier_fn(struct net_test_ctx *ctx,
+				     struct net_device *ndev)
 {
 	return netif_carrier_ok(ndev) ? 0 : -ENOLINK;
 }
 
-static int net_test_phy_phydev(struct net_device *ndev)
+static const NET_SELFTEST(netif_carrier, "Carrier");
+
+static int net_test_phy_phydev_fn(struct net_test_ctx *ctx,
+				  struct net_device *ndev)
 {
 	return ndev->phydev ? 0 : -EOPNOTSUPP;
 }
 
-static int net_test_phy_loopback_enable(struct net_device *ndev)
+static const NET_SELFTEST(phy_phydev, "PHY dev is present");
+
+static int net_test_phy_loopback_enable_fn(struct net_test_ctx *ctx,
+					   struct net_device *ndev)
 {
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
@@ -302,7 +329,10 @@ static int net_test_phy_loopback_enable(struct net_device *ndev)
 	return phy_loopback(ndev->phydev, true, 0);
 }
 
-static int net_test_phy_loopback_disable(struct net_device *ndev)
+static const NET_SELFTEST(phy_loopback_enable, "PHY loopback enable");
+
+static int net_test_phy_loopback_disable_fn(struct net_test_ctx *ctx,
+					    struct net_device *ndev)
 {
 	if (!ndev->phydev)
 		return -EOPNOTSUPP;
@@ -310,98 +340,125 @@ static int net_test_phy_loopback_disable(struct net_device *ndev)
 	return phy_loopback(ndev->phydev, false, 0);
 }
 
-static int net_test_phy_loopback_udp(struct net_device *ndev)
+static const NET_SELFTEST(phy_loopback_disable, "PHY loopback disable");
+
+static int net_test_phy_loopback_udp_fn(struct net_test_ctx *ctx,
+					struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
-	return __net_test_loopback(ndev, &attr);
+	return __net_test_loopback(ctx, ndev, &attr);
 }
 
-static int net_test_phy_loopback_udp_mtu(struct net_device *ndev)
+static const NET_SELFTEST(phy_loopback_udp, "PHY loopback UDP");
+
+static int net_test_phy_loopback_udp_mtu_fn(struct net_test_ctx *ctx,
+					    struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
 	attr.max_size = ndev->mtu;
-	return __net_test_loopback(ndev, &attr);
+	return __net_test_loopback(ctx, ndev, &attr);
 }
 
-static int net_test_phy_loopback_tcp(struct net_device *ndev)
+static const NET_SELFTEST(phy_loopback_udp_mtu, "PHY loopback MTU");
+
+static int net_test_phy_loopback_tcp_fn(struct net_test_ctx *ctx,
+					struct net_device *ndev)
 {
 	struct net_packet_attrs attr = { };
 
 	attr.dst = ndev->dev_addr;
 	attr.tcp = true;
-	return __net_test_loopback(ndev, &attr);
+	return __net_test_loopback(ctx, ndev, &attr);
 }
 
-static const struct net_test {
-	char name[ETH_GSTRING_LEN];
-	int (*fn)(struct net_device *ndev);
-} net_selftests[] = {
-	{
-		.name = "Carrier                       ",
-		.fn = net_test_netif_carrier,
-	}, {
-		.name = "PHY dev is present            ",
-		.fn = net_test_phy_phydev,
-	}, {
-		/* This test should be done before all PHY loopback test */
-		.name = "PHY internal loopback, enable ",
-		.fn = net_test_phy_loopback_enable,
-	}, {
-		.name = "PHY internal loopback, UDP    ",
-		.fn = net_test_phy_loopback_udp,
-	}, {
-		.name = "PHY internal loopback, MTU    ",
-		.fn = net_test_phy_loopback_udp_mtu,
-	}, {
-		.name = "PHY internal loopback, TCP    ",
-		.fn = net_test_phy_loopback_tcp,
-	}, {
-		/* This test should be done after all PHY loopback test */
-		.name = "PHY internal loopback, disable",
-		.fn = net_test_phy_loopback_disable,
-	},
+static const NET_SELFTEST(phy_loopback_tcp, "PHY loopback TCP");
+
+static const struct net_test *net_selftests_carrier[] = {
+	&net_test_netif_carrier,
+	&net_test_phy_phydev,
+	&net_test_phy_loopback_enable,
+	&net_test_phy_loopback_udp,
+	&net_test_phy_loopback_udp_mtu,
+	&net_test_phy_loopback_tcp,
+	&net_test_phy_loopback_disable,
 };
 
-void net_selftest(struct net_device *ndev, struct ethtool_test *etest, u64 *buf)
+static const struct net_test **net_selftests_set_get(int set)
 {
-	int count = net_selftest_get_count();
+	switch (set) {
+	case NET_SELFTEST_LOOPBACK_CARRIER:
+		return net_selftests_carrier;
+	}
+
+	return NULL;
+}
+
+void net_selftest_set(int set, int speed, struct net_device *ndev,
+		      struct ethtool_test *etest, u64 *buf)
+{
+	const struct net_test **selftests = net_selftests_set_get(set);
+	int count = net_selftest_set_get_count(set);
+	struct net_test_ctx ctx = { 0 };
 	int i;
 
 	memset(buf, 0, sizeof(*buf) * count);
-	net_test_next_id = 0;
 
-	if (etest->flags != ETH_TEST_FL_OFFLINE) {
+	if (!(etest->flags & ETH_TEST_FL_OFFLINE)) {
 		netdev_err(ndev, "Only offline tests are supported\n");
 		etest->flags |= ETH_TEST_FL_FAILED;
 		return;
 	}
 
-
 	for (i = 0; i < count; i++) {
-		buf[i] = net_selftests[i].fn(ndev);
+		buf[i] = selftests[i]->fn(&ctx, ndev);
 		if (buf[i] && (buf[i] != -EOPNOTSUPP))
 			etest->flags |= ETH_TEST_FL_FAILED;
 	}
 }
+EXPORT_SYMBOL_GPL(net_selftest_set);
+
+int net_selftest_set_get_count(int set)
+{
+	switch (set) {
+	case NET_SELFTEST_LOOPBACK_CARRIER:
+		return ARRAY_SIZE(net_selftests_carrier);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(net_selftest_set_get_count);
+
+void net_selftest_set_get_strings(int set, int speed, u8 **data)
+{
+	const struct net_test **selftests = net_selftests_set_get(set);
+	int count = net_selftest_set_get_count(set);
+	int i;
+
+	/* right pad strings for aligned ethtool output */
+	for (i = 0; i < count; i++)
+		ethtool_sprintf(data, "%-30s", selftests[i]->name);
+}
+EXPORT_SYMBOL_GPL(net_selftest_set_get_strings);
+
+void net_selftest(struct net_device *ndev, struct ethtool_test *etest, u64 *buf)
+{
+	net_selftest_set(NET_SELFTEST_LOOPBACK_CARRIER, 0, ndev, etest, buf);
+}
 EXPORT_SYMBOL_GPL(net_selftest);
 
 int net_selftest_get_count(void)
 {
-	return ARRAY_SIZE(net_selftests);
+	return net_selftest_set_get_count(NET_SELFTEST_LOOPBACK_CARRIER);
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_count);
 
 void net_selftest_get_strings(u8 *data)
 {
-	int i;
-
-	for (i = 0; i < net_selftest_get_count(); i++)
-		ethtool_sprintf(&data, "%2d. %s", i + 1,
-				net_selftests[i].name);
+	net_selftest_set_get_strings(NET_SELFTEST_LOOPBACK_CARRIER, 0, &data);
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
-- 
2.39.5


