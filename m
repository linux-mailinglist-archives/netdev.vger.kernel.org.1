Return-Path: <netdev+bounces-261750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAjGER9KoWnWrwQAu9opvQ
	(envelope-from <netdev+bounces-261750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:39:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D699C1B403A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F049D3157F34
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD933603DD;
	Fri, 27 Feb 2026 07:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D636AB77
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177786; cv=none; b=nbICzbfPlxCsWrMbcTVQzCG4n/7ToQHQndgTa93Y6ewRS3dNL5omkXBlS3gELx6M1fwp8poKJfq4LvI64iz4/pRPjWsQVruJDOpa/j2MIT8NjWoxKvCmN6CQcZqW6HEI637fUcOBoi1wM/3bD1rsOXIirTl/uTvm/2cnwnvjXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177786; c=relaxed/simple;
	bh=/ndazwx7PAVUiX2eBTyuNB807noBgmPXIeeCsDrnLQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSF5FAabrlbWn6/hCPegkVvRxjK6V05VOSDrPMKCGTq9ZSk3GkhcrfDMJboHmERj30SR5CxHaOKYfKTz7ru+WVzHqSmh9ViOum0KYjBhjIOl8KOfG+Db7Rhz1MuPjhtdR00dtH0TMWlGr/l/u314OM4e+0Ls43puJKWX5QXbXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177721t5ccee8d9
X-QQ-Originating-IP: Ik0Y7M5rPQnWXBVn7RkAW6OrhpRGdA+b2Et414aQI20=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13465959567694685381
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
Subject: [PATCH net-next v2 8/8] net: wangxun: implement pci_error_handlers ops
Date: Fri, 27 Feb 2026 15:34:50 +0800
Message-Id: <20260227073450.23680-9-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: N55MlACpQQDvmvslgBGehdFH76KJpcrGlL5LWLzrMMxDTNsoouLHqB1o
	/AUrEGFjG7NYrWWevVK/BbFQSvqmH++p+PZFYA5yUUumLfay+LhKIGwsq8dRVMxg2f1VT3U
	JsEI3CJpXROYktMOcOozFIaw2qtsSsJ3rnmIQy2h25pPMubmHv0cpwHe5qJYNhT9ReLJx1v
	2Ms9at0P7VIoTtdAAyXsWzGNtpcl243eevkStH/OvNj8TtgM9M1yNZxac8SbF56UCd0LJml
	Ru3aHObMWgCY45iiczapjCf0TfxZgM8gnOar3jxPoUGtzHv+TiTi7SRAEUzpfQm60hgpqFe
	BxthlOBOQu4OvwMN801vlnzkqIwvqqduWuGFBZs74/olB/OAbcs3Aty33hnqtW5J2U4gdsN
	MKlPvxxCedSH04K+08pfZSW6S/zIQt/R/RUxWEDg9iE6YrOPME8OX7uIzf4KF+OZQk4DRcj
	7c+t4t/ngl3U+9VXKRVu0MWVHWaEOLsCyoOJqbLrwpthjuRUZMzrxMGf5IAzU/fI7EEB1WF
	fQpGysKV+JFDXfcWQYYWbVwP5FMDp+0vry2UyjHPH4RU7QgllrA3qXUMknZbxiNDG0nmRQq
	myj2bx1g8flPlloGLEvKJb9eUh5p8lD6MtSm2tE9tEF1zZ7fIsrWs3YE7ZnJGw9vMeo5Upv
	eCSFqxl/+Qfrvhvgs3xO4dLaXcn9yg+GIFXsJwPgxLJA5n4brFaF32q2cCufVFRHpnuL3bK
	44X8zjrLvkOwksQazMBh56Rp1Jkz215coee3j2ic/qFzhWGTpkB0vWGEKyEWAfTA3QN9PFE
	5kNPtltRIM+/J3qSHxYAXYi65IRp1Swj2D9IZhH7ezTa0S3lKrNGExQRTj+8gCwV1gM3h1C
	CmV5BRq/2vslGiWXuuLzQKZFnMihfQQdTjnzImDNwRnsesQwEtMoStuVMz2r9WWd3WxcLIg
	Lv42wTSSpn+cPm1DCkkQRFmzdA10CjJAKT0APtVu+d/4xKzrDYWTbFokBOvORqgWurDDApn
	qmQ4RZT+ieHcHU1u/SMP4CAFD6c1kp60FVip1HCcWm9tmZVc1K/Ej/R7e45t+F8So3od11e
	JDh7xghn9Eduu4R8DC11tXaJ0R9z4bDEA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
	TAGGED_FROM(0.00)[bounces-261750-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: D699C1B403A
X-Rspamd-Action: no action

Support AER driver to handle the PCIe errors.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 98 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  5 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  5 +-
 6 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index bb77bdce69d2..644d2d7bd183 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -3,11 +3,109 @@
 
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
index 5a21478a592b..1cd73b424d7f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3418,7 +3418,8 @@ static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 int wx_suspend(struct pci_dev *pdev, pm_message_t state)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 434a582393d7..142b166117fa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1196,6 +1196,7 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
 	WX_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 0ed33480b4f4..772f4188c00d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -819,6 +819,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -868,7 +869,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver ngbe_driver = {
@@ -880,6 +882,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = wx_resume,
 	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8d2302c62ebf..1dd5c08d5187 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -886,6 +886,7 @@ static int txgbe_probe(struct pci_dev *pdev,
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


