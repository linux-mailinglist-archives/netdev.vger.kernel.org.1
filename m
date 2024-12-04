Return-Path: <netdev+bounces-148867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F99E348A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0158216620E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798EC1B4133;
	Wed,  4 Dec 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiyaZYGM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE81B3926
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298533; cv=none; b=cZ12OXEHRGJkTxhweOSrS7pYEJ84umksnAHTteN4MVONSPljdjlzemjEh9qaLYHzw3PjbuUkjirxZoogbDNghG/KXD5vtXloePCj4jwa8BNHIwrbW6iz1UMliIJmMe6xlU0JvHw8U2JJu/nglarzV9xOqWeWJoUGQTg6lN9dxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298533; c=relaxed/simple;
	bh=bg+ZoZAYQnzllVqK846Shozbwj6t+n/u5356UyLiuu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coELBbmlDtqBAB1SVKCsxo3fRYDI3YRxDhMmOsyTHqi51O55nrpXH0s2LOI+0omHizB4Yz1vJx9RMJ8gBPgkLHMciNozrcsJSnqd90LrY4kZ0eXZ1I+53SiZX16UqzXa2QUq7PE57rGztVpkNEdjrv9y0CjWRKxi15Wj8eWw3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiyaZYGM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yms2zrhSiXiiiUZtdHkRN+r4vsd4Em/T3BloXlOTbnY=;
	b=iiyaZYGMdvE1nsDisvlEOXMRQIN4Aj3cIZdcUVOc3gzKkelt4F7OO+fUkEHIHqX9WvYU17
	F0nMofRznssM0M+UJz+oF8JNj1KC0CluomDcLCMFmGi3PmwnbqfZLBqJXjGqNhPtxUfaak
	aRlKMLc+C6U470YvXlu0OSGmJzyoVg8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-0nf7goADPVSzpYMIr35Z7Q-1; Wed,
 04 Dec 2024 02:48:46 -0500
X-MC-Unique: 0nf7goADPVSzpYMIr35Z7Q-1
X-Mimecast-MFC-AGG-ID: 0nf7goADPVSzpYMIr35Z7Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F6A71955D4E;
	Wed,  4 Dec 2024 07:48:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C67ED3000197;
	Wed,  4 Dec 2024 07:48:42 +0000 (UTC)
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
Subject: [PATCH net-next v2 21/39] rxrpc: Display stats about jumbo packets transmitted and received
Date: Wed,  4 Dec 2024 07:46:49 +0000
Message-ID: <20241204074710.990092-22-dhowells@redhat.com>
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

In /proc/net/rxrpc/stats, display statistics about the numbers of different
sizes of jumbo packets transmitted and received, showing counts for 1
subpacket (ie. a non-jumbo packet), 2 subpackets, 3, ... to 8 and then 9+.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  2 ++
 net/rxrpc/input.c       |  6 +++++-
 net/rxrpc/output.c      |  5 ++++-
 net/rxrpc/proc.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 3e57cef7385f..840293f913a3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -111,6 +111,8 @@ struct rxrpc_net {
 	atomic_t		stat_tx_ack_skip;
 	atomic_t		stat_tx_acks[256];
 	atomic_t		stat_rx_acks[256];
+	atomic_t		stat_tx_jumbo[10];
+	atomic_t		stat_rx_jumbo[10];
 
 	atomic_t		stat_why_req_ack[8];
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index b89fd0dee324..8d7ab4b9d7d0 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -568,7 +568,7 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 	unsigned int offset = sizeof(struct rxrpc_wire_header);
 	unsigned int len = skb->len - offset;
 	bool notify = false;
-	int ack_reason = 0;
+	int ack_reason = 0, count = 1, stat_ix;
 
 	while (sp->hdr.flags & RXRPC_JUMBO_PACKET) {
 		if (len < RXRPC_JUMBO_SUBPKTLEN)
@@ -597,12 +597,16 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		sp->hdr.serial++;
 		offset += RXRPC_JUMBO_SUBPKTLEN;
 		len -= RXRPC_JUMBO_SUBPKTLEN;
+		count++;
 	}
 
 	sp->offset = offset;
 	sp->len    = len;
 	rxrpc_input_data_one(call, skb, &notify, &ack_serial, &ack_reason);
 
+	stat_ix = umin(count, ARRAY_SIZE(call->rxnet->stat_rx_jumbo)) - 1;
+	atomic_inc(&call->rxnet->stat_rx_jumbo[stat_ix]);
+
 	if (ack_reason > 0) {
 		rxrpc_send_ACK(call, ack_reason, ack_serial,
 			       rxrpc_propose_ack_input_data);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index c2044d593237..3886777d1bb6 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -552,10 +552,13 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 	rxrpc_seq_t seq = req->seq;
 	size_t len;
 	bool new_call = test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags);
-	int ret;
+	int ret, stat_ix;
 
 	_enter("%x,%x-%x", tq->qbase, seq, seq + req->n - 1);
 
+	stat_ix = umin(req->n, ARRAY_SIZE(call->rxnet->stat_tx_jumbo)) - 1;
+	atomic_inc(&call->rxnet->stat_tx_jumbo[stat_ix]);
+
 	len = rxrpc_prepare_data_packet(call, req);
 	txb = tq->bufs[seq & RXRPC_TXQ_MASK];
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index a8325b8e33c2..5f974ec13d69 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -529,6 +529,30 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_retrans]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_slow_start]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_small_txwin]));
+	seq_printf(seq,
+		   "Jumbo-Tx : %u,%u,%u,%u,%u,%u,%u,%u,%u,%u\n",
+		   atomic_read(&rxnet->stat_tx_jumbo[0]),
+		   atomic_read(&rxnet->stat_tx_jumbo[1]),
+		   atomic_read(&rxnet->stat_tx_jumbo[2]),
+		   atomic_read(&rxnet->stat_tx_jumbo[3]),
+		   atomic_read(&rxnet->stat_tx_jumbo[4]),
+		   atomic_read(&rxnet->stat_tx_jumbo[5]),
+		   atomic_read(&rxnet->stat_tx_jumbo[6]),
+		   atomic_read(&rxnet->stat_tx_jumbo[7]),
+		   atomic_read(&rxnet->stat_tx_jumbo[8]),
+		   atomic_read(&rxnet->stat_tx_jumbo[9]));
+	seq_printf(seq,
+		   "Jumbo-Rx : %u,%u,%u,%u,%u,%u,%u,%u,%u,%u\n",
+		   atomic_read(&rxnet->stat_rx_jumbo[0]),
+		   atomic_read(&rxnet->stat_rx_jumbo[1]),
+		   atomic_read(&rxnet->stat_rx_jumbo[2]),
+		   atomic_read(&rxnet->stat_rx_jumbo[3]),
+		   atomic_read(&rxnet->stat_rx_jumbo[4]),
+		   atomic_read(&rxnet->stat_rx_jumbo[5]),
+		   atomic_read(&rxnet->stat_rx_jumbo[6]),
+		   atomic_read(&rxnet->stat_rx_jumbo[7]),
+		   atomic_read(&rxnet->stat_rx_jumbo[8]),
+		   atomic_read(&rxnet->stat_rx_jumbo[9]));
 	seq_printf(seq,
 		   "Buffers  : txb=%u rxb=%u\n",
 		   atomic_read(&rxrpc_nr_txbuf),
@@ -566,6 +590,8 @@ int rxrpc_stats_clear(struct file *file, char *buf, size_t size)
 	atomic_set(&rxnet->stat_tx_ack_skip, 0);
 	memset(&rxnet->stat_tx_acks, 0, sizeof(rxnet->stat_tx_acks));
 	memset(&rxnet->stat_rx_acks, 0, sizeof(rxnet->stat_rx_acks));
+	memset(&rxnet->stat_tx_jumbo, 0, sizeof(rxnet->stat_tx_jumbo));
+	memset(&rxnet->stat_rx_jumbo, 0, sizeof(rxnet->stat_rx_jumbo));
 
 	memset(&rxnet->stat_why_req_ack, 0, sizeof(rxnet->stat_why_req_ack));
 


