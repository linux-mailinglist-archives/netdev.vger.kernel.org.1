Return-Path: <netdev+bounces-288743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPMGB13QCWreqgQAu9opvQ
	(envelope-from <netdev+bounces-288743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:27:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD3561A8E
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84FEC3004599
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA13BB10D;
	Sun, 17 May 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xmky4gjO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839B3BB13B
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028057; cv=none; b=cB34/6H4vc4ipJ9HtoHqFOz/XNH4sMQR1ljC+tPsP3Z/X2bQNGRoaX7uls1gcJ/Kup1BAsy0sacK05jQM+CNa3iauHHz+ruqxzzcXamYbfP88Rn8gGvZe/UT0VgjPRabGFk65z1Jl1wA5tt1nauYNuiLkrSoI0wYxPzjXfItS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028057; c=relaxed/simple;
	bh=4XSBxYxqISLsV6Spf98OGBDaeYRctTVPveYwKgI8UHs=;
	h=To:cc:Subject:MIME-Version:Content-Type:From:Date:Message-ID; b=n4z0ZHiT9k4QyABNRpMD6I7I/mawHY6sIlOJNUg+4iRr0aKQH8trqijjCWMnvoX6y25spv2UPEgMIKtWYno8Hk380nFYjwtQ0LRiffDVJIiwWUuRyShMklngAcTmj4eN5sgberesyMq3Nmcl243X1IOfs+QyygUWECZ6RT2lzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xmky4gjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779028042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LavLM0+8mYsFB9TAKaulpbSa6g77ESdqNgfKK8jSpI0=;
	b=Xmky4gjOTyP8L2Ne9NXqfgZ+ClL+Vf03RNUMs9xs4YfJjHVGOZ+pScJzEIYK4aEn4gWCYH
	GWdKGjUroF7LHQVJf4ZMqudnBltCQcEgkjE6fRkp3MPbiMV2w7IQBlE3TzW1dG/HMkq5fv
	FgsnGauB4cS/ncmlRWJa7vRj04JKN9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-3HtegX92MsSc8txN4rvGOg-1; Sun,
 17 May 2026 10:27:19 -0400
X-MC-Unique: 3HtegX92MsSc8txN4rvGOg-1
X-Mimecast-MFC-AGG-ID: 3HtegX92MsSc8txN4rvGOg_1779028037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB15E180044D;
	Sun, 17 May 2026 14:27:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63FF330001A2;
	Sun, 17 May 2026 14:27:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Michael Bommarito <michael.bommarito@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    stable@kernel.org, linux-kernel@kernel.org
Subject: [PATCH] rxrpc: Fix the ACK parser to extract the SACK table for parsing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3794759.1779027814.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Sun, 17 May 2026 15:27:10 +0100
Message-ID: <3794930.1779028030@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 8FBD3561A8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,google.com,davemloft.net,kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-288743-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,auristor.com:email]
X-Rspamd-Action: no action

    =

Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
potential incorrect access of the buffer in a fragmented UDP packet (the
packet would probably have to be deliberately pre-generated as fragmented)
when AF_RXRPC tries to extract the contents of the SACK table by copying
out the contents of the SACK table into a buffer before attempting to pars=
e
it.

AF_RXRPC assumes that it can just call skb_condense() and then validly
access the SACK table from skb->data and that it will be a flat buffer -
but skb_condense() can silently fail to do anything under some
circumstances.

Note that whilst rxrpc_input_soft_acks() should be able to parse extended
ACKs, the rest of AF_RXRPC doesn't currently support that.

Further, there's then no need to call skb_condense() in rxrpc_input_ack(),
so don't.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than markin=
g txbufs")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito=
@gmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 input.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..0c15ebf19eae 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -963,21 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call =
*call,
 	struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
 	struct rxrpc_txqueue *tq =3D call->tx_queue;
 	unsigned long extracted =3D ~0UL;
-	unsigned int nr =3D 0;
+	unsigned int nr =3D 0, nsack;
 	rxrpc_seq_t seq =3D call->acks_hard_ack + 1;
 	rxrpc_seq_t lowest_nak =3D seq + sp->ack.nr_acks;
-	u8 *acks =3D skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struc=
t rxrpc_ackpacket);
+	u8 sack[256] __aligned(sizeof(unsigned long));
+	u8 *acks =3D sack;
 =

 	_enter("%x,%x,%u", tq->qbase, seq, sp->ack.nr_acks);
 =

 	while (after(seq, tq->qbase + RXRPC_NR_TXQUEUE - 1))
 		tq =3D tq->next;
 =

+	/* Extract an individual SACK table.  A normal SACK table is up to 255
+	 * bytes with 1 ACK flag per byte, but an extended SACK table can be up
+	 * to 256 bytes with up to 8 ACK/NACK flags per byte.  The ACK flags go
+	 * across all bit 0's then all bit 1's, then all bit 2's, ...
+	 */
+	memset(sack, 0, sizeof(sack));
+	nsack =3D umin(sp->ack.nr_acks, 256);
+	if (skb_copy_bits(skb,
+			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
+			  sack, nsack) < 0)
+		return;
+
 	for (unsigned int i =3D 0; i < sp->ack.nr_acks; i++) {
 		/* Decant ACKs until we hit a txqueue boundary. */
 		shiftr_adv_rotr(acks, extracted);
 		if (i =3D=3D 256) {
-			acks -=3D i;
+			acks =3D sack;
 			i =3D 0;
 		}
 		seq++;
@@ -1117,9 +1130,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call,=
 struct sk_buff *skb)
 	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
 =

-	if (nr_acks > 0)
-		skb_condense(skb);
-
 	call->acks_latest_ts =3D ktime_get_real();
 	call->acks_hard_ack =3D hard_ack;
 	call->acks_prev_seq =3D prev_pkt;


