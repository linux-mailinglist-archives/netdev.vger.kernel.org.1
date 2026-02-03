Return-Path: <netdev+bounces-256182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OzkL0SrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F8D5EF9
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45B03063634
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB2392C3B;
	Tue,  3 Feb 2026 07:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF2392C2A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105593; cv=none; b=m3rLvWQS0dMnERy21hzfMI8xmqHClN8yFLN+Z77tgSDtS80u+OlWoaP1/2CQB3OVHHcXuCRJUISEk6Nct4klJZzdK2xxvZNXvdvn+HUsuKVPEkDcAWbiUkQlEuu8fl84poBoCw0OqxO3Ztxih+hjtwymgiPoUoNpg5PU3XvPZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105593; c=relaxed/simple;
	bh=TUrywacf/8uh9vB89NpVdKrIgPXQpdS0gaEUUxMaxeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdB+DgFW3fjCKnE3Wr2zG8BLlb18iW/bDLxK7vMfTy51NPmWOVqjI3uin48m6UHk7zaYLHJus1MZsmYRNMlAB0cXima7b7Z3XcjAes3eMVeYpLJYaWWemJB6PZj8e2hULDl3QBPZrcc1XEp5mBLeZgEcwy46/3SkuStbsrKyvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105505ta241df99
X-QQ-Originating-IP: 3mW8qIBvLwxmf71eG+TYNb2N8NTeXdMiWOX5x3dYF1o=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6605807458716566335
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
Subject: [PATCH net-next v1 3/7] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Tue,  3 Feb 2026 15:57:55 +0800
Message-Id: <20260203075759.5852-4-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MrTVJ9obs/HIuth7bLXDuZ0itOIgDf3YVNEXyQ88dDLRHtv+kFm7aGn6
	uyq9NLTcqIUqyiz/Lll52JWdyUgJ7DZibN4CaOeNvGxV+xlBy70bT6XKqw1YP7uwc8UgoEt
	qmBPrTfRHIffQjDWtw5I++QR7c02hODDxocAIYI2JoyxZc6XuCKPAzkKWunno6gY5rq6yMr
	iv4KKJDJlFn8IdhrI2I1j9jr7wSTWdDAdrQ9GDnQKyb7hMfKrFwaCuh+RvCfZ/2oBNjimxJ
	K3r8LMKlqjw9IdFOt7IZIWHe9Kn9IfUlemKU7ycyGrfE8VkK+IvMPFMaUPMpR0VX1MzPndJ
	QSD9NMMrfBQcgqi4rkoZwQxl7tpCBuPoxX9PeAb+2ozBpYZKo/W9XX67Dd7l//ay/QqNCVU
	3HsCpLqPY+1fIXNKU4uAT0SuLBY7qaCwE1PtV3Oh4QGEh9nEx6Xf60mt/pyXRwn1MHDVTEN
	RDH04HlL1FEdlMvyTu9E2ysafBR5vmq5KGe7fquilPFC4dagR9wnB7CPoYFSmf8rGOLAlq6
	xX2f2F4ZufaJpn6bRduLkMNxy/dPFtYiJhNPlDDvJEuN2BBevqr3/+MExg0tU9I4FM3ex7l
	sZRjEgEmg2L6E7afRFw6FzjwjaxQszponskfet3MxKfdBYEFKs8E/SAwKmHRK2uzt94Mrq8
	/CbaDTQOLAJzEH3RddZvg9KqzKi67/mmOFxpETgqfBJUsylLgazjxRsei4QPIe4wSrDRgQu
	Kf5CJedYXz3RZ86eJqGlO7D3gE8aO9AhRogb1PvE98XCq/kviWpEdjsTHAjOBQqCrTAzsxd
	k+hSexNyGR1wTJZB+atP784ogQXKNsEj0gOslDubfUYRaZ66Q8L05ivx2PEFETsR/eyVQj8
	rfnjfPyWCoQ3wMwYo/VIdLtQng6/33E288Doj8S1ymDciB4RyVgpBnuyPJeF2lAge+dPJ2/
	NH//oHU4m10vMkxBVGGqoCFznlI08UmO6hWxA4pmYLDKfgG4kzwimmzGnQXOp2JC2js8kcT
	Y9IYJV86MqjG6j604dXi9Kzxt72fPdqiBzUomQVACustuXho+xZWLxnGgMAm8PDOYvfEO+T
	AkCZSZU1CTk1Ud3NxqlbHI=
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
	TAGGED_FROM(0.00)[bounces-256182-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 4E3F8D5EF9
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
index b31b48d26575..1361f4461046 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3112,7 +3112,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3162,7 +3162,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
@@ -3345,5 +3345,90 @@ void wx_service_timer(struct timer_list *t)
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
+	return 0;
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
index fd6339db222c..5c85ce09e387 100644
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


