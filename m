Return-Path: <netdev+bounces-287611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AwOAdSKBGoxLQIAu9opvQ
	(envelope-from <netdev+bounces-287611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:29:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D8535106
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316683553981
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCE47ECDC;
	Wed, 13 May 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS2HgtLw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771631E852
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678425; cv=none; b=TSG2SK1S45X/YfTDO4b77iPoxdbdiU9lWkgDuICerSQQh+7zLwmdEtULt+JBR9wWlb0YP0OyZvwWWfterIokFz0k29Kn86IrYDg1YPOCoQe8mBiVgkrf0vXSTsFmC96aaWcznTfc+svOVaTdlqrl7I0GAIJsLwGNCwDRMD7JH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678425; c=relaxed/simple;
	bh=njwa9MObffiOiRNIk4kjxepmv87Jn9INCADAZkh/0VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+T7ppkUE2ulHBfp252EKJPXKN9/HPciuesv49GdvifV4QyXquBKlcd71J72oMXQKTFFUJfl9nQNvE04PZgpSkgnEQGWYi03LprXV2U0r0hqCadVTlYY3P6+IL1i1xLhCGI7i49IXdI6rTTURvO2IIbNRIF/JTMkl4xXxy9ExLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS2HgtLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778678420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9GfxdvdIBjgcqBZc4i2bnWTEYHoQlXQ+IXoeOm3y7E=;
	b=fS2HgtLwY/FsabZZKT0GGsj/Hy8UejSlNr57DFhqir4o6caqLCxlyru3ceTodqhFnUo2is
	2T/WJ+/IZT52EZEMjEZXpdJX2Xug7Mr4mWoN52IyOMz19SJD6nP8Xkbe/6i+TID6ELvZMt
	ekLAlUU0JwV1oCT9CBBFkMhEDi1EFSY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-nQYOC_tWNX-QIE1fYsuNPw-1; Wed,
 13 May 2026 09:20:16 -0400
X-MC-Unique: nQYOC_tWNX-QIE1fYsuNPw-1
X-Mimecast-MFC-AGG-ID: nQYOC_tWNX-QIE1fYsuNPw_1778678415
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E15F19560AF;
	Wed, 13 May 2026 13:20:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC3F91955D84;
	Wed, 13 May 2026 13:20:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@kernel.org
Subject: [PATCH net v2 4/4] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Date: Wed, 13 May 2026 14:19:40 +0100
Message-ID: <20260513131941.1439155-5-dhowells@redhat.com>
In-Reply-To: <20260513131941.1439155-1-dhowells@redhat.com>
References: <20260513131941.1439155-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 585D8535106
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287611-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,infradead.org:email,davemloft.net:email,linux.dev:email]
X-Rspamd-Action: no action

This improves the fix for CVE-2026-43500.

Fix the verification of RESPONSE packets to avoid the problem of
overwriting a RESPONSE packet sent via splice to a local address by
extracting the contents of the UDP packet into a kmalloc'd linear buffer
rather than decrypting the data in place in the sk_buff (which may corrupt
the original buffer).

Further, since the way the RESPONSE data is handled is being overhauled,
add an XDR decode abstraction that hides the details of buffer advancement
and length checking.  At some point it may be worth seeing if NFS's XDR
stuff can be used, but that involves linking against the sunrpc module
which is undesirable.

Fixes: 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/ar-internal.h |  7 +--
 net/rxrpc/conn_event.c  | 32 ++++++--------
 net/rxrpc/insecure.c    |  5 ++-
 net/rxrpc/rxgk.c        | 96 +++++++++++++----------------------------
 net/rxrpc/rxgk_app.c    | 44 ++++++++-----------
 net/rxrpc/rxgk_common.h | 92 +--------------------------------------
 net/rxrpc/rxkad.c       | 29 +++++--------
 7 files changed, 81 insertions(+), 224 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 783367eea798..98f2165159d7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -307,15 +307,16 @@ struct rxrpc_security {
 				    struct sk_buff *challenge);
 
 	/* verify a response */
-	int (*verify_response)(struct rxrpc_connection *,
-			       struct sk_buff *);
+	int (*verify_response)(struct rxrpc_connection *conn,
+			       struct sk_buff *response_skb,
+			       void *response, unsigned int len);
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
 
 	/* Default ticket -> key decoder */
 	int (*default_decode_ticket)(struct rxrpc_connection *conn, struct sk_buff *skb,
-				     unsigned int ticket_offset, unsigned int ticket_len,
+				     void *ticket, unsigned int ticket_len,
 				     struct key **_key);
 };
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 442414d90ba1..c96ca615b787 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -243,28 +243,22 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 static int rxrpc_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb)
 {
+	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
+	void *buffer;
 	int ret;
 
-	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
-	    skb_has_shared_frag(skb)) {
-		/* Copy the packet if shared so that we can do in-place
-		 * decryption.
-		 */
-		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
-
-		if (nskb) {
-			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
-			ret = conn->security->verify_response(conn, nskb);
-			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
-		} else {
-			/* OOM - Drop the packet. */
-			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
-			ret = -ENOMEM;
-		}
-	} else {
-		ret = conn->security->verify_response(conn, skb);
-	}
+	buffer = kmalloc(len, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, len);
+	if (ret < 0)
+		goto out;
+
+	ret = conn->security->verify_response(conn, skb, buffer, len);
 
+out:
+	kfree(buffer);
 	return ret;
 }
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 7a26c6097d03..0b39046bdc61 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -54,9 +54,10 @@ static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,
 }
 
 static int none_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *response_skb,
+				void *response, unsigned int len)
 {
-	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+	return rxrpc_abort_conn(conn, response_skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_response);
 }
 
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 85a59d74aea8..6c675590a675 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1080,11 +1080,12 @@ static int rxgk_sendmsg_respond_to_challenge(struct sk_buff *challenge,
  *	unsigned int call_numbers<>;
  * };
  */
-static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
-					const struct krb5_enctype *krb5,
-					struct sk_buff *skb,
-					__be32 *p, __be32 *end)
+static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
+				     const struct krb5_enctype *krb5,
+				     struct sk_buff *skb,
+				     void *auth, unsigned int auth_len)
 {
+	__be32 *p = auth, *end = auth + auth_len;
 	u32 app_len, call_count, level, epoch, cid, i;
 
 	_enter("");
@@ -1147,37 +1148,6 @@ static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
 	return 0;
 }
 
-/*
- * Extract the authenticator and verify it.
- */
-static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
-				     const struct krb5_enctype *krb5,
-				     struct sk_buff *skb,
-				     unsigned int auth_offset, unsigned int auth_len)
-{
-	void *auth;
-	__be32 *p;
-	int ret;
-
-	auth = kmalloc(auth_len, GFP_NOFS);
-	if (!auth)
-		return -ENOMEM;
-
-	ret = skb_copy_bits(skb, auth_offset, auth, auth_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
-				       rxgk_abort_resp_short_auth);
-		goto error;
-	}
-
-	p = auth;
-	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p,
-					   p + auth_len / sizeof(*p));
-error:
-	kfree(auth);
-	return ret;
-}
-
 /*
  * Verify a response.
  *
@@ -1188,49 +1158,45 @@ static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
  * };
  */
 static int rxgk_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				void *buffer, unsigned int len)
 {
 	const struct krb5_enctype *krb5;
 	struct rxrpc_key_token *token;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxgk_response rhdr;
+	struct rxgk_response *rhdr;
 	struct rxgk_context *gk;
 	struct key *key = NULL;
-	unsigned int offset = sizeof(struct rxrpc_wire_header);
-	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
-	unsigned int token_offset, token_len;
-	unsigned int auth_offset, auth_len;
+	unsigned int resp_token_len, auth_len;
+	void *resp_token, *auth;
 	__be32 xauth_len;
 	int ret, ec;
 
 	_enter("{%d}", conn->debug_id);
 
 	/* Parse the RXGK_Response object */
-	if (sizeof(rhdr) + sizeof(__be32) > len)
-		goto short_packet;
-
-	if (skb_copy_bits(skb, offset, &rhdr, sizeof(rhdr)) < 0)
+	if (len < sizeof(*rhdr) + sizeof(__be32))
 		goto short_packet;
-	offset	+= sizeof(rhdr);
-	len	-= sizeof(rhdr);
-
-	token_offset	= offset;
-	token_len	= ntohl(rhdr.token_len);
-	if (token_len > len ||
-	    xdr_round_up(token_len) + sizeof(__be32) > len)
+	rhdr = buffer;
+	buffer	+= sizeof(*rhdr);
+	len	-= sizeof(*rhdr);
+
+	resp_token	= buffer;
+	resp_token_len	= ntohl(rhdr->token_len);
+	if (resp_token_len > len ||
+	    xdr_round_up(resp_token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, resp_token_len);
 
-	offset	+= xdr_round_up(token_len);
-	len	-= xdr_round_up(token_len);
+	buffer	+= xdr_round_up(resp_token_len);
+	len	-= xdr_round_up(resp_token_len);
 
-	if (skb_copy_bits(skb, offset, &xauth_len, sizeof(xauth_len)) < 0)
-		goto short_packet;
-	offset	+= sizeof(xauth_len);
+	xauth_len = *(__be32 *)buffer;
+	buffer	+= sizeof(xauth_len);
 	len	-= sizeof(xauth_len);
 
-	auth_offset	= offset;
+	auth		= buffer;
 	auth_len	= ntohl(xauth_len);
 	if (auth_len > len)
 		goto short_packet;
@@ -1245,7 +1211,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 * to the app to deal with - which might mean a round trip to
 	 * userspace.
 	 */
-	ret = rxgk_extract_token(conn, skb, token_offset, token_len, &key);
+	ret = rxgk_extract_token(conn, skb, resp_token, resp_token_len, &key);
 	if (ret < 0)
 		goto out;
 
@@ -1259,7 +1225,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 */
 	token = key->payload.data[0];
 	conn->security_level = token->rxgk->level;
-	conn->rxgk.start_time = __be64_to_cpu(rhdr.start_time);
+	conn->rxgk.start_time = __be64_to_cpu(rhdr->start_time);
 
 	gk = rxgk_generate_transport_key(conn, token->rxgk, sp->hdr.cksum, GFP_NOFS);
 	if (IS_ERR(gk)) {
@@ -1269,18 +1235,18 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	krb5 = gk->krb5;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum,
+				resp_token_len);
 
 	/* Decrypt, parse and verify the authenticator. */
-	ret = rxgk_decrypt_skb(krb5, gk->resp_enc, skb,
-			       &auth_offset, &auth_len, &ec);
+	ret = rxgk_decrypt(krb5, gk->resp_enc, &auth, &auth_len, &ec);
 	if (ret < 0) {
 		rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
 				 rxgk_abort_resp_auth_dec);
 		goto out_gk;
 	}
 
-	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
+	ret = rxgk_verify_authenticator(conn, krb5, skb, auth, auth_len);
 	if (ret < 0)
 		goto out_gk;
 
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 0ef2a29eb695..c72e16901973 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -40,7 +40,7 @@
  * };
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *buffer, unsigned int ticket_len,
 			   struct key **_key)
 {
 	struct rxrpc_key_token *token;
@@ -49,7 +49,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	size_t pre_ticket_len, payload_len;
 	unsigned int klen, enctype;
 	void *payload, *ticket;
-	__be32 *t, *p, *q, tmp[2];
+	__be32 *t, *p, *q, *tmp;
 	int ret;
 
 	_enter("");
@@ -59,10 +59,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 					rxgk_abort_resp_short_yfs_tkt);
 
 	/* Get the session key length */
-	ret = skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-					rxgk_abort_resp_short_yfs_klen);
+	tmp = buffer;
 	enctype = ntohl(tmp[0]);
 	klen = ntohl(tmp[1]);
 
@@ -84,12 +81,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * it.
 	 */
 	ticket = payload + pre_ticket_len;
-	ret = skb_copy_bits(skb, ticket_offset, ticket, ticket_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-				       rxgk_abort_resp_short_yfs_tkt);
-		goto error;
-	}
+	memcpy(ticket, buffer, ticket_len);
 
 	/* Fill out the form header. */
 	p = payload;
@@ -131,7 +123,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 		goto error;
 	}
 
-	/* Ticket read in with skb_copy_bits above */
+	/* Ticket appended above. */
 	q += xdr_round_up(ticket_len) / 4;
 	if (WARN_ON((unsigned long)q - (unsigned long)payload != payload_len)) {
 		ret = -EIO;
@@ -182,14 +174,15 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
  * [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-afs-08 sec 6.1]
  */
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key)
 {
 	const struct krb5_enctype *krb5;
 	const struct krb5_buffer *server_secret;
 	struct crypto_aead *token_enc = NULL;
 	struct key *server_key;
-	unsigned int ticket_offset, ticket_len;
+	unsigned int ticket_len;
+	void *ticket;
 	u32 kvno, enctype;
 	int ret, ec = 0;
 
@@ -197,7 +190,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		__be32 kvno;
 		__be32 enctype;
 		__be32 token_len;
-	} container;
+	} *container;
 
 	if (token_len < sizeof(container))
 		goto short_packet;
@@ -206,15 +199,14 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * key we should be using.  We can then fetch the key, get the secret
 	 * and set up the crypto to extract the token.
 	 */
-	if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
-		goto short_packet;
+	container = token;
+	token += sizeof(*container);
 
-	kvno		= ntohl(container.kvno);
-	enctype		= ntohl(container.enctype);
-	ticket_len	= ntohl(container.token_len);
-	ticket_offset	= token_offset + sizeof(container);
+	kvno		= ntohl(container->kvno);
+	enctype		= ntohl(container->enctype);
+	ticket_len	= ntohl(container->token_len);
 
-	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
+	if (ticket_len > xdr_round_down(token_len - sizeof(*container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
@@ -237,8 +229,8 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * gain access to K0, from which we can derive the transport key and
 	 * thence decode the authenticator.
 	 */
-	ret = rxgk_decrypt_skb(krb5, token_enc, skb,
-			       &ticket_offset, &ticket_len, &ec);
+	ticket = token;
+	ret = rxgk_decrypt(krb5, token_enc, &ticket, &ticket_len, &ec);
 	crypto_free_aead(token_enc);
 	token_enc = NULL;
 	if (ret < 0) {
@@ -248,7 +240,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		return ret;
 	}
 
-	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
+	ret = conn->security->default_decode_ticket(conn, skb, ticket,
 						    ticket_len, _key);
 	if (ret < 0)
 		goto cant_get_token;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 112b5366ce11..3deed5863f5a 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -41,10 +41,10 @@ struct rxgk_context {
  * rxgk_app.c
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *ticket, unsigned int ticket_len,
 			   struct key **_key);
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key);
 
 /*
@@ -61,50 +61,6 @@ int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
 			     const struct krb5_enctype **_krb5,
 			     gfp_t gfp);
 
-/*
- * Apply decryption and checksumming functions to part of an skbuff.  The
- * offset and length are updated to reflect the actual content of the encrypted
- * region.
- */
-static inline
-int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
-		     struct crypto_aead *aead,
-		     struct sk_buff *skb,
-		     unsigned int *_offset, unsigned int *_len,
-		     int *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_decrypt(krb5, aead, sg, nr_sg,
-				  &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch. */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Apply decryption and checksumming functions a flat data buffer.  The data
  * point and length are updated to reflect the actual content of the encrypted
@@ -148,50 +104,6 @@ static inline int rxgk_decrypt(const struct krb5_enctype *krb5,
 	return ret;
 }
 
-/*
- * Check the MIC on a region of an skbuff.  The offset and length are updated
- * to reflect the actual content of the secure region.
- */
-static inline
-int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
-			struct crypto_shash *shash,
-			const struct krb5_buffer *metadata,
-			struct sk_buff *skb,
-			unsigned int *_offset, unsigned int *_len,
-			u32 *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_verify_mic(krb5, shash, metadata, sg, nr_sg,
-				     &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Check the MIC on a flat buffer.  The data pointer and length are updated to
  * reflect the actual content of the secure region.
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 075936337836..124ae560234f 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -963,7 +963,6 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1112,14 +1111,15 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
  * verify a response
  */
 static int rxkad_verify_response(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
+				 struct sk_buff *skb,
+				 void *buffer, unsigned int len)
 {
 	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket = NULL;
+	void *ticket;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1142,13 +1142,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 		}
 	}
 
-	ret = -ENOMEM;
-	response = kzalloc_obj(struct rxkad_response, GFP_NOFS);
-	if (!response)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  response, sizeof(*response)) < 0) {
+	response = buffer;
+	if (len < sizeof(*response)) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short);
 		goto error;
@@ -1160,6 +1155,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1179,13 +1177,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
-	ret = -ENOMEM;
-	ticket = kmalloc(ticket_len, GFP_NOFS);
-	if (!ticket)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
-			  ticket, ticket_len) < 0) {
+	ticket = buffer;
+	if (ticket_len < len) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short_tkt);
 		goto error;
@@ -1265,8 +1258,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;


