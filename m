Return-Path: <netdev+bounces-165798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E602A33687
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464D5188B761
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0402063F4;
	Thu, 13 Feb 2025 04:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4811EA84;
	Thu, 13 Feb 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419400; cv=none; b=T2wFaoyP+ZUKtAj7rZw+HZV3ZLWpldxd873zrL36WgV7Au0n46QHAGt4tvmGq6xYbcG8HZLx7sDqzePv2fb6AyTGJK9Mz2YyKmDL1TJqkryF6ajmVx64ITc+Juj1HBu1trH+juGqqJoDBz3IRjRYB5u2HDIIBG5ZAQ1g69ScQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419400; c=relaxed/simple;
	bh=6f0c0w8nLhLV3llCu31BoiGHRjMuEJaPcl7aUGkuE6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcNtthBYbVa/woEx8XYHUu0kn68XsDi91/cF5J2Vnehx75las5KH+6PAk5K2qph3rAgzHiJKfIqJdkvelDJYUlnrBlWofBwi1ySREdbPEHnpBNT1p8N0fiIS6w7Jfx+V5AK1EHvng4OfcQuFwd+UE2j3FwIH2SP7S6+bhWHIn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YthPW1nhyz20qLf;
	Thu, 13 Feb 2025 12:03:43 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A04A41A0188;
	Thu, 13 Feb 2025 12:03:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 2/7] net: hibmcge: Add self test supported in this module
Date: Thu, 13 Feb 2025 11:55:24 +0800
Message-ID: <20250213035529.2402283-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250213035529.2402283-1-shaojijie@huawei.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
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

This patch supports many self test: Mac, SerDes and Phy.

To implement self test, this patch implements a simple packet sending and
receiving function in the driver. By sending a packet in a specific format,
driver considers that the test is successful if the packet is received.
Otherwise, the test fails.

The SerDes hardware is on the BMC side, Therefore, when the SerDes loopback
need enabled, driver notifies the BMC through an event message.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  10 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 192 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |   6 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |   6 +
 6 files changed, 208 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 920514a8e29a..761137861c8d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -81,6 +81,9 @@ enum hbg_hw_event_type {
 	HBG_HW_EVENT_NONE = 0,
 	HBG_HW_EVENT_INIT, /* driver is loading */
 	HBG_HW_EVENT_RESET,
+
+	HBG_HW_EVENT_SERDES_LOOPBACK_ENABLE = 4,
+	HBG_HW_EVENT_SERDES_LOOPBACK_DISABLE = 5,
 };
 
 struct hbg_dev_specs {
@@ -249,8 +252,13 @@ struct hbg_stats {
 
 	u64 tx_timeout_cnt;
 	u64 tx_dma_err_cnt;
+
+	u64 self_test_rx_pkt_cnt;
 };
 
+typedef void (*self_test_pkt_recv)(struct net_device *ndev,
+				   struct sk_buff *skb);
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -266,6 +274,8 @@ struct hbg_priv {
 	struct hbg_user_def user_def;
 	struct hbg_stats stats;
 	struct delayed_work service_task;
+
+	self_test_pkt_recv self_test_pkt_recv_fn;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index f5be8d0ef611..f3980e5bec2e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -8,6 +8,17 @@
 #include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
+#include "hbg_txrx.h"
+
+#define HBG_LOOP_DATA_SIZE		0x100
+#define HBG_LOOP_MAX_WAIT_TIME		2000
+#define HBG_LOOP_WAIT_TIME_STEP		100
+
+struct hibmcge_self_test {
+	char desc[ETH_GSTRING_LEN];
+	int (*enable)(struct hbg_priv *priv, bool enable);
+	int (*fn)(struct net_device *ndev);
+};
 
 struct hbg_ethtool_stats {
 	char name[ETH_GSTRING_LEN];
@@ -309,6 +320,167 @@ static int hbg_ethtool_reset(struct net_device *netdev, u32 *flags)
 	return hbg_reset(priv);
 }
 
+static int hbg_test_mac_loopback_enable(struct hbg_priv *priv, bool enable)
+{
+	hbg_hw_loop_enable(priv, enable);
+	return 0;
+}
+
+static int hbg_test_serdes_loopback_enable(struct hbg_priv *priv, bool enable)
+{
+	u32 event = enable ? HBG_HW_EVENT_SERDES_LOOPBACK_ENABLE :
+			     HBG_HW_EVENT_SERDES_LOOPBACK_DISABLE;
+
+	return hbg_hw_event_notify(priv, event);
+}
+
+static int hbg_test_phy_loopback_enable(struct hbg_priv *priv, bool enable)
+{
+	return phy_loopback(priv->mac.phydev, enable);
+}
+
+static int hbg_self_test_pkt_send(struct net_device *ndev)
+{
+	struct hbg_priv *priv = netdev_priv(ndev);
+	struct sk_buff *skb = NULL;
+	int ret;
+	u32 i;
+
+	skb = netdev_alloc_skb(priv->netdev, HBG_LOOP_DATA_SIZE + NET_SKB_PAD);
+	if (!skb)
+		return -ENOMEM;
+	skb_reset_mac_header(skb);
+
+	skb_put(skb, HBG_LOOP_DATA_SIZE);
+	for (i = 0; i < HBG_LOOP_DATA_SIZE; i++)
+		skb->data[i] = i & 0xFF;
+
+	ret = hbg_net_start_xmit(skb, ndev);
+	if (ret != NETDEV_TX_OK) {
+		dev_kfree_skb_any(skb);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void hbg_self_test_pkt_recv(struct net_device *ndev, struct sk_buff *skb)
+{
+	struct hbg_priv *priv = netdev_priv(ndev);
+	u32 i;
+
+	skb_reserve(skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
+	if (skb_tailroom(skb) < HBG_LOOP_DATA_SIZE)
+		return;
+
+	skb_put(skb, HBG_LOOP_DATA_SIZE);
+
+	for (i = 0; i < HBG_LOOP_DATA_SIZE; i++)
+		if (skb->data[i] != (i & 0xFF))
+			return;
+
+	priv->stats.self_test_rx_pkt_cnt++;
+}
+
+static int hbg_test_loopback(struct net_device *ndev)
+{
+	struct hbg_priv *priv = netdev_priv(ndev);
+	u32 wait_time = 0;
+	int ret;
+
+	priv->stats.self_test_rx_pkt_cnt = 0;
+	ret = hbg_self_test_pkt_send(priv->netdev);
+	if (ret)
+		return ret;
+
+	do {
+		if (priv->stats.self_test_rx_pkt_cnt)
+			return 0;
+
+		msleep(HBG_LOOP_WAIT_TIME_STEP);
+		wait_time += HBG_LOOP_WAIT_TIME_STEP;
+	} while (wait_time < HBG_LOOP_MAX_WAIT_TIME);
+
+	return -ETIMEDOUT;
+}
+
+static int hbg_test_netif_carrier(struct net_device *ndev)
+{
+	return netif_carrier_ok(ndev) ? 0 : -ENOLINK;
+}
+
+/* Only support test in full duplex mode. */
+static int hbg_test_full_duplex(struct net_device *ndev)
+{
+	return ndev->phydev->duplex == DUPLEX_FULL ? 0 : -EINVAL;
+}
+
+const struct hibmcge_self_test hbg_selftests[] = {
+	{
+		.desc = "Carrier           ",
+		.fn = hbg_test_netif_carrier,
+	}, {
+		.desc = "Full Duplex       ",
+		.fn = hbg_test_full_duplex,
+	}, {
+		.desc = "MAC loopback      ",
+		.enable = hbg_test_mac_loopback_enable,
+		.fn = hbg_test_loopback,
+	}, {
+		.desc = "Serdes loopback   ",
+		.enable = hbg_test_serdes_loopback_enable,
+		.fn = hbg_test_loopback,
+	}, {
+		.desc = "Phy loopback      ",
+		.enable = hbg_test_phy_loopback_enable,
+		.fn = hbg_test_loopback,
+	},
+};
+
+static void hbg_ethtool_self_test(struct net_device *netdev,
+				  struct ethtool_test *etest, u64 *buf)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(hbg_selftests); i++)
+		buf[i] = -ENOEXEC;
+
+	if (!(etest->flags & ETH_TEST_FL_OFFLINE)) {
+		netdev_err(netdev, "Only offline tests are supported\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return;
+	}
+
+	if (!netif_running(netdev)) {
+		netdev_err(netdev, "port is down, can not do test\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return;
+	}
+
+	hbg_hw_set_mac_filter_enable(priv, false);
+	priv->self_test_pkt_recv_fn = hbg_self_test_pkt_recv;
+	for (i = 0; i < ARRAY_SIZE(hbg_selftests); i++) {
+		if (hbg_selftests[i].enable) {
+			buf[i] = hbg_selftests[i].enable(priv, true);
+			if (buf[i]) {
+				etest->flags |= ETH_TEST_FL_FAILED;
+				continue;
+			}
+		}
+
+		buf[i] = hbg_selftests[i].fn(netdev);
+		if (buf[i])
+			etest->flags |= ETH_TEST_FL_FAILED;
+
+		if (hbg_selftests[i].enable)
+			hbg_selftests[i].enable(priv, false);
+	}
+
+	priv->self_test_pkt_recv_fn = NULL;
+	hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
+}
+
 static void hbg_update_stats_by_info(struct hbg_priv *priv,
 				     const struct hbg_ethtool_stats *info,
 				     u32 info_len)
@@ -340,10 +512,12 @@ void hbg_update_stats(struct hbg_priv *priv)
 
 static int hbg_ethtool_get_sset_count(struct net_device *netdev, int stringset)
 {
-	if (stringset != ETH_SS_STATS)
-		return -EOPNOTSUPP;
+	if (stringset == ETH_SS_STATS)
+		return ARRAY_SIZE(hbg_ethtool_stats_info);
+	else if (stringset == ETH_SS_TEST)
+		return ARRAY_SIZE(hbg_selftests);
 
-	return ARRAY_SIZE(hbg_ethtool_stats_info);
+	return -EOPNOTSUPP;
 }
 
 static void hbg_ethtool_get_strings(struct net_device *netdev,
@@ -351,11 +525,12 @@ static void hbg_ethtool_get_strings(struct net_device *netdev,
 {
 	u32 i;
 
-	if (stringset != ETH_SS_STATS)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
-		ethtool_puts(&data, hbg_ethtool_stats_info[i].name);
+	if (stringset == ETH_SS_STATS)
+		for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
+			ethtool_puts(&data, hbg_ethtool_stats_info[i].name);
+	else if (stringset == ETH_SS_TEST)
+		for (i = 0; i < ARRAY_SIZE(hbg_selftests); i++)
+			ethtool_puts(&data, hbg_selftests[i].desc);
 }
 
 static void hbg_ethtool_get_stats(struct net_device *netdev,
@@ -487,6 +662,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_eth_mac_stats	= hbg_ethtool_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= hbg_ethtool_get_eth_ctrl_stats,
 	.get_rmon_stats		= hbg_ethtool_get_rmon_stats,
+	.self_test		= hbg_ethtool_self_test,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index e7798f213645..d978535e06a0 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -177,6 +177,12 @@ void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 	hbg_hw_set_mac_max_frame_len(priv, frame_len);
 }
 
+void hbg_hw_loop_enable(struct hbg_priv *priv, u32 enable)
+{
+	hbg_reg_write_field(priv, HBG_REG_LOOP_REG_ADDR,
+			    HBG_REG_CF_CG2MI_LP_EN_B, enable);
+}
+
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
 {
 	hbg_reg_write_field(priv, HBG_REG_PORT_ENABLE_ADDR,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index a4a049b5121d..fc216fcfae06 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -50,6 +50,7 @@ void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask);
 bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
 void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
+void hbg_hw_loop_enable(struct hbg_priv *priv, u32 enable);
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
 void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr, u32 index);
 u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 106d0e0408ba..d6d91fbe220c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -108,6 +108,7 @@
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
 #define HBG_REG_LOOP_REG_ADDR			(HBG_REG_SGMII_BASE + 0x01DC)
+#define HBG_REG_CF_CG2MI_LP_EN_B		BIT(2)
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
 #define HBG_REG_VLAN_CODE_ADDR			(HBG_REG_SGMII_BASE + 0x01E8)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 35dd3512d00e..8c631a9bcb6b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -413,6 +413,12 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 
+		if (unlikely(priv->self_test_pkt_recv_fn)) {
+			priv->self_test_pkt_recv_fn(priv->netdev, buffer->skb);
+			hbg_buffer_free(buffer);
+			goto next_buffer;
+		}
+
 		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc))) {
 			hbg_buffer_free(buffer);
 			goto next_buffer;
-- 
2.33.0


