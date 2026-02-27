Return-Path: <netdev+bounces-261743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOh6BchJoWnWrwQAu9opvQ
	(envelope-from <netdev+bounces-261743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA51B3FFA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12C9301051C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E436215F;
	Fri, 27 Feb 2026 07:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1D35A3AA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177778; cv=none; b=naWVxWEIuTznS1abvaNSXQwnLNW0tLXZZp9BrX1ukQVZT7PMp4dLSXYorcMzjBF1qMwTYl3sh0JOh+6e+G8RNiAct2AZmSxNvB0k3wP4mletzC/yYaZzKHFhCokvDq4mzVyLXirzm6IJXp/p1We2HIuzIxIF90bAZA9UF5vpFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177778; c=relaxed/simple;
	bh=q6a+GioDSfSF4AddXdEep52Nm8x2sma2LQZ7pUGUMHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBOjeIx+wmrxw9FWLGg/G6t+YY3rhWS34TmnS11F0++jNao/rI6j5sEKU5WamxgZH4E7fOYAPaiqRQ0wLh5NnSQqxFHnFlFbhaM7IvASoy3O7/HV0FTrDdQEIdt3q6NRM8TvRUiymIIiLbPj8NC3/mew0u3RhOxv5jZ1ArA3DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177714te6b5e7ed
X-QQ-Originating-IP: URXJUIz24L4AifGkj0EJmKIwqLSxIQVALtthR15vkwE=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14282051805719472887
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
Subject: [PATCH net-next v2 5/8] net: txgbe: add power management support
Date: Fri, 27 Feb 2026 15:34:47 +0800
Message-Id: <20260227073450.23680-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: Njp1rspSmtOfngwlwVbKvec7lPoV9nguYgFghQ3dQ57JwjSccpfhnIvQ
	Idk8eo5GMQZErKPEHALLu6kR9IdVbYwO7DQ6mDQ6y1eXm6jSTgLXUgJ/RQxR3uqWTKIrrhp
	bdGNH+NanJ/osGjkBEKV5S1BrN3XrHxwkZTUm4zyTjPB335pS4aBpYOEsgHZY/i4lWuh2y5
	xWczf1ki6hrAQ4UWP3LbEaL9K4yGqDN50OiO9U2++MhL9BEMSLNP3L6DMNf+kHAN0WF8Vdu
	4BY5gLijRgrc0w+tIByndsQhAIbqLJVJJyTIOyU8PmRofAUEVJ9UFG/if+wGy9jcAs1Cqj3
	XBnwHbrjrDqWQpIg4/FeHXyqIb3Dz6FCsUfCbZR2lY6krEBFF3+TZvWqY7ey+sbo6FjyiuX
	o6VATXEc+v/tAgzdu8eUMx+oZPJ/De96C5tQnp1QIENDb8d/3nHXZ3swyffXDQ1rlIgff+y
	sy9urUk6mn7QbKwQTND0xRkoeksHHZypEC/WCU2vld6G1WO1Hh8JewWSTqGXSJzVTGqQUtd
	Z99whwx37FSbzQQ4GOfvRYEa79+odfHGXnXADlT2rdZf/BoZuwyJI4DckU2EMvvmeGtBm00
	BDl0TbpYKUwWsJfjNr33D40mDl3tDZpFlW7G7E3ZWPAj6jYfZG8hRhVJMwXrJ1GqVskSbSz
	Qe3L4UhIioYV71ZKB1EeTZOt9VcMqDf0q6tdG+hncQuJCQ6zJLZ/tfszrxlkeapgcN6JEkX
	CQDlo/zZZqWbvf4+gh0skDz9WMGdjGruyS2hcwBZtmJ/BxVSl1DtL8pSE++J6J1oSLeRnPy
	JTqY3pWgUg56h9sa0ptns0TKvVFhOfTw5+SZ9h1embTLcvoWFcrLoldRRv24M5cBPph2apW
	5tKxtvh6YPALuORkzXkzKRWjgM6rRGg9DrWUckeGUJKNb9OijTD/gWon3TDUuWgURXSE+Uc
	TSeid3mABYzX3mwT277PTXbSc2ZHY+3DO43iV1xce583rp4LakG5C/O3DLOc3AUNLaQTpzG
	LNe4orE2H0hDehD1KwMHL7Qwk7ItwFyDu4RUsl9GNp/CQ6zSzv5sNxj6jYARSD1gpc1K1Sq
	UUVzBrVeUGDQZMSyKTSNe234WBjOLb5Cw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
	TAGGED_FROM(0.00)[bounces-261743-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89EA51B3FFA
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


