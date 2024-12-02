Return-Path: <netdev+bounces-148082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2039E054D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40D9164FA6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E020ADC0;
	Mon,  2 Dec 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/ru6qmK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5B20A5DD
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149927; cv=none; b=m2VfVAHCXb8vKnKfCpMSUV8pCi0GlWB7uXF1HCkz5wiRQXWdKpFTDsOmQvr/e71Cyv28F9mY6iJlXoG8ZP2dnWX2YuofhN3vBBdYrQOENAYBHbeSfGTHAcv+RcArY0aQ8sMISQIPh1rHxRRUwc9E2kWcGDeiVr9mvO2q6eeE/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149927; c=relaxed/simple;
	bh=Xs+zZ+14rHSUFjQox/+UleOe5OHlsnuVDiiYhDy7S8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovfwT07Q6QscsmJjYfVT87cu/Pn2saerkoSSthdoVT6P5yf5wgtttATcOoo5b1ji265hqW6MK36pjVjc4wrb9zXA1JEoEAl4qz51i7j/1dihWh/Ov/zJILWxNRweLcrmSDXV9MTlvBpeODXekHZ+Zq19VG3L46wS/u14pI/DXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/ru6qmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7fFcHxYF8wqhD0Hc9GDfPSIG0dKVa9/JcHHLCXB4yE=;
	b=b/ru6qmKNdtZAuzuLHMq9ukeA49Uc7oAfmwQGvpztlop1gJmnTklI8YlnHWHD41AdWOmxB
	0zP0qh+1TO7C9GVD716tjsmX+L/vUAQxuZyUFq0b8gep2WkIeI8IP89jiXvOUz6709Mnun
	tMr7dqh2y8mNrH8rgzHn2hMcZ1nrFqk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-uprFzPj1Pw-aGbWrKzRXbw-1; Mon,
 02 Dec 2024 09:32:03 -0500
X-MC-Unique: uprFzPj1Pw-aGbWrKzRXbw-1
X-Mimecast-MFC-AGG-ID: uprFzPj1Pw-aGbWrKzRXbw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEA641953954;
	Mon,  2 Dec 2024 14:32:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AFFB30000DF;
	Mon,  2 Dec 2024 14:31:59 +0000 (UTC)
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
Subject: [PATCH net-next 14/37] rxrpc: Only set DF=1 on initial DATA transmission
Date: Mon,  2 Dec 2024 14:30:32 +0000
Message-ID: <20241202143057.378147-15-dhowells@redhat.com>
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

Change how the DF flag is managed on DATA transmissions.  Set it on initial
transmission and don't set it on retransmissions.  Then remove the handling
for EMSGSIZE in rxrpc_send_data_packet() and just pretend it didn't happen,
leaving it to the retransmission path to retry.

The path-MTU discovery using PING ACKs is then used to probe for the
maximum DATA size - though notification by ICMP will be used if one is
received.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/output.c      | 32 ++++++++++++++++----------------
 net/rxrpc/proc.c        |  5 +++--
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 55cc68dd1b40..84efa21f176c 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -98,6 +98,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_data_send;
 	atomic_t		stat_tx_data_send_frag;
 	atomic_t		stat_tx_data_send_fail;
+	atomic_t		stat_tx_data_send_msgsize;
 	atomic_t		stat_tx_data_underflow;
 	atomic_t		stat_tx_data_cwnd_reset;
 	atomic_t		stat_rx_data;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 56695c441514..95a3819dd85d 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -551,16 +551,11 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	msg.msg_controllen = 0;
 	msg.msg_flags	= MSG_SPLICE_PAGES;
 
-	/* Track what we've attempted to transmit at least once so that the
-	 * retransmission algorithm doesn't try to resend what we haven't sent
-	 * yet.
+	/* Send the packet with the don't fragment bit set unless we think it's
+	 * too big or if this is a retransmission.
 	 */
-	if (txb->seq == call->tx_transmitted + 1)
-		call->tx_transmitted = txb->seq + n - 1;
-
-	/* send the packet with the don't fragment bit set if we currently
-	 * think it's small enough */
-	if (len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
+	if (txb->seq == call->tx_transmitted + 1 &&
+	    len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
 	} else {
@@ -568,6 +563,13 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
+	/* Track what we've attempted to transmit at least once so that the
+	 * retransmission algorithm doesn't try to resend what we haven't sent
+	 * yet.
+	 */
+	if (txb->seq == call->tx_transmitted + 1)
+		call->tx_transmitted = txb->seq + n - 1;
+
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
 		static int lose;
 		if ((lose++ & 7) == 7) {
@@ -578,7 +580,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		}
 	}
 
-retry:
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
 	 *   to go out of the interface
@@ -589,7 +590,11 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	conn->peer->last_tx_at = ktime_get_seconds();
 
-	if (ret < 0) {
+	if (ret == -EMSGSIZE) {
+		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_msgsize);
+		trace_rxrpc_tx_packet(call->debug_id, call->local->kvec[0].iov_base, frag);
+		ret = 0;
+	} else if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
@@ -597,11 +602,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	}
 
 	rxrpc_tx_backoff(call, ret);
-	if (ret == -EMSGSIZE && frag == rxrpc_tx_point_call_data_nofrag) {
-		rxrpc_local_dont_fragment(conn->local, false);
-		frag = rxrpc_tx_point_call_data_frag;
-		goto retry;
-	}
 
 done:
 	if (ret >= 0) {
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 1f1387cf62c8..aab392b4281f 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -476,10 +476,11 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_single_net(seq));
 
 	seq_printf(seq,
-		   "Data     : send=%u sendf=%u fail=%u\n",
+		   "Data     : send=%u sendf=%u fail=%u emsz=%u\n",
 		   atomic_read(&rxnet->stat_tx_data_send),
 		   atomic_read(&rxnet->stat_tx_data_send_frag),
-		   atomic_read(&rxnet->stat_tx_data_send_fail));
+		   atomic_read(&rxnet->stat_tx_data_send_fail),
+		   atomic_read(&rxnet->stat_tx_data_send_msgsize));
 	seq_printf(seq,
 		   "Data-Tx  : nr=%u retrans=%u uf=%u cwr=%u\n",
 		   atomic_read(&rxnet->stat_tx_data),


