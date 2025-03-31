Return-Path: <netdev+bounces-178458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53EA77183
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED9188DE07
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AE21D5AE;
	Mon, 31 Mar 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="MUl0iJ0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D721CC5D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464839; cv=none; b=etvnqHgcRTR6enjdhm8wp5IESmAknrI4l/2nVttuswlyzjprvHP8UIjKUkIdZ7NdRxRooLVFyyO+JH8LVBpycSJX7j2hIWhT2zqzBQiIzZvgNyjwb+cbAr5t8ZH8f8fwXSEJq16opDBzmsdPDB0S1Vk9JEGtClxwesR9yppneJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464839; c=relaxed/simple;
	bh=+7wy52JFJz2iGkzohzl0QsMPyxYPwDw+eDzdANgulYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He0QROBom7r+8D4bO0vLBtcYVL6UPDzAx22RERHgyFJ6uiJm0pdQWcedMB4Lq9CfCnD+A2vmIjwiIX8bfkNq3pXJkB3cWm5h0hB/iPyRHgsZBBejjjbXDHGG4Nvow/J+tXMMYi1vlvFPLD1l5AmEY1a810RpRcrXKCSQS6ubY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=MUl0iJ0C; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HhzZDNZoa82e1VI3CNfmv70tsZJPo9n8fRfzUySLwXo=; t=1743464837; x=1744328837; 
	b=MUl0iJ0C8RnkRWeD05nGlcPFyxo5gK/sNbd8pDXRwVSugxA8d04XTqL6A0ABu9FUCBVQaNKF+5q
	peY0Pc+JpKPuUxDi2xMjBTSV0WGNx4itP1xeDqnBafcwun5ms5b1tDEFl9xV7uqI6A7FNENdBRItB
	1be7uwN9iJwWynVeQfhRU9RJpspN5QxNr/U7SyUVzVNGjD6qOT1qrqke8RaZZKBPyeQ52MvYI5FM9
	wZ+FwFIEVZ7CM4PIRSz4HuxOAseu5K0l8BdkKoG5vJCDT3OJ1y6BeOclX4vM6vsL6dThycdHjvNN9
	Ck1tOLskS4aA0iHZ0FvrsnISASAGZUQRrjog==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqa-000219-Cq; Mon, 31 Mar 2025 16:47:17 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 12/14] net: homa: create homa_timer.c
Date: Mon, 31 Mar 2025 16:45:45 -0700
Message-ID: <20250331234548.62070-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250331234548.62070-1-ouster@cs.stanford.edu>
References: <20250331234548.62070-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: bf2d39bfc2650c7e8471b46ddb5f48c6

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v7:
* Interface changes to homa_sock_start_scan etc.
* Remove locker argument from locking functions
* Use u64 and __u64 properly
---
 net/homa/homa_timer.c | 155 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..abce2760a107
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file handles timing-related functions for Homa, such as retries
+ * and timeouts.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_stub.h"
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
+	struct homa_resend_hdr resend;
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
+				struct homa_need_ack_hdr h;
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
+			/* There are granted bytes that we haven't transmitted,
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
+	/* Scan all existing RPCs in all sockets. */
+	for (hsk = homa_socktab_start_scan(homa->port_map, &scan);
+			hsk; hsk = homa_socktab_next(&scan)) {
+		while (hsk->dead_skbs >= homa->dead_buffs_limit)
+			/* If we get here, it means that homa_wait_for_message
+			 * isn't keeping up with RPC reaping, so we'll help
+			 * out.  See reap.txt for more info.
+			 */
+			if (homa_rpc_reap(hsk, false) == 0)
+				break;
+
+		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
+			continue;
+
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		rcu_read_lock();
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			total_rpcs++;
+			homa_rpc_lock(rpc);
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
+				 * on this core.
+				 */
+				rcu_read_unlock();
+				schedule();
+				rcu_read_lock();
+				rpc_count = 0;
+			}
+		}
+		rcu_read_unlock();
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+	homa_skb_release_pages(homa);
+}
-- 
2.34.1


