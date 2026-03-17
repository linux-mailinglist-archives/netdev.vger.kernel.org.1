Return-Path: <netdev+bounces-268465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKiXDnYFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B32A4F66
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A92863056E54
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A233921C8;
	Tue, 17 Mar 2026 07:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A039280D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733176; cv=none; b=QFo4S6xhXkA8EKIfO/x22RaIJ3jd1UUglz3vZIg8KOEBPnnrvSX5t5EM/uKtWeLATnESXxXlM3WMgmVn+cxm21widM6AvAnSR1md7n+CH2NgjJdBsZqelQCiNBt58CL8J2fCDSB4DXUisZ/7zY+3jGZGoAG4TnB4F2CSW5tJ6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733176; c=relaxed/simple;
	bh=d4BPAl8E3Dm09yCOVd3XA7SEoS8RfDbW5WMT2FhpHYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxgWhAT9gIytyuEWkV7n8Usr5KT33oRWAQNQkSTYptb5Wiowc+jMjYyAwho1mjd7gQdVL6RwOE7nho1pLm23FNdMw+B319Mmj+GjG6mx5gBGHlO5E/FcTL8HuZv0lCvB0EaCHOq3plMDZgH9bghc7iFHeXrG97AU6p/qkFlAKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733134t219f5ca3
X-QQ-Originating-IP: B7vs9tuy3FF1iW094s6QxAjrmQfCLaJ7jQ8jkS63yCs=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3325193765145269571
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
Subject: [PATCH net-next v5 05/11] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Tue, 17 Mar 2026 15:38:21 +0800
Message-Id: <20260317073827.4300-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M+A46wCNsTVJZ8YEygZ0g35MZ7UbXGm9vnmhYeHMh8mPUs+fg6m/bU20
	z7mxVr92K7BU8iW+SNoCbQx4sDUSiDZnEXJ16EJrG//beDdTTqSQReqNeSOJ8L/yVNPieOG
	oRpZL3+bouYl1Yz3+S40pWcdUSo/fCeE8FmAZ1V8GR/NKDv8QzcID5z+8b53vRHQNoqvLSz
	CAFkTqeUBuZ84OB68bJbo0Cjg/MYwuwiNQJDX2YnUXRpeCeDdcCIT+fB+Sd3Uwfob63aeij
	Yx2wAR3AfwgLGSE6rsjFuvsp6AG8fj7B60krChzZYKbz28/hcW3NguU0a411jssNU2+7BdM
	0mSJKtXty4RPN8rc3KJ9T90GWw82dJVrlL+2JuAeHIiS5sw7wIMHrf7s+9NrIdgXsgOKh+5
	uKb/q0scPXoLBRtGDtc+DxntHURHBpowdyBOjVMFn6AejRh/LIpMwRRyBTON8V/FLqrcROI
	eyqIyPzGeMTJT+3wlEXyRocUEHg78zyk55vAPxhmrMmQICYD4NjABrm/XMo6WuDTObza/G8
	jsHfKWdeVqLlVKfSJJm5yX6LqBRPWdWGqZpu8uJOClHV20oDBWfAtSXaYwD8AjHMzYbisUV
	9ibnXxf2H+5GZTs4gmQ4fkPbkeweY9uS4SrUheUJu3eCvCbuIFNj2ixIYjqvdp5TsuWRLH3
	YvUl0vSOV0TCW12swWU5fGw0lvsclvCimA32kqVYSf5a0PcVCW181+7jq9MxHqyQ2TmSHTK
	O3Byo6mIAVz/8chaTvesulK/e/T9Q8vvewxToynjaMMko99HCy2gJ7s7s0OLrnYtQSs+wPu
	sRBL7MCovCc3rTFAUOtvF36TONZN/3K4DH9zxdsvcrz7YCy3Ed9ddmK5+a91JinJ6/dOXMl
	EcphXhFgPKkdueACujV+QAr1Rc+epQAwCkHN+w5p4tN6qzNx3pt9IqJzCM9sktRBMFZ01yb
	rna2MEUBOBBHczBqGxNCR6MX0YcH/G0mRddJKxk6eeCsnPDw1rAPmfYZB+JGh9hW80q/LKg
	uBinu/HAouunbhB1+6oUINsZdR45No7Xvif6625TpGxoP3OujJS/s59233/1U=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.810];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: E17B32A4F66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 2de1170db8c7..2fda1f6130c0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -395,7 +395,7 @@ static void wx_update_rsc(struct wx *wx)
 
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


