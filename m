Return-Path: <netdev+bounces-268468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O9CNJwFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CD2A4F85
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF37A30259A0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4668391851;
	Tue, 17 Mar 2026 07:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6237FF57
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733189; cv=none; b=ayEwGgZEBg11S2R18YTFSg4hXnXtY+EoQ6gw9ogl7QA6f1UMY8L1+Gj1Oyffgi1L74UN4PuOUZH3EBVkP0vzsmV7MO2Q3/vKKs8yHZM67o0oL34RREmfy63S5h5TmFW/mmkB599p+x4ZCwvIDhurEB6WuceUQWenCJEOHOcRUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733189; c=relaxed/simple;
	bh=+8bPcs+VPVRneVB1YBXHXMKsZyVyDIXRPpHdkb6IHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtWzm7Sio8gqEYjg0khfoROH/PPdEm4omT6n/fN4Nldpv7gsMsd9eMrKNmkNjU7SGAy0I7OdVdRprYP+jmiMCIf/H8JKb2kaeQ4DKqLY4xcUDbz2i/gKeYLQGUK7pRO0LBgYfllrSXa3zXh4lRE7hV4yI4GkHp9VTusoyflm3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733131tee1d4cc3
X-QQ-Originating-IP: eYut0V61EMf7+vtExJkBRIUpfEJgtlt0JL9uX3+UjSw=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2750968146534145995
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
Subject: [PATCH net-next v5 04/11] net: ngbe: improve the reset flow
Date: Tue, 17 Mar 2026 15:38:20 +0800
Message-Id: <20260317073827.4300-5-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MuZFsZUTkKSuHlZnhj9wG2mCVmxu8W/dOw6J4uxYX+X0XrWWcTAvpdjn
	II5LqRsqOJtjblMh+RUAvFbTggFwUCkNxLgapPYVkockkpeCrZmq2aBIqD8yNBeT/ZZvu2Y
	djm407F/6DPBuBvQGvzMCZ0kwRWdZNqRGWefnWh606cgJNGiYN99bsYUKGP09nPHW9Y6O7k
	Q8rCul1sgUaWy0m0fU2WggCg1J9LibmB9ILWFVlioFqK4oSpHt7lcsHuJPFkdZ9zNjj9Kbp
	iu3U1zPX9QmP+zn298qz2F6ptepSkvzaOQGidpjGjW76IBsSKG0sn8Bvmu+gb/eBNl0m8hy
	1gQfxg/7rFqGLMatRYZ26CXsQGwgVVOV5W7WyAahy3CVxL+jthCEjH+v7UHHGhiim2RoGno
	8i6SKcC/kDhtOue+zOYPhXFIdyxoNE+EZ3PD/OZr4U287OYStGFMH78Dc3a43MFUsQjh8K2
	SOczw95Apib2CBHvmY2N46tk9tgxopI7C3R+kOvB92nxV9UB8uc9F5TeGlp116zsEesUwEo
	w+nmtPjHOkBmJ7BIqnt5xNVMls0Zhgj+cyPlH042n2Oawg6Q2VBFAa5aTQTX3aKaI4XlZUO
	icqGeJfdxXSHW6x3guwlEm9Kt1WH5qYjmpmlZFS/WdNndnzuYr7Iu+I9JNhH3MgYYxbm/j5
	bU5QqlDik3s7wWW2Eaw0xcqRL8xIwvVy565HsPl3WmIUPHxqyNsYP/CivAHIhYlaoJHocxR
	fzwTL0MXM+GyuhJOG1f9jZUfDr58BW1o2dmTpp8fzaPFh++XqXJxDFoiBTJIiJzlemP6Sdl
	TaGC2UT1gVc70xAiZp/4CtSghnIToQXPUze0ZN6vACIw9/6iq6//g3oZc/+g4cGygcgzvbk
	QfXZg2HS139ig9JRstnaBfLzQaZoUMZGN1SH7ythkWdHImVH+MCLMtKgSImsw1zjFxAEn4b
	Rxy5u/cDuJEvcycrtVhK8JEwyQbSsDNSx0j2+0gp6pfUAoyVT8+IDtLXiVKwONEWZsI52dm
	4eNxsyELkftYjAXiBIwzTN2r600UwHQCWQOdPQSAnzSUayDtj1im52ZpXn2eHleA6S8pZPC
	LzanJI7+cKwkwt5waCnTw5LdZS4kNCKm/+wg97cb8wp
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.825];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: EB4CD2A4F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement wx->do_reset() for ngbe driver, and improve the specific reset
flow. Add ngbe_reset_hw() in ngbe_reset(), to make the device connected
to the external PHY (i.e. wx->mac_type != em_mac_type_mdi) do proper LAN
reset, at all times device reset is required.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Joe Damato <joe@dama.to>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 49 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 2b6356622a13..b86980c2418f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -60,7 +60,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8c9d505721b1..f25a5fcab319 100644
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
+	if (err)
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


