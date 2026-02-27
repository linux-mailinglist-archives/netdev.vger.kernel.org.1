Return-Path: <netdev+bounces-261747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFb4DoFJoWnWrwQAu9opvQ
	(envelope-from <netdev+bounces-261747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:36:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403F1B3FC4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ACFE3050CF6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014036B054;
	Fri, 27 Feb 2026 07:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3A36BCFA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177783; cv=none; b=kVTgYGW8aruSRcI1blvx9k1BF0sqbuFGt25pxcO/WLRY96HrPt+OYbj6ZJ6KBY7zwFgedWgrMT7ra6P5bhNH/U/asU/evNE6kKisJVNiDlzgozq/6FGAtgTPtOY/PnkKkqZEaCYr9oWnlA7ozNW9Zh9RVMF9RRHmvvKDX1oacj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177783; c=relaxed/simple;
	bh=4bxnySRx9dYzczqrWPgl0Hc7j0xzbct5a+lpNU89u5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVY6kQnhFM1l81RQRS3WanTD591jxpv2qO/f3pa02WSB6SIooa8umwxTNQ9Dy9wK+ozGiOW9Wx3ZCTW1VlYCeohAW6Hj5HoIV1QHmvMmwapJSuiJLfEWKmFTiYLJ1mI+9q5q1nezZK94UnONh/PZIZNQtIz0vhiQcTdmDMmV43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177711t1274cb89
X-QQ-Originating-IP: 60fELOjMH4t/lBKH0j7EQNOSG3BBCnbbbDeO4Qtdzf4=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2968009338336214781
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
Subject: [PATCH net-next v2 4/8] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Fri, 27 Feb 2026 15:34:46 +0800
Message-Id: <20260227073450.23680-5-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OKKHiI6c9SH3VTQNLEcvcskXShs3aW1p3Qdb5BI+z7IhFgufUG+pB8CI
	21CSDOuRv7vADGAUaIURoeRe1QJwqRW9o3JJzKltwsT3QQlo7skfbiB9wYG4MJhZG/hGA3u
	3EeWrI3FyYLpwrjtAxuFTPtfr4SP8CFzHdJjgFwzRp7AbWKygc5NxwsZjDAM9dxpAEP/xTL
	tBpMVpbM8CxUYpGvZ9+i9mTMODY9MgdQP9qRLgv3z+RWRwwhH8fcG8UbCXJJc7s88je1zX9
	ESrvZTcsev5Bl3qHB9m3wugxkxBX6Qe8k3fwxqkTy8buvFnAhDJg6kjiacGDZ8L6vfXr8Ub
	vVa6Nzoubsr6dg3/sOf+tGfqLF22GWgFJA4s6GzdDeU3VY9gJgEqXsD+fcxm8cTnwAz4/67
	kDjDOHHPdlz/emqw/TPEZLzDiuK31p9pRRwOUWLXZ8/Zb5gk+x5+go1dVGNqwdjaJXVVJwD
	oCeQ31Gm9h1MkToc4cEp1aQV5mpd4QmFHceo0WNzi4sdfmhuBS3lNir5garbFcTRYv40KXr
	PSipyLQUW4XgJVBad/ZCdZfbik63GitQpjA9RurOQvoVC4Osz7ILWrdArjAApt3hQc+nOHm
	coxPTF63BohQGNBBQ2uD2EJll2BhiWlK8tIlIQ/8U/6WMbEs23mluYbB/hCm1RtZfCWESwy
	Sfnxav6/ATf/YzGpEJLnWmgJ7pXgXJ6dRPXM6OnoebWbY0/Ls4KxYAWmDaWLv4IgN+Kc7tn
	IxXg37Im2MQUTH4m8ZkxNgQG8eA4EbGw8wftWkqkbkjzpZdmm0dmxw62luyCRuXpK3wrjLG
	DangJy8PuPlQlEedUOFKWpf9M29KJHE6W+uAYusTqOr0s4YBFp174JaK7AJbwUGiYgAa//k
	SnhfqjhZV/MM5gw1vDyPdWaWNZJarPg7mO4VqYSZYEPGPQBN1F/ljgw/PHPukb8sUyCFLw1
	GGMkKU64DoKF1CtlYZXJnmGyRKzMd4OjaHeiTC1TfXEYNiuSYlCcm6Bd1950rHtKxrlr6+L
	+BFYcY4FSU6wr2CgRiN7FflXHixQSNCD5ii3KFL6qetu61rbf7/TwepuUCcJVof2YstBzqj
	7dGk/jw7gB33XaeDns2F70=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261747-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2403F1B3FC4
X-Rspamd-Action: no action

Add function pointer wx->close_suspend() and adjust wx->do_reset(), so
that PCI driver ops such as .shutdown can be called in libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  89 +++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 113 ++++--------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  17 +--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 8 files changed, 126 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9e940ea9cb8b..9fd8cbe62f0c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -396,7 +396,7 @@ static void wx_update_rsc(struct wx *wx)
 
 	/* reset the device to apply the new RSC setting */
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 }
 
 int wx_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 746623fa59b4..c65240ca3c28 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3109,7 +3109,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3159,7 +3159,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
@@ -3342,5 +3342,90 @@ void wx_service_timer(struct timer_list *t)
 }
 EXPORT_SYMBOL(wx_service_timer);
 
+static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	u32 wufc = wx->wol;
+
+	netdev = wx->netdev;
+	rtnl_lock();
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev))
+		wx->close_suspend(wx);
+
+	wx_clear_interrupt_scheme(wx);
+	rtnl_unlock();
+
+	if (wufc) {
+		wx_set_rx_mode(netdev);
+		wx_configure_rx(wx);
+		wr32(wx, WX_PSR_WKUP_CTL, wufc);
+	} else {
+		wr32(wx, WX_PSR_WKUP_CTL, 0);
+	}
+	pci_wake_from_d3(pdev, !!wufc);
+	*enable_wake = !!wufc;
+	wx_control_hw(wx, false);
+
+	pci_disable_device(pdev);
+}
+
+int wx_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	bool wake;
+
+	wx_dev_shutdown(pdev, &wake);
+	device_set_wakeup_enable(&pdev->dev, wake);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_suspend);
+
+int wx_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev;
+	struct wx *wx;
+	u32 err;
+
+	wx = pci_get_drvdata(pdev);
+	netdev = wx->netdev;
+
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		wx_err(wx, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
+	pci_set_master(pdev);
+	device_wakeup_disable(&pdev->dev);
+
+	wx->do_reset(netdev, false);
+	rtnl_lock();
+
+	err = wx_init_interrupt_scheme(wx);
+	if (!err && netif_running(netdev))
+		err = netdev->netdev_ops->ndo_open(netdev);
+	if (!err)
+		netif_device_attach(netdev);
+	rtnl_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL(wx_resume);
+
+void wx_shutdown(struct pci_dev *pdev)
+{
+	bool wake;
+
+	wx_dev_shutdown(pdev, &wake);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pdev, wake);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+EXPORT_SYMBOL(wx_shutdown);
+
 MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..42461723a400 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -41,5 +41,8 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
+int wx_suspend(struct pci_dev *pdev, pm_message_t state);
+int wx_resume(struct pci_dev *pdev);
+void wx_shutdown(struct pci_dev *pdev);
 
 #endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 29e5c5470c94..e013f05d2cfe 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1372,7 +1372,8 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
-	void (*do_reset)(struct net_device *netdev);
+	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*close_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index f25a5fcab319..4dd7de79431c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -134,6 +134,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->close_suspend = ngbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -483,6 +484,16 @@ static int ngbe_open(struct net_device *netdev)
 	return err;
 }
 
+void ngbe_close_suspend(struct wx *wx)
+{
+	wx_ptp_suspend(wx);
+	ngbe_down(wx);
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+	phylink_disconnect_phy(wx->phylink);
+}
+
 /**
  * ngbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -499,11 +510,10 @@ static int ngbe_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wx_ptp_stop(wx);
-	ngbe_down(wx);
-	wx_free_irq(wx);
-	wx_free_isb_resources(wx);
-	wx_free_resources(wx);
-	phylink_disconnect_phy(wx->phylink);
+
+	if (netif_device_present(netdev))
+		ngbe_close_suspend(wx);
+
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -515,50 +525,6 @@ void ngbe_up(struct wx *wx)
 	ngbe_up_complete(wx);
 }
 
-static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
-{
-	struct wx *wx = pci_get_drvdata(pdev);
-	struct net_device *netdev;
-	u32 wufc = wx->wol;
-
-	netdev = wx->netdev;
-	rtnl_lock();
-	netif_device_detach(netdev);
-
-	if (netif_running(netdev))
-		ngbe_close(netdev);
-	wx_clear_interrupt_scheme(wx);
-	rtnl_unlock();
-
-	if (wufc) {
-		wx_set_rx_mode(netdev);
-		wx_configure_rx(wx);
-		wr32(wx, WX_PSR_WKUP_CTL, wufc);
-	} else {
-		wr32(wx, WX_PSR_WKUP_CTL, 0);
-	}
-	pci_wake_from_d3(pdev, !!wufc);
-	*enable_wake = !!wufc;
-	wx_control_hw(wx, false);
-
-	pci_disable_device(pdev);
-}
-
-static void ngbe_shutdown(struct pci_dev *pdev)
-{
-	struct wx *wx = pci_get_drvdata(pdev);
-	bool wake;
-
-	wake = !!wx->wol;
-
-	ngbe_dev_shutdown(pdev, &wake);
-
-	if (system_state == SYSTEM_POWER_OFF) {
-		pci_wake_from_d3(pdev, wake);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-}
-
 /**
  * ngbe_setup_tc - routine to configure net_device for multiple traffic
  * classes.
@@ -612,11 +578,11 @@ static void ngbe_reinit_locked(struct wx *wx)
 	clear_bit(WX_STATE_RESETTING, wx->state);
 }
 
-void ngbe_do_reset(struct net_device *netdev)
+void ngbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		ngbe_reinit_locked(wx);
 	else
 		ngbe_reset(wx);
@@ -874,53 +840,14 @@ static void ngbe_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
-{
-	bool wake;
-
-	ngbe_dev_shutdown(pdev, &wake);
-	device_set_wakeup_enable(&pdev->dev, wake);
-
-	return 0;
-}
-
-static int ngbe_resume(struct pci_dev *pdev)
-{
-	struct net_device *netdev;
-	struct wx *wx;
-	u32 err;
-
-	wx = pci_get_drvdata(pdev);
-	netdev = wx->netdev;
-
-	err = pci_enable_device_mem(pdev);
-	if (err) {
-		wx_err(wx, "Cannot enable PCI device from suspend\n");
-		return err;
-	}
-	pci_set_master(pdev);
-	device_wakeup_disable(&pdev->dev);
-
-	ngbe_reset(wx);
-	rtnl_lock();
-	err = wx_init_interrupt_scheme(wx);
-	if (!err && netif_running(netdev))
-		err = ngbe_open(netdev);
-	if (!err)
-		netif_device_attach(netdev);
-	rtnl_unlock();
-
-	return 0;
-}
-
 static struct pci_driver ngbe_driver = {
 	.name     = ngbe_driver_name,
 	.id_table = ngbe_pci_tbl,
 	.probe    = ngbe_probe,
 	.remove   = ngbe_remove,
-	.suspend  = ngbe_suspend,
-	.resume   = ngbe_resume,
-	.shutdown = ngbe_shutdown,
+	.suspend  = wx_suspend,
+	.resume   = wx_resume,
+	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
 };
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 4f648f272c08..eb5c92edae06 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,6 +125,7 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
-void ngbe_do_reset(struct net_device *netdev);
+void ngbe_do_reset(struct net_device *netdev, bool reinit);
+void ngbe_close_suspend(struct wx *wx);
 
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 0de051450a82..30f66507809b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -412,6 +412,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->close_suspend = txgbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -500,10 +501,12 @@ static int txgbe_open(struct net_device *netdev)
  * This function should contain the necessary work common to both suspending
  * and closing of the device.
  */
-static void txgbe_close_suspend(struct wx *wx)
+void txgbe_close_suspend(struct wx *wx)
 {
 	wx_ptp_suspend(wx);
-	txgbe_disable_device(wx);
+	txgbe_down(wx);
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 }
 
@@ -523,10 +526,8 @@ static int txgbe_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wx_ptp_stop(wx);
-	txgbe_down(wx);
-	wx_free_irq(wx);
-	txgbe_free_misc_irq(wx->priv);
-	wx_free_resources(wx);
+	if (netif_device_present(netdev))
+		txgbe_close_suspend(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
 
@@ -614,11 +615,11 @@ static void txgbe_reinit_locked(struct wx *wx)
 	clear_bit(WX_STATE_RESETTING, wx->state);
 }
 
-void txgbe_do_reset(struct net_device *netdev)
+void txgbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		txgbe_reinit_locked(wx);
 	else
 		txgbe_reset(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 82433e9cb0e3..e9360e935682 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -313,7 +313,8 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
-void txgbe_do_reset(struct net_device *netdev);
+void txgbe_do_reset(struct net_device *netdev, bool reinit);
+void txgbe_close_suspend(struct wx *wx);
 
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
-- 
2.48.1


