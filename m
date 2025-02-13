Return-Path: <netdev+bounces-165800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06EA3368C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171B188B49A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2217207651;
	Thu, 13 Feb 2025 04:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA5206F31;
	Thu, 13 Feb 2025 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419405; cv=none; b=qmUe7voeQhnPiUgxi/u8TQIGXLYZ9zuXhszN7FvwMcrLNTEvr78h3XmgztDNF8AfpVgvHA+xFisuA+pYY5jHABsEEBxuO8VxBZyQQZ1uSDo8RlwDT4SjvX0ZvyZOxbIkMMcjM1bgAcw5lDD5E7lTM9Qws1firKF5fu0ZC8UxJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419405; c=relaxed/simple;
	bh=TG3oH2TkfavGL21FWlitN+B3sF3dSUwYOZFWx9CChi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOcahR2j9/br0ib9/JmzQagsWh2hZa811NX56U2Z6NfsQ3Nl0yeTCmRsDvAS2ANaiT4EwrPrKcVS6BYHpirGO7mdXDZNuUzlxYLB0LpOCImx74f1LYRXMB6OtzslDfKBfYa2M6Y2zhoTZHqGK+D35EUX4I4iwMpRKocmJJ6wXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YthMM5F70z1JJxr;
	Thu, 13 Feb 2025 12:01:51 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 949611A016C;
	Thu, 13 Feb 2025 12:03:15 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 5/7] net: hibmcge: Add mac link exception handling feature in this module
Date: Thu, 13 Feb 2025 11:55:27 +0800
Message-ID: <20250213035529.2402283-6-shaojijie@huawei.com>
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

If the rate changed frequently, the PHY link ok,
but the MAC link maybe fails.
As a result, the network port is unavailable.

According to the documents of the chip,
core_reset needs to do to fix the fault.

In hw_adjus_link(), the core_reset is added to try to
ensure that MAC link status is normal.
In addition, MAC link failure detection is added.
If the MAC link fails after core_reset,
the PHY will reset and re-link up to five times.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  4 ++-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  2 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 26 +++++++++++++++--
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 29 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  2 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 13 ++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  1 +
 7 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f45e899c62d8..e942a1e6f859 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -37,6 +37,7 @@ enum hbg_nic_state {
 	HBG_NIC_STATE_RESETTING,
 	HBG_NIC_STATE_RESET_FAIL,
 	HBG_NIC_STATE_NEED_RESET, /* trigger a reset in scheduled task */
+	HBG_NIC_STATE_NP_LINK_FAIL,
 };
 
 enum hbg_reset_type {
@@ -82,7 +83,7 @@ enum hbg_hw_event_type {
 	HBG_HW_EVENT_NONE = 0,
 	HBG_HW_EVENT_INIT, /* driver is loading */
 	HBG_HW_EVENT_RESET,
-
+	HBG_HW_EVENT_CORE_RESET,
 	HBG_HW_EVENT_SERDES_LOOPBACK_ENABLE = 4,
 	HBG_HW_EVENT_SERDES_LOOPBACK_DISABLE = 5,
 };
@@ -257,6 +258,7 @@ struct hbg_stats {
 	u64 tx_dma_err_cnt;
 
 	u64 self_test_rx_pkt_cnt;
+	u64 np_link_fail_cnt;
 };
 
 typedef void (*self_test_pkt_recv)(struct net_device *ndev,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 55ce90b4319a..5e0ba4d5b08d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -117,6 +117,8 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 		   reset_type_str[priv->reset_type]);
 	seq_printf(s, "need reset state: %s\n",
 		   state_str_true_false(priv, HBG_NIC_STATE_NEED_RESET));
+	seq_printf(s, "np_link fail state: %s\n",
+		   state_str_true_false(priv, HBG_NIC_STATE_NP_LINK_FAIL));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 4e8cb66f601c..01c4b246d040 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -46,6 +46,16 @@ int hbg_rebuild(struct hbg_priv *priv)
 	return 0;
 }
 
+int hbg_reset_phy(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+
+	if (phydev->drv->soft_reset)
+		return phydev->drv->soft_reset(phydev);
+
+	return genphy_soft_reset(phydev);
+}
+
 static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 {
 	int ret;
@@ -61,12 +71,22 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 	priv->reset_type = type;
 	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
-	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
+
+	ret = hbg_reset_phy(priv);
 	if (ret) {
-		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
-		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
+		dev_err(&priv->pdev->dev, "failed to reset phy\n");
+		goto reset_fail;
 	}
 
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
+	if (ret)
+		goto reset_fail;
+
+	return 0;
+
+reset_fail:
+	set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index d978535e06a0..cb145f524e15 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -17,6 +17,7 @@
  */
 #define HBG_ENDIAN_CTRL_LE_DATA_BE	0x0
 #define HBG_PCU_FRAME_LEN_PLUS 4
+#define HBG_LINK_FAIL_RETRY_TIMES	5
 
 static bool hbg_hw_spec_is_valid(struct hbg_priv *priv)
 {
@@ -217,12 +218,38 @@ void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr)
 	hbg_reg_write(priv, HBG_REG_RX_CFF_ADDR_ADDR, buffer_dma_addr);
 }
 
-void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
+int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
+	struct hbg_stats *stats = &priv->stats;
+	int ret;
+
+	clear_bit(HBG_NIC_STATE_NP_LINK_FAIL, &priv->state);
+	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
+
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
 			    HBG_REG_PORT_MODE_M, speed);
 	hbg_reg_write_field(priv, HBG_REG_DUPLEX_TYPE_ADDR,
 			    HBG_REG_DUPLEX_B, duplex);
+
+	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_CORE_RESET);
+	if (ret)
+		return ret;
+
+	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
+
+	if (!hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
+				HBG_REG_AN_NEG_STATE_NP_LINK_OK_B)) {
+		set_bit(HBG_NIC_STATE_NP_LINK_FAIL, &priv->state);
+
+		stats->np_link_fail_cnt++;
+		if (!(stats->np_link_fail_cnt % HBG_LINK_FAIL_RETRY_TIMES))
+			return -EFAULT;
+
+		return -ENOLINK;
+	}
+
+	stats->np_link_fail_cnt = 0;
+	return 0;
 }
 
 /* only support uc filter */
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index fc216fcfae06..4c9bef0348b4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -44,7 +44,7 @@ static inline void hbg_reg_write64(struct hbg_priv *priv, u32 addr, u64 value)
 int hbg_hw_event_notify(struct hbg_priv *priv,
 			enum hbg_hw_event_type event_type);
 int hbg_hw_init(struct hbg_priv *priv);
-void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
 u32 hbg_hw_get_irq_status(struct hbg_priv *priv);
 void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask);
 bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index db6bc4cfb971..8de6d57bd5f3 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -3,6 +3,7 @@
 
 #include <linux/phy.h>
 #include "hbg_common.h"
+#include "hbg_err.h"
 #include "hbg_hw.h"
 #include "hbg_mdio.h"
 #include "hbg_reg.h"
@@ -132,6 +133,7 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
 	struct hbg_priv *priv = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
 	u32 speed;
+	int ret;
 
 	if (phydev->link != priv->mac.link_status) {
 		if (phydev->link) {
@@ -152,7 +154,16 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
 			priv->mac.speed = speed;
 			priv->mac.duplex = phydev->duplex;
 			priv->mac.autoneg = phydev->autoneg;
-			hbg_hw_adjust_link(priv, speed, phydev->duplex);
+			ret = hbg_hw_adjust_link(priv, speed, phydev->duplex);
+			if (ret == -ENOLINK) {
+				dev_err(&priv->pdev->dev,
+					"failed to link between MAC and PHY\n");
+				hbg_reset_phy(priv);
+			} else if (ret == -EFAULT) {
+				dev_err(&priv->pdev->dev,
+					"failed to fix the MAC link status\n");
+			}
+
 			hbg_flowctrl_cfg(priv);
 		}
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index fe146c2c5e80..9f9346b7f1be 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -54,6 +54,7 @@
 #define HBG_REG_PAUSE_ENABLE_RX_B		BIT(0)
 #define HBG_REG_PAUSE_ENABLE_TX_B		BIT(1)
 #define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
+#define HBG_REG_AN_NEG_STATE_NP_LINK_OK_B	BIT(15)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
-- 
2.33.0


