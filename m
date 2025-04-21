Return-Path: <netdev+bounces-184379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8CA951FC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824461884CD5
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162F2676C2;
	Mon, 21 Apr 2025 13:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79D266580;
	Mon, 21 Apr 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243445; cv=none; b=GVVESh8pBvCIv9Za6yAmzuWRHsQWYTLvMBGwNDukyPf+H+o++WQ8HyRDYmW253urdTl0fdcQfeDpJ0J3mQCpCVX7/B8grQwwTOaKqgmIRj0KBmHbG745WlBst4Ua76d6r/u3kp300fC9Dl6V4XmCG4Fyw7CVCmfQBFEdKg6KH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243445; c=relaxed/simple;
	bh=12mEl+1YTyr+7T+HiJM6voewpOKBSfOE4w8KgEwFzZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnOeh2td1MjdOhxAsSa8YVhRAeJUJzFixKlaPLjGyVynApN2zHS4fb3rHNU2XX45M6PhvLhA7zl2vvkthd5dFSACSGQNsOjn0UFYZOeJCGQuX/Dtoq2bATJKblH1N3+boP+c4yl/VRbvyrwafDjLD9tRd/AoN8mwxa4TkbclXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zh6CX4W13z1R7fN;
	Mon, 21 Apr 2025 21:48:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8316E1800B2;
	Mon, 21 Apr 2025 21:50:39 +0800 (CST)
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
Subject: [PATCH RFC net-next 2/2] net: hibmcge: add support for selftest
Date: Mon, 21 Apr 2025 21:43:58 +0800
Message-ID: <20250421134358.1241851-3-shaojijie@huawei.com>
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

This patch implements selftest, including MAC and SerDes selftest,
which is the driver's own test. The .enable() is implemented by the driver.

In addition, the driver sets extra_flags to
test the carrier status, full duplex, and PHY.

For example:
ethtool -t enp132s0f1
The test result is PASS
The test extra info:
 1. MAC internal loopback      	 0
 2. Serdes internal loopback   	 0
 3. Carrier                    	 0
 4. Full Duplex                	 0
 5. PHY internal loopback      	 0

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  2 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 60 ++++++++++++++++---
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  6 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |  3 +-
 6 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 7725cb0c5c8a..876933f88329 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -84,6 +84,8 @@ enum hbg_hw_event_type {
 	HBG_HW_EVENT_INIT, /* driver is loading */
 	HBG_HW_EVENT_RESET,
 	HBG_HW_EVENT_CORE_RESET,
+	HBG_HW_EVENT_SERDES_LOOP_ENABLE,
+	HBG_HW_EVENT_SERDES_LOOP_DISABLE = 5,
 };
 
 struct hbg_dev_specs {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 8f1107b85fbb..cc60bd76890d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
+#include <net/selftests.h>
 #include "hbg_common.h"
 #include "hbg_err.h"
 #include "hbg_ethtool.h"
@@ -339,12 +340,55 @@ void hbg_update_stats(struct hbg_priv *priv)
 				 ARRAY_SIZE(hbg_ethtool_ctrl_stats_info));
 }
 
+static int hbg_test_mac_loopback_enable(struct net_device *ndev,
+					bool enable)
+{
+	struct hbg_priv *priv = netdev_priv(ndev);
+
+	hbg_hw_loop_enable(priv, enable);
+	return 0;
+}
+
+static int hbg_test_serdes_loopback_enable(struct net_device *ndev,
+					   bool enable)
+{
+	struct hbg_priv *priv = netdev_priv(ndev);
+	u32 event = enable ? HBG_HW_EVENT_SERDES_LOOP_ENABLE :
+			     HBG_HW_EVENT_SERDES_LOOP_DISABLE;
+
+	return hbg_hw_event_notify(priv, event);
+}
+
+static const struct net_test hbg_test = {
+	.extra_flags = NET_EXTRA_CARRIER_TEST |
+		       NET_EXTRA_FULL_DUPLEX_TEST |
+		       NET_EXTRA_PHY_TEST,
+	.entries = {
+		NET_TEST_E("MAC internal loopback",
+			   hbg_test_mac_loopback_enable,
+			   NET_TEST_UDP_MAX_MTU | NET_TEST_TCP),
+		NET_TEST_E("Serdes internal loopback",
+			   hbg_test_serdes_loopback_enable,
+			   NET_TEST_UDP_MAX_MTU | NET_TEST_TCP),
+	},
+	.count = 2,
+};
+
+static void hbg_ethtool_self_test(struct net_device *netdev,
+				  struct ethtool_test *etest,
+				  u64 *buf)
+{
+	net_selftest_custom(netdev, &hbg_test, etest, buf);
+}
+
 static int hbg_ethtool_get_sset_count(struct net_device *netdev, int stringset)
 {
-	if (stringset != ETH_SS_STATS)
-		return -EOPNOTSUPP;
+	if (stringset == ETH_SS_STATS)
+		return ARRAY_SIZE(hbg_ethtool_stats_info);
+	else if (stringset == ETH_SS_TEST)
+		return net_selftest_get_count_custom(&hbg_test);
 
-	return ARRAY_SIZE(hbg_ethtool_stats_info);
+	return -EOPNOTSUPP;
 }
 
 static void hbg_ethtool_get_strings(struct net_device *netdev,
@@ -352,11 +396,12 @@ static void hbg_ethtool_get_strings(struct net_device *netdev,
 {
 	u32 i;
 
-	if (stringset != ETH_SS_STATS)
-		return;
+	if (stringset == ETH_SS_STATS)
+		for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
+			ethtool_puts(&data, hbg_ethtool_stats_info[i].name);
+	else if (stringset == ETH_SS_TEST)
+		net_selftest_get_strings_custom(&hbg_test, data);
 
-	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
-		ethtool_puts(&data, hbg_ethtool_stats_info[i].name);
 }
 
 static void hbg_ethtool_get_stats(struct net_device *netdev,
@@ -488,6 +533,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_eth_mac_stats	= hbg_ethtool_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= hbg_ethtool_get_eth_ctrl_stats,
 	.get_rmon_stats		= hbg_ethtool_get_rmon_stats,
+	.self_test		= hbg_ethtool_self_test,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 9b65eef62b3f..ad3fc572bc13 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -264,6 +264,12 @@ void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr)
 	hbg_reg_write64(priv, HBG_REG_FD_FC_ADDR_LOW_ADDR, mac_addr);
 }
 
+void hbg_hw_loop_enable(struct hbg_priv *priv, u32 enable)
+{
+	hbg_reg_write_field(priv, HBG_REG_LOOP_REG_ADDR,
+			    HBG_REG_CF_CG2MI_LP_EN_B, enable);
+}
+
 static void hbg_hw_init_transmit_ctrl(struct hbg_priv *priv)
 {
 	u32 ctrl = 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index a4a049b5121d..f7917a5353c2 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -59,5 +59,6 @@ void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable);
 void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en);
 void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en);
 void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr);
+void hbg_hw_loop_enable(struct hbg_priv *priv, u32 enable);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index a6e7f5e62b48..85b46f35b876 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -117,6 +117,7 @@
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
 #define HBG_REG_LOOP_REG_ADDR			(HBG_REG_SGMII_BASE + 0x01DC)
+#define HBG_REG_CF_CG2MI_LP_EN_B		BIT(2)
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
 #define HBG_REG_VLAN_CODE_ADDR			(HBG_REG_SGMII_BASE + 0x01E8)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 8d814c8f19ea..5802748f3a13 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -258,7 +258,8 @@ static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
 		break;
 	case HBG_L4_ZERO_PORT_NUM:
 		priv->stats.rx_desc_l4_zero_port_num_cnt++;
-		return false;
+		/* Don't drop packets whose L4 port number is 0. */
+		break;
 	default:
 		priv->stats.rx_desc_l4_other_cnt++;
 		return false;
-- 
2.33.0


