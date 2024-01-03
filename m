Return-Path: <netdev+bounces-61092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AED8226D0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 03:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7171F225FD
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A30136B;
	Wed,  3 Jan 2024 02:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725A1FBA
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp63t1704248109t9y7w1lp
Received: from wxdbg.localdomain.com ( [36.20.47.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jan 2024 10:15:08 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 2w1wQVt6itSJ4t4UkohjrXYhkjQUhRQXmtnBsK3PI7YB0ER74H2yIlBk7fMYE
	7F1eXXQe1Lzihs99Gjeex1PvV5uJ+YiSxCzenjPVMMDvygyHKrABvz0KU72oIyoBOBRhME2
	Z+zesllD5Ysst/GN6aZkl01OalLBAIRpkEuZocW3uBN5szEuaNVu4ZW4S2nMQouO94+ulAl
	iA64oQUYrUhnaj9i4yJilmXG2lulebFLN3HQVT5PuzXRjGdzUyTncnwjB6OP8O5+KECf0KP
	I5d5Bd3t20E2OnLl1hl2UV563vbknKsqQ2jrxg2Zfb6D2v9qt0PN09c4k5aGyoTd+rxj4Ur
	4PShpDPTdEWSlO9QPz5e84pYAvQ2oXWROqGZ/n4bQXqEYZQ/SyX0+Minb0hBtBwvrqKlZMm
	9TWbmodsyv4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10640750423024535590
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
Subject: [PATCH net-next v7 8/8] net: wangxun: add ethtool_ops for msglevel
Date: Wed,  3 Jan 2024 10:08:54 +0800
Message-Id: <20240103020854.1656604-9-jiawenwu@trustnetic.com>
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
index 96f417aea8e4..cc3bec42ed8e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -405,3 +405,19 @@ int wx_set_channels(struct net_device *dev,
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
index 348f3d8aca8b..786a652ae64f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -128,6 +128,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= ngbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 0f16c3fc0257..db675512ce4d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -92,6 +92,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= txgbe_set_channels,
+	.get_msglevel		= wx_get_msglevel,
+	.set_msglevel		= wx_set_msglevel,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


