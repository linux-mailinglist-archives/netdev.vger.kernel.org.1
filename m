Return-Path: <netdev+bounces-53422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331B802E7C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2E01F2101B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABD171B6;
	Mon,  4 Dec 2023 09:26:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DEAC3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:26:15 -0800 (PST)
X-QQ-mid: bizesmtp89t1701681847t8imkzv4
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 17:24:06 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3jxuQy5k5GqbE50CSWJ+8av/F2+dmg8zX1HuCW6VJj6kKK0U3AZh
	hG6bRP7dn11+CXGy1Q+07SbS8clD++MvMxxO5M/J2oh9Hw2Mjqnd+cKRUx9lWwzxQY8L3vS
	cb5XyIZYN5Dz1dsd9x/HDAkHvz6zJwLBxod93LUtrsPdMCsaWsBeq9ZN1AW226ifVUuRtK3
	4CMt+G9cBaK3KLykhiBY8HD4xhsMMErzMNnB8xbELtpLSCkVg0m2ZlQmEuDPVm5cA82QSG9
	jv/4MryPLhTBGZBLvkNwbUZ8MxnzN8dm2gGd1je32sMumTiJM2Fhfsy7JDc5ZUn6UpxCQDt
	sEjfdU6PVuuS92mUfRY9N6wK8b0EQ0BmsscTkXOK25JJo4rD2Gl9WYuvhrmK35Chu/jp2EZ
	uvAVnfl5nz8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14253337410874341189
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
Subject: [PATCH net-next v2 7/7] net: wangxun: add ethtool_ops for msglevel
Date: Mon,  4 Dec 2023 17:19:05 +0800
Message-Id: <20231204091905.1186255-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
References: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
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
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c  | 16 ++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h  |  2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c |  2 ++
 .../net/ethernet/wangxun/txgbe/txgbe_ethtool.c   |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 864c1ba78365..bc34b1d7fc0a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -414,3 +414,19 @@ int wx_set_channels(struct net_device *dev,
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
index 8c7bcd9dbfe1..c0297172f506 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -123,6 +123,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= ngbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index fb499ea72991..e377ae61a543 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -87,6 +87,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= txgbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


