Return-Path: <netdev+bounces-139678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0869B3CE5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7077FB21BA3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590271E22E6;
	Mon, 28 Oct 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="snMO7nk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089931EE00F
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151386; cv=none; b=DtZ3CLexEo6M8vCrmGTPLlN8qS/UO/7NLKl3P5jbf2LFvNXOooVxpdcMP/Jx4nHnfr7XlN72ruURsGHJXZ5/5HYXir1BfnGcS3vVODZfYhlU/Heud1eDgy2ntyG/a1C/JMUeYbakp1GdM7UabZfuFMPiWdhfPBtfwawiFrHIhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151386; c=relaxed/simple;
	bh=P6t3xzWi/gWSVvJ49SLmYgfY1Z1X4R6tRCbS5Ilj/Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLgRSmDqRfDxDBMccWpLQh9QM22nkLkbZdAMVPoHdVI04j2K3Amo1rQY+pbAbHwyjUctRC9lQNCz+3BJuRjdk/Yhtk96vBs2M1+kDczoVK6GonndeVMEzE4EOLNs/wm5cm5jfLKe5ZW6Mreps6EI2qh2PCdkMTw3CR7JKjxAM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=snMO7nk5; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CnwDCQWkPH0K+jB7tLLOeVecnM9nTUcy9BLIZuTMeMY=; t=1730151384; x=1731015384; 
	b=snMO7nk5slAjZj2OGc62f1Bp414IEKCHqFGLNqlnmNWYstBAWZ4iICdRTa5x25eOx9aGgFO6atn
	PgH/MPdhDcsYr7IvB61Ayx5EW/LHZqM+Ah25oEmrG29t4UlUw8LydCTU9Ws4G54Pop/M1mOl7+i0Z
	jfqZtNdj4DR6goVXNEdeUjlDewMeKQE1BBpG6mGoPsnQM2KmOeBWejSTpCoxtzbIhHfUTfRfPGt4W
	iLAmc0WsaNOGtalLdHU9LFHoZoCrH2HnXC5j7cvdEyza/T9P4UtamW4OdMXVFllWbvc7PEeZSFFgq
	DzRppeB5I+UR5hp6MjptXqmjNCTZzkmNZ9QQ==;
Received: from ouster2016.stanford.edu ([172.24.72.71]:54106 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t5XPS-0005xj-Vp; Mon, 28 Oct 2024 14:36:23 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next 10/12] net: homa: create homa_timer.c
Date: Mon, 28 Oct 2024 14:35:37 -0700
Message-ID: <20241028213541.1529-11-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241028213541.1529-1-ouster@cs.stanford.edu>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 8d916073a6e03d0ab55799977e12a57e

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_timer.c | 158 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..bce7c02bb1cd
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file handles timing-related functions for Homa, such as retries
+ * and timeouts.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+
+/**
+ * homa_check_rpc() -  Invoked for each RPC during each timer pass; does
+ * most of the work of checking for time-related actions such as sending
+ * resends, aborting RPCs for which there is no response, and sending
+ * requests for acks. It is separate from homa_timer because homa_timer
+ * got too long and deeply indented.
+ * @rpc:     RPC to check; must be locked by the caller.
+ */
+void homa_check_rpc(struct homa_rpc *rpc)
+{
+	struct homa *homa = rpc->hsk->homa;
+	struct resend_header resend;
+
+	/* See if we need to request an ack for this RPC. */
+	if (!homa_is_client(rpc->id) && rpc->state == RPC_OUTGOING &&
+	    rpc->msgout.next_xmit_offset >= rpc->msgout.length) {
+		if (rpc->done_timer_ticks == 0) {
+			rpc->done_timer_ticks = homa->timer_ticks;
+		} else {
+			/* >= comparison that handles tick wrap-around. */
+			if ((rpc->done_timer_ticks + homa->request_ack_ticks
+					- 1 - homa->timer_ticks) & 1 << 31) {
+				struct need_ack_header h;
+
+				homa_xmit_control(NEED_ACK, &h, sizeof(h), rpc);
+			}
+		}
+	}
+
+	if (rpc->state == RPC_INCOMING) {
+		if (rpc->msgin.num_bpages == 0) {
+			/* Waiting for buffer space, so no problem. */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	} else if (!homa_is_client(rpc->id)) {
+		/* We're the server and we've received the input message;
+		 * no need to worry about retries.
+		 */
+		rpc->silent_ticks = 0;
+		return;
+	}
+
+	if (rpc->state == RPC_OUTGOING) {
+		if (rpc->msgout.next_xmit_offset < rpc->msgout.length) {
+			/* There are bytes that we haven't transmitted,
+			 * so no need to be concerned; the ball is in our court.
+			 */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	}
+
+	if (rpc->silent_ticks < homa->resend_ticks)
+		return;
+	if (rpc->silent_ticks >= homa->timeout_ticks) {
+		homa_rpc_abort(rpc, -ETIMEDOUT);
+		return;
+	}
+	if (((rpc->silent_ticks - homa->resend_ticks) % homa->resend_interval)
+			!= 0)
+		return;
+
+	/* Issue a resend for the bytes just after the last ones received
+	 * (gaps in the middle were already handled by homa_gap_retry above).
+	 */
+	if (rpc->msgin.length < 0) {
+		/* Haven't received any data for this message; request
+		 * retransmission of just the first packet (the sender
+		 * will send at least one full packet, regardless of
+		 * the length below).
+		 */
+		resend.offset = htonl(0);
+		resend.length = htonl(100);
+	} else {
+		homa_gap_retry(rpc);
+		resend.offset = htonl(rpc->msgin.recv_end);
+		resend.length = htonl(rpc->msgin.length - rpc->msgin.recv_end);
+		if (resend.length == 0)
+			return;
+	}
+	homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
+}
+
+/**
+ * homa_timer() - This function is invoked at regular intervals ("ticks")
+ * to implement retries and aborts for Homa.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_timer(struct homa *homa)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+	struct homa_rpc *rpc;
+	int total_rpcs = 0;
+	int rpc_count = 0;
+
+	homa->timer_ticks++;
+
+	/* Scan all existing RPCs in all sockets.  The rcu_read_lock
+	 * below prevents sockets from being deleted during the scan.
+	 */
+	rcu_read_lock();
+	for (hsk = homa_socktab_start_scan(homa->port_map, &scan);
+			hsk; hsk = homa_socktab_next(&scan)) {
+		while (hsk->dead_skbs >= homa->dead_buffs_limit)
+			/* If we get here, it means that homa_wait_for_message
+			 * isn't keeping up with RPC reaping, so we'll help
+			 * out.  See reap.txt for more info.
+			 */
+			if (homa_rpc_reap(hsk, hsk->homa->reap_limit) == 0)
+				break;
+
+		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
+			continue;
+
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			total_rpcs++;
+			homa_rpc_lock(rpc, "homa_timer");
+			if (rpc->state == RPC_IN_SERVICE) {
+				rpc->silent_ticks = 0;
+				homa_rpc_unlock(rpc);
+				continue;
+			}
+			rpc->silent_ticks++;
+			homa_check_rpc(rpc);
+			homa_rpc_unlock(rpc);
+			rpc_count++;
+			if (rpc_count >= 10) {
+				/* Give other kernel threads a chance to run
+				 * on this core. Must release the RCU read lock
+				 * while doing this.
+				 */
+				rcu_read_unlock();
+				schedule();
+				rcu_read_lock();
+				rpc_count = 0;
+			}
+		}
+		homa_unprotect_rpcs(hsk);
+	}
+	rcu_read_unlock();
+
+//	if (total_rpcs > 0)
+//		tt_record1("homa_timer finished scanning %d RPCs", total_rpcs);
+}
-- 
2.34.1


