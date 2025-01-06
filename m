Return-Path: <netdev+bounces-155570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596BA02F91
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B2C1651D8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C81DFD9B;
	Mon,  6 Jan 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="DoOos6Gc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4E1DF993
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187206; cv=none; b=r9yJPY6po4TPwtkDKlmmDDUuat/5rTYb4ZUHOG6mR0j6ekWkA2q/1JCfaHC9398gJL/B0xuAI0g9P1+SqH41HXIh6We2g0MqnHuQfe9BAyDOx+u/undTNWIFvdmrZRzPU2YMXtSGq9MvERgiStNAdHFsq9elu8c6cvPnWvmps30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187206; c=relaxed/simple;
	bh=gemtKFqpbN02AixCvKhoKwebhMaJ/w70WxMAuc2aaXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbLq9Q5drCVpLrgosRrYiJhcW02OlCVsJ6FwCM1NWaJj/17v9KmHzspcn3aAmH1gIikqNq5uRz4NQA3qzWusemTeOJGq26JKzViQP7XwVJVknw5Lb/0qJXREOV1wm+2AIPKbp6uVX8P7tYxEUSwqVv5gVeAkfmfm/y0JqwGYj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=DoOos6Gc; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PINGEPwAwBzSkH8Ous7f1eTQxMzvz1ZIhQ+q/ulMA40=; t=1736187204; x=1737051204; 
	b=DoOos6GcHtWjhgwWqTlYB2i0CS4MAIXniaPaFXR4hxTVvrhGx7AXP58t6qPmFqqkh/oTtJsNqmo
	sz2nI7KPU6I1AlQX/InJmrxhj7dEu0tCX/k9m+rG96exmg9uhk7LUFpnbKulWlgT++yipl8AtzAF5
	clMA7yIru2DlZ6I8PjtQ1gqPdBqMrUDYxOWUlDEsKEkoA36dPdO6XwoHUi9iK3UwKAhGXjkyqMyAt
	0QIBJdTiSuhQGeOWRg0RNmcQ45ssiziANO7feOLD/MW+Kd+47X/Gyne6/fdiazMoeggJe/ppdxpXr
	o3YhtmxGiLhhtyy5m1M+wjyabKHRjYKFM+nA==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:59627 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tUrbP-0003Bs-R8; Mon, 06 Jan 2025 10:13:24 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v5 10/12] net: homa: create homa_timer.c
Date: Mon,  6 Jan 2025 10:12:16 -0800
Message-ID: <20250106181219.1075-11-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250106181219.1075-1-ouster@cs.stanford.edu>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 72fea6e5439bae575da00cf3f782b6e6

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_timer.c | 157 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..1b67846d510f
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,157 @@
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
+	homa_socktab_end_scan(&scan);
+	rcu_read_unlock();
+}
-- 
2.34.1


