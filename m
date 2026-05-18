Return-Path: <netdev+bounces-289154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AOwNoFcC2ppGAUAu9opvQ
	(envelope-from <netdev+bounces-289154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:37:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E95725DB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707CB3065EBF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151034BA42;
	Mon, 18 May 2026 18:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB038B7AA;
	Mon, 18 May 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129269; cv=none; b=cZh8qCaaxRR8cfevsH6r/UdwxAyY6KyEq5Ft2G1o+D8MDIIMZeICcaJOKlw2J111wJj2oUBWcX69SsxCi03vXuST3+tys9IsafvLEwZpLaMmq0INqCV17BqqZFdPY44IE2Ae9bX9Nu4V6r0DpmMffG6MWYqH5Wnu/LopbPRaryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129269; c=relaxed/simple;
	bh=t81xk1GMOcGxUt+jDZ0yUGChoEIYX6sNI7OC+beV18U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nffk+JocwUaMb6dr4AlbTwFGN94a1Szvse7iGvtpSnEaNl5EEynnCwxPrpj/Ch2W2IDyYgVZZxazYiMlz6/lOc0jWV1MWgaL2OvarQBxlbZG8QwhiiZ7jD5BoCR5QmpOR32d/DwHYhYDFetefExkiA3V5AHyu3BPKG/9Hs8mhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 65CAF5A061C; Mon, 18 May 2026 20:34:24 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jon Maloy <jmaloy@redhat.com>,
	Dmitry Safonov <dima@arista.com>,
	Andrei Vagin <avagin@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 1/2] tcp: Don't accept data when socket is in repair mode
Date: Mon, 18 May 2026 20:34:23 +0200
Message-ID: <20260518183424.3144867-2-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518183424.3144867-1-sbrivio@redhat.com>
References: <20260518183424.3144867-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289154-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 919E95725DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once a socket enters repair mode (TCP_REPAIR socket option with
TCP_REPAIR_ON value), it's possible to dump the receive sequence
number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
(using TCP_REPAIR_QUEUE to select it).

If we receive data after the application fetched the sequence number
or saved the contents of the queue, though, the application will now
have outdated information, which defeats the whole functionality,
because this leads to gaps in sequence and data once they're restored
by the target instance of the application, resulting in a hanging or
otherwise non-functional TCP connection.

This type of race condition was discovered in the KubeVirt integration
of passt(1), using a remote iperf3 client connected to an iperf3
server running in the guest which is being migrated. The setup allows
traffic to reach the origin node hosting the guest during the
migration.

If passt dumps sequence number and contents of the queue *before*
further data is received and acknowledged to the peer by the kernel,
once the TCP data connection is migrated to the target node, the
remote client becomes unable to continue sending, because a portion
of the data it sent *and received an acknowledgement for* is now lost.

Schematically:

1. client --seq 1:100--> origin host --> passt --> guest --> server

2. client <--ACK: 100-- origin host

3. migration starts, passt enables repair mode, dumps the sequence
   number (101) and sends it to the target node of the guest migration

4. client --seq 101:201--> origin host (passt not receiving anymore)

5. client <--ACK: 201-- origin host

6. migration completes, and passt restores sequence number 101 on the
   migrated socket

7. client --seq 201:301--> target host (now seeing a sequence jump)

8. client <--ACK: 100-- target host

...and the connection can't recover anymore, because the client can't
resend data that was already (erroneously) acknowledged. We need to
avoid step 5. above.

This would equally affect CRIU (the other known user of TCP_REPAIR),
should data be received while the original container is frozen: the
sequence dumped and the contents of the saved incoming queue would
then depend on the timing.

The race condition is also illustrated in the kselftests introduced
by the next patch.

To prevent this issue, discard data received for a socket in repair
mode, with a new reason, SKB_DROP_REASON_SOCKET_REPAIR.

In order to do this without affecting the TCP fast path, once repair
mode is set, disable the fast path for the given socket using the
pred_flags mechanism (as commonly done for other corner cases), so
that tcp_rcv_established() can handle this in the slow path.

Once / if repair mode is disabled, take care of re-enabling the fast
path if conditions are met, as implemented by tcp_fast_path_check().

v2: Instead of directly checking for tp->repair in the common case
    of tcp_rcv_established(), disable the fast path by setting
    pred_flags to 0 on TCP_REPAIR_ON, and re-enable it as we leave
    repair mode, while checking for that in tcp_fast_path_check().

    This way, we avoid touching the fast path itself, as requested by
    Kuniyuki Iwashima and Eric Dumazet.

Fixes: ee9952831cfd ("tcp: Initial repair mode")
Tested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 include/net/dropreason-core.h |  3 +++
 include/net/tcp.h             |  3 ++-
 net/ipv4/tcp.c                |  9 +++++++++
 net/ipv4/tcp_input.c          | 15 +++++++++++++--
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..19ab9e6ffc33 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -9,6 +9,7 @@
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
+	FN(SOCKET_REPAIR)		\
 	FN(UNIX_DISCONNECT)		\
 	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
@@ -158,6 +159,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/** @SKB_DROP_REASON_SOCKET_REPAIR: socket is in repair mode */
+	SKB_DROP_REASON_SOCKET_REPAIR,
 	/**
 	 * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged when SOCK_DGRAM
 	 * or SOCK_SEQPACKET socket re-connect()s to another socket or notices
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a744..bc26ab16e39d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1958,7 +1958,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
 	    tp->rcv_wnd &&
 	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
+	    !tp->urg_data &&
+	    !tp->repair)
 		tcp_fast_path_on(tp);
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4..74ef96bda8c7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3993,13 +3993,22 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			tp->repair = 1;
 			sk->sk_reuse = SK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
+
+			/* Disable fast path so that we can freeze the receive
+			 * queue as needed, see tcp_rcv_established().
+			 */
+			tp->pred_flags = 0;
 		} else if (val == TCP_REPAIR_OFF) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
 			tcp_send_window_probe(sk);
+
+			tcp_fast_path_check(sk);
 		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
+
+			tcp_fast_path_check(sk);
 		} else
 			err = -EINVAL;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..3081ccfa90b4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6451,8 +6451,9 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
  *	- Out of order segments arrived.
  *	- Urgent data is expected.
  *	- There is no buffer space left
- *	- Unexpected TCP flags/window values/header lengths are received
- *	  (detected by checking the TCP header against pred_flags)
+ *	- Unexpected TCP flags/window values/header lengths are received, or
+ *	  socket is in repair mode (detected by checking the TCP header against
+ *	  pred_flags)
  *	- Data is sent in both directions. Fast path only supports pure senders
  *	  or pure receivers (this means either the sequence number or the ack
  *	  value must stay constant)
@@ -6632,6 +6633,11 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		goto discard;
 	}
 
+	if (tp->repair) {
+		reason = SKB_DROP_REASON_SOCKET_REPAIR;
+		goto discard;
+	}
+
 	/*
 	 *	Standard slow path.
 	 */
@@ -7125,6 +7131,11 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	int queued = 0;
 	SKB_DR(reason);
 
+	if (tp->repair) {
+		SKB_DR_SET(reason, SOCKET_REPAIR);
+		goto discard;
+	}
+
 	switch (sk->sk_state) {
 	case TCP_CLOSE:
 		SKB_DR_SET(reason, TCP_CLOSE);
-- 
2.43.0


