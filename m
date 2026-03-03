Return-Path: <netdev+bounces-263012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPb/GBZQpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D84211E8504
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D013B30BC970
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1637CD26;
	Tue,  3 Mar 2026 03:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F837B01E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507091; cv=none; b=sa+di81jQxDtBHHq9cVAs8B/irbIYOFE2MaVJ8RCbX4CDwkn3kIyEr49okN+qEF6atGuUiN3oxi4f9XDgYIwa5kiHqb0JsG9/5zzu36bJVwk28MgucutoktxGMglxMhfg+nk0tA4pKSZ6OfoDxm4Gh35wWL8yCJ1L5fDdVEkwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507091; c=relaxed/simple;
	bh=WJSWaLjWbON+BMECS1XrVYPa7mMp0uQhMEJK8eIaaco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLebpdmVeiYJXP40R5CWYntK/tmGkH2SgA6uRMY1dp6S5ZkwKmPK5m2d6+HO2blbsqi7WPk+U/Q1nf0gy6s+c36F9SUP9H0yMZA4fIgagGTEeqaJ4vggxFifnVF42HTa4Rm0UIi5xCMGQ0wLza7QY1NZ+SYnWbTA6Vtd0rW+nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507040tfa2d20ee
X-QQ-Originating-IP: xIg3hn5n/DXc7/tV+DCJsyNHfwdw+YqEY/INZVWN3VU=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:03:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3153843117219811331
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
Subject: [PATCH net-next v3 5/9] net: txgbe: add power management support
Date: Tue,  3 Mar 2026 11:03:27 +0800
Message-Id: <20260303030331.24076-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NG+oLgkBIWry1W90tgwIjFxna5nDQ2fdZhI7gKXtay/M/z/WfSi86Beu
	L+IusRQbGYVRM8h7taahUM2Yy7A2VwqlUUvdyjLZbhqKv5EjwV0aX9TZmEeQNWtL5XeiGEt
	shJu7iUkp0C/FTDKqBe+AL2pJbiyo/IOCo7+ltTAs49qoc62n816gXZTwqUtjYxSSj7U6z0
	cWAOwVCFzmpielwOvB0I6wQskMQlVsi73qcXqEbkLkmRV76v5AhkvsMCUgjkDJR5jgZFU7k
	SLs4vN+3mA94wSJK4kSkhC7pUO5A4tvujrFvMMk9/1Ypz+sp+FyUSaRO7KY45EIQ77aNDzp
	Rb7KlKUICmY3qrQcS5bb4hZZR5K2PFplcWTeP/f7b7aWtfHzAAnhS7tpkGJaWM6KFHeXc+B
	IiRBHpKmpkq2d2D6s79wz8g75/SlgmI4ZxmIxpHcMq1/BGoamVWmhUo9TRLM6vw8EOopO9k
	u6YSbC+0W21nqA1tW9PValIR9ZNjbei72MjZtjo/xOnFRGtsX9rMHdorFNlSKjGPDaDqk72
	fPErnvJV8zeJuVdslI8yxvCdqSfvn/OcWK1H6lSDvVhMoreF/63lvefxz0/q7oV83WRVSAM
	NWYM1IDNT4PcmcgUCqV27vXkWU9WgcdwsIq3xo98/FmybL3majPb4LKTQE8cZeQsRxELDnk
	7a5ouWtdvEYvt50woD6LT+Gu62WChkB1fAocQ/9taOctIqDvFoyGozD89JCUB10Yr79fyMJ
	amJjVlmJaW3/MHidz/J8qhA+FL4ZZe8WVWHyuPgZhFwpj9sjxfkC0pVmH9Psd6H8lnbjpdx
	rJWX7vAYcv+u3ICvnJHsesWvA3YFoz0fOrnFsZ+JL9hcNgvTM+PW6tfpNVNXUfTe7bN7Ktk
	XnH1yD2yFXoZRD1PDPQpAHVgBroRcc65l+YOrbngVUW2fVshWCxV5wzHBdvcsS3NIf/a1B+
	ZbVgMU8Wxp/TBP78/lUFBT8Ts4Eu6icyNP9I8q9O138pvTPZWj2wG2Tg2jvpCnX7Wd3Urae
	ZBS5fb5VkNsHJdPshjuUYZD9VlIgd2Wfue/scul80HT4k2OPg9sWTuRLrHiz4tHn6ZVs58W
	ey/RDjnGHvZ/I5ZnYqoMHAyqJUWF+mGTg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: D84211E8504
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
	TAGGED_FROM(0.00)[bounces-263012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.827];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:email]
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
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 49 +++++++------------
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index bee9e245e792..150a063daafd 100644
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
index 9157b8275be1..c92eb71e0c15 100644
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


