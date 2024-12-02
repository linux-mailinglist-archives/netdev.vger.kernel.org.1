Return-Path: <netdev+bounces-148087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB49E076A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4324B357B1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7C20E01C;
	Mon,  2 Dec 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixWEgh81"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15B20D512
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149952; cv=none; b=p1tZ2NgOtDsaOJt1up0Z2CU64aUxWSGvQg+Z+ywJdki0NM936+LGJvGdS5pEQJ/v/bWNc+1yS5zED5MtOmA27pGVxpXkqPqQvVjU2KgJ0dQn0/P5DjtVELmKUtAQCArtf0XKJYJUK8nBXdnyow+ZcNn2TOfUXCahjbDfHjMOnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149952; c=relaxed/simple;
	bh=YKTxFVVuOPcD96kKG+W3DinvLQM41+0w/fE1JP30J58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NORPxtpdEX1vhaT+CakUfUKY6ehDtb9b92/XPAKrM+1SIZZHilbrfezyXi1k9wuo2+7mCoHBUQlatADLZFZODk2s6h3cdJ/2djl7m+zvcqvWCRCFHzCcBVN8/SpfNjQhz2l+7pZElJI2ObZqXDKobrkmdOv+658HX6V/60i71Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixWEgh81; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSzodCLi8lHVHDHFOACKNah3Rx590SNadOxvvVMC/Oo=;
	b=ixWEgh81+dg6pKAJ0MWrKGYcrKc56Q65fUCxOh4yU3RQcRmyLXyCt8u5bU2DjmWyiY2nBv
	eU7DhgoDIpIarO8N2ArBjwPq0rdSrKyF7hGKrcylMg3L1htWwZSUcNN6TPBRuNTGrB4nIt
	ulE3s8Kv9PgpFYqsBWbYnyl3vLFCoIE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-9_0K13mEOpWCSGEBozX_2Q-1; Mon,
 02 Dec 2024 09:32:23 -0500
X-MC-Unique: 9_0K13mEOpWCSGEBozX_2Q-1
X-Mimecast-MFC-AGG-ID: 9_0K13mEOpWCSGEBozX_2Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E1241944D05;
	Mon,  2 Dec 2024 14:32:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A578B1956052;
	Mon,  2 Dec 2024 14:32:19 +0000 (UTC)
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
Subject: [PATCH net-next 19/37] rxrpc: Display stats about jumbo packets transmitted and received
Date: Mon,  2 Dec 2024 14:30:37 +0000
Message-ID: <20241202143057.378147-20-dhowells@redhat.com>
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
 net/rxrpc/output.c      |  3 +++
 net/rxrpc/proc.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

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
index 4684c2c127b5..87e2e983b161 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -568,7 +568,7 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 	unsigned int offset = sizeof(struct rxrpc_wire_header);
 	unsigned int len = skb->len - offset;
 	bool notify = false;
-	int ack_reason = 0;
+	int ack_reason = 0, count = 1;
 
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
 
+	atomic_inc(&call->rxnet->stat_rx_jumbo[
+			   umin(count, ARRAY_SIZE(call->rxnet->stat_rx_jumbo)) - 1]);
+
 	if (ack_reason > 0) {
 		rxrpc_send_ACK(call, ack_reason, ack_serial,
 			       rxrpc_propose_ack_input_data);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index f785ea0ade43..6b5eac7fcfaf 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -555,6 +555,9 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 
 	_enter("%x,%x-%x", tq->qbase, seq, seq + req->n - 1);
 
+	atomic_inc(&call->rxnet->stat_tx_jumbo[
+			   umin(req->n, ARRAY_SIZE(call->rxnet->stat_tx_jumbo)) - 1]);
+
 	len = rxrpc_prepare_data_packet(call, req);
 	txb = tq->bufs[seq & RXRPC_TXQ_MASK];
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index fb16fff102fc..79fd472dbcfc 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -532,6 +532,30 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
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
@@ -569,6 +593,8 @@ int rxrpc_stats_clear(struct file *file, char *buf, size_t size)
 	atomic_set(&rxnet->stat_tx_ack_skip, 0);
 	memset(&rxnet->stat_tx_acks, 0, sizeof(rxnet->stat_tx_acks));
 	memset(&rxnet->stat_rx_acks, 0, sizeof(rxnet->stat_rx_acks));
+	memset(&rxnet->stat_tx_jumbo, 0, sizeof(rxnet->stat_tx_jumbo));
+	memset(&rxnet->stat_rx_jumbo, 0, sizeof(rxnet->stat_rx_jumbo));
 
 	memset(&rxnet->stat_why_req_ack, 0, sizeof(rxnet->stat_why_req_ack));
 


