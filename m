Return-Path: <netdev+bounces-39139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B537BE305
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D838A1C20A54
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1318043;
	Mon,  9 Oct 2023 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTQzP8Of"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F1358A3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:37:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290859E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696862269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SV3l0/+La+9i5+gaDgdfQ8L9OoHIkNWOubb186R3TlY=;
	b=iTQzP8OfLdhboB8+J2NV8PHEq9RgNB9Hbfx7goxbUfK/Z1tg8tINdrBGkGfTfMQe3QRrqJ
	JKE/ZGBLmlwsEqEE9zmQH5m3Dntr5ztejUs+JeTsgnRDuAVhEijJ56RQlqKBzavETwthJH
	fKdeE813jfMEJnDh7kFXKkstIYCqSCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-QwS_LLF5MHe_RlU7D-wtLA-1; Mon, 09 Oct 2023 10:37:41 -0400
X-MC-Unique: QwS_LLF5MHe_RlU7D-wtLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B48D811E8D;
	Mon,  9 Oct 2023 14:37:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.81])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F95D47AD4A;
	Mon,  9 Oct 2023 14:37:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	mptcp@lists.linux.dev,
	Boris Pismenny <borisp@nvidia.com>,
	Tom Deseyn <tdeseyn@redhat.com>
Subject: [PATCH net] tcp: allow again tcp_disconnect() when threads are waiting
Date: Mon,  9 Oct 2023 16:37:24 +0200
Message-ID: <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As reported by Tom, .NET and applications build on top of it rely
on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
socket.

The blamed commit below caused a regression, as such cancellation
can now fail.

As suggested by Eric, this change addresses the problem explicitly
causing blocking I/O operation to terminate immediately (with an error)
when a concurrent disconnect() is executed.

Instead of tracking the number of threads blocked on a given socket,
track the number of disconnect() issued on such socket. If such counter
changes after a blocking operation releasing and re-acquiring the socket
lock, error out the current operation.

Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting")
Reported-by: Tom Deseyn <tdeseyn@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=1886305
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 35 +++++++++++++++----
 include/net/sock.h                            | 10 +++---
 net/core/stream.c                             | 12 ++++---
 net/ipv4/af_inet.c                            |  8 +++--
 net/ipv4/inet_connection_sock.c               |  1 -
 net/ipv4/tcp.c                                | 17 ++++-----
 net/ipv4/tcp_bpf.c                            |  4 +++
 net/mptcp/protocol.c                          |  8 +----
 net/tls/tls_main.c                            | 10 ++++--
 net/tls/tls_sw.c                              | 19 ++++++----
 10 files changed, 79 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index 5fc64e47568a..caa1eaed190d 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -911,7 +911,7 @@ static int csk_wait_memory(struct chtls_dev *cdev,
 			   struct sock *sk, long *timeo_p)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int err = 0;
+	int ret, err = 0;
 	long current_timeo;
 	long vm_wait = 0;
 	bool noblock;
@@ -942,10 +942,13 @@ static int csk_wait_memory(struct chtls_dev *cdev,
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, sk->sk_err ||
-			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
-			      (csk_mem_free(cdev, sk) && !vm_wait), &wait);
+		ret = sk_wait_event(sk, &current_timeo, sk->sk_err ||
+				    (sk->sk_shutdown & SEND_SHUTDOWN) ||
+				    (csk_mem_free(cdev, sk) && !vm_wait),
+				    &wait);
 		sk->sk_write_pending--;
+		if (ret < 0)
+			goto do_error;
 
 		if (vm_wait) {
 			vm_wait -= current_timeo;
@@ -1348,6 +1351,7 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int copied = 0;
 	int target;
 	long timeo;
+	int ret;
 
 	buffers_freed = 0;
 
@@ -1423,7 +1427,11 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 		chtls_cleanup_rbuf(sk, copied);
-		sk_wait_data(sk, &timeo, NULL);
+		ret = sk_wait_data(sk, &timeo, NULL);
+		if (ret < 0) {
+			copied = copied ? : ret;
+			goto unlock;
+		}
 		continue;
 found_ok_skb:
 		if (!skb->len) {
@@ -1518,6 +1526,8 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	if (buffers_freed)
 		chtls_cleanup_rbuf(sk, copied);
+
+unlock:
 	release_sock(sk);
 	return copied;
 }
@@ -1534,6 +1544,7 @@ static int peekmsg(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 	size_t avail;          /* amount of available data in current skb */
 	long timeo;
+	int ret;
 
 	lock_sock(sk);
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
@@ -1585,7 +1596,11 @@ static int peekmsg(struct sock *sk, struct msghdr *msg,
 			release_sock(sk);
 			lock_sock(sk);
 		} else {
-			sk_wait_data(sk, &timeo, NULL);
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0) {
+				copied = ret;
+				break;
+			}
 		}
 
 		if (unlikely(peek_seq != tp->copied_seq)) {
@@ -1656,6 +1671,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int copied = 0;
 	long timeo;
 	int target;             /* Read at least this many bytes */
+	int ret;
 
 	buffers_freed = 0;
 
@@ -1747,7 +1763,11 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 		chtls_cleanup_rbuf(sk, copied);
-		sk_wait_data(sk, &timeo, NULL);
+		ret = sk_wait_data(sk, &timeo, NULL);
+		if (ret < 0) {
+			copied = copied ? : ret;
+			goto unlock;
+		}
 		continue;
 
 found_ok_skb:
@@ -1816,6 +1836,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (buffers_freed)
 		chtls_cleanup_rbuf(sk, copied);
 
+unlock:
 	release_sock(sk);
 	return copied;
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index b770261fbdaf..92f7ea62a915 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -336,7 +336,7 @@ struct sk_filter;
   *	@sk_cgrp_data: cgroup data for this cgroup
   *	@sk_memcg: this socket's memory cgroup association
   *	@sk_write_pending: a write to stream socket waits to start
-  *	@sk_wait_pending: number of threads blocked on this socket
+  *	@sk_disconnects: number of disconnect operations performed on this sock
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
   *	@sk_write_space: callback to indicate there is bf sending space available
@@ -429,7 +429,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
-	int			sk_wait_pending;
+	int			sk_disconnects;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -1189,8 +1189,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 }
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
-	({	int __rc;						\
-		__sk->sk_wait_pending++;				\
+	({	int __rc, __dis = __sk->sk_disconnects;			\
 		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
@@ -1200,8 +1199,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 		}							\
 		sched_annotate_sleep();					\
 		lock_sock(__sk);					\
-		__sk->sk_wait_pending--;				\
-		__rc = __condition;					\
+		__rc = __dis == __sk->sk_disconnects ? __condition : -EPIPE; \
 		__rc;							\
 	})
 
diff --git a/net/core/stream.c b/net/core/stream.c
index f5c4e47df165..96fbcb9bbb30 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(sk_stream_wait_close);
  */
 int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 {
-	int err = 0;
+	int ret, err = 0;
 	long vm_wait = 0;
 	long current_timeo = *timeo_p;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -142,11 +142,13 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
-						  (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
-						  (sk_stream_memory_free(sk) &&
-						  !vm_wait), &wait);
+		ret = sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
+				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
+				    (sk_stream_memory_free(sk) && !vm_wait),
+				    &wait);
 		sk->sk_write_pending--;
+		if (ret < 0)
+			goto do_error;
 
 		if (vm_wait) {
 			vm_wait -= current_timeo;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3d2e30e20473..a7aa082f9a4c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -597,7 +597,6 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending += writebias;
-	sk->sk_wait_pending++;
 
 	/* Basic assumption: if someone sets sk->sk_err, he _must_
 	 * change state of the socket from TCP_SYN_*.
@@ -613,7 +612,6 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending -= writebias;
-	sk->sk_wait_pending--;
 	return timeo;
 }
 
@@ -696,6 +694,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		int writebias = (sk->sk_protocol == IPPROTO_TCP) &&
 				tcp_sk(sk)->fastopen_req &&
 				tcp_sk(sk)->fastopen_req->data ? 1 : 0;
+		int dis = sk->sk_disconnects;
 
 		/* Error code is set above */
 		if (!timeo || !inet_wait_for_connect(sk, timeo, writebias))
@@ -704,6 +703,11 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		err = sock_intr_errno(timeo);
 		if (signal_pending(current))
 			goto out;
+
+		if (dis != sk->sk_disconnects) {
+			err = -EPIPE;
+			goto out;
+		}
 	}
 
 	/* Connection was closed by RST, timeout, ICMP error
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index aeebe8816689..394a498c2823 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1145,7 +1145,6 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
-		newsk->sk_wait_pending = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3f66cdeef7de..368f0d16c817 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -831,7 +831,9 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 			 */
 			if (!skb_queue_empty(&sk->sk_receive_queue))
 				break;
-			sk_wait_data(sk, &timeo, NULL);
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0)
+				break;
 			if (signal_pending(current)) {
 				ret = sock_intr_errno(timeo);
 				break;
@@ -2442,7 +2444,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			__sk_flush_backlog(sk);
 		} else {
 			tcp_cleanup_rbuf(sk, copied);
-			sk_wait_data(sk, &timeo, last);
+			err = sk_wait_data(sk, &timeo, last);
+			if (err < 0) {
+				err = copied ? : err;
+				goto out;
+			}
 		}
 
 		if ((flags & MSG_PEEK) &&
@@ -2966,12 +2972,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	int old_state = sk->sk_state;
 	u32 seq;
 
-	/* Deny disconnect if other threads are blocked in sk_wait_event()
-	 * or inet_wait_for_connect().
-	 */
-	if (sk->sk_wait_pending)
-		return -EBUSY;
-
 	if (old_state != TCP_CLOSE)
 		tcp_set_state(sk, TCP_CLOSE);
 
@@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 		sk->sk_frag.offset = 0;
 	}
 	sk_error_report(sk);
+	sk->sk_disconnects++;
 	return 0;
 }
 EXPORT_SYMBOL(tcp_disconnect);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 327268203001..ba2e92188124 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -307,6 +307,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 
 		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (data < 0)
+			return data;
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
 		copied = -EAGAIN;
@@ -351,6 +353,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (data < 0)
+			return data;
 		if (data) {
 			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e252539b1e19..22dd27cce4e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3098,12 +3098,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* Deny disconnect if other threads are blocked in sk_wait_event()
-	 * or inet_wait_for_connect().
-	 */
-	if (sk->sk_wait_pending)
-		return -EBUSY;
-
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
 	 * msk->firstsocket lock).
@@ -3144,6 +3138,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
+	sk->sk_disconnects++;
 	return 0;
 }
 
@@ -3173,7 +3168,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
-	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 02f583ff9239..002483e60c19 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -139,8 +139,8 @@ void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
 {
-	int rc = 0;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int ret, rc = 0;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
@@ -154,9 +154,13 @@ int wait_on_pending_writer(struct sock *sk, long *timeo)
 			break;
 		}
 
-		if (sk_wait_event(sk, timeo,
-				  !READ_ONCE(sk->sk_write_pending), &wait))
+		ret = sk_wait_event(sk, timeo,
+				    !READ_ONCE(sk->sk_write_pending), &wait);
+		if (ret) {
+			if (ret < 0)
+				rc = ret;
 			break;
+		}
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return rc;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1fc295b83b5..e9d1e83a859d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1291,6 +1291,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int ret = 0;
 	long timeo;
 
 	timeo = sock_rcvtimeo(sk, nonblock);
@@ -1302,6 +1303,9 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (sk->sk_err)
 			return sock_error(sk);
 
+		if (ret < 0)
+			return ret;
+
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			tls_strp_check_rcv(&ctx->strp);
 			if (tls_strp_msg_ready(ctx))
@@ -1320,10 +1324,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		released = true;
 		add_wait_queue(sk_sleep(sk), &wait);
 		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-		sk_wait_event(sk, &timeo,
-			      tls_strp_msg_ready(ctx) ||
-			      !sk_psock_queue_empty(psock),
-			      &wait);
+		ret = sk_wait_event(sk, &timeo,
+				    tls_strp_msg_ready(ctx) ||
+				    !sk_psock_queue_empty(psock),
+				    &wait);
 		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		remove_wait_queue(sk_sleep(sk), &wait);
 
@@ -1852,6 +1856,7 @@ static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
 				 bool nonblock)
 {
 	long timeo;
+	int ret;
 
 	timeo = sock_rcvtimeo(sk, nonblock);
 
@@ -1861,14 +1866,16 @@ static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
 		ctx->reader_contended = 1;
 
 		add_wait_queue(&ctx->wq, &wait);
-		sk_wait_event(sk, &timeo,
-			      !READ_ONCE(ctx->reader_present), &wait);
+		ret = sk_wait_event(sk, &timeo,
+				    !READ_ONCE(ctx->reader_present), &wait);
 		remove_wait_queue(&ctx->wq, &wait);
 
 		if (timeo <= 0)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return sock_intr_errno(timeo);
+		if (ret < 0)
+			return ret;
 	}
 
 	WRITE_ONCE(ctx->reader_present, 1);
-- 
2.41.0


