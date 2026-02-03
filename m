Return-Path: <netdev+bounces-256180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHFVNQWrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:00:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975FD5ED4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D66303D313
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29146392C2A;
	Tue,  3 Feb 2026 07:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B525392C48
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105582; cv=none; b=hTAhkl9aKUqSA4u+Z3oWExNusBB414cvg+aNJ0i+ePQKl9O8kJ9/3zpuJOGN61nTP8sk27X9zMPJgY4xY1UfxJ2CMhAnfvGmZsP8JZhc4k7tBRPx0P1T0Po7kJDcKF0JzWcX0dw0haSF7fMKXDpep7wW8QCr6wzgQuNUDHhj1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105582; c=relaxed/simple;
	bh=pkba4hsQxsyT2hckqkFZsjyl4itJflTea7rzkrjV0DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cayKVYpZzjFcA2JHcKqdvXh287MSvsURkuQ466hPKXF+Jh2F9P0ZHHAzlMJIxuUuc74cADnOBcxubGjlAbWkDBW7/VU6RQ3Kqk7BxjIhNuLHB3U6B1Ba6Dkq0ADAhQvHwiIgB84yeJpuxWDK/lMTOMUmPKWZcQ8dtuOaIANFgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105507t3b265592
X-QQ-Originating-IP: fFRouYdSm0e0m7yJ4Fqj/EpOcUrjyuRWFvXoeHxH6cA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7878167116517507610
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
Subject: [PATCH net-next v1 4/7] net: txgbe: add power management support
Date: Tue,  3 Feb 2026 15:57:56 +0800
Message-Id: <20260203075759.5852-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260203075759.5852-1-jiawenwu@trustnetic.com>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mre+2s01GWHngXSvED7yfeVrjXGcAJWFEWzKcHYUXWjuK/JgMjvlfd4s
	8LdfBknseBRG9whzG1WHRwuP0a15vOcQi0D5FE/mxbQTw65y7GSloRhrNvnJREByO20fhmD
	AW/w6FoZ9T49V1gEIIZLYFmdyLt1fSZP9mGGBTlOsudDuU5M3wSbfhWpINQJvx7ZaHPjNzI
	a6yJ+fbhEgQ0Q+z1kKDSd6yl9MzboRoTpEU1ECwshbrWk8strDB+O42KmhBDs+cn+Yc8KCu
	seaTduSzJXPqJoXuE9YO1nw+59L9JPXg/Omz1CLJr0irxWLWP1HDBDjvNCioEYiz+y0AL0Q
	zK752hKG7ELCKs4bqLQZjZgih3LcBDTEEvRiNbPQP3AtdtUDkV7ymloDRj/cSU0gFlFhy27
	SYGAZqjQcKOSHOLM3xWlzbkV3kwkTE7Glkzebyd6Dvvruff2+4a0PilZeNeuav6SJYNsMiR
	Qih2Na66MgBhAof0yX4QIMTqN7c2J3fqB0F96GWei6vEQFGgHEQjL0ZKv4Pj822IcQqNvDo
	gKM6n62mfDDcp8V1ILB+2pzALWi1eBTO8L/lOXT72BMPjRCahSbZLtnk4Ez0xYp+UOQ6q1u
	bCPBwG+SF20cP25VIts0IBTaI4p2sSmh30FdCjwnZ90NVClOH6XjnL8z63qY1AfVYfcIa99
	nakhr06IGSJrrgiYKWcwEhy9EzQLecwuHvkE4AN3S2sV/OvAudnc6TThNGLWET9B/6RyUvw
	Cmqdsc2pshviHfuxP9HNX4f+QnWxNyYi3LFxPWr3VJOEbSPpL0aUD8KYp8b5oZFVZZ3AVpF
	ZbDjwTFHJqf/s/RzjThBXBUV6i4591By1aA1bh4yO3vOvNG78S8vgZBcnnTt1kTtAvkGxt9
	XnrhGqVQlby+oveyN4HAQu0EhMHxQkgDgsxVjqhcwvzoINt/Gsc3VQf7gV3K9eTChrEt26Q
	Dm1NlQMpTXieLVv/WM2rwqJbihRNh4jzEuG5Awhnnf/TRgn/Y2zvIbFSAB6vBGcGiJmvr38
	M1MXE+zSdMn1eN7+kHiA8SH0c9Y86npK0DtJI4P5sC2wu4DUAh4pye1Pzv2/EYcIJjAXCDn
	hUD2d5qpr/i
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256180-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6975FD5ED4
X-Rspamd-Action: no action

Support .suspend and .resume and Wake-on-LAN.

Implement ethtool ops .get_wol and .set_wol to support Wake-on-LAN
function. WOL requires hardware board support which is identified by
subsystem device ID. Magic packets are checked by firmware, and
currently only WAKE_MAGIC is supported.

And WOL related operations are added to txgbe_shutdown(), it matches the
implementation of wx_shutdown(). So change to call wx_shutdown()
directly in txgbe driver.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 49 +++++++------------
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 58b8300e3d2c..2725c6d5d338 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1313,8 +1313,7 @@ void wx_disable_rx(struct wx *wx)
 		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
 		wr32(wx, WX_RDB_PB_CTL, rxctrl);
 
-		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+		if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
 			/* disable mac receiver */
 			wr32m(wx, WX_MAC_RX_CFG,
 			      WX_MAC_RX_CFG_RE, 0);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 59d758acccf0..183ec7f0166a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -575,6 +575,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= txgbe_get_link_ksettings,
 	.set_link_ksettings	= wx_set_link_ksettings,
+	.get_wol		= wx_get_wol,
+	.set_wol		= wx_set_wol,
 	.get_sset_count		= wx_get_sset_count,
 	.get_strings		= wx_get_strings,
 	.get_ethtool_stats	= wx_get_ethtool_stats,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 30f66507809b..ddc7cea9d7c2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -245,8 +245,7 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_set_all_vfs(wx);
 	}
 
-	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+	if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
 		/* disable mac transmiter */
 		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 	}
@@ -303,6 +302,7 @@ void txgbe_up(struct wx *wx)
 static void txgbe_init_type_code(struct wx *wx)
 {
 	u8 device_type = wx->subsystem_device_id & 0xF0;
+	u16 wol_mask, ncsi_mask;
 
 	switch (wx->device_id) {
 	case TXGBE_DEV_ID_SP1000:
@@ -347,6 +347,11 @@ static void txgbe_init_type_code(struct wx *wx)
 		wx->media_type = wx_media_unknown;
 		break;
 	}
+
+	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
+	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
+	wx->wol_hw_supported = (wol_mask == WX_WOL_SUP) ? 1 : 0;
+	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP) ? 1 : 0;
 }
 
 /**
@@ -534,34 +539,6 @@ static int txgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-static void txgbe_dev_shutdown(struct pci_dev *pdev)
-{
-	struct wx *wx = pci_get_drvdata(pdev);
-	struct net_device *netdev;
-
-	netdev = wx->netdev;
-	netif_device_detach(netdev);
-
-	rtnl_lock();
-	if (netif_running(netdev))
-		txgbe_close_suspend(wx);
-	rtnl_unlock();
-
-	wx_control_hw(wx, false);
-
-	pci_disable_device(pdev);
-}
-
-static void txgbe_shutdown(struct pci_dev *pdev)
-{
-	txgbe_dev_shutdown(pdev);
-
-	if (system_state == SYSTEM_POWER_OFF) {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-}
-
 /**
  * txgbe_setup_tc - routine to configure net_device for multiple traffic
  * classes.
@@ -824,6 +801,14 @@ static int txgbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	wx->wol = 0;
+	if (wx->wol_hw_supported)
+		wx->wol = WX_PSR_WKUP_CTL_MAG;
+
+	netdev->ethtool->wol_enabled = !!(wx->wol);
+	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
+	device_set_wakeup_enable(&pdev->dev, wx->wol);
+
 	txgbe_init_service(wx);
 
 	err = wx_init_interrupt_scheme(wx);
@@ -975,7 +960,9 @@ static struct pci_driver txgbe_driver = {
 	.id_table = txgbe_pci_tbl,
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
-	.shutdown = txgbe_shutdown,
+	.suspend  = wx_suspend,
+	.resume   = wx_resume,
+	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
 };
 
-- 
2.48.1


