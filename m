Return-Path: <netdev+bounces-56269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C680E58E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C191F2188C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0B0182DF;
	Tue, 12 Dec 2023 08:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232DB8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:11:04 -0800 (PST)
X-QQ-mid: bizesmtp74t1702368576tyy4oqsx
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:09:35 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: OtIeQkg1QQEkWaKNbvjhSQCcgDf4zb+i8952PvY9ZQZHat4xb1VJmsA9/agXZ
	iX3U/15uVtzy+s1ktmzpe6mAHfvU/Yy+HE07c2Q7wWmGMjBbRfucCq8Up1Ha00jJ6YiYrqe
	LdGHZ7Y4AbwbY99DezhpkYHW/F8nH0b5c1Cldxb97T0GZpmjY/r+XH503gptOkx77Ta4wPC
	OYJZmQh5gE1K3aHaw/CIl9OXNkF3QQq7rThw42lE67fOgua78R/w0Pp3WFmpXpscim7AU3u
	HdHFyCnTeX1OGVn4kY2HSVQP4KfkfbW0tjwlo+r93t1GgJnskW1Er/E8/XUCgGi8LBl2yBV
	KAWUnbzLloqwZb6nRovol94h4Z7/Kh7EVKFMb6YI2XIKIsG/jZ0CWRMSSgadmeuzOr68jmy
	tfJ4duTE2o0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15544939174727221329
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
Subject: [PATCH net-next v4 1/8] net: libwx: add phylink to libwx
Date: Tue, 12 Dec 2023 16:04:31 +0800
Message-Id: <20231212080438.1361308-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
References: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
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


