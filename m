Return-Path: <netdev+bounces-148871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD069E3491
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D83281230
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF61B85D7;
	Wed,  4 Dec 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaTiV+G9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FE1B6D14
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298546; cv=none; b=ty6gDPID7vAvNwvxLMDDXh4kS0VPayknOMULXAJcjvb4ZoaY4FvpxMjok1jPEbOABK+OUQ1AfcoKVgDMOwzLQ6R7kXktKq4b1YGEUw8XJqAaHy9gx3MJAkck3wduX/unRqQrxP8zb0kZTGg3ssUN0MVu0jRHGZK0SFXXZlspi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298546; c=relaxed/simple;
	bh=SUSeeCpo3fJtPlSnWodgXvhrV0YL7exdUNFHf+eIFJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mro3ke0iNhQoXNb+V3pyozvzAedAznWbOygI2IGC+lS+5UkqzjcG9MrGkArEUdjlA95PQLB7VaMUChyyZbKxUYRZpnF585kY8Ch2YRh2LTwHS0CHgXcITA+OtYW3GXwZwAgk5BJIvy3wfLZ9ql7B7GiR+QifC6i9BJtY5SNebMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaTiV+G9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYNqwQ+r9bHBO6fnf+nYpMYD43+gr4F/tj7hJd7FZHo=;
	b=DaTiV+G9Pr0YB9vQmeAjy0KRp1Il9RW7mGoInwSTeqc9kThh1tofFrQ5jQxreaWQqcEFZu
	A/04giuhcT5QRhz1s/uoOejPqHwV5fXzTgHYYAjhB3TcALAqKJ37CuivsRtMhd1GTAt2ca
	mOpnalEeXEI9F5fDQ6Xg55ygH3eiUEI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-wAQLODvDNGmP7N5RHjQ3vw-1; Wed,
 04 Dec 2024 02:49:02 -0500
X-MC-Unique: wAQLODvDNGmP7N5RHjQ3vw-1
X-Mimecast-MFC-AGG-ID: wAQLODvDNGmP7N5RHjQ3vw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 331661955DD8;
	Wed,  4 Dec 2024 07:49:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A77E519560A2;
	Wed,  4 Dec 2024 07:48:58 +0000 (UTC)
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
Subject: [PATCH net-next v2 25/39] rxrpc: Don't use received skbuff timestamps
Date: Wed,  4 Dec 2024 07:46:53 +0000
Message-ID: <20241204074710.990092-26-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Don't use received skbuff timestamps, but rather set a timestamp when an
ack is processed so that the time taken to get to rxrpc_input_ack() is
included in the RTT.

The timestamp of the latest ACK received is tracked in
call->acks_latest_ts.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/input.c        | 19 ++++++++++---------
 net/rxrpc/local_object.c |  3 ---
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 41b4fb56f96c..c682e95e15dc 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1037,14 +1037,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	rxrpc_inc_stat(call->rxnet, stat_rx_acks[summary.ack_reason]);
 	prefetch(call->tx_queue);
 
-	if (summary.acked_serial != 0) {
-		if (summary.ack_reason == RXRPC_ACK_PING_RESPONSE)
-			rxrpc_complete_rtt_probe(call, skb->tstamp, summary.acked_serial,
-						 ack_serial, rxrpc_rtt_rx_ping_response);
-		else
-			summary.rtt_sample_avail = true;
-	}
-
 	/* If we get an EXCEEDS_WINDOW ACK from the server, it probably
 	 * indicates that the client address changed due to NAT.  The server
 	 * lost the call because it switched to a different peer.
@@ -1087,7 +1079,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0)
 		skb_condense(skb);
 
-	call->acks_latest_ts = skb->tstamp;
+	call->acks_latest_ts = ktime_get_real();
 	call->acks_hard_ack = hard_ack;
 	call->acks_prev_seq = prev_pkt;
 
@@ -1108,6 +1100,15 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (hard_ack + 1 == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
 
+	if (summary.acked_serial != 0) {
+		if (summary.ack_reason == RXRPC_ACK_PING_RESPONSE)
+			rxrpc_complete_rtt_probe(call, call->acks_latest_ts,
+						 summary.acked_serial, ack_serial,
+						 rxrpc_rtt_rx_ping_response);
+		else
+			summary.rtt_sample_avail = true;
+	}
+
 	/* Ignore ACKs unless we are or have just been transmitting. */
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 2792d2304605..a74a4b43904f 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -215,9 +215,6 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 		/* we want to set the don't fragment bit */
 		rxrpc_local_dont_fragment(local, true);
-
-		/* We want receive timestamps. */
-		sock_enable_timestamps(usk);
 		break;
 
 	default:


