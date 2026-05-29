Return-Path: <netdev+bounces-293039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAptM7ZFGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1A5FED14
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC92300ACB5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6D3B2FCC;
	Fri, 29 May 2026 07:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A323C4F3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041126; cv=none; b=PiqIg9N3uqaoiwlZ4X1ND7BDm2sr9um+Cg0EMaT2QvxD6YMM8DB3p+EsTnD+5Grsl/IsjnU/Ljd3gTvQrxLqCHSRtZV5I3ttGx5shlOh5HFf+A2Y8fnZfj8MaEk04uSem2Sj1TYRDJXs+oQraDkLxNQ3F5pNRlDTMymgdnwk738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041126; c=relaxed/simple;
	bh=JxnRAz7OtvaeNZPxtRVItUXeAAiiWPxZ+RD4Bm6JIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxI7+lCLY8GRbKfpvApbF9ytskBo0LejJjEcdoYszBmV6zlc+Td3v7cDxkBmMxDFJoS62pDm5bXueXW+5MFsONelScvLlI57l4jLCu14+X23y6l071lKB06X8RuurJrzlpv1TH7YoGzEPXtJOGq4dPnMV97oOA+rGIfSNY/KM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1780041117t73bdede3
X-QQ-Originating-IP: EfAkxhpe0MC6fEBiLMNMTtEZ2eyiGVeu+TUib33ODPo=
Received: from localhost.localdomain ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 15:51:56 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4475392059451762684
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Fri, 29 May 2026 15:51:45 +0800
Message-Id: <20260529075147.88398-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260529075147.88398-1-mengyuanlou@net-swift.com>
References: <20260529075147.88398-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MMa4N5DwQO12l7tvkAD5qfT1kEV8xO4SK1eS/NGYliwMXl41hGtrMzst
	eN0GJmSHLydbZvm2VXg2d5WRZ+z9lntcpGfZLAfiNs8lJvTTqK/u36dbnzzu3dpbANhb2s0
	+1QkX5QRghPw/ER9u+0rsSxo0n7X5nTkk/zM5/5yHdKfBrhisGosl7NKtvNSEjLE7UFaarO
	1IKLAAY/k4SX65KSYQa02X7d95Q4ukAP+k4lT2ug97XALyHu61D9FVvX9DFoo+SDV7vOnf5
	J0Sr+VxCQ1gLohT9f64bgsfquqj6tmSVAf0Ejhi7Qjza5Yif9M2bouMudG6/7DnRXhQbHu4
	oQtdyLR8zliQVTHJwEaDK+fKlz+dJucFZSKsx6dic/ihvlp0x10Zn8YWd7NetJ72PTXx5wT
	CbycY/HhCtT0c1KlIgeOVtgA8XLZZwqImshR84qFbNIEJB7zmV6a+MZ6qjGuQNoECQXjv3l
	qtAje1LQqXXUDPKUPv1i982Dt7JAe47y0PFw1C2PtSk+ul7S4TnLYLJ+T+K7EkRy3okfEub
	dwWEp2rffU863Hd5HZ6GBXYC36PhQmccNi4PqluEcOMQSrNJkFgqd4wVyrTC9YCTsD22DK/
	YLF8DlEe/oOAgSPy71sdsAyeBBLpefJtaxz39JXQu42G8fXlStTEThblvOXU3lrwAJagm2s
	oTt9jDQQf8Pe70Lrw25tZd/Cu7PbBxttzEYwJ7mN8lAr/cqijSoNYtVAhMan1Hmsu2YLo89
	ijweUI9H5C/WUKma1ufZKigmeekO2W1NhTbO5sxQGkPLMAWyph2toRjHKkC1WAQZxFoRZlS
	vIL35smFS8jwvFRjpdSct1IZeK0Usd3fc47VDGAgMyuoeECuRgsNXtPtt5EtczFiLI21e53
	Q8N8ZrFpEYIVRB4BvdlMy6IlINXtft9iX3+76f0CyjOMoDwE5cZ4WgKt6EEqHZLucK07UBY
	aD0sGygW9MhbmhlKZr7kNnVqVfCNh9CV8nnQ6RnMK9WsJBA8JiKYgZjb3VpQKmAsmte+Z10
	zljD/ZY8kQS2WiAi3L2VrKq3U3oP0awbRLTSEqoflcjmV7R/S2Ka9wFKJamomK0RxYO2MCl
	CowD4VYUERyHaP/bXcSs4lQLsR167ilfV7SOFfKmWvicVulLG4qfgjPdoOAIU662Jn2XUbv
	MnBk
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293039-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,net-swift.com:mid,net-swift.com:email]
X-Rspamd-Queue-Id: 49D1A5FED14
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
index d042567b8128..2e5dba88d04a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3248,8 +3248,8 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(wx_features_check);
 
-void wx_set_ring(struct wx *wx, u32 new_tx_count,
-		 u32 new_rx_count, struct wx_ring *temp_ring)
+int wx_set_ring(struct wx *wx, u32 new_tx_count,
+		u32 new_rx_count, struct wx_ring *temp_ring)
 {
 	int i, err = 0;
 
@@ -3271,7 +3271,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_tx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3299,7 +3299,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_rx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3311,6 +3311,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 
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
index 0d2db8d38cd5..26de78e9a69e 100644
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
@@ -324,7 +324,7 @@ int wxvf_open(struct net_device *netdev)
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


