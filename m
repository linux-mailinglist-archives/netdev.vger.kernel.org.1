Return-Path: <netdev+bounces-295204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9oYYFs9oIWr8FwEAu9opvQ
	(envelope-from <netdev+bounces-295204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6263FA8A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OhD8y0Cq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295204-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F149F3125D90
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719E3CD8D7;
	Thu,  4 Jun 2026 11:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384F425CE6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:46:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573572; cv=none; b=FeeLn4vsrztyMe0fuDLimC0q+7Z2kMonNX3SqmZCSgFpWMa0ZNqCJPf1cFyn8MvT4ESRY9wHNUmJbK7c6Bd+Ah7Xg4k8Pmst/nbP7yPoRbPEsXF0DPUw2pge/dmCBWoPFYcqGX32e6R7jIDcZvK4KZdFBBu90zvOij/sO94TK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573572; c=relaxed/simple;
	bh=tyBVDAGqORGCNfVRHw3Ru9dCLxp3WyGsGwS0iSMyDzg=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=p1ohPM5eIM/pfmCBH3hJtXKeNVmWTicKi0XFSXTQi1evYJcIRarjZVjh7sicK4/ICnlDJRvFwJ12LxfodkZq0/KZMgu8oHhNKyGXXj4sqZkZUJ7rz9ut4h7/s8Jxz8lvHjkG95FYvOXMtOrnRSJ/oKrfust/NurvLEI7O7Eg4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhD8y0Cq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780573570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1bjPY9dHNK2+TuuIlF+joIQGrJbqLPAjvn/n6TvWQ44=;
	b=OhD8y0CqyZ2fzMyEzoUCdYpNa8G95XG0cJ9MjY9Ey3H6W9++v5YzrjR0EbX7f9ME4eorCQ
	hLwTG8e9vcmrNqDoKghTQ5rATVAZ0bWFSSGzqqVIQ8l6AjdjpPnI65xiGHwEVAWAdK3GpN
	niqB0f3Nk05jjUPmMGCOrR17rNcB+D0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-RbdsaTjfP-K8hroyv3bcXQ-1; Thu,
 04 Jun 2026 07:46:09 -0400
X-MC-Unique: RbdsaTjfP-K8hroyv3bcXQ-1
X-Mimecast-MFC-AGG-ID: RbdsaTjfP-K8hroyv3bcXQ_1780573567
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CCB1180047F;
	Thu,  4 Jun 2026 11:46:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0FF81955D87;
	Thu,  4 Jun 2026 11:46:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Michael Bommarito <michael.bommarito@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    stable@kernel.org, linux-kernel@kernel.org
Subject: [PATCH net v2] rxrpc: Fix the ACK parser to extract the SACK table for parsing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <105361.1780573560.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 12:46:00 +0100
Message-ID: <105362.1780573560@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:michael.bommarito@gmail.com,m:marc.dionne@auristor.com,m:jaltman@auristor.com,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:stable@kernel.org,m:linux-kernel@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,google.com,davemloft.net,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auristor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AA6263FA8A

    =

Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
potential incorrect access of the buffer in a fragmented UDP packet (the
packet would probably have to be deliberately pre-generated as fragmented)
when AF_RXRPC tries to extract the contents of the SACK table by copying
out the contents of the SACK table into a buffer before attempting to pars=
e

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
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #2)
 - Fix potential overflow/infinite loop as detected by AI[1] by resetting
   acks pointer should the ack number hit a multiple of 256.

 [1] https://lore.kernel.org/r/20260521021910.687776-2-kuba@kernel.org/

 net/rxrpc/input.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..ce761466b02d 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -963,23 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call =
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
+		if ((i & 255) =3D=3D 0)
+			acks =3D sack;
 		shiftr_adv_rotr(acks, extracted);
-		if (i =3D=3D 256) {
-			acks -=3D i;
-			i =3D 0;
-		}
 		seq++;
 		nr++;
 		if ((seq & RXRPC_TXQ_MASK) !=3D 0)
@@ -1117,9 +1128,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call,=
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


