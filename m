Return-Path: <netdev+bounces-296480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIC2NKOdJmp0ZwIAu9opvQ
	(envelope-from <netdev+bounces-296480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:46:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741856554E4
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296480-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A11305AA9A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A2388E42;
	Mon,  8 Jun 2026 10:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDD3B71BD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915230; cv=none; b=Jbj4lS/6/yfweezlU+m6dGymQn9JrVfny2Wj50ajDqlqMVH/DwG2ZD5Dw8HwId0kw53GmePPlfoHUeOZfoU9K7CzhkLv2K/cRES2LUg0R3b1Oeb4LP+we1lKR55Mw5V78bnZExP9aWHePOxJZ3N4xIcBGIQbYJDIKJXQfLLLgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915230; c=relaxed/simple;
	bh=JxnRAz7OtvaeNZPxtRVItUXeAAiiWPxZ+RD4Bm6JIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYUz4x/oYphST7P1fOzLVRDAUrV5GDn/Rda/cntonxXPaK+PqZG8lTYV42hkJANjIMjpebiXx9kO4mHlCOSsufJhJGqeLQuRfq+ulG4tCQAjMJI9Dg7BwOFUDHKfElQww6Ov3TmlnMXdBHvDbD9Y2tRZCYG70GkATNOQTdYvkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
X-QQ-mid: esmtpgz10t1780915191t481dadcd
X-QQ-Originating-IP: MGJmuGRkKW4X90GtJGTg3a12Ys+jszYez+0b9QsbJ3E=
Received: from localhost.localdomain ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 18:39:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10400062301939224614
EX-QQ-RecipientCnt: 6
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Mon,  8 Jun 2026 18:39:44 +0800
Message-Id: <20260608103946.25786-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260608103946.25786-1-mengyuanlou@net-swift.com>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OTOKxUKFeFTR7t8lqHKd0AcRPhmKNQF8qoItJz6Pg9F61Omde0xUIcNb
	X1xUYHdiipG6r485blyKIzmZXMxNq1TLlOrCbbN21HgMJ7+ZbRRaUPR4gin70wFowA6doY7
	d9R72TUiFVd/e1G/npOZNe7/xuvJ3konM3w9t6PZ7LQdMkYHaaGtPJzTIKrdMwMBist7McQ
	/zjmqUHqEeOl3EbMtGbQ59j5cDaPb3vgtsBbxNv7DSBlDTp0InLnK4WqK9EfSb8nGVkHftw
	mpxjXQ+VpRjtt4NyVVA9jvyfn0H80t3V2z11aJoBzUkAGzH/3sk6HOZHZp7AzCCQMoMmV2K
	SWHStp76hTBSrIlGjtvhBzxzuiH516vSSqB/D3HuKg6NNNYHPuhvKC47V5Oa81LapfGbeqt
	87l1bIEm28Mk84Qux24AAXqVg04cmtluIiVb4AzgZQVQheUscRCtu/LNlqV/N/L8NoN7DL+
	UO0rOGj3jyIXtoDCN+mIIEnLDZDufZ8rjSN1Q96Q6vHsxh6VlGZi/XuZyqjxsTFfY8Mu5Le
	2qIGgxO4hG3pL0X7Kx2QMZFHHPc5eeBSr7rosPPz9kn4o1pBvJJO8KgV64uM/vSAgnd8RYo
	7Y+Ii7tScj1dDsRSByf42LOtPoT8hN8AkjZ/hZt9s4RyqgBBQdgnYSj+KMd35dqXOevnM6N
	MrI4QMy0pRcSFLNLEQfxMLQRWDnlf90jNrhrb+j0Grj75wLjIptuDk4xCgsqR7i2I/+lbcN
	Api8LvGYR789qv37jk18NhqBNkrMbFRG5EAFnGbwjUmC9jrpXHSrM7tD23nRVvXfUwbDqK9
	Kv1h8L5KZV6If+vBiu9LRQ4XeBcSBBfsHk7x7/dcUjI3xwuyYvsoo4Tn3JQLNRUrcI/ioxn
	GLJ7n8KwTPb9OVzH2r8I5qSUgncC5nyDDGOwgjarg7zLyyl2RkVlrsdis47xOG9PrdkAIiU
	btmeAWlsrZzfYGCssTVEMbCS0vYNUef3rRDaTQRSZLCWPOns+HUmuKoItdF85Am3lTbA58X
	HvhVi4gp7jQYcl8kgPle2NOotOImlTRnE7jDpzpKXGEVOFRipvETLyh7K9DU921gKYhEdD2
	HRr3dpXBJ/81IBoIXn2XIOAFj57QuUCsJPtj8vElG5YFdUeATFlQULITaidt+j/Bkg7yDty
	hj5SoSGSTQMcQ7mvgME+5sEtLNSDt+cl2Kzox9qPv55NGwLsq9UPUzu45OcODn4tXsjM
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296480-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 741856554E4

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


