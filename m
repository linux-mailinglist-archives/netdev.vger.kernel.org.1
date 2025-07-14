Return-Path: <netdev+bounces-206519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB74B0354A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B393B8E61
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEADD1F418F;
	Mon, 14 Jul 2025 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="I/XaKqPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187571FA15E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468345; cv=none; b=Xn2Iz+0mTDeOXyCnUIqmRkoShghwMJMNdbyZjrnLdBNu3zQf+0qSESO1MDDraKOwdtzFzX3oCcJM7sMWl0rKZUMGg7fTZRzbPbQdO0fo1N87KtND3nG/JcotdwYhh4yB4ZNlkACN1QjjVqaA7fHBMeRKymGqzmEmxLV2Sjkd3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468345; c=relaxed/simple;
	bh=4cUaH8fwLHSIRgkdNsip9Od//gGF7R7ZdBYmuiuxsik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuig46EHVBq+U1MK1EDginOio/H6P8w9TDnG7u07skx3qUvumspniXjwjf1+vntwvaP5OuYBk2sLfcyCI4+A3++eY73hwRdzbAfkEdB8ABF7rL1fK61hi7Bix83URQWzjmOlNHYXk5/bh8ezpmEOPNxzKpb/NGwBWSc//nCOZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=I/XaKqPv; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bgrgxZSlxrDEOsffBx6GztQFsx1XYQ/UHvr2P34Bwg4=; t=1752468344; x=1753332344; 
	b=I/XaKqPveNB9kxmq04ea2JvApynpfazEgL1E85UJPYVLm3JcwyDQ6kf91S/5Q/f9Bi08pDvBAh5
	qpxBXvE8Gn/Yk3z2AkqdJNMyYKe/N5LgnC52ai5lTb6UattmPtb5kJQNsTq1uQGT0WLvyiY2dZkup
	nCZ32vhFBEh5ku7ScoBQHvWdp+aDMl8tnpgzxswb+2JL+csXbz6+hhLkfy7j12UawS6FWMkBjONfo
	j4E2pRpHdvOssaZOF0FLxiJEpXe5xQKIlm0F2cHK/oH1migYHCKT5Auq6z/Kt4HKBhPa+Dy0t/OLH
	5E0Nm+o1FG+NnEpZJaOl2YPCrddN5J70dGSQ==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:63266 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ubB4Q-00080i-Rd; Sun, 13 Jul 2025 21:45:43 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 13/15] net: homa: create homa_timer.c
Date: Sun, 13 Jul 2025 21:44:45 -0700
Message-ID: <20250714044448.254-14-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250714044448.254-1-ouster@cs.stanford.edu>
References: <20250714044448.254-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 5db651a2cb4a9bde5cb99e1d094eeb0a

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v11:
* Cleanup sparse annotations.

Changes for v10:
* Refactor resend mechanism

Changes for v9:
* Reflect changes in socket and peer management
* Minor name changes for clarity

Changes for v7:
* Interface changes to homa_sock_start_scan etc.
* Remove locker argument from locking functions
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h  |   3 +
 net/homa/homa_timer.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 068b46a90a62..b2ff854b6c5c 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -409,6 +409,9 @@ void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
 			 struct homa_sock *hsk);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
 void     homa_spin(int ns);
+void     homa_timer(struct homa *homa);
+void     homa_timer_check_rpc(struct homa_rpc *rpc);
+int      homa_timer_main(void *transport);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..0de4de709460
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,135 @@
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
+ * homa_timer_check_rpc() -  Invoked for each RPC during each timer pass; does
+ * most of the work of checking for time-related actions such as sending
+ * resends, aborting RPCs for which there is no response, and sending
+ * requests for acks. It is separate from homa_timer because homa_timer
+ * got too long and deeply indented.
+ * @rpc:     RPC to check; must be locked by the caller.
+ */
+void homa_timer_check_rpc(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa *homa = rpc->hsk->homa;
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
+			== 0)
+		homa_request_retrans(rpc);
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
+	int rpc_count = 0;
+
+	homa->timer_ticks++;
+
+	/* Scan all existing RPCs in all sockets. */
+	for (hsk = homa_socktab_start_scan(homa->socktab, &scan);
+			hsk; hsk = homa_socktab_next(&scan)) {
+		while (hsk->dead_skbs >= homa->dead_buffs_limit)
+			/* If we get here, it means that Homa isn't keeping
+			 * up with RPC reaping, so we'll help out.  See
+			 * "RPC Reaping Strategy" in homa_rpc_reap code for
+			 * details.
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
+			homa_rpc_lock(rpc);
+			if (rpc->state == RPC_IN_SERVICE) {
+				rpc->silent_ticks = 0;
+				homa_rpc_unlock(rpc);
+				continue;
+			}
+			rpc->silent_ticks++;
+			homa_timer_check_rpc(rpc);
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
+	homa_peer_gc(homa->peertab);
+}
-- 
2.43.0


