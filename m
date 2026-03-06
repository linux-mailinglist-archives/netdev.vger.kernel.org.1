Return-Path: <netdev+bounces-264692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KANkDHl1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1DC21C1B1
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66EC4304D673
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72E370D6B;
	Fri,  6 Mar 2026 06:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4C43147
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778834; cv=none; b=caJfdpo7olcmDceu1CV/YB2Nzf6xiDy2v6uDh0ZO5HtOf4D4pBRklFztZiQzXw986fzWp557o8JFh2eu23eQRmKPA+jiRYXEfnfDTh0UZfLeWopBc2VLigBuE4Cp/LwnQYVPnPlfCjdyAdls1KLfgf2aU3ZupOMfTHUyubGIT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778834; c=relaxed/simple;
	bh=d4BPAl8E3Dm09yCOVd3XA7SEoS8RfDbW5WMT2FhpHYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKu3+bHYrNUObQcikZVytVc+aAUUw1M0Upsz/Oxyv21lQSkxpjUROPQxu8I/+6QItjA1fZ/JVhj/Ib1j9suwxJKHFc3pOjXQZW1XuzLri0DQuoWMru9pzvkg/WajB95MlyoYc+QOaHajcF7ohBM/FWnPMK6hpsgKUArk5TK/EYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778778tc8efd777
X-QQ-Originating-IP: yFe5c6uxVrjeoUe5s8CG3z/paGQ1wb2GYQ4lPU9o5c0=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1063588999199690612
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
Subject: [PATCH net-next v4 05/10] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Fri,  6 Mar 2026 14:32:06 +0800
Message-Id: <20260306063211.20536-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MiiEV9CzP8OGK0Ow4I1yyRN76WnP9+xUEJjqOlxMWu4u58RLjF41rIxG
	OS2qqo+8rDndeRaRPcLS9hvHxJZjMOJRhxVCXuQ5/WRXi+kE7Zn0ehMkxlT8zfjyLPjIHLq
	HMrrNaG1MiviXU9I37kvhK4kuzKbOcMYK7Q623JEBWRWtQqe7iwv4UOArUf2nTFi8JT8b6Z
	AuePq2PFA4BJpYk+1L+KLV3AG8o56OyK7JLsvsk/nvk+n155SxKGlwmhMQfLWAIYBnRvmMl
	pD0uD8hA2vijmIqy7Rv79m5h3mWPT5c+52zRIN61zlSH0gsNUUF6of8DAEwEuELzzqGt8Xw
	Rc68vhhwu9Cpftaf00F+VENMD02Ux8LaL9CBdLsp4idzSB1kQpKZO+MRGZNkZvfUteyjU5K
	IrFQdACP8U+w0ZRe16p0axcktPYhlkGG36YU7BK/z9G898rJp3Jfx/TwY97aLJv3lGZ52DJ
	qCVeFfIxlubgMLQ7L/cw1tJHX0nU3yzmHlVXf1j8Vh6+rkYtK9K5HWnErF9L1Mc/kl/WOlY
	qUbpP3sLITuUqg1RtmiomQ2ljyxfwNZOt4ty3wwn/ZJpEoqUvofwnPtA7O8e7ScScTUDXx0
	B+k9ru2YQvzQXGhQq2IDoBgY71MZbZ5lvDjEAXJIihEdf6eyL7trvOs4i7Jz808YRSFc4iq
	B2BU8liL36ee/2Go6TlGGUouJ1TtdY3UrFrpXKi9a/JtLNBZiavsqt4yT3ga1ybm3OwII9l
	0gI2rSNiIVVfsNCIHTvdBGc8ss+0umy4TOxyWh1VhUZYQ20qDZFUTZMlYJQcByBzgIa6inW
	V0C8eajm34ADnu/+YjB6SWT5XgQV2J7yBzAQDcHCz+Z24Bsh1Zku7FuEHciz6Q+4/BEDgEQ
	/oSJyMQc0DvqbwjatT2poeeOf14ZeLz3LRyYgbqiK5gL7OvVZnJ2rKZR48/iKtuEroZvdgc
	Z6BvQSA7kyFZY8qkIaPsAv+hI36T6LfmSOxyRSy8/jwsemAFqVFIRkVRO3B+kEjvXPAREi4
	Q7j2PdkvyviyxuIxWmAx9kLuPcH+GVd9LIRN9LUspYDvX1CBBA5T2rkJUNxhU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: CC1DC21C1B1
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
	TAGGED_FROM(0.00)[bounces-264692-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


