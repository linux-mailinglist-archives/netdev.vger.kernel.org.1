Return-Path: <netdev+bounces-256185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMS7OnOrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B2D5F1D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90D9307DCAF
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247D392C54;
	Tue,  3 Feb 2026 08:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751D23BD1A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105601; cv=none; b=NgV302ZJpzqpSop5B+ibcLENjmVRn25cuCCgDIE84d8vC6RXuncyVNWf+DC5C7M62uRIZiIjJjDFRcRvnpsESyQIYLXp0tQ7EndIwz575tf1a1w8ThL8rvc05hcnxelMDtLjV0FBL5RMgbBwUAOrPTsJLzO8Je3x9ew1emOeO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105601; c=relaxed/simple;
	bh=k2NoaFS4BtbcW6hUU88YBtN4ZBGTwImP0HOLm0o5IqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6rfQZVfTR+P3mNlABbAfag7POuuNG8eskZj6RKTucP62dmlyplBZaJJmUqNwePSkmeAXyCgDwjF0q/9EAFCGuIb+NCP3P0740ab9JgIIauDAIbKX+V+mA4D6JAltT9eu1YHRf61SOEvHsiWpnH5v8BLOnPeN/OoPKJCtEswrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105502t8d1d9c3f
X-QQ-Originating-IP: Owv5td8EgTQuXEo+xBrLlOCu/PfFBy91tzopl95zfnA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1169898116973737428
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
Subject: [PATCH net-next v1 2/7] net: ngbe: improve the reset flow
Date: Tue,  3 Feb 2026 15:57:54 +0800
Message-Id: <20260203075759.5852-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MyirvGjpKb1jxoI/4o2KE6CEmv19NRbN/xViTJ5/BuGp22JnOZLAHJOW
	QpDX6AiuUqHOC2y5Gz5CxZpNlw5nkwoKvafHksyql+nFLfv2gjIfol8y2M7QTMSmpq2EyUG
	ngBMV+s554o1QuNPf3FUg7IEPSPIZTCxr2vgKTGBdHriEkDf2mKSip8uOfmTUD/xodz8ZTX
	upYHyaD7oUwI2uWkcBmygr1sNXv2mc3ZOBgGiMZYKHDSzIC3uhEfJW68bTQqg3SjVdMDvif
	SRiatYKnDBHqde40EZ/W8Xmx9MooMU4N1mPMrDjjEgsNKUreJ5Ly/dgEdpBEIpC9oEBbUY7
	BLRHR7kyjNgHqa+RIRJwS51ua8AQlwcbzi9vIJiQe3/rDM9WyMZkA+1wHzEGYv7awDy1XnM
	mfS8PIYWg4JLc5cp5N/8fPGnwRY1gzJSkq81OLWVjMsuK6J8uZ3ck8Z5YfPYO81Zmm+xJQ4
	cnR3SPXC4brfDJO+3ceqpTq3am2vJd/xB64n0vbDJsKfMXMviet1BZaTDXbTsziixIz5gEm
	TMagq4bcfScgb+p5CA7MMkP8rM8lA1C0WV7Ddt8Sgn1TSS1BUoIUQawew0TRaZMiTdDHVvl
	a1ykFT8bt6Yhu2XXoSjJSRLlb7TiEyVCPbuJev/rZLApYyMSGZqkgPHgGhYL2DLAzUR6oKz
	lWx1YhroDIbKt3UHWhv54zEi01qgHa9r7Q1/Y1DqWS6V7Nwwr0m9zUFwWuBo1fgW4UkhejY
	bgm83OtKBQbcg+hB0x5qwAH8VrRz5L/Ktx3UD+9HXHkg4PAgbQd8mF8+m6IL1v6m+Fekdw0
	5t4eeg/3Kj/zWm5QLasgCCID4IxjeqEGMJ9HaPOoyjjTWzReGj59spxdqX64tVuuUsI9QnP
	BWnQFzp6FjgIK60xUi2moSZ5Thex+r9kIBgjFMz5RFA9GZKJUXc/S/urMDbmIQTP+gko+b6
	eAWNr4NLPDujMBgGMX8bpPBMG/ejpN1FBJP09VGW4D9bBMqkPBNJpFqnfN/+5akzTj49eDj
	D74xpDp136xa8FFVvtLyxAp4XXwCsTXWqo0irkz7aaMKXbhCaIBdS9KXxSmNM01IhU22pBj
	ueI/Bswq/kEKOi4VeoOUD8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
	TAGGED_FROM(0.00)[bounces-256185-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 525B2D5F1D
X-Rspamd-Action: no action

Implement wx->do_reset() for ngbe driver, and improve the specific reset
flow.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 49 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 427d4c00b739..1a3082c1d15c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -60,7 +60,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8c9d505721b1..fd6339db222c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -383,6 +384,12 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_reset(struct wx *wx)
 {
+	int err;
+
+	err = ngbe_reset_hw(wx);
+	if (err != 0)
+		wx_err(wx, "Hardware Error: %d\n", err);
+
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, wx->mac.addr);
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -398,7 +405,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -463,7 +470,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -502,6 +509,12 @@ static int ngbe_close(struct net_device *netdev)
 	return 0;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 {
 	struct wx *wx = pci_get_drvdata(pdev);
@@ -563,6 +576,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	 */
 	if (netif_running(dev))
 		ngbe_close(dev);
+	else
+		ngbe_reset(wx);
 
 	wx_clear_interrupt_scheme(wx);
 
@@ -579,6 +594,34 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
+	else
+		ngbe_reset(wx);
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
@@ -858,7 +901,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
-	ngbe_reset_hw(wx);
+	ngbe_reset(wx);
 	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
 	if (!err && netif_running(netdev))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..4f648f272c08 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
+void ngbe_do_reset(struct net_device *netdev);
 
 #endif /* _NGBE_TYPE_H_ */
-- 
2.48.1


