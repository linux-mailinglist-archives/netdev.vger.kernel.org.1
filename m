Return-Path: <netdev+bounces-148873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8669E34A1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1BB30C57
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27591C1F13;
	Wed,  4 Dec 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD7+IJ/0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C91C1AA9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298556; cv=none; b=qLhtmC5lq3K/xnD2iGlzlFe1gEKLRjMehl0+t8Z/wxpT3CzZYLX7N2vTKF5DRD6hKC06TuaQteK1wSQQNlkKEIK9THXhwzbo3yAp8DuUq+QplKxmTE9dAmdh8Rf1mkreuvdKIfut8hFK3dC0moyL154um7asOPbNbuEFSEifsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298556; c=relaxed/simple;
	bh=tK9CEy1CIpIjwAX+ilTQ9kE3jrph0RfC2ZC1auwvmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtcoQO3mBdZ9rrFX7kgANUBsbVVFOEm3X8qxVIkdeh8mpQ5BZMTT76js1ie6QL39w4tf0t4l2NMzZyHGmc1OKFqQ3bZoTwjs+YncLkThpd1R3cOG/4QKUdTS74fiLNPSR6HIgBucK9Qwx44+gxFi8b5UVIYjjRSsT4hh7EXZ9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SD7+IJ/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZrRzk/s9nUon9TCg/3caLMbcRXaPdQa2A2SZg/kig4=;
	b=SD7+IJ/0/J1++aM6hg2Qa8BUYKIkS1M/AHbfPzrwHFxm6GMbpOx14UnQgS3E50fD6S0CPn
	5GLC8svuoGraPS9HHszmWXYChWNILacthI8S4kdQk1qCFnWUS+Wko39LpascguJRbxhRVV
	9b/B+2x8yjdt4XOFDxjoLHo6qd2EzBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-6fQHhzThMHqWEdXxwwsRiw-1; Wed,
 04 Dec 2024 02:49:10 -0500
X-MC-Unique: 6fQHhzThMHqWEdXxwwsRiw-1
X-Mimecast-MFC-AGG-ID: 6fQHhzThMHqWEdXxwwsRiw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63BDE1956088;
	Wed,  4 Dec 2024 07:49:09 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE41A3000197;
	Wed,  4 Dec 2024 07:49:06 +0000 (UTC)
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
Subject: [PATCH net-next v2 27/39] rxrpc: Adjust the rxrpc_rtt_rx tracepoint
Date: Wed,  4 Dec 2024 07:46:55 +0000
Message-ID: <20241204074710.990092-28-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adjust the rxrpc_rtt_rx tracepoint in the following ways:

 (1) Display the collected RTT sample in the rxrpc_rtt_rx trace.

 (2) Move the division of srtt by 8 to the TP_printk() rather doing it
     before invoking the trace point.

 (3) Display the min_rtt value.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 14 ++++++++++----
 net/rxrpc/input.c            |  4 ++--
 net/rxrpc/rtt.c              |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 798bea0853c4..6e929f4448ac 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1415,9 +1415,9 @@ TRACE_EVENT(rxrpc_rtt_rx,
 	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 		     int slot,
 		     rxrpc_serial_t send_serial, rxrpc_serial_t resp_serial,
-		     u32 rtt, u32 rto),
+		     u32 rtt, u32 srtt, u32 rto),
 
-	    TP_ARGS(call, why, slot, send_serial, resp_serial, rtt, rto),
+	    TP_ARGS(call, why, slot, send_serial, resp_serial, rtt, srtt, rto),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
@@ -1426,7 +1426,9 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __field(rxrpc_serial_t,		send_serial)
 		    __field(rxrpc_serial_t,		resp_serial)
 		    __field(u32,			rtt)
+		    __field(u32,			srtt)
 		    __field(u32,			rto)
+		    __field(u32,			min_rtt)
 			     ),
 
 	    TP_fast_assign(
@@ -1436,17 +1438,21 @@ TRACE_EVENT(rxrpc_rtt_rx,
 		    __entry->send_serial = send_serial;
 		    __entry->resp_serial = resp_serial;
 		    __entry->rtt = rtt;
+		    __entry->srtt = srtt;
 		    __entry->rto = rto;
+		    __entry->min_rtt = minmax_get(&call->peer->min_rtt)
 			   ),
 
-	    TP_printk("c=%08x [%d] %s sr=%08x rr=%08x rtt=%u rto=%u",
+	    TP_printk("c=%08x [%d] %s sr=%08x rr=%08x rtt=%u srtt=%u rto=%u min=%u",
 		      __entry->call,
 		      __entry->slot,
 		      __print_symbolic(__entry->why, rxrpc_rtt_rx_traces),
 		      __entry->send_serial,
 		      __entry->resp_serial,
 		      __entry->rtt,
-		      __entry->rto)
+		      __entry->srtt / 8,
+		      __entry->rto,
+		      __entry->min_rtt)
 	    );
 
 TRACE_EVENT(rxrpc_timer_set,
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c682e95e15dc..1eb9c22aba51 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -740,7 +740,7 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 		 */
 		if (after(acked_serial, orig_serial)) {
 			trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_obsolete, i,
-					   orig_serial, acked_serial, 0, 0);
+					   orig_serial, acked_serial, 0, 0, 0);
 			clear_bit(i + RXRPC_CALL_RTT_PEND_SHIFT, &call->rtt_avail);
 			smp_wmb();
 			set_bit(i, &call->rtt_avail);
@@ -748,7 +748,7 @@ static void rxrpc_complete_rtt_probe(struct rxrpc_call *call,
 	}
 
 	if (!matched)
-		trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_lost, 9, 0, acked_serial, 0, 0);
+		trace_rxrpc_rtt_rx(call, rxrpc_rtt_rx_lost, 9, 0, acked_serial, 0, 0, 0);
 }
 
 /*
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index 8048467f4bee..e0b7d99854b4 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -175,7 +175,7 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 	spin_unlock(&peer->rtt_input_lock);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,
-			   peer->srtt_us >> 3, peer->rto_us);
+			   rtt_us, peer->srtt_us, peer->rto_us);
 }
 
 /*


