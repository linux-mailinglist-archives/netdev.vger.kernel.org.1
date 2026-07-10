Return-Path: <netdev+bounces-306677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jqb9C2RHUWohBwMAu9opvQ
	(envelope-from <netdev+bounces-306677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:26:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F29FE73DBFD
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="MwlMz/y2";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306677-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306677-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3EAA305A4AF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1738F938;
	Fri, 10 Jul 2026 19:23:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6E380FCA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711431; cv=none; b=Out4hPOqpkIOjULuAv+HcNE+BhUGpLa0C1CeBCFPrZKkmDk/ZeQloR0Y9sBbE5DGnmRsY/YyjOvtFUjq8Mlh4aYfL/2fbdy/V38vgItF9hwM97yBndR6upO7L2X1WHydWnyXIkIMHHLSVnxjLjaWcWph37Jg8qC9WkB0RnznZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711431; c=relaxed/simple;
	bh=6guoQXDxMm7F31VXmZjPZiL+ySmq78h0iE6of3yYXPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0ecNuZUMnyd2BIsi8AF//UYTvAjQpcDMxIKSkXrLLHy1szd2ZlgyRg1QVCfqjbv2byRL4citSxVXC24xmVcVbnw4Z/q9/4ZRjOJoJhY9vsHbSUAHD/U28WkZNlUr/anF6Q4ws8J/TC15l0+9Y1VV6zNRo3S9c8P0kGho1jPmnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwlMz/y2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq7llsTmsWlajzQqjB1qgWIWN4J/21bO/XvtzoPCw4c=;
	b=MwlMz/y2/jBo9EIv2Opm8NrJEABUMrocwnm9rv0gjspatAzhuWhERnw7mYUJtt+on5/wt4
	Rfxo5zSiiWkJVog/tpYbLuHaHZOSYhg8WzgZ/I8PJ+GQKlqM3Xk7k9kryGnMOi7TkJZslW
	ntun32vsEpvQwMdUoh7Jqdzea3r1zQk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-LsT4yJgcMrulF4KaDjJ8zQ-1; Fri,
 10 Jul 2026 15:23:44 -0400
X-MC-Unique: LsT4yJgcMrulF4KaDjJ8zQ-1
X-Mimecast-MFC-AGG-ID: LsT4yJgcMrulF4KaDjJ8zQ_1783711423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27AB41955F15;
	Fri, 10 Jul 2026 19:23:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 476FB1800594;
	Fri, 10 Jul 2026 19:23:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 15/16] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Date: Fri, 10 Jul 2026 20:22:17 +0100
Message-ID: <20260710192220.1922433-16-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:jarkko@kernel.org,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F29FE73DBFD

Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
the AF_RXRPC socket that generated one of the calls on that connection for
the application (which might be in userspace) to service.  The application
then picks up the CHALLENGE and requests a RESPONSE packet be generated,
allowing the app to include app-specific data in it if appropriate.  There
is, however, no actual limit on the capacity of the CHALLENGE queue, and
this could be abused remotely - and also getting the OOB mechanism right
has proven tricky.

Further, by analogy with other AFS codebases, it's not actually necessary
to generate the application data in response to the CHALLENGE.  The reason
I did this was to set the encryption on the app-data to be the same as that
specified in the CHALLENGE as the server must be able to handle that.
However, it's sufficient to use the encoding type set in the token that is
going to be sent to the server; presumably the kerberos server knows that
the fileserver can handle that type - otherwise why tell the client to use
it?

This is the main part of the fix.  It switches the code over from using the
OOB communication mechanism to get the appdata on the fly from the
application (either the AFS filesystem or userspace) to using the appdata
key preemptively provided by the application.

The following changes are made:

 (1) Revert to making the connection event processor work item parse the
     CHALLENGE and generate the RESPONSE directly.

 (2) Add another (optional) parameter that is passed in when an rxrpc
     client call is created and ends up attached to the connection bundle
     and is a user-type key containing the application data.

 (3) RESPONSE generation looks at the bundle and if the app-data is there,
     it will include it (if the security class is YFS-RxGK; RxKAD ignores
     it).

The AFS filesystem driver creates an app-data key when it probes a
fileserver and attaches it to the afs_server struct.  This is picked up
when a call is made to that server and thence passed to rxrpc.

Direct userspace users of AF_RXRPC can partake by creating a user-type key
containing the app-data they want to use and passing its serial ID in a
CMSG of type RXRPC_RESPONSE_APPDATA in the initial sendmsg() of a call.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: linux-afs@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/af_rxrpc.c   |  5 +---
 net/rxrpc/conn_event.c | 68 ++----------------------------------------
 net/rxrpc/recvmsg.c    |  2 +-
 net/rxrpc/rxgk.c       | 57 +++++++++++++++++++++--------------
 4 files changed, 39 insertions(+), 93 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index a19c0fd3c51a..9eb6ca3c5ebf 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -598,10 +598,7 @@ static int rxrpc_sendmsg(struct socket *sock, struct msghdr *m, size_t len)
 		fallthrough;
 	case RXRPC_SERVER_BOUND:
 	case RXRPC_SERVER_LISTENING:
-		if (m->msg_flags & MSG_OOB)
-			ret = rxrpc_sendmsg_oob(rx, m, len);
-		else
-			ret = rxrpc_do_sendmsg(rx, m, len);
+		ret = rxrpc_do_sendmsg(rx, m, len);
 		/* The socket has been unlocked */
 		goto out;
 	default:
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..9146b9d4c2ac 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -279,10 +279,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_CHALLENGE:
-		ret = conn->security->respond_to_challenge(conn, skb);
-		sp->chall.conn = NULL;
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		return ret;
+		return conn->security->respond_to_challenge(conn, skb);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		spin_lock_irq(&conn->state_lock);
@@ -425,66 +422,6 @@ static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
 	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
 }
 
-/*
- * Post a CHALLENGE packet to the socket of one of a connection's calls so that
- * it can get application data to include in the packet, possibly querying
- * userspace.
- */
-static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_call *call = NULL;
-	struct rxrpc_sock *rx;
-	bool respond = false, queued = false;
-
-	sp->chall.conn =
-		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
-
-	if (!conn->security->challenge_to_recvmsg) {
-		rxrpc_post_packet_to_conn(conn, skb);
-		return true;
-	}
-
-	rcu_read_lock();
-
-	for (int i = 0; i < ARRAY_SIZE(conn->channels); i++) {
-		if (conn->channels[i].call) {
-			call = conn->channels[i].call;
-			rx = rcu_dereference(call->socket);
-			if (!rx) {
-				call = NULL;
-				continue;
-			}
-
-			respond = true;
-			if (test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags))
-				break;
-			call = NULL;
-		}
-	}
-
-	if (!respond) {
-		rcu_read_unlock();
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		sp->chall.conn = NULL;
-		return false;
-	}
-
-	if (call)
-		queued = rxrpc_notify_socket_oob(call, skb);
-	rcu_read_unlock();
-	if (call && !queued) {
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		sp->chall.conn = NULL;
-		return false;
-	}
-
-	if (!call)
-		rxrpc_post_packet_to_conn(conn, skb);
-	return true;
-}
-
 /*
  * Input a connection-level packet.
  */
@@ -513,7 +450,8 @@ bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_buff *skb)
 		}
 		if (!conn->security->validate_challenge(conn, skb))
 			return false;
-		return rxrpc_post_challenge(conn, skb);
+		rxrpc_post_packet_to_conn(conn, skb);
+		return true;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		if (rxrpc_is_conn_aborted(conn)) {
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 28b2148b5693..33577522ec02 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -405,7 +405,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	trace_rxrpc_recvmsg(0, rxrpc_recvmsg_enter, 0);
 
-	if (flags & (MSG_OOB | MSG_TRUNC))
+	if (flags & MSG_TRUNC)
 		return -EOPNOTSUPP;
 
 	timeo = sock_rcvtimeo(&rx->sk, flags & MSG_DONTWAIT);
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d24..f3e085b64502 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/key-type.h>
+#include <keys/user-type.h>
 #include "ar-internal.h"
 #include "rxgk_common.h"
 
@@ -837,7 +838,7 @@ static noinline ssize_t rxgk_insert_response_header(struct rxrpc_connection *con
  */
 static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 					    struct sk_buff *challenge,
-					    const struct krb5_buffer *appdata,
+					    const struct user_key_payload *appdata,
 					    struct sk_buff *response,
 					    size_t offset)
 {
@@ -859,20 +860,20 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 	if (ret < 0)
 		return -EPROTO;
 
-	a.appdata_len = htonl(appdata->len);
+	a.appdata_len = htonl(appdata->datalen);
 
 	ret = skb_store_bits(response, offset, &a, sizeof(a));
 	if (ret < 0)
 		return ret;
 	offset += sizeof(a);
 
-	if (appdata->len) {
-		ret = skb_store_bits(response, offset, appdata->data, appdata->len);
+	if (appdata->datalen) {
+		ret = skb_store_bits(response, offset, appdata->data, appdata->datalen);
 		if (ret < 0)
 			return ret;
-		offset += appdata->len;
+		offset += appdata->datalen;
 
-		ret = rxgk_pad_out(response, appdata->len, offset);
+		ret = rxgk_pad_out(response, appdata->datalen, offset);
 		if (ret < 0)
 			return ret;
 		offset += ret;
@@ -890,7 +891,7 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 	ret = skb_store_bits(response, offset, &b, sizeof(b));
 	if (ret < 0)
 		return ret;
-	return sizeof(a) + xdr_round_up(appdata->len) + sizeof(b);
+	return sizeof(a) + xdr_round_up(appdata->datalen) + sizeof(b);
 }
 
 static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
@@ -923,7 +924,7 @@ static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
  */
 static int rxgk_construct_response(struct rxrpc_connection *conn,
 				   struct sk_buff *challenge,
-				   struct krb5_buffer *appdata)
+				   const struct user_key_payload *appdata)
 {
 	struct rxrpc_skb_priv *csp, *rsp;
 	struct rxgk_context *gk;
@@ -936,7 +937,7 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
 
-	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
+	auth_len = 20 + (4 + appdata->datalen) + 12 + (1 + 4) * 4;
 	authx_len = crypto_krb5_how_much_buffer(gk->krb5, KRB5_ENCRYPT_MODE,
 						auth_len, &auth_offset);
 	len = sizeof(struct rxrpc_wire_header) +
@@ -1011,24 +1012,36 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
  * Respond to a challenge packet.
  */
 static int rxgk_respond_to_challenge(struct rxrpc_connection *conn,
-				     struct sk_buff *challenge,
-				     struct krb5_buffer *appdata)
+				     struct sk_buff *challenge)
 {
-	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
+	struct user_key_payload dummy = {}, *appdata = &dummy;
+	int ret;
+
+	_enter("{%d,%u,%x,%x}",
+	       conn->debug_id, conn->service_id,
+	       key_serial(conn->key), key_serial(conn->bundle->app_data));
 
 	if (key_validate(conn->key) < 0)
 		return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EPROTO,
 					rxgk_abort_chall_key_expired);
 
-	return rxgk_construct_response(conn, challenge, appdata);
-}
+	if (conn->bundle->app_data) {
+		rcu_read_lock();
+		appdata = (struct user_key_payload *)
+			user_key_payload_rcu(conn->bundle->app_data);
+		if (appdata && !refcount_inc_not_zero(&appdata->ref))
+			appdata = NULL;
+		rcu_read_unlock();
+		if (!appdata)
+			return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EKEYREVOKED,
+						rxgk_abort_chall_key_expired);
+	}
 
-static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
-						struct sk_buff *challenge)
-{
-	struct krb5_buffer appdata = {};
+	ret = rxgk_construct_response(conn, challenge, appdata);
 
-	return rxgk_respond_to_challenge(conn, challenge, &appdata);
+	if (appdata != &dummy)
+		put_user_key_payload(appdata);
+	return ret;
 }
 
 /**
@@ -1044,9 +1057,7 @@ static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
 int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
 				     struct krb5_buffer *appdata)
 {
-	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
-
-	return rxgk_respond_to_challenge(csp->chall.conn, challenge, appdata);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(rxgk_kernel_respond_to_challenge);
 
@@ -1348,7 +1359,7 @@ const struct rxrpc_security rxgk_yfs = {
 	.validate_challenge		= rxgk_validate_challenge,
 	.challenge_to_recvmsg		= rxgk_challenge_to_recvmsg,
 	.sendmsg_respond_to_challenge	= rxgk_sendmsg_respond_to_challenge,
-	.respond_to_challenge		= rxgk_respond_to_challenge_no_appdata,
+	.respond_to_challenge		= rxgk_respond_to_challenge,
 	.verify_response		= rxgk_verify_response,
 	.clear				= rxgk_clear,
 	.default_decode_ticket		= rxgk_yfs_decode_ticket,


