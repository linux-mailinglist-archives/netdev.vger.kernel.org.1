Return-Path: <netdev+bounces-303571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DubrECfnRGpl2woAu9opvQ
	(envelope-from <netdev+bounces-303571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B06EBE94
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:08:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303571-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F136F302737A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55A3FAE04;
	Wed,  1 Jul 2026 10:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76A3EAC74
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:02:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900164; cv=none; b=OdAQshfZ+Fw3Lq0RqAJmvnhqQhrL72EPU6Ps8g2cMmqhk+fTiulCIymPkx16gE63H/Uqc+4+HHd+Zc6QpJ87KgBSmCYpOOC3XcGwxJIvRPNKjc4oLVr3F3MGcxZTEer/HCl/O1FKaO0ZgPQFgga1YxZshB//L1pVA3FPbotIseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900164; c=relaxed/simple;
	bh=PhAGNmSo69Z2m6XNhnVOoP106UEeayX8JsvFki6CVo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGCtPaowFGH8HZZCX2y1qqGBTgUMGEEK5bYw3Goj7K6S+GzpVUc6VbgNBhhdoGdRPeFbLpO8J7c0ANfG1PkqiiwHW+cERoUJtIOQt0hC/6iqGCcCmvtuaKQMtAJnrt+QDqqRC118IdSjtBFmHYrlPLxR+dWXKIGWah/Em/6+CWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: zesmtpgz4t1782900115t6266496b
X-QQ-Originating-IP: k3+kHaNuopit1xeUx9ilhiZiyVIhS5MsqvSuU80dS1w=
Received: from localhost.localdomain ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 18:01:54 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16115072362845468618
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Wed,  1 Jul 2026 18:01:43 +0800
Message-Id: <20260701100145.23738-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260701100145.23738-1-mengyuanlou@net-swift.com>
References: <20260701100145.23738-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N/qyVNBeLtyyPPz2yZXZYAf/vGueTDXJQILe5Wd/y6jpMwH9GemYtUXo
	p1M0i+Bbd9ftR2vFgk2jrbNbXjkVHTWbpUHH7Oa2ZSwEKF3lE4xJX2KcOeQkHcjEOaNutgD
	UolJkmn7WepLaQJd3UwAyLpEm52JreWb1aD4M7W8eDRoC7zLEMiuQE9N/j4gCwC+3cgVQ/R
	hTMEPYb7W9f/KO75WQZ4mbDUyiq4fPXy7mQQf7fC5Eotk/HkMTbzyQeoUy+vPn7ARaGpxD8
	cb+hswghe5nFVQkAqaHriWK93GXGS5UgkRhQhHv4p1K3c9NNy1K8fz8YdnmBRu1HkZxcolt
	HMjRSGTuupeo3wicmTmbM5XDOW7ZZBUTdGdJBfa73CcfYVsn6HFcp0FJKdSwo5lmFmXoZ+3
	AjKKKk+1MtVCkWRI2Z0aPV05lW29NmXQRjkhkTDCh+M7zjOqh7iMPxg1nwHZ8SU/Wb16p1g
	Q44D3zdirM0lrU/tjC7RmxJgPvSEMjyikrJ3Aycu4rX7Xa3dRres6Ut0c7bUA3757zCc/XY
	IoAdfxVPfhtLiG7YpO4ImJ47EWOPqyDFKJRePaADUZiSy7HVXEGSRvbWW9LucLZGVYmlPWz
	aY2Myct5j0OFrQKoi+D7CGSw6kmMQp/NOWsh3v8ZNWJYaLKsvtNmzLCIO+b+lmG5hUsVvSi
	QMfyqKy9s+IB+NWV1L9EjTqDwMl2jNWiK2f+j//0Q+2HY07zX1Xd9oc9G/vCoQVk6I7mGfp
	lFZBoLDqRx8DRyoPE+WJiuR3E7axJbTA7bGvecX8P0OZM8ZPinfH8DpWz8GBMSI9c8oQDv1
	8K5nIcCPa8IYCPEvLq53bZFv+3J7LoQZWYCCUK5yOwN9go7XqhQdjKdMaRJJQpvtJ86H9rU
	WB4t78lGMA/IZq0U65eDUYClLsEbOGgMvNx7pbBtAqzQQCCxBcnVytnb/GqwWn4yB/2z4Tt
	96napc4W6hF+ONzdyVVLwnpxYJ59eWjjsK79bgR7W2/fBxNuqEJKw2TKmnhLscZ9k1W4tBl
	CYjmktyi6Yl4xjxQvYndg5QoFW60y5NKM+sOroZw2sAzqO13Wf9ZIV3yEYrEczbUBDAiSoo
	kTXGN+xwh2avQjx0m5dDlNWA62O7jndUtq9Mjq3buUT9s019ZjIG4/1bc1zyTLzicNIEPkW
	8wlXJZn1W9CcrFDYp6Cucfvywg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303571-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,net-swift.com:email,net-swift.com:mid,net-swift.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE6B06EBE94

Add support for the set_ringparam in wx_ethtool_ops_vf,
which is used to set ring sizes for ngbevf and txgbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 61 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 5 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..eae038df6875 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -9,6 +9,7 @@
 #include "wx_ethtool.h"
 #include "wx_hw.h"
 #include "wx_lib.h"
+#include "wx_vf_common.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -775,6 +776,65 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
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
+	/* wx_set_ring() may partially apply changes before
+	 * returning an error. The error indicates that not all
+	 * requested ring parameters could be configured.
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
@@ -782,6 +842,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
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


