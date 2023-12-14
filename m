Return-Path: <netdev+bounces-57211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37F8125B1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9D8B213DA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F313138F;
	Thu, 14 Dec 2023 03:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB111D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:01:39 -0800 (PST)
X-QQ-mid: bizesmtp68t1702522822tonjdmjl
Received: from wxdbg.localdomain.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Dec 2023 11:00:21 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 7YFKcddXaghKykJRvhmj5bYNzFJiXOJYx/571afAXBOPTP8gTLAu4ONeIjcBu
	HfuWi3sTVn7XDQUvHU2SZK+RtEWmS3xIgl3bRqekA0q3nUmG6qR/EQz8Q4uqbYZbTvuiehN
	8ao6OTwk2fgANGtaPPbPTpi0By4WWOkgqhNtuCP471Sppfc8BMOLBtcbOpdlCBNVtvAdk4J
	PltNWVD6kNAPIRRHSUzfUtAms6WYrUO1d+O0yfMgNQjcVfV1mABOLIcCsCetN9h4g2Ke4h2
	CdUX8bgIHHWKVnPUBMghEbE1b9qd4+4LsnLF5rVuHj52qY6zibGFssEhhixfuK4HexbbwQq
	6sBryExLmvMThCoOnZMImfIpn2T7QFDqklFfTaksOEFSt9PNFrerbufvhHu1snxt3257XxT
	qtqF0Sgre10=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9371315004211221537
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
Subject: [PATCH net-next v5 8/8] net: wangxun: add ethtool_ops for msglevel
Date: Thu, 14 Dec 2023 10:54:56 +0800
Message-Id: <20231214025456.1387175-9-jiawenwu@trustnetic.com>
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
index 6d16150f0bbd..ee49bd3ce51a 100644
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
index 7148ff8333db..5d16e5712d77 100644
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


