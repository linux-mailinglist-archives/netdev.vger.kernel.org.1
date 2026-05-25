Return-Path: <netdev+bounces-291285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OPjAKUgFGpjKAcAu9opvQ
	(envelope-from <netdev+bounces-291285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:12:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D71CF5C91C2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43399300B5B2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352BE33F5B2;
	Mon, 25 May 2026 10:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58913344025
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703906; cv=none; b=kXT7L1pUKhn5ErVqYZle7pdhvDfWWY4K7FLmkCyob1Zp/7ru1+dMJzBkkdXdSiLBAB/aAG9a2n/n9YHZMXPFcc0mMcxg+xF2qlnBequtHZj/1w6/mF9i8NSGj/UXjAqM1eH1JOz7OfNj7i/JRWjyPFutEN2KrGd9/gzVh/zIe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703906; c=relaxed/simple;
	bh=Hkw+Nr1fkAqiMxrJDrfR3ABk0ehz5DcA5BCyjqQqFVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgowpcudBn3WmZAZvWGDp+2NJ4oBVOzd02lZrCwg0TAAs9etlFby4VkGw5sqXzs9+726KVI+xqm8g7yDP5ncCrarImwELhqWzCAdpGwkVySIz5M0b/0n/RPIhcN67WyZpWBuh0uhG/6tyU8+x6nsf8ZdvaTfihn3IJx9Yake+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1779703892t3cc31a81
X-QQ-Originating-IP: uueMrl6Zy81D5AG/rYnR5vltdKI8ystDGiaOVFTAXAA=
Received: from localhost.localdomain ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:11:31 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6248796208129736148
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Mon, 25 May 2026 18:11:13 +0800
Message-Id: <20260525101115.13151-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260525101115.13151-1-mengyuanlou@net-swift.com>
References: <20260525101115.13151-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: ONNzAaE3j5jCo40/y31vhxTMzF0Ueo1QMGkQDX7mZaQ4WdO36sMehNxF
	ZIYv3Q1j+6EJgLIcjf+yQueEjUVjM76+vayWo+bvj969kTPD28stA7XqKxWvbK8JUFbev8i
	WDKhb0nw8pTqwYsQO6FlsnB5XJGonmvHFuiVEKB/DtiNbo1D0MeKa0g11GZQWoZ5/IkKnRK
	ciWexCfN2jI8/f4CXZTj/hbSM8bi7YiNlpxnTOj8MZ15mngWssXD8/Twygi4RGNMQHH7y0O
	IYnwSJo5NzddwxM94Xjgxu3AqLqzjQRXYjv3cDkRGWBNV1lZORpKZmlFnjqywKhbCPPhGMP
	6M/RgScL6G3LP8cyo6dCQ8sZrhkf6k6dXMKDHh4keXqWYVkQtSVXOS2TguieINsJQy/hArJ
	4EwlXRbQKiV71psq21hMHBvwIuOtPhyMwG0v+cJBGm+gKvAd73ojOP+RwAeiMTnZxRAshpG
	y16tfFfjy7hgHQOYxna+hVBt3y9+ZAT0iHQbpGZ3M4C0Yqy2QWxEbAJi2kmOAHuqzsW5F/B
	JurDoEeLXgknc45YJTwAVHdWoZGFBVm0RT9/m7uk7kG0SqelNJeE/BSMU5kM9uiylkzfp+p
	YErEDp2kWrsOgrUYwrUp7tc4SxGyT0l8VRB46GQjggzWFhuO/UMNqhp4Tc9+F66ZmJxaWVo
	N755rhzozvXCVEWb1ACydWphZBExgwzFtHBIvIz5mZteqRYUMJOg+V99F5dKjnFxS+fXsO3
	atkcc1/V0awJLGvuPWGQLjyA0qkf+nc2dAv5pYEyuBd2LHZBxxkjGULi98O9JKLwVajmBRz
	1BBJNZ8ouo3amYIxnHeEKQCos5eAhPKGAMRkLDVQKzkPn3tn/GKRO4L0U5NKzOjWEu/lnuB
	GRDEW0JmRbD4mAx/vxaPMdmCtT41b5mVrpAh/IILXTAO/F/FIltuQdWz3I7HKZKIS5aC21o
	g3wxTaj2TSoYtEeO8+e7qmzk4BSukUTJ1LpUa7GzTLObVA79XGnUzKGZ1RpNMgO36ksFCTI
	aYREZ38rQxY0e/9mk3tjbawjIkJwz9r/PcBXViLJWOy/huHWiYF0zfIyQVXFuMEtDI1Otyh
	CwEYw0DpgX2qZm5LiuHuy+0xKXg4z9VaVU0jQc59vNjpDvslm2PiBuLswvuaf5o/OH3NMhy
	EAuZ
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291285-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D71CF5C91C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the set_ringparam in wx_ethtool_ops_vf,
which is used to set ring sizes for ngbevf and txgbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 60 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 5 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..6d8fcddde6fa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -9,6 +9,7 @@
 #include "wx_ethtool.h"
 #include "wx_hw.h"
 #include "wx_lib.h"
+#include "wx_vf_common.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -775,6 +776,64 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
 	return 0;
 }
 
+static int wx_set_ringparam_vf(struct net_device *netdev,
+			       struct ethtool_ringparam *ring,
+			       struct kernel_ethtool_ringparam *kernel_ring,
+			       struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	struct wx_ring *temp_ring;
+	int i, err = 0;
+
+	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
+
+	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
+
+	if (new_tx_count == wx->tx_ring_count &&
+	    new_rx_count == wx->rx_ring_count)
+		return 0;
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	if (!netif_running(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			wx->tx_ring[i]->count = new_tx_count;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx->rx_ring[i]->count = new_rx_count;
+		wx->tx_ring_count = new_tx_count;
+		wx->rx_ring_count = new_rx_count;
+
+		goto clear_reset;
+	}
+
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = kvmalloc_objs(struct wx_ring, i);
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
+
+	wxvf_down(wx);
+	/* When set_ring fails, the count will not be updated.
+	 * It merely notifies that there is an error in the setting.
+	 */
+	err = wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
+	if (err)
+		wx_err(wx, "failed to set ring parameters: %d", err);
+	wx_configure_vf(wx);
+	wxvf_up_complete(wx);
+	kvfree(temp_ring);
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+	return err;
+}
+
 static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -782,6 +841,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 746623fa59b4..2f5d5ef639df 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3246,8 +3246,8 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(wx_features_check);
 
-void wx_set_ring(struct wx *wx, u32 new_tx_count,
-		 u32 new_rx_count, struct wx_ring *temp_ring)
+int wx_set_ring(struct wx *wx, u32 new_tx_count,
+		u32 new_rx_count, struct wx_ring *temp_ring)
 {
 	int i, err = 0;
 
@@ -3269,7 +3269,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_tx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3297,7 +3297,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_rx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3309,6 +3309,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 
 		wx->rx_ring_count = new_rx_count;
 	}
+	return 0;
 }
 EXPORT_SYMBOL(wx_set_ring);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..bc671786978e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -36,8 +36,8 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 netdev_features_t wx_features_check(struct sk_buff *skb,
 				    struct net_device *netdev,
 				    netdev_features_t features);
-void wx_set_ring(struct wx *wx, u32 new_tx_count,
-		 u32 new_rx_count, struct wx_ring *temp_ring);
+int wx_set_ring(struct wx *wx, u32 new_tx_count,
+		u32 new_rx_count, struct wx_ring *temp_ring);
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 94ff8f5f0b4c..a3361696b783 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -269,7 +269,7 @@ static void wxvf_irq_enable(struct wx *wx)
 	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
 }
 
-static void wxvf_up_complete(struct wx *wx)
+void wxvf_up_complete(struct wx *wx)
 {
 	/* Always set the carrier off */
 	netif_carrier_off(wx->netdev);
@@ -323,7 +323,7 @@ int wxvf_open(struct net_device *netdev)
 }
 EXPORT_SYMBOL(wxvf_open);
 
-static void wxvf_down(struct wx *wx)
+void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index cbbb1b178cb2..d45d5d8ac3ab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -15,7 +15,9 @@ void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
 void wxvf_watchdog_update_link(struct wx *wx);
+void wxvf_up_complete(struct wx *wx);
 int wxvf_open(struct net_device *netdev);
+void wxvf_down(struct wx *wx);
 int wxvf_close(struct net_device *netdev);
 void wxvf_init_service(struct wx *wx);
 
-- 
2.30.1


