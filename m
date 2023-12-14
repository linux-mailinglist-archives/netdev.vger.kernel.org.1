Return-Path: <netdev+bounces-57208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8B8125AE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1162B1F21EBB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49158ECF;
	Thu, 14 Dec 2023 03:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 154213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 19:01:33 PST
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BCAF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:01:32 -0800 (PST)
X-QQ-mid: bizesmtp68t1702522795t4v55xjx
Received: from wxdbg.localdomain.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Dec 2023 10:59:54 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: OtIeQkg1QQHiVzi61LYWQQCuoPocRifoYjuNIpugtq+Rviu5t/khpqxX6ETLy
	f/aGXika1GzqvkdA0IqRh/NokRh+uOxijmSklvPmL9XZJUeOttYVvVmV2k7Y4nBSQSwoLvL
	zgCyzePKIXTBz50XamWxcWQs7cQoigU9P/KCOptBOPejQH56goVGTrAH1rXVAxd6FjsHcbu
	7Y9iBfaT+sNworZYWgaVQVEILrnH6DmrMoZFLUgVE1zyrAsBI0WPXKqbLQfFDOj0E4XUH+3
	9LDoj2DB8XBi2XMs8ojXBzPLydixN05C98K04Jqn5Kfb3C8lrkfrRVTDnbgYosA2skGJBVj
	bqv9QfuVKmfTr6EQX17oX5OjsP7Q+4j3X+EYXHn/Q4GbsoLKG/ciBSltYAYKUl8ES6nFCom
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14160201901316088662
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
Subject: [PATCH net-next v5 1/8] net: libwx: add phylink to libwx
Date: Thu, 14 Dec 2023 10:54:49 +0800
Message-Id: <20231214025456.1387175-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
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
index ddc5f6d20b9c..12feb8a5ee75 100644
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
index 165e82de772e..c0dd9fc6df66 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/phylink.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -940,6 +941,8 @@ struct wx {
 	int speed;
 	int duplex;
 	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 
 	bool wol_hw_supported;
 	bool ncsi_enabled;
@@ -1045,4 +1048,9 @@ rd64(struct wx *wx, u32 reg)
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


