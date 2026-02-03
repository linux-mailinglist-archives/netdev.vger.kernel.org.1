Return-Path: <netdev+bounces-256183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGb/BVWrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE09D5F07
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2C1302616A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE2392C3B;
	Tue,  3 Feb 2026 07:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A7392C50
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105596; cv=none; b=IAe4Zl7P5v/Yiaugc0VrZuMzCuf9BvWz3Ms1ijJZZnbLmrZ6pw2ZdjnnsrtG+5/+hoPyU8l7k3k+kENOCsAsYmeXfuoJofdVnQuW1gEpArsbj2g81Bc2BalU98fBn2Ln/TySv5jkV7s/gfe4oNKMSrQqAt3cgl4m7fjfBdtUJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105596; c=relaxed/simple;
	bh=Dk1nTqIMRx6RFcW5QBL/LWALC8d7F3rLKi0DgNfBX5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9C86u2dRxL2fc2s+lWxcMQSvb52dZmo2qKrRHmZpZPxbKFWKbvRBAd/Vv5ago7hEyPfNgFuGdovXWtSx723kgeyICXgv3I1ZlvNbzRyGv7htqsHu01nCnTkxrMFsyzqnxkWiA/tq+LrxV0lpynRajA4kOSYbJtend24eYw6DQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105514t26661bd2
X-QQ-Originating-IP: /Q5pWAoW/Vrm82c3Ejgcx2WaC02mdu88P9D0S94mgZ8=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8704012657956629175
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
Subject: [PATCH net-next v1 7/7] net: wangxun: add pcie error handler
Date: Tue,  3 Feb 2026 15:57:59 +0800
Message-Id: <20260203075759.5852-8-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NKjpL9D7hCRxPNbL38EaFUUFFmJ5xyejLmJBP3D8CffW7NuVOJBFh5Jj
	p2VBw+d+L0LtuVJc2WV/40Ht3CjgBZlR9SJC3K5cwR+Nj11kifi9sYLXQCUZuziMm08i9Gc
	q31Jkr3LY/GGA1NVPbIzWhElamfdSa5Z/hTAXF4JSYxD3QfSmacgKXb6UsAePPhLfseT/2X
	rytRNr0JtsQxejxwJaRcC85huLvPl2e8klunJ7K/VnU/tTJX/37pVUiAbR4mKeGndSHWEL1
	mCX2M9EtFEc5KMoZUKgR1jp1XW5m3fH26H2NOJEvi42NfLnUMNN4Zilgb3V4WzoKuM9O7Kp
	SeUGVAapY5bBlYNQdsmLJkOpEtCNlikWEltoH4ba7TirYpwYVQkrKVtFk02JgUGgs3NJ+GF
	5HaUs8vSq/9tF6V0JZznJgeYYnWnUcMdJB64da2hyZbDvGilYiZnBe5FcnUpoxti1WUwvHK
	aYLXFAo8xt/4B4rN0Yvl7l1qf7Hck/9yqo9ToiVatSBjiOCUmwsJvrWRZoHomCbjqbNaS1k
	KCGSSDSe6KJm9BwEnJ7uyb1MDuw5KZ8W31bgRcIiFP7nfJPB9+/NCRMSMaHE1pZGDer6vk1
	pn0p7oeug1smEw1nKi3i03var7GCaxuxw/4v4t/uOCU10lWdb6wXUolZEf/o5tzfuoWkQOJ
	bCJN2GXjqmNi6DbV831ZxUPFL+FoZFOoxy6biehyu8/KCmWm+ueQbh2eI0aYafPsjPv8BOD
	C6aa5ceH70wJfmfctljP4FXXd5JPvTW+JM+XLtcBDevOxXaIuJUAKzF6MplLp3q14aGlGfC
	UEjFBGf3yVeruJ0KW6bOSp5fsHNy10utIl7NFKyJazp9SZokTMpbpkgn9SfxwW8lX+8+GWv
	+v65LBY8Plbd4F5TqyA9ikESrHI374LkC4R/DsNH+yIVo3lD5KjCJIzP9Un+0vJCuvtSi40
	b5cmQdliu51iBok0zcn6+/OGa5xFhCkSzxn/QSzcAXvmS/pMPFP3uMuSSeXIsTxB6fZ1Q6X
	m0WM3Jn8B0VoqQyv5tArCnxZzsWgRXxDb/pSo8teV41gTDLM29/BAmcLUTnzwuyYasFOywz
	xvvpDRbETqlI+npsS9ITe4=
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
	TAGGED_FROM(0.00)[bounces-256183-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7BE09D5F07
X-Rspamd-Action: no action

Support to check pcie error and invoke aer driver to recover pcie.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 235 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  56 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  13 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   5 +-
 11 files changed, 339 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index bb77bdce69d2..36eb06bd1798 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -3,10 +3,228 @@
 
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_err.h"
+#include "wx_hw.h"
+
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
+	wx->io_err = true;
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
+	wx->io_err = false;
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
+static bool wx_check_pcie_error(struct wx *wx)
+{
+	u16 vid, pci_cmd, devctl2;
+	u32 value;
+
+	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
+	wx_warn(wx, "PCI vendor id is 0x%x\n", vid);
+	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
+	wx_warn(wx, "PCI command reg is 0x%x\n", pci_cmd);
+	pcie_capability_read_word(wx->pdev, PCI_EXP_DEVCTL2, &devctl2);
+	wx_warn(wx, "Device Control2 Register: 0x%04x\n", devctl2);
+
+	value = rd32(wx, WX_MIS_PWR);
+	wx_warn(wx, "MIS_PWR value is 0x%08x\n", value);
+	value = rd32(wx, WX_PX_IMS(0));
+	wx_warn(wx, "PX_IMS0 value is 0x%08x\n", value);
+	if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		value = rd32(wx, WX_PX_IMS(1));
+		wx_warn(wx, "PX_IMS1 value is 0x%08x\n", value);
+	}
+	value = rd32(wx, WX_TDB_TFCS);
+	wx_warn(wx, "Tx flow control Status[TDB_TFCS 0xCE00]: 0x%x\n", value);
+
+	/* PCIe link loss or memory space can't access */
+	if (vid == WX_FAILED_READ_CFG_WORD || !(pci_cmd & 0x2))
+		return true;
+
+	return false;
+}
+
+static void wx_check_error_subtask(struct wx *wx)
+{
+	u32 sm;
+
+	if (test_bit(WX_FLAG_ERROR_CHECK, wx->flags)) {
+		/* get PF semaphore */
+		wr32(wx, WX_MIS_PF_SM, 1);
+		clear_bit(WX_FLAG_ERROR_CHECK, wx->flags);
+	}
+
+	sm = rd32(wx, WX_MIS_PF_SM);
+	/* PCIe memory space access error */
+	if (sm == U32_MAX)
+		goto out;
+
+	/* PCIe error may be occurred in another port */
+	if ((sm == 1 && wx_check_first_lan_up(wx)))
+		goto out;
+
+	return;
+out:
+	set_bit(WX_FLAG_NEED_PCIE_RECOVER, wx->flags);
+	wx_warn(wx, "Set PCIe recover on LAN %d\n", wx->bus.func);
+}
+
+static bool wx_check_recovery_capability(struct pci_dev *dev)
+{
+#if defined(__i386__) || defined(__x86_64__)
+	return true;
+#else
+	/* check upstream bridge is root or PLX bridge,
+	 * or if CPU is kunpeng 920
+	 */
+	if (dev->bus->self->vendor == PCI_VENDOR_ID_PLX ||
+	    dev->bus->self->vendor == PCI_VENDOR_ID_HUAWEI)
+		return true;
+	else
+		return false;
+#endif
+}
+
+static void wx_pcie_do_recovery(struct pci_dev *dev)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+	struct aer_capability_regs *regs = &wx->aer_info;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	memset(regs, 0, sizeof(*regs));
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &regs->uncor_status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &regs->uncor_mask);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &regs->uncor_severity);
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &regs->cor_status);
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &regs->cor_mask);
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &regs->cap_control);
+
+	aer_recover_queue(pci_domain_nr(dev->bus), dev->bus->number,
+			  dev->devfn, AER_FATAL, regs);
+}
+
+static void wx_pcie_recovery_subtask(struct wx *wx)
+{
+	if (!test_bit(WX_FLAG_NEED_PCIE_RECOVER, wx->flags))
+		return;
+
+	/* release PF semaphore */
+	wr32(wx, WX_MIS_PF_SM, 0);
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
+		wx_warn(wx, "PCIe recovery skipped in SR-IOV mode\n");
+		goto out;
+	}
+
+	if (wx_check_recovery_capability(wx->pdev)) {
+		wx_warn(wx, "Do PCIe recovery\n");
+		wx_pcie_do_recovery(wx->pdev);
+	} else {
+		wx_warn(wx, "This platform can't support PCIe recovery, skip it\n");
+	}
+
+out:
+	clear_bit(WX_FLAG_NEED_PCIE_RECOVER, wx->flags);
+}
 
 static void wx_reset_subtask(struct wx *wx)
 {
@@ -57,11 +275,20 @@ static void wx_check_tx_hang_subtask(struct wx *wx)
 
 void wx_handle_errors_subtask(struct wx *wx)
 {
+	wx_check_error_subtask(wx);
+	wx_pcie_recovery_subtask(wx);
 	wx_reset_subtask(wx);
 	wx_check_tx_hang_subtask(wx);
 }
 EXPORT_SYMBOL(wx_handle_errors_subtask);
 
+void wx_pcie_error_handler(struct wx *wx)
+{
+	set_bit(WX_FLAG_ERROR_CHECK, wx->flags);
+	wx_service_event_schedule(wx);
+}
+EXPORT_SYMBOL(wx_pcie_error_handler);
+
 static void wx_tx_timeout_reset(struct wx *wx)
 {
 	if (!netif_running(wx->netdev))
@@ -75,9 +302,12 @@ static void wx_tx_timeout_reset(struct wx *wx)
 void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
 	struct wx *wx = netdev_priv(netdev);
+	bool pcie_error;
 	u32 head, tail;
 	int i;
 
+	pcie_error = wx_check_pcie_error(wx);
+
 	for (i = 0; i < wx->num_tx_queues; i++) {
 		struct wx_ring *tx_ring = wx->tx_ring[i];
 
@@ -95,7 +325,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 			i, head, tail);
 	}
 
-	wx_tx_timeout_reset(wx);
+	if (pcie_error)
+		wx_pcie_error_handler(wx);
+	else
+		wx_tx_timeout_reset(wx);
 }
 EXPORT_SYMBOL(wx_tx_timeout);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
index e317e6c8d928..f1d14d622f14 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -7,7 +7,10 @@
 #ifndef _WX_ERR_H_
 #define _WX_ERR_H_
 
+extern const struct pci_error_handlers wx_err_handler;
+
 void wx_handle_errors_subtask(struct wx *wx);
+void wx_pcie_error_handler(struct wx *wx);
 void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 8e3e02ffb5a4..ec0c8e2ba511 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -10,6 +10,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_err.h"
 #include "wx_sriov.h"
 #include "wx_vf.h"
 #include "wx_hw.h"
@@ -2308,8 +2309,11 @@ int wx_disable_pcie_master(struct wx *wx)
 	/* Poll for master request bit to clear */
 	status = read_poll_timeout(rd32, val, !val, 100, WX_PCI_MASTER_DISABLE_TIMEOUT,
 				   false, wx, WX_PX_TRANSACTION_PENDING);
-	if (status < 0)
+	if (status < 0) {
 		wx_err(wx, "PCIe transaction pending bit did not clear.\n");
+		if (!wx->io_err)
+			wx_pcie_error_handler(wx);
+	}
 
 	return status;
 }
@@ -2517,6 +2521,7 @@ int wx_sw_init(struct wx *wx)
 	bitmap_zero(wx->state, WX_STATE_NBITS);
 	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
 	wx->misc_irq_domain = false;
+	wx->io_err = false;
 
 	return 0;
 }
@@ -2974,4 +2979,53 @@ void wx_start_hw(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_start_hw);
 
+void wx_set_pci_lan_up(struct wx *wx, bool up)
+{
+	u8 max_lan;
+	u32 reg;
+
+	if (wx->mac.type == wx_mac_em)
+		max_lan = 3;
+	else
+		max_lan = 1;
+
+	if (wx->bus.func > max_lan) {
+		wx_err(wx, "%s: invalid bus lan id %d\n",
+		       __func__, wx->bus.func);
+		return;
+	}
+
+	reg = rd32(wx, WX_MIS_PRB_CTL);
+	if (up)
+		reg |= BIT(max_lan - wx->bus.func);
+	else
+		reg &= ~BIT(max_lan - wx->bus.func);
+	wr32(wx, WX_MIS_PRB_CTL, reg);
+}
+EXPORT_SYMBOL(wx_set_pci_lan_up);
+
+bool wx_check_first_lan_up(struct wx *wx)
+{
+	u8 max_lan, i;
+	u32 reg;
+
+	if (wx->mac.type == wx_mac_em)
+		max_lan = 3;
+	else
+		max_lan = 1;
+
+	/* Check whether the current port is the first (smallest number)
+	 * among the ports up on this board.
+	 */
+	reg = rd32(wx, WX_MIS_PRB_CTL);
+	for (i = 0; i <= max_lan; i++) {
+		if (reg & BIT(max_lan - i))
+			break;
+	}
+	if (i == wx->bus.func)
+		return true;
+
+	return false;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 13857376bbad..1ab30a983b68 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -59,5 +59,7 @@ int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause);
 void wx_update_stats(struct wx *wx);
 void wx_clear_hw_cntrs(struct wx *wx);
+void wx_set_pci_lan_up(struct wx *wx, bool up);
+bool wx_check_first_lan_up(struct wx *wx);
 
 #endif /* _WX_HW_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 76bda834c59f..cbd391f1c027 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3421,7 +3421,8 @@ static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 int wx_suspend(struct pci_dev *pdev, pm_message_t state)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 434a582393d7..68d06d6619ab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -11,6 +11,7 @@
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
 #include <linux/dim.h>
+#include <linux/aer.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -30,9 +31,11 @@
 
 /* chip control Registers */
 #define WX_MIS_PWR                   0x10000
+#define WX_MIS_PF_SM                 0x10008
 #define WX_MIS_RST                   0x1000C
 #define WX_MIS_RST_LAN_RST(_i)       BIT((_i) + 1)
 #define WX_MIS_RST_SW_RST            BIT(0)
+#define WX_MIS_PRB_CTL               0x10010
 #define WX_MIS_ST                    0x10028
 #define WX_MIS_ST_MNG_INIT_DN        BIT(0)
 #define WX_MIS_SWSM                  0x1002C
@@ -308,6 +311,7 @@
 #define WX_TDM_VLAN_INS_VLANA_DEFAULT BIT(30) /* Always use default VLAN*/
 
 /****************************** TDB ******************************************/
+#define WX_TDB_TFCS                  0x1CE00
 #define WX_TDB_PB_SZ(_i)             (0x1CC00 + ((_i) * 4))
 #define WX_TXPKT_SIZE_MAX            0xA /* Max Tx Packet size */
 
@@ -1196,6 +1200,7 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1263,6 +1268,8 @@ enum wx_pf_flags {
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PF_RESET,
+	WX_FLAG_ERROR_CHECK,
+	WX_FLAG_NEED_PCIE_RECOVER,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1358,6 +1365,8 @@ struct wx {
 #define WX_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
 	u32 wol;
+	bool io_err;
+	struct aer_capability_regs aer_info;
 
 	u16 bd_number;
 	bool default_up;
@@ -1415,6 +1424,8 @@ struct wx {
 #define WX_INTR_ALL (~0ULL)
 #define WX_INTR_Q(i) BIT((i))
 
+#define WX_FAILED_READ_CFG_WORD  0xffffU
+
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
 #define rd32(a, reg)		readl((a)->hw_addr + (reg))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 3171a98d81a6..653a98d9835b 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -234,6 +234,12 @@ static irqreturn_t __ngbe_msix_misc(struct wx *wx, u32 eicr)
 	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
 		wx_msg_task(wx);
 
+	if (eicr & NGBE_PX_MISC_PCIE_REQ_ERR) {
+		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
+			wx->bus.func);
+		wx_pcie_error_handler(wx);
+	}
+
 	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
 		wx_ptp_check_pps_event(wx);
 
@@ -392,6 +398,7 @@ static void ngbe_disable_device(struct wx *wx)
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
 	timer_delete_sync(&wx->service_timer);
+	wx_set_pci_lan_up(wx, false);
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, false);
 	wx_irq_disable(wx);
@@ -439,6 +446,8 @@ static void ngbe_up_complete(struct wx *wx)
 	netif_tx_start_all_queues(wx->netdev);
 	mod_timer(&wx->service_timer, jiffies);
 
+	wx_set_pci_lan_up(wx, true);
+
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
 	rd32(wx, WX_PX_MISC_IC);
@@ -819,6 +828,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -868,7 +878,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver ngbe_driver = {
@@ -880,6 +891,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = wx_resume,
 	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index eb5c92edae06..69ee8f1f74f0 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -70,12 +70,14 @@
 #define NGBE_PX_MISC_IEN_INT_ERR		BIT(20)
 #define NGBE_PX_MISC_IC_VF_MBOX			BIT(23)
 #define NGBE_PX_MISC_IEN_GPIO			BIT(26)
+#define NGBE_PX_MISC_PCIE_REQ_ERR		BIT(27)
 #define NGBE_PX_MISC_IEN_MASK ( \
 				NGBE_PX_MISC_IEN_DEV_RST | \
 				NGBE_PX_MISC_IEN_TIMESYNC | \
 				NGBE_PX_MISC_IEN_ETH_LK | \
 				NGBE_PX_MISC_IEN_INT_ERR | \
 				NGBE_PX_MISC_IC_VF_MBOX | \
+				NGBE_PX_MISC_PCIE_REQ_ERR | \
 				NGBE_PX_MISC_IEN_GPIO)
 
 /* Extended Interrupt Cause Read */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index aa14958d439a..c832100bcb61 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -6,6 +6,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_sriov.h"
@@ -178,6 +179,12 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		handle_nested_irq(sub_irq);
 		nhandled++;
 	}
+	if (eicr & TXGBE_PX_MISC_PCIE_REQ_ERR) {
+		wx_warn(wx, "PCIe Request Error founded on Lan %d\n",
+			wx->bus.func);
+		wx_pcie_error_handler(wx);
+		nhandled++;
+	}
 	if (unlikely(eicr & TXGBE_PX_MISC_IC_TIMESYNC)) {
 		wx_ptp_check_pps_event(wx);
 		nhandled++;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8d2302c62ebf..48d418574ee8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -182,6 +182,8 @@ static void txgbe_up_complete(struct wx *wx)
 	netif_tx_start_all_queues(netdev);
 	mod_timer(&wx->service_timer, jiffies);
 
+	wx_set_pci_lan_up(wx, true);
+
 	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
 	wr32m(wx, WX_CFG_PORT_CTL, WX_CFG_PORT_CTL_PFRSTD,
 	      WX_CFG_PORT_CTL_PFRSTD);
@@ -231,11 +233,7 @@ static void txgbe_disable_device(struct wx *wx)
 
 	timer_delete_sync(&wx->service_timer);
 
-	if (wx->bus.func < 2)
-		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);
-	else
-		wx_err(wx, "%s: invalid bus lan id %d\n",
-		       __func__, wx->bus.func);
+	wx_set_pci_lan_up(wx, false);
 
 	if (wx->num_vfs) {
 		/* Clear EITR Select mapping */
@@ -886,6 +884,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -955,7 +954,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -967,6 +967,7 @@ static struct pci_driver txgbe_driver = {
 	.resume   = wx_resume,
 	.shutdown = wx_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index e9360e935682..74ac762a8c34 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -54,8 +54,7 @@
 /* chip control Registers */
 #define TXGBE_MIS_RST                           0x1000C
 #define TXGBE_MIS_RST_MAC_RST(_i)               BIT(20 - (_i) * 3)
-#define TXGBE_MIS_PRB_CTL                       0x10010
-#define TXGBE_MIS_PRB_CTL_LAN_UP(_i)            BIT(1 - (_i))
+
 /* FMGR Registers */
 #define TXGBE_SPI_ILDR_STATUS                   0x10120
 #define TXGBE_SPI_ILDR_STATUS_PERST             BIT(0) /* PCIE_PERST is done */
@@ -89,10 +88,12 @@
 #define TXGBE_PX_MISC_INT_ERR                   BIT(20)
 #define TXGBE_PX_MISC_IC_VF_MBOX                BIT(23)
 #define TXGBE_PX_MISC_GPIO                      BIT(26)
+#define TXGBE_PX_MISC_PCIE_REQ_ERR              BIT(27)
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
 	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR | \
+	 TXGBE_PX_MISC_PCIE_REQ_ERR | \
 	 TXGBE_PX_MISC_IC_VF_MBOX | TXGBE_PX_MISC_IC_TIMESYNC)
 
 /* Port cfg registers */
-- 
2.48.1


