Return-Path: <netdev+bounces-148877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAE9E34FF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355FBB32037
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A61F707A;
	Wed,  4 Dec 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUIeedHw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3E1F666A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298573; cv=none; b=FZF4wqZDpoRLiqdHtCFJ9b5ACvdXNKl3DKGV9ganj8H6ATVbnl3mjayNMQsyGEBT9LocrPQO4cmb9aRKhv0mFKhcn5HeuZjBSnAAtC6yoJdnn0RHOKNIkklTS7UwIN1uEXhCmUt/vFfBAukISveBkdzPrRpM/wyJJtb3LHDp4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298573; c=relaxed/simple;
	bh=LvMICNJekCwdPnGFI2BLmiZad7122HVzp6hxGDUl9ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz+1Q9W26Ph8kD6HAihcnL4nYcVh/m5OKW9zx7fkTgxwHRV1yJZVV8htrPSkJ7LL8ysrT9Lnodoh2KRwWLoMpq0+tJiLRcEvEgWNpw1IUwC7uPqLToC16CuPp++pzdELk7sGVHLOCpp10vPEgfcd2jnVd4cwhpF4SVnto5njCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUIeedHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrbBSXk5EpbO0BUkqOm3977XzZKy0gLnCr7MnMkpeY4=;
	b=bUIeedHwQMgTTjTOf+/6UZd1oDxw4eByEfac8Imrm91192w0QhVimfiSwtihI9BBUyq0UR
	+j7V87IuEfc0pYc76Kw1HikX9AS5Irw8wl2XZgpDAj6M6qxTlIKv/eQU8+5GBRPJrbPBqb
	D/0a/wDiv17aXCqNXRh3EmDnNml3Cx0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-XU8g3rKnNEqhpQ2vx08cYA-1; Wed,
 04 Dec 2024 02:49:28 -0500
X-MC-Unique: XU8g3rKnNEqhpQ2vx08cYA-1
X-Mimecast-MFC-AGG-ID: XU8g3rKnNEqhpQ2vx08cYA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7572D1956046;
	Wed,  4 Dec 2024 07:49:26 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C41971956089;
	Wed,  4 Dec 2024 07:49:23 +0000 (UTC)
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
Subject: [PATCH net-next v2 31/39] rxrpc: Send jumbo DATA packets
Date: Wed,  4 Dec 2024 07:46:59 +0000
Message-ID: <20241204074710.990092-32-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 net/rxrpc/ar-internal.h | 1 +
 net/rxrpc/call_event.c  | 2 +-
 net/rxrpc/call_object.c | 1 +
 net/rxrpc/input.c       | 3 +++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d0d0ab453909..1307749a1a74 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -710,6 +710,7 @@ struct rxrpc_call {
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
 	u8			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
+	u8			tx_jumbo_max;	/* Maximum subpkts peer will accept */
 	ktime_t			tx_last_sent;	/* Last time a transmission occurred */
 
 	/* Received data tracking */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 4390c97e3ba6..39772459426b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -288,7 +288,7 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call)
 		struct rxrpc_txqueue *tq;
 		struct rxrpc_txbuf *txb;
 		rxrpc_seq_t send_top, seq;
-		int limit = min(space, 1);
+		int limit = min(space, max(call->peer->pmtud_jumbo, 1));
 
 		/* Order send_top before the contents of the new txbufs and
 		 * txqueue pointers
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index bba058055c97..e0644e9a8d21 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -155,6 +155,7 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	refcount_set(&call->ref, 1);
 	call->debug_id		= debug_id;
 	call->tx_total_len	= -1;
+	call->tx_jumbo_max	= 1;
 	call->next_rx_timo	= 20 * HZ;
 	call->next_req_timo	= 1 * HZ;
 	call->ackr_window	= 1;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 1eb9c22aba51..a7a249872a54 100644
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


