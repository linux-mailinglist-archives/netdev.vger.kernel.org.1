Return-Path: <netdev+bounces-271808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DyaN3CXxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8232E4D0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36AD6302AF24
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7E390221;
	Thu, 26 Mar 2026 02:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885C33AD8C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491466; cv=none; b=XyY8PMKGuK02ROxD48tXO0IK9jxBD6zxehmv11so67oIwZQrJCL8IQOOnRoZn8ssC6Owm73Mc2d5BqafQrwcUDpwiV/+e7/l0NNgErmFzkPuxkWMFgWGf14XX8LLRouRnlNXe3MhOzgAqoa7UZWqWSldG2AS50GFrA7N8BvPS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491466; c=relaxed/simple;
	bh=QqH7Wdg59WRrg279JM6iirCloQWd8/iwHmLoiowCroc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4fzOyYEkow7mZkGTsdK2CZSwMO6NKMHlyNQia3kNtmjiUVsBJ1bxxD8JWPVBToLwujeyMSUA1mnlIQ9uFrchg3fNvhdvTjSLBEFXP7Hg6LQ26SFVZAOVUOyjTq1Tt7Q8cBTD9esF1jCeuaSUAplumHLTRhcB0J8tnMDc0JaAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491347tbd1ddf50
X-QQ-Originating-IP: IyiggHlmL/S654Nz76+QAx2Z7PpeV8v3zdkgPQAfQPg=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 513056848894671807
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 11/11] net: wangxun: implement pci_error_handlers ops
Date: Thu, 26 Mar 2026 10:14:06 +0800
Message-Id: <20260326021406.30444-12-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OJ1IEQL1epI3s5vkeKsgH7XDA4c8asPJGnaEGAltgGEmFQt4NN+AHNg0
	XL6A3VCi6erJXQG42LfZ0lNg9z6Hh8mlCOD1vovnhpU6av1uQs9RkF6bo7v9quPQTo7+jt0
	S3Q7YgROlUKXKH0EVl2BStjIqgzzM0JDjuZNoO3NbPD8E8aeRLY124axNqYnns4rAgXusLS
	RRXXrjJ3snQqbQRiJGMYyzLH91cnaVOzXnT71zncNdlZahIDPlPByF/r1q/8qqhQo+4Ed6j
	Qx3amIZYhVMqFxQNb7lf4p6IFveV+yufGQlFh0ViUlrfS6jJDfSRf79CCcjohV/KNtKgAQX
	KctAfOyJ2kkN/fRupPg34jl5zV8xFh9j5diHu8gPnNQoFguQLSqgKyf9+BfW00HXRb7aduJ
	Fk8jS5qTJF9yj9i/nGSFbkhVr7XALxa49Lc7wqcqSyrnhVJMPMuoR5XHE5Kd+pub7ZoLHhW
	bUc5A02x4ONZ7zBAVePO3RYrbDH/nNUKj9J/kxJ1Inj39dJGrC69RfwGUXCURVKO1EKXcNM
	dP9Lp8FCr5nl7SiBKxFPqyG4eY43PjbdppUUb1cvFbMfoItIJqyxHMZtp7uQBcWYXxfrflc
	brRiPhXcEtcS8YdIt9Zy+m1Hu5PJqnl2PA9dSNsz1FfN0Mv4dvbqUzoUvZ1AtGPxoIW6uj/
	to+qlE9AohJ5qGUN2OKLWdQSMFKRRt1x8i100oM+GoIJhrqk+tz6ufYmYXnBv1eYqVnIf9G
	le8ImaLeby2SNP5i9gxW1zxWHSfk4taM34p44neAe9yRWBBVTmRb3a65CMihNhej0CtqzAx
	22sfYecqatRoNxEAgQ5WOs52WAHJsvM/1+a5gEDNqRVynwBMDcj6VBAIcEhunw1vhwYlgaX
	HRpbdZAjfobl53F2ntdrVtWwOT5UZYv2acjsjj3pT8HIIayDyz5WceEv/qupp7Y5XLaOr8k
	FLDtg8Vu3hIa9w7frLTZQ99igppgswct81+MiLnl64Xqpg9WabWQ1RgfTgpSutIl/r7lwvq
	CGaCF9UiIv3sJsKL9NPeXB7X5jj0dwZkjWMXsg7gsd13zbjgUPV+4g6uJRArFBHQmmjcW6G
	tH0m5bB5ryEXr9dqz7H2jlEKqGNhNHWHw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
	TAGGED_FROM(0.00)[bounces-271808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,trustnetic.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59D8232E4D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Support AER driver to handle the PCIe errors.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 102 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   5 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   5 +-
 6 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index bb77bdce69d2..86b318647a3c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -3,11 +3,113 @@
 
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
+		pci_save_state(pdev);
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
+
+	netdev = wx->netdev;
+	rtnl_lock();
+	if (netif_running(netdev))
+		netdev->netdev_ops->ndo_open(netdev);
+
+	netif_device_attach(netdev);
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
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index be7a170a4029..09be700f69bb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3406,7 +3406,8 @@ static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 int wx_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -3434,6 +3435,8 @@ int wx_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 510fab4b3a0f..117cebbb9a67 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1208,6 +1208,7 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
 	WX_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 080310a51ef8..3715db4ec912 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -808,6 +808,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -858,7 +859,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver ngbe_driver = {
@@ -870,6 +872,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = wx_resume,
 	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index e9439e4ebe61..4f0af47260a9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -885,6 +885,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -955,7 +956,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -967,6 +969,7 @@ static struct pci_driver txgbe_driver = {
 	.resume   = wx_resume,
 	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.48.1


