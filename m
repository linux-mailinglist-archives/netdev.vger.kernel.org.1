Return-Path: <netdev+bounces-148103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF239E05A2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26EC167F40
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D121948E;
	Mon,  2 Dec 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du8NFaeg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF186219487
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150013; cv=none; b=J5HteIZvNktPQrieBGH6hoaMZn6TiOBJlzx7UwUvdFf1dYBlofw0c6HNd7A/A7/7TNPEoNUH0r4fK3oo/3PXuFemPym3yEQ1EbquZQjZTJlKLXsvZO8JLLpXLtVdfQu3otRv6q0hpSWFdRT91eVDIkNqHyokzN2zg6oW8u03rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150013; c=relaxed/simple;
	bh=nbTSDzhcH4lyvr+F7+lLS0fDNJdgv68R+O+CXUy/0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opkaB3lsH0PlJDBuQMvECW2exADD9p3RBIieFhleT3InDio9JZRa7+CO/nOj7z1sBAY/EXcjHhzAes/U2TroX/KTfA0tfZexFPYPBQbNPqrwz2VgVo6sUwS/hkP/Yu9CS9zrsa1Q2vqj5viHQlz/DKzNaRr8frsnCL9gEk63cQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Du8NFaeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbGQyHdP2L2HHjYVWzByAsDoksyySzbwmjdX/j9/yy4=;
	b=Du8NFaegC5skHn+HMtnFDiRLmBTi4ruD371JOO+68OBIBvgz6Di2x7+3cERQQe4FJsnp5j
	NIikQySq6PkD5GaVq5D06IC6bpYy6Lk1v2s/wJAssRODUvJ+/ie35Tn5qPRsK2Pzuj6JMK
	j/d86O839OJjGxSPc6MiP0sa70RR0ws=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-psHDplDKO4yrfRGbpaxaFA-1; Mon,
 02 Dec 2024 09:33:25 -0500
X-MC-Unique: psHDplDKO4yrfRGbpaxaFA-1
X-Mimecast-MFC-AGG-ID: psHDplDKO4yrfRGbpaxaFA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 689B31953962;
	Mon,  2 Dec 2024 14:33:24 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7BF81956052;
	Mon,  2 Dec 2024 14:33:21 +0000 (UTC)
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
Subject: [PATCH net-next 34/37] rxrpc: Add a reason indicator to the tx_ack tracepoint
Date: Mon,  2 Dec 2024 14:30:52 +0000
Message-ID: <20241202143057.378147-35-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Record the reason for the transmission of an ACK in the rxrpc_tx_ack
tracepoint, and not just in the rxrpc_propose_ack tracepoint.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 13 +++++++++----
 net/rxrpc/conn_event.c       |  3 ++-
 net/rxrpc/output.c           |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d79623fff746..0cfc8e1baf1f 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -375,6 +375,7 @@
 	EM(rxrpc_propose_ack_processing_op,	"ProcOp ") \
 	EM(rxrpc_propose_ack_respond_to_ack,	"Rsp2Ack") \
 	EM(rxrpc_propose_ack_respond_to_ping,	"Rsp2Png") \
+	EM(rxrpc_propose_ack_retransmit,	"Retrans") \
 	EM(rxrpc_propose_ack_retry_tx,		"RetryTx") \
 	EM(rxrpc_propose_ack_rotate_rx,		"RxAck  ") \
 	EM(rxrpc_propose_ack_rx_idle,		"RxIdle ") \
@@ -1267,9 +1268,10 @@ TRACE_EVENT(rxrpc_tx_data,
 TRACE_EVENT(rxrpc_tx_ack,
 	    TP_PROTO(unsigned int call, rxrpc_serial_t serial,
 		     rxrpc_seq_t ack_first, rxrpc_serial_t ack_serial,
-		     u8 reason, u8 n_acks, u16 rwind),
+		     u8 reason, u8 n_acks, u16 rwind,
+		     enum rxrpc_propose_ack_trace trace),
 
-	    TP_ARGS(call, serial, ack_first, ack_serial, reason, n_acks, rwind),
+	    TP_ARGS(call, serial, ack_first, ack_serial, reason, n_acks, rwind, trace),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,	call)
@@ -1279,6 +1281,7 @@ TRACE_EVENT(rxrpc_tx_ack,
 		    __field(u8,			reason)
 		    __field(u8,			n_acks)
 		    __field(u16,		rwind)
+		    __field(enum rxrpc_propose_ack_trace, trace)
 			     ),
 
 	    TP_fast_assign(
@@ -1289,16 +1292,18 @@ TRACE_EVENT(rxrpc_tx_ack,
 		    __entry->reason = reason;
 		    __entry->n_acks = n_acks;
 		    __entry->rwind = rwind;
+		    __entry->trace = trace;
 			   ),
 
-	    TP_printk(" c=%08x ACK  %08x %s f=%08x r=%08x n=%u rw=%u",
+	    TP_printk(" c=%08x ACK  %08x %s f=%08x r=%08x n=%u rw=%u %s",
 		      __entry->call,
 		      __entry->serial,
 		      __print_symbolic(__entry->reason, rxrpc_ack_names),
 		      __entry->ack_first,
 		      __entry->ack_serial,
 		      __entry->n_acks,
-		      __entry->rwind)
+		      __entry->rwind,
+		      __print_symbolic(__entry->trace, rxrpc_propose_ack_traces))
 	    );
 
 TRACE_EVENT(rxrpc_receive,
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index b6f15d15ecac..d669f82281e4 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -175,7 +175,8 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 		trace_rxrpc_tx_ack(chan->call_debug_id, serial,
 				   ntohl(pkt.ack.firstPacket),
 				   ntohl(pkt.ack.serial),
-				   pkt.ack.reason, 0, rxrpc_rx_window_size);
+				   pkt.ack.reason, 0, rxrpc_rx_window_size,
+				   rxrpc_propose_ack_retransmit);
 		break;
 
 	default:
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 47796f451895..36c2597768d6 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -266,7 +266,7 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *call, int nr_kv, size_t len
 	trace_rxrpc_tx_ack(call->debug_id, serial,
 			   ntohl(ack->firstPacket),
 			   ntohl(ack->serial), ack->reason, ack->nAcks,
-			   ntohl(trailer->rwind));
+			   ntohl(trailer->rwind), why);
 
 	rxrpc_inc_stat(call->rxnet, stat_tx_ack_send);
 


