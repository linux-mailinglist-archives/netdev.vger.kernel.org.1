Return-Path: <netdev+bounces-160512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A311A1A040
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F91F16D561
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442EB20C03B;
	Thu, 23 Jan 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgAHK2vv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1E20C00D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737622766; cv=none; b=fHXDw0XDua8ID1V3nbmPsxtuoSrd4B+nL5uPCwdeCLyG90sya5ESrot4lk1UJ+cWprleeuFgJD59l1QqUTyyi2tMF9pdeHmDEcUkxP+F+axH4g0iOsl5bIhq21U2+FdWLozPiIN/Z1eqNmI6PmSEMqKLVKNxPFx7qZAliaMg61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737622766; c=relaxed/simple;
	bh=QYwG08fv7LCe0nRLz9nAz6siZ2+lGH9Nm+l8NkJg+Cw=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=aiA3dIMWqdLybHUGg0PrOUKZIF8eSmRxXOCUhOecjaGn/uHEDaH8Td0ZGeOANejIJqK1BILMBdPWCdXhcg1MuwId4z1DiNTTBOqzko6Fki78OCdVDxVXRW/nDxf5xQ/wi9AtK8e7OGKT3FME3x1AGzViUAaW7UngPLhzQrS9A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgAHK2vv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737622763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u0zGpo6OTMm9f5DXUBo9iD012diEnF7FfUaJEidTJQA=;
	b=bgAHK2vv4kVANFKOn9CUr3OP23g/m9vN2PpqUOZl8L24U2UHXzZ6S1KLVeskvIToyLO6kk
	yWGFmqkGJbKKzHES52d4Q5hHeHkwlLTQmxxewqGrGjjoabtnQRQblswx8az0o8O/etKzGs
	Qo9KaEhRUvHoGG4ivMcPKV4I88bhisg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-fi2jiBiQPCOlYS-BQQRAWQ-1; Thu,
 23 Jan 2025 03:59:18 -0500
X-MC-Unique: fi2jiBiQPCOlYS-BQQRAWQ-1
X-Mimecast-MFC-AGG-ID: fi2jiBiQPCOlYS-BQQRAWQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8103D1955DCB;
	Thu, 23 Jan 2025 08:59:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A881930001BE;
	Thu, 23 Jan 2025 08:59:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc, afs: Fix peer hash locking vs RCU callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2095617.1737622752.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2025 08:59:12 +0000
Message-ID: <2095618.1737622752@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In its address list, afs now retains pointers to and refs on one or more
rxrpc_peer objects.  The address list is freed under RCU and at this time,
it puts the refs on those peers.

Now, when an rxrpc_peer object runs out of refs, it gets removed from the
peer hash table and, for that, rxrpc has to take a spinlock.  However, it
is now being called from afs's RCU cleanup, which takes place in BH
context - but it is just taking an ordinary spinlock.

The put may also be called from non-BH context, and so there exists the
possibility of deadlock if the BH-based RCU cleanup happens whilst the has=
h
spinlock is held.  This led to the attached lockdep complaint.

Fix this by changing spinlocks of rxnet->peer_hash_lock back to
BH-disabling locks.

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
    WARNING: inconsistent lock state
    6.13.0-rc5-build2+ #1223 Tainted: G            E
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    swapper/1/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
    ffff88810babe228 (&rxnet->peer_hash_lock){+.?.}-{3:3}, at: rxrpc_put_p=
eer+0xcb/0x180
    {SOFTIRQ-ON-W} state was registered at:
      mark_usage+0x164/0x180
      __lock_acquire+0x544/0x990
      lock_acquire.part.0+0x103/0x280
      _raw_spin_lock+0x2f/0x40
      rxrpc_peer_keepalive_worker+0x144/0x440
      process_one_work+0x486/0x7c0
      process_scheduled_works+0x73/0x90
      worker_thread+0x1c8/0x2a0
      kthread+0x19b/0x1b0
      ret_from_fork+0x24/0x40
      ret_from_fork_asm+0x1a/0x30
    irq event stamp: 972402
    hardirqs last  enabled at (972402): [<ffffffff8244360e>] _raw_spin_unl=
ock_irqrestore+0x2e/0x50
    hardirqs last disabled at (972401): [<ffffffff82443328>] _raw_spin_loc=
k_irqsave+0x18/0x60
    softirqs last  enabled at (972300): [<ffffffff810ffbbe>] handle_softir=
qs+0x3ee/0x430
    softirqs last disabled at (972313): [<ffffffff810ffc54>] __irq_exit_rc=
u+0x44/0x110

    other info that might help us debug this:
     Possible unsafe locking scenario:
           CPU0
           ----
      lock(&rxnet->peer_hash_lock);
      <Interrupt>
        lock(&rxnet->peer_hash_lock);

     *** DEADLOCK ***
    1 lock held by swapper/1/0:
     #0: ffffffff83576be0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire=
+0x7/0x30

    stack backtrace:
    CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G            E      6.13=
.0-rc5-build2+ #1223
    Tainted: [E]=3DUNSIGNED_MODULE
    Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
    Call Trace:
     <IRQ>
     dump_stack_lvl+0x57/0x80
     print_usage_bug.part.0+0x227/0x240
     valid_state+0x53/0x70
     mark_lock_irq+0xa5/0x2f0
     mark_lock+0xf7/0x170
     mark_usage+0xe1/0x180
     __lock_acquire+0x544/0x990
     lock_acquire.part.0+0x103/0x280
     _raw_spin_lock+0x2f/0x40
     rxrpc_put_peer+0xcb/0x180
     afs_free_addrlist+0x46/0x90 [kafs]
     rcu_do_batch+0x2d2/0x640
     rcu_core+0x2f7/0x350
     handle_softirqs+0x1ee/0x430
     __irq_exit_rcu+0x44/0x110
     irq_exit_rcu+0xa/0x30
     sysvec_apic_timer_interrupt+0x7f/0xa0
     </IRQ>

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/peer_event.c  |   16 ++++++++--------
 net/rxrpc/peer_object.c |   12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index d82e44a3901b..e874c31fa901 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -246,7 +246,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc=
_net *rxnet,
 	bool use;
 	int slot;
 =

-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 =

 	while (!list_empty(collector)) {
 		peer =3D list_entry(collector->next,
@@ -257,7 +257,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc=
_net *rxnet,
 			continue;
 =

 		use =3D __rxrpc_use_local(peer->local, rxrpc_local_use_peer_keepalive);
-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 =

 		if (use) {
 			keepalive_at =3D peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
@@ -277,17 +277,17 @@ static void rxrpc_peer_keepalive_dispatch(struct rxr=
pc_net *rxnet,
 			 */
 			slot +=3D cursor;
 			slot &=3D mask;
-			spin_lock(&rxnet->peer_hash_lock);
+			spin_lock_bh(&rxnet->peer_hash_lock);
 			list_add_tail(&peer->keepalive_link,
 				      &rxnet->peer_keepalive[slot & mask]);
-			spin_unlock(&rxnet->peer_hash_lock);
+			spin_unlock_bh(&rxnet->peer_hash_lock);
 			rxrpc_unuse_local(peer->local, rxrpc_local_unuse_peer_keepalive);
 		}
 		rxrpc_put_peer(peer, rxrpc_peer_put_keepalive);
-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 	}
 =

-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 =

 /*
@@ -317,7 +317,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *w=
ork)
 	 * second; the bucket at cursor + 1 goes at now + 1s and so
 	 * on...
 	 */
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	list_splice_init(&rxnet->peer_keepalive_new, &collector);
 =

 	stop =3D cursor + ARRAY_SIZE(rxnet->peer_keepalive);
@@ -329,7 +329,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *w=
ork)
 	}
 =

 	base =3D now;
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 =

 	rxnet->peer_keepalive_base =3D base;
 	rxnet->peer_keepalive_cursor =3D cursor;
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index e1c63129586b..0fcc87f0409f 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -325,10 +325,10 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *loc=
al, struct rxrpc_peer *peer)
 	hash_key =3D rxrpc_peer_hash_key(local, &peer->srx);
 	rxrpc_init_peer(local, peer, hash_key);
 =

-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
 	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 =

 /*
@@ -360,7 +360,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_loca=
l *local,
 			return NULL;
 		}
 =

-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 =

 		/* Need to check that we aren't racing with someone else */
 		peer =3D __rxrpc_lookup_peer_rcu(local, srx, hash_key);
@@ -373,7 +373,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_loca=
l *local,
 				      &rxnet->peer_keepalive_new);
 		}
 =

-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 =

 		if (peer)
 			rxrpc_free_peer(candidate);
@@ -423,10 +423,10 @@ static void __rxrpc_put_peer(struct rxrpc_peer *peer=
)
 =

 	ASSERT(hlist_empty(&peer->error_targets));
 =

-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_del_rcu(&peer->hash_link);
 	list_del_init(&peer->keepalive_link);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 =

 	rxrpc_free_peer(peer);
 }


