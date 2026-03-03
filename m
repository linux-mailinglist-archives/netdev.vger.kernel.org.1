Return-Path: <netdev+bounces-263008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NEfNs5PpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB91E84D1
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8FB3081059
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D537CD21;
	Tue,  3 Mar 2026 03:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475F3254A3
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507079; cv=none; b=G7Gvy5EprFknd+afNjWTBgW/RQp3m3XosiisucuT2UdmFuYgqbsJzQ/xW1Xs+V+4EnxCalpu5FGery+N0T7tNht5E7CI3Y+YJ7ZClFr8Tva5Vfi7WtvMkRwPtobISjFd0lfY3KY1FreUmyaxYyEpjBMo1JKtF8+PIBGFuir+aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507079; c=relaxed/simple;
	bh=yJJFgj/WVdeL8Img1+DR+YhtOlYj8YwfU9knQ95s+F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4pUlhijIEO6HVnMOASBvgEqDly2G35QhDjckpgjd5xutCFYaJh1GJbGD4RQll9NUbz13PdZNcJlAQfDeSdtcc85JrrjgmHo8VbEB19x8UbsYZnJs9sWtIdzLfMQ0K8tG1eIfdrCycBkZcGUmSyKSUUnaxqxjcsCVyWJpQRJU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507026t05f2c711
X-QQ-Originating-IP: 5nrjr4CbphkUtnzRwF3x5MCR5aGPSgsdqWXG7h3Xk9E=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:03:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12601811569188540251
EX-QQ-RecipientCnt: 18
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 1/9] net: ngbe: move the WOL functions to libwx
Date: Tue,  3 Mar 2026 11:03:23 +0800
Message-Id: <20260303030331.24076-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260303030331.24076-1-jiawenwu@trustnetic.com>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ocu70LrMHRlZSK5l8s/1P+fNnFozzfDOivpB0c6ruVQEbRt8tmjMwOjQ
	5dPqT6AjuG3kR95oFfwmbBUMRMTlIkNwfGC76Bnap81+oOxG+v5xGs7zFP/VP9UDbo3OENh
	GKGRiKLOLEesFPqJskDFNbsygrkVLTQT9NeOHQTg/A8BkUvUELYk2PgMqd39KtgWgBkxEf0
	QX9J6Xg5U1oMdRwhAxHlWk/LCLTd96YOmX9xa1N9R3SjqWZs+WZiASii4wguG0olVnr50pT
	CgzepPvs5NkvfZMmH3DYKfCktWmT33Zsuy0cahcKjiC18vyF2CcKybK0RiBNQ/Z8tTk5D7P
	kLXybG1MatftPdxlmc2QzfyFzt5Sl3Mq9dVLQ/nYOQsAwUpCZi3TDSU8cJU5yyYDJ6N42Zo
	D8s8hrxjd66J/CIqH1NimsNu7fo4iAIKAj77HVeZmXnvn1UuC9wXijB02lwkGB2ZJOE3ofM
	7bGgqKSSSh/TB7T0KkYPLZJe8+muJxzK5zlRq8igNc2xNGdxRko0x1hbfkuiucgN4XJ+Aby
	JpREMZmMvFZTDiaNl7/RnqWS3ZKiAfZnV0BTh7sppFopA5J1L1rC30hIMOz26uzprXhg2Lm
	bGU3vEITP3P1SJ3RfGcc4AL1US75XfIBmkJ7vhCBXjp4Gb5nkfQZkS8as7G9MdQQKt06iY2
	rkrcGhLGLHgN8JtKFHDASWm/i8AjSg9ymIovJRMDyu48vn7WD2aeFsrDPD2cOsbHbZ0s6PC
	2IsWTZ4NUj6VEmg/KBQ13tbnGlxGPBQBSngjYfsL8MCYwLg1p8Iyu6HT/NHNULtltxsIwwi
	3myXYW7DbnoVqPRFFJTyhqif9Rn/fDLVLdALNBoLWBSmSRhVikg7wz/5QU8NdEPJZd/K2zg
	A6mnrnX+MS+TBuZ6fbc+q8dHLstJXH0SOU3Vl3re/dtFE0qnOPDIS7MudxNp/1RCgdhQRV6
	vsbZEsE5i9AONDd40vemiueCDOkhgJJjtOS/k+YwCnBlxWQefbEfBzbvT0NsMAFe+So4jX1
	xqqpKQuictu00INQKScQtF23OCjUSIqYfzQa/w/HG0Tqr+OtrVU2Vfnc2CJi4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 40FB91E84D1
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
	TAGGED_FROM(0.00)[bounces-263008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.841];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


