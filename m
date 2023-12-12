Return-Path: <netdev+bounces-56275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4880E594
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A051F216D7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5E182DF;
	Tue, 12 Dec 2023 08:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F48AB8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:11:38 -0800 (PST)
X-QQ-mid: bizesmtp74t1702368603tilk993b
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:10:02 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: xwvWJGGFd7NHXZujvYFHKMXtIVmcTGOV13EX0VLQGgr+QiDO4HbvIuRL6fAfo
	yV9U0YzI/UTC3tlnOQLIhAqjNR+H29wzN9+igZJjM0f7E4fXFnYzp8+bysKVsMfyu7jr8TV
	2abQ01iOQGg6W/6G3I0nZqzJ9cLa1E0SLIKlcJmYT6LtqmFFscEqGaVqyxEdMXwgB3s3NVP
	NdNagYzraYO36ZZmHltN00oOUhcvHIAGnFKoFsa/TXe1STwPOzPovNMCMGkZrucCbMsN/cb
	gSaHSy1Rfp3fRVeGKpRLD3I3aren5ZNhs0AoTpdmvzT3n+3Or1yOLuREWzD5gZ0yRFvmJBu
	C4iJ6kuOKw5Ka/z7jLbte+zY7B2j47HQ/0zZnOzNaOKGt4xvCFtIIp3u5KvPYUl2qR+/y6o
	fxDwyqwYYvY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15854337931834670988
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
Subject: [PATCH net-next v4 8/8] net: wangxun: add ethtool_ops for msglevel
Date: Tue, 12 Dec 2023 16:04:38 +0800
Message-Id: <20231212080438.1361308-9-jiawenwu@trustnetic.com>
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

Add support to get and set msglevel for driver txgbe and ngbe.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 24 ++++++++++++-------
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  2 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  2 ++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 ++
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 31d189e8536b..518278ae41ac 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -383,10 +383,6 @@ void wx_get_channels(struct net_device *dev,
 
 	/* record RSS queues */
 	ch->combined_count = wx->ring_feature[RING_F_RSS].indices;
-
-	/* nothing else to report if RSS is disabled */
-	if (ch->combined_count == 1)
-		return;
 }
 EXPORT_SYMBOL(wx_get_channels);
 
@@ -396,10 +392,6 @@ int wx_set_channels(struct net_device *dev,
 	unsigned int count = ch->combined_count;
 	struct wx *wx = netdev_priv(dev);
 
-	/* verify they are not requesting separate vectors */
-	if (!count || ch->rx_count || ch->tx_count)
-		return -EOPNOTSUPP;
-
 	/* verify other_count has not changed */
 	if (ch->other_count != 1)
 		return -EINVAL;
@@ -413,3 +405,19 @@ int wx_set_channels(struct net_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_channels);
+
+u32 wx_get_msglevel(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return wx->msg_enable;
+}
+EXPORT_SYMBOL(wx_get_msglevel);
+
+void wx_set_msglevel(struct net_device *netdev, u32 data)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	wx->msg_enable = data;
+}
+EXPORT_SYMBOL(wx_set_msglevel);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index ec4ad84c03b9..600c3b597d1a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -38,4 +38,6 @@ void wx_get_channels(struct net_device *dev,
 		     struct ethtool_channels *ch);
 int wx_set_channels(struct net_device *dev,
 		    struct ethtool_channels *ch);
+u32 wx_get_msglevel(struct net_device *netdev);
+void wx_set_msglevel(struct net_device *netdev, u32 data);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 948d25ea7b1e..26fbcc5cd00a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -131,6 +131,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= ngbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index e3db21b49e2a..dde83518400f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -95,6 +95,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= txgbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


