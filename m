Return-Path: <netdev+bounces-167480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC8A3A748
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FEA7A3B2E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E81E5217;
	Tue, 18 Feb 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8pqrClL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379721B9C7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906593; cv=none; b=syb0wJR7CM/sPb0mldwKzlHXGn3CwVJWP/7MLhscfsbc2RbcL0cyh1H9A3nTt2Q5r4hLN8cOPiYnPdh5fc0qNwY6ohdkY5Pt8Ls3jw70MGeaGCrtSmWXIrYzkU2sj/Ic8SOC4rB8LlnkSTzJN1lg4ZqXizSf4TQflp7a9Sk09w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906593; c=relaxed/simple;
	bh=54+1wSTWK34HQr0H/R006mkjjB9f/D+FONo/jgiEPf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZG3KfZ7ZgGeeV1qhJ9JkkpEGuYriOFiKSDhjatbTAyA3IQ8mSGpCsj/UyI2lkiGF1/hJcHC7pKf1bZIZeqihvCVE2B4fhwMiFyvyUURGfUR9Hgownr2G817aeZqN0/5S+jFCyHMl6QJyO14qXaFi/jq5tmWY0Zf7fNvLGWyU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8pqrClL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BBat5EO7Q9cBS+sJTTtoikXXonGuQ1MFgftGhda40Q=;
	b=U8pqrClLEHqZvifjqhOi36WmJbwNGBVoO5fdkaZyyitvZ2Amp/BBpVxtVpfOd80w3zuJHL
	qj2LCGn3BuXdVNnO+2iIIc7VsGOrvAdZBJgO0ztviGj7m7dfvsZxx572Iq6FMkprlzxwan
	quplC4TsMoaCGUCpEX7rybHnqKtZ6Ww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-22pJpuW7PPuXM6-9ovXNoA-1; Tue,
 18 Feb 2025 14:23:06 -0500
X-MC-Unique: 22pJpuW7PPuXM6-9ovXNoA-1
X-Mimecast-MFC-AGG-ID: 22pJpuW7PPuXM6-9ovXNoA_1739906585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45F4F19783B7;
	Tue, 18 Feb 2025 19:23:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8D8D180034D;
	Tue, 18 Feb 2025 19:23:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/5] rxrpc: peer->mtu_lock is redundant
Date: Tue, 18 Feb 2025 19:22:45 +0000
Message-ID: <20250218192250.296870-3-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
References: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The peer->mtu_lock is only used to lock around writes to peer->max_data -
and nothing else; further, all such writes take place in the I/O thread and
the lock is only ever write-locked and never read-locked.

In a couple of places, the write_seqcount_begin() is wrapped in
preempt_disable/enable(), but not in all places.  This can cause lockdep to
complain:

WARNING: CPU: 0 PID: 1549 at include/linux/seqlock.h:221 rxrpc_input_ack_trailer+0x305/0x430
...
RIP: 0010:rxrpc_input_ack_trailer+0x305/0x430

Fix this by just getting rid of the lock.

Fixes: eeaedc5449d9 ("rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h | 1 -
 net/rxrpc/input.c       | 2 --
 net/rxrpc/peer_event.c  | 9 +--------
 net/rxrpc/peer_object.c | 1 -
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5e740c486203..a64a0cab1bf7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -360,7 +360,6 @@ struct rxrpc_peer {
 	u8			pmtud_jumbo;	/* Max jumbo packets for the MTU */
 	bool			ackr_adv_pmtud;	/* T if the peer advertises path-MTU */
 	unsigned int		ackr_max_data;	/* Maximum data advertised by peer */
-	seqcount_t		mtu_lock;	/* Lockless MTU access management */
 	unsigned int		if_mtu;		/* Local interface MTU (- hdrsize) for this peer */
 	unsigned int		max_data;	/* Maximum packet data capacity for this peer */
 	unsigned short		hdrsize;	/* header size (IP + UDP + RxRPC) */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9047ba13bd31..24aceb183c2c 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -810,9 +810,7 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call *call, struct sk_buff *skb
 	if (max_mtu < peer->max_data) {
 		trace_rxrpc_pmtud_reduce(peer, sp->hdr.serial, max_mtu,
 					 rxrpc_pmtud_reduce_ack);
-		write_seqcount_begin(&peer->mtu_lock);
 		peer->max_data = max_mtu;
-		write_seqcount_end(&peer->mtu_lock);
 	}
 
 	max_data = umin(max_mtu, peer->max_data);
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index bc283da9ee40..7f4729234957 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -130,9 +130,7 @@ static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
 			peer->pmtud_bad = max_data + 1;
 
 		trace_rxrpc_pmtud_reduce(peer, 0, max_data, rxrpc_pmtud_reduce_icmp);
-		write_seqcount_begin(&peer->mtu_lock);
 		peer->max_data = max_data;
-		write_seqcount_end(&peer->mtu_lock);
 	}
 }
 
@@ -408,13 +406,8 @@ void rxrpc_input_probe_for_pmtud(struct rxrpc_connection *conn, rxrpc_serial_t a
 	}
 
 	max_data = umin(max_data, peer->ackr_max_data);
-	if (max_data != peer->max_data) {
-		preempt_disable();
-		write_seqcount_begin(&peer->mtu_lock);
+	if (max_data != peer->max_data)
 		peer->max_data = max_data;
-		write_seqcount_end(&peer->mtu_lock);
-		preempt_enable();
-	}
 
 	jumbo = max_data + sizeof(struct rxrpc_jumbo_header);
 	jumbo /= RXRPC_JUMBO_SUBPKTLEN;
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 0fcc87f0409f..2ddc8ed68742 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -235,7 +235,6 @@ struct rxrpc_peer *rxrpc_alloc_peer(struct rxrpc_local *local, gfp_t gfp,
 		peer->service_conns = RB_ROOT;
 		seqlock_init(&peer->service_conn_lock);
 		spin_lock_init(&peer->lock);
-		seqcount_init(&peer->mtu_lock);
 		peer->debug_id = atomic_inc_return(&rxrpc_debug_id);
 		peer->recent_srtt_us = UINT_MAX;
 		peer->cong_ssthresh = RXRPC_TX_MAX_WINDOW;


