Return-Path: <netdev+bounces-261744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NJSHN1JoWnWrwQAu9opvQ
	(envelope-from <netdev+bounces-261744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C467B1B4008
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647E131081DE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8AE3603C7;
	Fri, 27 Feb 2026 07:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E8345CDC
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177780; cv=none; b=fNmhXCRI7NuD+XaO62AH78Agk3Hy1Z0YBxujw8fcXjukmXkl3W5d6KgtLcKMISLlnAwkYg64mv6+Fol6Yuo3weEDbwZn3iOA/WgNvcGEXu4P0HXZwqlJ/ZsROuSjl3JURm5GwQI1Vjg+TEHwAO9qQWXxlRkQHYNXcEuhpZq1XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177780; c=relaxed/simple;
	bh=yJJFgj/WVdeL8Img1+DR+YhtOlYj8YwfU9knQ95s+F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfzsI79iKrh16JdZSdE4E9WvU0I6sLrGHGocQmopDF5OBBRfN9SaBeocdCl4zu2Q6tC4+0gPOaVvQChSyYaUhJ2Od3JzPmcBYOnZTpuqs6vInlD31ucpOjd63L5sqHdQau2s/YmJzkTTJTdBABBwCzFABJMLxz76HLuF9dqNKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177704t8ec798de
X-QQ-Originating-IP: bTH2dqk5Cvygm8+1gGMtv4r/5XgtnpNIulDqDcopXRU=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17306825846419217133
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
Subject: [PATCH net-next v2 1/8] net: ngbe: move the WOL functions to libwx
Date: Fri, 27 Feb 2026 15:34:43 +0800
Message-Id: <20260227073450.23680-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260227073450.23680-1-jiawenwu@trustnetic.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mr60+xGCU1pW7cn4tVWFQHvinTaLwu9lMGiD1ih0XXlu+810ZpPPM2YP
	nHbRytBWt7RWUEDbxe7FATUsDj/Hv8gQRAqEG7UnwVjz4Oua5nAU8mgK/CZs22iBbxoE4Zg
	MAzLGRnQQjNnNNrV7sOl5n2vz7ZZ5Z0wPiWOnwBTnrRHn6mf7jy3kSyaNWhCmNZkQ1hpZwX
	QGsYdOFl+DwQBjLKHWqLY0Ts73NfXYf6RUOI5XZF4Tfhp8z2L1MUTIHEo36wBEoPHbGdhPr
	eYcaXFjWiSrzdG2ulXns/YSCxmxV/rJo4fX0v6JM2JJNDogAsMXmDDEk+xKl9FEb2xZr9K1
	lV0HxscXhgwV0r6wTmNzj3FnSd3w6BkppoYpgvo0S9qQO5cSIfZKR84p9NyJJki6pdok9Aa
	JCRX1qfJXHuWKl+DYnJOHUBLnRyuUUdYuYks87wA/Zhy2mLxdgpoqvFy/TepenbhnXpvvyw
	aHdI0eN8mBLmParhQaz0Wn7s7FpZnD0u6IdZkxBY7/2bLPz84IggCV3qGHncXXXFYGSCMcI
	ip3rbVW81BRs1tPoqrEMHz1UKvGOO91lHw+1dBX7QiNMWKXlG+bjAH6L8QMx3UGd9FPe0Ws
	kUug99EwJq8+WPP0RtrvIEx/vovV7Z3DRSxX+0FGoiRyIBIHxr6AjrPJltfHHizAPAja3mI
	pjT3ZnnW0LOcDQvuh7xZg//0WGQ6KoONUBMFOzoLgMYP4ZEZjP7ypjmQZYpskwI3NxjHg5r
	wiUN4G+BWBMSGl84HH0rMREkyeDnVUoxEi8sRhlXDs2FVeAwdfm3Hb2ZkeCe4wOkT9Ixd6g
	qghcfZlhIf6tLZ6AMq8+FmnaqDJuUyMwUdwYg5P4p6BTiyxpfz1svdlEpNfgz9nsCeU4w55
	exEFSbULq/zCh2MOE5xq8zsTZz/HuKLC5PUafgW4bIqQgbP2fIXM4/uY1UoL7lKh/7vUqZv
	DpRGvN9b4XCHlkHEG3j2JPYNNnFgtJ5SaaOXUNN3EUBk53R3nXDkHHtQcWMgy/0YSjLBQBO
	wt6sKs5wk8KBM7GwD9EC5XINFCRe/wAYB8olDVDDVowdCS4uXzMXBb/TGhqiFW1H9Kc5NpC
	TJwQOHsOcdZkx3urvb7MuIUfV9g0v9g6Jn04wTvjHyS
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261744-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: C467B1B4008
X-Rspamd-Action: no action

Remove duplicate-defined register macros, move the WOL implementation to
the library module. So that the WOL functions can be reused in txgbe
later.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 34 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 36 ++-----------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 12 +++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 14 --------
 5 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index f362e51c73ee..9e940ea9cb8b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -262,6 +262,40 @@ int wx_set_link_ksettings(struct net_device *netdev,
 }
 EXPORT_SYMBOL(wx_set_link_ksettings);
 
+void wx_get_wol(struct net_device *netdev,
+		struct ethtool_wolinfo *wol)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (!wx->wol_hw_supported)
+		return;
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+	if (wx->wol & WX_PSR_WKUP_CTL_MAG)
+		wol->wolopts |= WAKE_MAGIC;
+}
+EXPORT_SYMBOL(wx_get_wol);
+
+int wx_set_wol(struct net_device *netdev,
+	       struct ethtool_wolinfo *wol)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct pci_dev *pdev = wx->pdev;
+
+	if (!wx->wol_hw_supported)
+		return -EOPNOTSUPP;
+
+	wx->wol = 0;
+	if (wol->wolopts & WAKE_MAGIC)
+		wx->wol = WX_PSR_WKUP_CTL_MAG;
+	netdev->ethtool->wol_enabled = !!(wx->wol);
+	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
+	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_wol);
+
 void wx_get_pauseparam(struct net_device *netdev,
 		       struct ethtool_pauseparam *pause)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 727093970462..5b187d1587b1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -18,6 +18,10 @@ int wx_get_link_ksettings(struct net_device *netdev,
 			  struct ethtool_link_ksettings *cmd);
 int wx_set_link_ksettings(struct net_device *netdev,
 			  const struct ethtool_link_ksettings *cmd);
+void wx_get_wol(struct net_device *netdev,
+		struct ethtool_wolinfo *wol);
+int wx_set_wol(struct net_device *netdev,
+	       struct ethtool_wolinfo *wol);
 void wx_get_pauseparam(struct net_device *netdev,
 		       struct ethtool_pauseparam *pause);
 int wx_set_pauseparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index fc04040957bf..2b6356622a13 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -12,38 +12,6 @@
 #include "ngbe_ethtool.h"
 #include "ngbe_type.h"
 
-static void ngbe_get_wol(struct net_device *netdev,
-			 struct ethtool_wolinfo *wol)
-{
-	struct wx *wx = netdev_priv(netdev);
-
-	if (!wx->wol_hw_supported)
-		return;
-	wol->supported = WAKE_MAGIC;
-	wol->wolopts = 0;
-	if (wx->wol & WX_PSR_WKUP_CTL_MAG)
-		wol->wolopts |= WAKE_MAGIC;
-}
-
-static int ngbe_set_wol(struct net_device *netdev,
-			struct ethtool_wolinfo *wol)
-{
-	struct wx *wx = netdev_priv(netdev);
-	struct pci_dev *pdev = wx->pdev;
-
-	if (!wx->wol_hw_supported)
-		return -EOPNOTSUPP;
-
-	wx->wol = 0;
-	if (wol->wolopts & WAKE_MAGIC)
-		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->ethtool->wol_enabled = !!(wx->wol);
-	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
-
-	return 0;
-}
-
 static int ngbe_set_ringparam(struct net_device *netdev,
 			      struct ethtool_ringparam *ring,
 			      struct kernel_ethtool_ringparam *kernel_ring,
@@ -122,8 +90,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_link_ksettings	= wx_get_link_ksettings,
 	.set_link_ksettings	= wx_set_link_ksettings,
 	.nway_reset		= wx_nway_reset,
-	.get_wol		= ngbe_get_wol,
-	.set_wol		= ngbe_set_wol,
+	.get_wol		= wx_get_wol,
+	.set_wol		= wx_set_wol,
 	.get_sset_count		= wx_get_sset_count,
 	.get_strings		= wx_get_strings,
 	.get_ethtool_stats	= wx_get_ethtool_stats,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 58488e138beb..e28ddf684a06 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -58,14 +58,14 @@ static void ngbe_init_type_code(struct wx *wx)
 	wx->mac.type = wx_mac_em;
 	type_mask = (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
 	ncsi_mask = wx->subsystem_device_id & NGBE_NCSI_MASK;
-	wol_mask = wx->subsystem_device_id & NGBE_WOL_MASK;
+	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
 
 	val = rd32(wx, WX_CFG_PORT_ST);
 	wx->mac_type = (val & BIT(7)) >> 7 ?
 		       em_mac_type_rgmii :
 		       em_mac_type_mdi;
 
-	wx->wol_hw_supported = (wol_mask == NGBE_WOL_SUP) ? 1 : 0;
+	wx->wol_hw_supported = (wol_mask == WX_WOL_SUP) ? 1 : 0;
 	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
 			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
 
@@ -520,9 +520,9 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	if (wufc) {
 		wx_set_rx_mode(netdev);
 		wx_configure_rx(wx);
-		wr32(wx, NGBE_PSR_WKUP_CTL, wufc);
+		wr32(wx, WX_PSR_WKUP_CTL, wufc);
 	} else {
-		wr32(wx, NGBE_PSR_WKUP_CTL, 0);
+		wr32(wx, WX_PSR_WKUP_CTL, 0);
 	}
 	pci_wake_from_d3(pdev, !!wufc);
 	*enable_wake = !!wufc;
@@ -742,10 +742,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	wx->wol = 0;
 	if (wx->wol_hw_supported)
-		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
+		wx->wol = WX_PSR_WKUP_CTL_MAG;
 
 	netdev->ethtool->wol_enabled = !!(wx->wol);
-	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
+	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
 
 	/* Save off EEPROM version number and Option Rom version which
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 3b2ca7f47e33..f1957fa0add4 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -39,8 +39,6 @@
 
 #define NGBE_NCSI_SUP				0x8000
 #define NGBE_NCSI_MASK				0x8000
-#define NGBE_WOL_SUP				0x4000
-#define NGBE_WOL_MASK				0x4000
 
 /**************** EM Registers ****************************/
 /* chip control Registers */
@@ -93,18 +91,6 @@
 #define NGBE_CFG_LAN_SPEED			0x14440
 #define NGBE_CFG_PORT_ST			0x14404
 
-/* Wake up registers */
-#define NGBE_PSR_WKUP_CTL			0x15B80
-/* Wake Up Filter Control Bit */
-#define NGBE_PSR_WKUP_CTL_LNKC			BIT(0) /* Link Status Change Wakeup Enable*/
-#define NGBE_PSR_WKUP_CTL_MAG			BIT(1) /* Magic Packet Wakeup Enable */
-#define NGBE_PSR_WKUP_CTL_EX			BIT(2) /* Directed Exact Wakeup Enable */
-#define NGBE_PSR_WKUP_CTL_MC			BIT(3) /* Directed Multicast Wakeup Enable*/
-#define NGBE_PSR_WKUP_CTL_BC			BIT(4) /* Broadcast Wakeup Enable */
-#define NGBE_PSR_WKUP_CTL_ARP			BIT(5) /* ARP Request Packet Wakeup Enable*/
-#define NGBE_PSR_WKUP_CTL_IPV4			BIT(6) /* Directed IPv4 Pkt Wakeup Enable */
-#define NGBE_PSR_WKUP_CTL_IPV6			BIT(7) /* Directed IPv6 Pkt Wakeup Enable */
-
 #define NGBE_FW_EEPROM_CHECKSUM_CMD		0xE9
 #define NGBE_FW_NVM_DATA_OFFSET			3
 #define NGBE_FW_CMD_DEFAULT_CHECKSUM		0xFF /* checksum always 0xFF */
-- 
2.48.1


