Return-Path: <netdev+bounces-148096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC89E09EC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477ECB82729
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C4215F7C;
	Mon,  2 Dec 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6/JGZ9g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC2215F6E
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149982; cv=none; b=lKYdOWxC0hERkoB7W2OspjTsAi7Wy0qttp5fKrGp38OjV0xj4fDRIVko3SEb5mJESEvU7xy7TTSnTCCJGOU1S3f7jUu9uJLiduq3ifQ7rMylIYyy16lKuPmUbJ53NrVQM54t+7GJo1r1gdE66IUIUvLl7Tkqig8sTBrhK7uUE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149982; c=relaxed/simple;
	bh=Ar0XsQes2NQM/o820yw2uVSGenY7YgfMmYxdts5Ez+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjPskMN2i3zR8vnxezc5UM/8RIHyBQ6FucD9Y3eAxMj/piNyouXcqqb+JgOVxUqUASbifs00xyjmslD+mfg6AuFLdpC1CbKww8f6fHmzi+CaN5CKXQvKcl5GNWe4CrUcCAAlyrexTQyUVtCM9O7vMdI2Of6OMdXSau6GziIVl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6/JGZ9g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Lh7zpSWuzxz1KJopEi7PEGej8fgj5oeqaS3jhAxyO0=;
	b=D6/JGZ9gfGijK6oXTLiUSdliR0xr5jpVFNxbQ+v2zEYHfJ/E/iDeVsIUQaCJlqSUPplPeJ
	hY869JJKnX8NoP20i7qX/c3e/MJlDNU/unF2tqYTQZKCJXoTz64ADhBXbiPX/HRZwxTpRx
	Yv0GfCW1BBR7bh2XAHVN+EaShfSK7O8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-Pl3qapJ2NvW5fQ9cIOKm7A-1; Mon,
 02 Dec 2024 09:32:57 -0500
X-MC-Unique: Pl3qapJ2NvW5fQ9cIOKm7A-1
X-Mimecast-MFC-AGG-ID: Pl3qapJ2NvW5fQ9cIOKm7A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 771F11953959;
	Mon,  2 Dec 2024 14:32:55 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 470C130000DF;
	Mon,  2 Dec 2024 14:32:52 +0000 (UTC)
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
Subject: [PATCH net-next 27/37] rxrpc: Fix the calculation and use of RTO
Date: Mon,  2 Dec 2024 14:30:45 +0000
Message-ID: <20241202143057.378147-28-dhowells@redhat.com>
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
index 48bc06842f99..1f9b1964e142 100644
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


