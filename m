Return-Path: <netdev+bounces-297465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5owCEtMBKWoAOwMAu9opvQ
	(envelope-from <netdev+bounces-297465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0866628F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297465-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31AE331876A0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBAF370AFB;
	Wed, 10 Jun 2026 06:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA735331EA2
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:12:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071971; cv=none; b=Qf/O1w3BQdwyFeLhgNB1ev0rDmUNJnE9aVumimA7M8yr2naI1iF0+bUzluleVtm0b2mtqxMm6OaFAMyH326qF8+Vbx08R21xcNqaPVVvlosJkgD184aSJPVrjLWK5gkD9R5I45FdGzADOQ6DhupEHcwjX0pO56Oc5jPmWEshXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071971; c=relaxed/simple;
	bh=b6hsm2pfRx6wON3ZNg5UjEUXY44+6OKw7bdiFb5xZoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP15IN41b+YazDgiD7Cqmx7/vP/FQCt9Az+FDBCtzf/5LDnVliSRMI0lIjH6Q7UwEJuoCptBKIIa3xkYlhhdPtRs4uv62kc+4w0tyW5PBAnVnRQfDsqoIgShZrWzoUf6j5oxu4bG+iQNH6Mi6jvGrnCdyOwQpZTHPRy8XClR5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: esmtpsz10t1781071918td3a6af67
X-QQ-Originating-IP: TSaFq+VHw2cS9g5uPgVvSwUBf3P+N4FksnEtNwsYGBw=
Received: from lap-jiawenwu.trustnetic.com ( [125.118.31.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 14:11:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11822830297446217141
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 5/5] net: wangxun: add pcie error handler
Date: Wed, 10 Jun 2026 14:09:17 +0800
Message-Id: <20260610060917.23980-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260610060917.23980-1-jiawenwu@trustnetic.com>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODmRr9XAsEUIlms5o5Wfxy95WNbubRCkYWApFL3EPEr+FQ4P9JMceslc
	gzEA0tQvuS/LpMqZp8d12/yBTgZXlargV0SmkScC77lxO5etz3lxpy264XDE6wdfzdWcZUr
	WCUm8Y0KxfN6HBYDsSXNq6oMPz2Hq1ngdFxpLOqrkj3QLd75vLs0NngGUBHAGd7JGjohtL7
	VIPXqi/cG7BhIFenZteEa/6rATdPS0xHxtyqqrZJw9/HhTzIrI+r2Kl5Lm1VcJ67CS0BuHA
	kSp8o7Wf/Ic+BPB9YzSzrlDZ+t1EJEuF2LFbIDXnh/hFXjOtfcSHr/gnIjWXC4Y/ZmBkm73
	2UQQXULA+WHKpYkLhCaKUlYLwY5FIH69AU+hw+F/w1Yn2H6UVzIkJxuJF6Mrm0B8je7XELt
	yOHrMjVMGyWg8ujAr+YzFWNEs1wzzhQELmutoH3ujBUN7OJwLdY+V+4cNvwP7aOdbChD7YY
	i3AqbANt0EUpj54EaMwqWOv/arIBjFO3oGYDpz2U36R5ah7co1r1I48JdDAIir6w0jCBAP0
	7KjYD9Zx7DWEBLay9UfYNgCL7Im/vUpTiu9QN5EtY7OMlJEBzQdO9g3s3+mENt9S2s7ZiHD
	GV5tFhR02ihodlLkronB+Kzh403j5XbMXbeUOrK8Iix3RHbRLDBOZaf5qOoJtea5DHIApGs
	fN38F6n8LJpr1v0QAlJE5Br1PlbsDei9lufU6aMSIsRwzDgpiYCdDEHSMVLBCF7mX1/f54C
	QkqWQhkLuZkoMyiDVXUzXbxy05OuE33JF5Q0NdwJ9TQkr3Lt9hjPGBwM37xpCI7WLkYIRXP
	vXCulZvY2VHxOi1E6w2xWgQJzmy2323fwKBvVUmjv/lBWRJCALK1kWiFJSOq+4ZWKA0kqd2
	D3/UsRg7UPMQrj+GwGqWzg5ccQqhqzd9GPmneJcADGUQyK6Wlef5pF9bCTBuEW6+Bsow1Uj
	FJqvzflMvRYp4LQVUkT+O084sM4xrlwQk1YIrJPCXtDJRtBp/zWIhyKMjSxd29k3Hi54UcU
	Vka6OpWTwitJvjYvEchRAA3H8i+fRMRHubpfVUVdfCQfjcVBPvWxDKWYuL6x1kkZ5Xtxx2e
	40y61Fm5X6SINsVz8Xfhdk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297465-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:email,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAB0866628F

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, check PCIe error status in .ndo_tx_timeout. The current
function of ngbe is not yet fully developed, it will be completed in the
future.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 148 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  33 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  30 +++-
 5 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index ee27f96735dc..aca52b9e8260 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,124 @@
 
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
+	pci_ers_result_t result;
+
+	if (pci_enable_device_mem(pdev)) {
+		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
+		result = PCI_ERS_RESULT_DISCONNECT;
+	} else {
+		/* make all memory operations done before clearing the flag */
+		smp_mb__before_atomic();
+		clear_bit(WX_STATE_DISABLED, wx->state);
+		clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
+		pci_set_master(pdev);
+		pci_restore_state(pdev);
+		pci_wake_from_d3(pdev, false);
+
+		rtnl_lock();
+		if (netif_running(wx->netdev) && wx->down_suspend)
+			wx->down_suspend(wx);
+		if (wx->do_reset)
+			wx->do_reset(wx->netdev, false);
+		rtnl_unlock();
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
 static void wx_pf_reset_subtask(struct wx *wx)
 {
 	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
@@ -25,6 +138,9 @@ static void wx_reset_task(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		wx_soft_quiesce(wx);
+
 	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		goto out;
@@ -139,6 +255,33 @@ void wx_check_hang_subtask(struct wx *wx)
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
+	if (vid == 0xFFFF || !(pci_cmd & 0x2))
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
@@ -153,7 +296,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
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
index a8b4e84787f4..c2edb74881f2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1221,6 +1221,8 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
+	WX_STATE_RES_FREED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1288,6 +1290,7 @@ enum wx_pf_flags {
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PF_RESET,
+	WX_FLAG_NEED_PCIE_RECOVERY,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1409,6 +1412,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*down_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 7dd3e12d48aa..7585d4fe4442 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -47,6 +47,22 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
 	{ }
 };
 
+static void ngbe_down_suspend(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
+		return;
+
+	phylink_stop(wx->phylink);
+	phylink_disconnect_phy(wx->phylink);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+}
+
 /**
  *  ngbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -135,6 +151,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->down_suspend = ngbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -413,6 +430,9 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_reset(struct wx *wx)
 {
+	if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
+		return;
+
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, wx->mac.addr);
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -435,6 +455,7 @@ static void ngbe_up_complete(struct wx *wx)
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
 	clear_bit(WX_STATE_DOWN, wx->state);
+	clear_bit(WX_STATE_RES_FREED, wx->state);
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
@@ -529,6 +550,9 @@ static int ngbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		return 0;
+
 	wx_ptp_stop(wx);
 	ngbe_down(wx);
 	wx_free_irq(wx);
@@ -566,7 +590,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void ngbe_shutdown(struct pci_dev *pdev)
@@ -856,6 +881,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -911,7 +937,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -938,6 +965,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -962,6 +990,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f6e596eb9217..bee42ac234c2 100644
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
@@ -530,6 +549,9 @@ static int txgbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (test_bit(WX_STATE_RES_FREED, wx->state))
+		return 0;
+
 	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
@@ -556,7 +578,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
 
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void txgbe_shutdown(struct pci_dev *pdev)
@@ -908,6 +931,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -982,7 +1006,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -992,6 +1017,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
-- 
2.51.0


