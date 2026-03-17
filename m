Return-Path: <netdev+bounces-268462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDAjKVIFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D112A4F3E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47CB301468B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675F391833;
	Tue, 17 Mar 2026 07:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739F391505
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733172; cv=none; b=G2BTiP3Mw0Qx2TW8VHv6fmnrH1NxAAYLH1pkH1iju2AhiRV9wptAFq+Efr/4/p7JkxGEmHlVIcND4Xo9fSsohYmnJcodnMeg/P9UMzfU4rhbUDAEHOGod1JvISpsvC8V9YhjsJfoW7ZQAwkMo6KrddEnj6ULHUGBSXQcsLUpOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733172; c=relaxed/simple;
	bh=BvlJDg/zBO1yZyMn6i+wSG5NepPYDumV+ZD91h+8nZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wi1oH0KmoIfvZHFGFKx7Hv0jBcNcjo/dcrb6egBX12MC/tS+6sgpsvBRO5IhUeY4AmDVREA/ybDi8hvjDYbZl5QDwWYOMygANWHuzkaqdLP8uDE56/5YTD8BKiTPGHT/lO8v53WFrc84czpIwt51hAZa4MsYiQoBqE/cNI0m3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733125t8d1635ec
X-QQ-Originating-IP: io5rEzg7oBmyjaSy2KsqZeREiiG2Pi+EmZh+qQV+6I8=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8950795841799231099
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
Subject: [PATCH net-next v5 02/11] net: ngbe: move the WOL functions to libwx
Date: Tue, 17 Mar 2026 15:38:18 +0800
Message-Id: <20260317073827.4300-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260317073827.4300-1-jiawenwu@trustnetic.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NLt6YVICj3iUCfVnkE+yuWTYdJlz6U4FTzg0iDp2oI1oh6tyQm29vDhk
	iNo19f98BW1FfRw29i4NCTtdPgpzBxeoQjrFo/6zeE+woJ0bNyPcdEvOYw0QqTccPSbRsfN
	DUnAxH5uRJA7XLT6UHOxC1qOgQu6HsialVbZZDUshsGGhmDy3Tba76wv5jLURVDYkaFZmhS
	7cm80P0c4A6VhXOsXseFIdjZNoVTQ4aUpOWMD0OkMwoqb5jRNP//yO3iZnIHy0Wmi3wxnWG
	h9x87n9n8hqppnVLBpUyd8dhTZZUfHybLzHivw6DcHLluvrhxc/cfEcle1ts6w68WQmyMZy
	9awZCOKPhlJRfQR5HiHSfPlzj+nSdx2p29zfdGPSvjd3q8v2yN1TIfwCKvdtBeORyH8D+xF
	Y4Es7TAR1sX4GMunuc98vf6lRmJktGV/UwpZNLa57UPJGyRfrAEbh4SmAGOIPxuOC+nJPII
	rro2p+8jeoIHRo5T+6v+kgEnPzGrBFfiRpGm3r2ttIP8Qt12jIhVu4eCJSAsf5vMD0guCUC
	WOnnSM55ryDrwvedsH6qMS02JHHqP1qGa49mODYwVFo9qB3Ulkw7dlQYQ9CWrRxms6/GJ8x
	wgffs9lwcedG5eiGnwHn4i1BAAgpSVnJmdJEVCST7SNkAnVravb/gkAS0DZAC+f48437vzw
	TOO9li4zlUPIyUL7vhF4n8L4NK3mvNwPfG9mfklnJLGdTpikdWvJbyk/gw2DdZ+i4xNrCFm
	ClXl0eYNXsxbzXfnOgpevr2xjnfuA2JLO0thITLoQnH2lqKtRuUXINiudiIX4Coflu5pTJr
	rj6eq2nQP5S07jmE//pix/MTk3bkbymjJiZ88mGz/BFF4kHA8XaDPBaRaMOjHlg4pC8vqCx
	qD7HwV2ZqjW/wa/Ljn3LHPsBiUz8l1S0GmmguWj+IESg5EA3ucVURxESDi4o87C5+Qo1d6r
	HjFR3vaMLQRDNZKuKzfzSEWWa/YC2j2nfLwEKBL84UDu/l0EW5yR+utlrrYN+eUHLZ3tFr9
	/mbY6j3zD09nUDmiuzxe/xOXERgw+mH7L3zR/S/nVLKqaG3VLDBtAQzLA3q1jiu/kA/PpKq
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268462-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.805];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48D112A4F3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove duplicate-defined register macros, move the WOL implementation to
the library module. So that the WOL functions can be reused in txgbe
later.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 33 +++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 35 ++-----------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 12 +++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 14 --------
 5 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index f362e51c73ee..2de1170db8c7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -262,6 +262,39 @@ int wx_set_link_ksettings(struct net_device *netdev,
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
+	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
+	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
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
index 40779fee0fdf..2b6356622a13 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -12,37 +12,6 @@
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
-	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
-
-	return 0;
-}
-
 static int ngbe_set_ringparam(struct net_device *netdev,
 			      struct ethtool_ringparam *ring,
 			      struct kernel_ethtool_ringparam *kernel_ring,
@@ -121,8 +90,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
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


