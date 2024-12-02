Return-Path: <netdev+bounces-148094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FD9E054E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718DA2844CD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0D2144BD;
	Mon,  2 Dec 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUVu9TKx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17A20FA9B
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149975; cv=none; b=EesJLgfieku1hSm7zkwcqUEg3Kfm8nNUzVX9+QmUPzcPws/MJPWfqGdGl6RbgrmbbhCbCcRHzPDZcR348teEw8W+QRpftvsu4cQsk4hkc7dus/24vbONEQXohTdT6qyJUEMaK7NabmemHTbSfyCkeL+yRkLqsGMgP5Sz265S9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149975; c=relaxed/simple;
	bh=Mvn0JXv++avOlIY0IIQ+hCK2ymy43mWJlQe109HoEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJL1+GCmpwlnc/S9uIgjVO8GIg1Jzi+7qQVDwnIPQ9vBSicB8Wn0msNUzBgbIpg5F8wNbAk8G/b1iH6nDGZ5nUNmNPrjDb2/CWFOeItVu0dIYiSAq3Hb0vAn9EaiFXh+aO2yhnsjGmjg+/ZF0S2i4YvsgV66nQxezL2j/rky5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUVu9TKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y55T7HoQEza48UwwqzlNDQyRFxdL8sX9c/2gYlUdy9I=;
	b=gUVu9TKxPBKVJws5WeXMg6OWfB9DcWb7LRpJp45228wuGsx/7qTkvcMG3mhg0KpdUl+Kmg
	asQUvu96ATM3pKZ7cxh/8OsupddV8KjHlFm2LZS4OgcQX85MmMhYRlAlQFEh97HtvwEp10
	WkM55dNNaq/ai1IPt1paKB+CYetJdzE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Nwmwsh-JNCOThw0SowqiIw-1; Mon,
 02 Dec 2024 09:32:49 -0500
X-MC-Unique: Nwmwsh-JNCOThw0SowqiIw-1
X-Mimecast-MFC-AGG-ID: Nwmwsh-JNCOThw0SowqiIw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAD131944D24;
	Mon,  2 Dec 2024 14:32:46 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28A68195605A;
	Mon,  2 Dec 2024 14:32:43 +0000 (UTC)
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
Subject: [PATCH net-next 25/37] rxrpc: Adjust the rxrpc_rtt_rx tracepoint
Date: Mon,  2 Dec 2024 14:30:43 +0000
Message-ID: <20241202143057.378147-26-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index eb467c3f06da..849c49a8229a 100644
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


