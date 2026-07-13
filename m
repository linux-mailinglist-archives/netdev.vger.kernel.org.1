Return-Path: <netdev+bounces-307075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtU3JEqgVGqooQMAu9opvQ
	(envelope-from <netdev+bounces-307075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:22:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF37489F5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GNyq+c78;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307075-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307075-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B90C307A30D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C743AFAEA;
	Mon, 13 Jul 2026 08:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE213B4E9B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930311; cv=none; b=Gb4BSmjTTYUgnsjwDJNCXtET8OMiBmDybD7TFQVph+687Tavpio9gusPDwyNqip3VzrqRN2AE4y2LgbaLHRGJ2ZPT4bEEQNLGHrTezFUwtoFUB6cirSuVc99vOSRW9JcwZjdx1m5VGsFeN6pwsFlBVVtGylhFoufYCfcjW9ASMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930311; c=relaxed/simple;
	bh=TfQaVtT/FW+kTbxJ2TnriDXc0tQS/NqNt9yuWEZaayo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXLBGwORe1+DSNKGDdBqgJKyxi0whck+zo1WFTlQnms51dz8pdt6C/WnralYZEZ094lGaFDVNFHXS5Qg67UxwEWbTv9PjRGYkKz0F/aubEPrPskKnCU9ko6tCokWvASxjsxgEivk0NXeUQIbd+AHYacXZo87wYiXA9C+V0aCKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNyq+c78; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPbJLKojtqChersHmPMPuesLkjZ3DrJaObEVkz5GVz0=;
	b=GNyq+c78N8aKvcIk9Ebiv5XUrsR73IpsaQ4YA3d3CMnjORQTNwa6udOH1HkJ1LwLMG9XrI
	5M63qPummQi5HyYrgWQr0raWPide6GXxMUj+7PU916dWlr+K2HkNkk9PGbkaR8lYIgb38Z
	NwdTd+uxd9OBM2Sm439EsANNS/oTvsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Gj_xcE-aNAekCjgvuCxNgA-1; Mon,
 13 Jul 2026 04:11:43 -0400
X-MC-Unique: Gj_xcE-aNAekCjgvuCxNgA-1
X-Mimecast-MFC-AGG-ID: Gj_xcE-aNAekCjgvuCxNgA_1783930301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A31A18001FB;
	Mon, 13 Jul 2026 08:11:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E28830001A1;
	Mon, 13 Jul 2026 08:11:37 +0000 (UTC)
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
Subject: [PATCH net v3 14/14] rxrpc: Remove OOB challenge/response code
Date: Mon, 13 Jul 2026 09:10:20 +0100
Message-ID: <20260713081022.2186481-15-dhowells@redhat.com>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307075-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BDF37489F5

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

This is the final part of the fix.  It removes all the OOB communication
stuff along with the UAPI elements related to them.

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
 fs/afs/cm_security.c         | 259 -----------------------
 fs/afs/internal.h            |   3 -
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               |  19 --
 fs/afs/server.c              |   1 -
 include/net/af_rxrpc.h       |  18 --
 include/trace/events/rxrpc.h |   2 -
 include/uapi/linux/rxrpc.h   |   5 -
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  41 +---
 net/rxrpc/ar-internal.h      |  19 --
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/recvmsg.c          |  82 +-------
 net/rxrpc/rxgk.c             |  73 -------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/server_key.c       |  40 ----
 16 files changed, 5 insertions(+), 973 deletions(-)
 delete mode 100644 net/rxrpc/oob.c

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index 36907a04efd0..f0fec3a76522 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -20,11 +20,6 @@
 #define xdr_round_up(x) (round_up((x), sizeof(__be32)))
 #define xdr_len_object(x) (4 + round_up((x), sizeof(__be32)))
 
-#ifdef CONFIG_RXGK
-static int afs_create_yfs_cm_token(struct sk_buff *challenge,
-				   struct afs_server *server);
-#endif
-
 #ifdef CONFIG_RXGK
 /*
  * As the YFS RxGK appdata to be passed in the YFS.FS-service RESPONSE packet,
@@ -255,95 +250,6 @@ int afs_create_server_appdata(struct afs_server *server, struct key *key)
 	return ret;
 }
 
-/*
- * Respond to an RxGK challenge, adding appdata.
- */
-static int afs_respond_to_challenge(struct sk_buff *challenge)
-{
-#ifdef CONFIG_RXGK
-	struct krb5_buffer appdata = {};
-	struct afs_server *server;
-#endif
-	struct rxrpc_peer *peer;
-	unsigned long peer_data;
-	u16 service_id;
-	u8 security_index;
-
-	rxrpc_kernel_query_challenge(challenge, &peer, &peer_data,
-				     &service_id, &security_index);
-
-	_enter("%u,%u", service_id, security_index);
-
-	switch (service_id) {
-		/* We don't send CM_SERVICE RPCs, so don't expect a challenge
-		 * therefrom.
-		 */
-	case FS_SERVICE:
-	case VL_SERVICE:
-	case YFS_FS_SERVICE:
-	case YFS_VL_SERVICE:
-		break;
-	default:
-		pr_warn("Can't respond to unknown challenge %u:%u",
-			service_id, security_index);
-		return rxrpc_kernel_reject_challenge(challenge, RX_USER_ABORT, -EPROTO,
-						     afs_abort_unsupported_sec_class);
-	}
-
-	switch (security_index) {
-#ifdef CONFIG_RXKAD
-	case RXRPC_SECURITY_RXKAD:
-		return rxkad_kernel_respond_to_challenge(challenge);
-#endif
-
-#ifdef CONFIG_RXGK
-	case RXRPC_SECURITY_RXGK:
-		return rxgk_kernel_respond_to_challenge(challenge, &appdata);
-
-	case RXRPC_SECURITY_YFS_RXGK:
-		switch (service_id) {
-		case FS_SERVICE:
-		case YFS_FS_SERVICE:
-			server = (struct afs_server *)peer_data;
-			if (!server->cm_rxgk_appdata.data) {
-				mutex_lock(&server->cm_token_lock);
-				if (!server->cm_rxgk_appdata.data)
-					afs_create_yfs_cm_token(challenge, server);
-				mutex_unlock(&server->cm_token_lock);
-			}
-			if (server->cm_rxgk_appdata.data)
-				appdata = server->cm_rxgk_appdata;
-			break;
-		}
-		return rxgk_kernel_respond_to_challenge(challenge, &appdata);
-#endif
-
-	default:
-		return rxrpc_kernel_reject_challenge(challenge, RX_USER_ABORT, -EPROTO,
-						     afs_abort_unsupported_sec_class);
-	}
-}
-
-/*
- * Process the OOB message queue, processing challenge packets.
- */
-void afs_process_oob_queue(struct work_struct *work)
-{
-	struct afs_net *net = container_of(work, struct afs_net, rx_oob_work);
-	struct sk_buff *oob;
-	enum rxrpc_oob_type type;
-
-	while (READ_ONCE(net->live) &&
-	       (oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
-		switch (type) {
-		case RXRPC_OOB_CHALLENGE:
-			afs_respond_to_challenge(oob);
-			break;
-		}
-		rxrpc_kernel_free_oob(oob);
-	}
-}
-
 #ifdef CONFIG_RXGK
 /*
  * Create a securities keyring for the cache manager and attach a key to it for
@@ -405,169 +311,4 @@ int afs_create_token_key(struct afs_net *net, struct socket *socket)
 	key_put(ring);
 	return ret;
 }
-
-/*
- * Create an YFS RxGK GSS token to use as a ticket to the specified fileserver.
- */
-static int afs_create_yfs_cm_token(struct sk_buff *challenge,
-				   struct afs_server *server)
-{
-	const struct krb5_enctype *conn_krb5, *token_krb5;
-	const struct krb5_buffer *token_key;
-	struct crypto_aead *aead;
-	struct scatterlist sg;
-	struct afs_net *net = server->cell->net;
-	const struct key *key = net->fs_cm_token_key;
-	size_t keysize, uuidsize, authsize, toksize, encsize, contsize, adatasize, offset;
-	__be32 caps[1] = {
-		[0] = htonl(AFS_CAP_ERROR_TRANSLATION),
-	};
-	__be32 *xdr;
-	void *appdata, *K0, *encbase;
-	u32 enctype;
-	int ret;
-
-	if (!key)
-		return -ENOKEY;
-
-	/* Assume that the fileserver is happy to use the same encoding type as
-	 * we were told to use by the token obtained by the user.
-	 */
-	enctype = rxgk_kernel_query_challenge(challenge);
-
-	conn_krb5 = crypto_krb5_find_enctype(enctype);
-	if (!conn_krb5)
-		return -ENOPKG;
-	token_krb5 = key->payload.data[0];
-	token_key = (const struct krb5_buffer *)&key->payload.data[2];
-
-	/* struct rxgk_key {
-	 *	afs_uint32	enctype;
-	 *	opaque		key<>;
-	 * };
-	 */
-	keysize = 4 + xdr_len_object(conn_krb5->key_len);
-
-	/* struct RXGK_AuthName {
-	 *	afs_int32	kind;
-	 *	opaque		data<AUTHDATAMAX>;
-	 *	opaque		display<AUTHPRINTABLEMAX>;
-	 * };
-	 */
-	uuidsize = sizeof(server->uuid);
-	authsize = 4 + xdr_len_object(uuidsize) + xdr_len_object(0);
-
-	/* struct RXGK_Token {
-	 *	rxgk_key		K0;
-	 *	RXGK_Level		level;
-	 *	rxgkTime		starttime;
-	 *	afs_int32		lifetime;
-	 *	afs_int32		bytelife;
-	 *	rxgkTime		expirationtime;
-	 *	struct RXGK_AuthName	identities<>;
-	 * };
-	 */
-	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
-
-	offset = 0;
-	encsize = crypto_krb5_how_much_buffer(token_krb5, KRB5_ENCRYPT_MODE, toksize, &offset);
-
-	/* struct RXGK_TokenContainer {
-	 *	afs_int32	kvno;
-	 *	afs_int32	enctype;
-	 *	opaque		encrypted_token<>;
-	 * };
-	 */
-	contsize = 4 + 4 + xdr_len_object(encsize);
-
-	/* struct YFSAppData {
-	 *	opr_uuid	initiatorUuid;
-	 *	opr_uuid	acceptorUuid;
-	 *	Capabilities	caps;
-	 *	afs_int32	enctype;
-	 *	opaque		callbackKey<>;
-	 *	opaque		callbackToken<>;
-	 * };
-	 */
-	adatasize = 16 + 16 +
-		xdr_len_object(sizeof(caps)) +
-		4 +
-		xdr_len_object(conn_krb5->key_len) +
-		xdr_len_object(contsize);
-
-	ret = -ENOMEM;
-	appdata = kzalloc(adatasize, GFP_KERNEL);
-	if (!appdata)
-		goto out;
-	xdr = appdata;
-
-	memcpy(xdr, &net->uuid, 16);		/* appdata.initiatorUuid */
-	xdr += 16 / 4;
-	memcpy(xdr, &server->uuid, 16);		/* appdata.acceptorUuid */
-	xdr += 16 / 4;
-	*xdr++ = htonl(ARRAY_SIZE(caps));	/* appdata.caps.len */
-	memcpy(xdr, &caps, sizeof(caps));	/* appdata.caps */
-	xdr += ARRAY_SIZE(caps);
-	*xdr++ = htonl(conn_krb5->etype);	/* appdata.enctype */
-
-	*xdr++ = htonl(conn_krb5->key_len);	/* appdata.callbackKey.len */
-	K0 = xdr;
-	get_random_bytes(K0, conn_krb5->key_len); /* appdata.callbackKey.data */
-	xdr += xdr_round_up(conn_krb5->key_len) / 4;
-
-	*xdr++ = htonl(contsize);		/* appdata.callbackToken.len */
-	*xdr++ = htonl(1);			/* cont.kvno */
-	*xdr++ = htonl(token_krb5->etype);	/* cont.enctype */
-	*xdr++ = htonl(encsize);		/* cont.encrypted_token.len */
-
-	encbase = xdr;
-	xdr += offset / 4;
-	*xdr++ = htonl(conn_krb5->etype);	/* token.K0.enctype */
-	*xdr++ = htonl(conn_krb5->key_len);	/* token.K0.key.len */
-	memcpy(xdr, K0, conn_krb5->key_len);	/* token.K0.key.data */
-	xdr += xdr_round_up(conn_krb5->key_len) / 4;
-
-	*xdr++ = htonl(RXRPC_SECURITY_ENCRYPT);	/* token.level */
-	*xdr++ = htonl(0);			/* token.starttime */
-	*xdr++ = htonl(0);			/* " */
-	*xdr++ = htonl(0);			/* token.lifetime */
-	*xdr++ = htonl(0);			/* token.bytelife */
-	*xdr++ = htonl(0);			/* token.expirationtime */
-	*xdr++ = htonl(0);			/* " */
-	*xdr++ = htonl(1);			/* token.identities.count */
-	*xdr++ = htonl(0);			/* token.identities[0].kind */
-	*xdr++ = htonl(uuidsize);		/* token.identities[0].data.len */
-	memcpy(xdr, &server->uuid, uuidsize);
-	xdr += xdr_round_up(uuidsize) / 4;
-	*xdr++ = htonl(0);			/* token.identities[0].display.len */
-
-	xdr = encbase + xdr_round_up(encsize);
-
-	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
-		pr_err("Appdata size incorrect %lx != %zx\n",
-		       (unsigned long)xdr - (unsigned long)appdata, adatasize);
-
-	aead = crypto_krb5_prepare_encryption(token_krb5, token_key, RXGK_SERVER_ENC_TOKEN,
-					      GFP_KERNEL);
-	if (IS_ERR(aead)) {
-		ret = PTR_ERR(aead);
-		goto out_token;
-	}
-
-	sg_init_one(&sg, encbase, encsize);
-	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);
-	if (ret < 0)
-		goto out_aead;
-
-	server->cm_rxgk_appdata.len  = adatasize;
-	server->cm_rxgk_appdata.data = appdata;
-	appdata = NULL;
-
-out_aead:
-	crypto_free_aead(aead);
-out_token:
-	kfree(appdata);
-out:
-	return ret;
-}
 #endif /* CONFIG_RXGK */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 57519888b978..9322234ce7f7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -282,7 +282,6 @@ struct afs_net {
 	struct socket		*socket;
 	struct afs_call		*spare_incoming_call;
 	struct work_struct	charge_preallocation_work;
-	struct work_struct	rx_oob_work;
 	struct mutex		socket_mutex;
 	atomic_t		nr_outstanding_calls;
 	atomic_t		nr_superblocks;
@@ -547,7 +546,6 @@ struct afs_server {
 	struct work_struct	destroyer;	/* Work item to try and destroy a server */
 	struct timer_list	timer;		/* Management timer */
 	struct mutex		cm_token_lock;	/* Lock governing creation of appdata */
-	struct krb5_buffer	cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	struct key		*yfs_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
@@ -1090,7 +1088,6 @@ extern bool afs_cm_incoming_call(struct afs_call *);
  * cm_security.c
  */
 int afs_create_server_appdata(struct afs_server *server, struct key *key);
-void afs_process_oob_queue(struct work_struct *work);
 #ifdef CONFIG_RXGK
 int afs_create_token_key(struct afs_net *net, struct socket *socket);
 #else
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 7a883c59976f..6353feaa5fb4 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -73,7 +73,6 @@ static int __net_init afs_net_init(struct net *net_ns)
 	generate_random_uuid((unsigned char *)&net->uuid);
 
 	INIT_WORK(&net->charge_preallocation_work, afs_charge_preallocation);
-	INIT_WORK(&net->rx_oob_work, afs_process_oob_queue);
 	mutex_init(&net->socket_mutex);
 
 	net->cells = RB_ROOT;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 1a110448dbdb..4f6d699b5d22 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -25,14 +25,12 @@ static void afs_process_async_call(struct work_struct *);
 static void afs_rx_new_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_rx_discard_new_call(struct rxrpc_call *, unsigned long);
 static void afs_rx_attach(struct rxrpc_call *rxcall, unsigned long user_call_ID);
-static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob);
 static int afs_deliver_cm_op_id(struct afs_call *);
 
 static const struct rxrpc_kernel_ops afs_rxrpc_callback_ops = {
 	.notify_new_call	= afs_rx_new_call,
 	.discard_new_call	= afs_rx_discard_new_call,
 	.user_attach_call	= afs_rx_attach,
-	.notify_oob		= afs_rx_notify_oob,
 };
 
 /* asynchronous incoming call initial processing */
@@ -74,10 +72,6 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
-	ret = rxrpc_sock_set_manage_response(socket->sk, true);
-	if (ret < 0)
-		goto error_2;
-
 	ret = afs_create_token_key(net, socket);
 	if (ret < 0)
 		pr_err("Couldn't create RxGK CM key: %d\n", ret);
@@ -128,7 +122,6 @@ void afs_close_socket(struct afs_net *net)
 	_enter("");
 
 	cancel_work_sync(&net->charge_preallocation_work);
-	cancel_work_sync(&net->rx_oob_work);
 	/* Future work items should now see ->live is false. */
 
 	kernel_listen(net->socket, 0);
@@ -149,7 +142,6 @@ void afs_close_socket(struct afs_net *net)
 
 	kernel_sock_shutdown(net->socket, SHUT_RDWR);
 	flush_workqueue(afs_async_calls);
-	cancel_work_sync(&net->rx_oob_work);
 	net->socket->sk->sk_user_data = NULL;
 	sock_release(net->socket);
 	key_put(net->fs_cm_token_key);
@@ -963,14 +955,3 @@ noinline int afs_protocol_error(struct afs_call *call,
 		call->unmarshalling_error = true;
 	return -EBADMSG;
 }
-
-/*
- * Wake up OOB notification processing.
- */
-static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
-{
-	struct afs_net *net = sk->sk_user_data;
-
-	if (READ_ONCE(net->live))
-		queue_work(afs_wq, &net->rx_oob_work);
-}
diff --git a/fs/afs/server.c b/fs/afs/server.c
index b08d9080b0c5..4c3a7bd0f7d8 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -398,7 +398,6 @@ static void afs_server_rcu(struct rcu_head *rcu)
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
 	afs_put_cell(server->cell, afs_cell_trace_put_server);
-	kfree(server->cm_rxgk_appdata.data);
 	key_put(server->yfs_rxgk_appdata);
 	kfree(server);
 }
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 19c61a2f5af3..a9b8e1ba67ef 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -92,24 +92,6 @@ bool rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
 
 int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
 int rxrpc_sock_set_security_keyring(struct sock *, struct key *);
-int rxrpc_sock_set_manage_response(struct sock *sk, bool set);
-
-enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
-					   struct rxrpc_peer **_peer,
-					   unsigned long *_peer_appdata);
-struct sk_buff *rxrpc_kernel_dequeue_oob(struct socket *sock,
-					 enum rxrpc_oob_type *_type);
-void rxrpc_kernel_free_oob(struct sk_buff *oob);
-void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
-				  struct rxrpc_peer **_peer,
-				  unsigned long *_peer_appdata,
-				  u16 *_service_id, u8 *_security_index);
-int rxrpc_kernel_reject_challenge(struct sk_buff *challenge, u32 abort_code,
-				  int error, enum rxrpc_abort_reason why);
-int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge);
-u32 rxgk_kernel_query_challenge(struct sk_buff *challenge);
-int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
-				     struct krb5_buffer *appdata);
 void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index,
 			    u32 *_krb5_enctype);
 u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d7c7b04d69fc..45e4550a18ed 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -263,7 +263,6 @@
 	EM(rxrpc_conn_free,			"FREE        ") \
 	EM(rxrpc_conn_get_activate_call,	"GET act-call") \
 	EM(rxrpc_conn_get_call_input,		"GET inp-call") \
-	EM(rxrpc_conn_get_challenge_input,	"GET inp-chal") \
 	EM(rxrpc_conn_get_conn_input,		"GET inp-conn") \
 	EM(rxrpc_conn_get_idle,			"GET idle    ") \
 	EM(rxrpc_conn_get_poke_abort,		"GET pk-abort") \
@@ -275,7 +274,6 @@
 	EM(rxrpc_conn_new_service,		"NEW service ") \
 	EM(rxrpc_conn_put_call,			"PUT call    ") \
 	EM(rxrpc_conn_put_call_input,		"PUT inp-call") \
-	EM(rxrpc_conn_put_challenge_input,	"PUT inp-chal") \
 	EM(rxrpc_conn_put_conn_input,		"PUT inp-conn") \
 	EM(rxrpc_conn_put_discard_idle,		"PUT disc-idl") \
 	EM(rxrpc_conn_put_local_dead,		"PUT loc-dead") \
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index bcdfdf9c67a1..7d6a50151931 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -58,11 +58,6 @@ enum rxrpc_cmsg_type {
 	RXRPC_TX_LENGTH		= 12,	/* -s-: Total length of Tx data */
 	RXRPC_SET_CALL_TIMEOUT	= 13,	/* -s-: Set one or more call timeouts */
 	RXRPC_CHARGE_ACCEPT	= 14,	/* Ss-: Charge the accept pool with a user call ID */
-	RXRPC_OOB_ID		= 15,	/* -sr: OOB message ID */
-	RXRPC_CHALLENGED	= 16,	/* C-r: Info on a received CHALLENGE */
-	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
-	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
-	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
 	RXRPC_RESPONSE_APPDATA	= 20,	/* Cs-: User key holding app data for RESPONSE */
 	RXRPC__SUPPORTED
 };
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index f994f9f30a29..f7a5e0a592ee 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -24,7 +24,6 @@ rxrpc-y := \
 	local_object.o \
 	misc.o \
 	net_ns.o \
-	oob.o \
 	output.o \
 	peer_event.o \
 	peer_object.o \
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9eb6ca3c5ebf..9d5ce1c7ad0d 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -633,7 +633,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	unsigned int min_sec_level, val;
+	unsigned int min_sec_level;
 	u16 service_upgrade[2];
 	int ret;
 
@@ -710,23 +710,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 
 		case RXRPC_MANAGE_RESPONSE:
 			ret = -EINVAL;
-			if (optlen != sizeof(unsigned int))
-				goto error;
-			ret = -EISCONN;
-			if (rx->sk.sk_state != RXRPC_UNBOUND)
-				goto error;
-			ret = copy_safe_from_sockptr(&val, sizeof(val),
-						     optval, optlen);
-			if (ret)
-				goto error;
-			ret = -EINVAL;
-			if (val > 1)
-				goto error;
-			if (val)
-				set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-			else
-				clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-			goto success;
+			goto error;
 
 		default:
 			break;
@@ -835,8 +819,6 @@ static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
 	rx->calls = RB_ROOT;
 
 	spin_lock_init(&rx->incoming_lock);
-	skb_queue_head_init(&rx->recvmsg_oobq);
-	rx->pending_oobq = RB_ROOT;
 	INIT_LIST_HEAD(&rx->sock_calls);
 	INIT_LIST_HEAD(&rx->to_be_accepted);
 	INIT_LIST_HEAD(&rx->recvmsg_q);
@@ -884,23 +866,6 @@ static int rxrpc_shutdown(struct socket *sock, int flags)
 	return ret;
 }
 
-/*
- * Purge the out-of-band queue.
- */
-static void rxrpc_purge_oob_queue(struct sock *sk)
-{
-	struct rxrpc_sock *rx = rxrpc_sk(sk);
-	struct sk_buff *skb;
-
-	while ((skb = skb_dequeue(&rx->recvmsg_oobq)))
-		rxrpc_kernel_free_oob(skb);
-	while (!RB_EMPTY_ROOT(&rx->pending_oobq)) {
-		skb = rb_entry(rx->pending_oobq.rb_node, struct sk_buff, rbnode);
-		rb_erase(&skb->rbnode, &rx->pending_oobq);
-		rxrpc_kernel_free_oob(skb);
-	}
-}
-
 /*
  * RxRPC socket destructor
  */
@@ -908,7 +873,6 @@ static void rxrpc_sock_destructor(struct sock *sk)
 {
 	_enter("%p", sk);
 
-	rxrpc_purge_oob_queue(sk);
 	rxrpc_purge_queue(&sk->sk_receive_queue);
 
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
@@ -961,7 +925,6 @@ static int rxrpc_release_sock(struct sock *sk)
 	rxrpc_discard_prealloc(rx);
 	rxrpc_release_calls_on_socket(rx);
 	flush_workqueue(rxrpc_workqueue);
-	rxrpc_purge_oob_queue(sk);
 	rxrpc_purge_queue(&sk->sk_receive_queue);
 
 	rxrpc_unuse_local(rx->local, rxrpc_local_unuse_release_sock);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 20c10428a50e..1c6f4a279034 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -171,9 +171,6 @@ struct rxrpc_sock {
 	const struct rxrpc_kernel_ops *app_ops;	/* Table of kernel app notification funcs */
 	struct rxrpc_local	*local;		/* local endpoint */
 	struct rxrpc_backlog	*backlog;	/* Preallocation for services */
-	struct sk_buff_head	recvmsg_oobq;	/* OOB messages for recvmsg to pick up */
-	struct rb_root		pending_oobq;	/* OOB messages awaiting userspace to respond to */
-	u64			oob_id_counter;	/* OOB message ID counter */
 	spinlock_t		incoming_lock;	/* Incoming call vs service shutdown lock */
 	struct list_head	sock_calls;	/* List of calls owned by this socket */
 	struct list_head	to_be_accepted;	/* calls awaiting acceptance */
@@ -184,7 +181,6 @@ struct rxrpc_sock {
 	struct rb_root		calls;		/* User ID -> call mapping */
 	unsigned long		flags;
 #define RXRPC_SOCK_CONNECTED		0	/* connect_srx is set */
-#define RXRPC_SOCK_MANAGE_RESPONSE	1	/* User wants to manage RESPONSE packets */
 	rwlock_t		call_lock;	/* lock for calls */
 	u32			min_sec_level;	/* minimum security level */
 #define RXRPC_SECURITY_MAX	RXRPC_SECURITY_ENCRYPT
@@ -241,7 +237,6 @@ struct rxrpc_skb_priv {
 			u8		reason;		/* Reason for ack */
 		} ack;
 		struct {
-			struct rxrpc_connection *conn;	/* Connection referred to */
 			union {
 				u32 rxkad_nonce;
 			};
@@ -310,13 +305,6 @@ struct rxrpc_security {
 	bool (*validate_challenge)(struct rxrpc_connection *conn,
 				   struct sk_buff *skb);
 
-	/* Fill out the cmsg for recvmsg() to pass on a challenge to userspace.
-	 * The security class gets to add additional information.
-	 */
-	int (*challenge_to_recvmsg)(struct rxrpc_connection *conn,
-				    struct sk_buff *challenge,
-				    struct msghdr *msg);
-
 	/* Parse sendmsg() control message and respond to challenge. */
 	int (*sendmsg_respond_to_challenge)(struct sk_buff *challenge,
 					    struct msghdr *msg);
@@ -1379,13 +1367,6 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
 	return net_generic(net, rxrpc_net_id);
 }
 
-/*
- * oob.c
- */
-bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb);
-void rxrpc_add_pending_oob(struct rxrpc_sock *rx, struct sk_buff *skb);
-int rxrpc_sendmsg_oob(struct rxrpc_sock *rx, struct msghdr *msg, size_t len);
-
 /*
  * output.c
  */
diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
deleted file mode 100644
index c80ee2487d09..000000000000
--- a/net/rxrpc/oob.c
+++ /dev/null
@@ -1,387 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Out of band message handling (e.g. challenge-response)
- *
- * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/net.h>
-#include <linux/gfp.h>
-#include <linux/skbuff.h>
-#include <linux/export.h>
-#include <linux/sched/signal.h>
-#include <net/sock.h>
-#include <net/af_rxrpc.h>
-#include "ar-internal.h"
-
-enum rxrpc_oob_command {
-	RXRPC_OOB_CMD_UNSET,
-	RXRPC_OOB_CMD_RESPOND,
-} __mode(byte);
-
-struct rxrpc_oob_params {
-	u64			oob_id;		/* ID number of message if reply */
-	s32			abort_code;
-	enum rxrpc_oob_command	command;
-	bool			have_oob_id:1;
-};
-
-/*
- * Post an out-of-band message for attention by the socket or kernel service
- * associated with a reference call.
- */
-bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_sock *rx;
-	struct sock *sk;
-	bool queued = false;
-
-	rcu_read_lock();
-
-	rx = rcu_dereference(call->socket);
-	if (rx) {
-		sk = &rx->sk;
-		spin_lock_irq(&rx->recvmsg_lock);
-
-		if (sk->sk_state < RXRPC_CLOSE) {
-			skb->skb_mstamp_ns = rx->oob_id_counter++;
-			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
-			skb_queue_tail(&rx->recvmsg_oobq, skb);
-			queued = true;
-
-			trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
-			if (rx->app_ops)
-				rx->app_ops->notify_oob(sk, skb);
-		}
-
-		spin_unlock_irq(&rx->recvmsg_lock);
-		if (queued && !rx->app_ops && !sock_flag(sk, SOCK_DEAD))
-			sk->sk_data_ready(sk);
-	}
-
-	rcu_read_unlock();
-	return queued;
-}
-
-/*
- * Locate the OOB message to respond to by its ID.
- */
-static struct sk_buff *rxrpc_find_pending_oob(struct rxrpc_sock *rx, u64 oob_id)
-{
-	struct rb_node *p;
-	struct sk_buff *skb;
-
-	p = rx->pending_oobq.rb_node;
-	while (p) {
-		skb = rb_entry(p, struct sk_buff, rbnode);
-
-		if (oob_id < skb->skb_mstamp_ns)
-			p = p->rb_left;
-		else if (oob_id > skb->skb_mstamp_ns)
-			p = p->rb_right;
-		else
-			return skb;
-	}
-
-	return NULL;
-}
-
-/*
- * Add an OOB message into the pending-response set.  We always assign the next
- * value from a 64-bit counter to the oob_id, so just assume we're always going
- * to be on the right-hand edge of the tree and that the counter won't wrap.
- * The tree is also given a ref to the message.
- */
-void rxrpc_add_pending_oob(struct rxrpc_sock *rx, struct sk_buff *skb)
-{
-	struct rb_node **pp = &rx->pending_oobq.rb_node, *p = NULL;
-
-	while (*pp) {
-		p = *pp;
-		pp = &(*pp)->rb_right;
-	}
-
-	rb_link_node(&skb->rbnode, p, pp);
-	rb_insert_color(&skb->rbnode, &rx->pending_oobq);
-}
-
-/*
- * Extract control messages from the sendmsg() control buffer.
- */
-static int rxrpc_sendmsg_oob_cmsg(struct msghdr *msg, struct rxrpc_oob_params *p)
-{
-	struct cmsghdr *cmsg;
-	int len;
-
-	if (msg->msg_controllen == 0)
-		return -EINVAL;
-
-	for_each_cmsghdr(cmsg, msg) {
-		if (!CMSG_OK(msg, cmsg))
-			return -EINVAL;
-
-		len = cmsg->cmsg_len - sizeof(struct cmsghdr);
-		_debug("CMSG %d, %d, %d",
-		       cmsg->cmsg_level, cmsg->cmsg_type, len);
-
-		if (cmsg->cmsg_level != SOL_RXRPC)
-			continue;
-
-		switch (cmsg->cmsg_type) {
-		case RXRPC_OOB_ID:
-			if (len != sizeof(p->oob_id) || p->have_oob_id)
-				return -EINVAL;
-			memcpy(&p->oob_id, CMSG_DATA(cmsg), sizeof(p->oob_id));
-			p->have_oob_id = true;
-			break;
-		case RXRPC_RESPOND:
-			if (p->command != RXRPC_OOB_CMD_UNSET)
-				return -EINVAL;
-			p->command = RXRPC_OOB_CMD_RESPOND;
-			break;
-		case RXRPC_ABORT:
-			if (len != sizeof(p->abort_code) || p->abort_code)
-				return -EINVAL;
-			memcpy(&p->abort_code, CMSG_DATA(cmsg), sizeof(p->abort_code));
-			if (p->abort_code == 0)
-				return -EINVAL;
-			break;
-		case RXRPC_RESP_RXGK_APPDATA:
-			if (p->command != RXRPC_OOB_CMD_RESPOND)
-				return -EINVAL;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	switch (p->command) {
-	case RXRPC_OOB_CMD_RESPOND:
-		if (!p->have_oob_id)
-			return -EBADSLT;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/*
- * Allow userspace to respond to an OOB using sendmsg().
- */
-static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
-				struct rxrpc_oob_params *p,
-				struct msghdr *msg)
-{
-	struct rxrpc_connection *conn;
-	struct rxrpc_skb_priv *sp;
-	struct sk_buff *skb;
-	int ret;
-
-	skb = rxrpc_find_pending_oob(rx, p->oob_id);
-	if (skb)
-		rb_erase(&skb->rbnode, &rx->pending_oobq);
-	release_sock(&rx->sk);
-	if (!skb)
-		return -EBADSLT;
-
-	sp = rxrpc_skb(skb);
-
-	switch (p->command) {
-	case RXRPC_OOB_CMD_RESPOND:
-		ret = -EPROTO;
-		if (skb->mark != RXRPC_OOB_CHALLENGE)
-			break;
-		conn = sp->chall.conn;
-		ret = -EOPNOTSUPP;
-		if (!conn->security->sendmsg_respond_to_challenge)
-			break;
-		if (p->abort_code) {
-			rxrpc_abort_conn(conn, NULL, p->abort_code, -ECONNABORTED,
-					 rxrpc_abort_response_sendmsg);
-			ret = 0;
-		} else {
-			ret = conn->security->sendmsg_respond_to_challenge(skb, msg);
-		}
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	switch (skb->mark) {
-	case RXRPC_OOB_CHALLENGE:
-		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
-		break;
-	}
-	rxrpc_free_skb(skb, rxrpc_skb_put_oob);
-	return ret;
-}
-
-/*
- * Send an out-of-band message or respond to a received out-of-band message.
- * - caller gives us the socket lock
- * - the socket may be either a client socket or a server socket
- */
-int rxrpc_sendmsg_oob(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
-{
-	struct rxrpc_oob_params p = {};
-	int ret;
-
-	_enter("");
-
-	ret = rxrpc_sendmsg_oob_cmsg(msg, &p);
-	if (ret < 0)
-		goto error_release_sock;
-
-	if (p.have_oob_id)
-		return rxrpc_respond_to_oob(rx, &p, msg);
-
-	release_sock(&rx->sk);
-
-	switch (p.command) {
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-
-error_release_sock:
-	release_sock(&rx->sk);
-	return ret;
-}
-
-/**
- * rxrpc_kernel_query_oob - Query the parameters of an out-of-band message
- * @oob: The message to query
- * @_peer: Where to return the peer record
- * @_peer_appdata: The application data attached to a peer record
- *
- * Extract useful parameters from an out-of-band message.  The source peer
- * parameters are returned through the argument list and the message type is
- * returned.
- *
- * Return:
- * * %RXRPC_OOB_CHALLENGE - Challenge wanting a response.
- */
-enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
-					   struct rxrpc_peer **_peer,
-					   unsigned long *_peer_appdata)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
-	enum rxrpc_oob_type type = oob->mark;
-
-	switch (type) {
-	case RXRPC_OOB_CHALLENGE:
-		*_peer		= sp->chall.conn->peer;
-		*_peer_appdata	= sp->chall.conn->peer->app_data;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		*_peer		= NULL;
-		*_peer_appdata	= 0;
-		break;
-	}
-
-	return type;
-}
-EXPORT_SYMBOL(rxrpc_kernel_query_oob);
-
-/**
- * rxrpc_kernel_dequeue_oob - Dequeue and return the front OOB message
- * @sock: The socket to query
- * @_type: Where to return the message type
- *
- * Dequeue the front OOB message, if there is one, and return it and
- * its type.
- *
- * Return: The sk_buff representing the OOB message or %NULL if the queue was
- * empty.
- */
-struct sk_buff *rxrpc_kernel_dequeue_oob(struct socket *sock,
-					 enum rxrpc_oob_type *_type)
-{
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct sk_buff *oob;
-
-	oob = skb_dequeue(&rx->recvmsg_oobq);
-	if (oob)
-		*_type = oob->mark;
-	return oob;
-}
-EXPORT_SYMBOL(rxrpc_kernel_dequeue_oob);
-
-/**
- * rxrpc_kernel_free_oob - Free an out-of-band message
- * @oob: The OOB message to free
- *
- * Free an OOB message along with any resources it holds.
- */
-void rxrpc_kernel_free_oob(struct sk_buff *oob)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
-
-	switch (oob->mark) {
-	case RXRPC_OOB_CHALLENGE:
-		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
-		break;
-	}
-
-	rxrpc_free_skb(oob, rxrpc_skb_put_purge_oob);
-}
-EXPORT_SYMBOL(rxrpc_kernel_free_oob);
-
-/**
- * rxrpc_kernel_query_challenge - Query the parameters of a challenge
- * @challenge: The challenge to query
- * @_peer: Where to return the peer record
- * @_peer_appdata: The application data attached to a peer record
- * @_service_id: Where to return the connection service ID
- * @_security_index: Where to return the connection security index
- *
- * Extract useful parameters from a CHALLENGE message.
- */
-void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
-				  struct rxrpc_peer **_peer,
-				  unsigned long *_peer_appdata,
-				  u16 *_service_id, u8 *_security_index)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
-
-	*_peer		= sp->chall.conn->peer;
-	*_peer_appdata	= sp->chall.conn->peer->app_data;
-	*_service_id	= sp->hdr.serviceId;
-	*_security_index = sp->hdr.securityIndex;
-}
-EXPORT_SYMBOL(rxrpc_kernel_query_challenge);
-
-/**
- * rxrpc_kernel_reject_challenge - Allow a kernel service to reject a challenge
- * @challenge: The challenge to be rejected
- * @abort_code: The abort code to stick into the ABORT packet
- * @error: Local error value
- * @why: Indication as to why.
- *
- * Allow a kernel service to reject a challenge by aborting the connection if
- * it's still in an abortable state.  The error is returned so this function
- * can be used with a return statement.
- *
- * Return: The %error parameter.
- */
-int rxrpc_kernel_reject_challenge(struct sk_buff *challenge, u32 abort_code,
-				  int error, enum rxrpc_abort_reason why)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
-
-	_enter("{%x},%d,%d,%u", sp->hdr.serial, abort_code, error, why);
-
-	rxrpc_abort_conn(sp->chall.conn, NULL, abort_code, error, why);
-	return error;
-}
-EXPORT_SYMBOL(rxrpc_kernel_reject_challenge);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 33577522ec02..5b8c7f573b7f 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -201,61 +201,6 @@ static int rxrpc_recvmsg_user_id(struct rxrpc_call *call, struct msghdr *msg,
 	}
 }
 
-/*
- * Deal with a CHALLENGE packet.
- */
-static int rxrpc_recvmsg_challenge(struct socket *sock, struct msghdr *msg,
-				   struct sk_buff *challenge, unsigned int flags)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
-	struct rxrpc_connection *conn = sp->chall.conn;
-
-	return conn->security->challenge_to_recvmsg(conn, challenge, msg);
-}
-
-/*
- * Process OOB packets.  Called with the socket locked.
- */
-static int rxrpc_recvmsg_oob(struct socket *sock, struct msghdr *msg,
-			     unsigned int flags)
-{
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct sk_buff *skb;
-	bool need_response = false;
-	int ret;
-
-	skb = skb_peek(&rx->recvmsg_oobq);
-	if (!skb)
-		return -EAGAIN;
-	rxrpc_see_skb(skb, rxrpc_skb_see_recvmsg);
-
-	ret = put_cmsg(msg, SOL_RXRPC, RXRPC_OOB_ID, sizeof(u64),
-		       &skb->skb_mstamp_ns);
-	if (ret < 0)
-		return ret;
-
-	switch ((enum rxrpc_oob_type)skb->mark) {
-	case RXRPC_OOB_CHALLENGE:
-		need_response = true;
-		ret = rxrpc_recvmsg_challenge(sock, msg, skb, flags);
-		break;
-	default:
-		WARN_ONCE(1, "recvmsg() can't process unknown OOB type %u\n",
-			  skb->mark);
-		ret = -EIO;
-		break;
-	}
-
-	if (!(flags & MSG_PEEK)) {
-		skb_unlink(skb, &rx->recvmsg_oobq);
-		if (need_response)
-			rxrpc_add_pending_oob(rx, skb);
-		else
-			rxrpc_free_skb(skb, rxrpc_skb_put_oob);
-	}
-	return ret;
-}
-
 /*
  * Deliver messages to a call.  This keeps processing packets until the buffer
  * is filled and we find either more DATA (returns 0) or the end of the DATA
@@ -267,7 +212,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 			      size_t len, int flags, size_t *_offset)
 {
 	struct rxrpc_skb_priv *sp;
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	struct sk_buff *skb;
 	rxrpc_seq_t seq = 0;
 	size_t remain;
@@ -362,13 +306,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 
 		if (!(flags & MSG_PEEK))
 			rxrpc_rotate_rx_window(call);
-
-		if (!rx->app_ops &&
-		    !skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
-			trace_rxrpc_recvdata(call, rxrpc_recvmsg_oobq, seq,
-					     rx_pkt_offset, rx_pkt_len, ret);
-			break;
-		}
 	}
 
 out:
@@ -416,14 +353,12 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	/* Return immediately if a client socket has no outstanding calls */
 	if (RB_EMPTY_ROOT(&rx->calls) &&
 	    list_empty(&rx->recvmsg_q) &&
-	    skb_queue_empty_lockless(&rx->recvmsg_oobq) &&
 	    rx->sk.sk_state != RXRPC_SERVER_LISTENING) {
 		release_sock(&rx->sk);
 		return -EAGAIN;
 	}
 
-	if (list_empty(&rx->recvmsg_q) &&
-	    skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
+	if (list_empty(&rx->recvmsg_q)) {
 		ret = -EWOULDBLOCK;
 		if (timeo == 0) {
 			call = NULL;
@@ -439,8 +374,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (ret)
 			goto wait_error;
 
-		if (list_empty(&rx->recvmsg_q) &&
-		    skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
+		if (list_empty(&rx->recvmsg_q)) {
 			if (signal_pending(current))
 				goto wait_interrupted;
 			trace_rxrpc_recvmsg(0, rxrpc_recvmsg_wait, 0);
@@ -450,15 +384,6 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto try_again;
 	}
 
-	/* Deal with OOB messages before we consider getting normal data. */
-	if (!skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
-		ret = rxrpc_recvmsg_oob(sock, msg, flags);
-		release_sock(&rx->sk);
-		if (ret == -EAGAIN)
-			goto try_again;
-		goto error_trace;
-	}
-
 	/* Find the next call and dequeue it if we're not just peeking.  If we
 	 * do dequeue it, that comes with a ref that we will need to release.
 	 * We also want to weed out calls that got requeued whilst we were
@@ -469,8 +394,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
-	    skb_queue_empty(&call->recvmsg_queue) &&
-	    skb_queue_empty(&rx->recvmsg_oobq)) {
+	    skb_queue_empty(&call->recvmsg_queue)) {
 		list_del_init(&call->recvmsg_link);
 		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index f3e085b64502..b9efeec145dd 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -735,37 +735,6 @@ static bool rxgk_validate_challenge(struct rxrpc_connection *conn,
 	return true;
 }
 
-/**
- * rxgk_kernel_query_challenge - Query RxGK-specific challenge parameters
- * @challenge: The challenge packet to query
- *
- * Return: The Kerberos 5 encoding type for the challenged connection.
- */
-u32 rxgk_kernel_query_challenge(struct sk_buff *challenge)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
-
-	return sp->chall.conn->rxgk.enctype;
-}
-EXPORT_SYMBOL(rxgk_kernel_query_challenge);
-
-/*
- * Fill out the control message to pass to userspace to inform about the
- * challenge.
- */
-static int rxgk_challenge_to_recvmsg(struct rxrpc_connection *conn,
-				     struct sk_buff *challenge,
-				     struct msghdr *msg)
-{
-	struct rxgk_challenge chall;
-
-	chall.base.service_id		= conn->service_id;
-	chall.base.security_index	= conn->security_ix;
-	chall.enctype			= conn->rxgk.enctype;
-
-	return put_cmsg(msg, SOL_RXRPC, RXRPC_CHALLENGED, sizeof(chall), &chall);
-}
-
 /*
  * Insert the requisite amount of XDR padding for the length given.
  */
@@ -1044,46 +1013,6 @@ static int rxgk_respond_to_challenge(struct rxrpc_connection *conn,
 	return ret;
 }
 
-/**
- * rxgk_kernel_respond_to_challenge - Respond to a challenge with appdata
- * @challenge: The challenge to respond to
- * @appdata: The application data to include in the RESPONSE authenticator
- *
- * Allow a kernel application to respond to a CHALLENGE with application data
- * to be included in the RxGK RESPONSE Authenticator.
- *
- * Return: %0 if successful and a negative error code otherwise.
- */
-int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
-				     struct krb5_buffer *appdata)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(rxgk_kernel_respond_to_challenge);
-
-/*
- * Parse sendmsg() control message and respond to challenge.  We need to see if
- * there's an appdata to fish out.
- */
-static int rxgk_sendmsg_respond_to_challenge(struct sk_buff *challenge,
-					     struct msghdr *msg)
-{
-	struct krb5_buffer appdata = {};
-	struct cmsghdr *cmsg;
-
-	for_each_cmsghdr(cmsg, msg) {
-		if (cmsg->cmsg_level != SOL_RXRPC ||
-		    cmsg->cmsg_type != RXRPC_RESP_RXGK_APPDATA)
-			continue;
-		if (appdata.data)
-			return -EINVAL;
-		appdata.data = CMSG_DATA(cmsg);
-		appdata.len = cmsg->cmsg_len - sizeof(struct cmsghdr);
-	}
-
-	return rxgk_kernel_respond_to_challenge(challenge, &appdata);
-}
-
 /*
  * Verify the authenticator.
  *
@@ -1357,8 +1286,6 @@ const struct rxrpc_security rxgk_yfs = {
 	.free_call_crypto		= rxgk_free_call_crypto,
 	.issue_challenge		= rxgk_issue_challenge,
 	.validate_challenge		= rxgk_validate_challenge,
-	.challenge_to_recvmsg		= rxgk_challenge_to_recvmsg,
-	.sendmsg_respond_to_challenge	= rxgk_sendmsg_respond_to_challenge,
 	.respond_to_challenge		= rxgk_respond_to_challenge,
 	.verify_response		= rxgk_verify_response,
 	.clear				= rxgk_clear,
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index ca9f0e82cb9a..e55bfca10e1a 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -748,32 +748,6 @@ static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
 	return ret;
 }
 
-/*
- * RxKAD does automatic response only as there's nothing to manage that isn't
- * already in the key.
- */
-static int rxkad_sendmsg_respond_to_challenge(struct sk_buff *challenge,
-					      struct msghdr *msg)
-{
-	return -EINVAL;
-}
-
-/**
- * rxkad_kernel_respond_to_challenge - Respond to a challenge with appdata
- * @challenge: The challenge to respond to
- *
- * Allow a kernel application to respond to a CHALLENGE.
- *
- * Return: %0 if successful and a negative error code otherwise.
- */
-int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge)
-{
-	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
-
-	return rxkad_respond_to_challenge(csp->chall.conn, challenge);
-}
-EXPORT_SYMBOL(rxkad_kernel_respond_to_challenge);
-
 /* Decrypt data in-place using DES-PCBC.  @len must be a multiple of 8. */
 VISIBLE_IF_KUNIT void des_pcbc_decrypt_inplace(const struct des_ctx *key,
 					       __le64 iv, u8 *data, size_t len)
@@ -1134,7 +1108,6 @@ const struct rxrpc_security rxkad = {
 	.free_call_crypto		= rxkad_free_call_crypto,
 	.issue_challenge		= rxkad_issue_challenge,
 	.validate_challenge		= rxkad_validate_challenge,
-	.sendmsg_respond_to_challenge	= rxkad_sendmsg_respond_to_challenge,
 	.respond_to_challenge		= rxkad_respond_to_challenge,
 	.verify_response		= rxkad_verify_response,
 	.clear				= rxkad_clear,
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index 3efe104b1930..fc6f478e1762 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -173,43 +173,3 @@ int rxrpc_sock_set_security_keyring(struct sock *sk, struct key *keyring)
 	return ret;
 }
 EXPORT_SYMBOL(rxrpc_sock_set_security_keyring);
-
-/**
- * rxrpc_sock_set_manage_response - Set the manage-response flag for a kernel service
- * @sk: The socket to set the keyring on
- * @set: True to set, false to clear the flag
- *
- * Set the flag on an rxrpc socket to say that the caller wants to manage the
- * RESPONSE packet and the user-defined data it may contain.  Setting this
- * means that recvmsg() will return messages with RXRPC_CHALLENGED in the
- * control message buffer containing information about the challenge.
- *
- * The user should respond to the challenge by passing RXRPC_RESPOND or
- * RXRPC_RESPOND_ABORT control messages with sendmsg() to the same call.
- * Supplementary control messages, such as RXRPC_RESP_RXGK_APPDATA, may be
- * included to indicate the parts the user wants to supply.
- *
- * The server will be passed the response data with a RXRPC_RESPONDED control
- * message when it gets the first data from each call.
- *
- * Note that this is only honoured by security classes that need auxiliary data
- * (e.g. RxGK).  Those that don't offer the facility (e.g. RxKAD) respond
- * without consulting userspace.
- *
- * Return: The previous setting.
- */
-int rxrpc_sock_set_manage_response(struct sock *sk, bool set)
-{
-	struct rxrpc_sock *rx = rxrpc_sk(sk);
-	int ret;
-
-	lock_sock(sk);
-	ret = !!test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-	if (set)
-		set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-	else
-		clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-	release_sock(sk);
-	return ret;
-}
-EXPORT_SYMBOL(rxrpc_sock_set_manage_response);


