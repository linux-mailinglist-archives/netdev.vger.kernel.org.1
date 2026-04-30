Return-Path: <netdev+bounces-282702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CboH3IS82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:27:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0949F396
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428423036627
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773338E106;
	Thu, 30 Apr 2026 08:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1803DD511
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537586; cv=none; b=Rpz6v586rG95FiXnMM9+rIg4TbbQBQSttbTsG5Ns/XNtnq01QQuVPzUeao7orEdJ4qjW4IfhcgzI4dfTTsbvnFDKqhnEO2w1psMKL50VSokK4ltEvp3GS4C8hIRjWfmjy2gFoFDBuLIqMU1Ab2Pz+9MbuoHBRo9XvDdl4jrJYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537586; c=relaxed/simple;
	bh=UD4T91B+HBD0Ce+roc7IOlVzlDJPF2NAbsP/1U/EKFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfOaNGj9tvoR7qsGQeY2Y5VxlCfwIUZPEGJQzBRsg7nVSsu36BXlkzwrMhk10JVKV8nzKp9t2EWDecam+14m3nHE+xZM46iJ+VOgU0EMibBYe9KwkHKHw7OWnsMRuKAlP2naJXDuwXSUKxiYOmfibXtiVQ0PKMPm65FvDN2qWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537546t25439ff2
X-QQ-Originating-IP: X4V7hmsWoaXxzjkIgPR41RYP/OEi7rqqtejK60QRUaQ=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4903252611942497304
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
Subject: [PATCH net-next v2 2/6] net: wangxun: add Tx timeout process
Date: Thu, 30 Apr 2026 16:25:13 +0800
Message-Id: <20260430082517.19612-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MQKyb5NHApCUPbihZ6NGNSqB02bko2H8qn9d/SA+7DOLeWhquFDBRvDI
	nwik6x4TP4mPGjlnkvoa8wvSQiJZbSjyvzGY4tjzlhx/bEXJXuqonDkRd3njjBkoFKCwFp1
	cnFkLh1OdkHQxVgAmJtS0TbIVqRBYjD5cHaf2LOlmMkBg5WVKIfpAClg616mvMdsGr6Sabf
	tYmuy88TcDQfBa4y1SZV2xUu0d5lgBOsXqoWYykaZRb0nFHydFBtM/N2IoPztUZpY0fmBOw
	86LgxgYM/trCgGo/OQo1QSKJUS4Fi1sWrEhUS4wqtWWcz3PelJR2XVD2cPiz5sp0MQb6hyp
	CjQshf96NXSaXRPbBcZwMJE/5A3DquFXQwx/gcN8kbpxdNDb/y6QTqXksQ1RS2EUXFxAA66
	G6rhR0g213/Jxxk0gcZPFV3PUySwU6esxCZU/swGAJbN3Q8hdZOPlPOKs+9jf7/6Ovin6kv
	4cQnLuFKAofcs2mTEOU4jleFmve1+TedyKeMy3DwOhIm24+s1skDx/vnMtHF27NfhYvAdU/
	iK2nE9XBG5smZeZNnWcdmyIj8GxREm7WD6nh9HvqKuAxNjgltQGRotLusg/J+8OcGmClV4g
	RNtkKPC3rFFL6Pd9fQgtuUObkfBDXbqzOH4/YPkZocY2BCXSndoBuoULeCqWstFVTDEvA5S
	HZBaixMmoKs7WMMEXZtvju/+3AYUMYBagMSEV6oOKPdne50x3jy6EnmkHqWwhtjjFVcdt7/
	GIv5ml9D/AOguJYTrkxh9GuRotPytRbRZGWB9xDc4Bah6pHC66z7MvVyHKSFEG6FRrVtvjI
	3LzXSKGerNywrhXaVm1pA/zKklNuyCRrb7rToztWLzs/qyGlt6SF6L7bjE/8x49ORnt7Dub
	ghgYe0pw877+HSrpiqpQSIKo35vBqaG7yvFKuTdsC9kaA1eh7OJ8rRNVAh3mhCgbNgradmn
	EX45zDy93fMncBGgGpLLLG+BB0oIKQ0LW7QGGvTTK3JXKoCrpPMpX9dGMbQM2MCI14qtlNY
	cGNLZQkF82nxhhVcdIorn0IG4O+dNRnEPIRZWv0ipkecalcEUwG6XxXTnVUlU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: D8B0949F396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282702-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	NEURAL_SPAM(0.00)[0.947];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]

Implement .ndo_tx_timeout to handle Tx side timeout event. When Tx
timeout event occur, it will triger driver into reset process.

The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
be cleared if a pause frame is received to remove false hang detection
due to 802.3 frames.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 126 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  14 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 ++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 +++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   4 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   4 +
 9 files changed, 212 insertions(+), 5 deletions(-)
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
index 000000000000..ba5f23cefc0f
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_lib.h"
+#include "wx_err.h"
+
+static void wx_reset_subtask(struct wx *wx)
+{
+	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
+		return;
+
+	rtnl_lock();
+
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		goto out;
+
+	wx_warn(wx, "Reset adapter.\n");
+
+	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
+		if (wx->do_reset)
+			wx->do_reset(wx->netdev);
+	}
+
+out:
+	rtnl_unlock();
+}
+
+/*
+ * wx_check_tx_hang_subtask - check for hung queues and dropped interrupts
+ * @wx - pointer to the device wx structure
+ *
+ * This function serves two purposes.  First it strobes the interrupt lines
+ * in order to make certain interrupts are occurring.  Secondly it sets the
+ * bits needed to check for TX hangs.  As a result we should immediately
+ * determine if a hang has occurred.
+ */
+static void wx_check_tx_hang_subtask(struct wx *wx)
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
+void wx_handle_errors_subtask(struct wx *wx)
+{
+	wx_reset_subtask(wx);
+	wx_check_tx_hang_subtask(wx);
+}
+EXPORT_SYMBOL(wx_handle_errors_subtask);
+
+static void wx_tx_timeout_reset(struct wx *wx)
+{
+	if (!netif_running(wx->netdev))
+		return;
+
+	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	wx_warn(wx, "initiating reset due to tx timeout\n");
+	wx_service_event_schedule(wx);
+}
+
+void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 head, tail;
+	int i;
+
+	for (i = 0; i < wx->num_tx_queues; i++) {
+		struct wx_ring *tx_ring = wx->tx_ring[i];
+
+		if (test_bit(WX_TX_DETECT_HANG, tx_ring->state) &&
+		    wx_check_tx_hang(tx_ring))
+			wx_warn(wx, "Real tx hang detected on queue %d\n", i);
+
+		head = rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx));
+		tail = rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx));
+		wx_warn(wx,
+			"tx ring %d next_to_use is %d, next_to_clean is %d\n",
+			i, tx_ring->next_to_use,
+			tx_ring->next_to_clean);
+		wx_warn(wx, "tx ring %d hw rp is 0x%x, wp is 0x%x\n",
+			i, head, tail);
+	}
+
+	wx_tx_timeout_reset(wx);
+}
+EXPORT_SYMBOL(wx_tx_timeout);
+
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
+{
+	struct wx *wx = netdev_priv(tx_ring->netdev);
+
+	wx_warn(wx, "Detected Tx Unit Hang\n"
+		"  Tx Queue             <%d>\n"
+		"  TDH, TDT             <%x>, <%x>\n"
+		"  next_to_use          <%x>\n"
+		"  next_to_clean        <%x>\n"
+		"tx_buffer_info[next_to_clean]\n"
+		"  time_stamp           <%lx>\n"
+		"  jiffies              <%lx>\n",
+		tx_ring->queue_index,
+		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
+		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
+		tx_ring->next_to_use, next,
+		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
+
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+
+	wx_warn(wx, "tx hang detected on queue %d, resetting adapter\n",
+		tx_ring->queue_index);
+
+	wx_tx_timeout_reset(wx);
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
new file mode 100644
index 000000000000..e317e6c8d928
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WangXun Gigabit PCI Express Linux driver
+ * Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd.
+ */
+
+#ifndef _WX_ERR_H_
+#define _WX_ERR_H_
+
+void wx_handle_errors_subtask(struct wx *wx);
+void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next);
+
+#endif /* _WX_ERR_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index d3772d01e00b..401dc7eb1137 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1932,6 +1932,7 @@ static void wx_configure_tx_ring(struct wx *wx,
 	else
 		ring->atr_sample_rate = 0;
 
+	bitmap_zero(ring->state, WX_RING_STATE_NBITS);
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
@@ -2847,16 +2848,26 @@ EXPORT_SYMBOL(wx_fc_enable);
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
index 746623fa59b4..9e6167b43f75 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -14,6 +14,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_err.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
 #include "wx_vf_lib.h"
@@ -742,6 +743,36 @@ static struct netdev_queue *wx_txring_txq(const struct wx_ring *ring)
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
+bool wx_check_tx_hang(struct wx_ring *ring)
+{
+	u32 tx_done_old = ring->tx_stats.tx_done_old;
+	u32 tx_pending = wx_get_tx_pending(ring);
+	u32 tx_done = ring->stats.packets;
+
+	clear_bit(WX_TX_DETECT_HANG, ring->state);
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
@@ -866,6 +897,12 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 	netdev_tx_completed_queue(wx_txring_txq(tx_ring),
 				  total_packets, total_bytes);
 
+	if (test_bit(WX_TX_DETECT_HANG, tx_ring->state) &&
+	    wx_check_tx_hang(tx_ring)) {
+		wx_handle_tx_hang(tx_ring, i);
+		return true;
+	}
+
 #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
 	if (unlikely(total_packets && netif_carrier_ok(tx_ring->netdev) &&
 		     (wx_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD))) {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..e373cd7f05d3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -10,6 +10,7 @@
 struct wx_dec_ptype wx_decode_ptype(const u8 ptype);
 void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count);
 u16 wx_desc_unused(struct wx_ring *ring);
+bool wx_check_tx_hang(struct wx_ring *ring);
 netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 			  struct net_device *netdev);
 void wx_napi_enable_all(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 0da5565ee4ff..f65c2d7bae39 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1039,6 +1039,7 @@ struct wx_queue_stats {
 struct wx_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
+	u32 tx_done_old;
 };
 
 struct wx_rx_queue_stats {
@@ -1054,6 +1055,12 @@ struct wx_rx_queue_stats {
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
@@ -1073,6 +1080,7 @@ struct wx_ring {
 		struct wx_tx_buffer *tx_buffer_info;
 		struct wx_rx_buffer *rx_buffer_info;
 	};
+	DECLARE_BITMAP(state, WX_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;                 /* phys. address of descriptor ring */
 	dma_addr_t headwb_dma;
@@ -1273,6 +1281,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
+	WX_FLAG_NEED_PF_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1503,7 +1512,8 @@ rd32_wrap(struct wx *wx, u32 reg, u32 *last)
 
 #define wx_err(wx, fmt, arg...) \
 	dev_err(&(wx)->pdev->dev, fmt, ##arg)
-
+#define wx_warn(wx, fmt, arg...) \
+	dev_warn(&(wx)->pdev->dev, fmt, ##arg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index bd905e267575..e9561996b970 100644
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
@@ -147,6 +148,7 @@ static void ngbe_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
+	wx_handle_errors_subtask(wx);
 	wx_update_stats(wx);
 
 	wx_service_event_complete(wx);
@@ -642,6 +644,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_stop               = ngbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -731,6 +734,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			   NETIF_F_TSO | NETIF_F_TSO6 |
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8b7c3753bb6a..5793da5b7bab 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -14,6 +14,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_err.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_mbx.h"
@@ -128,6 +129,7 @@ static void txgbe_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
+	wx_handle_errors_subtask(wx);
 	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
 	wx_update_stats(wx);
@@ -659,6 +661,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_stop               = txgbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -750,6 +753,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
 	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
-- 
2.51.0


