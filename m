Return-Path: <netdev+bounces-245090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B5CC6BB5
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D749330656E3
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628B34573F;
	Wed, 17 Dec 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U4vZC7/Y"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC03446CC;
	Wed, 17 Dec 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961494; cv=none; b=Lu8oiPOG4ugHRBHAeCq4xPvebFCmgv+rg9ohGK7kJws+RvBUzVAYlHbP1S9Scb30hzfUIAqUVZ7FPSul4XeRpNjodvQ4Q6CrIQQOAj9A17vav3Lfi0T7QjkHkX1KspuFaBVvp6o+7r6+l9djtdv1bkwxZnyS0kc9fHUSk3pk/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961494; c=relaxed/simple;
	bh=FnOOBaGd7RXBm1aRgFwgvFlDVREzwRS11hIxzUHLU3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRvBcOVXLxaCEbmOTYqj6pB70o6eUvsgKONDILTOPZPmzedY4+BNjpChp+r1VAsCqAeZ6fyqrICNb87w5V/IATb82I+7iY2bA70Rf6+7YGDaUkG9ouZcFLAZA6uH+Shcv0gdHG6ezxPKlfaWCwjCHBz7P1Ya5kco1AxrfcHO+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U4vZC7/Y; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=N7ga78rmrr1Rzxa1m02QopH9GBEqIl3krawrnnZrmD8=;
	b=U4vZC7/YkQ3qEvJDhtcZO1mAiTeHP6A4SkRe1ldmUhnKHam9DO8ZfQj54Fr27s
	cNbBTk7invGS9wRMobsSY1b0jd536YEX0GkrTciWwgfCO/dptWwMIjOBldelYL4u
	tc0b/n3ki/aSWR4wugJpkE1Gp1Z0ISiOWmugxzZORelb8=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXSZ7lbkJp2ZeZAw--.42656S13;
	Wed, 17 Dec 2025 16:50:50 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH 08/14] examples/vhost_user_rdma: implement advanced completer engine with reliability features
Date: Wed, 17 Dec 2025 16:49:56 +0800
Message-ID: <20251217085044.5432-10-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217085044.5432-1-15927021679@163.com>
References: <20251217085044.5432-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSZ7lbkJp2ZeZAw--.42656S13
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4-B_UUUUU
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wrASWlCbupBSQAA3X

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds the completer engine for RDMA operations with:
1. State machine for ACK packet processing
2. PSN-based sequence validation
3. Reliability mechanisms (retry, RNR backoff)
4. Atomic operation execution
5. Comprehensive error handling
6. Performance counters for diagnostics

Key features:
- 11-state processing pipeline for response handling
- Dynamic retransmission timer management
- RNR NAK timer for flow control
- Packet lifetime tracking (mbuf release)
- Work completion error propagation
- Congestion-aware task scheduling

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: I12a7baf03edffcd66da7bdc84218001c6bf3a0de
---
 examples/vhost_user_rdma/meson.build          |   1 +
 .../vhost_user_rdma/vhost_rdma_complete.c     | 850 ++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_opcode.h  | 437 +++++----
 examples/vhost_user_rdma/vhost_rdma_queue.c   |   6 -
 examples/vhost_user_rdma/vhost_rdma_queue.h   |   5 +
 5 files changed, 1096 insertions(+), 203 deletions(-)
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_complete.c

diff --git a/examples/vhost_user_rdma/meson.build b/examples/vhost_user_rdma/meson.build
index 2a0a6ffc15..4948f709d9 100644
--- a/examples/vhost_user_rdma/meson.build
+++ b/examples/vhost_user_rdma/meson.build
@@ -45,5 +45,6 @@ sources = files(
     'vhost_rdma_opcode.c',
     'vhost_rdma_pkt.c',
     'vhost_rdma_crc.c',
+    'vhost_rdma_complete.c',
 )
 
diff --git a/examples/vhost_user_rdma/vhost_rdma_complete.c b/examples/vhost_user_rdma/vhost_rdma_complete.c
new file mode 100644
index 0000000000..623b8dd2a0
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_complete.c
@@ -0,0 +1,850 @@
+/*
+ * Vhost-user RDMA device: Completion Queue Handler (Completer)
+ *
+ * This module handles the completion of Send Queue Work Queue Entries (WQEs)
+ * based on incoming response packets such as ACKs, Read Responses, or NAKs.
+ * It ensures reliable delivery for RC QPs by checking PSN, handling retries,
+ * and posting completions to the CQ.
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <rte_mbuf.h>
+#include <rte_timer.h>
+#include <rte_atomic.h>
+#include <rte_log.h>
+
+#include "vhost_rdma_opcode.h"
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma_queue.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_pkt.h"
+
+/**
+ * enum comp_state - State machine for RDMA completer
+ *
+ * The completer processes incoming responses using a state machine to handle:
+ * - Packet validation (PSN, opcode)
+ * - Retry logic (timeout, RNR NAK)
+ * - Data operations (READ, ATOMIC)
+ * - Completion generation
+ */
+enum comp_state {
+	VHOST_RDMA_COMPST_GET_ACK,
+	VHOST_RDMA_COMPST_GET_WQE,
+	VHOST_RDMA_COMPST_COMP_WQE,
+	VHOST_RDMA_COMPST_COMP_ACK,
+	VHOST_RDMA_COMPST_CHECK_PSN,
+	VHOST_RDMA_COMPST_CHECK_ACK,
+	VHOST_RDMA_COMPST_READ,
+	VHOST_RDMA_COMPST_ATOMIC,
+	VHOST_RDMA_COMPST_WRITE_SEND,
+	VHOST_RDMA_COMPST_UPDATE_COMP,
+	VHOST_RDMA_COMPST_ERROR_RETRY,
+	VHOST_RDMA_COMPST_RNR_RETRY,
+	VHOST_RDMA_COMPST_ERROR,
+	VHOST_RDMA_COMPST_EXIT,
+	VHOST_RDMA_COMPST_DONE,
+};
+
+/* Human-readable state names for debugging */
+static const char *comp_state_name[] = {
+	[VHOST_RDMA_COMPST_GET_ACK]		= "GET ACK",
+	[VHOST_RDMA_COMPST_GET_WQE]		= "GET WQE",
+	[VHOST_RDMA_COMPST_COMP_WQE]	= "COMP WQE",
+	[VHOST_RDMA_COMPST_COMP_ACK]	= "COMP ACK",
+	[VHOST_RDMA_COMPST_CHECK_PSN]	= "CHECK PSN",
+	[VHOST_RDMA_COMPST_CHECK_ACK]	= "CHECK ACK",
+	[VHOST_RDMA_COMPST_READ]		= "READ",
+	[VHOST_RDMA_COMPST_ATOMIC]		= "ATOMIC",
+	[VHOST_RDMA_COMPST_WRITE_SEND]	= "WRITE/SEND",
+	[VHOST_RDMA_COMPST_UPDATE_COMP]	= "UPDATE COMP",
+	[VHOST_RDMA_COMPST_ERROR_RETRY]	= "ERROR RETRY",
+	[VHOST_RDMA_COMPST_RNR_RETRY]	= "RNR RETRY",
+	[VHOST_RDMA_COMPST_ERROR]		= "ERROR",
+	[VHOST_RDMA_COMPST_EXIT]		= "EXIT",
+	[VHOST_RDMA_COMPST_DONE]		= "DONE",
+};
+
+/**
+ * enum ib_rnr_timeout - Backoff values for RNR NAK timer
+ *
+ * These define exponential backoff delays when receiver is not ready.
+ * Expressed in microseconds via rnrnak_usec[] table.
+ */
+enum ib_rnr_timeout {
+	IB_RNR_TIMER_655_36 =  0,
+	IB_RNR_TIMER_000_01 =  1,
+	IB_RNR_TIMER_000_02 =  2,
+	IB_RNR_TIMER_000_03 =  3,
+	IB_RNR_TIMER_000_04 =  4,
+	IB_RNR_TIMER_000_06 =  5,
+	IB_RNR_TIMER_000_08 =  6,
+	IB_RNR_TIMER_000_12 =  7,
+	IB_RNR_TIMER_000_16 =  8,
+	IB_RNR_TIMER_000_24 =  9,
+	IB_RNR_TIMER_000_32 = 10,
+	IB_RNR_TIMER_000_48 = 11,
+	IB_RNR_TIMER_000_64 = 12,
+	IB_RNR_TIMER_000_96 = 13,
+	IB_RNR_TIMER_001_28 = 14,
+	IB_RNR_TIMER_001_92 = 15,
+	IB_RNR_TIMER_002_56 = 16,
+	IB_RNR_TIMER_003_84 = 17,
+	IB_RNR_TIMER_005_12 = 18,
+	IB_RNR_TIMER_007_68 = 19,
+	IB_RNR_TIMER_010_24 = 20,
+	IB_RNR_TIMER_015_36 = 21,
+	IB_RNR_TIMER_020_48 = 22,
+	IB_RNR_TIMER_030_72 = 23,
+	IB_RNR_TIMER_040_96 = 24,
+	IB_RNR_TIMER_061_44 = 25,
+	IB_RNR_TIMER_081_92 = 26,
+	IB_RNR_TIMER_122_88 = 27,
+	IB_RNR_TIMER_163_84 = 28,
+	IB_RNR_TIMER_245_76 = 29,
+	IB_RNR_TIMER_327_68 = 30,
+	IB_RNR_TIMER_491_52 = 31
+};
+
+/**
+ * rnrnak_usec - Microsecond delay lookup for RNR timeout codes
+ *
+ * Indexed by enum ib_rnr_timeout. Used to schedule RNR retry timers.
+ */
+static unsigned long rnrnak_usec[32] = {
+	[IB_RNR_TIMER_655_36] = 655360,
+	[IB_RNR_TIMER_000_01] = 10,
+	[IB_RNR_TIMER_000_02] = 20,
+	[IB_RNR_TIMER_000_03] = 30,
+	[IB_RNR_TIMER_000_04] = 40,
+	[IB_RNR_TIMER_000_06] = 60,
+	[IB_RNR_TIMER_000_08] = 80,
+	[IB_RNR_TIMER_000_12] = 120,
+	[IB_RNR_TIMER_000_16] = 160,
+	[IB_RNR_TIMER_000_24] = 240,
+	[IB_RNR_TIMER_000_32] = 320,
+	[IB_RNR_TIMER_000_48] = 480,
+	[IB_RNR_TIMER_000_64] = 640,
+	[IB_RNR_TIMER_000_96] = 960,
+	[IB_RNR_TIMER_001_28] = 1280,
+	[IB_RNR_TIMER_001_92] = 1920,
+	[IB_RNR_TIMER_002_56] = 2560,
+	[IB_RNR_TIMER_003_84] = 3840,
+	[IB_RNR_TIMER_005_12] = 5120,
+	[IB_RNR_TIMER_007_68] = 7680,
+	[IB_RNR_TIMER_010_24] = 10240,
+	[IB_RNR_TIMER_015_36] = 15360,
+	[IB_RNR_TIMER_020_48] = 20480,
+	[IB_RNR_TIMER_030_72] = 30720,
+	[IB_RNR_TIMER_040_96] = 40960,
+	[IB_RNR_TIMER_061_44] = 61410,
+	[IB_RNR_TIMER_081_92] = 81920,
+	[IB_RNR_TIMER_122_88] = 122880,
+	[IB_RNR_TIMER_163_84] = 163840,
+	[IB_RNR_TIMER_245_76] = 245760,
+	[IB_RNR_TIMER_327_68] = 327680,
+	[IB_RNR_TIMER_491_52] = 491520,
+};
+
+/**
+ * vhost_rdma_get_wqe - Retrieve head WQE from send queue
+ * @qp: Queue pair
+ * @pkt: Incoming packet (may be NULL)
+ * @wqe_p: Output pointer to current WQE
+ *
+ * Returns next state depending on WQE state and presence of packet.
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_get_wqe(struct vhost_rdma_qp *qp, struct vhost_rdma_pkt_info *pkt,
+		   struct vhost_rdma_send_wqe **wqe_p)
+{
+	struct vhost_rdma_send_wqe *wqe;
+
+	wqe = queue_head(&qp->sq.queue);
+	*wqe_p = wqe;
+
+	/* No WQE available or requester hasn't started processing */
+	if (!wqe || wqe->state == WQE_STATE_POSTED)
+		return pkt ? VHOST_RDMA_COMPST_DONE : VHOST_RDMA_COMPST_EXIT;
+
+	/* Already completed locally */
+	if (wqe->state == WQE_STATE_DONE)
+		return VHOST_RDMA_COMPST_COMP_WQE;
+
+	/* WQE previously failed */
+	if (wqe->state == WQE_STATE_ERROR)
+		return VHOST_RDMA_COMPST_ERROR;
+
+	/* Valid WQE exists — proceed to PSN check if packet exists */
+	return pkt ? VHOST_RDMA_COMPST_CHECK_PSN : VHOST_RDMA_COMPST_EXIT;
+}
+
+/**
+ * reset_retry_counters - Reset retry counters after successful ACK
+ * @qp: Queue pair whose attributes are used
+ */
+static __rte_always_inline void
+reset_retry_counters(struct vhost_rdma_qp *qp)
+{
+	qp->comp.retry_cnt = qp->attr.retry_cnt;
+	qp->comp.rnr_retry = qp->attr.rnr_retry;
+	qp->comp.started_retry = 0;
+}
+
+/**
+* vhost_rdma_check_psn - Validate packet sequence number against expected
+* @qp: Queue pair
+* @pkt: Response packet
+* @wqe: Current WQE
+*
+* Checks whether PSN is valid, detects retransmissions, timeouts, or gaps.
+*/
+static __rte_always_inline enum comp_state
+vhost_rdma_check_psn(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_pkt_info *pkt,
+			struct vhost_rdma_send_wqe *wqe)
+{
+	int32_t diff;
+
+	/* Check if this response is newer than last segment of current WQE */
+	diff = psn_compare(pkt->psn, wqe->last_psn);
+	if (diff > 0) {
+		if (wqe->state == WQE_STATE_PENDING) {
+			/* Unexpected late arrival — likely timeout occurred */
+			if (wqe->mask & WR_ATOMIC_OR_READ_MASK)
+				return VHOST_RDMA_COMPST_ERROR_RETRY;
+
+			/* Reset retry count on new transaction */
+			reset_retry_counters(qp);
+			return VHOST_RDMA_COMPST_COMP_WQE;
+		} else {
+			return VHOST_RDMA_COMPST_DONE;
+		}
+	}
+
+	/* Compare with expected PSN at completer */
+	diff = psn_compare(pkt->psn, qp->comp.psn);
+	if (diff < 0) {
+		/* Retransmitted packet — complete only if matches WQE */
+		if (pkt->psn == wqe->last_psn)
+			return VHOST_RDMA_COMPST_COMP_ACK;
+		else
+			return VHOST_RDMA_COMPST_DONE;
+	} else if ((diff > 0) && (wqe->mask & WR_ATOMIC_OR_READ_MASK)) {
+		/* Out-of-order read/atomic response — skip */
+		return VHOST_RDMA_COMPST_DONE;
+	} else {
+		return VHOST_RDMA_COMPST_CHECK_ACK;
+	}
+}
+
+/**
+ * vhost_rdma_check_ack - Validate response opcode and AETH status
+ * @qp: Queue pair
+ * @pkt: Incoming packet
+ * @wqe: Associated WQE
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_check_ack(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_pkt_info *pkt,
+			struct vhost_rdma_send_wqe *wqe)
+{
+	struct vhost_rdma_device *dev = qp->dev;
+	unsigned int mask = pkt->mask;
+	uint8_t syn;
+
+	/* Handle initial opcode expectations */
+	switch (qp->comp.opcode) {
+	case -1:
+		/* Expecting start of message */
+		if (!(mask & VHOST_START_MASK))
+			return VHOST_RDMA_COMPST_ERROR;
+		break;
+
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+		if (pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
+			pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
+			/* Allow retry from first or only segment */
+			if ((pkt->psn == wqe->first_psn &&
+				pkt->opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST) ||
+				(wqe->first_psn == wqe->last_psn &&
+				pkt->opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY))
+				break;
+
+			return VHOST_RDMA_COMPST_ERROR;
+		}
+		break;
+	default:
+		RDMA_LOG_ERR("Invalid comp opcode state: %d", qp->comp.opcode);
+		return VHOST_RDMA_COMPST_ERROR;
+	}
+
+	/* Parse AETH syndrome for ACK/NAK types */
+	syn = aeth_syn(pkt);
+
+	switch (pkt->opcode) {
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
+		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
+			return VHOST_RDMA_COMPST_ERROR;
+		/* Fall through */
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+		if (wqe->wr->opcode != VHOST_RDMA_IB_WR_RDMA_READ) {
+			wqe->status = VHOST_RDMA_IB_WC_FATAL_ERR;
+			return VHOST_RDMA_COMPST_ERROR;
+		}
+		reset_retry_counters(qp);
+		return VHOST_RDMA_COMPST_READ;
+
+	case IB_OPCODE_RC_ACKNOWLEDGE:
+		switch (syn & AETH_TYPE_MASK) {
+		case AETH_ACK:
+			reset_retry_counters(qp);
+			return VHOST_RDMA_COMPST_WRITE_SEND;
+
+		case AETH_RNR_NAK:
+			vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_RCV_RNR);
+			return VHOST_RDMA_COMPST_RNR_RETRY;
+
+		case AETH_NAK:
+			switch (syn) {
+			case AETH_NAK_PSN_SEQ_ERROR:
+				int diff;
+				diff = psn_compare(pkt->psn, qp->comp.psn);
+				if (diff > 0) {
+					vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_RCV_SEQ_ERR);
+					qp->comp.psn = pkt->psn;
+					if (qp->req.wait_psn) {
+						qp->req.wait_psn = 0;
+						vhost_rdma_run_task(&qp->req.task, 0);
+					}
+				}
+				return VHOST_RDMA_COMPST_ERROR_RETRY;
+
+			case AETH_NAK_INVALID_REQ:
+				wqe->status = VHOST_RDMA_IB_WC_REM_INV_REQ_ERR;
+				return VHOST_RDMA_COMPST_ERROR;
+
+			case AETH_NAK_REM_ACC_ERR:
+				wqe->status = VHOST_RDMA_IB_WC_REM_ACCESS_ERR;
+				return VHOST_RDMA_COMPST_ERROR;
+
+			case AETH_NAK_REM_OP_ERR:
+				wqe->status = VHOST_RDMA_IB_WC_REM_OP_ERR;
+				return VHOST_RDMA_COMPST_ERROR;
+
+			default:
+				RDMA_LOG_ERR("Unexpected NAK type: 0x%x", syn);
+				wqe->status = VHOST_RDMA_IB_WC_REM_OP_ERR;
+				return VHOST_RDMA_COMPST_ERROR;
+			}
+
+		default:
+			RDMA_LOG_ERR("Unknown AETH type: 0x%x", syn);
+			return VHOST_RDMA_COMPST_ERROR;
+		}
+		break;
+
+	default:
+		RDMA_LOG_ERR("Unexpected opcode: %u", pkt->opcode);
+		return VHOST_RDMA_COMPST_ERROR;
+	}
+}
+
+/**
+ * vhost_rdma_do_read - Copy data from read response into local buffer
+ * @qp: Queue pair
+ * @pkt: Read response packet
+ * @wqe: Corresponding WQE
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_do_read(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_pkt_info *pkt,
+			struct vhost_rdma_send_wqe *wqe)
+{
+	int ret;
+
+	ret = copy_data(qp->pd, VHOST_RDMA_IB_ACCESS_LOCAL_WRITE,
+			&wqe->dma, payload_addr(pkt),
+			payload_size(pkt), VHOST_RDMA_TO_MR_OBJ, NULL);
+	if (ret) {
+		wqe->status = VHOST_RDMA_IB_WC_LOC_PROT_ERR;
+		return VHOST_RDMA_COMPST_ERROR;
+	}
+
+	/* Final packet? Complete now */
+	if (wqe->dma.resid == 0 && (pkt->mask & VHOST_END_MASK))
+		return VHOST_RDMA_COMPST_COMP_ACK;
+
+	return VHOST_RDMA_COMPST_UPDATE_COMP;
+}
+
+/**
+ * vhost_rdma_do_atomic - Handle atomic acknowledgment with original value
+ * @qp: Queue pair
+ * @pkt: Atomic ACK packet
+ * @wqe: WQE
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_do_atomic(struct vhost_rdma_qp *qp,
+				struct vhost_rdma_pkt_info *pkt,
+				struct vhost_rdma_send_wqe *wqe)
+{
+	int ret;
+	uint64_t atomic_orig = atmack_orig(pkt);
+
+	ret = copy_data(qp->pd, VHOST_RDMA_IB_ACCESS_LOCAL_WRITE,
+			&wqe->dma, &atomic_orig,
+			sizeof(uint64_t), VHOST_RDMA_TO_MR_OBJ, NULL);
+	if (ret) {
+		wqe->status = VHOST_RDMA_IB_WC_LOC_PROT_ERR;
+		return VHOST_RDMA_COMPST_ERROR;
+	}
+
+	return VHOST_RDMA_COMPST_COMP_ACK;
+}
+
+/**
+ * wr_to_wc_opcode - Convert Work Request opcode to Work Completion opcode
+ * @opcode: WR opcode
+ *
+ * Returns corresponding WC opcode or 0xff on error.
+ */
+static enum vhost_rdma_ib_wc_opcode
+wr_to_wc_opcode(enum vhost_rdma_ib_wr_opcode opcode)
+{
+	switch (opcode) {
+	case VHOST_RDMA_IB_WR_RDMA_WRITE:
+	case VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM:
+		return VHOST_RDMA_IB_WC_RDMA_WRITE;
+	case VHOST_RDMA_IB_WR_SEND:
+	case VHOST_RDMA_IB_WR_SEND_WITH_IMM:
+		return VHOST_RDMA_IB_WC_SEND;
+	case VHOST_RDMA_IB_WR_RDMA_READ:
+		return VHOST_RDMA_IB_WC_RDMA_READ;
+	default:
+		return 0xff;
+	}
+}
+
+/**
+ * make_send_cqe - Build a completion queue entry from WQE
+ * @qp: Queue pair
+ * @wqe: Completed WQE
+ * @cqe: Output CQE
+ */
+static void
+make_send_cqe(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_send_wqe *wqe,
+			struct vhost_rdma_cq_req *cqe)
+{
+	memset(cqe, 0, sizeof(*cqe));
+
+	cqe->wr_id = wqe->wr->wr_id;
+	cqe->status = wqe->status;
+	cqe->opcode = wr_to_wc_opcode(wqe->wr->opcode);
+
+	if (wqe->wr->opcode == VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM ||
+		wqe->wr->opcode == VHOST_RDMA_IB_WR_SEND_WITH_IMM)
+		cqe->wc_flags |= VHOST_RDMA_WC_WITH_IMM;
+
+	cqe->byte_len = wqe->dma.length;
+	cqe->qp_num = qp->qpn;
+}
+
+/**
+ * advance_consumer - Advance SQ consumer index and notify virtqueue
+ * @q: Queue structure
+ */
+static __rte_always_inline void
+advance_consumer(struct vhost_rdma_queue *q)
+{
+	uint16_t cons_idx;
+	uint16_t desc_idx;
+
+	assert(q->consumer_index == q->vq->last_avail_idx);
+
+	cons_idx = q->consumer_index & (q->num_elems - 1);
+	desc_idx = q->vq->vring.avail->ring[cons_idx];
+
+	vhost_rdma_queue_push(q->vq, desc_idx, 0);
+
+	q->consumer_index++;
+	q->vq->last_avail_idx++;
+}
+
+/**
+ * vhost_rdma_do_complete - Complete a WQE and post CQE if needed
+ * @qp: Queue pair
+ * @wqe: WQE to complete
+ *
+ * Per IB spec, even unsignaled WQEs must generate CQE on error.
+ */
+static void
+vhost_rdma_do_complete(struct vhost_rdma_qp *qp,
+				struct vhost_rdma_send_wqe *wqe)
+{
+	struct vhost_rdma_device *dev = qp->dev;
+	struct vhost_rdma_cq_req cqe;
+	bool post;
+
+	post = (qp->sq_sig_all ||
+		(wqe->wr->send_flags & VHOST_RDMA_IB_SEND_SIGNALED) ||
+		wqe->status != VHOST_RDMA_IB_WC_SUCCESS);
+
+	if (post)
+		make_send_cqe(qp, wqe, &cqe);
+
+	advance_consumer(&qp->sq.queue);
+
+	if (post)
+		vhost_rdma_cq_post(dev, qp->scq, &cqe, 0);
+
+	if (wqe->wr->opcode == VHOST_RDMA_IB_WR_SEND ||
+	    wqe->wr->opcode == VHOST_RDMA_IB_WR_SEND_WITH_IMM)
+		vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_RDMA_SEND);
+
+	/* Wake up requester if waiting for fence or PSN */
+	if (qp->req.wait_fence) {
+		qp->req.wait_fence = 0;
+		vhost_rdma_run_task(&qp->req.task, 0);
+	}
+}
+
+/**
+ * vhost_rdma_complete_wqe - Mark WQE as completed and update PSN
+ * @qp: Queue pair
+ * @pkt: Response packet (may be NULL)
+ * @wqe: WQE
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_complete_wqe(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_pkt_info *pkt,
+			struct vhost_rdma_send_wqe *wqe)
+{
+	if (pkt && wqe->state == WQE_STATE_PENDING) {
+		if (psn_compare(wqe->last_psn, qp->comp.psn) >= 0) {
+			qp->comp.psn = (wqe->last_psn + 1) & VHOST_RDMA_PSN_MASK;
+			qp->comp.opcode = -1;
+		}
+
+		if (qp->req.wait_psn) {
+			qp->req.wait_psn = 0;
+			vhost_rdma_run_task(&qp->req.task, 1);
+		}
+	}
+
+	vhost_rdma_do_complete(qp, wqe);
+	return VHOST_RDMA_COMPST_GET_WQE;
+}
+
+/**
+ * vhost_rdma_rnr_nak_timer - Callback when RNR backoff timer expires
+ * @timer: Timer instance
+ * @arg: Pointer to QP
+ */
+static void
+vhost_rdma_rnr_nak_timer(__rte_unused struct rte_timer *timer, void *arg)
+{
+	struct vhost_rdma_qp *qp = arg;
+
+	RDMA_LOG_DEBUG_DP("QP#%d RNR NAK timer expired", qp->qpn);
+	vhost_rdma_run_task(&qp->req.task, 1);
+}
+
+/**
+ * vhost_rdma_complete_ack - Handle ACK completion including RD_ATOMICS sync
+ * @qp: Queue pair
+ * @pkt: ACK packet
+ * @wqe: WQE
+ */
+static __rte_always_inline enum comp_state
+vhost_rdma_complete_ack(struct vhost_rdma_qp *qp,
+			struct vhost_rdma_pkt_info *pkt,
+			struct vhost_rdma_send_wqe *wqe)
+{
+	if (wqe->has_rd_atomic) {
+		wqe->has_rd_atomic = 0;
+		rte_atomic32_inc(&qp->req.rd_atomic);
+		if (qp->req.need_rd_atomic) {
+			qp->comp.timeout_retry = 0;
+			qp->req.need_rd_atomic = 0;
+			vhost_rdma_run_task(&qp->req.task, 0);
+		}
+	}
+
+	/* Handle SQ drain transition */
+	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
+		rte_spinlock_lock(&qp->state_lock);
+		if (qp->req.state == QP_STATE_DRAIN &&
+		    qp->comp.psn == qp->req.psn) {
+			qp->req.state = QP_STATE_DRAINED;
+			rte_spinlock_unlock(&qp->state_lock);
+
+			// TODO: Trigger IB_EVENT_SQ_DRAINED
+		} else {
+			rte_spinlock_unlock(&qp->state_lock);
+		}
+	}
+
+	vhost_rdma_do_complete(qp, wqe);
+
+	if (psn_compare(pkt->psn, qp->comp.psn) >= 0)
+		return VHOST_RDMA_COMPST_UPDATE_COMP;
+	else
+		return VHOST_RDMA_COMPST_DONE;
+}
+
+/**
+ * free_pkt - Release packet reference and free mbuf
+ * @pkt: Packet info to release
+ */
+static __rte_always_inline void
+free_pkt(struct vhost_rdma_pkt_info *pkt)
+{
+	struct rte_mbuf *mbuf = PKT_TO_MBUF(pkt);
+
+	vhost_rdma_drop_ref(pkt->qp, pkt->qp->dev, qp);
+	rte_pktmbuf_free(mbuf);
+}
+
+/**
+ * rnrnak_ticks - Convert RNR timeout code to timer ticks
+ * @timeout: Timeout code
+ */
+static __rte_always_inline unsigned long
+rnrnak_ticks(uint8_t timeout)
+{
+	uint64_t ticks_per_us = rte_get_timer_hz() / 1000000;
+	return RTE_MAX(rnrnak_usec[timeout] * ticks_per_us, 1UL);
+}
+
+/**
+ * vhost_rdma_drain_resp_pkts - Flush all pending response packets
+ * @qp: Queue pair
+ * @notify: Whether to signal flush error
+ */
+static void
+vhost_rdma_drain_resp_pkts(struct vhost_rdma_qp *qp, bool notify)
+{
+	struct rte_mbuf *mbuf;
+	struct vhost_rdma_send_wqe *wqe;
+	struct vhost_rdma_queue *q = &qp->sq.queue;
+
+	while (rte_ring_dequeue(qp->resp_pkts, (void **)&mbuf) == 0) {
+		vhost_rdma_drop_ref(qp, qp->dev, qp);
+		rte_pktmbuf_free(mbuf);
+	}
+
+	while ((wqe = queue_head(q))) {
+		if (notify) {
+			wqe->status = VHOST_RDMA_IB_WC_WR_FLUSH_ERR;
+			vhost_rdma_do_complete(qp, wqe);
+		} else {
+			advance_consumer(q);
+		}
+	}
+}
+
+/**
+ * vhost_rdma_completer - Main completer function (run per QP)
+ * @arg: Pointer to vhost_rdma_qp
+ *
+ * Processes incoming response packets and completes WQEs accordingly.
+ * Implements reliability mechanisms: retry, RNR backoff, PSN tracking.
+ *
+ * Return: 0 on success, -EAGAIN if needs rescheduling
+ */
+int
+vhost_rdma_completer(void *arg)
+{
+	struct vhost_rdma_qp *qp = arg;
+	struct vhost_rdma_device *dev = qp->dev;
+	struct vhost_rdma_send_wqe *wqe = NULL;
+	struct rte_mbuf *mbuf = NULL;
+	struct vhost_rdma_pkt_info *pkt = NULL;
+	enum comp_state state;
+	int ret = 0;
+
+	vhost_rdma_add_ref(qp);
+
+	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
+		qp->req.state == QP_STATE_RESET) {
+		vhost_rdma_drain_resp_pkts(qp, qp->valid &&
+						qp->req.state == QP_STATE_ERROR);
+		ret = -EAGAIN;
+		goto done;
+	}
+
+	if (qp->comp.timeout) {
+		qp->comp.timeout_retry = 1;
+		qp->comp.timeout = 0;
+	} else {
+		qp->comp.timeout_retry = 0;
+	}
+
+	if (qp->req.need_retry) {
+		ret = -EAGAIN;
+		goto done;
+	}
+
+	state = VHOST_RDMA_COMPST_GET_ACK;
+
+	while (1) {
+		RDMA_LOG_DEBUG_DP("QP#%d state=%s", qp->qpn, comp_state_name[state]);
+
+		switch (state) {
+		case VHOST_RDMA_COMPST_GET_ACK:
+			if (rte_ring_dequeue(qp->resp_pkts, (void **)&mbuf) == 0) {
+				pkt = MBUF_TO_PKT(mbuf);
+				qp->comp.timeout_retry = 0;
+			} else {
+				mbuf = NULL;
+			}
+			state = VHOST_RDMA_COMPST_GET_WQE;
+			break;
+
+		case VHOST_RDMA_COMPST_GET_WQE:
+			state = vhost_rdma_get_wqe(qp, pkt, &wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_CHECK_PSN:
+			state = vhost_rdma_check_psn(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_CHECK_ACK:
+			state = vhost_rdma_check_ack(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_READ:
+			state = vhost_rdma_do_read(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_ATOMIC:
+			state = vhost_rdma_do_atomic(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_WRITE_SEND:
+			if (wqe && wqe->state == WQE_STATE_PENDING &&
+				wqe->last_psn == pkt->psn)
+				state = VHOST_RDMA_COMPST_COMP_ACK;
+			else
+				state = VHOST_RDMA_COMPST_UPDATE_COMP;
+			break;
+
+		case VHOST_RDMA_COMPST_COMP_ACK:
+			state = vhost_rdma_complete_ack(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_COMP_WQE:
+			state = vhost_rdma_complete_wqe(qp, pkt, wqe);
+			break;
+
+		case VHOST_RDMA_COMPST_UPDATE_COMP:
+			if (pkt->mask & VHOST_END_MASK)
+				qp->comp.opcode = -1;
+			else
+				qp->comp.opcode = pkt->opcode;
+
+			if (psn_compare(pkt->psn, qp->comp.psn) >= 0)
+				qp->comp.psn = (pkt->psn + 1) & VHOST_RDMA_PSN_MASK;
+
+			if (qp->req.wait_psn) {
+				qp->req.wait_psn = 0;
+				vhost_rdma_run_task(&qp->req.task, 1);
+			}
+			state = VHOST_RDMA_COMPST_DONE;
+			break;
+
+		case VHOST_RDMA_COMPST_DONE:
+			goto done;
+
+		case VHOST_RDMA_COMPST_EXIT:
+			if (qp->comp.timeout_retry && wqe) {
+				state = VHOST_RDMA_COMPST_ERROR_RETRY;
+				break;
+			}
+
+			/* Restart retransmit timer if conditions met */
+			if ((qp->type == VHOST_RDMA_IB_QPT_RC) &&
+				(qp->req.state == QP_STATE_READY) &&
+				(psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
+				qp->qp_timeout_ticks) {
+				rte_timer_reset(&qp->retrans_timer,
+						qp->qp_timeout_ticks,
+						SINGLE, rte_lcore_id(),
+						retransmit_timer, qp);
+			}
+			ret = -EAGAIN;
+			goto done;
+
+		case VHOST_RDMA_COMPST_ERROR_RETRY:
+			if (!wqe || wqe->state == WQE_STATE_POSTED)
+				goto done;
+
+			if (qp->comp.started_retry && !qp->comp.timeout_retry)
+				goto done;
+
+			if (qp->comp.retry_cnt > 0) {
+				if (qp->comp.retry_cnt != 7)
+					qp->comp.retry_cnt--;
+
+				if (psn_compare(qp->req.psn, qp->comp.psn) > 0) {
+					vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_COMP_RETRY);
+					qp->req.need_retry = 1;
+					qp->comp.started_retry = 1;
+					vhost_rdma_run_task(&qp->req.task, 0);
+				}
+				goto done;
+			} else {
+				vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_RETRY_EXCEEDED);
+				wqe->status = VHOST_RDMA_IB_WC_RETRY_EXC_ERR;
+				state = VHOST_RDMA_COMPST_ERROR;
+			}
+			break;
+
+		case VHOST_RDMA_COMPST_RNR_RETRY:
+			if (qp->comp.rnr_retry > 0) {
+				if (qp->comp.rnr_retry != 7)
+					qp->comp.rnr_retry--;
+
+				qp->req.need_retry = 1;
+				RDMA_LOG_DEBUG_DP("QP#%d setting RNR NAK timer", qp->qpn);
+				rte_timer_reset(&qp->rnr_nak_timer,
+						rnrnak_ticks(aeth_syn(pkt) & ~AETH_TYPE_MASK),
+						SINGLE, rte_lcore_id(),
+						vhost_rdma_rnr_nak_timer, qp);
+				ret = -EAGAIN;
+				goto done;
+			} else {
+				vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_RNR_RETRY_EXCEEDED);
+				wqe->status = VHOST_RDMA_IB_WC_RNR_RETRY_EXC_ERR;
+				state = VHOST_RDMA_COMPST_ERROR;
+			}
+			break;
+
+		case VHOST_RDMA_COMPST_ERROR:
+			RDMA_LOG_ERR_DP("WQE Error: %u", wqe->status);
+			vhost_rdma_do_complete(qp, wqe);
+			vhost_rdma_qp_error(qp);
+			ret = -EAGAIN;
+			goto done;
+		}
+	}
+
+done:
+	if (pkt)
+		free_pkt(pkt);
+	vhost_rdma_drop_ref(qp, dev, qp);
+
+	return ret;
+}
diff --git a/examples/vhost_user_rdma/vhost_rdma_opcode.h b/examples/vhost_user_rdma/vhost_rdma_opcode.h
index 6c3660f36b..0c2961d5cd 100644
--- a/examples/vhost_user_rdma/vhost_rdma_opcode.h
+++ b/examples/vhost_user_rdma/vhost_rdma_opcode.h
@@ -27,28 +27,28 @@
 #include "vhost_rdma_pkt.h"
 
 /** Maximum number of QP types supported for WR mask dispatching */
-#define WR_MAX_QPT                  8
+#define WR_MAX_QPT					8
 
 /** Total number of defined opcodes (must be power-of-2 >= 256) */
-#define VHOST_NUM_OPCODE            256
+#define VHOST_NUM_OPCODE			256
 
 #ifndef BIT
 	#define BIT(x)	(1 << (x))
 #endif
 
 /* Invalid opcode marker */
-#define OPCODE_NONE                 (-1)
+#define OPCODE_NONE				(-1)
 
 #define VHOST_RDMA_SE_MASK		(0x80)
 #define VHOST_RDMA_MIG_MASK		(0x40)
 #define VHOST_RDMA_PAD_MASK		(0x30)
-#define VHOST_RDMA_TVER_MASK		(0x0f)
-#define VHOST_RDMA_FECN_MASK		(0x80000000)
-#define VHOST_RDMA_BECN_MASK		(0x40000000)
-#define VHOST_RDMA_RESV6A_MASK		(0x3f000000)
+#define VHOST_RDMA_TVER_MASK	(0x0f)
+#define VHOST_RDMA_FECN_MASK	(0x80000000)
+#define VHOST_RDMA_BECN_MASK	(0x40000000)
+#define VHOST_RDMA_RESV6A_MASK	(0x3f000000)
 #define VHOST_RDMA_QPN_MASK		(0x00ffffff)
 #define VHOST_RDMA_ACK_MASK		(0x80000000)
-#define VHOST_RDMA_RESV7_MASK		(0x7f000000)
+#define VHOST_RDMA_RESV7_MASK	(0x7f000000)
 #define VHOST_RDMA_PSN_MASK		(0x00ffffff)
 
 /**
@@ -56,19 +56,19 @@
  * @{
  */
 enum vhost_rdma_hdr_type {
-    VHOST_RDMA_LRH,           /**< Link Layer Header (InfiniBand only) */
-    VHOST_RDMA_GRH,           /**< Global Route Header (IPv6-style GIDs) */
-    VHOST_RDMA_BTH,           /**< Base Transport Header */
-    VHOST_RDMA_RETH,          /**< RDMA Extended Transport Header */
-    VHOST_RDMA_AETH,          /**< Acknowledge/Error Header */
-    VHOST_RDMA_ATMETH,        /**< Atomic Operation Request Header */
-    VHOST_RDMA_ATMACK,        /**< Atomic Operation Response Header */
-    VHOST_RDMA_IETH,          /**< Immediate Data + Error Code Header */
-    VHOST_RDMA_RDETH,         /**< Reliable Datagram Extended Transport Header */
-    VHOST_RDMA_DETH,          /**< Datagram Endpoint Identifier Header */
-    VHOST_RDMA_IMMDT,         /**< Immediate Data Header */
-    VHOST_RDMA_PAYLOAD,       /**< Payload section */
-    NUM_HDR_TYPES             /**< Number of known header types */
+	VHOST_RDMA_LRH,			/**< Link Layer Header (InfiniBand only) */
+	VHOST_RDMA_GRH,			/**< Global Route Header (IPv6-style GIDs) */
+	VHOST_RDMA_BTH,			/**< Base Transport Header */
+	VHOST_RDMA_RETH,		/**< RDMA Extended Transport Header */
+	VHOST_RDMA_AETH,		/**< Acknowledge/Error Header */
+	VHOST_RDMA_ATMETH,		/**< Atomic Operation Request Header */
+	VHOST_RDMA_ATMACK,		/**< Atomic Operation Response Header */
+	VHOST_RDMA_IETH,		/**< Immediate Data + Error Code Header */
+	VHOST_RDMA_RDETH,		/**< Reliable Datagram Extended Transport Header */
+	VHOST_RDMA_DETH,		/**< Datagram Endpoint Identifier Header */
+	VHOST_RDMA_IMMDT,		/**< Immediate Data Header */
+	VHOST_RDMA_PAYLOAD,		/**< Payload section */
+	NUM_HDR_TYPES			/**< Number of known header types */
 };
 
 /**
@@ -76,50 +76,50 @@ enum vhost_rdma_hdr_type {
  * @{
  */
 enum vhost_rdma_hdr_mask {
-    VHOST_LRH_MASK            = BIT(VHOST_RDMA_LRH),
-    VHOST_GRH_MASK            = BIT(VHOST_RDMA_GRH),
-    VHOST_BTH_MASK            = BIT(VHOST_RDMA_BTH),
-    VHOST_IMMDT_MASK          = BIT(VHOST_RDMA_IMMDT),
-    VHOST_RETH_MASK           = BIT(VHOST_RDMA_RETH),
-    VHOST_AETH_MASK           = BIT(VHOST_RDMA_AETH),
-    VHOST_ATMETH_MASK         = BIT(VHOST_RDMA_ATMETH),
-    VHOST_ATMACK_MASK         = BIT(VHOST_RDMA_ATMACK),
-    VHOST_IETH_MASK           = BIT(VHOST_RDMA_IETH),
-    VHOST_RDETH_MASK          = BIT(VHOST_RDMA_RDETH),
-    VHOST_DETH_MASK           = BIT(VHOST_RDMA_DETH),
-    VHOST_PAYLOAD_MASK        = BIT(VHOST_RDMA_PAYLOAD),
-
-    /* Semantic packet type flags */
-    VHOST_REQ_MASK            = BIT(NUM_HDR_TYPES + 0),  /**< Request packet */
-    VHOST_ACK_MASK            = BIT(NUM_HDR_TYPES + 1),  /**< ACK/NACK packet */
-    VHOST_SEND_MASK           = BIT(NUM_HDR_TYPES + 2),  /**< Send operation */
-    VHOST_WRITE_MASK          = BIT(NUM_HDR_TYPES + 3),  /**< RDMA Write */
-    VHOST_READ_MASK           = BIT(NUM_HDR_TYPES + 4),  /**< RDMA Read */
-    VHOST_ATOMIC_MASK         = BIT(NUM_HDR_TYPES + 5),  /**< Atomic operation */
-
-    /* Packet fragmentation flags */
-    VHOST_RWR_MASK            = BIT(NUM_HDR_TYPES + 6),  /**< RDMA with Immediate + Invalidate */
-    VHOST_COMP_MASK           = BIT(NUM_HDR_TYPES + 7),  /**< Completion required */
-
-    VHOST_START_MASK          = BIT(NUM_HDR_TYPES + 8),  /**< First fragment */
-    VHOST_MIDDLE_MASK         = BIT(NUM_HDR_TYPES + 9),  /**< Middle fragment */
-    VHOST_END_MASK            = BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
-
-    VHOST_LOOPBACK_MASK       = BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
-
-    /* Composite masks */
-    VHOST_READ_OR_ATOMIC      = (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
-    VHOST_WRITE_OR_SEND       = (VHOST_WRITE_MASK | VHOST_SEND_MASK),
+	VHOST_LRH_MASK			= BIT(VHOST_RDMA_LRH),
+	VHOST_GRH_MASK			= BIT(VHOST_RDMA_GRH),
+	VHOST_BTH_MASK			= BIT(VHOST_RDMA_BTH),
+	VHOST_IMMDT_MASK		= BIT(VHOST_RDMA_IMMDT),
+	VHOST_RETH_MASK			= BIT(VHOST_RDMA_RETH),
+	VHOST_AETH_MASK			= BIT(VHOST_RDMA_AETH),
+	VHOST_ATMETH_MASK		= BIT(VHOST_RDMA_ATMETH),
+	VHOST_ATMACK_MASK		= BIT(VHOST_RDMA_ATMACK),
+	VHOST_IETH_MASK			= BIT(VHOST_RDMA_IETH),
+	VHOST_RDETH_MASK		= BIT(VHOST_RDMA_RDETH),
+	VHOST_DETH_MASK			= BIT(VHOST_RDMA_DETH),
+	VHOST_PAYLOAD_MASK		= BIT(VHOST_RDMA_PAYLOAD),
+
+	/* Semantic packet type flags */
+	VHOST_REQ_MASK			= BIT(NUM_HDR_TYPES + 0),	/**< Request packet */
+	VHOST_ACK_MASK			= BIT(NUM_HDR_TYPES + 1),	/**< ACK/NACK packet */
+	VHOST_SEND_MASK			= BIT(NUM_HDR_TYPES + 2),	/**< Send operation */
+	VHOST_WRITE_MASK		= BIT(NUM_HDR_TYPES + 3),	/**< RDMA Write */
+	VHOST_READ_MASK			= BIT(NUM_HDR_TYPES + 4),	/**< RDMA Read */
+	VHOST_ATOMIC_MASK		= BIT(NUM_HDR_TYPES + 5),	/**< Atomic operation */
+
+	/* Packet fragmentation flags */
+	VHOST_RWR_MASK			= BIT(NUM_HDR_TYPES + 6),	/**< RDMA with Immediate + Invalidate */
+	VHOST_COMP_MASK			= BIT(NUM_HDR_TYPES + 7),	/**< Completion required */
+
+	VHOST_START_MASK		= BIT(NUM_HDR_TYPES + 8),	/**< First fragment */
+	VHOST_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),	/**< Middle fragment */
+	VHOST_END_MASK			= BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
+
+	VHOST_LOOPBACK_MASK		= BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
+
+	/* Composite masks */
+	VHOST_READ_OR_ATOMIC	= (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
+	VHOST_WRITE_OR_SEND		= (VHOST_WRITE_MASK | VHOST_SEND_MASK),
 };
 
 /**
  * @brief Per-opcode metadata for parsing and validation
  */
 struct vhost_rdma_opcode_info {
-    const char *name;                             /**< Opcode name (e.g., "RC SEND_FIRST") */
-    int length;                                   /**< Fixed payload length (if any) */
-    int offset[NUM_HDR_TYPES];                    /**< Offset of each header within packet */
-    enum vhost_rdma_hdr_mask mask;                /**< Header presence and semantic flags */
+	const char *name;				/**< Opcode name (e.g., "RC SEND_FIRST") */
+	int length;						/**< Fixed payload length (if any) */
+	int offset[NUM_HDR_TYPES];		/**< Offset of each header within packet */
+	enum vhost_rdma_hdr_mask mask;	/**< Header presence and semantic flags */
 };
 
 /* Global opcode info table (indexed by IB opcode byte) */
@@ -146,8 +146,8 @@ static inline uint8_t bth_pad(struct vhost_rdma_pkt_info *pkt)
 }
 
 struct vhost_deth {
-	rte_be32_t			qkey;
-	rte_be32_t			sqp;
+	rte_be32_t		qkey;
+	rte_be32_t		sqp;
 };
 
 #define GSI_QKEY		(0x80010000)
@@ -206,7 +206,7 @@ static inline void deth_set_sqp(struct vhost_rdma_pkt_info *pkt, uint32_t sqp)
 }
 
 struct vhost_immdt {
-	rte_be32_t			imm;
+	rte_be32_t	imm;
 };
 
 static inline rte_be32_t __immdt_imm(void *arg)
@@ -236,9 +236,9 @@ static inline void immdt_set_imm(struct vhost_rdma_pkt_info *pkt, rte_be32_t imm
 }
 
 struct vhost_reth {
-	rte_be64_t			va;
-	rte_be32_t			rkey;
-	rte_be32_t			len;
+	rte_be64_t	va;
+	rte_be32_t	rkey;
+	rte_be32_t	len;
 };
 
 static inline uint64_t __reth_va(void *arg)
@@ -323,35 +323,65 @@ struct vhost_aeth {
 	rte_be32_t			smsn;
 };
 
+#define AETH_SYN_MASK		(0xff000000)
+#define AETH_MSN_MASK		(0x00ffffff)
+
+enum aeth_syndrome {
+	AETH_TYPE_MASK		= 0xe0,
+	AETH_ACK			= 0x00,
+	AETH_RNR_NAK		= 0x20,
+	AETH_RSVD			= 0x40,
+	AETH_NAK			= 0x60,
+	AETH_ACK_UNLIMITED	= 0x1f,
+	AETH_NAK_PSN_SEQ_ERROR	= 0x60,
+	AETH_NAK_INVALID_REQ	= 0x61,
+	AETH_NAK_REM_ACC_ERR	= 0x62,
+	AETH_NAK_REM_OP_ERR	= 0x63,
+	AETH_NAK_INV_RD_REQ	= 0x64,
+};
+
+static inline uint8_t __aeth_syn(void *arg)
+{
+	struct vhost_aeth *aeth = arg;
+
+	return (AETH_SYN_MASK & rte_be_to_cpu_32(aeth->smsn)) >> 24;
+}
+
+static inline uint8_t aeth_syn(struct vhost_rdma_pkt_info *pkt)
+{
+	return __aeth_syn(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_AETH]);
+}
+
 struct vhost_atmack {
-	rte_be64_t			orig;
+	rte_be64_t	orig;
 };
 
 struct vhost_atmeth {
-	rte_be64_t			va;
-	rte_be32_t			rkey;
-	rte_be64_t			swap_add;
-	rte_be64_t			comp;
+	rte_be64_t	va;
+	rte_be32_t	rkey;
+	rte_be64_t	swap_add;
+	rte_be64_t	comp;
 } __rte_packed;
 
 struct vhost_ieth {
-	rte_be32_t			rkey;
+	rte_be32_t	rkey;
 };
 
 struct vhost_rdeth {
-	rte_be32_t			een;
+	rte_be32_t	een;
 };
 
 enum vhost_rdma_hdr_length {
-	VHOST_BTH_BYTES	    	= sizeof(struct vhost_bth),
-	VHOST_DETH_BYTES		= sizeof(struct vhost_deth),
-	VHOST_IMMDT_BYTES		= sizeof(struct vhost_immdt),
-	VHOST_RETH_BYTES		= sizeof(struct vhost_reth),
-	VHOST_AETH_BYTES		= sizeof(struct vhost_aeth),
-	VHOST_ATMACK_BYTES	    = sizeof(struct vhost_atmack),
-	VHOST_ATMETH_BYTES  	= sizeof(struct vhost_atmeth),
-	VHOST_IETH_BYTES		= sizeof(struct vhost_ieth),
-	VHOST_RDETH_BYTES		= sizeof(struct vhost_rdeth),
+	VHOST_BTH_BYTES		= sizeof(struct vhost_bth),
+	VHOST_DETH_BYTES	= sizeof(struct vhost_deth),
+	VHOST_IMMDT_BYTES	= sizeof(struct vhost_immdt),
+	VHOST_RETH_BYTES	= sizeof(struct vhost_reth),
+	VHOST_AETH_BYTES	= sizeof(struct vhost_aeth),
+	VHOST_ATMACK_BYTES	= sizeof(struct vhost_atmack),
+	VHOST_ATMETH_BYTES	= sizeof(struct vhost_atmeth),
+	VHOST_IETH_BYTES	= sizeof(struct vhost_ieth),
+	VHOST_RDETH_BYTES	= sizeof(struct vhost_rdeth),
 };
 
 /**
@@ -360,8 +390,8 @@ enum vhost_rdma_hdr_length {
  * Expands to e.g.: `IB_OPCODE_RC_SEND_FIRST = IB_OPCODE_RC + IB_OPCODE_SEND_FIRST`
  */
 #define IB_OPCODE(transport, op) \
-    IB_OPCODE_ ## transport ## _ ## op = \
-        (IB_OPCODE_ ## transport + IB_OPCODE_ ## op)
+	IB_OPCODE_ ## transport ## _ ## op = \
+		(IB_OPCODE_ ## transport + IB_OPCODE_ ## op)
 
 /**
  * @defgroup ib_opcodes InfiniBand OpCode Definitions
@@ -371,105 +401,105 @@ enum vhost_rdma_hdr_length {
  */
 
 enum {
-    /* Transport types (base values) */
-    IB_OPCODE_RC                                = 0x00,  /**< Reliable Connection */
-    IB_OPCODE_UC                                = 0x20,  /**< Unreliable Connection */
-    IB_OPCODE_RD                                = 0x40,  /**< Reliable Datagram */
-    IB_OPCODE_UD                                = 0x60,  /**< Unreliable Datagram */
-    IB_OPCODE_CNP                               = 0x80,  /**< Congestion Notification Packet */
-    IB_OPCODE_MSP                               = 0xe0,  /**< Manufacturer Specific Protocol */
-
-    /* Operation subtypes */
-    IB_OPCODE_SEND_FIRST                        = 0x00,
-    IB_OPCODE_SEND_MIDDLE                       = 0x01,
-    IB_OPCODE_SEND_LAST                         = 0x02,
-    IB_OPCODE_SEND_LAST_WITH_IMMEDIATE          = 0x03,
-    IB_OPCODE_SEND_ONLY                         = 0x04,
-    IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE          = 0x05,
-    IB_OPCODE_RDMA_WRITE_FIRST                  = 0x06,
-    IB_OPCODE_RDMA_WRITE_MIDDLE                 = 0x07,
-    IB_OPCODE_RDMA_WRITE_LAST                   = 0x08,
-    IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE    = 0x09,
-    IB_OPCODE_RDMA_WRITE_ONLY                   = 0x0a,
-    IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE    = 0x0b,
-    IB_OPCODE_RDMA_READ_REQUEST                 = 0x0c,
-    IB_OPCODE_RDMA_READ_RESPONSE_FIRST          = 0x0d,
-    IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE         = 0x0e,
-    IB_OPCODE_RDMA_READ_RESPONSE_LAST           = 0x0f,
-    IB_OPCODE_RDMA_READ_RESPONSE_ONLY           = 0x10,
-    IB_OPCODE_ACKNOWLEDGE                       = 0x11,
-    IB_OPCODE_ATOMIC_ACKNOWLEDGE                = 0x12,
-    IB_OPCODE_COMPARE_SWAP                      = 0x13,
-    IB_OPCODE_FETCH_ADD                         = 0x14,
-    /* 0x15 is reserved */
-    IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
-    IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
-
-    /* Real opcodes generated via IB_OPCODE() macro */
-    IB_OPCODE(RC, SEND_FIRST),
-    IB_OPCODE(RC, SEND_MIDDLE),
-    IB_OPCODE(RC, SEND_LAST),
-    IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(RC, SEND_ONLY),
-    IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
-    IB_OPCODE(RC, RDMA_WRITE_FIRST),
-    IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
-    IB_OPCODE(RC, RDMA_WRITE_LAST),
-    IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(RC, RDMA_WRITE_ONLY),
-    IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-    IB_OPCODE(RC, RDMA_READ_REQUEST),
-    IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
-    IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
-    IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
-    IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
-    IB_OPCODE(RC, ACKNOWLEDGE),
-    IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
-    IB_OPCODE(RC, COMPARE_SWAP),
-    IB_OPCODE(RC, FETCH_ADD),
-    IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
-    IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
-
-    /* UC opcodes */
-    IB_OPCODE(UC, SEND_FIRST),
-    IB_OPCODE(UC, SEND_MIDDLE),
-    IB_OPCODE(UC, SEND_LAST),
-    IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(UC, SEND_ONLY),
-    IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
-    IB_OPCODE(UC, RDMA_WRITE_FIRST),
-    IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
-    IB_OPCODE(UC, RDMA_WRITE_LAST),
-    IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(UC, RDMA_WRITE_ONLY),
-    IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-
-    /* RD opcodes */
-    IB_OPCODE(RD, SEND_FIRST),
-    IB_OPCODE(RD, SEND_MIDDLE),
-    IB_OPCODE(RD, SEND_LAST),
-    IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(RD, SEND_ONLY),
-    IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
-    IB_OPCODE(RD, RDMA_WRITE_FIRST),
-    IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
-    IB_OPCODE(RD, RDMA_WRITE_LAST),
-    IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-    IB_OPCODE(RD, RDMA_WRITE_ONLY),
-    IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-    IB_OPCODE(RD, RDMA_READ_REQUEST),
-    IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
-    IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
-    IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
-    IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
-    IB_OPCODE(RD, ACKNOWLEDGE),
-    IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
-    IB_OPCODE(RD, COMPARE_SWAP),
-    IB_OPCODE(RD, FETCH_ADD),
-
-    /* UD opcodes */
-    IB_OPCODE(UD, SEND_ONLY),
-    IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+	/* Transport types (base values) */
+	IB_OPCODE_RC								= 0x00,	/**< Reliable Connection */
+	IB_OPCODE_UC								= 0x20,	/**< Unreliable Connection */
+	IB_OPCODE_RD								= 0x40,	/**< Reliable Datagram */
+	IB_OPCODE_UD								= 0x60,	/**< Unreliable Datagram */
+	IB_OPCODE_CNP								= 0x80,	/**< Congestion Notification Packet */
+	IB_OPCODE_MSP								= 0xe0,	/**< Manufacturer Specific Protocol */
+
+	/* Operation subtypes */
+	IB_OPCODE_SEND_FIRST						= 0x00,
+	IB_OPCODE_SEND_MIDDLE						= 0x01,
+	IB_OPCODE_SEND_LAST						 = 0x02,
+	IB_OPCODE_SEND_LAST_WITH_IMMEDIATE			= 0x03,
+	IB_OPCODE_SEND_ONLY						 = 0x04,
+	IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE			= 0x05,
+	IB_OPCODE_RDMA_WRITE_FIRST					= 0x06,
+	IB_OPCODE_RDMA_WRITE_MIDDLE				 = 0x07,
+	IB_OPCODE_RDMA_WRITE_LAST					= 0x08,
+	IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE	= 0x09,
+	IB_OPCODE_RDMA_WRITE_ONLY					= 0x0a,
+	IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE	= 0x0b,
+	IB_OPCODE_RDMA_READ_REQUEST				 = 0x0c,
+	IB_OPCODE_RDMA_READ_RESPONSE_FIRST			= 0x0d,
+	IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE		 = 0x0e,
+	IB_OPCODE_RDMA_READ_RESPONSE_LAST			= 0x0f,
+	IB_OPCODE_RDMA_READ_RESPONSE_ONLY			= 0x10,
+	IB_OPCODE_ACKNOWLEDGE						= 0x11,
+	IB_OPCODE_ATOMIC_ACKNOWLEDGE				= 0x12,
+	IB_OPCODE_COMPARE_SWAP						= 0x13,
+	IB_OPCODE_FETCH_ADD						 = 0x14,
+	/* 0x15 is reserved */
+	IB_OPCODE_SEND_LAST_WITH_INVALIDATE		 = 0x16,
+	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE		 = 0x17,
+
+	/* Real opcodes generated via IB_OPCODE() macro */
+	IB_OPCODE(RC, SEND_FIRST),
+	IB_OPCODE(RC, SEND_MIDDLE),
+	IB_OPCODE(RC, SEND_LAST),
+	IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, SEND_ONLY),
+	IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_FIRST),
+	IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RC, RDMA_WRITE_LAST),
+	IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_READ_REQUEST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RC, ACKNOWLEDGE),
+	IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RC, COMPARE_SWAP),
+	IB_OPCODE(RC, FETCH_ADD),
+	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
+	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+
+	/* UC opcodes */
+	IB_OPCODE(UC, SEND_FIRST),
+	IB_OPCODE(UC, SEND_MIDDLE),
+	IB_OPCODE(UC, SEND_LAST),
+	IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, SEND_ONLY),
+	IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_FIRST),
+	IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(UC, RDMA_WRITE_LAST),
+	IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+
+	/* RD opcodes */
+	IB_OPCODE(RD, SEND_FIRST),
+	IB_OPCODE(RD, SEND_MIDDLE),
+	IB_OPCODE(RD, SEND_LAST),
+	IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, SEND_ONLY),
+	IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_FIRST),
+	IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RD, RDMA_WRITE_LAST),
+	IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_READ_REQUEST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RD, ACKNOWLEDGE),
+	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RD, COMPARE_SWAP),
+	IB_OPCODE(RD, FETCH_ADD),
+
+	/* UD opcodes */
+	IB_OPCODE(UD, SEND_ONLY),
+	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
 };
 /** @} */
 
@@ -478,17 +508,17 @@ enum {
  * @{
  */
 enum vhost_rdma_wr_mask {
-    WR_INLINE_MASK              = BIT(0),   /**< WR contains inline data */
-    WR_ATOMIC_MASK              = BIT(1),   /**< WR is an atomic operation */
-    WR_SEND_MASK                = BIT(2),   /**< WR is a send-type operation */
-    WR_READ_MASK                = BIT(3),   /**< WR initiates RDMA read */
-    WR_WRITE_MASK               = BIT(4),   /**< WR performs RDMA write */
-    WR_LOCAL_OP_MASK            = BIT(5),   /**< WR triggers local memory op */
-
-    WR_READ_OR_WRITE_MASK       = WR_READ_MASK | WR_WRITE_MASK,
-    WR_READ_WRITE_OR_SEND_MASK  = WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
-    WR_WRITE_OR_SEND_MASK       = WR_WRITE_MASK | WR_SEND_MASK,
-    WR_ATOMIC_OR_READ_MASK      = WR_ATOMIC_MASK | WR_READ_MASK,
+	WR_INLINE_MASK				= BIT(0),	/**< WR contains inline data */
+	WR_ATOMIC_MASK				= BIT(1),	/**< WR is an atomic operation */
+	WR_SEND_MASK				= BIT(2),	/**< WR is a send-type operation */
+	WR_READ_MASK				= BIT(3),	/**< WR initiates RDMA read */
+	WR_WRITE_MASK				= BIT(4),	/**< WR performs RDMA write */
+	WR_LOCAL_OP_MASK			= BIT(5),	/**< WR triggers local memory op */
+
+	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
+	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
+	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
+	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
 };
 
 /**
@@ -497,8 +527,8 @@ enum vhost_rdma_wr_mask {
  * Used to determine which operations are valid per QP type.
  */
 struct vhost_rdma_wr_opcode_info {
-    const char *name;                         /**< Human-readable name */
-    enum vhost_rdma_wr_mask mask[WR_MAX_QPT]; /**< Validity per QP type */
+	const char *name;						 /**< Human-readable name */
+	enum vhost_rdma_wr_mask mask[WR_MAX_QPT]; /**< Validity per QP type */
 };
 
 /* Extern declaration of global opcode metadata table */
@@ -510,8 +540,21 @@ static inline unsigned int wr_opcode_mask(int opcode, struct vhost_rdma_qp *qp)
 	return vhost_rdma_wr_opcode_info[opcode].mask[qp->type];
 }
 
+static inline uint64_t __atmack_orig(void *arg)
+{
+	struct vhost_atmack *atmack = arg;
+
+	return rte_be_to_cpu_64(atmack->orig);
+}
+
+static inline uint64_t atmack_orig(struct vhost_rdma_pkt_info *pkt)
+{
+	return __atmack_orig(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_ATMACK]);
+}
+
 int vhost_rdma_next_opcode(struct vhost_rdma_qp *qp, 
-					       struct vhost_rdma_send_wqe *wqe,
-		       		       uint32_t opcode);
+							struct vhost_rdma_send_wqe *wqe,
+								uint32_t opcode);
 
 #endif
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.c b/examples/vhost_user_rdma/vhost_rdma_queue.c
index 7d0c45592c..5f9f7fd3c7 100644
--- a/examples/vhost_user_rdma/vhost_rdma_queue.c
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.c
@@ -1388,12 +1388,6 @@ int vhost_rdma_requester(void *arg)
 	return -EAGAIN;
 }
 
-int vhost_rdma_completer(void* arg)
-{
-	//TODO: handle complete
-	return 0;
-}
-
 int vhost_rdma_responder(void* arg)
 {
 	//TODO: handle response
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.h b/examples/vhost_user_rdma/vhost_rdma_queue.h
index fb5a90235f..d8af86cdf2 100644
--- a/examples/vhost_user_rdma/vhost_rdma_queue.h
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.h
@@ -24,6 +24,11 @@
 #include "vhost_rdma.h"
 #include "vhost_rdma_log.h"
 
+#define PKT_TO_MBUF(p) ((struct rte_mbuf *) \
+			(RTE_PTR_SUB(p, sizeof(struct rte_mbuf))))
+#define MBUF_TO_PKT(m) ((struct vhost_rdma_pkt_info *) \
+			(RTE_PTR_ADD(m, sizeof(struct rte_mbuf))))
+
 #define QP_OPCODE_INVAILD (-1)
 
 /******************************************************************************
-- 
2.43.0


