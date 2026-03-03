Return-Path: <netdev+bounces-263014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPXpOdpPpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D47361E84E7
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AAAF302142C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E4375F96;
	Tue,  3 Mar 2026 03:04:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917037CD30
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507096; cv=none; b=QqKS2jM6pkLo9fNbzeMrcDe8a1pWpL8KrOUsbmbgxRRm0iSdu/BF1oNSbPxn8wqgM/YvogAvuvXvLPStA2/78ezDGNzBJDuMoV9M3FcZE6UCucZn35MauuInDP0ZwbwgImdrcP1B3WlPRbrfhRU4TU+u+zjlUJ5nAAumgSu5PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507096; c=relaxed/simple;
	bh=EOtMOwXsuHUh0JcQs1B8ofK20VIf8n5ireJY2h5gfxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjoZe4v+JIrTzcaW9kWAEMm5Yo3wDZdreM/xYVCDJwNuF3oq2rEOFXkwme3tEzY0shhxcwzN4esiMUpxyoKOgKkMCbncCq36dvW3ipG5XYQxcp8yf/PGqqXSkSK0vKv6sSJEc5BQhfQcvtnLZ+JIRwuxiE+NZylsHmjI0xkOFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507049td74dc46e
X-QQ-Originating-IP: TonvNbZmdndwJfjAvzkOcF601bgVm1aOWxzO5YuajW8=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:04:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5010813016814483052
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
Subject: [PATCH net-next v3 8/9] net: wangxun: add Tx timeout process
Date: Tue,  3 Mar 2026 11:03:30 +0800
Message-Id: <20260303030331.24076-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260303030331.24076-1-jiawenwu@trustnetic.com>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHZ6KcAtOkTxH5ZeVU7X+o5r2M0Kjrf+dXd5TCjTgp4dhNu4EmJXEOm+
	pU+gnvxQJ0rZrzN2FNj6oBXpJtejFO34nq3nfU7kJWSe6/16lGOW06o9L99nuo7anPE1xa9
	e/LBQt2H69QJg4dgyFspMIoh+ZSRHHiF+owygTH/klvjF3AHpQB+TQKXPjy7AR+CPjS7m9b
	2l9u4HTsr4//psOFeuuRNUE8jnnZxbNk583rAKXtSinSbEEhaj5oSMNA9L80ozbc+u/D9uj
	thDdUwSO/1+tUMA14e4QtxxzEDD/wSo0IVX7yyhEDF7/ikxP0xlDHhF0UeZQYHY48NEUPGC
	5blwEvfbu+fr/5iR00vLxZbxmEfcHTrWIQZgIWz60kV3qsD10ua29+Yw54VRtOdw3JcsuI+
	VYpa6noH1VGSgGPMagIQYA0Nz2+4hBNkPluHu5ijfmzQO4MgJmFR2pA5afw5j842elX+Uav
	npKqe+4vH6D3yisKTDPr4E0eeiJhASXlMWh2G3VK9VQG01JUAzgbVEpo4Z9KBaReUE93q6g
	bSDg1vTlQpvrDD+SKGq1eJMV9J3pWeetzV49Q4D+RYE73ST61BdqQDsMUagkMJOx7HFzT3/
	HxqISuFLe4Ns5kytHPUve/MZ9AOwLQJKAMoR7E9sizhbOgK3U4edhzq4VBTVrSjmsS9o7cs
	REalGFIcacXqY4fV3tTp+kvC752zUZB/yLzsCfM2zcdZnSu7TwfOrhhznDCKYLmCQyAFOlQ
	SVLx9tDd2kMP6PSedwQkYT0UjNFC0C3WHgkIqAqQCxu/7HYjAk/jykgK9HE7axVivd/KGJb
	UMmpkScVMO1Xi1yHqgW4L3Bzr8o7he7s/xsbE4ACQ8SSltWLmBo9gZMLZn8xed2R4PeFqsW
	JeFMHYZqeQqvdLFZv2bLWRgRQkg67BdbSQpvhh2gtloTC1by0OaHhjvhogY85HrqyC92300
	css8s6Z8Q0aXr3XlVfdxK2eP1ov8IKt0j+sGdwNJVE1DHBwa6L2PuZtMxgpJ1yk7KK9nzA4
	AHmjQTgKfxi59zoESiVX/OyAh+0sqCsNpMwtzdrNNKIeGH7Fi4ppenygb4kZd4mNcQH3q7B
	aaRNgw2pQao46Dv+1FGjIcFSbgONVUlv6Lt9KhTEA52
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: D47361E84E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.813];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Action: no action

Implement .ndo_tx_timeout to handle Tx side timeout event. When Tx
timeout event occur, it will triger driver into reset process.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 126 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  14 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  49 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  34 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   3 +
 9 files changed, 239 insertions(+), 3 deletions(-)
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
index 000000000000..bb77bdce69d2
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
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	rtnl_lock();
+
+	wx_warn(wx, "Reset adapter.\n");
+
+	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
+		if (wx->do_reset)
+			wx->do_reset(wx->netdev, true);
+		clear_bit(WX_FLAG_NEED_PF_RESET,  wx->flags);
+	}
+
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
index 150a063daafd..2f71dc24306d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1931,6 +1931,7 @@ static void wx_configure_tx_ring(struct wx *wx,
 	else
 		ring->atr_sample_rate = 0;
 
+	bitmap_zero(ring->state, WX_RING_STATE_NBITS);
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index c65240ca3c28..5a21478a592b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -14,6 +14,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_err.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
 #include "wx_vf_lib.h"
@@ -742,6 +743,48 @@ static struct netdev_queue *wx_txring_txq(const struct wx_ring *ring)
 	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
 }
 
+static u64 wx_get_tx_pending(struct wx_ring *ring)
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
+	u64 tx_done_old = ring->tx_stats.tx_done_old;
+	u64 tx_pending = wx_get_tx_pending(ring);
+	u64 tx_done = ring->stats.packets;
+
+	clear_bit(WX_TX_DETECT_HANG, ring->state);
+
+	/*
+	 * Check for a hung queue, but be thorough. This verifies
+	 * that a transmit has been completed since the previous
+	 * check AND there is at least one packet pending. The
+	 * ARMED bit is set to indicate a potential hang. The
+	 * bit is cleared if a pause frame is received to remove
+	 * false hang detection due to PFC or 802.3x frames. By
+	 * requiring this to fail twice we avoid races with
+	 * pfc clearing the ARMED bit and conditions where we
+	 * run the check_tx_hang logic with a transmit completion
+	 * pending but without time to complete it yet.
+	 */
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
@@ -866,6 +909,12 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
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
index 42461723a400..85f70ea5a64f 100644
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
index e013f05d2cfe..434a582393d7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1036,6 +1036,7 @@ struct wx_queue_stats {
 struct wx_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
+	u64 tx_done_old;
 };
 
 struct wx_rx_queue_stats {
@@ -1051,6 +1052,12 @@ struct wx_rx_queue_stats {
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
@@ -1070,6 +1077,7 @@ struct wx_ring {
 		struct wx_tx_buffer *tx_buffer_info;
 		struct wx_rx_buffer *rx_buffer_info;
 	};
+	DECLARE_BITMAP(state, WX_RING_STATE_NBITS);
 	u8 __iomem *tail;
 	dma_addr_t dma;                 /* phys. address of descriptor ring */
 	dma_addr_t headwb_dma;
@@ -1254,6 +1262,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
+	WX_FLAG_NEED_PF_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1470,7 +1479,8 @@ wr32ptp(struct wx *wx, u32 reg, u32 value)
 
 #define wx_err(wx, fmt, arg...) \
 	dev_err(&(wx)->pdev->dev, fmt, ##arg)
-
+#define wx_warn(wx, fmt, arg...) \
+	dev_warn(&(wx)->pdev->dev, fmt, ##arg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 4dd7de79431c..e0f5d3b49db7 100644
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
@@ -140,6 +141,26 @@ static int ngbe_sw_init(struct wx *wx)
 	return 0;
 }
 
+/**
+ * ngbe_service_task - manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+static void ngbe_service_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, service_task);
+
+	wx_handle_errors_subtask(wx);
+
+	wx_service_event_complete(wx);
+}
+
+static void ngbe_init_service(struct wx *wx)
+{
+	timer_setup(&wx->service_timer, wx_service_timer, 0);
+	INIT_WORK(&wx->service_task, ngbe_service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+
 /**
  * ngbe_irq_enable - Enable default interrupt generation settings
  * @wx: board private structure
@@ -370,6 +391,7 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_napi_disable_all(wx);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
+	timer_delete_sync(&wx->service_timer);
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, false);
 	wx_irq_disable(wx);
@@ -415,6 +437,7 @@ static void ngbe_up_complete(struct wx *wx)
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
+	mod_timer(&wx->service_timer, jiffies);
 
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
@@ -593,6 +616,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_stop               = ngbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
@@ -779,9 +803,11 @@ static int ngbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	ngbe_init_service(wx);
+
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_cancel_service;
 
 	/* phy Interface Configuration */
 	err = ngbe_mdio_init(wx);
@@ -801,6 +827,9 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
+err_cancel_service:
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -826,6 +855,9 @@ static void ngbe_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 01ceaf270b70..d4f87fbb9565 100644
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
 
@@ -640,6 +642,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_stop               = txgbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
+	.ndo_tx_timeout         = wx_tx_timeout,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
-- 
2.48.1


