Return-Path: <netdev+bounces-279844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIDrL3BZ5mmtvAEAu9opvQ
	(envelope-from <netdev+bounces-279844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:50:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E92430194
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7BC8337CAFC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC634678C;
	Mon, 20 Apr 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd8VFx0s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE93345CB2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697161; cv=none; b=QP0OkxujI8rbu+IcsCLybqTI94m3eMKClzV8/g9w7egvf/6Ag0nO80uYREuQ09AwU5NRwgixpJXdpYOPT3G0bzlUsQ8nYuTt/c+w2pZ718+s5QPE+Frg1rRddiThpBxFN0JOPXIzkoZhJ9EZsAv1gbbjmcrsltPYzN1eOUgo3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697161; c=relaxed/simple;
	bh=AETbByEE0rw3gQfCb+AzDaqSkv1wpeGEPIitanum73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqAFnxd/BBQsbCCxFCJEdQJBaZBOeHuqhZi+Lhzs0yXiQE8JuaJqqxZs6/Mxw6NfHyS2/JYXWU1TEiWHrGOD2suwg3bTORUv4Tny6nsxF1t0Ra6JjYx4eLh9tpRSDn1NEMBYvNZxrGvYBNecZnmI1KF0YmsBStiCpzovnZ90EBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd8VFx0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776697158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpunXl3cNRxJtECI+04AK4+bUELE1MCI4XgfkPLjNLw=;
	b=Jd8VFx0sJ8bpiO1Da9TqBmq9tWFB/Dj3bgOWr8c7NF3KSP0Mnwm/nGNwH/2hD+A07KQJTj
	iIbltcFnsyVR89X1alaLQsNthyHUE8++QcGGEFZuhjq+Hx0vjZnloYWuA+Smdl+e/m9jg4
	iZtiQLw9rjsveXz4NZ3U6VnE9Shh/nY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-VaU60qdCMp65sf7vL92Anw-1; Mon,
 20 Apr 2026 10:59:15 -0400
X-MC-Unique: VaU60qdCMp65sf7vL92Anw-1
X-Mimecast-MFC-AGG-ID: VaU60qdCMp65sf7vL92Anw_1776697154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DBF11956054;
	Mon, 20 Apr 2026 14:59:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D46061956095;
	Mon, 20 Apr 2026 14:59:09 +0000 (UTC)
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
	stable@kernel.org
Subject: [PATCH net 1/4] rxrpc: Fix memory leaks in rxkad_verify_response()
Date: Mon, 20 Apr 2026 15:58:54 +0100
Message-ID: <20260420145900.1223732-2-dhowells@redhat.com>
In-Reply-To: <20260420145900.1223732-1-dhowells@redhat.com>
References: <20260420145900.1223732-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279844-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: C4E92430194
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxkad_verify_response() to free ticket by using a __free() construct
rather than explicitly freeing it.

Also fix rxkad_verify_response() to free the server key by using a __free()
construct.

Fixes: 57af281e5389 ("rxrpc: Tidy up abort generation infrastructure")
Fixes: ec832bd06d6f ("rxrpc: Don't retain the server key in the connection")
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
 include/linux/key.h |   2 +
 net/rxrpc/rxkad.c   | 133 +++++++++++++++-----------------------------
 2 files changed, 48 insertions(+), 87 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 81b8f05c6898..1cafbc3827c2 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -304,6 +304,8 @@ extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
 extern void key_remove_domain(struct key_tag *domain_tag);
 
+DEFINE_FREE(key_put, struct key *, if (!IS_ERR(_T)) key_put(_T))
+
 static inline struct key *__key_get(struct key *key)
 {
 	refcount_inc(&key->usage);
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index eb7f2769d2b1..0acdc46f42c2 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1131,21 +1131,20 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
 static int rxkad_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb)
 {
-	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
-	struct key *server_key;
 	time64_t expiry;
-	void *ticket;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
 
 	_enter("{%d}", conn->debug_id);
 
-	server_key = rxrpc_look_up_server_security(conn, skb, 0, 0);
+	struct key *server_key __free(key_put) =
+		rxrpc_look_up_server_security(conn, skb, 0, 0);
 	if (IS_ERR(server_key)) {
 		ret = PTR_ERR(server_key);
+		server_key = NULL;
 		switch (ret) {
 		case -ENOKEY:
 			return rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, ret,
@@ -1160,16 +1159,15 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	}
 
 	ret = -ENOMEM;
-	response = kzalloc_obj(struct rxkad_response, GFP_NOFS);
+	struct rxkad_response *response __free(kfree) =
+		kzalloc_obj(struct rxkad_response, GFP_NOFS);
 	if (!response)
 		goto temporary_error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  response, sizeof(*response)) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short);
-		goto protocol_error;
-	}
+			  response, sizeof(*response)) < 0)
+		return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+					rxkad_abort_resp_short);
 
 	version = ntohl(response->version);
 	ticket_len = ntohl(response->ticket_len);
@@ -1177,103 +1175,79 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
-	if (version != RXKAD_VERSION) {
-		rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
-				 rxkad_abort_resp_version);
-		goto protocol_error;
-	}
+	if (version != RXKAD_VERSION)
+		return rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
+					rxkad_abort_resp_version);
 
-	if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN) {
-		rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
-				 rxkad_abort_resp_tkt_len);
-		goto protocol_error;
-	}
+	if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN)
+		return rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
+					rxkad_abort_resp_tkt_len);
 
-	if (kvno >= RXKAD_TKT_TYPE_KERBEROS_V5) {
-		rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
-				 rxkad_abort_resp_unknown_tkt);
-		goto protocol_error;
-	}
+	if (kvno >= RXKAD_TKT_TYPE_KERBEROS_V5)
+		return rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
+					rxkad_abort_resp_unknown_tkt);
 
 	/* extract the kerberos ticket and decrypt and decode it */
 	ret = -ENOMEM;
-	ticket = kmalloc(ticket_len, GFP_NOFS);
+	void *ticket __free(kfree) = kmalloc(ticket_len, GFP_NOFS);
 	if (!ticket)
-		goto temporary_error_free_resp;
+		goto temporary_error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
-			  ticket, ticket_len) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short_tkt);
-		goto protocol_error;
-	}
+			  ticket, ticket_len) < 0)
+		return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+					rxkad_abort_resp_short_tkt);
 
 	ret = rxkad_decrypt_ticket(conn, server_key, skb, ticket, ticket_len,
 				   &session_key, &expiry);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto temporary_error;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
 	ret = rxkad_decrypt_response(conn, response, &session_key);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto temporary_error;
 
 	if (ntohl(response->encrypted.epoch) != conn->proto.epoch ||
 	    ntohl(response->encrypted.cid) != conn->proto.cid ||
-	    ntohl(response->encrypted.securityIndex) != conn->security_ix) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_param);
-		goto protocol_error_free;
-	}
+	    ntohl(response->encrypted.securityIndex) != conn->security_ix)
+		return rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					rxkad_abort_resp_bad_param);
 
 	csum = response->encrypted.checksum;
 	response->encrypted.checksum = 0;
 	rxkad_calc_response_checksum(response);
-	if (response->encrypted.checksum != csum) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_checksum);
-		goto protocol_error_free;
-	}
+	if (response->encrypted.checksum != csum)
+		return rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					rxkad_abort_resp_bad_checksum);
 
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
 		u32 call_id = ntohl(response->encrypted.call_id[i]);
 		u32 counter = READ_ONCE(conn->channels[i].call_counter);
 
-		if (call_id > INT_MAX) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_bad_callid);
-			goto protocol_error_free;
-		}
-
-		if (call_id < counter) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_call_ctr);
-			goto protocol_error_free;
-		}
-
+		if (call_id > INT_MAX)
+			return rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+						rxkad_abort_resp_bad_callid);
+		if (call_id < counter)
+			return rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+						rxkad_abort_resp_call_ctr);
 		if (call_id > counter) {
-			if (conn->channels[i].call) {
-				rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-						 rxkad_abort_resp_call_state);
-				goto protocol_error_free;
-			}
+			if (conn->channels[i].call)
+				return rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+							rxkad_abort_resp_call_state);
 			conn->channels[i].call_counter = call_id;
 		}
 	}
 
-	if (ntohl(response->encrypted.inc_nonce) != conn->rxkad.nonce + 1) {
-		rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
-				 rxkad_abort_resp_ooseq);
-		goto protocol_error_free;
-	}
+	if (ntohl(response->encrypted.inc_nonce) != conn->rxkad.nonce + 1)
+		return rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
+					rxkad_abort_resp_ooseq);
 
 	level = ntohl(response->encrypted.level);
-	if (level > RXRPC_SECURITY_ENCRYPT) {
-		rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
-				 rxkad_abort_resp_level);
-		goto protocol_error_free;
-	}
+	if (level > RXRPC_SECURITY_ENCRYPT)
+		return rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
+					rxkad_abort_resp_level);
 	conn->security_level = level;
 
 	/* create a key to hold the security data and expiration time - after
@@ -1281,30 +1255,15 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	 * as for a client connection */
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
-
-	kfree(ticket);
-	kfree(response);
+		goto temporary_error;
 	_leave(" = 0");
 	return 0;
 
-protocol_error_free:
-	kfree(ticket);
-protocol_error:
-	kfree(response);
-	key_put(server_key);
-	return -EPROTO;
-
-temporary_error_free_ticket:
-	kfree(ticket);
-temporary_error_free_resp:
-	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as
 	 * ENOMEM.  We just want to send the challenge again.  Note that we
 	 * also come out this way if the ticket decryption fails.
 	 */
-	key_put(server_key);
 	return ret;
 }
 


