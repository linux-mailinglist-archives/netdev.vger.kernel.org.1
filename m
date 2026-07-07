Return-Path: <netdev+bounces-305286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fJ2MOfSZTGqjmwEAu9opvQ
	(envelope-from <netdev+bounces-305286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A500717DF0
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:17:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305286-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305286-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7826302979C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99180388363;
	Tue,  7 Jul 2026 06:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3B226CF6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404962; cv=none; b=ezgwl9TFtHf+OcFrn1pGiy03W//6TfXkoeBZ+oNANbhDD3fYaRaEvDGQc293ZNJ18tQmXY5yRZsqPJg7bRp/vx8X8Uz2C5Zu6qLwUls8XRi7j/BjgyI2Ud9wj+lIyl5TONaP/0S8oSNHDZglE8wTzOoSFrUH7dR0SzsVOuWEPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404962; c=relaxed/simple;
	bh=BrARUmunaivAm6ZZlmtiJnjUjxqkkrByeFRiBW17H90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDtb/TJYYcVB8rJ3U2toE+A4YnUEiZXwL4gvBKpU3lvOe6O0LHYwt6rwig+1I0EFekmg6IAWahCKuH2oMCQzGBxJ3XQ2IoTxOHxMxaKpuSVmShQGTzedo1Ve+9XNfID6RTaszucdhGPjE17SfHeixJOVmsG9Z+pZLi4kyFNRZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: esmtpsz10t1783404920tdd122fec
X-QQ-Originating-IP: nHCLoXmRGqNUExhtmCt6DeaeB1mKOQcc8GQHqd4dnbw=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 14:15:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9719262162574171370
EX-QQ-RecipientCnt: 22
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v10 5/5] net: wangxun: add pcie error handler
Date: Tue,  7 Jul 2026 14:14:55 +0800
Message-Id: <20260707061455.39564-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260707061455.39564-1-jiawenwu@trustnetic.com>
References: <20260707061455.39564-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OFfQQ3bkz2z44yHJhlg8v2M9Rsgj1kRfzAdLitmgbgdtWLJTIW5YlcUN
	0pSTEoUuwQKxDUSQOEwC3QN8GhpaCjIq6GzqQcgAx7ihQ5yGY3TF/4x9N/p+IlRbCoKs6Dh
	T78GmjbwlSqvVspPMjL7CWPGL0Jn9mOTngbXqxmxSxB6nhEzJG+TuxggRCBbCuaNQKwWauG
	+BcH4R52gqEcGn/FSeKSsuuTORU04kal8m47iuYrfR9IRbLJesuwtlSoin5HhQPLDhfFArn
	K2O93rJMVi+Vn4Eh22GrhAS06pofG6ejc4sYhJ538c5YDjIXXR7zdpsLN2vImYHV33vuN8q
	+KZZ5H2YEdrgQ5eC0D7lSVBOuycMoGN+mLCl5BD0z9mEsafseimcQSCMl1XWXbKqYlmOnch
	Um8iDX9eA5xSL8nw4oYK6f3KiCkRTgljFK5vns2xFP1n9XwRa3zLWIdqHx4CDGOP5ph//ec
	5EWOcBNVWwDPOaTkuvA51qYPXprTVx8ICsZDy9ZuG+lG7kQyRlY66idQyuclW1357ktsQBx
	OUPN6IgPQnZ9cCmtEQz1LzloaIw/g5SUdocqKPVlNwAcYOYGvDIJgDDmpCppULhXQ4vRpIg
	6Toe74V+G8eA5boWR2TtZ0nBE9NbHDfVBoScF2a023+Bsb+FMG212mJzdlk2fLROmv+E0zl
	rhYa7T73KPW8e2FzvEnrVl7cKhpeLmj9vMfMWTnOGRC/kz/+wU1Ld6+yG06E7MMvVMpqz3Z
	3gx7/v/LERxqUOaUQJ1pb9yMy0NDKw8ML8dwYMdTkE+DbcwOFPejFFk6Uiv/YqVQlqYMMbp
	LwtETZJvN9e9AfPGpzUXFkRtsEzZmhq8Edt/2Dufp1x0Ah5yI3Sb/QIGcxXc+k0dprlL/iE
	hnxAVGdBrf+ONV9Kf0IB0yovULAVWsRLVTHHxko5p9YriSADgeA0SVtDMyp7fv3dOm4bk/8
	fEtlvCm3Y8rOd2tYmPR6SgOaXDgJeA4AoCnvTs5LEIj5kdNhLUefz2jAF9c3vmJkAUHNqtx
	jkTK+sPx42Kl3LHhXza54XZZ/IFBUF+4ShXKMkCbtc7zJKUVptRJoW+KntR9StRRCu0S459
	w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305286-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:shaojijie@huawei.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,huawei.com,baylibre.com,kylinos.cn,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:from_mime,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A500717DF0

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, check PCIe error status in .ndo_tx_timeout. The current
function of ngbe is not yet fully developed, it will be completed in the
future.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 144 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  32 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  31 +++-
 5 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index ee27f96735dc..0cb99e456a1c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,120 @@
 
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
+	if (!wx)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	netdev = wx->netdev;
+	if (!netif_device_present(netdev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	wx_soft_quiesce(wx);
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
+
+	if (pci_enable_device_mem(pdev)) {
+		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	/* make all memory operations done before clearing the flag */
+	smp_mb__before_atomic();
+	clear_bit(WX_STATE_DISABLED, wx->state);
+	clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	pci_set_master(pdev);
+	pci_restore_state(pdev);
+	pci_wake_from_d3(pdev, false);
+
+	rtnl_lock();
+	if (netif_running(wx->netdev) && wx->down_suspend)
+		wx->down_suspend(wx);
+	if (wx->do_reset)
+		wx->do_reset(wx->netdev, false);
+	rtnl_unlock();
+
+	return PCI_ERS_RESULT_RECOVERED;
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
 static void wx_pf_reset_subtask(struct wx *wx)
 {
 	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
@@ -25,6 +134,9 @@ static void wx_reset_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		wx_soft_quiesce(wx);
+
 	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		goto out;
@@ -139,6 +251,33 @@ void wx_check_hang_subtask(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_check_hang_subtask);
 
+static bool wx_check_pcie_error(struct wx *wx)
+{
+	u16 vid, pci_cmd;
+
+	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
+	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
+
+	/* PCIe link loss or memory space can't access */
+	if (vid == U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
+		return true;
+
+	return false;
+}
+
+static void wx_tx_timeout_recovery(struct wx *wx)
+{
+	/*
+	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
+	 * recovery mechanism. However, this recovery flow relies on the AER
+	 * driver for current kernel policy. Therefore, a self-contained
+	 * recovery mechanism is not implemented yet.
+	 */
+	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+	wx_err(wx, "PCIe error detected during tx timeout\n");
+	queue_work(wx->reset_wq, &wx->reset_task);
+}
+
 static void wx_tx_timeout_reset(struct wx *wx)
 {
 	if (test_bit(WX_STATE_DOWN, wx->state))
@@ -153,7 +292,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	wx_tx_timeout_reset(wx);
+	if (wx_check_pcie_error(wx))
+		wx_tx_timeout_recovery(wx);
+	else
+		wx_tx_timeout_reset(wx);
 }
 EXPORT_SYMBOL(wx_tx_timeout);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
index 1eed13e48095..a6a82a263528 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -7,6 +7,8 @@
 #ifndef _WX_ERR_H_
 #define _WX_ERR_H_
 
+extern const struct pci_error_handlers wx_err_handler;
+
 void wx_check_err_subtask(struct wx *wx);
 int wx_init_err_task(struct wx *wx);
 void wx_check_hang_subtask(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index edcb8d121b86..aa357e260c4c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1222,6 +1222,8 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
+	WX_STATE_RES_FREED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1289,6 +1291,7 @@ enum wx_pf_flags {
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PF_RESET,
+	WX_FLAG_NEED_PCIE_RECOVERY,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1410,6 +1413,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*down_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 92895f503511..56d4b63387fd 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -47,6 +47,20 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
 	{ }
 };
 
+static void ngbe_down_suspend(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return;
+
+	phylink_stop(wx->phylink);
+	phylink_disconnect_phy(wx->phylink);
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+}
+
 /**
  *  ngbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -135,6 +149,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->down_suspend = ngbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -413,6 +428,9 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_reset(struct wx *wx)
 {
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		return;
+
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, wx->mac.addr);
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -435,6 +453,7 @@ static void ngbe_up_complete(struct wx *wx)
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
@@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		goto out;
+
 	wx_ptp_stop(wx);
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_isb_resources(wx);
 	wx_free_resources(wx);
 	phylink_disconnect_phy(wx->phylink);
+out:
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -566,7 +589,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void ngbe_shutdown(struct pci_dev *pdev)
@@ -855,6 +879,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -910,7 +935,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -937,6 +963,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -961,6 +988,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a7bde03a98fe..d85ee83192e4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -155,6 +155,7 @@ static void txgbe_up_complete(struct wx *wx)
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 
 	switch (wx->mac.type) {
@@ -198,6 +199,9 @@ static void txgbe_reset(struct wx *wx)
 	u8 old_addr[ETH_ALEN];
 	int err;
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		return;
+
 	err = txgbe_reset_hw(wx);
 	if (err != 0)
 		wx_err(wx, "Hardware Error: %d\n", err);
@@ -304,6 +308,20 @@ void txgbe_up(struct wx *wx)
 	txgbe_up_complete(wx);
 }
 
+static void txgbe_down_suspend(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return;
+
+	phylink_stop(wx->phylink);
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
+	wx_free_resources(wx);
+	txgbe_fdir_filter_exit(wx);
+}
+
 /**
  *  txgbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -420,6 +438,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->down_suspend = txgbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -530,12 +549,16 @@ static int txgbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		goto out;
+
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
 	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
+out:
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -556,7 +579,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
 
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void txgbe_shutdown(struct pci_dev *pdev)
@@ -907,6 +931,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -981,7 +1006,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -991,6 +1017,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.51.0


