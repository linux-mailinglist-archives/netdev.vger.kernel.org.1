Return-Path: <netdev+bounces-264690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH9pDlp1qmmuRwEAu9opvQ
	(envelope-from <netdev+bounces-264690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEA21C199
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4222B303B4DB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AF37107B;
	Fri,  6 Mar 2026 06:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD03288C2C
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778829; cv=none; b=qm0SlMo+mFwIx5NROz8Av71pZFy6pC1zUfQPIJO8qRDb9EBD/BM3Za/9grVtCdfQ/x7XfmfVxEXkw7zKql94lrPBLIsxGwM/N7sHQU/YspkW6H3q3/aETrdkcHrATnI3CjJZYh29yVY6DSGXGH7XCtxF66wBHSpVOxKFVrRL32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778829; c=relaxed/simple;
	bh=BvlJDg/zBO1yZyMn6i+wSG5NepPYDumV+ZD91h+8nZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOKPn90y9nLdu/qBUOh+acb+Bb04mfAuNpY5WJ0g+I29J6PdoyTy+7cmYlW3O/0+b5n6ECaZaUkvvk8d+zSg9iVmCnN9zQc+en+ysZwMVv8OPv9H81gr5OerkKAtp1P/r4XuM8cukkoTO5gzGEbzvJY94Gs403BkKlK+QqNELxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778768t8301b6a7
X-QQ-Originating-IP: wRsbbixxVMU7b3xdPa610xazgHBJcmdxBLPSYcuEoak=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2224502801172992657
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 02/10] net: ngbe: move the WOL functions to libwx
Date: Fri,  6 Mar 2026 14:32:03 +0800
Message-Id: <20260306063211.20536-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260306063211.20536-1-jiawenwu@trustnetic.com>
References: <20260306063211.20536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mv39S0orU04hamL4II1Tm+P0qBlOIDKzly3cKAdJ6tv9Ip2kaE7kLwR7
	JJww8HH1V+KsW0xZkXp2uY3joeAdtIXJ13xVNT7NF3ZY0VWqPl9VOZr6Pzy2e4QgAViLPe8
	QI85bnDmKXYuhRxh8VrGVBSNn4OBX6oXRvE/3VFMZdWtonFDSyQyLms2iL0hLlykUp5jC/U
	8GKMpqj5LdIIUhqEtZuM7+akjLhOpww3DqkDVVtG+LrmElU0OwYTyXut/u3K+4ZaENRp/bG
	CtVMtMXYXyP9mFRZO/gUlAAW18yr5Q2Azluk577CKfOuGGgD7sLFJurvQaNpf1ZyQF92N98
	EpY7HQ35slRKYcgxttGekt7gSX+45ekFOa2MUbhb2ZqcTOv6rwksnlKik4cH/5wwq3vH3+V
	+mV2OzA+lyzQTrNIDX4nPVbi5b19INETnA/WS+ILe+4kPiJagLqV57gIYNyr86QpQzYvCmC
	cTVyWfvEYzTcBnMn8jCzlRRlaCy+Ocxp7K6UNoBSxVWIk99OQhqpJiEQJyqmXASFSrkI2hk
	OapjoM0zeJ+D3qbtSZaSb4hF+/oXTtppmLOUqpjoD29hVGcpZy7muDDzXscJ1AXB+S9+e17
	p1sWUO3OnDQlq9Qd7AeNcLVwdEr/nkqD78kwnKAn7c+abxXKcMDuMLlMtXLSZSgUu7/Psrv
	8EI5X6lZO1ebuCurG9ga34SdE1+PWI0h5wTLw4t3xc6GzTdDyAj85muAYUFN+ybNOunzDvR
	d45baz/kxzBPH7UlpxR0ULyYJ9c42eP48nZuAUyKRtpBKYfWwyzIwzcmfl9d03gWx5dayOP
	v+ayQx6zwETxSBFm7thXTFTXwxAokY0aY40ZDW3wDdTpSL5pqmcjCz2yFJJ5yxHoQkO3gY3
	oWurONUhzzQTKP9A8w1sEDPF3iRHFcYcSW2ZFlRsqe06QPd0v0f/5YkoXeCZQdIlpnHRaOU
	ryzpvXUgvj7IShsr8c5XBNG4Ofz5oziT6Gd2iDFfiH+bB9vwX9w2Aaev7JkeknaUR9Cn1hC
	on/JzgGOBBdds6KXU6kwmlsQcRaAEAhO2yOzBcxBEG2cnuXvnTqoCE9+KmDNg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: D5AEA21C199
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


