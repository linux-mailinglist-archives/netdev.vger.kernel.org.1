Return-Path: <netdev+bounces-169244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A9A4311B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A75189EDBC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D920D4F6;
	Mon, 24 Feb 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li0nk5Qm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29189207DEA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440537; cv=none; b=HhmpDYYAhUTIlcesxG2khHVuHzd6SEzSF7vRsdBOASIBrAqWWhhI13i6e/uUKQ3Zue+rFqP6D3naGtHY8NxE1SGJjgM9N04b4EMDHE+upg27EK71DinkxPnIL5aw8K673HWb0P1PCGgQjykdfl198Et7VUhTJY64oQC1zeX1MjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440537; c=relaxed/simple;
	bh=GAF4rTI1DsGws7r7GRla1/im4tYifATcIPq/nactC60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt35uK51VY1uQNhJbTXPgm5wr7634c52H4fP2euiitqzrQQ/YmdfhEbTet/8k/v2glXUhn+MjWrOTfo0oBMSEIB3oQwuSBMJ3gV5IsDIv7KuYcokvt9i09eTNFbo5zG8AUk+Y7I1vqSXL1urijcWBfenu8cE4/iJG71julUeZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li0nk5Qm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJysTY3l6efKg+rxbSyGDPWajwbgdCVI4+yZliqv/jI=;
	b=Li0nk5QmcHjIjMzsy/JkC2sgWhnNxG3qKjBsze8E+AkTmHjv1y249WNT4DR1Xx1m7e7E0j
	aKSvyaxJnBiRYC+/V3p+oDjswiEOUS5Ndx11laSII7eOBmoXspJD14Igpz1VQTQpa/y5lx
	vdrLMQnBqWuXlDGaxsP0TrHF9HSrLsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-lKJIW5ZiOr-4stc6ovGtfA-1; Mon,
 24 Feb 2025 18:42:10 -0500
X-MC-Unique: lKJIW5ZiOr-4stc6ovGtfA-1
X-Mimecast-MFC-AGG-ID: lKJIW5ZiOr-4stc6ovGtfA_1740440529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ED791800872;
	Mon, 24 Feb 2025 23:42:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 756B8180035F;
	Mon, 24 Feb 2025 23:42:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 02/15] rxrpc: peer->mtu_lock is redundant
Date: Mon, 24 Feb 2025 23:41:39 +0000
Message-ID: <20250224234154.2014840-3-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The peer->mtu_lock is only used to lock around writes to peer->max_data -
and nothing else; further, all such writes take place in the I/O thread and
the lock is only ever write-locked and never read-locked.

In a couple of places, the write_seqcount_begin() is wrapped in
preempt_disable/enable(), but not in all places.  This can cause lockdep to
throw a complaint:

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


