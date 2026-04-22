Return-Path: <netdev+bounces-280478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGfTJzf06Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:15:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84067448673
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11A2630071C2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D037E2E0;
	Wed, 22 Apr 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrMAkelq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EA368972
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874519; cv=none; b=kRsudkJ72WvuACdlJpDAdC93RhAjYRbkEHneEtFRJZjmmWBbWT26phk/dY5LFCTF2B9BRDj2rzuUJU4dRfvAq5PokKigAwrRa2HZHJT2HggFNCtvGgfoIdYIuxPxdm4Y1Q3iAeIJvpqpNak5ui8a4ZKrjbb+UrWR0nMqJLQaX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874519; c=relaxed/simple;
	bh=+EKRktilg6oe3/7cbefqbezSD8RF6QlPylai2+Cwl+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7rR8Dw4TKPz0cVSFLTSz8BYSkVSYnOtYvF5FeOSA7zX0iKMfSZgxg7yMz59nZKNG0uk3wuzCG8MKwtAakdgmy0mMdlLlpKV9VyWgo651OpMBiWXA5Qp0+hD/BQbA7vxKkpwyI/lizqnKS5GNE5s1knONfxp7uiv1sl4uw0cpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrMAkelq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776874517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nLXlP54hHx7zvrb/k/7cEnulnNUgehqI5MnTQ7goa0=;
	b=WrMAkelq4asFFZejP/17+8a4ZZFyUEBCeTJc6KwbxB2aKEUmOQe/9scGA1E5PLK8VuLji9
	CrqA2ORk924hfxCNMCMKI4pXAIkTt5cvKgpTQ7L7SqA3kBAPQcGEEaxqTmyD9M2szemBMt
	Q024M/H0WQvu6U2klRu3goo+JYyWXUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-GcDIu6MpP2yjMnOX3UPw0A-1; Wed,
 22 Apr 2026 12:15:04 -0400
X-MC-Unique: GcDIu6MpP2yjMnOX3UPw0A-1
X-Mimecast-MFC-AGG-ID: GcDIu6MpP2yjMnOX3UPw0A_1776874502
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8738D1800348;
	Wed, 22 Apr 2026 16:15:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0CD01956095;
	Wed, 22 Apr 2026 16:14:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v2 3/6] rxrpc: Fix potential UAF after skb_unshare() failure
Date: Wed, 22 Apr 2026 17:14:32 +0100
Message-ID: <20260422161438.2593376-4-dhowells@redhat.com>
In-Reply-To: <20260422161438.2593376-1-dhowells@redhat.com>
References: <20260422161438.2593376-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280478-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,auristor.com:email]
X-Rspamd-Queue-Id: 84067448673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If skb_unshare() fails to unshare a packet due to allocation failure in
rxrpc_input_packet(), the skb pointer in the parent (rxrpc_io_thread())
will be NULL'd out.  This will likely cause the call to
trace_rxrpc_rx_done() to oops.

Fix this by moving the unsharing down to where rxrpc_input_call_event()
calls rxrpc_input_call_packet().  There are a number of places prior to
that where we ignore DATA packets for a variety of reasons (such as the
call already being complete) for which an unshare is then avoided.

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
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
 include/trace/events/rxrpc.h |  4 ++--
 net/rxrpc/ar-internal.h      |  1 -
 net/rxrpc/call_event.c       | 19 ++++++++++++++++++-
 net/rxrpc/io_thread.c        | 24 ++----------------------
 net/rxrpc/skbuff.c           |  9 ---------
 5 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 5820d7e41ea0..13b9d017f8e1 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -162,8 +162,6 @@
 	E_(rxrpc_call_poke_timer_now,		"Timer-now")
 
 #define rxrpc_skb_traces \
-	EM(rxrpc_skb_eaten_by_unshare,		"ETN unshare  ") \
-	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
 	EM(rxrpc_skb_get_call_rx,		"GET call-rx  ") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
@@ -190,6 +188,7 @@
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_purge_oob,		"PUT purge-oob") \
 	EM(rxrpc_skb_put_response,		"PUT response ") \
+	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
@@ -198,6 +197,7 @@
 	EM(rxrpc_skb_see_recvmsg_oob,		"SEE recvm-oob") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
+	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
 
 #define rxrpc_local_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 96ecb83c9071..27c2aa2dd023 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1486,7 +1486,6 @@ int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 void rxrpc_kernel_data_consumed(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_eaten_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fec59d9338b9..cc8f9dfa44e8 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -332,7 +332,24 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
-			rxrpc_input_call_packet(call, skb);
+			if (sp->hdr.securityIndex != 0 &&
+			    skb_cloned(skb)) {
+				/* Unshare the packet so that it can be
+				 * modified by in-place decryption.
+				 */
+				struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
+
+				if (nskb) {
+					rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+					rxrpc_input_call_packet(call, nskb);
+					rxrpc_free_skb(nskb, rxrpc_skb_put_call_rx);
+				} else {
+					/* OOM - Drop the packet. */
+					rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+				}
+			} else {
+				rxrpc_input_call_packet(call, skb);
+			}
 			rxrpc_free_skb(skb, rxrpc_skb_put_call_rx);
 			did_receive = true;
 		}
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 697956931925..dc5184a2fa9d 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -192,13 +192,12 @@ static bool rxrpc_extract_abort(struct sk_buff *skb)
 /*
  * Process packets received on the local endpoint
  */
-static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
+static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct sockaddr_rxrpc peer_srx;
 	struct rxrpc_skb_priv *sp;
 	struct rxrpc_peer *peer = NULL;
-	struct sk_buff *skb = *_skb;
 	bool ret = false;
 
 	skb_pull(skb, sizeof(struct udphdr));
@@ -244,25 +243,6 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_call);
 		if (sp->hdr.seq == 0)
 			return rxrpc_bad_message(skb, rxrpc_badmsg_zero_seq);
-
-		/* Unshare the packet so that it can be modified for in-place
-		 * decryption.
-		 */
-		if (sp->hdr.securityIndex != 0) {
-			skb = skb_unshare(skb, GFP_ATOMIC);
-			if (!skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare_nomem);
-				*_skb = NULL;
-				return just_discard;
-			}
-
-			if (skb != *_skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare);
-				*_skb = skb;
-				rxrpc_new_skb(skb, rxrpc_skb_new_unshared);
-				sp = rxrpc_skb(skb);
-			}
-		}
 		break;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:
@@ -494,7 +474,7 @@ int rxrpc_io_thread(void *data)
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
-				if (!rxrpc_input_packet(local, &skb))
+				if (!rxrpc_input_packet(local, skb))
 					rxrpc_reject_packet(local, skb);
 				trace_rxrpc_rx_done(skb->mark, skb->priority);
 				rxrpc_free_skb(skb, rxrpc_skb_put_input);
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index 3bcd6ee80396..e2169d1a14b5 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -46,15 +46,6 @@ void rxrpc_get_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	skb_get(skb);
 }
 
-/*
- * Note the dropping of a ref on a socket buffer by the core.
- */
-void rxrpc_eaten_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
-{
-	int n = atomic_inc_return(&rxrpc_n_rx_skbs);
-	trace_rxrpc_skb(skb, 0, n, why);
-}
-
 /*
  * Note the destruction of a socket buffer.
  */


