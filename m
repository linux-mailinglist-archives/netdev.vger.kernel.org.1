Return-Path: <netdev+bounces-184378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B7A951F8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E17A4701
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFD266F0D;
	Mon, 21 Apr 2025 13:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61126560F;
	Mon, 21 Apr 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243444; cv=none; b=rwHpu5eqBp3GUi7+z6HZhnX8nH+PZMGedITNFlUd8v1XHjBL4F/MIk7gmz/NK8qQj0HmHKKXyFyiWADOaG2wXSmHNtjsngM0yNgr5oDRKIhcujS1zosFd43dM/1vQS1zQAF0iVJuODRgVE0pBIGvRWTy0Uki+H5PEg509ehxWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243444; c=relaxed/simple;
	bh=7SD9ZhbVN138LPMEg8v/knYXG+Np5pyV2+V8KFGcnb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZUprKn+7/tm6h7wh9EvbEsHFNQaG1ubb2iNMqIXci3ZrRJR5djZUvl5a+mRCOaoGePvbQFNTPJQ3IS6i8DaM0AFgt7xpuStxvhVnktXL43pewFExdemDLOFXffGmEhvnsGXNr/1FRdQb8cmHqmjeOgJUAIL/hEsaTkd8bgXA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zh6CX0Z8bz1R7fH;
	Mon, 21 Apr 2025 21:48:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EFB18140119;
	Mon, 21 Apr 2025 21:50:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:50:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gerhard@engleder-embedded.com>,
	<shaojijie@huawei.com>
Subject: [PATCH RFC net-next 1/2] net: selftest: add net_selftest_custom() interface
Date: Mon, 21 Apr 2025 21:43:57 +0800
Message-ID: <20250421134358.1241851-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250421134358.1241851-1-shaojijie@huawei.com>
References: <20250421134358.1241851-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In net/core/selftests.c,
net_selftest() supports loopback tests.
However, the loopback content of this interface is a fixed common test
and cannot be expanded to add the driver's own test.

In this patch, the net_selftest_custom() interface is added
to support driver customized loopback tests and
extra common loopback tests.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 include/net/selftests.h |  61 +++++++++++++
 net/core/selftests.c    | 188 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 245 insertions(+), 4 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e65e8d230d33..a36e6ee0a41f 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -4,6 +4,48 @@
 
 #include <linux/ethtool.h>
 
+#define NET_TEST_NETIF_CARRIER		BIT(0)
+#define NET_TEST_FULL_DUPLEX		BIT(1)
+#define NET_TEST_TCP			BIT(2)
+#define NET_TEST_UDP			BIT(3)
+#define NET_TEST_UDP_MAX_MTU		BIT(4)
+
+#define NET_EXTRA_CARRIER_TEST		BIT(0)
+#define NET_EXTRA_FULL_DUPLEX_TEST	BIT(1)
+#define NET_EXTRA_PHY_TEST		BIT(2)
+
+struct net_test_entry {
+	char name[ETH_GSTRING_LEN];
+
+	/* can set to NULL */
+	int (*enable)(struct net_device *ndev, bool enable);
+
+	/* can set to NULL */
+	int (*fn)(struct net_device *ndev);
+
+	/* if flag is set, fn() will be ignored,
+	 * and will do test according to the flag,
+	 * such as NET_TEST_UDP...
+	 */
+	unsigned long flags;
+};
+
+#define NET_TEST_E(_name, _enable, _flags) { \
+	.name = _name, \
+	.enable = _enable, \
+	.fn = NULL, \
+	.flags = _flags }
+
+#define NET_TEST_ENTRY_MAX_COUNT	10
+struct net_test {
+	/* extra tests will be added based on this flag */
+	unsigned long extra_flags;
+
+	struct net_test_entry entries[NET_TEST_ENTRY_MAX_COUNT];
+	/* the count of entries, must <= NET_TEST_ENTRY_MAX_COUNT */
+	u32 count;
+};
+
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
 
 void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
@@ -11,6 +53,11 @@ void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 int net_selftest_get_count(void);
 void net_selftest_get_strings(u8 *data);
 
+void net_selftest_custom(struct net_device *ndev, const struct net_test *test,
+			 struct ethtool_test *etest, u64 *buf);
+int net_selftest_get_count_custom(const struct net_test *test);
+void net_selftest_get_strings_custom(const struct net_test *test, u8 *data);
+
 #else
 
 static inline void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
@@ -27,5 +74,19 @@ static inline void net_selftest_get_strings(u8 *data)
 {
 }
 
+void net_selftest_custom(struct net_device *ndev, struct net_test *test,
+			 struct ethtool_test *etest, u64 *buf)
+{
+}
+
+int net_selftest_get_count_custom(struct net_test *test)
+{
+	return 0;
+}
+
+void net_selftest_get_strings_custom(struct net_test *test, u8 *data)
+{
+}
+
 #endif
 #endif /* _NET_SELFTESTS */
diff --git a/net/core/selftests.c b/net/core/selftests.c
index e99ae983fca9..e6abae17f324 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -289,6 +289,11 @@ static int net_test_netif_carrier(struct net_device *ndev)
 	return netif_carrier_ok(ndev) ? 0 : -ENOLINK;
 }
 
+static int net_test_full_duplex(struct net_device *ndev)
+{
+	return ndev->phydev->duplex == DUPLEX_FULL ? 0 : -EINVAL;
+}
+
 static int net_test_phy_phydev(struct net_device *ndev)
 {
 	return ndev->phydev ? 0 : -EOPNOTSUPP;
@@ -336,10 +341,7 @@ static int net_test_phy_loopback_tcp(struct net_device *ndev)
 	return __net_test_loopback(ndev, &attr);
 }
 
-static const struct net_test {
-	char name[ETH_GSTRING_LEN];
-	int (*fn)(struct net_device *ndev);
-} net_selftests[] = {
+static const struct net_test_entry net_selftests[] = {
 	{
 		.name = "Carrier                       ",
 		.fn = net_test_netif_carrier,
@@ -405,6 +407,184 @@ void net_selftest_get_strings(u8 *data)
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
+static const struct net_do_test_func {
+	int flag;
+	int (*fn)(struct net_device *ndev);
+} net_do_test_funcs[] = {
+	{ NET_TEST_NETIF_CARRIER, net_test_netif_carrier },
+	{ NET_TEST_FULL_DUPLEX, net_test_full_duplex },
+	{ NET_TEST_UDP, net_test_phy_loopback_udp },
+	{ NET_TEST_TCP, net_test_phy_loopback_tcp },
+	{ NET_TEST_UDP_MAX_MTU, net_test_phy_loopback_udp_mtu },
+};
+
+static int net_do_test(struct net_device *ndev,
+		       const struct net_test_entry *entry)
+{
+	int ret = -EOPNOTSUPP;
+	u32 i;
+
+	if (!entry->flags && entry->fn)
+		return entry->fn(ndev);
+
+	for (i = 0; i < ARRAY_SIZE(net_do_test_funcs); i++) {
+		if (!(entry->flags & net_do_test_funcs[i].flag))
+			continue;
+
+		ret = net_do_test_funcs[i].fn(ndev);
+		if (ret) {
+			netdev_err(ndev, "failed to do test, bit: %#x\n",
+				   net_do_test_funcs[i].flag);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int net_selftest_entry(struct net_device *ndev,
+			      const struct net_test_entry *entry)
+{
+	int ret;
+
+	if (entry->enable) {
+		ret = entry->enable(ndev, true);
+		if (ret) {
+			netdev_err(ndev,
+				   "failed to enable test, ret = %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = net_do_test(ndev, entry);
+	if (entry->enable)
+		entry->enable(ndev, false);
+	return ret;
+}
+
+static void net_selftest_check_result(struct net_device *ndev,
+				      const struct net_test_entry *entry,
+				      struct ethtool_test *etest, u64 *result)
+{
+	*result = net_selftest_entry(ndev, entry);
+	if (*result)
+		etest->flags |= ETH_TEST_FL_FAILED;
+}
+
+static int net_test_prepare(struct net_device *ndev,
+			    const struct net_test *test,
+			    struct ethtool_test *etest, u64 *buf)
+{
+	u32 i;
+
+	/* first set all results to -ENOEXEC,
+	 * test->count is also checked in .net_selftest_get_count_custom()
+	 */
+	for (i = 0; i < net_selftest_get_count_custom(test); i++)
+		buf[i] = -ENOEXEC;
+
+	if (etest->flags != ETH_TEST_FL_OFFLINE) {
+		netdev_err(ndev, "Only offline tests are supported\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return -EOPNOTSUPP;
+	}
+
+	if (test->count > ARRAY_SIZE(test->entries)) {
+		netdev_err(ndev, "The count of entries exceeds the maximum\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int net_test_phy_enable(struct net_device *ndev, bool enable)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_loopback(ndev->phydev, enable, 0);
+}
+
+static const struct net_extra_test {
+	int flag;
+	struct net_test_entry entry;
+} net_extra_tests[] = {
+	{
+		.flag = NET_EXTRA_CARRIER_TEST,
+		.entry = NET_TEST_E("Carrier", NULL, NET_TEST_NETIF_CARRIER),
+	}, {
+		.flag = NET_EXTRA_FULL_DUPLEX_TEST,
+		.entry = NET_TEST_E("Full Duplex", NULL, NET_TEST_FULL_DUPLEX),
+	}, {
+		/* this test must be the last one */
+		.flag = NET_EXTRA_PHY_TEST,
+		.entry = NET_TEST_E("PHY internal loopback",
+				    net_test_phy_enable,
+				    NET_TEST_UDP_MAX_MTU | NET_TEST_TCP),
+	}
+};
+
+void net_selftest_custom(struct net_device *ndev, const struct net_test *test,
+			 struct ethtool_test *etest, u64 *buf)
+{
+	u32 i, j = 0;
+	int ret;
+
+	ret = net_test_prepare(ndev, test, etest, buf);
+	if (ret)
+		return;
+
+	for (i = 0; i < test->count; i++)
+		net_selftest_check_result(ndev, &test->entries[i],
+					  etest, &buf[j++]);
+
+	for (i = 0; i < ARRAY_SIZE(net_extra_tests); i++)
+		if (test->extra_flags & net_extra_tests[i].flag)
+			net_selftest_check_result(ndev,
+						  &net_extra_tests[i].entry,
+						  etest, &buf[j++]);
+}
+EXPORT_SYMBOL_GPL(net_selftest_custom);
+
+int net_selftest_get_count_custom(const struct net_test *test)
+{
+	u32 i, exter_count = 0;
+
+	if (test->count > ARRAY_SIZE(test->entries))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(net_extra_tests); i++)
+		if (test->extra_flags & net_extra_tests[i].flag)
+			exter_count++;
+
+	return test->count + exter_count;
+}
+EXPORT_SYMBOL_GPL(net_selftest_get_count_custom);
+
+static void net_selftest_get_entry_string(const struct net_test_entry *entry,
+					  u32 index, u8 **data)
+{
+	ethtool_sprintf(data, "%2d. %-30s", index, entry->name);
+}
+
+void net_selftest_get_strings_custom(const struct net_test *test, u8 *data)
+{
+	u32 i, j = 1;
+
+	if (test->count > ARRAY_SIZE(test->entries))
+		return;
+
+	for (i = 0; i < test->count; i++)
+		net_selftest_get_entry_string(&test->entries[i], j++, &data);
+
+	for (i = 0; i < ARRAY_SIZE(net_extra_tests); i++)
+		if (test->extra_flags & net_extra_tests[i].flag)
+			net_selftest_get_entry_string(&net_extra_tests[i].entry,
+						      j++, &data);
+}
+EXPORT_SYMBOL_GPL(net_selftest_get_strings_custom);
+
 MODULE_DESCRIPTION("Common library for generic PHY ethtool selftests");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
-- 
2.33.0


