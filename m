Return-Path: <netdev+bounces-263010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J4MN/VPpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E81E84EE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C3C93073FBF
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230B375F96;
	Tue,  3 Mar 2026 03:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3154774
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507088; cv=none; b=bxyKCCGuGouVEczHGG4A2ldI5JDw6XOThMeyI45foO9UaLLwbfC+I+8Pf0kTiu+pWNIXfMVahNJbxeuO7GOFqFKyxcdXKPDS9ciIcUimUgiurdiwt+ufIs6+jrMU5xF1hfS/OD2f0dmwejnWKqIvFdaNDk8Q9hy0rh0N9HIc4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507088; c=relaxed/simple;
	bh=+8bPcs+VPVRneVB1YBXHXMKsZyVyDIXRPpHdkb6IHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7MPutxGw+G91iucdy8ASWk1HyXGc7g4u95dpjozleH1UpvbnxegKWIGLWYfMkCitlpAdJtsXKq/8UxUj82Mx11Q8rE44LJQvKHn1YaC7MFJbllQxnzgz4w6qIxNkHzyPJT0tfm698jpc77Swr7/5knHCRypcKD32BFiepn6o5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507033tc8e54cce
X-QQ-Originating-IP: iwTsDSfLAL4dazBSCCsGxn4Z7gWU4k9DLgP3d0VGMl0=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:03:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16410556378519049200
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
Subject: [PATCH net-next v3 3/9] net: ngbe: improve the reset flow
Date: Tue,  3 Mar 2026 11:03:25 +0800
Message-Id: <20260303030331.24076-4-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NGZp1yYNf7Y+o4A5JVOAHC6alYWpJ8agoGWBxikbFoF9fi79Iqx+1F/n
	ixij2a38fdpIkc/ErTFhjBsny9Kw8ZPELUN0d60whPOyMabZa5FbU/CHcnj4de8wAJ2lsb3
	nFtt2AXR/nKF6rIZUGqD9Z73S0EiBnZc+SGQRliLB5mh7dll88wqqpP08Ubmhoz+Eqz5fvS
	KN6Y2/bIlwN0lGmjnGcA14ByAmsvsevodCZsEvnp62pyiO3tsyT4TzQZrlrs32bJmDlWyLm
	Fx+Cxm5d6DAxJTKgrfifoMjXa3V1MDEX4faSYLk2NC/GwjB3F1M/YNEun+E4yN3ZDv002Ps
	Gq0a0ZGPTNUmyjCMMRTOWSEwaylQkZY9E4iacjZcrqhEbbbwHddjvm4XKrkyvMAmYwy2RrR
	YY7iEID4yB5iKtboC8xuTObgoLxlK3lxygEI6rvlDNYaPvqcboFmMwIyNc4z3z6D2/O1oq0
	fyzvalh0bSwOFi6jYXnwkoPwWGQhhDeEH7S0C1H1Zzlh/yKq4Tw0VlWL4mQWQJLcgOp2r3F
	vds4NmIAU6n1XiZnOFBUMWnRsiJEdr93HUNj012o7h3gFVzksk93R943bT81Sg1D2dNPoqz
	CYLr4Rf/J+lQliV5IPOGxdnT7HOGiboSrB5PJzUYKwtFoVA9eJyLXPjnkLFzN9IbIFzdf3i
	QphnNpiFnoHQHe6pFKXaQCmQis3+ttytGHtx4YeEIH/v9VwMQV78BkmPTROPYpHmXbb/Sur
	FBQlthLgzRzmaZx+N0ozXQ0H0gSQ47oxFKsRfBJ4d1pKw67IZgQyYrlZOhWza/Mm8qwnmxG
	xFNESC6YI+deFhFtSM75O/FVeCTbBvOATQoj3czC2AL4RgSKMuSvrAVC9yN3HQQCYoUD0ke
	2NKq12lwMH86F/P1qV6J9kNbpNvyVN1QCz8P1uOvBKJ5Z8sPCuaIWMSOzq2TwILzAxxDrZK
	+c+SBmQ328Mril4s0OaeWmhpjKokG5EBoJ4A+iwBLP7NEMFneHFKGdRlrrnUObHbcn1YCcG
	Sb2KFtlpnxlTTyTzbQfiF/AUSSZyz84HqFdnhtf7ZflngmLJefiZeEw934J1/07Hi2jWp2R
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 409E81E84EE
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
	TAGGED_FROM(0.00)[bounces-263010-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.814];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Action: no action

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


