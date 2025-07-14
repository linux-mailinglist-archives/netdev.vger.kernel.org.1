Return-Path: <netdev+bounces-206599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDAB03AD1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B27189E01D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4521C174;
	Mon, 14 Jul 2025 09:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337423C4FF
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485414; cv=none; b=uCDpKchs9P5ECmx9cLCXChPZPeFGnrziKx08t3ZoPk2HrbqVvNSamsM4BHKSEZU3OkKHuRF1ZxrPuI6amqps9s+VqBjw2NBA5vK9YKRakRbRx3EgQKljS1O8uiaY1BLU/r2zU9dVj7BLWKwB+WVeaY3iOJYsHVGJNY7uDsPTU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485414; c=relaxed/simple;
	bh=pdrn7fWSIbyJ8Y0kOpcOpbrmdfUvU9g01P65GJ4TNpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpMdI4tzdB7OIRKyZMhNn3qSSMsq+eiSZjWZX6J+3NMX/dDBFsVFbMhwp1Zsnqa8wYaPsCcB25YTF2CR4PIkOsP+uvPZv9tDuwfaKzBJmGcNuRPPaQ+zhjAyDkXLZab/At9H8PjWsJio8upDkOsrs5QjgeoHvhsRgh00P0sYcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1752485320t715b896d
X-QQ-Originating-IP: qb1Nlph145zSWCt4CdXwns0R7NrmdrHLKHxlduIQ2Z0=
Received: from w-MS-7E16.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 17:28:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9081982586704226143
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: wangxun: complete ethtool coalesce options
Date: Mon, 14 Jul 2025 17:28:11 +0800
Message-ID: <3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw0DA4HvQHQXel9I/aQ95FoA/vB9RW66uK9Rg2ugkXrKoJfXo/nVLWFM
	ym/phKuIO0k0r/SE1G2V7SrJrW6/6do7YcxC1eOcHUcZF8aWYVITPuxhWQLHeJcSzYrfw+b
	M2hUBm3BwlmarUpibAcmzHTQ0/Y7nBVAdAhCXwFZfSHtGeLxQ33htt5rXFCOpF5gflqYs5v
	XGpe5b1KgK1VBya9FiM273NFtbdalrPrjsfzF4PS/P5YoX9cO3EPr7W3IRAGsfBICHHI1gc
	UW1p4NLhjiONgEm0s4s0HIqxUZYflaD7seCvqJHOEwaexYMZCA/YVh4KJc0seVdhDyD60Hr
	1AQtR9wBie5xUupOj/vXPH1gTVzgj/TGgU8aUMzGS5XMpZUiFbpH1MdBkR+dMAx9gucsNvp
	2i91VrgbyWoRq+nVrBPNUwVryRWlEYzbDYfK8lYrIZt4+tkr6unxlFddoZ6vqet5LFPgSaQ
	x4aMqa14tO+Yg1bVc9wHab/VxXTwKhLm3N73T42MKh+1366DSf2Puvika49PIvgfNBXRozq
	UyZ+fjlCPQZahZJAigsIOqgxCKVyJMf9jLnTvVfmO7qSNj2z/GJ1GSFpWDYxsbukmTSj7wJ
	Lq5XM7te2zpHlsPaxBLcEN0c9QtHAWCUFHsZbpeYjtF8m7uxGcDxknDJCeC6kE42QABEasT
	1c6nMaTW0zaKJ8u+m6g6o6XrQfGRFtAWto3hLvPZFP/r8IMEL2+sQpa/jwXEAHnh6mmgjmV
	m2bgQzUAk+79p11O5XpAMGPK1FpZv3YiwHVpp90r27enUylLolS7lGiS0a49fYurm4P6fBf
	OozVQD6xMR5HBZl5C+thbdvsUG+TDe9jsLYEYqGwaUwQGqZsIgdgfWdAhNeVXsOYfp4ypKI
	B/CBNbf+mk+wlMOdGo1hgybelkH6WQhBA0mMAld51pIea4oHJ5L4OpcGEI34hr4TEttS4wv
	5d588lB9Eve5y6YGM+r8p3yWHXJOAQfyHgZE76v07N8viTqPvTKd6ShozKWNEh8Um/JS5Tn
	NDjpJ44NZg4EpxSWsPnUepDlEHjvLMP7truAtE4Ue24Tcd7PjYhqq1Ryzs129qA5uhdrkFv
	mexqvYeF/JnW43HcBpluAAtCIK+lllGSQAZVz8mCyLsyOBC83v3TEg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Support to use adaptive RX coalescing. Change the default RX coalesce
usecs and limit the range of parameters for various types of devices,
according to their hardware design.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 48 ++++++++++++-------
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  4 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  3 +-
 5 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index d9de600e685a..cf7fc412a273 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -303,6 +303,9 @@ int wx_get_coalesce(struct net_device *netdev,
 	else
 		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
 
+	if (wx->rx_itr_setting == 1)
+		ec->use_adaptive_rx_coalesce = 1;
+
 	/* if in mixed tx/rx queues per vector mode, report only rx settings */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
 		return 0;
@@ -334,19 +337,28 @@ int wx_set_coalesce(struct net_device *netdev,
 			return -EOPNOTSUPP;
 	}
 
-	if (ec->tx_max_coalesced_frames_irq)
-		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
+	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
+	    !ec->tx_max_coalesced_frames_irq)
+		return -EINVAL;
+
+	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
 
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 		max_eitr = WX_SP_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		max_eitr = WX_AML_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	default:
 		max_eitr = WX_EM_MAX_EITR;
+		rx_itr_param = WX_7K_ITR;
+		tx_itr_param = WX_7K_ITR;
 		break;
 	}
 
@@ -354,14 +366,26 @@ int wx_set_coalesce(struct net_device *netdev,
 	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
 		return -EINVAL;
 
+	if (ec->use_adaptive_rx_coalesce) {
+		wx->rx_itr_setting = 1;
+		return 0;
+	}
+
+	/* restore to default rx-usecs value when adaptive itr turn off */
+	/* user shall turn off adaptive itr and set user-defined rx usecs value
+	 * in two cmds separately.
+	 */
+	if (wx->rx_itr_setting == 1) {
+		wx->rx_itr_setting = rx_itr_param;
+		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
+	}
+
 	if (ec->rx_coalesce_usecs > 1)
 		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting == 1)
-		rx_itr_param = WX_20K_ITR;
-	else
+	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
 
 	if (ec->tx_coalesce_usecs > 1)
@@ -369,20 +393,8 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
-	if (wx->tx_itr_setting == 1) {
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
-		case wx_mac_aml40:
-			tx_itr_param = WX_12K_ITR;
-			break;
-		default:
-			tx_itr_param = WX_20K_ITR;
-			break;
-		}
-	} else {
+	if (wx->tx_itr_setting != 1)
 		tx_itr_param = wx->tx_itr_setting;
-	}
 
 	/* mixed Rx/Tx */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c363379126c0..b632e5f80ad5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -411,6 +411,8 @@ enum WX_MSCA_CMD_value {
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
+#define WX_70K_ITR                   57
+#define WX_MAX_TX_WORK               65535
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 7e2d9ec38a30..2ca127a7aa77 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -115,7 +115,8 @@ static int ngbe_set_channels(struct net_device *dev,
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= wx_get_link_ksettings,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e0fc897b0a58..cb1b24a9ac6e 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -120,8 +120,8 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->rss_enabled = true;
 
 	/* enable itr by default in dynamic mode */
-	wx->rx_itr_setting = 1;
-	wx->tx_itr_setting = 1;
+	wx->rx_itr_setting = WX_7K_ITR;
+	wx->tx_itr_setting = WX_7K_ITR;
 
 	/* set default ring sizes */
 	wx->tx_ring_count = NGBE_DEFAULT_TXD;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index a4753402660e..86f3c106f1ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -538,7 +538,8 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-- 
2.48.1



