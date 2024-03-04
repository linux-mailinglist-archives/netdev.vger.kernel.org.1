Return-Path: <netdev+bounces-76985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570686FC23
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104E7282B63
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8922611;
	Mon,  4 Mar 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exl8Dd0z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA3224C7
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541821; cv=none; b=iQl3OtsZbd++OY2ZGFRRG5hSHYFYvRlf3RTrM35E2+Uhct5GtUhcMYGeDGQUNHo+xJ/X/UTV3YfnZ5sdQE0fGbz9kMLc+ajN+RKbfgE90kRfb8P3vFGc/YHWCeRMXuygdJmT6bhzBR9py9sjNcQwvSCUzq5hyq+Zs2og7STDO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541821; c=relaxed/simple;
	bh=0raf8PRlraWnPhbn6SRbKPcBod2VJHcvfxva3reVfio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDn5fb4e1Xso+mWJBhOxkH3je6SgWodaNSx9WbCzUsZXJLsHwRELzI6umlzSxvQ9bSo8NPNMkj66txoFhecyWXvHfkgfgdIWs2jFz9Guf0VVcuUeup/9hRFFH9t1LD7tfgrGR5c0D9JenKWWn1SNTMFBSJQk5MxhbrOw8GGrNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Exl8Dd0z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol9Zm5BaokJG1LA5SA9PnxgRsE5CFPeI5pD0RB5to08=;
	b=Exl8Dd0zkHAGnEGWtQnLsYQsoof9zV/3GgLQmdeqS9jEmi/mPiVjiPiYqGf03egwdk1zT1
	HWbOcsAC16yKhu57Gw0h75NhgcI20NAGOkzqgfwAErZcZHRaoTz0KptLa9P4a3oU5S4nZi
	yDEKEvb/VjEjhUWg4FNDLE8CQlHrQFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Lx9SgLAkNySWxjizXIlCoQ-1; Mon, 04 Mar 2024 03:43:37 -0500
X-MC-Unique: Lx9SgLAkNySWxjizXIlCoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BC78489A0;
	Mon,  4 Mar 2024 08:43:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C271120229A4;
	Mon,  4 Mar 2024 08:43:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 06/21] rxrpc: Remove atomic handling on some fields only used in I/O thread
Date: Mon,  4 Mar 2024 08:43:03 +0000
Message-ID: <20240304084322.705539-7-dhowells@redhat.com>
In-Reply-To: <20240304084322.705539-1-dhowells@redhat.com>
References: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

call->tx_transmitted and call->acks_prev_seq don't need to be managed with
cmpxchg() and barriers as it's only used within the singular I/O thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 10 ++++------
 net/rxrpc/output.c     |  8 +++-----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 84eedbb49fcb..1184518dcdb8 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -115,7 +115,7 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
 	unsigned long resend_at;
-	rxrpc_seq_t transmitted = READ_ONCE(call->tx_transmitted);
+	rxrpc_seq_t transmitted = call->tx_transmitted;
 	ktime_t now, max_age, oldest, ack_ts;
 	bool unacked = false;
 	unsigned int i;
@@ -184,16 +184,14 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * seen.  Anything between the soft-ACK table and that point will get
 	 * ACK'd or NACK'd in due course, so don't worry about it here; here we
 	 * need to consider retransmitting anything beyond that point.
-	 *
-	 * Note that ACK for a packet can beat the update of tx_transmitted.
 	 */
-	if (after_eq(READ_ONCE(call->acks_prev_seq), READ_ONCE(call->tx_transmitted)))
+	if (after_eq(call->acks_prev_seq, call->tx_transmitted))
 		goto no_further_resend;
 
 	list_for_each_entry_from(txb, &call->tx_buffer, call_link) {
-		if (before_eq(txb->seq, READ_ONCE(call->acks_prev_seq)))
+		if (before_eq(txb->seq, call->acks_prev_seq))
 			continue;
-		if (after(txb->seq, READ_ONCE(call->tx_transmitted)))
+		if (after(txb->seq, call->tx_transmitted))
 			break; /* Not transmitted yet */
 
 		if (ack && ack->reason == RXRPC_ACK_PING_RESPONSE &&
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 2386b01b2231..1e039b6f4494 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -397,12 +397,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 
 	/* Track what we've attempted to transmit at least once so that the
 	 * retransmission algorithm doesn't try to resend what we haven't sent
-	 * yet.  However, this can race as we can receive an ACK before we get
-	 * to this point.  But, OTOH, if we won't get an ACK mentioning this
-	 * packet unless the far side received it (though it could have
-	 * discarded it anyway and NAK'd it).
+	 * yet.
 	 */
-	cmpxchg(&call->tx_transmitted, txb->seq - 1, txb->seq);
+	if (txb->seq == call->tx_transmitted + 1)
+		call->tx_transmitted = txb->seq;
 
 	/* send the packet with the don't fragment bit set if we currently
 	 * think it's small enough */


