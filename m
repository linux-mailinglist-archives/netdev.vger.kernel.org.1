Return-Path: <netdev+bounces-148098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7FE9E0598
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE5116F538
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D922217661;
	Mon,  2 Dec 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYY8nHDS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFA208981
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149992; cv=none; b=OmQPyK03Sj0/G01oEtY4tnxXQX4uxE+lS3Rv5fU9+bJarsL1qfglBnUF6RVAuYeGdtlQ+QLbQu2Q2NBWSxvvITlWXCTxv4okAMBikIC8MHJsVmvVpWYGXtTFz2/uJGpfpmiIhxxvOJ/wvm1pnlZUDsqct9XRbKzaJDeBuXohWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149992; c=relaxed/simple;
	bh=9vMHpOsdNhD/rwVslLHBlNpxQ7tIyD/sSGwc96q9O4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pgc7wV3RXoFTOET7tpzCZ0932NhFx2FGSO1/GjiNGpl9FjvMoosF3mZHemyp9KEUtoV9NASCR7GQ7ZAFUq5ZSkKwYFu7UX+8xOkfrqYnd8btc+Ri5yDHzuJOyRudHwohzt9cpIAZy55ww62lSELUWqkaPdqSToYbCBwYmItAZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYY8nHDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP2uT6bhktaJ9tpzmuSGzVmljXbUMIQ5fvP+/Zg4+/I=;
	b=EYY8nHDSp6T+q7a/6ouvT/Jsv3Ac9SY/DUtwyb4PNsA9iVCZIi3V8Ab5GyNooKVlnKUyxn
	HUBMgrv7NWrABgvzdVLEnNxzfJ/k99iEtiu/P1GpgQpseCjFaEc9GeoBoMpPYSum73Tbzp
	3p0IjJPRF+R+roRriMF7r1zq28yUloM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-AMdtMQ-IOlGfB0jpo24iFQ-1; Mon,
 02 Dec 2024 09:33:05 -0500
X-MC-Unique: AMdtMQ-IOlGfB0jpo24iFQ-1
X-Mimecast-MFC-AGG-ID: AMdtMQ-IOlGfB0jpo24iFQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 119D318EBB62;
	Mon,  2 Dec 2024 14:33:04 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6384C1956052;
	Mon,  2 Dec 2024 14:33:01 +0000 (UTC)
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
Subject: [PATCH net-next 29/37] rxrpc: Send jumbo DATA packets
Date: Mon,  2 Dec 2024 14:30:47 +0000
Message-ID: <20241202143057.378147-30-dhowells@redhat.com>
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

Send jumbo DATA packets if the path-MTU probing using padded PING ACK
packets shows up sufficient capacity to do so.  This allows larger chunks
of data to be sent without reducing the retryability as the subpackets in a
jumbo packet can also be retransmitted individually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 2 ++
 net/rxrpc/call_event.c  | 2 +-
 net/rxrpc/call_object.c | 2 ++
 net/rxrpc/input.c       | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 012b9bc283eb..361d4f1bfb4f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -710,6 +710,8 @@ struct rxrpc_call {
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
 	u8			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
+	u8			tx_jumbo_max;	/* Maximum subpkts peer will accept */
+	u8			tx_jumbo_limit;	/* Maximum subpkts in a jumbo packet */
 	ktime_t			tx_last_sent;	/* Last time a transmission occurred */
 
 	/* Received data tracking */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 1f9b1964e142..165d7cb134f2 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -287,7 +287,7 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
 		struct rxrpc_txqueue *tq;
 		struct rxrpc_txbuf *txb;
 		rxrpc_seq_t send_top, seq;
-		int limit = min(space, 1);
+		int limit = min(space, max(call->peer->pmtud_jumbo, 1));
 
 		/* Order send_top before the contents of the new txbufs and
 		 * txqueue pointers
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index bba058055c97..91e9b331047f 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -155,6 +155,8 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	refcount_set(&call->ref, 1);
 	call->debug_id		= debug_id;
 	call->tx_total_len	= -1;
+	call->tx_jumbo_limit	= 1;
+	call->tx_jumbo_max	= 1;
 	call->next_rx_timo	= 20 * HZ;
 	call->next_req_timo	= 1 * HZ;
 	call->ackr_window	= 1;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 849c49a8229a..88693080ef96 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -796,8 +796,11 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 		peer->ackr_adv_pmtud = true;
 	} else {
 		peer->ackr_adv_pmtud = false;
+		capacity = clamp(capacity, 1, jumbo_max);
 	}
 
+	call->tx_jumbo_max = capacity;
+
 	if (wake)
 		wake_up(&call->waitq);
 }


