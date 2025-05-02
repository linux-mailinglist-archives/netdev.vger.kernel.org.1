Return-Path: <netdev+bounces-187546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2AAA7D5E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED79A189D7BE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A922D79D;
	Fri,  2 May 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="dyciaWhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BE22CBE2
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229094; cv=none; b=WsRsBziJ20YdhsEBi7AoYZqArJdAldKwRCNqJgcqfGJHhg5tLBHDghNoickUg3p/qimdLHKrVQJ2SsLsuQPfeYZuII9K8pTwRgVoCdjGL16W+Gcwc/mae3nVnoWssO74OTWb5ThGYReVUPkaZ6ygOHFEEyNGPZhrl9YkmT1Xgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229094; c=relaxed/simple;
	bh=MvuNMuAlMG23UAquDIbnqH5UcCOXvYKxgxVsfe8oB9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7rTknl1Vxd25jva4L4bVRlXpxyoOv1V7kD315Fw+iURhEIOYZH6M3Cmnm9uErMYJfVStiz1zLHRcT4Y31Bja3p4NVSMsZn/RejFWkNJ4RPKF0zLaWRcc10PKVF7PJtPiTAYxcqtg8p7D9X++hOJqfoj2pWRdD57A6lnfPSPwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=dyciaWhV; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6r/TW6gsYpRQYwFuMh0tHkVLMYUNlKJ1ucQirQ+FrA0=; t=1746229092; x=1747093092; 
	b=dyciaWhVSLBlW06F6c4Cc27xm+s4SY0SveBsdNrfeGyQ3tl23HMSU5AQWIZjpHc1mej5ABhYtAd
	zNCVRFSDl+4npIVxRQPR1zWB99JvhIPUdOmFBRpd6xKEtDAySxXvI7DpOM83cspyqXCGMs3xEtXBX
	M2b5+hZX1ikMmwBmiVno5ULEsb355F89ZSVpudwRVjANQBvaAdgVrIhTclfsLlTOt+4CYit+XrFQE
	BFY+drFyArcdhgnlvUORpmgh3do6JsjKp/jlSWWF44IrUQuAucBloC/YvtMtYQgtBgA6v8BGMuahE
	QJGfe8QVRy/KBrTEVBZlMPr+Vk2GvSAnJ6Xg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:64199 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uAzxL-0007if-CQ; Fri, 02 May 2025 16:38:12 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v8 07/15] net: homa: create homa_interest.h and homa_interest.
Date: Fri,  2 May 2025 16:37:20 -0700
Message-ID: <20250502233729.64220-8-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250502233729.64220-1-ouster@cs.stanford.edu>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 1085a1c2809627baa475b583c0169231

These files implement the homa_interest struct, which is used to
wait for incoming messages.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_interest.c | 122 +++++++++++++++++++++++++++++++++++++++
 net/homa/homa_interest.h | 100 ++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 net/homa/homa_interest.c
 create mode 100644 net/homa/homa_interest.h

diff --git a/net/homa/homa_interest.c b/net/homa/homa_interest.c
new file mode 100644
index 000000000000..71bf70d7073b
--- /dev/null
+++ b/net/homa/homa_interest.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains functions for managing homa_interest structs. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_rpc.h"
+#include "homa_sock.h"
+
+/**
+ * homa_interest_init_shared() - Initialize an interest and queue it up on a socket.
+ * @interest:  Interest to initialize
+ * @hsk:       Socket on which the interests should be queued. Must be locked
+ *             by caller.
+ */
+void homa_interest_init_shared(struct homa_interest *interest,
+			       struct homa_sock *hsk)
+	__must_hold(&hsk->lock)
+{
+	interest->rpc = NULL;
+	atomic_set(&interest->ready, 0);
+	interest->core = raw_smp_processor_id();
+	interest->blocked = 0;
+	init_waitqueue_head(&interest->wait_queue);
+	interest->hsk = hsk;
+	list_add(&interest->links, &hsk->interests);
+}
+
+/**
+ * homa_interest_init_private() - Initialize an interest that will wait
+ * on a particular (private) RPC, and link it to that RPC.
+ * @interest:   Interest to initialize.
+ * @rpc:        RPC to associate with the interest. Must be private, and
+ *              caller must have locked it.
+ *
+ * Return:      0 for success, otherwise a negative errno.
+ */
+int homa_interest_init_private(struct homa_interest *interest,
+			       struct homa_rpc *rpc)
+	__must_hold(&rpc->bucket->lock)
+{
+	if (rpc->private_interest)
+		return -EINVAL;
+
+	interest->rpc = rpc;
+	atomic_set(&interest->ready, 0);
+	interest->core = raw_smp_processor_id();
+	interest->blocked = 0;
+	init_waitqueue_head(&interest->wait_queue);
+	interest->hsk = rpc->hsk;
+	rpc->private_interest = interest;
+	return 0;
+}
+
+/**
+ * homa_interest_wait() - Wait for an interest to have an actionable RPC,
+ * or for an error to occur.
+ * @interest:     Interest to wait for; must previously have been initialized
+ *                and linked to a socket or RPC. On return, the interest
+ *                will have been unlinked if its ready flag is set; otherwise
+ *                it may still be linked.
+ * @nonblocking:  Nonzero means return without blocking if the interest
+ *                doesn't become ready immediately.
+ *
+ * Return: 0 for success (there is an actionable RPC in the interest), or
+ * a negative errno.
+ */
+int homa_interest_wait(struct homa_interest *interest, int nonblocking)
+{
+	struct homa_sock *hsk = interest->hsk;
+	int result = 0;
+	int iteration;
+	int wait_err;
+
+	interest->blocked = 0;
+
+	/* This loop iterates in order to poll and/or reap dead RPCS. */
+	for (iteration = 0; ; iteration++) {
+		if (iteration != 0)
+			/* Give NAPI/SoftIRQ tasks a chance to run. */
+			schedule();
+
+		if (atomic_read_acquire(&interest->ready) != 0)
+			goto done;
+
+		/* See if we can cleanup dead RPCs while waiting. */
+		if (homa_rpc_reap(hsk, false) != 0)
+			continue;
+
+		if (nonblocking) {
+			result = -EAGAIN;
+			goto done;
+		}
+
+		break;
+	}
+
+	interest->blocked = 1;
+	wait_err = wait_event_interruptible_exclusive(interest->wait_queue,
+			atomic_read_acquire(&interest->ready) != 0);
+	if (wait_err == -ERESTARTSYS)
+		result = -EINTR;
+
+done:
+	return result;
+}
+
+/**
+ * homa_interest_notify_private() - If a thread is waiting on the private
+ * interest for an RPC, wake it up.
+ * @rpc:      RPC that may (potentially) have a private interest. Must be
+ *            locked by the caller.
+ */
+void homa_interest_notify_private(struct homa_rpc *rpc)
+	__must_hold(&rpc->bucket->lock)
+{
+	if (rpc->private_interest) {
+		atomic_set_release(&rpc->private_interest->ready, 1);
+		wake_up(&rpc->private_interest->wait_queue);
+	}
+}
+
diff --git a/net/homa/homa_interest.h b/net/homa/homa_interest.h
new file mode 100644
index 000000000000..78111bf68b6c
--- /dev/null
+++ b/net/homa/homa_interest.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines struct homa_interest and related functions.  */
+
+#ifndef _HOMA_INTEREST_H
+#define _HOMA_INTEREST_H
+
+#include "homa_rpc.h"
+#include "homa_sock.h"
+
+/**
+ * struct homa_interest - Used by homa_wait_private and homa_wait_shared to
+ * wait for incoming message data to arrive for an RPC. An interest can
+ * be either private (if referenced by an rpc->private_interest) or shared
+ * (if present on hsk->interests).
+ */
+struct homa_interest {
+	/**
+	 * @rpc: If ready is set, then this holds an RPC that needs
+	 * attention, or NULL if this is a shared interest and hsk has
+	 * been shutdown. If ready is not set, this will be NULL if the
+	 * interest is shared; if it's private, it holds the RPC the
+	 * interest is associated with. If non-NULL, a reference has been
+	 * taken on the RPC.
+	 */
+	struct homa_rpc *rpc;
+
+	/**
+	 * @ready: Nonzero means the interest is ready for attention: either
+	 * there is an RPC that needs attention or @hsk has been shutdown.
+	 */
+	atomic_t ready;
+
+	/**
+	 * @core: Core on which homa_wait_*was invoked.  This is a hint
+	 * used for load balancing (see balance.txt).
+	 */
+	int core;
+
+	/**
+	 * @blocked: Zero means a handoff was received without the thread
+	 * needing to block; nonzero means the thread blocked.
+	 */
+	int blocked;
+
+	/**
+	 * @wait_queue: Used to block the thread while waiting (will never
+	 * have more than one queued thread).
+	 */
+	struct wait_queue_head wait_queue;
+
+	/** @hsk: Socket that the interest is associated with. */
+	struct homa_sock *hsk;
+
+	/**
+	 * @links: If the interest is shared, used to link this object into
+	 * @hsk->interests.
+	 */
+	struct list_head links;
+};
+
+/**
+ * homa_interest_unlink_shared() - Remove an interest from the list for a
+ * socket. Note: this can race with homa_rpc_handoff, so on return it's
+ * possible that the interest is ready.
+ * @interest:    Interest to remove. Must have been initialized with
+ *               homa_interest_init_shared.
+ */
+static inline void homa_interest_unlink_shared(struct homa_interest *interest)
+{
+	if (!list_empty(&interest->links)) {
+		homa_sock_lock(interest->hsk);
+		list_del_init(&interest->links);
+		homa_sock_unlock(interest->hsk);
+	}
+}
+
+/**
+ * homa_interest_unlink_private() - Detach a private interest from its
+ * RPC. Note: this can race with homa_rpc_handoff, so on return it's
+ * possible that the interest is ready.
+ * @interest:    Interest to remove. Must have been initialized with
+ *               homa_interest_init_private. Its RPC must be locked by
+ *               the caller.
+ */
+static inline void homa_interest_unlink_private(struct homa_interest *interest)
+	__must_hold(&interest->rpc->bucket->lock)
+{
+	if (interest == interest->rpc->private_interest)
+		interest->rpc->private_interest = NULL;
+}
+
+void     homa_interest_init_shared(struct homa_interest *interest,
+	struct homa_sock *hsk);
+int      homa_interest_init_private(struct homa_interest *interest,
+				    struct homa_rpc *rpc);
+void     homa_interest_notify_private(struct homa_rpc *rpc);
+int      homa_interest_wait(struct homa_interest *interest, int nonblocking);
+
+#endif /* _HOMA_INTEREST_H */
-- 
2.43.0


