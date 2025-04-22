Return-Path: <netdev+bounces-184921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918EA97B5F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D58177131
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E821C16E;
	Tue, 22 Apr 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hgimGChY"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B50215160;
	Tue, 22 Apr 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365928; cv=none; b=Id0Ah2w33I4qt1qk11dnjF2/05mkTe1D6F5alE2JaRtXF0GNgHqGCZveAblfBeIhYFxJn1yydCtMpIrHTFRYxiayNXNwWk9uYBnjn/mNjBXGQcyMdxAA9JPzalMFdbpPjdl3ddP2QL5w3WHyKYT8cZj5NzUddmID/HmprkCbh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365928; c=relaxed/simple;
	bh=IKd+z45KHPynbqhXPNDIBcgAPl1PU2QsOXeUwlI7E0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfKbFkA1JK5Si5uDLVXsLnyUcn5UVru0FY2oJH265/uX1AUwfRYH+Ugw+zHQTNzaXWO2RlB4h+Aev8aYw1BrmC5HncyEQIbQaUqYA8Kw3uxoWxc1h3+NrlhAeuw9ee4SWit2vbHdGHtCf7cuyWo0NJGraWAUrTQxU5Xqv3RqcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hgimGChY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VilT9XDvLQXBLLBfiH0Gyi/0dFwIoLcpzrL6/PGti1w=; b=hgimGChYxFktyhbr
	6Tf668i7LCiFiNh7qJ4v9uLdlRrIo+3tGBDlD3gfq9Fnp9IJljHJLRT9Mw/Ry8ElUoZ5kBxcuZX5T
	V/kxV/oivK34W0zxAemtWrUos4Fu3/ZVDvjcAK10VW9rPWmAxix/oa8aaDF/6elbO06J6mIt6mlLR
	NJ8tRbzpHguAjXPKiKqQRJ3Sx4a4ggVNEk1MwnU9e/aWTRUHabe+dyRTRFuUD1BX/rcKzSZNJqCoA
	z7YUBWXBT89kH2iqUx8RM3O8v6QWrxhzugekHpOyEhyR6XqxinIQToWCwokda9MfNdLTzauFpxfsq
	PgqhUhHAb8cXDazK6A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u7NP2-00DCSP-1U;
	Tue, 22 Apr 2025 23:51:48 +0000
From: linux@treblig.org
To: horms@kernel.org,
	dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2] rxrpc: Remove deadcode
Date: Wed, 23 Apr 2025 00:51:47 +0100
Message-ID: <20250422235147.146460-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove three functions that are no longer used.

rxrpc_get_txbuf() last use was removed by 2020's
commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
local processor work")

rxrpc_kernel_get_epoch() last use was removed by 2020's
commit 44746355ccb1 ("afs: Don't get epoch from a server because it may be
ambiguous")

rxrpc_kernel_set_max_life() last use was removed by 2023's
commit db099c625b13 ("rxrpc: Fix timeout of a call that hasn't yet been
granted a channel")

Both of the rxrpc_kernel_* functions were documented.  Remove that
documentation as well as the code.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
v2 rebase on top of net-next 45bd443bfd86

 Documentation/networking/rxrpc.rst | 24 -----------------
 include/net/af_rxrpc.h             |  3 ---
 net/rxrpc/af_rxrpc.c               | 41 ------------------------------
 net/rxrpc/ar-internal.h            |  1 -
 net/rxrpc/txbuf.c                  |  8 ------
 5 files changed, 77 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index fe2ea73be441..d63e3e27dd06 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -1062,30 +1062,6 @@ The kernel interface functions are as follows:
      first function to change.  Note that this must be called in TASK_RUNNING
      state.
 
- (#) Get remote client epoch::
-
-	u32 rxrpc_kernel_get_epoch(struct socket *sock,
-				   struct rxrpc_call *call)
-
-     This allows the epoch that's contained in packets of an incoming client
-     call to be queried.  This value is returned.  The function always
-     successful if the call is still in progress.  It shouldn't be called once
-     the call has expired.  Note that calling this on a local client call only
-     returns the local epoch.
-
-     This value can be used to determine if the remote client has been
-     restarted as it shouldn't change otherwise.
-
- (#) Set the maximum lifespan on a call::
-
-	void rxrpc_kernel_set_max_life(struct socket *sock,
-				       struct rxrpc_call *call,
-				       unsigned long hard_timeout)
-
-     This sets the maximum lifespan on a call to hard_timeout (which is in
-     jiffies).  In the event of the timeout occurring, the call will be
-     aborted and -ETIME or -ETIMEDOUT will be returned.
-
  (#) Apply the RXRPC_MIN_SECURITY_LEVEL sockopt to a socket from within in the
      kernel::
 
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index f15341594cc8..0fb4c41c9bbf 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -88,9 +88,6 @@ int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
 			       unsigned int debug_id);
 void rxrpc_kernel_set_tx_length(struct socket *, struct rxrpc_call *, s64);
 bool rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
-u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
-void rxrpc_kernel_set_max_life(struct socket *, struct rxrpc_call *,
-			       unsigned long);
 
 int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
 int rxrpc_sock_set_security_keyring(struct sock *, struct key *);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 3a558c1a541e..36df0274d7b7 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -460,22 +460,6 @@ bool rxrpc_kernel_check_life(const struct socket *sock,
 }
 EXPORT_SYMBOL(rxrpc_kernel_check_life);
 
-/**
- * rxrpc_kernel_get_epoch - Retrieve the epoch value from a call.
- * @sock: The socket the call is on
- * @call: The call to query
- *
- * Allow a kernel service to retrieve the epoch value from a service call to
- * see if the client at the other end rebooted.
- *
- * Return: The epoch of the call's connection.
- */
-u32 rxrpc_kernel_get_epoch(struct socket *sock, struct rxrpc_call *call)
-{
-	return call->conn->proto.epoch;
-}
-EXPORT_SYMBOL(rxrpc_kernel_get_epoch);
-
 /**
  * rxrpc_kernel_set_notifications - Set table of callback operations
  * @sock: The socket to install table upon
@@ -492,31 +476,6 @@ void rxrpc_kernel_set_notifications(struct socket *sock,
 }
 EXPORT_SYMBOL(rxrpc_kernel_set_notifications);
 
-/**
- * rxrpc_kernel_set_max_life - Set maximum lifespan on a call
- * @sock: The socket the call is on
- * @call: The call to configure
- * @hard_timeout: The maximum lifespan of the call in ms
- *
- * Set the maximum lifespan of a call.  The call will end with ETIME or
- * ETIMEDOUT if it takes longer than this.
- */
-void rxrpc_kernel_set_max_life(struct socket *sock, struct rxrpc_call *call,
-			       unsigned long hard_timeout)
-{
-	ktime_t delay = ms_to_ktime(hard_timeout), expect_term_by;
-
-	mutex_lock(&call->user_mutex);
-
-	expect_term_by = ktime_add(ktime_get_real(), delay);
-	WRITE_ONCE(call->expect_term_by, expect_term_by);
-	trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_hard);
-	rxrpc_poke_call(call, rxrpc_call_poke_set_timeout);
-
-	mutex_unlock(&call->user_mutex);
-}
-EXPORT_SYMBOL(rxrpc_kernel_set_max_life);
-
 /*
  * connect an RxRPC socket
  * - this just targets it at a specific destination; no actual connection
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ca62a1db3286..5bd3922c310d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1503,7 +1503,6 @@ static inline void rxrpc_sysctl_exit(void) {}
 extern atomic_t rxrpc_nr_txbuf;
 struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_size,
 					   size_t data_align, gfp_t gfp);
-void rxrpc_get_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 void rxrpc_put_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what);
 
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index c550991d48fa..29767038691a 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -60,14 +60,6 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 	return txb;
 }
 
-void rxrpc_get_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
-{
-	int r;
-
-	__refcount_inc(&txb->ref, &r);
-	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, r + 1, what);
-}
-
 void rxrpc_see_txbuf(struct rxrpc_txbuf *txb, enum rxrpc_txbuf_trace what)
 {
 	int r = refcount_read(&txb->ref);
-- 
2.49.0


