Return-Path: <netdev+bounces-169245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7226A4312A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF373B6167
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFC20C46B;
	Mon, 24 Feb 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7i4e7cS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81D20E024
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440541; cv=none; b=r505GIfSHUCEA3WWL1SXIUQ9ctgzYRtfRFHzQMtkJVqpTZXiH4ebANIt1ElE1fWWTPHGvcxM82HmmP+FP1v7G8G4+UDWpLuPbw9NCW2MemFYc0hejrsNym0UW+cWA+oM1TNiL4wC2K88JmnFZKjmJJluv6J67+jro4mOI05nHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440541; c=relaxed/simple;
	bh=eZXHQ2G41uUOKVDh8j9cpZv9XKLuoY45JwNn5kAktpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx0/Vxnt4OTnQm+cnDOGNQ8n/xe/KdtL7FDEqhhNbyreXTiLFyv3r/x4Mwj3RX3OuRLCA3ZDb+XWoTLHnh7uQRDbsJFynGIKBcA6e+TqWjoFywiqhj3x5+uG0R3WbHeUvsOki5BlyoQBtvN4YRblZ1YC36mhBC96xwqJE42eGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7i4e7cS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaiYoCGsFpAWLKJ3d+qpfykW2KxLfKQHY0MVDwtgSTg=;
	b=Q7i4e7cSc573W5JSqG2CSF7v8knGM8+avZQu1gVFP5xMBneCKVvh5o3MTrQFj+3FCEHjAt
	qaLEuC0ure7yjHAxvlgSttDpl31+YrdCgYLwsAN/tjnoZFnk06wYpSGBO8/4Yf9hnOd+Nk
	7OnHp4EN21hb7BFi1ZfRK7FpHAwkEvk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-DIjDmn3aNqWTIY8mq3OH-Q-1; Mon,
 24 Feb 2025 18:42:15 -0500
X-MC-Unique: DIjDmn3aNqWTIY8mq3OH-Q-1
X-Mimecast-MFC-AGG-ID: DIjDmn3aNqWTIY8mq3OH-Q_1740440534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE7618EB2C3;
	Mon, 24 Feb 2025 23:42:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 005AD19560A3;
	Mon, 24 Feb 2025 23:42:10 +0000 (UTC)
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
Subject: [PATCH net-next 03/15] rxrpc: Fix locking issues with the peer record hash
Date: Mon, 24 Feb 2025 23:41:40 +0000
Message-ID: <20250224234154.2014840-4-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rxrpc_new_incoming_peer() can't use spin_lock_bh() whilst its caller has
interrupts disabled.

    WARNING: CPU: 0 PID: 1550 at kernel/softirq.c:369 __local_bh_enable_ip+0x46/0xd0
    ...
    Call Trace:
     rxrpc_alloc_incoming_call+0x1b0/0x400
     rxrpc_new_incoming_call+0x1dd/0x5e0
     rxrpc_input_packet+0x84a/0x920
     rxrpc_io_thread+0x40d/0xb40
     kthread+0x2ec/0x300
     ret_from_fork+0x24/0x40
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    irq event stamp: 1811
    hardirqs last  enabled at (1809): _raw_spin_unlock_irq+0x24/0x50
    hardirqs last disabled at (1810): _raw_read_lock_irq+0x17/0x70
    softirqs last  enabled at (1182): handle_softirqs+0x3ee/0x430
    softirqs last disabled at (1811): rxrpc_new_incoming_peer+0x56/0x120

Fix this by using a plain spin_lock() instead.  IRQs are held, so softirqs
can't happen.

Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I/O thread")
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
 net/rxrpc/peer_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 2ddc8ed68742..56e09d161a97 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -324,10 +324,10 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
 	rxrpc_init_peer(local, peer, hash_key);
 
-	spin_lock_bh(&rxnet->peer_hash_lock);
+	spin_lock(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
 	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	spin_unlock_bh(&rxnet->peer_hash_lock);
+	spin_unlock(&rxnet->peer_hash_lock);
 }
 
 /*


