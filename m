Return-Path: <netdev+bounces-249946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203FD21634
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4588030788B6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABC376BE4;
	Wed, 14 Jan 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN9KoJt1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9436D4FB
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426651; cv=none; b=kyl8h7VdB5ppiDABL9VCCZKWT8zgwrbR/cA3zExDE09dpwmRX6+pXeZ/T7LRoS3TGMnASO8Nv1VZno4uI98lW6yGrMhh3xKWvdHERDm7yH44KbR57oWg77UUHFBcoUWsH8+iOt1qd6uHAMhhWgvMKavSReZxG8mDi3sGlhuRGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426651; c=relaxed/simple;
	bh=yOiY2PnHluCIfkqe46Yjye9jkyOA0/H2b3IULGULlws=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=IhZTVld6dOu6m7BGOS0sF3xbAtMltvbaU2B/OQ0yd8aG1X2jFMKb+rypGHAjSAtNBLNoPnx1n4QNnTpkbYle53TBSfdKG0NJc/fQF8omkaLwnhUfQgKn+XYD85J72fWXkNKVKFIwTg0zEa6AW7E96ISH3TA9d49c0rXakjqtf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN9KoJt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768426625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0UFxoOj7uBxpoYcltZPOzqeF7UevTJ0PuU8PpzgQ0CY=;
	b=CN9KoJt1YDi7Er4WJWYY9c9zw1Cn12UIx2OnuxkoadRXvniGUqeP11+PNYcJ2u82H1ltlD
	sFgr6ymQE8n+5baG+mOVzyyMgYuNAtDmgJKa5AGEjAz4xuaCeIXLH51Ed0rSyANuFua/Nd
	OO2Jgr/zAXOtW+yJDMGx7HHp6BvLL8M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-FYhPyw_TNjeF7pPLPspwnw-1; Wed,
 14 Jan 2026 16:36:59 -0500
X-MC-Unique: FYhPyw_TNjeF7pPLPspwnw-1
X-Mimecast-MFC-AGG-ID: FYhPyw_TNjeF7pPLPspwnw_1768426618
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2F061956046;
	Wed, 14 Jan 2026 21:36:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E78419560A7;
	Wed, 14 Jan 2026 21:36:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com,
    syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    stable@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rxrpc: Fix data-race warning and potential load/store tearing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89225.1768426612.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jan 2026 21:36:52 +0000
Message-ID: <89226.1768426612@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

    =

Fix the following:

        BUG: KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_=
data_packet

which is reporting an issue with the reads and writes to ->last_tx_at in:

        conn->peer->last_tx_at =3D ktime_get_seconds();

and:

        keepalive_at =3D peer->last_tx_at + RXRPC_KEEPALIVE_TIME;

The lockless accesses to these to values aren't actually a problem as the
read only needs an approximate time of last transmission for the purposes
of deciding whether or not the transmission of a keepalive packet is
warranted yet.

Also, as ->last_tx_at is a 64-bit value, tearing can occur on a 32-bit
arch.

Fix both of these by switching to an unsigned int for ->last_tx_at and onl=
y
storing the LSW of the time64_t.  It can then be reconstructed at need
provided no more than 68 years has elapsed since the last transmission.

Fixes: ace45bec6d77 ("rxrpc: Fix firewall route keepalive")
Reported-by: syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/695e7cfb.050a0220.1c677c.036b.GAE@google=
.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #2)
  - Fix a format specifier to match the change in type of last_tx_at.

 net/rxrpc/ar-internal.h |    9 ++++++++-
 net/rxrpc/conn_event.c  |    2 +-
 net/rxrpc/output.c      |   14 +++++++-------
 net/rxrpc/peer_event.c  |   17 ++++++++++++++++-
 net/rxrpc/proc.c        |    4 ++--
 net/rxrpc/rxgk.c        |    2 +-
 net/rxrpc/rxkad.c       |    2 +-
 7 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5b7342d43486..36d6ca0d1089 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -387,7 +387,7 @@ struct rxrpc_peer {
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
 	unsigned long		app_data;	/* Application data (e.g. afs_server) */
-	time64_t		last_tx_at;	/* Last time packet sent here */
+	unsigned int		last_tx_at;	/* Last time packet sent here (time64_t LSW) *=
/
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
 	int			debug_id;	/* debug ID for printks */
@@ -1379,6 +1379,13 @@ void rxrpc_peer_keepalive_worker(struct work_struct=
 *);
 void rxrpc_input_probe_for_pmtud(struct rxrpc_connection *conn, rxrpc_ser=
ial_t acked_serial,
 				 bool sendmsg_fail);
 =

+/* Update the last transmission time on a peer for keepalive purposes. */
+static inline void rxrpc_peer_mark_tx(struct rxrpc_peer *peer)
+{
+	/* To avoid tearing on 32-bit systems, we only keep the LSW. */
+	WRITE_ONCE(peer->last_tx_at, ktime_get_seconds());
+}
+
 /*
  * peer_object.c
  */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 232b6986da83..98ad9b51ca2c 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -194,7 +194,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connectio=
n *conn,
 	}
 =

 	ret =3D kernel_sendmsg(conn->local->socket, &msg, iov, ioc, len);
-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(chan->call_debug_id, serial, ret,
 				    rxrpc_tx_point_call_final_resend);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8b5903b6e481..d70db367e358 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -275,7 +275,7 @@ static void rxrpc_send_ack_packet(struct rxrpc_call *c=
all, int nr_kv, size_t len
 	rxrpc_local_dont_fragment(conn->local, why =3D=3D rxrpc_propose_ack_ping=
_for_mtu_probe);
 =

 	ret =3D do_udp_sendmsg(conn->local->socket, &msg, len);
-	call->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(call->peer);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_ack);
@@ -411,7 +411,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 =

 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
 	ret =3D do_udp_sendmsg(conn->local->socket, &msg, sizeof(pkt));
-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
 				    rxrpc_tx_point_call_abort);
@@ -698,7 +698,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, s=
truct rxrpc_send_data_req
 			ret =3D 0;
 			trace_rxrpc_tx_data(call, txb->seq, txb->serial, txb->flags,
 					    rxrpc_txdata_inject_loss);
-			conn->peer->last_tx_at =3D ktime_get_seconds();
+			rxrpc_peer_mark_tx(conn->peer);
 			goto done;
 		}
 	}
@@ -711,7 +711,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, s=
truct rxrpc_send_data_req
 	 */
 	rxrpc_inc_stat(call->rxnet, stat_tx_data_send);
 	ret =3D do_udp_sendmsg(conn->local->socket, &msg, len);
-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 =

 	if (ret =3D=3D -EMSGSIZE) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_msgsize);
@@ -797,7 +797,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *co=
nn)
 =

 	trace_rxrpc_tx_packet(conn->debug_id, &whdr, rxrpc_tx_point_conn_abort);
 =

-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 }
 =

 /*
@@ -917,7 +917,7 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 		trace_rxrpc_tx_packet(peer->debug_id, &whdr,
 				      rxrpc_tx_point_version_keepalive);
 =

-	peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(peer);
 	_leave("");
 }
 =

@@ -973,7 +973,7 @@ void rxrpc_send_response(struct rxrpc_connection *conn=
, struct sk_buff *response
 	if (ret < 0)
 		goto fail;
 =

-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	return;
 =

 fail:
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 7f4729234957..9d02448ac062 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -237,6 +237,21 @@ static void rxrpc_distribute_error(struct rxrpc_peer =
*peer, struct sk_buff *skb,
 	spin_unlock_irq(&peer->lock);
 }
 =

+/*
+ * Reconstruct the last transmission time.  The difference calculated sho=
uld be
+ * valid provided no more than ~68 years elapsed since the last transmiss=
ion.
+ */
+static time64_t rxrpc_peer_get_tx_mark(const struct rxrpc_peer *peer, tim=
e64_t base)
+{
+	s32 last_tx_at =3D READ_ONCE(peer->last_tx_at);
+	s32 base_lsw =3D base;
+	s32 diff =3D last_tx_at - base_lsw;
+
+	diff =3D clamp(diff, -RXRPC_KEEPALIVE_TIME, RXRPC_KEEPALIVE_TIME);
+
+	return diff + base;
+}
+
 /*
  * Perform keep-alive pings.
  */
@@ -265,7 +280,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc=
_net *rxnet,
 		spin_unlock_bh(&rxnet->peer_hash_lock);
 =

 		if (use) {
-			keepalive_at =3D peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
+			keepalive_at =3D rxrpc_peer_get_tx_mark(peer, base) + RXRPC_KEEPALIVE_=
TIME;
 			slot =3D keepalive_at - base;
 			_debug("%02x peer %u t=3D%d {%pISp}",
 			       cursor, peer->debug_id, slot, &peer->srx.transport);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index d803562ca0ac..ce4fd1af79ba 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -296,13 +296,13 @@ static int rxrpc_peer_seq_show(struct seq_file *seq,=
 void *v)
 =

 	now =3D ktime_get_seconds();
 	seq_printf(seq,
-		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
+		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6ds %8d %8d\n",
 		   lbuff,
 		   rbuff,
 		   refcount_read(&peer->ref),
 		   peer->cong_ssthresh,
 		   peer->max_data,
-		   now - peer->last_tx_at,
+		   (s32)now - (s32)peer->last_tx_at,
 		   READ_ONCE(peer->recent_srtt_us),
 		   READ_ONCE(peer->recent_rto_us));
 =

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index dce5a3d8a964..43cbf9efd89f 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -678,7 +678,7 @@ static int rxgk_issue_challenge(struct rxrpc_connectio=
n *conn)
 =

 	ret =3D do_udp_sendmsg(conn->local->socket, &msg, len);
 	if (ret > 0)
-		conn->peer->last_tx_at =3D ktime_get_seconds();
+		rxrpc_peer_mark_tx(conn->peer);
 	__free_page(page);
 =

 	if (ret < 0) {
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 3657c0661cdc..a756855a0a62 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -694,7 +694,7 @@ static int rxkad_issue_challenge(struct rxrpc_connecti=
on *conn)
 		return -EAGAIN;
 	}
 =

-	conn->peer->last_tx_at =3D ktime_get_seconds();
+	rxrpc_peer_mark_tx(conn->peer);
 	trace_rxrpc_tx_packet(conn->debug_id, &whdr,
 			      rxrpc_tx_point_rxkad_challenge);
 	_leave(" =3D 0");


