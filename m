Return-Path: <netdev+bounces-231856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D447BFDFF9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A60A34F5775
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7C34E74A;
	Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUTkS9cw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2634FF50
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160639; cv=none; b=MRJuASU8qW9i+KS2jLKIPuOWeijM/qfZNyTsp8fH6iBeBsLsiYDnjVkndy8+wo+LU7lNvNynPN7/5HAyu1IBYtv7jhVNeoIgsrjDHJ5Mm91s1zh/8jByxez+/o1BN42GTONBAuXeJzvlA00RgfJprGNu5E6ybW3mVTJlhZk7AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160639; c=relaxed/simple;
	bh=BNAE/a6kdbkGl6xvxIl6x+M8CoRo4+rW/S2MMHUDy2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPWmdOHFWdNgUu5IRPY009qAa6Qm/HyD4SnCQo/WNIkrHn6RcFMCScEvYAdlSS+V0zYGzBu+S46jh9DJC1AlRCEfPb3ffUew9lNeh1R8qqkR8C6Bx8j4gz7dTaIIM4WqsK19OVVJ8XR3KRtj+fN3smALyXNBjQd/NvlBrT0QuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUTkS9cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A0C4CEE7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160639;
	bh=BNAE/a6kdbkGl6xvxIl6x+M8CoRo4+rW/S2MMHUDy2I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aUTkS9cw3gmiUflGT87gVqeBHxufT2iGINtwADsCToOTREvsjUEClrp2GMV94MTke
	 xj5QlJDevqm9j2smFmQBpVWjmQHVk5SKoJ2J9S+e2Rw4LkEbdQlgpVr123Qker2ddm
	 DqmqktzSqVRB0VG4joGXmfurknbbh2zol/ZqYBbxG6A5q8SwCHIvMa1PcWjFkDe9G7
	 Z6W6P8fka3EvMHAWBWZ9QW1lCaV6Q1TuUo3tb4KLjhM2G1nIV2Hwx0MoRkFmc2h7KO
	 QSJhJf84yksBc5SKk4/VnMQPLDEvti/lnCpMqzTEvIytmKTTBb9YP7gg5gweIV7+Ui
	 x6AQjc4iNsdtQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 08/15] net/rds: rds_tcp_conn_path_shutdown must not discard messages
Date: Wed, 22 Oct 2025 12:17:08 -0700
Message-ID: <20251022191715.157755-9-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged by the
TCP stack of a peer, rds_tcp_write_space() goes on to discard
prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages
away.

The dequeuing of messages in RDS/TCP is done either from the
"sk_data_ready" callback pointing to rds_tcp_data_ready()
(the most common case), or from the receive worker pointing
to rds_tcp_recv_path() which is called for as long as the
connection is "RDS_CONN_UP".

However, as soon as rds_conn_path_drop() is called for whatever reason,
including "DR_USER_RESET", "cp_state" transitions to "RDS_CONN_ERROR",
and rds_tcp_restore_callbacks() ends up restoring the callbacks
and thereby disabling message receipt.

So messages already acknowledged to the sender were dropped.

Furthermore, the "->shutdown" callback was always called
with an invalid parameter ("RCV_SHUTDOWN | SEND_SHUTDOWN == 3"),
instead of the correct pre-increment value ("SHUT_RDWR == 2").
inet_shutdown() returns "-EINVAL" in such cases, rendering
this call a NOOP.

So we change rds_tcp_conn_path_shutdown() to do the proper
"->shutdown(SHUT_WR)" call in order to signal EOF to the peer
and make it transition to "TCP_CLOSE_WAIT" (RFC 793).

This should make the peer also enter rds_tcp_conn_path_shutdown()
and do the same.

This allows us to dequeue all messages already received
and acknowledged to the peer.
We do so, until we know that the receive queue no longer has data
(skb_queue_empty()) and that we couldn't have any data
in flight anymore, because the socket transitioned to
any of the states "CLOSING", "TIME_WAIT", "CLOSE_WAIT",
"LAST_ACK", or "CLOSE" (RFC 793).

However, if we do just that, we suddenly see duplicate RDS
messages being delivered to the application.
So what gives?

Turns out that with MPRDS and its multitude of backend connections,
retransmitted messages ("RDS_FLAG_RETRANSMITTED") can outrace
the dequeuing of their original counterparts.

And the duplicate check implemented in rds_recv_local() only
discards duplicates if flag "RDS_FLAG_RETRANSMITTED" is set.

Rather curious, because a duplicate is a duplicate; it shouldn't
matter which copy is looked at and delivered first.

To avoid this entire situation, we simply make the sender discard
messages from the send-queue right from within
rds_tcp_conn_path_shutdown().  Just like rds_tcp_write_space() would
have done, were it called in time or still called.

This makes sure that we no longer have messages that we know
the receiver already dequeued sitting in our send-queue,
and therefore avoid the entire "RDS_FLAG_RETRANSMITTED" fiasco.

Now we got rid of the duplicate RDS message delivery, but we
still run into cases where RDS messages are dropped.

This time it is due to the delayed setting of the socket-callbacks
in rds_tcp_accept_one() via either rds_tcp_reset_callbacks()
or rds_tcp_set_callbacks().

By the time rds_tcp_accept_one() gets there, the socket
may already have transitioned into state "TCP_CLOSE_WAIT",
but rds_tcp_state_change() was never called.

Subsequently, "->shutdown(SHUT_WR)" did not happen either.
So the peer ends up getting stuck in state "TCP_FIN_WAIT2".

We fix that by checking for states "TCP_CLOSE_WAIT", "TCP_LAST_ACK",
or "TCP_CLOSE" and drop the freshly accepted socket in that case.

This problem is observable by running "rds-stress --reset"
frequently on either of the two sides of a RDS connection,
or both while other "rds-stress" processes are exchanging data.
Those "rds-stress" processes reported out-of-sequence
errors, with the expected sequence number being smaller
than the one actually received (due to the dropped messages).

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp.c         |  1 +
 net/rds/tcp.h         |  4 ++++
 net/rds/tcp_connect.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 net/rds/tcp_listen.c  | 14 +++++++++++++
 net/rds/tcp_recv.c    |  4 ++++
 net/rds/tcp_send.c    |  2 +-
 6 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 31e7425e2da9..45484a93d75f 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -384,6 +384,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
+		init_waitqueue_head(&tc->t_recv_done_waitq);
 
 		conn->c_path[i].cp_transport_data = tc;
 		tc->t_cpath = &conn->c_path[i];
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 3beb0557104e..1893bc4bd342 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -55,6 +55,9 @@ struct rds_tcp_connection {
 	u32			t_last_sent_nxt;
 	u32			t_last_expected_una;
 	u32			t_last_seen_una;
+
+	/* for rds_tcp_conn_path_shutdown */
+	wait_queue_head_t	t_recv_done_waitq;
 };
 
 struct rds_tcp_statistics {
@@ -105,6 +108,7 @@ void rds_tcp_xmit_path_prepare(struct rds_conn_path *cp);
 void rds_tcp_xmit_path_complete(struct rds_conn_path *cp);
 int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 		 unsigned int hdr_off, unsigned int sg, unsigned int off);
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack);
 void rds_tcp_write_space(struct sock *sk);
 
 /* tcp_stats.c */
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 6b9d4776e504..f832cdfe149b 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -75,8 +75,16 @@ void rds_tcp_state_change(struct sock *sk)
 			rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 		}
 		break;
+	case TCP_CLOSING:
+	case TCP_TIME_WAIT:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
+		break;
 	case TCP_CLOSE_WAIT:
+	case TCP_LAST_ACK:
 	case TCP_CLOSE:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
 		rds_conn_path_drop(cp, false);
 		break;
 	default:
@@ -225,6 +233,7 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
 	struct socket *sock = tc->t_sock;
+	unsigned int rounds;
 
 	rdsdebug("shutting down conn %p tc %p sock %p\n",
 		 cp->cp_conn, tc, sock);
@@ -232,8 +241,43 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 	if (sock) {
 		if (rds_destroy_pending(cp->cp_conn))
 			sock_no_linger(sock->sk);
-		sock->ops->shutdown(sock, RCV_SHUTDOWN | SEND_SHUTDOWN);
+
+		sock->ops->shutdown(sock, SHUT_WR);
+
+		/* after sending FIN,
+		 * wait until we processed all incoming messages
+		 * and we're sure that there won't be any more:
+		 * i.e. state CLOSING, TIME_WAIT, CLOSE_WAIT,
+		 * LAST_ACK, or CLOSE (RFC 793).
+		 *
+		 * Give up waiting after 5 seconds and allow messages
+		 * to theoretically get dropped, if the TCP transition
+		 * didn't happen.
+		 */
+		rounds = 0;
+		do {
+			/* we need to ensure messages are dequeued here
+			 * since "rds_recv_worker" only dispatches messages
+			 * while the connection is still in RDS_CONN_UP
+			 * and there is no guarantee that "rds_tcp_data_ready"
+			 * was called nor that "sk_data_ready" still points to it.
+			 */
+			rds_tcp_recv_path(cp);
+		} while (!wait_event_timeout(tc->t_recv_done_waitq,
+					     (sock->sk->sk_state == TCP_CLOSING ||
+					      sock->sk->sk_state == TCP_TIME_WAIT ||
+					      sock->sk->sk_state == TCP_CLOSE_WAIT ||
+					      sock->sk->sk_state == TCP_LAST_ACK ||
+					      sock->sk->sk_state == TCP_CLOSE) &&
+					     skb_queue_empty_lockless(&sock->sk->sk_receive_queue),
+					     msecs_to_jiffies(100)) &&
+			 ++rounds < 50);
 		lock_sock(sock->sk);
+
+		/* discard messages that the peer received already */
+		tc->t_last_seen_una = rds_tcp_snd_una(tc);
+		rds_send_path_drop_acked(cp, rds_tcp_snd_una(tc), rds_tcp_is_acked);
+
 		rds_tcp_restore_callbacks(sock, tc); /* tc->tc_sock = NULL */
 
 		release_sock(sock->sk);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d9960c2399d4..b8a4ec424085 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -278,6 +278,20 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		rds_tcp_set_callbacks(new_sock, cp);
 		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 	}
+
+	/* Since "rds_tcp_set_callbacks" happens this late
+	 * the connection may already have been closed without
+	 * "rds_tcp_state_change" doing its due diligence.
+	 *
+	 * If that's the case, we simply drop the path,
+	 * knowing that "rds_tcp_conn_path_shutdown" will
+	 * dequeue pending messages.
+	 */
+	if (new_sock->sk->sk_state == TCP_CLOSE_WAIT ||
+	    new_sock->sk->sk_state == TCP_LAST_ACK ||
+	    new_sock->sk->sk_state == TCP_CLOSE)
+		rds_conn_path_drop(cp, 0);
+
 	new_sock = NULL;
 	ret = 0;
 	if (conn->c_npaths == 0)
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index b7cf7f451430..49f96ee0c40f 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -278,6 +278,10 @@ static int rds_tcp_read_sock(struct rds_conn_path *cp, gfp_t gfp)
 	rdsdebug("tcp_read_sock for tc %p gfp 0x%x returned %d\n", tc, gfp,
 		 desc.error);
 
+	if (skb_queue_empty_lockless(&sock->sk->sk_receive_queue) &&
+	    wq_has_sleeper(&tc->t_recv_done_waitq))
+		wake_up(&tc->t_recv_done_waitq);
+
 	return desc.error;
 }
 
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 4e82c9644aa6..7c52acc749cf 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -169,7 +169,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
  * unacked byte of the TCP sequence space.  We have to do very careful
  * wrapping 32bit comparisons here.
  */
-static int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
 {
 	if (!test_bit(RDS_MSG_HAS_ACK_SEQ, &rm->m_flags))
 		return 0;
-- 
2.43.0


