Return-Path: <netdev+bounces-148076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD539E0541
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F2316B49E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5D205ACF;
	Mon,  2 Dec 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvXELf8y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B032205ACE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149906; cv=none; b=YdEa60E59NPDartyq/LtYuudiYgV3dxndmfqNkVCgLL6sS4IKMRBbjmqkkSWeZyvLxIDrXJ9yUxesA7eUHxxpUONITZ7ekXKOmaIc4ob5mlfyWDJI/RBT1QvmbudPVOX3hrnpBhOAbEMAhL/3LtN+6K0Bensl8G+xFk8Ka+G86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149906; c=relaxed/simple;
	bh=shNrObhnlgGPk2nEmj+XU+EfVA//ZcAhgraQPs9c8s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGgIH15G8ni9LNSHqy0HRRaMl/tXYELv0VnRxXm6DsrTnDNGkADdvAElYyUWZHinsZ9ltSdzkqJgh/Y//o6F5qFI/gZEElzl19wB4FnHFj6uUsYYAdymGRzFKq7jthWcwjQgRmqgklTIZjJDQn2w/pCB/fGGhGHeDYHNzh1ApFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvXELf8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1IFBi441ysZuLuU3BMbPZdHtVkpKLXdN5BYfu814WE=;
	b=MvXELf8yiHbm6KtFuqUxqtTiS2wyg29B08akepg41y2hAXYVjacetgan313ZKkHk7qDByt
	c4nD7aE7cWvqaa9vizut1gTvCMFLl9oxguPEzgQCxoOI7id8yCovbhnHylMFFLd7N6i8+A
	8MWOkhOpAbFqXZvcwOHUnU/QURPWR1Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-zirNLG3gNlWlOoT2QlCOZA-1; Mon,
 02 Dec 2024 09:31:41 -0500
X-MC-Unique: zirNLG3gNlWlOoT2QlCOZA-1
X-Mimecast-MFC-AGG-ID: zirNLG3gNlWlOoT2QlCOZA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 702DB18EBB62;
	Mon,  2 Dec 2024 14:31:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF82330000DF;
	Mon,  2 Dec 2024 14:31:34 +0000 (UTC)
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
Subject: [PATCH net-next 08/37] rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)
Date: Mon,  2 Dec 2024 14:30:26 +0000
Message-ID: <20241202143057.378147-9-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement path-MTU probing (along the lines of RFC8899) by padding some of
the PING ACKs we send.  PING ACKs get their own individual responses quite
apart from the acking of data (though, as ACKs, they fulfil that role
also).

The probing concentrates on packet sizes that correspond how many
subpackets can be stuffed inside a jumbo packet as jumbo DATA packets are
just aggregations of individual DATA packets and can be split easily for
retransmission purposes.

If we want to perform probing, we advertise this by setting the maximum
number of jumbo subpackets to 0 in the ack trailer when we send an ACK and
see if the peer is also advertising the service.  This is interpreted by
non-supporting Rx stacks as an indication that jumbo packets aren't
supported.

The MTU sizes advertised in the ACK trailer AF_RXRPC transmits are pegged
at a maximum of 1444 unless pmtud is supported by both sides.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 124 +++++++++++++++++++++++++++++++++++
 net/rxrpc/ar-internal.h      |  25 +++++--
 net/rxrpc/call_event.c       |   5 ++
 net/rxrpc/conn_event.c       |  15 +++--
 net/rxrpc/conn_object.c      |   6 ++
 net/rxrpc/input.c            |  26 +++++---
 net/rxrpc/io_thread.c        |   6 ++
 net/rxrpc/misc.c             |   4 +-
 net/rxrpc/output.c           |  66 +++++++++++++++----
 net/rxrpc/peer_event.c       | 102 ++++++++++++++++++++++++++--
 net/rxrpc/peer_object.c      |  24 +++++--
 net/rxrpc/proc.c             |   6 +-
 net/rxrpc/protocol.h         |  13 ++--
 net/rxrpc/sysctl.c           |   6 +-
 net/rxrpc/txbuf.c            |   3 +-
 15 files changed, 377 insertions(+), 54 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d86b5f07d292..9dcadad88e76 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -364,6 +364,7 @@
 	EM(rxrpc_propose_ack_ping_for_lost_ack,	"LostAck") \
 	EM(rxrpc_propose_ack_ping_for_lost_reply, "LostRpl") \
 	EM(rxrpc_propose_ack_ping_for_0_retrans, "0-Retrn") \
+	EM(rxrpc_propose_ack_ping_for_mtu_probe, "MTUProb") \
 	EM(rxrpc_propose_ack_ping_for_old_rtt,	"OldRtt ") \
 	EM(rxrpc_propose_ack_ping_for_params,	"Params ") \
 	EM(rxrpc_propose_ack_ping_for_rtt,	"Rtt    ") \
@@ -478,6 +479,11 @@
 	EM(rxrpc_txbuf_see_send_more,		"SEE SEND+  ")	\
 	E_(rxrpc_txbuf_see_unacked,		"SEE UNACKED")
 
+#define rxrpc_pmtud_reduce_traces \
+	EM(rxrpc_pmtud_reduce_ack,		"Ack  ")	\
+	EM(rxrpc_pmtud_reduce_icmp,		"Icmp ")	\
+	E_(rxrpc_pmtud_reduce_route,		"Route")
+
 /*
  * Generate enums for tracing information.
  */
@@ -498,6 +504,7 @@ enum rxrpc_congest_change	{ rxrpc_congest_changes } __mode(byte);
 enum rxrpc_conn_trace		{ rxrpc_conn_traces } __mode(byte);
 enum rxrpc_local_trace		{ rxrpc_local_traces } __mode(byte);
 enum rxrpc_peer_trace		{ rxrpc_peer_traces } __mode(byte);
+enum rxrpc_pmtud_reduce_trace	{ rxrpc_pmtud_reduce_traces } __mode(byte);
 enum rxrpc_propose_ack_outcome	{ rxrpc_propose_ack_outcomes } __mode(byte);
 enum rxrpc_propose_ack_trace	{ rxrpc_propose_ack_traces } __mode(byte);
 enum rxrpc_receive_trace	{ rxrpc_receive_traces } __mode(byte);
@@ -534,6 +541,7 @@ rxrpc_congest_changes;
 rxrpc_congest_modes;
 rxrpc_conn_traces;
 rxrpc_local_traces;
+rxrpc_pmtud_reduce_traces;
 rxrpc_propose_ack_traces;
 rxrpc_receive_traces;
 rxrpc_recvmsg_traces;
@@ -2040,6 +2048,122 @@ TRACE_EVENT(rxrpc_sack,
 		      __entry->sack)
 	    );
 
+TRACE_EVENT(rxrpc_pmtud_tx,
+	    TP_PROTO(struct rxrpc_call *call),
+
+	    TP_ARGS(call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	peer_debug_id)
+		    __field(unsigned int,	call_debug_id)
+		    __field(rxrpc_serial_t,	ping_serial)
+		    __field(unsigned short,	pmtud_trial)
+		    __field(unsigned short,	pmtud_good)
+		    __field(unsigned short,	pmtud_bad)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer_debug_id = call->peer->debug_id;
+		    __entry->call_debug_id = call->debug_id;
+		    __entry->ping_serial = call->conn->pmtud_probe;
+		    __entry->pmtud_trial = call->peer->pmtud_trial;
+		    __entry->pmtud_good = call->peer->pmtud_good;
+		    __entry->pmtud_bad = call->peer->pmtud_bad;
+			   ),
+
+	    TP_printk("P=%08x c=%08x pr=%08x %u-%u-%u",
+		      __entry->peer_debug_id,
+		      __entry->call_debug_id,
+		      __entry->ping_serial,
+		      __entry->pmtud_good,
+		      __entry->pmtud_trial,
+		      __entry->pmtud_bad)
+	    );
+
+TRACE_EVENT(rxrpc_pmtud_rx,
+	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t resp_serial),
+
+	    TP_ARGS(conn, resp_serial),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	peer_debug_id)
+		    __field(unsigned int,	call_debug_id)
+		    __field(rxrpc_serial_t,	ping_serial)
+		    __field(rxrpc_serial_t,	resp_serial)
+		    __field(unsigned short,	max_data)
+		    __field(u8,			jumbo_max)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer_debug_id = conn->peer->debug_id;
+		    __entry->call_debug_id = conn->pmtud_call;
+		    __entry->ping_serial = conn->pmtud_probe;
+		    __entry->resp_serial = resp_serial;
+		    __entry->max_data = conn->peer->max_data;
+		    __entry->jumbo_max = conn->peer->pmtud_jumbo;
+			   ),
+
+	    TP_printk("P=%08x c=%08x pr=%08x rr=%08x max=%u jm=%u",
+		      __entry->peer_debug_id,
+		      __entry->call_debug_id,
+		      __entry->ping_serial,
+		      __entry->resp_serial,
+		      __entry->max_data,
+		      __entry->jumbo_max)
+	    );
+
+TRACE_EVENT(rxrpc_pmtud_lost,
+	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t resp_serial),
+
+	    TP_ARGS(conn, resp_serial),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	peer_debug_id)
+		    __field(unsigned int,	call_debug_id)
+		    __field(rxrpc_serial_t,	ping_serial)
+		    __field(rxrpc_serial_t,	resp_serial)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer_debug_id = conn->peer->debug_id;
+		    __entry->call_debug_id = conn->pmtud_call;
+		    __entry->ping_serial = conn->pmtud_probe;
+		    __entry->resp_serial = resp_serial;
+			   ),
+
+	    TP_printk("P=%08x c=%08x pr=%08x rr=%08x",
+		      __entry->peer_debug_id,
+		      __entry->call_debug_id,
+		      __entry->ping_serial,
+		      __entry->resp_serial)
+	    );
+
+TRACE_EVENT(rxrpc_pmtud_reduce,
+	    TP_PROTO(struct rxrpc_peer *peer, rxrpc_serial_t serial,
+		     unsigned int max_data, enum rxrpc_pmtud_reduce_trace reason),
+
+	    TP_ARGS(peer, serial, max_data, reason),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	peer_debug_id)
+		    __field(rxrpc_serial_t,	serial)
+		    __field(unsigned int,	max_data)
+		    __field(enum rxrpc_pmtud_reduce_trace, reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->peer_debug_id = peer->debug_id;
+		    __entry->serial = serial;
+		    __entry->max_data = max_data;
+		    __entry->reason = reason;
+			   ),
+
+	    TP_printk("P=%08x %s r=%08x m=%u",
+		      __entry->peer_debug_id,
+		      __print_symbolic(__entry->reason, rxrpc_pmtud_reduce_traces),
+		      __entry->serial, __entry->max_data)
+	    );
+
 #undef EM
 #undef E_
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ab8e565cb20b..69e6f4b20bad 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -344,13 +344,25 @@ struct rxrpc_peer {
 	time64_t		last_tx_at;	/* Last time packet sent here */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
-	unsigned int		if_mtu;		/* interface MTU for this peer */
-	unsigned int		mtu;		/* network MTU for this peer */
-	unsigned int		maxdata;	/* data size (MTU - hdrsize) */
-	unsigned short		hdrsize;	/* header size (IP + UDP + RxRPC) */
 	int			debug_id;	/* debug ID for printks */
 	struct sockaddr_rxrpc	srx;		/* remote address */
 
+	/* Path MTU discovery [RFC8899] */
+	unsigned int		pmtud_trial;	/* Current MTU probe size */
+	unsigned int		pmtud_good;	/* Largest working MTU probe we've tried */
+	unsigned int		pmtud_bad;	/* Smallest non-working MTU probe we've tried */
+	bool			pmtud_lost;	/* T if MTU probe was lost */
+	bool			pmtud_probing;	/* T if we have an active probe outstanding */
+	bool			pmtud_pending;	/* T if a call to this peer should send a probe */
+	u8			pmtud_jumbo;	/* Max jumbo packets for the MTU */
+	bool			ackr_adv_pmtud;	/* T if the peer advertises path-MTU */
+	unsigned int		ackr_max_data;	/* Maximum data advertised by peer */
+	seqcount_t		mtu_lock;	/* Lockless MTU access management */
+	unsigned int		if_mtu;		/* Local interface MTU (- hdrsize) for this peer */
+	unsigned int		max_data;	/* Maximum packet data capacity for this peer */
+	unsigned short		hdrsize;	/* header size (IP + UDP + RxRPC) */
+	unsigned short		tx_seg_max;	/* Maximum number of transmissable segments */
+
 	/* calculated RTT cache */
 #define RXRPC_RTT_CACHE_SIZE 32
 	spinlock_t		rtt_input_lock;	/* RTT lock for input routine */
@@ -531,6 +543,8 @@ struct rxrpc_connection {
 	int			debug_id;	/* debug ID for printks */
 	rxrpc_serial_t		tx_serial;	/* Outgoing packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
+	rxrpc_serial_t		pmtud_probe;	/* Serial of MTU probe (or 0) */
+	unsigned int		pmtud_call;	/* ID of call used for probe */
 	u32			service_id;	/* Service ID, possibly upgraded */
 	u32			security_level;	/* Security level selected */
 	u8			security_ix;	/* security type */
@@ -1155,6 +1169,7 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
  */
 void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why);
+void rxrpc_send_probe_for_pmtud(struct rxrpc_call *call);
 int rxrpc_send_abort_packet(struct rxrpc_call *);
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
@@ -1166,6 +1181,8 @@ void rxrpc_transmit_one(struct rxrpc_call *call, struct rxrpc_txbuf *txb);
  */
 void rxrpc_input_error(struct rxrpc_local *, struct sk_buff *);
 void rxrpc_peer_keepalive_worker(struct work_struct *);
+void rxrpc_input_probe_for_pmtud(struct rxrpc_connection *conn, rxrpc_serial_t acked_serial,
+				 bool sendmsg_fail);
 
 /*
  * peer_object.c
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index c4754cc9b8d4..1d889b6f0366 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -483,6 +483,11 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 			rxrpc_disconnect_call(call);
 		if (call->security)
 			call->security->free_call_crypto(call);
+	} else {
+		if (skb &&
+		    call->peer->ackr_adv_pmtud &&
+		    call->peer->pmtud_pending)
+			rxrpc_send_probe_for_pmtud(call);
 	}
 	if (call->acks_hard_ack != call->tx_bottom)
 		rxrpc_shrink_call_tx_buffer(call);
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 2a1396cd892f..511e1208a748 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -92,7 +92,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	struct rxrpc_acktrailer trailer;
 	size_t len;
 	int ret, ioc;
-	u32 serial, mtu, call_id, padding;
+	u32 serial, max_mtu, if_mtu, call_id, padding;
 
 	_enter("%d", conn->debug_id);
 
@@ -150,8 +150,11 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		break;
 
 	case RXRPC_PACKET_TYPE_ACK:
-		mtu = conn->peer->if_mtu;
-		mtu -= conn->peer->hdrsize;
+		if_mtu = conn->peer->if_mtu - conn->peer->hdrsize;
+		if (conn->peer->ackr_adv_pmtud)
+			max_mtu = umax(conn->peer->max_data, rxrpc_rx_mtu);
+		else
+			max_mtu = if_mtu = umin(1444, if_mtu);
 		pkt.ack.bufferSpace	= 0;
 		pkt.ack.maxSkew		= htons(skb ? skb->priority : 0);
 		pkt.ack.firstPacket	= htonl(chan->last_seq + 1);
@@ -159,10 +162,10 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		pkt.ack.serial		= htonl(skb ? sp->hdr.serial : 0);
 		pkt.ack.reason		= skb ? RXRPC_ACK_DUPLICATE : RXRPC_ACK_IDLE;
 		pkt.ack.nAcks		= 0;
-		trailer.maxMTU		= htonl(rxrpc_rx_mtu);
-		trailer.ifMTU		= htonl(mtu);
+		trailer.maxMTU		= htonl(max_mtu);
+		trailer.ifMTU		= htonl(if_mtu);
 		trailer.rwind		= htonl(rxrpc_rx_window_size);
-		trailer.jumbo_max	= htonl(rxrpc_rx_jumbo_max);
+		trailer.jumbo_max	= 0;
 		pkt.whdr.flags		|= RXRPC_SLOW_START_OK;
 		padding			= 0;
 		iov[0].iov_len += sizeof(pkt.ack);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 694c4df7a1a3..b0627398311b 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -321,6 +321,12 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	list_del_init(&conn->proc_link);
 	write_unlock(&rxnet->conn_lock);
 
+	if (conn->pmtud_probe) {
+		trace_rxrpc_pmtud_lost(conn, 0);
+		conn->peer->pmtud_probing = false;
+		conn->peer->pmtud_pending = true;
+	}
+
 	rxrpc_purge_queue(&conn->rx_queue);
 
 	rxrpc_kill_client_conn(conn);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 49e35be7dc13..fd08d813ef29 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -692,8 +692,8 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 				    struct rxrpc_acktrailer *trailer)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_peer *peer;
-	unsigned int mtu;
+	struct rxrpc_peer *peer = call->peer;
+	unsigned int max_data;
 	bool wake = false;
 	u32 rwind = ntohl(trailer->rwind);
 
@@ -706,14 +706,22 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		call->tx_winsize = rwind;
 	}
 
-	mtu = umin(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
+	if (trailer->jumbo_max == 0) {
+		/* The peer says it supports pmtu discovery */
+		peer->ackr_adv_pmtud = true;
+	} else {
+		peer->ackr_adv_pmtud = false;
+	}
+
+	max_data = ntohl(trailer->maxMTU);
+	peer->ackr_max_data = max_data;
 
-	peer = call->peer;
-	if (mtu < peer->maxdata) {
-		spin_lock(&peer->lock);
-		peer->maxdata = mtu;
-		peer->mtu = mtu + peer->hdrsize;
-		spin_unlock(&peer->lock);
+	if (max_data < peer->max_data) {
+		trace_rxrpc_pmtud_reduce(peer, sp->hdr.serial, max_data,
+					 rxrpc_pmtud_reduce_ack);
+		write_seqcount_begin(&peer->mtu_lock);
+		peer->max_data = max_data;
+		write_seqcount_end(&peer->mtu_lock);
 	}
 
 	if (wake)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 7af5adf53b25..bd6d4f5e97b4 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -364,6 +364,12 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 	if (sp->hdr.callNumber == 0)
 		return rxrpc_input_conn_packet(conn, skb);
 
+	/* Deal with path MTU discovery probing. */
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_ACK &&
+	    conn->pmtud_probe &&
+	    after_eq(sp->ack.acked_serial, conn->pmtud_probe))
+		rxrpc_input_probe_for_pmtud(conn, sp->ack.acked_serial, false);
+
 	/* Call-bound packets are routed by connection channel. */
 	channel = sp->hdr.cid & RXRPC_CHANNELMASK;
 	chan = &conn->channels[channel];
diff --git a/net/rxrpc/misc.c b/net/rxrpc/misc.c
index 657cf35089a6..8fcc8139d771 100644
--- a/net/rxrpc/misc.c
+++ b/net/rxrpc/misc.c
@@ -46,13 +46,13 @@ unsigned int rxrpc_rx_window_size = 255;
  * Maximum Rx MTU size.  This indicates to the sender the size of jumbo packet
  * made by gluing normal packets together that we're willing to handle.
  */
-unsigned int rxrpc_rx_mtu = 5692;
+unsigned int rxrpc_rx_mtu = RXRPC_JUMBO(46);
 
 /*
  * The maximum number of fragments in a received jumbo packet that we tell the
  * sender that we're willing to handle.
  */
-unsigned int rxrpc_rx_jumbo_max = 4;
+unsigned int rxrpc_rx_jumbo_max = 46;
 
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 /*
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index f8bb5250e849..9168c149444c 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -82,10 +82,9 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_acktrailer *trailer = txb->kvec[2].iov_base + 3;
 	struct rxrpc_ackpacket *ack = (struct rxrpc_ackpacket *)(whdr + 1);
-	unsigned int qsize, sack, wrap, to;
+	unsigned int qsize, sack, wrap, to, max_mtu, if_mtu;
 	rxrpc_seq_t window, wtop;
 	int rsize;
-	u32 mtu, jmax;
 	u8 *filler = txb->kvec[2].iov_base;
 	u8 *sackp = txb->kvec[1].iov_base;
 
@@ -132,16 +131,21 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *call,
 		ack->reason = RXRPC_ACK_IDLE;
 	}
 
-	mtu = call->peer->if_mtu;
-	mtu -= call->peer->hdrsize;
-	jmax = rxrpc_rx_jumbo_max;
 	qsize = (window - 1) - call->rx_consumed;
 	rsize = max_t(int, call->rx_winsize - qsize, 0);
 	txb->ack_rwind = rsize;
-	trailer->maxMTU		= htonl(rxrpc_rx_mtu);
-	trailer->ifMTU		= htonl(mtu);
+
+	if_mtu = call->peer->if_mtu - call->peer->hdrsize;
+	if (call->peer->ackr_adv_pmtud) {
+		max_mtu = umax(call->peer->max_data, rxrpc_rx_mtu);
+	} else {
+		max_mtu = if_mtu = umin(if_mtu, 1444);
+	}
+
+	trailer->maxMTU		= htonl(max_mtu);
+	trailer->ifMTU		= htonl(if_mtu);
 	trailer->rwind		= htonl(rsize);
-	trailer->jumbo_max	= htonl(jmax);
+	trailer->jumbo_max	= 0; /* Advertise pmtu discovery */
 }
 
 /*
@@ -176,7 +180,7 @@ static void rxrpc_begin_rtt_probe(struct rxrpc_call *call, rxrpc_serial_t serial
  * Transmit an ACK packet.
  */
 static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
-				  int nr_kv)
+				  int nr_kv, enum rxrpc_propose_ack_trace why)
 {
 	struct kvec *kv = call->local->kvec;
 	struct rxrpc_wire_header *whdr = kv[0].iov_base;
@@ -209,13 +213,16 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, kv, nr_kv, txb->len);
-	rxrpc_local_dont_fragment(conn->local, false);
+	rxrpc_local_dont_fragment(conn->local, why == rxrpc_propose_ack_ping_for_mtu_probe);
 
 	ret = do_udp_sendmsg(conn->local->socket, &msg, txb->len);
 	call->peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret,
 				    rxrpc_tx_point_call_ack);
+		if (why == rxrpc_propose_ack_ping_for_mtu_probe &&
+		    ret == -EMSGSIZE)
+			rxrpc_input_probe_for_pmtud(conn, txb->serial, true);
 	} else {
 		trace_rxrpc_tx_packet(call->debug_id, whdr,
 				      rxrpc_tx_point_call_ack);
@@ -225,6 +232,13 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		if (txb->flags & RXRPC_REQUEST_ACK)
 			call->peer->rtt_last_req = now;
 		rxrpc_set_keepalive(call, now);
+		if (why == rxrpc_propose_ack_ping_for_mtu_probe) {
+			call->peer->pmtud_pending = false;
+			call->peer->pmtud_probing = true;
+			call->conn->pmtud_probe = txb->serial;
+			call->conn->pmtud_call = call->debug_id;
+			trace_rxrpc_pmtud_tx(call);
+		}
 	}
 	rxrpc_tx_backoff(call, ret);
 }
@@ -254,21 +268,45 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 
 	rxrpc_fill_out_ack(call, txb, ack_reason, serial);
 
+	/* Extend a path MTU probe ACK. */
 	nr_kv = txb->nr_kvec;
 	kv[0] = txb->kvec[0];
 	kv[1] = txb->kvec[1];
 	kv[2] = txb->kvec[2];
-	// TODO: Extend a path MTU probe ACK
+	if (why == rxrpc_propose_ack_ping_for_mtu_probe) {
+		size_t probe_mtu = call->peer->pmtud_trial + sizeof(struct rxrpc_wire_header);
+
+		if (txb->len > probe_mtu)
+			goto skip;
+		while (txb->len < probe_mtu) {
+			size_t part = umin(probe_mtu - txb->len, PAGE_SIZE);
+
+			kv[nr_kv].iov_base = page_address(ZERO_PAGE(0));
+			kv[nr_kv].iov_len = part;
+			txb->len += part;
+			nr_kv++;
+		}
+	}
 
 	call->ackr_nr_unacked = 0;
 	atomic_set(&call->ackr_nr_consumed, 0);
 	clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags);
 
 	trace_rxrpc_send_ack(call, why, ack_reason, serial);
-	rxrpc_send_ack_packet(call, txb, nr_kv);
+	rxrpc_send_ack_packet(call, txb, nr_kv, why);
+skip:
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_ack_tx);
 }
 
+/*
+ * Send an ACK probe for path MTU discovery.
+ */
+void rxrpc_send_probe_for_pmtud(struct rxrpc_call *call)
+{
+	rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
+		       rxrpc_propose_ack_ping_for_mtu_probe);
+}
+
 /*
  * Send an ABORT call packet.
  */
@@ -501,7 +539,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */
-	if (len >= sizeof(struct rxrpc_wire_header) + call->peer->maxdata) {
+	if (len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
 	} else {
@@ -548,7 +586,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 						  RX_USER_ABORT, ret);
 	}
 
-	_leave(" = %d [%u]", ret, call->peer->maxdata);
+	_leave(" = %d [%u]", ret, call->peer->max_data);
 	return ret;
 }
 
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c..77fede060865 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -102,6 +102,8 @@ static struct rxrpc_peer *rxrpc_lookup_peer_local_rcu(struct rxrpc_local *local,
  */
 static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
 {
+	unsigned int max_data;
+
 	/* wind down the local interface MTU */
 	if (mtu > 0 && peer->if_mtu == 65535 && mtu < peer->if_mtu)
 		peer->if_mtu = mtu;
@@ -120,11 +122,17 @@ static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
 		}
 	}
 
-	if (mtu < peer->mtu) {
-		spin_lock(&peer->lock);
-		peer->mtu = mtu;
-		peer->maxdata = peer->mtu - peer->hdrsize;
-		spin_unlock(&peer->lock);
+	max_data = max_t(int, mtu - peer->hdrsize, 500);
+	if (max_data < peer->max_data) {
+		if (peer->pmtud_good > max_data)
+			peer->pmtud_good = max_data;
+		if (peer->pmtud_bad > max_data + 1)
+			peer->pmtud_bad = max_data + 1;
+
+		trace_rxrpc_pmtud_reduce(peer, 0, max_data, rxrpc_pmtud_reduce_icmp);
+		write_seqcount_begin(&peer->mtu_lock);
+		peer->max_data = max_data;
+		write_seqcount_end(&peer->mtu_lock);
 	}
 }
 
@@ -347,3 +355,87 @@ void rxrpc_peer_keepalive_worker(struct work_struct *work)
 
 	_leave("");
 }
+
+/*
+ * Do path MTU probing.
+ */
+void rxrpc_input_probe_for_pmtud(struct rxrpc_connection *conn, rxrpc_serial_t acked_serial,
+				 bool sendmsg_fail)
+{
+	struct rxrpc_peer *peer = conn->peer;
+	unsigned int max_data = peer->max_data;
+	int good, trial, bad, jumbo;
+
+	good  = peer->pmtud_good;
+	trial = peer->pmtud_trial;
+	bad   = peer->pmtud_bad;
+	if (good >= bad - 1) {
+		conn->pmtud_probe = 0;
+		peer->pmtud_lost = false;
+		return;
+	}
+
+	if (!peer->pmtud_probing)
+		goto send_probe;
+
+	if (sendmsg_fail || after(acked_serial, conn->pmtud_probe)) {
+		/* Retry a lost probe. */
+		if (!peer->pmtud_lost) {
+			trace_rxrpc_pmtud_lost(conn, acked_serial);
+			conn->pmtud_probe = 0;
+			peer->pmtud_lost = true;
+			goto send_probe;
+		}
+
+		/* The probed size didn't seem to get through. */
+		peer->pmtud_bad = bad = trial;
+		if (bad <= max_data)
+			max_data = bad - 1;
+	} else {
+		/* It did get through. */
+		peer->pmtud_good = good = trial;
+		if (good > max_data)
+			max_data = good;
+	}
+
+	max_data = umin(max_data, peer->ackr_max_data);
+	if (max_data != peer->max_data) {
+		preempt_disable();
+		write_seqcount_begin(&peer->mtu_lock);
+		peer->max_data = max_data;
+		write_seqcount_end(&peer->mtu_lock);
+		preempt_enable();
+	}
+
+	jumbo = max_data + sizeof(struct rxrpc_jumbo_header);
+	jumbo /= RXRPC_JUMBO_SUBPKTLEN;
+	peer->pmtud_jumbo = jumbo;
+
+	trace_rxrpc_pmtud_rx(conn, acked_serial);
+	conn->pmtud_probe = 0;
+	peer->pmtud_lost = false;
+
+	if (good < RXRPC_JUMBO(2) && bad > RXRPC_JUMBO(2))
+		trial = RXRPC_JUMBO(2);
+	else if (good < RXRPC_JUMBO(4) && bad > RXRPC_JUMBO(4))
+		trial = RXRPC_JUMBO(4);
+	else if (good < RXRPC_JUMBO(3) && bad > RXRPC_JUMBO(3))
+		trial = RXRPC_JUMBO(3);
+	else if (good < RXRPC_JUMBO(6) && bad > RXRPC_JUMBO(6))
+		trial = RXRPC_JUMBO(6);
+	else if (good < RXRPC_JUMBO(5) && bad > RXRPC_JUMBO(5))
+		trial = RXRPC_JUMBO(5);
+	else if (good < RXRPC_JUMBO(8) && bad > RXRPC_JUMBO(8))
+		trial = RXRPC_JUMBO(8);
+	else if (good < RXRPC_JUMBO(7) && bad > RXRPC_JUMBO(7))
+		trial = RXRPC_JUMBO(7);
+	else
+		trial = (good + bad) / 2;
+	peer->pmtud_trial = trial;
+
+	if (good >= bad)
+		return;
+
+send_probe:
+	peer->pmtud_pending = true;
+}
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 49dcda67a0d5..80ef6f06d512 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -162,6 +162,11 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 #endif
 
 	peer->if_mtu = 1500;
+	if (peer->max_data < peer->if_mtu - peer->hdrsize) {
+		trace_rxrpc_pmtud_reduce(peer, 0, peer->if_mtu - peer->hdrsize,
+					 rxrpc_pmtud_reduce_route);
+		peer->max_data = peer->if_mtu - peer->hdrsize;
+	}
 
 	memset(&fl, 0, sizeof(fl));
 	switch (peer->srx.transport.family) {
@@ -199,8 +204,16 @@ static void rxrpc_assess_MTU_size(struct rxrpc_local *local,
 	}
 
 	peer->if_mtu = dst_mtu(dst);
+	peer->hdrsize += dst->header_len + dst->trailer_len;
+	peer->tx_seg_max = dst->dev->gso_max_segs;
 	dst_release(dst);
 
+	peer->max_data		= umin(RXRPC_JUMBO(1), peer->if_mtu - peer->hdrsize);
+	peer->pmtud_good	= 500;
+	peer->pmtud_bad		= peer->if_mtu - peer->hdrsize + 1;
+	peer->pmtud_trial	= umin(peer->max_data, peer->pmtud_bad - 1);
+	peer->pmtud_pending	= true;
+
 	_leave(" [if_mtu %u]", peer->if_mtu);
 }
 
@@ -223,6 +236,7 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp,
 		seqlock_init(&peer->service_conn_lock);
 		spin_lock_init(&peer->lock);
 		spin_lock_init(&peer->rtt_input_lock);
+		seqcount_init(&peer->mtu_lock);
 		peer->debug_id = atomic_inc_return(&rxrpc_debug_id);
 
 		rxrpc_peer_init_rtt(peer);
@@ -242,9 +256,7 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 			    unsigned long hash_key)
 {
 	peer->hash_key = hash_key;
-	rxrpc_assess_MTU_size(local, peer);
-	peer->mtu = peer->if_mtu;
-	peer->rtt_last_req = ktime_get_real();
+
 
 	switch (peer->srx.transport.family) {
 	case AF_INET:
@@ -268,7 +280,11 @@ static void rxrpc_init_peer(struct rxrpc_local *local, struct rxrpc_peer *peer,
 	}
 
 	peer->hdrsize += sizeof(struct rxrpc_wire_header);
-	peer->maxdata = peer->mtu - peer->hdrsize;
+	peer->max_data = peer->if_mtu - peer->hdrsize;
+
+	rxrpc_assess_MTU_size(local, peer);
+
+	peer->rtt_last_req = ktime_get_real();
 }
 
 /*
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index ce4d48bdfbe9..1f1387cf62c8 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -285,7 +285,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 		seq_puts(seq,
 			 "Proto Local                                          "
 			 " Remote                                         "
-			 " Use SST   MTU LastUse      RTT      RTO\n"
+			 " Use SST   Maxd LastUse      RTT      RTO\n"
 			 );
 		return 0;
 	}
@@ -299,12 +299,12 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 	now = ktime_get_seconds();
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %3u"
-		   " %3u %5u %6llus %8u %8u\n",
+		   " %4u %5u %6llus %8u %8u\n",
 		   lbuff,
 		   rbuff,
 		   refcount_read(&peer->ref),
 		   peer->cong_ssthresh,
-		   peer->mtu,
+		   peer->max_data,
 		   now - peer->last_tx_at,
 		   peer->srtt_us >> 3,
 		   peer->rto_us);
diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index 4fe6b4d20ada..77d64404ddd0 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -92,11 +92,16 @@ struct rxrpc_jumbo_header {
 /*
  * The maximum number of subpackets that can possibly fit in a UDP packet is:
  *
- *	((max_IP - IP_hdr - UDP_hdr) / RXRPC_JUMBO_SUBPKTLEN) + 1
- *	= ((65535 - 28 - 28) / 1416) + 1
- *	= 46 non-terminal packets and 1 terminal packet.
+ *	(max_UDP - wirehdr + jumbohdr) / (jumbohdr + 1412)
+ *	= ((65535 - 28 + 4) / 1416) 
+ *	= 45 non-terminal packets and 1 terminal packet.
  */
-#define RXRPC_MAX_NR_JUMBO	47
+#define RXRPC_MAX_NR_JUMBO	46
+
+/* Size of a jumbo packet with N subpackets, excluding UDP+IP */
+#define RXRPC_JUMBO(N) ((int)sizeof(struct rxrpc_wire_header) + \
+			RXRPC_JUMBO_DATALEN +				\
+			((N) - 1) * RXRPC_JUMBO_SUBPKTLEN)
 
 /*****************************************************************************/
 /*
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index 9bf9a1f6e4cb..46a20cf4c402 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -11,6 +11,8 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
+static const unsigned int rxrpc_rx_mtu_min = 500;
+static const unsigned int rxrpc_jumbo_max = RXRPC_MAX_NR_JUMBO;
 static const unsigned int four = 4;
 static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
 static const unsigned int n_65535 = 65535;
@@ -115,7 +117,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
+		.extra1		= (void *)&rxrpc_rx_mtu_min,
 		.extra2		= (void *)&n_65535,
 	},
 	{
@@ -125,7 +127,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&four,
+		.extra2		= (void *)&rxrpc_jumbo_max,
 	},
 };
 
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index c3913d8a50d3..2a4291617d40 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -179,7 +179,8 @@ static void rxrpc_free_txbuf(struct rxrpc_txbuf *txb)
 	trace_rxrpc_txbuf(txb->debug_id, txb->call_debug_id, txb->seq, 0,
 			  rxrpc_txbuf_free);
 	for (i = 0; i < txb->nr_kvec; i++)
-		if (txb->kvec[i].iov_base)
+		if (txb->kvec[i].iov_base &&
+		    !is_zero_pfn(page_to_pfn(virt_to_page(txb->kvec[i].iov_base))))
 			page_frag_free(txb->kvec[i].iov_base);
 	kfree(txb);
 	atomic_dec(&rxrpc_nr_txbuf);


