Return-Path: <netdev+bounces-61091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6B58226CF
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82861C21CF3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5515AF;
	Wed,  3 Jan 2024 02:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9361846
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp63t1704248082tqzhfw10
Received: from wxdbg.localdomain.com ( [36.20.47.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jan 2024 10:14:41 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: vpirJkIp8F5eP8iH7igMueS5S8NynmYWBUMTs11A++uqOSvuFZG3puw5vKKyr
	iLWEC3u4ECBfQZi4ypzJTPVQDoAFvCAUCKeOMdAmcsC8lDFdZMd2Momz/BjvhO6HUw2RCr+
	30K/1K0VVNzZ0eisNPsx8HCQc/Iz9jYIFyhOjn9/w5Hiu2iBN7NIjt3lGt6jJiT8NR4tRR6
	RTYrbm5tYaxQ8lpeYc6vRfZrQ2X8NrkZhtrvg90MZRzECxFdjvbXQORY6RrIVuhPhb0+6Wu
	avfzzHi4pXpYgpRJNYMuNajsIDSrMt5YmFPp5DPQeWnBKODdC2qcRorjvRInRzu2UaRSGae
	cdqah42WngsxEcgz3nQKLTL0HUyU1QkFy8Pi3meamVxpf0QBPSNBA+WqJP2hm9H+bh1jfzs
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 803519913223223915
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 1/8] net: libwx: add phylink to libwx
Date: Wed,  3 Jan 2024 10:08:47 +0800
Message-Id: <20240103020854.1656604-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
References: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

For the following implementation, add struct phylink and phylink_config
to wx structure. Add the helper function for converting phylink to wx,
implement ethtool ksetting and nway reset in libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 26 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  5 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  8 ++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 6e9e5f01c152..ba37ba6f03e4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -185,3 +185,29 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	}
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
+
+int wx_nway_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_nway_reset(wx->phylink);
+}
+EXPORT_SYMBOL(wx_nway_reset);
+
+int wx_get_link_ksettings(struct net_device *netdev,
+			  struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
+}
+EXPORT_SYMBOL(wx_get_link_ksettings);
+
+int wx_set_link_ksettings(struct net_device *netdev,
+			  const struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
+}
+EXPORT_SYMBOL(wx_set_link_ksettings);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 16d1a09369a6..f15cc445ae0f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -13,4 +13,9 @@ void wx_get_mac_stats(struct net_device *netdev,
 void wx_get_pause_stats(struct net_device *netdev,
 			struct ethtool_pause_stats *stats);
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info);
+int wx_nway_reset(struct net_device *netdev);
+int wx_get_link_ksettings(struct net_device *netdev,
+			  struct ethtool_link_ksettings *cmd);
+int wx_set_link_ksettings(struct net_device *netdev,
+			  const struct ethtool_link_ksettings *cmd);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 83f9bb7b3c22..5b064c434053 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/phylink.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -939,6 +940,8 @@ struct wx {
 	int speed;
 	int duplex;
 	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 
 	bool wol_hw_supported;
 	bool ncsi_enabled;
@@ -1044,4 +1047,9 @@ rd64(struct wx *wx, u32 reg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
+static inline struct wx *phylink_to_wx(struct phylink_config *config)
+{
+	return container_of(config, struct wx, phylink_config);
+}
+
 #endif /* _WX_TYPE_H_ */
-- 
2.27.0


