Return-Path: <netdev+bounces-282701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iELjBlIS82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2C49F386
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73104302978E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC83FE350;
	Thu, 30 Apr 2026 08:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF439BFED
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537583; cv=none; b=ciCC4O2+tdM/3SlBBPUEMrEXCON2WVvwAt7EqhCasD7lyGAVKqBezD0XvniI9ScvwWHwu5ysoGnUmCwAIkPooLJrnn2RUnxokJ9W4EZ7AnZJVXJQS6Q3rayXAM20Jq5XU9x0SAtZZTZjCd9iYJGVwqRifyv0lrXMfru4KTmdLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537583; c=relaxed/simple;
	bh=MpjzlxvyJAWfUp8BFPrQ91zje5Cjfp3Q9RWh5/ploXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGQYq86uycFFwVMAXnxM8F4MF0y52M/rZiSry62zTan65vC8nrFmDegtxO91eK0XaPfPQWB8rRniE9k8tcHQjislsNEmyjSextGcq4EooerGfZF1I34W0s9xXLlpdoBSlX6Nun8DzUxKSr7nU8jRISVpZPf8imY/YcVeac8sDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537557tee68f061
X-QQ-Originating-IP: Z6bhiH130/pZkltjjzsxAZivBv0goCG+jyhPI9t7aCY=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12186848776330360127
EX-QQ-RecipientCnt: 17
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
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 6/6] net: wangxun: implement pci_error_handlers ops
Date: Thu, 30 Apr 2026 16:25:17 +0800
Message-Id: <20260430082517.19612-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260430082517.19612-1-jiawenwu@trustnetic.com>
References: <20260430082517.19612-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMGzQWUSIfvTFpWTp8Nf3vZlQGAh/8udO20f5LrIoTgpGgA1fTkkLwi5
	jQiMF0aDxBoHnMc/SeENeEGxuyMNA54dNNSGZAMmdJtWYxnYJ4jQKGRJP0eHs+jQxVoXJ0v
	mOnr7LFoVx7EPN78q12gPHS6i+fNKg9CeplWzv+WFQOGY4Ltva88WvR3iOPySJVmPlQiLHQ
	DTlKIf5UGTBQEyt8InlqcyFoEY3oUexzrf93dXiiwmysQZIU5lahYzRPcHXKKGow+IYIX+Q
	3tVRYfTWv1qOqGQisXKMFoMehYhEMi1ve4ZljV3WkZGJtBtwN7EVmB9OtGPDZQZnnTTFFlV
	x7i8zJOV+0+r2kQcVwjl+dn6kmGQIxL3YcDt+ld4pHI8hSWSOMoQecbmOaSRKZO/vQzrEuG
	FdjrpUc5pYRs1T8uWaiHVIQ5Xkbt1tbeQ4fo2TlFLYGyhbabh1iS8za5n2eWE08hNCnW6By
	KON70uTnLiAlHFiV/CKd5HdYUDHkwiiN5dcmdrQsxb87YOcalDS/MLjUAv88hqzTwizWiky
	T6EJxb7muY+CdHSrev800i2qhF+8GsMg7TfEwis8LAfKSlAZRX1aR/QZNk7veEMJG/wa52u
	2EUezoaZvLt5srt0KCwEI1qizWxvXvoJacB9OFj9Nkal+yUmhrZyc4z3h1Gnou/EErIOeF0
	+ou95TNDHUeiNltg6+ZeHgQSYqHgrrsq4/dNij2FjX/K5o920X8zCdOD956Z4XHaljp6yDA
	mSIUH3s8tkMPdARoxmyWNYszIroxbDgiA1G4uNPudZ5+1Fe+4MvBzh+dJhPBqYuBTiQxORg
	I5GcItHPUEVpuMjrvECvILRsVoQS80OAXepx56qg68wLk9ACVIYFd83vl3ms+AOPPaIGh8V
	tNO8yga21W/nvtjFPwboMJ+PXpsWxBguygRxnTuwxufOJcn0MKSO/Lll9ErImuuzPQkrJ9f
	znVC1z1zRC83JtuG3Lkv8JT9R8IRjkS4ZaM8cO3jPe6X6gWuI5KuhWaVcq2JItV1RuSCLsx
	ThpO/aQqS0fJSS6ehMLrJ2zA5EoTPRTNaHEZSLZXD2Hk/AVGEsnjBfnin1PBvudPuYDbibi
	XVmC0aHl5KX
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 7CF2C49F386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282701-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	NEURAL_SPAM(0.00)[0.934];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]

Support AER driver to handle the PCIe errors.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 107 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   9 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 +-
 5 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index 124011c3d5b1..32d063ee52f4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -3,11 +3,118 @@
 
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_err.h"
 
+/**
+ * wx_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci connection state
+ *
+ * Return: pci_ers_result_t.
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
+					     pci_channel_state_t state)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	netdev = wx->netdev;
+	if (!netif_device_present(netdev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev))
+		wx->close_suspend(wx);
+
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
+	rtnl_unlock();
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * wx_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Return: pci_ers_result_t.
+ *
+ * Restart the card from scratch, as if from a cold-boot.
+ */
+static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	pci_ers_result_t result;
+
+	if (pci_enable_device_mem(pdev)) {
+		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
+		result = PCI_ERS_RESULT_DISCONNECT;
+	} else {
+		/* make all bar access done before reset. */
+		smp_mb__before_atomic();
+		clear_bit(WX_STATE_DISABLED, wx->state);
+		pci_set_master(pdev);
+		pci_restore_state(pdev);
+		pci_wake_from_d3(pdev, false);
+
+		wx->do_reset(wx->netdev, false);
+		result = PCI_ERS_RESULT_RECOVERED;
+	}
+
+	pci_aer_clear_nonfatal_status(pdev);
+
+	return result;
+}
+
+/**
+ * wx_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation.
+ */
+static void wx_io_resume(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	int err;
+
+	netdev = wx->netdev;
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		err = netdev->netdev_ops->ndo_open(netdev);
+		if (err) {
+			wx_err(wx, "Failed to open netdev after reset\n");
+			goto out;
+		}
+	}
+	netif_device_attach(netdev);
+out:
+	rtnl_unlock();
+}
+
+const struct pci_error_handlers wx_err_handler = {
+	.error_detected = wx_io_error_detected,
+	.slot_reset = wx_io_slot_reset,
+	.resume = wx_io_resume,
+};
+EXPORT_SYMBOL(wx_err_handler);
+
 static void wx_reset_subtask(struct wx *wx)
 {
 	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
index e317e6c8d928..8b1a7863b5b1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -7,6 +7,8 @@
 #ifndef _WX_ERR_H_
 #define _WX_ERR_H_
 
+extern const struct pci_error_handlers wx_err_handler;
+
 void wx_handle_errors_subtask(struct wx *wx);
 void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 4b72835ddec1..81e12609d3fa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1215,6 +1215,7 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
 	WX_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2bd00eade11d..244123f203de 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -570,7 +570,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void ngbe_shutdown(struct pci_dev *pdev)
@@ -856,6 +857,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -907,7 +909,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -934,6 +937,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -958,6 +962,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 3bfb3328b8f3..a89b0a8643b3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -552,7 +552,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
 
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void txgbe_shutdown(struct pci_dev *pdev)
@@ -900,6 +901,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -970,7 +972,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -980,6 +983,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.51.0


