Return-Path: <netdev+bounces-209848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED431B11107
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB38E3AAE33
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7BF2ECE9D;
	Thu, 24 Jul 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="T3Ns7/vk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AB2ECEB5
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382495; cv=none; b=rWU0FQ5zwH8FeBHV202U5U/jYGuj/ExOacqHVOiYRq+GFwRpn2V2rDMqfCxjGyY0+YEekbyErUQNdIeQIm9l4qhZ5oKAqOSN6rBygZNJ82a9vv0TNJRzV1Vx5F2SuYdpd/XtVlaCOOzi9mU9I+uhhM89jbkKsnohcbMASCBFrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382495; c=relaxed/simple;
	bh=716+HLsGqOulI8nN5MHmWLKSIfSeV5oEicGON7F2YiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phCCW4E4PwhNnhlkNAW5PQaRzEcB6FXUHeUs4JmNul08GkM8ddXNkQk+STesSBRgj/YePxYGY5GybfVFWuo8BP7tfbdqEKjmeIAJ+ZfZpPUALOz8FDirKn/u2IcTG5xNTUQa92cJ0QYh1lPeOixZASN+XGNz/ZaZLL1yUgTMCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=T3Ns7/vk; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GhWsXpcVSmE6OVT8EfldCDVdJNOQcu1iaPe7Dok5pPc=; t=1753382493; x=1754246493; 
	b=T3Ns7/vk0fbPrZA5vFKlplpVGFkC3Ut1Fxh6Mdi93oW6rr6l5hXBhjz94gJx5jTr4jXbuO+h+wp
	Fl321qxf/ODUts2IATyOiFSlgLjfnahj1uORncrx8jXrsD2si5dkP30tx0rjvTh7YNC3zUxAMfF8q
	o+u0vheTDrOvx3CdEIYjRszQehzJLKohLcb3u5EAKibt/3b+4jjtU6lePR8tXNm+S9eVtu/SFWjr0
	FaP40x4bEWGznx5CM9DowEJZI/qZe7Tcsix8wf1+mULELQ7LmdLY/D1RX4UTQ1TkmONEefb0Q8kf3
	c1AAnnmQV8onO+c9aszCHsvzKKQmqpPrJ1Bw==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:55641 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uf0sl-0006eP-3S; Thu, 24 Jul 2025 11:41:31 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v12 07/15] net: homa: create homa_interest.h and homa_interest.c
Date: Thu, 24 Jul 2025 11:40:40 -0700
Message-ID: <20250724184050.3130-8-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250724184050.3130-1-ouster@cs.stanford.edu>
References: <20250724184050.3130-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: d3a99d2b3b32688373268ce224509287

These files implement the homa_interest struct, which is used to
wait for incoming messages.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v11:
* Clean up sparse annotations

Changes for v10: none

Changes for v9:
* Remove unused field homa_interest->core
---
 net/homa/homa_interest.c | 121 +++++++++++++++++++++++++++++++++++++++
 net/homa/homa_interest.h |  96 +++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 net/homa/homa_interest.c
 create mode 100644 net/homa/homa_interest.h

diff --git a/net/homa/homa_interest.c b/net/homa/homa_interest.c
new file mode 100644
index 000000000000..42df499f12a2
--- /dev/null
+++ b/net/homa/homa_interest.c
@@ -0,0 +1,121 @@
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
+ * homa_interest_init_shared() - Initialize an interest and queue it up on
+ * a socket.
+ * @interest:  Interest to initialize
+ * @hsk:       Socket on which the interests should be queued. Must be locked
+ *             by caller.
+ */
+void homa_interest_init_shared(struct homa_interest *interest,
+			       struct homa_sock *hsk)
+	__must_hold(hsk->lock)
+{
+	interest->rpc = NULL;
+	atomic_set(&interest->ready, 0);
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
+	__must_hold(rpc->bucket->lock)
+{
+	if (rpc->private_interest)
+		return -EINVAL;
+
+	interest->rpc = rpc;
+	atomic_set(&interest->ready, 0);
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
+	__must_hold(rpc->bucket->lock)
+{
+	if (rpc->private_interest) {
+		atomic_set_release(&rpc->private_interest->ready, 1);
+		wake_up(&rpc->private_interest->wait_queue);
+	}
+}
+
diff --git a/net/homa/homa_interest.h b/net/homa/homa_interest.h
new file mode 100644
index 000000000000..ad0c697a2949
--- /dev/null
+++ b/net/homa/homa_interest.h
@@ -0,0 +1,96 @@
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
+ * struct homa_interest - Holds info that allows applications to wait for
+ * incoming RPC messages. An interest can be either private, in which case
+ * the application is waiting for a single specific RPC response and the
+ * interest is referenced by an rpc->private_interest, or shared, in which
+ * case the application is waiting for any incoming message that isn't
+ * private and the interest is present on hsk->interests.
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
+	__must_hold(interest->rpc->bucket->lock)
+{
+	if (interest == interest->rpc->private_interest)
+		interest->rpc->private_interest = NULL;
+}
+
+void     homa_interest_init_shared(struct homa_interest *interest,
+				   struct homa_sock *hsk);
+int      homa_interest_init_private(struct homa_interest *interest,
+				    struct homa_rpc *rpc);
+void     homa_interest_notify_private(struct homa_rpc *rpc);
+int      homa_interest_wait(struct homa_interest *interest, int nonblocking);
+
+#endif /* _HOMA_INTEREST_H */
-- 
2.43.0


