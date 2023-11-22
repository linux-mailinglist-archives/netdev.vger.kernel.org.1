Return-Path: <netdev+bounces-50008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7C57F43E0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1CEB20FEC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6E584E2;
	Wed, 22 Nov 2023 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83971197
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:28:54 -0800 (PST)
X-QQ-mid: bizesmtp82t1700648833tjpdo018
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 18:27:12 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: /gpUuYPpeIX8QSLzYBe3nM/NBvZFsF3POeCoXoHnL3e9PaweWr9wdZ2BaH/fk
	WXeVfS4t2WDfUcb1Xk7qKj4KbMQg6/XXfEbMi0qX6ETlrf+xzblmOOxpFfL6fCRS0BJuDTV
	HAguLZiEYBLQvnFXci1+bl8qC0rDN2VvyyQIU6FmjnFugyPmweZMCV37LvAGAq8oa9+tW0A
	DQ6msjyIRmUN2HC39BNaENpb8o/u4lZkc2vTcoq6gqWmdRnJRjEN53V+CVLpg9GdvxSMtBr
	zDOsa7ZnQ+ln65sU6asvmll+xpQuNV8X2jemXcp6WcXkw9Cf/Qs2B1A/CufWaClugKkvzSf
	AbuGxdEvAZfTT6ajMvrSODmjs8hGVsdROAgA9YDW5x83V9UaFiZFfCbEUWAvR3a1NWkNdNP
	cdFga4rI4fk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5822293344562643178
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 5/5] net: wangxun: add ethtool_ops for msglevel
Date: Wed, 22 Nov 2023 18:22:26 +0800
Message-Id: <20231122102226.986265-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231122102226.986265-1-jiawenwu@trustnetic.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
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
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c  | 16 ++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h  |  2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c |  2 ++
 .../net/ethernet/wangxun/txgbe/txgbe_ethtool.c   |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 4e467aa1cc19..f76227f2f544 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -369,3 +369,19 @@ int wx_set_channels(struct net_device *dev,
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
index 5b5af3689c04..73b6d7003569 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -29,4 +29,6 @@ void wx_get_channels(struct net_device *dev,
 		     struct ethtool_channels *ch);
 int wx_set_channels(struct net_device *dev,
 		    struct ethtool_channels *ch);
+u32 wx_get_msglevel(struct net_device *netdev);
+void wx_set_msglevel(struct net_device *netdev, u32 data);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index e4ac46242965..caeaf1dd95b7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -153,6 +153,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= ngbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 36cbc4e799b3..18408af6a860 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -126,6 +126,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= txgbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


