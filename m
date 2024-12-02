Return-Path: <netdev+bounces-148070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8379E04FF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477A2287DAA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7727205E03;
	Mon,  2 Dec 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/YQdQks"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27F2940F
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149882; cv=none; b=dDIGgerQQMbRRSMB1D4fHKUM7VtOBBIxj7EhVkollCZmqTf7e5kY9aRIv995o3XrpJkbr0BNUOAeDuGvvjUbEPcvMlXZzB4pHRNWfz4/KBxZCvR48FLzLxdbi6nf0YRq9tp8zshwxCb3uaO9q7nCWTs3SYhRL9wVC2MDFOpGOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149882; c=relaxed/simple;
	bh=Ajr6EJYUikw3/5g4fJy9d6ePJmsXOdDxMyw8WEJtZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBnLghY5h+2zSceqHhjEpoeFxKq0seWyGIAsdlkO4Nh49TO0pI9D+K+0U+Smc66dVQLEYh2Reetb7cxcQyd71+mfKIGc6tYGSSP/weFzelwcSCZz1cIgwf0h5LQicSBbXtyobUtzFcBGsNGmq45DfCJLh2mYhU5pFrufU1ejQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/YQdQks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7W+ovC1/MZN/VGq8X1RAdXcqzCIH+5G/UI+MbcPx/zU=;
	b=Q/YQdQksfWqACM2FLcNSIYmx/G6NReEXqII0Wf7zenoiN3YJZ7fJmvxAAroWJwy2NY7sab
	lB0Dp/BAkNBXxBQQ2gVEsQrz3+ckUOc6aaG5g3kn65bYiRaFlYlJqlAvMQTrEiz3QzfUHC
	azojSQLU705t5rbHUBwNEH3NghwlvI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-kaf7AxhpPm6wO1d8Dz-qHw-1; Mon,
 02 Dec 2024 09:31:14 -0500
X-MC-Unique: kaf7AxhpPm6wO1d8Dz-qHw-1
X-Mimecast-MFC-AGG-ID: kaf7AxhpPm6wO1d8Dz-qHw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 671A118EBABB;
	Mon,  2 Dec 2024 14:31:12 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F224195608A;
	Mon,  2 Dec 2024 14:31:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than min_t()/max_t() where possible
Date: Mon,  2 Dec 2024 14:30:20 +0000
Message-ID: <20241202143057.378147-3-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use umin() and umax() rather than min_t()/max_t() where the type specified
is an unsigned type.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c  |  5 ++---
 net/rxrpc/call_object.c |  4 ++--
 net/rxrpc/conn_client.c |  2 +-
 net/rxrpc/input.c       | 13 +++++--------
 net/rxrpc/insecure.c    |  2 +-
 net/rxrpc/io_thread.c   |  2 +-
 net/rxrpc/output.c      |  2 +-
 net/rxrpc/rtt.c         |  6 +++---
 net/rxrpc/rxkad.c       |  6 +++---
 net/rxrpc/rxperf.c      |  2 +-
 net/rxrpc/sendmsg.c     |  2 +-
 11 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 7bbb68504766..c4754cc9b8d4 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -233,8 +233,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
 
 static bool rxrpc_tx_window_has_space(struct rxrpc_call *call)
 {
-	unsigned int winsize = min_t(unsigned int, call->tx_winsize,
-				     call->cong_cwnd + call->cong_extra);
+	unsigned int winsize = umin(call->tx_winsize, call->cong_cwnd + call->cong_extra);
 	rxrpc_seq_t window = call->acks_hard_ack, wtop = window + winsize;
 	rxrpc_seq_t tx_top = call->tx_top;
 	int space;
@@ -467,7 +466,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		} else {
 			unsigned long nowj = jiffies, delayj, nextj;
 
-			delayj = max(nsecs_to_jiffies(delay), 1);
+			delayj = umax(nsecs_to_jiffies(delay), 1);
 			nextj = nowj + delayj;
 			if (time_before(nextj, call->timer.expires) ||
 			    !timer_pending(&call->timer)) {
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index f9e983a12c14..0df647d1d3a2 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -220,9 +220,9 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 		__set_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 
 	if (p->timeouts.normal)
-		call->next_rx_timo = min(p->timeouts.normal, 1);
+		call->next_rx_timo = umin(p->timeouts.normal, 1);
 	if (p->timeouts.idle)
-		call->next_req_timo = min(p->timeouts.idle, 1);
+		call->next_req_timo = umin(p->timeouts.idle, 1);
 	if (p->timeouts.hard)
 		call->hard_timo = p->timeouts.hard;
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index bb11e8289d6d..86fb18bcd188 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -231,7 +231,7 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
 	distance = id - id_cursor;
 	if (distance < 0)
 		distance = -distance;
-	limit = max_t(unsigned long, atomic_read(&rxnet->nr_conns) * 4, 1024);
+	limit = umax(atomic_read(&rxnet->nr_conns) * 4, 1024);
 	if (distance > limit)
 		goto mark_dont_reuse;
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 16d49a861dbb..49e35be7dc13 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -44,8 +44,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
-		call->cong_ssthresh = max_t(unsigned int,
-					    summary->flight_size / 2, 2);
+		call->cong_ssthresh = umax(summary->flight_size / 2, 2);
 		cwnd = 1;
 		if (cwnd >= call->cong_ssthresh &&
 		    call->cong_mode == RXRPC_CALL_SLOW_START) {
@@ -113,8 +112,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 
 		change = rxrpc_cong_begin_retransmission;
 		call->cong_mode = RXRPC_CALL_FAST_RETRANSMIT;
-		call->cong_ssthresh = max_t(unsigned int,
-					    summary->flight_size / 2, 2);
+		call->cong_ssthresh = umax(summary->flight_size / 2, 2);
 		cwnd = call->cong_ssthresh + 3;
 		call->cong_extra = 0;
 		call->cong_dup_acks = 0;
@@ -206,9 +204,8 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_cwnd_reset);
 	call->tx_last_sent = now;
 	call->cong_mode = RXRPC_CALL_SLOW_START;
-	call->cong_ssthresh = max_t(unsigned int, call->cong_ssthresh,
-				    call->cong_cwnd * 3 / 4);
-	call->cong_cwnd = max_t(unsigned int, call->cong_cwnd / 2, RXRPC_MIN_CWND);
+	call->cong_ssthresh = umax(call->cong_ssthresh, call->cong_cwnd * 3 / 4);
+	call->cong_cwnd = umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
 }
 
 /*
@@ -709,7 +706,7 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		call->tx_winsize = rwind;
 	}
 
-	mtu = min(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
+	mtu = umin(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
 
 	peer = call->peer;
 	if (mtu < peer->maxdata) {
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 6716c021a532..751eb621021d 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -19,7 +19,7 @@ static int none_init_connection_security(struct rxrpc_connection *conn,
  */
 static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, size_t remain, gfp_t gfp)
 {
-	return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO_DATALEN), 1, gfp);
+	return rxrpc_alloc_data_txbuf(call, umin(remain, RXRPC_JUMBO_DATALEN), 1, gfp);
 }
 
 static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 07c74c77d802..7af5adf53b25 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -558,7 +558,7 @@ int rxrpc_io_thread(void *data)
 			}
 
 			timeout = nsecs_to_jiffies(delay_ns);
-			timeout = max(timeout, 1UL);
+			timeout = umax(timeout, 1);
 			schedule_timeout(timeout);
 			__set_current_state(TASK_RUNNING);
 			continue;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5ea9601efd05..85112ea31a39 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -118,7 +118,7 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 		txb->kvec[1].iov_len = ack->nAcks;
 
 		wrap = RXRPC_SACK_SIZE - sack;
-		to = min_t(unsigned int, ack->nAcks, RXRPC_SACK_SIZE);
+		to = umin(ack->nAcks, RXRPC_SACK_SIZE);
 
 		if (sack + ack->nAcks <= RXRPC_SACK_SIZE) {
 			memcpy(sackp, call->ackr_sack_table + sack, ack->nAcks);
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index cdab7b7d08a0..6dc51486b5a6 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -27,7 +27,7 @@ static u32 __rxrpc_set_rto(const struct rxrpc_peer *peer)
 
 static u32 rxrpc_bound_rto(u32 rto)
 {
-	return min(rto, RXRPC_RTO_MAX);
+	return umin(rto, RXRPC_RTO_MAX);
 }
 
 /*
@@ -91,11 +91,11 @@ static void rxrpc_rtt_estimator(struct rxrpc_peer *peer, long sample_rtt_us)
 		/* no previous measure. */
 		srtt = m << 3;		/* take the measured time to be rtt */
 		peer->mdev_us = m << 1;	/* make sure rto = 3*rtt */
-		peer->rttvar_us = max(peer->mdev_us, rxrpc_rto_min_us(peer));
+		peer->rttvar_us = umax(peer->mdev_us, rxrpc_rto_min_us(peer));
 		peer->mdev_max_us = peer->rttvar_us;
 	}
 
-	peer->srtt_us = max(1U, srtt);
+	peer->srtt_us = umax(srtt, 1);
 }
 
 /*
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 48a1475e6b06..e3194d73dd84 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -150,11 +150,11 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t rem
 	struct rxrpc_txbuf *txb;
 	size_t shdr, space;
 
-	remain = min(remain, 65535 - sizeof(struct rxrpc_wire_header));
+	remain = umin(remain, 65535 - sizeof(struct rxrpc_wire_header));
 
 	switch (call->conn->security_level) {
 	default:
-		space = min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
+		space = umin(remain, RXRPC_JUMBO_DATALEN);
 		return rxrpc_alloc_data_txbuf(call, space, 1, gfp);
 	case RXRPC_SECURITY_AUTH:
 		shdr = sizeof(struct rxkad_level1_hdr);
@@ -164,7 +164,7 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct rxrpc_call *call, size_t rem
 		break;
 	}
 
-	space = min_t(size_t, round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain + shdr);
+	space = umin(round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain + shdr);
 	space = round_up(space, RXKAD_ALIGN);
 
 	txb = rxrpc_alloc_data_txbuf(call, space, RXKAD_ALIGN, gfp);
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 085e7892d310..7ef93407be83 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -503,7 +503,7 @@ static int rxperf_process_call(struct rxperf_call *call)
 				   reply_len + sizeof(rxperf_magic_cookie));
 
 	while (reply_len > 0) {
-		len = min_t(size_t, reply_len, PAGE_SIZE);
+		len = umin(reply_len, PAGE_SIZE);
 		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
 		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
 		msg.msg_flags = MSG_MORE;
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 6abb8eec1b2b..b04afb5df241 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -360,7 +360,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 		/* append next segment of data to the current buffer */
 		if (msg_data_left(msg) > 0) {
-			size_t copy = min_t(size_t, txb->space, msg_data_left(msg));
+			size_t copy = umin(txb->space, msg_data_left(msg));
 
 			_debug("add %zu", copy);
 			if (!copy_from_iter_full(txb->kvec[0].iov_base + txb->offset,


