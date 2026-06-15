Return-Path: <netdev+bounces-299339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnuPN/2gL2pZDgUAu9opvQ
	(envelope-from <netdev+bounces-299339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44E683F0F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:51:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299339-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299339-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3062A3006B44
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337453B3898;
	Mon, 15 Jun 2026 06:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733B330662
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:51:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506294; cv=none; b=SEMeIJGCSSD/KtHixK86GzWsRDRd1upYjSxi9GDh6pVMwsvzrmzv/mEwKvzuz7Xb154mK3JnkrzCUkeYDIqUJsmLnbpM3asU9tKyLxsA/cvk1Fmpr1A3N6XVBBClrQ/h5AWuDVPOjl/pr9s2UUIJD5jokE27Wli89mWMXN27Kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506294; c=relaxed/simple;
	bh=+ngw+gXwhACHlWgLBssAEXP2JTa6nBwLurAL2dNLFCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Suipp1Bq0rQnIGWx0HUqEfRdROVlzleZCCA6fdXDgcY/wX5gn/14Ivvr5YvfMqjIJ1buyD3KjLltVe1SWBqotx8yRukiOq6mfC08v1RnLcBWrR85zSe0ySLD0VQBrhhgbm2SNbxHV+TEJ5J5g5QXOBP82BOyjSFbCWyNfUyNbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: esmtpsz11t1781506234te1bba6d6
X-QQ-Originating-IP: sLn+8R2sq1aIPiz3/Msl4wacKlUqwc34wc5up7hXP9s=
Received: from lap-jiawenwu.trustnetic.com ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 14:50:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8710857262894356469
EX-QQ-RecipientCnt: 21
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 2/5] net: wangxun: add Tx timeout process
Date: Mon, 15 Jun 2026 14:50:13 +0800
Message-Id: <20260615065016.21672-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260615065016.21672-1-jiawenwu@trustnetic.com>
References: <20260615065016.21672-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N3gATt1+RV61uIUu+37FTz1mEL7AWmr5uxE2Yh1NQ6MvLzskZs5uS4wK
	PuMDMMrZqGgXyz9tb5piIqrDLFFFVBVbhGMZfnve+3JQzweI5JzVR2SSLgolzwjc2bizFmQ
	Fvn7NyP+85fkO0XQd9oAobpdRQT0lsBJA5BZVkyDe1Y4vqrWP1BfrZ+47U65uX5q6+6Eqc9
	T994CwExqjOTVpH47cTzK0Gc5642YXPoDTR7pcPYFswjXxd5kGwy6B4K0dIAltKhDsN1Zq/
	5BFLBh6IgGA0ulNmZBvl3giVBu4/J0ywGJ1l9FPxBG4R/P/2fUFUiUllExD2xeaRkMG9CBN
	jxgxAefSWAZCiROrwEtHX4PimAByNdUPj1gOkojrdl062rZHef8VT8VrpkWtTJ2a8qfXKGh
	KU8ONb/EIqs+5uXu4lbtz3oJzDCTdIqtgbB/HyhzwD/7fS+34cbhO8gCIkQFFxPqKBtYLK6
	SGqqNlKVE+r6BnqIE1czSrD1TCkBj9cY66n/mprpIBzSm/Q3qcTKJtQP99I0pGiziHUiLPD
	A5jaCpo6gGkPf8K8ozvQNO/OokB+PLQvNoQ85hPaB0JlTfdAxeY74dSVljJNyOABDVk1HCI
	/gz13wUrv7rMAbgpqcVwbrP1k0b/liTnAZK9qkE7bQeY8EHBNYCdtaznf16z08prrqhOqkX
	0skv9zNEUaiUkuzojavnHnx8xVy5lZmT6FdY/UxkzEQLTPpPO8fgbFih6E39NTCIP4u0KMi
	UAjLSgdfVxiRBDOz/Vob3c+pdsGWZhFxiiHYbbe4pkbjmWky8cC8g53RHCcKxNkUAGrSvrV
	cm1K1gpFRlKXdKQ0HlXsS/B4PPbEGsu8cPoFG0KqLFeX8e6I5wvsKO6NAMagi0pUuttYr15
	ExVNBizs9V5QgUfK1/LTPmOHbgxFOhnADVthAYkMPxJ2ilry5MApbrhQCEsJ6GNXw/9AFQa
	+NZFpzT848q7QRETUqirojDQryVA7czTtm8FZR6JpM6NxRcfwe9rutDerlTiq/b8LwKP3ed
	BJrMUxWqtoZIv4f9nyuMfCrcrn16bAEbsSbCs/8FH1pHpnq1tI3RdTXI/5+o98ixkqrOm/w
	a7fJ4fsrxaH
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299339-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:leitao@debian.org,m:larysa.zaremba@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,linuxfoundation.org,debian.org,baylibre.com,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,trustnetic.com:email,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B44E683F0F

Implement .ndo_tx_timeout to handle Tx side timeout event. When a Tx
timeout event occur, it will trigger driver into reset process. And
allocate a separate work queue for reset process.

The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
be cleared if a pause frame is received to avoid false hang detection
caused by pause frames.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 175 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 ++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  19 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 ++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  14 ++
 8 files changed, 289 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index a71b0ad77de3..c8724bb129aa 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
 libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
new file mode 100644
index 000000000000..b6e2d16d4a16
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
+/* Copyright (c) 1999 - 2026 Intel Corporation. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_lib.h"
+#include "wx_err.h"
+
+static void wx_pf_reset_subtask(struct wx *wx)
+{
+	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
+		return;
+
+	wx_warn(wx, "Reset adapter.\n");
+	if (wx->do_reset)
+		wx->do_reset(wx->netdev);
+}
+
+static void wx_reset_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, reset_task);
+
+	rtnl_lock();
+
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		goto out;
+
+	wx_pf_reset_subtask(wx);
+
+out:
+	rtnl_unlock();
+}
+
+void wx_check_err_subtask(struct wx *wx)
+{
+	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
+		queue_work(wx->reset_wq, &wx->reset_task);
+}
+EXPORT_SYMBOL(wx_check_err_subtask);
+
+int wx_init_err_task(struct wx *wx)
+{
+	wx->reset_wq = alloc_workqueue("%s_reset_wq_%x", WQ_UNBOUND | WQ_HIGHPRI,
+				       1, wx->driver_name, pci_dev_id(wx->pdev));
+	if (!wx->reset_wq) {
+		wx_err(wx, "Failed to create wx_reset_wq workqueue\n");
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&wx->reset_task, wx_reset_task);
+	return 0;
+}
+EXPORT_SYMBOL(wx_init_err_task);
+
+static bool wx_ring_tx_pending(struct wx *wx)
+{
+	int i;
+
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = wx->tx_ring[i];
+
+		if (tx_ring->next_to_use != tx_ring->next_to_clean)
+			return true;
+	}
+
+	return false;
+}
+
+static bool wx_vf_tx_pending(struct wx *wx)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
+	u32 i, j;
+
+	if (!wx->num_vfs)
+		return false;
+
+	for (i = 0; i < wx->num_vfs; i++) {
+		for (j = 0; j < q_per_pool; j++) {
+			u32 h, t;
+
+			h = rd32(wx, WX_PX_TR_RP_PV(q_per_pool, i, j));
+			t = rd32(wx, WX_PX_TR_WP_PV(q_per_pool, i, j));
+
+			if (h != t)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static void wx_watchdog_flush_tx(struct wx *wx)
+{
+	if (!netif_running(wx->netdev))
+		return;
+	if (netif_carrier_ok(wx->netdev))
+		return;
+
+	if (wx_ring_tx_pending(wx) || wx_vf_tx_pending(wx)) {
+		/* We've lost link, so the controller stops DMA,
+		 * but we've got queued Tx work that's never going
+		 * to get done, so reset controller to flush Tx.
+		 * (Do the reset outside of interrupt context).
+		 */
+		wx_warn(wx, "initiating reset due to lost link with pending Tx work\n");
+		set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	}
+}
+
+static void wx_detect_tx_hang(struct wx *wx)
+{
+	int i;
+
+	/* If we're down or resetting, just bail */
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	/* Force detection of hung controller */
+	if (netif_carrier_ok(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
+	}
+}
+
+void wx_check_hang_subtask(struct wx *wx)
+{
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	wx_watchdog_flush_tx(wx);
+	wx_detect_tx_hang(wx);
+}
+EXPORT_SYMBOL(wx_check_hang_subtask);
+
+static void wx_tx_timeout_reset(struct wx *wx)
+{
+	if (test_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	wx_warn(wx, "initiating reset due to tx timeout\n");
+	wx_service_event_schedule(wx);
+}
+
+void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txqueue)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	wx_tx_timeout_reset(wx);
+}
+EXPORT_SYMBOL(wx_tx_timeout);
+
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
+{
+	struct wx *wx = netdev_priv(tx_ring->netdev);
+
+	wx_warn(wx,
+		"Detected Tx Unit Hang: Queue %d, TDH %x, TDT %x, ntu %x, ntc %x, ntc.time_stamp %lx, jiffies %lx\n",
+		tx_ring->queue_index,
+		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
+		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
+		tx_ring->next_to_use, next,
+		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
+
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+
+	wx_tx_timeout_reset(wx);
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
new file mode 100644
index 000000000000..1eed13e48095
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WangXun Gigabit PCI Express Linux driver
+ * Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd.
+ */
+
+#ifndef _WX_ERR_H_
+#define _WX_ERR_H_
+
+void wx_check_err_subtask(struct wx *wx);
+int wx_init_err_task(struct wx *wx);
+void wx_check_hang_subtask(struct wx *wx);
+void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next);
+
+#endif /* _WX_ERR_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..122c4952d203 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1932,6 +1932,7 @@ static void wx_configure_tx_ring(struct wx *wx,
 	else
 		ring->atr_sample_rate = 0;
 
+	bitmap_zero(ring->state, WX_RING_STATE_NBITS);
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
@@ -2851,16 +2852,26 @@ EXPORT_SYMBOL(wx_fc_enable);
 static void wx_update_xoff_rx_lfc(struct wx *wx)
 {
 	struct wx_hw_stats *hwstats = &wx->stats;
+	u64 data;
+	int i;
 
 	if (wx->fc.mode != wx_fc_full &&
 	    wx->fc.mode != wx_fc_rx_pause)
 		return;
 
 	if (wx->mac.type >= wx_mac_aml)
-		hwstats->lxoffrxc += rd32_wrap(wx, WX_MAC_LXOFFRXC_AML,
-					       &wx->last_stats.lxoffrxc);
+		data = rd32_wrap(wx, WX_MAC_LXOFFRXC_AML,
+				 &wx->last_stats.lxoffrxc);
 	else
-		hwstats->lxoffrxc += rd64(wx, WX_MAC_LXOFFRXC);
+		data = rd64(wx, WX_MAC_LXOFFRXC);
+	hwstats->lxoffrxc += data;
+
+	/* refill credits (no tx hang) if we received xoff */
+	if (!data)
+		return;
+
+	for (i = 0; i < wx->num_tx_queues; i++)
+		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d042567b8128..da4d9e229c9e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -14,6 +14,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_err.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
 #include "wx_vf_lib.h"
@@ -742,6 +743,37 @@ static struct netdev_queue *wx_txring_txq(const struct wx_ring *ring)
 	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
 }
 
+static u32 wx_get_tx_pending(struct wx_ring *ring)
+{
+	unsigned int head, tail;
+
+	head = ring->next_to_clean;
+	tail = ring->next_to_use;
+
+	return ((head <= tail) ? tail : tail + ring->count) - head;
+}
+
+static bool wx_check_tx_hang(struct wx_ring *ring)
+{
+	u32 tx_done_old = ring->tx_stats.tx_done_old;
+	u32 tx_pending = wx_get_tx_pending(ring);
+	u32 tx_done = ring->stats.packets;
+
+	if (!test_and_clear_bit(WX_TX_DETECT_HANG, ring->state))
+		return false;
+
+	if (tx_done_old == tx_done && tx_pending)
+		/* make sure it is true for two checks in a row */
+		return test_and_set_bit(WX_HANG_CHECK_ARMED, ring->state);
+
+	/* update completed stats and continue */
+	ring->tx_stats.tx_done_old = tx_done;
+	/* reset the countdown */
+	clear_bit(WX_HANG_CHECK_ARMED, ring->state);
+
+	return false;
+}
+
 /**
  * wx_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: structure containing interrupt and ring information
@@ -866,6 +898,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 	netdev_tx_completed_queue(wx_txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
+	if (wx_check_tx_hang(tx_ring)) {
+		wx_handle_tx_hang(tx_ring, i);
+		return true;
+	}
+
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	if (unlikely(total_packets && netif_carrier_ok(tx_ring->netdev) &&
 		     (wx_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c7befe4cdfe9..75d74ca2e259 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -450,6 +450,11 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_TR_CFG_THRE_SHIFT      8
 #define WX_PX_TR_CFG_HEAD_WB         BIT(27)
 
+#define WX_PX_TR_RP_PV(q_per_pool, vf_number, vf_q_index) \
+		(WX_PX_TR_RP((q_per_pool) * (vf_number) + (vf_q_index)))
+#define WX_PX_TR_WP_PV(q_per_pool, vf_number, vf_q_index) \
+		(WX_PX_TR_WP((q_per_pool) * (vf_number) + (vf_q_index)))
+
 /* Receive DMA Registers */
 #define WX_PX_RR_BAL(_i)             (0x01000 + ((_i) * 0x40))
 #define WX_PX_RR_BAH(_i)             (0x01004 + ((_i) * 0x40))
@@ -1039,6 +1044,7 @@ struct wx_queue_stats {
 struct wx_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
+	u32 tx_done_old;
 };
 
 struct wx_rx_queue_stats {
@@ -1054,6 +1060,12 @@ struct wx_rx_queue_stats {
 #define wx_for_each_ring(posm, headm) \
 	for (posm = (headm).ring; posm; posm = posm->next)
 
+enum wx_ring_state {
+	WX_TX_DETECT_HANG,
+	WX_HANG_CHECK_ARMED,
+	WX_RING_STATE_NBITS
+};
+
 struct wx_ring_container {
 	struct wx_ring *ring;           /* pointer to linked list of rings */
 	unsigned int total_bytes;       /* total bytes processed this int */
@@ -1073,6 +1085,7 @@ struct wx_ring {
 		struct wx_tx_buffer *tx_buffer_info;
 		struct wx_rx_buffer *rx_buffer_info;
 	};
+	DECLARE_BITMAP(state, WX_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;                 /* phys. address of descriptor ring */
 	dma_addr_t headwb_dma;
@@ -1274,6 +1287,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
+	WX_FLAG_NEED_PF_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1422,6 +1436,8 @@ struct wx {
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
+	struct work_struct reset_task;
+	struct workqueue_struct *reset_wq;
 	struct mutex reset_lock; /* mutex for reset */
 };
 
@@ -1504,7 +1520,8 @@ rd32_wrap(struct wx *wx, u32 reg, u32 *last)
 
 #define wx_err(wx, fmt, arg...) \
 	dev_err(&(wx)->pdev->dev, fmt, ##arg)
-
+#define wx_warn(wx, fmt, arg...) \
+	dev_warn(&(wx)->pdev->dev, fmt, ##arg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index dea6dfb043f3..4bcef967e992 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -14,6 +14,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_sriov.h"
@@ -148,6 +149,8 @@ static void ngbe_service_task(struct work_struct *work)
 	struct wx *wx = container_of(work, struct wx, service_task);
 
 	wx_update_stats(wx);
+	wx_check_hang_subtask(wx);
+	wx_check_err_subtask(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -393,6 +396,7 @@ static void ngbe_disable_device(struct wx *wx)
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
 
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
@@ -644,6 +648,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_stop               = ngbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -733,6 +738,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			   NETIF_F_TSO | NETIF_F_TSO6 |
@@ -830,6 +836,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	err = wx_init_err_task(wx);
+	if (err)
+		goto err_free_mac_table;
+
 	ngbe_init_service(wx);
 
 	err = wx_init_interrupt_scheme(wx);
@@ -857,6 +867,8 @@ static int ngbe_probe(struct pci_dev *pdev,
 err_cancel_service:
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -888,6 +900,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ce82e13aa8ae..689679b315ae 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -14,6 +14,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_mbx.h"
@@ -123,6 +124,8 @@ static void txgbe_service_task(struct work_struct *work)
 	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
 	wx_update_stats(wx);
+	wx_check_hang_subtask(wx);
+	wx_check_err_subtask(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -224,6 +227,7 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	wx_napi_disable_all(wx);
 
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
@@ -654,6 +658,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_stop               = txgbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -745,6 +750,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
@@ -815,6 +821,10 @@ static int txgbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	err = wx_init_err_task(wx);
+	if (err)
+		goto err_free_mac_table;
+
 	txgbe_init_service(wx);
 
 	err = wx_init_interrupt_scheme(wx);
@@ -917,6 +927,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 err_cancel_service:
 	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -949,6 +961,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
+	cancel_work_sync(&wx->reset_task);
+	destroy_workqueue(wx->reset_wq);
 
 	txgbe_remove_phy(txgbe);
 	wx_free_isb_resources(wx);
-- 
2.51.0


