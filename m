Return-Path: <netdev+bounces-59872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A681C80D
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4E51F239EB
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AD6107A9;
	Fri, 22 Dec 2023 10:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E311718
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1703240516tsj6nfa2
Received: from wxdbg.localdomain.com ( [125.119.246.92])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Dec 2023 18:21:55 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2ieeRpzzrevRP8Wwvf+tqZzMArSYboWkmXQKGXpnEL3dI5F2N0IH4
	/EGqz+1/eemAzOe0ofx+ZI3uNH4F15IUrvJFSdbBhg+mG1QxBFlT9qitlaOOKymcCDpB55l
	qCXLwIB1ik/VnOPaEUvNw3HwBfY0FmESzFFYi/MwuA7epKNXCJHMgnYkVFGFztt7YsB0noW
	kWS/nrZYRChqtkocKHdOHRngx9XuypSQqUsuyXkFrTJw5CAL2XhpYaa1W5PryB8ZdvleaIq
	2i3T2NXQgiKiDwIEfTnRoadhQLPj+R8GuCVheyF0S0s7TlWMTbJMPfAyYWDz/1qz0wt0KAZ
	aAmQmfjAqrVB4vqiDeapVL91JQHnGciz6IszwcWuNs5unQiuDBzC1WIMAB1OYPLbJ9nDdhg
	6npXIXTNHq0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13425975966908633895
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
Subject: [PATCH net-next v6 1/8] net: libwx: add phylink to libwx
Date: Fri, 22 Dec 2023 18:16:32 +0800
Message-Id: <20231222101639.1499997-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
References: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
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


