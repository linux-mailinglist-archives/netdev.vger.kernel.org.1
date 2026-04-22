Return-Path: <netdev+bounces-280372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALVOKT6d6GlNNQIAu9opvQ
	(envelope-from <netdev+bounces-280372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:04:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C7444682
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 329D530C73A9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9F3CAE8C;
	Wed, 22 Apr 2026 09:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908A53CB2D8
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851849; cv=none; b=aSuhhRipYIYOX1G5hwfCYAuJVwu3HAFa6/bSykPZswQL9NJxPda5q1DfoQ9Jemfad89RkfbNiIv5F8jso5bFD0cEFNkhR1cMNJl2DHlVB5q4jEdkasi0C6+WJsOB6iFF0BA59nscouWjEJaq0VZg6Nq7yHPiMXG4HbSPtSCdMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851849; c=relaxed/simple;
	bh=yuVuXoD3a/um8dkjzYTvT0DMFNMMVUYDJEwbmDJS5BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLaUo+wnm61cqjCL1H89W1gjzvqDegxswCcfPQYqQbTMKiaDQyQ/LFWVOOxQBAQEs5a//TVlb1M+AO+TS5jJsml+cHA6rk+Bl9GSWv/pg0WyeS+ROBWryreLY0tFwxhqdqO03LZHPGbtYmJVzRluYKM9HyaV2gT8auL+N+vxqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1776851800t0f007c89
X-QQ-Originating-IP: yS2jjjVRkWIfemqOmnV9Je52Fr6jCOkn3sxQsw84/vc=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 17:56:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15654093085467248494
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RFC PATCH net-next 3/5] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Wed, 22 Apr 2026 17:56:15 +0800
Message-Id: <20260422095617.27080-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260422095617.27080-1-jiawenwu@trustnetic.com>
References: <20260422095617.27080-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NIYZTvZremrNVxEkTTl+ZOoGR8tHWvWgX653fNka2rvhx4zaOIUswTm8
	Kzb05NaNExoMo2rKK/SAOCQdCbh2Ldoq88ZWKW3A3QoLtI6joz96TqRcLWRoA+AgaRud2kI
	INSyhy2O50ZnFP0aD5yiKPOXFr9imKx+qBQxEbawqnOj7yrKzJrT8ReAWqZTl14VvLVG/+W
	TfP/xs0d2AF19MQOgZ8blt3rq9NrgLqseR2pMWM9DtHcVqkN2D1zdKImsct5kdyWxdywrn9
	9Tp5wgnDNSHiPZF4m3UThc8W6cCik+C9JoqxB0sf+y/QjFgLEIQThh7cM2f4OzTciO+6aRR
	hQgGxMrP+AEk3e6r3pLFKSrf/M3lUIMFG6OF/Wcr8XFDZF7OlKRPfrVZ5X5Lq26nkRbFOzr
	khNg56Co60bft/lgoKhIdmu7R8zW56vY/5oW0mVlRg/5GqChI/x+/cDN38NYSRWjrE0eBg1
	pCD8IFCS9bz+5pExnUu8BWYHc5qW3n5tT3A6OkaGxmqQutrjceKdUWJ3OV+c9rvORfylFQY
	1DSFwUmThZo7fTg0rqDFdmgkykopXvYzenn17zntebAtujtGH5AQVnZ4H+atAPYqXopeN1C
	jf1P2gVbB8ZTTfrDP52afQyxCSBkNP4G6Pjmdo0Dj2U4UdaZzorfxN5j7JcW5/M7uUW/3D6
	AKVVfYmXzjkYLtQsMaWx2JVp8pip9k9SoLmt46zpgIf3PamerWPHgqrLoz0CEV1LE+uoD59
	5GJBwG9TJ5MB+1bX6r+vxXtce8Oj87V3anv9COwF2oKMLfkR7R3pZsD0EQYE0VmkCBen4nk
	spQWDc+2PZfNBhfDvSmTB+jRj8AdBddTmMyPVXHekM3rT0Cikh1L/1TvM/V8bPgiJeRbWVS
	W/6SWCFTpgmK5BEc4g8W9ZThNupccf/KW1yvbtO0OxDboWZk4eL/uSU4DOVNHomwuIZdjsB
	BLTXyuxd0CI1EatME/nJc+sowki6+Ze2refIAe0uOhBaIjrdG+8YbAR+wkP7SEbwUaHtbbW
	b/1uOM0+Kf3iwUM7AqVIWOEHh/Xz4bucP0G5mqyxDyy0ABKwm5eCcUnSh7fyWJR4UvzQFpE
	1CdZiti7Bpy+0+7yO2A6sN340ALny1jYw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA0C7444682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To implement a simple hardware reset without tearing down the network
interface state, introduce a boolean 'reinit' parameter to wx->do_reset
callback.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c     | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index 42e00f0bd8da..e7c9dcb148b5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -23,7 +23,7 @@ static void wx_reset_subtask(struct wx *wx)
 
 	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
 		if (wx->do_reset)
-			wx->do_reset(wx->netdev);
+			wx->do_reset(wx->netdev, true);
 	}
 
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..d1356ff5d69b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -395,7 +395,7 @@ static void wx_update_rsc(struct wx *wx)
 
 	/* reset the device to apply the new RSC setting */
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 }
 
 int wx_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 9e6167b43f75..3216dee778be 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3146,7 +3146,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3196,7 +3196,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index f65c2d7bae39..671ac0a19dee 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1402,7 +1402,7 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
-	void (*do_reset)(struct net_device *netdev);
+	void (*do_reset)(struct net_device *netdev, bool reinit);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e9561996b970..ec14dd47cd42 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -629,11 +629,11 @@ static void ngbe_reinit_locked(struct wx *wx)
 	mutex_unlock(&wx->reset_lock);
 }
 
-void ngbe_do_reset(struct net_device *netdev)
+void ngbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		ngbe_reinit_locked(wx);
 	else
 		ngbe_reset(wx);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 4f648f272c08..c9233dc7ae50 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,6 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
-void ngbe_do_reset(struct net_device *netdev);
+void ngbe_do_reset(struct net_device *netdev, bool reinit);
 
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index b13c48507374..f6050775af71 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -613,11 +613,11 @@ static void txgbe_reinit_locked(struct wx *wx)
 	mutex_unlock(&wx->reset_lock);
 }
 
-void txgbe_do_reset(struct net_device *netdev)
+void txgbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		txgbe_reinit_locked(wx);
 	else
 		txgbe_reset(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 6b05f32b4a01..1e373f7fd9b5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -313,7 +313,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
-void txgbe_do_reset(struct net_device *netdev);
+void txgbe_do_reset(struct net_device *netdev, bool reinit);
 
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
-- 
2.51.0


