Return-Path: <netdev+bounces-148875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1E9E3524
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B8DB31861
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4F1DFE15;
	Wed,  4 Dec 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6ZzN4Di"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E21DC182
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298567; cv=none; b=rkhnxakEqtQNKVNNola8q7tQfk/2h0ZebtwDd0GMZ/jlfUnpzRSeISLu0XoACp0u97NixUdqdx/n2kBUcqC1XKHvRdeogFWtaBFUrOzH9f/dCoCkCb9E90s+dzI9mlzaE3gmvcTk8xdZ/8NJxjv2eNp3zR97leuDIvdGWiiXUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298567; c=relaxed/simple;
	bh=YtjjrJglzNbaWY3oR5O84SLCh/26+LOHepc0+fkoFTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdknXg7U7VvEF4v1vwF7VbK4O0yKBcJbxTxdamS8a/TfQJneTm61nJIqa5jnpK9YpxkF/c36pAEkC/vkd+rANxR2jhLHLscYlXvq/hr9aDlMsxeRsiKkJyeQXrxYMKf+/w7b1GP4khAJ2F1ml1KMAlRsEGL3kA/vlw3YT4MF9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6ZzN4Di; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF+8sPKxES4A1AKWrEyikFQcOwxRXaA9QVPagIN61Ew=;
	b=i6ZzN4DioMyCYAWANKTSQv5CIlxoj0frc2/14ttgp8ZhaAvAL+bEuYkfCAba/jZ72pRHyK
	J8FtP56505bLY9u6wmwIzrDOY3RSk68xPfyJOZS7IyuWPBpQhz4xiZanEcDrnEjSTdPXrI
	GtStpaTgxqAeFXAfxL3UVATzfT+cqOA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-yxjoyEIPObS8NWWEPyEmgA-1; Wed,
 04 Dec 2024 02:49:19 -0500
X-MC-Unique: yxjoyEIPObS8NWWEPyEmgA-1
X-Mimecast-MFC-AGG-ID: yxjoyEIPObS8NWWEPyEmgA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F96D1956053;
	Wed,  4 Dec 2024 07:49:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A29BB3000199;
	Wed,  4 Dec 2024 07:49:14 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Simon Wilkinson <sxw@auristor.com>
Subject: [PATCH net-next v2 29/39] rxrpc: Fix the calculation and use of RTO
Date: Wed,  4 Dec 2024 07:46:57 +0000
Message-ID: <20241204074710.990092-30-dhowells@redhat.com>
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

Make the following changes to the calculation and use of RTO:

 (1) Fix rxrpc_resend() to use the backed-off RTO value obtained by calling
     rxrpc_get_rto_backoff() rather than extracting the value itself.
     Without this, it may retransmit packets too early.

 (2) The RTO value being similar to the RTT causes a lot of extraneous
     resends because the RTT doesn't end up taking account of clearing out
     of the receive queue on the server.  Worse, responses to PING-ACKs are
     made as fast as possible and so are less than the DATA-requested-ACK
     RTT and so skew the RTT down.

     Fix this by putting a lower bound on the RTO by adding 100ms to it and
     limiting the lower end to 200ms.

Fixes: c410bf01933e ("rxrpc: Fix the excessive initial retransmission timeout")
Fixes: 37473e416234 ("rxrpc: Clean up the resend algorithm")
Signed-off-by: David Howells <dhowells@redhat.com>
Suggested-by: Simon Wilkinson <sxw@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 3 ++-
 net/rxrpc/rtt.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index f71773b18e22..4390c97e3ba6 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -103,7 +103,8 @@ void rxrpc_resend(struct rxrpc_call *call, rxrpc_serial_t ack_serial, bool ping_
 		.now	= ktime_get_real(),
 	};
 	struct rxrpc_txqueue *tq = call->tx_queue;
-	ktime_t lowest_xmit_ts = KTIME_MAX, rto	= ns_to_ktime(call->peer->rto_us * NSEC_PER_USEC);
+	ktime_t lowest_xmit_ts = KTIME_MAX;
+	ktime_t rto = rxrpc_get_rto_backoff(call->peer, false);
 	bool unacked = false;
 
 	_enter("{%d,%d}", call->tx_bottom, call->tx_top);
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index e0b7d99854b4..3f1ec8e420a6 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -27,7 +27,7 @@ static u32 __rxrpc_set_rto(const struct rxrpc_peer *peer)
 
 static u32 rxrpc_bound_rto(u32 rto)
 {
-	return umin(rto, RXRPC_RTO_MAX);
+	return clamp(200000, rto + 100000, RXRPC_RTO_MAX);
 }
 
 /*


