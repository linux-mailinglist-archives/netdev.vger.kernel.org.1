Return-Path: <netdev+bounces-280476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHy/JMj16Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B327448882
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A548A30DC0A4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444437475D;
	Wed, 22 Apr 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB6dG/0K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685837D11B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874500; cv=none; b=uLkEDnjZb92NqaoxXTuL6ZQbl2OfbeE4Ok0S5sC7HI7fGVf3FtGv1lf5y23gqztzIhd7uGFDMGXSCD1HzOy8Tygrw7uVA85+ZsjH3FtJeNqgQKyFa26sKNn4XoCoW3qh+ySqHtMb7QRuBdTekFhcF/YIZOixGx9PDio+D7cln80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874500; c=relaxed/simple;
	bh=SSqHbGZ95GYCV2EuCOzcRLwpr9gSS5ZWQl+D5sPHmUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfkM+q8faZMxFPVzC3em7T2NRkHvBN+2GWkiARnPcOfNF1U5IpuPYPVhMUIMXlZFoxnMCswO2mH/9oYilEYLPQONxNfBLzZAAeBNJuYYS3QWrVvAaV+D21lFC9qqhBj5vKwbNhwu3ludRyC8E4uJroxzfQWTnBc7yri3CnP5iDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QB6dG/0K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776874494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RaGw34o3ooCJd7rw5d3AQWxYeLxSOWEW/SU5v+5GIo=;
	b=QB6dG/0KcbHjFJH3KG5rmKyLNvRa2YtEYF86RV81tIKq9X3+Yz/M7vGJ30ngUQRcg2PErk
	2WhEQdixvbO7GIqHdNR+H9H0vB2scWb7Ps0bdi4Otbl/vEmrN9JyHX69kvKRCLmYz1Xzb9
	gHC/sZkLWHyvaS3YkSKhRwJvRAJE//I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-dupgZS8EONiY3T73g9L5rw-1; Wed,
 22 Apr 2026 12:14:53 -0400
X-MC-Unique: dupgZS8EONiY3T73g9L5rw-1
X-Mimecast-MFC-AGG-ID: dupgZS8EONiY3T73g9L5rw_1776874491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45FA91956048;
	Wed, 22 Apr 2026 16:14:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BDC0180066C;
	Wed, 22 Apr 2026 16:14:46 +0000 (UTC)
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
Subject: [PATCH net v2 1/6] rxrpc: Fix memory leaks in rxkad_verify_response()
Date: Wed, 22 Apr 2026 17:14:30 +0100
Message-ID: <20260422161438.2593376-2-dhowells@redhat.com>
In-Reply-To: <20260422161438.2593376-1-dhowells@redhat.com>
References: <20260422161438.2593376-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280476-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,sashiko.dev:url,auristor.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 3B327448882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxkad_verify_response() to free the ticket and the server key under all
circumstances by initialising the ticket pointer to NULL and then making
all paths through the function after the first allocation has been done go
through a single common epilogue that just releases everything - where all
the releases skip on a NULL pointer.

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
 net/rxrpc/rxkad.c | 103 +++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index eb7f2769d2b1..5a720222854f 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1136,7 +1136,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket;
+	void *ticket = NULL;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1162,13 +1162,13 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = -ENOMEM;
 	response = kzalloc_obj(struct rxkad_response, GFP_NOFS);
 	if (!response)
-		goto temporary_error;
+		goto error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
 			  response, sizeof(*response)) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				       rxkad_abort_resp_short);
+		goto error;
 	}
 
 	version = ntohl(response->version);
@@ -1178,62 +1178,62 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
 	if (version != RXKAD_VERSION) {
-		rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
-				 rxkad_abort_resp_version);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
+				       rxkad_abort_resp_version);
+		goto error;
 	}
 
 	if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN) {
-		rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
-				 rxkad_abort_resp_tkt_len);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
+				       rxkad_abort_resp_tkt_len);
+		goto error;
 	}
 
 	if (kvno >= RXKAD_TKT_TYPE_KERBEROS_V5) {
-		rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
-				 rxkad_abort_resp_unknown_tkt);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
+				       rxkad_abort_resp_unknown_tkt);
+		goto error;
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
 	ret = -ENOMEM;
 	ticket = kmalloc(ticket_len, GFP_NOFS);
 	if (!ticket)
-		goto temporary_error_free_resp;
+		goto error;
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
 			  ticket, ticket_len) < 0) {
-		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-				 rxkad_abort_resp_short_tkt);
-		goto protocol_error;
+		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				       rxkad_abort_resp_short_tkt);
+		goto error;
 	}
 
 	ret = rxkad_decrypt_ticket(conn, server_key, skb, ticket, ticket_len,
 				   &session_key, &expiry);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto error;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
 	ret = rxkad_decrypt_response(conn, response, &session_key);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto error;
 
 	if (ntohl(response->encrypted.epoch) != conn->proto.epoch ||
 	    ntohl(response->encrypted.cid) != conn->proto.cid ||
 	    ntohl(response->encrypted.securityIndex) != conn->security_ix) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_param);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				       rxkad_abort_resp_bad_param);
+		goto error;
 	}
 
 	csum = response->encrypted.checksum;
 	response->encrypted.checksum = 0;
 	rxkad_calc_response_checksum(response);
 	if (response->encrypted.checksum != csum) {
-		rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-				 rxkad_abort_resp_bad_checksum);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				       rxkad_abort_resp_bad_checksum);
+		goto error;
 	}
 
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
@@ -1241,38 +1241,38 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 		u32 counter = READ_ONCE(conn->channels[i].call_counter);
 
 		if (call_id > INT_MAX) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_bad_callid);
-			goto protocol_error_free;
+			ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					       rxkad_abort_resp_bad_callid);
+			goto error;
 		}
 
 		if (call_id < counter) {
-			rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
-					 rxkad_abort_resp_call_ctr);
-			goto protocol_error_free;
+			ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+					       rxkad_abort_resp_call_ctr);
+			goto error;
 		}
 
 		if (call_id > counter) {
 			if (conn->channels[i].call) {
-				rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
+				ret = rxrpc_abort_conn(conn, skb, RXKADSEALEDINCON, -EPROTO,
 						 rxkad_abort_resp_call_state);
-				goto protocol_error_free;
+				goto error;
 			}
 			conn->channels[i].call_counter = call_id;
 		}
 	}
 
 	if (ntohl(response->encrypted.inc_nonce) != conn->rxkad.nonce + 1) {
-		rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
-				 rxkad_abort_resp_ooseq);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADOUTOFSEQUENCE, -EPROTO,
+				       rxkad_abort_resp_ooseq);
+		goto error;
 	}
 
 	level = ntohl(response->encrypted.level);
 	if (level > RXRPC_SECURITY_ENCRYPT) {
-		rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
-				 rxkad_abort_resp_level);
-		goto protocol_error_free;
+		ret = rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EPROTO,
+				       rxkad_abort_resp_level);
+		goto error;
 	}
 	conn->security_level = level;
 
@@ -1280,31 +1280,12 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	 * this the connection security can be handled in exactly the same way
 	 * as for a client connection */
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
-	if (ret < 0)
-		goto temporary_error_free_ticket;
-
-	kfree(ticket);
-	kfree(response);
-	_leave(" = 0");
-	return 0;
 
-protocol_error_free:
-	kfree(ticket);
-protocol_error:
-	kfree(response);
-	key_put(server_key);
-	return -EPROTO;
-
-temporary_error_free_ticket:
+error:
 	kfree(ticket);
-temporary_error_free_resp:
 	kfree(response);
-temporary_error:
-	/* Ignore the response packet if we got a temporary error such as
-	 * ENOMEM.  We just want to send the challenge again.  Note that we
-	 * also come out this way if the ticket decryption fails.
-	 */
 	key_put(server_key);
+	_leave(" = %d", ret);
 	return ret;
 }
 


