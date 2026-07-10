Return-Path: <netdev+bounces-306676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F3R0Md5HUWo2BwMAu9opvQ
	(envelope-from <netdev+bounces-306676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49773DC37
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Dpj/kwZk";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306676-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306676-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 874A730A996D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500CE38AC64;
	Fri, 10 Jul 2026 19:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0638F620
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711423; cv=none; b=exfYRFD0ZPf6MJ1z09wzxON5/zDUhuVI2sCUDyfSIOdpy3e/BhodUuiKpz3PWSp0cHKqHnV2N1qSDI0qfymjK6sx7bWbXJOM+K7fOd/iJFC2yK7Q2D5gPLx5VSOlcDNgd9I32f0001jAA+rcG2MN9gQhGF6njzdjYw0kv0/pAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711423; c=relaxed/simple;
	bh=8doUWbBtR90GpZH/h8PCqfSXkZbH5v21J+mIadSAvcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smudd9BE2K3x6wFYsNaoySVuIYSsIJvDiZ70pAuvD0pR+aJk/yTYj9UxaXsb1WMQ6xh4k7YNlQELJUbt8nzc0BDaEcHt3Uj/tOhfXa++xMSA2Ep/jk2ywVzO/dYGlPBXYM5G+yOwH14/TStELgh8jHWtk1m1UVQnXULVZGMYSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpj/kwZk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE7Fy1/vJLutSdmOsmwasltC6iGjSPulEbNA2iMtznM=;
	b=Dpj/kwZk3HZoWa6UHVUCIDmznYKLk6dlsNINl/WezLF3dpWmaA0PZ7LPmjAUbH+nWbTvO3
	3z7N7FXVyMIc9Fmx84tO+ecU3g7DdwMayQWwbTBTRtkqWZDfVxhV/zx5pLJDzeKntYdpRX
	Ky/q4u/6I+q9x0vs8CJ71Pqwi+NvXyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-r0WwPmrnMKqdmbb37eJI3A-1; Fri,
 10 Jul 2026 15:23:34 -0400
X-MC-Unique: r0WwPmrnMKqdmbb37eJI3A-1
X-Mimecast-MFC-AGG-ID: r0WwPmrnMKqdmbb37eJI3A_1783711412
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DA4818007EA;
	Fri, 10 Jul 2026 19:23:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89DAF36933;
	Fri, 10 Jul 2026 19:23:28 +0000 (UTC)
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
Subject: [PATCH net v2 13/16] afs: Create a server appdata key
Date: Fri, 10 Jul 2026 20:22:15 +0100
Message-ID: <20260710192220.1922433-14-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306676-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F49773DC37

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

This is a part of the fix.  With this, the AFS filesystem creates an
appdata key for each fileserver it talks to with RxGK and attaches it to
the afs_server record.

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
 fs/afs/cm_security.c   | 232 +++++++++++++++++++++++++++++++++++++++++
 fs/afs/fs_probe.c      |   5 +
 fs/afs/internal.h      |   2 +
 fs/afs/server.c        |   1 +
 include/net/af_rxrpc.h |   2 +
 net/rxrpc/key.c        |  37 +++++++
 6 files changed, 279 insertions(+)

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index 103168c70dd4..36907a04efd0 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/slab.h>
+#include <linux/key-type.h>
 #include <crypto/krb5.h>
+#include <keys/user-type.h>
 #include "internal.h"
 #include "afs_cm.h"
 #include "afs_fs.h"
@@ -23,6 +25,236 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
 				   struct afs_server *server);
 #endif
 
+#ifdef CONFIG_RXGK
+/*
+ * As the YFS RxGK appdata to be passed in the YFS.FS-service RESPONSE packet,
+ * create a GSS token to use as a ticket to the specified fileserver.
+ */
+static int afs_create_yfs_rxgk_cm_appdata(struct afs_server *server, u32 enctype)
+{
+	const struct krb5_enctype *conn_krb5, *token_krb5;
+	const struct krb5_buffer *token_key;
+	struct crypto_aead *aead;
+	struct scatterlist sg;
+	struct afs_net *net = server->cell->net;
+	const struct key *cm_key = net->fs_cm_token_key;
+	struct key *appdata_key = NULL;
+	size_t keysize, uuidsize, authsize, toksize, encsize, contsize;
+	size_t adatasize, offset;
+	__be32 caps[1] = {
+		[0] = htonl(AFS_CAP_ERROR_TRANSLATION),
+	};
+	__be32 *xdr;
+	void *appdata, *K0, *encbase;
+	int ret;
+
+	if (!cm_key)
+		return -ENOKEY;
+
+	/* Assume that the fileserver is happy to use the same encoding type as
+	 * we were told to use by the token obtained by the user.
+	 */
+	conn_krb5 = crypto_krb5_find_enctype(enctype);
+	if (!conn_krb5)
+		return -ENOPKG;
+	token_krb5 = cm_key->payload.data[0];
+	token_key = (const struct krb5_buffer *)&cm_key->payload.data[2];
+
+	/* struct rxgk_key {
+	 *	afs_uint32	enctype;
+	 *	opaque		key<>;
+	 * };
+	 */
+	keysize = 4 + xdr_len_object(conn_krb5->key_len);
+
+	/* struct RXGK_AuthName {
+	 *	afs_int32	kind;
+	 *	opaque		data<AUTHDATAMAX>;
+	 *	opaque		display<AUTHPRINTABLEMAX>;
+	 * };
+	 */
+	uuidsize = sizeof(server->uuid);
+	authsize = 4 + xdr_len_object(uuidsize) + xdr_len_object(0);
+
+	/* struct RXGK_Token {
+	 *	rxgk_key		K0;
+	 *	RXGK_Level		level;
+	 *	rxgkTime		starttime;
+	 *	afs_int32		lifetime;
+	 *	afs_int32		bytelife;
+	 *	rxgkTime		expirationtime;
+	 *	struct RXGK_AuthName	identities<>;
+	 * };
+	 */
+	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
+
+	offset = 0;
+	encsize = crypto_krb5_how_much_buffer(token_krb5, KRB5_ENCRYPT_MODE, toksize, &offset);
+
+	/* struct RXGK_TokenContainer {
+	 *	afs_int32	kvno;
+	 *	afs_int32	enctype;
+	 *	opaque		encrypted_token<>;
+	 * };
+	 */
+	contsize = 4 + 4 + xdr_len_object(encsize);
+
+	/* struct YFSAppData {
+	 *	opr_uuid	initiatorUuid;
+	 *	opr_uuid	acceptorUuid;
+	 *	Capabilities	caps;
+	 *	afs_int32	enctype;
+	 *	opaque		callbackKey<>;
+	 *	opaque		callbackToken<>;
+	 * };
+	 */
+	adatasize = 16 + 16 +
+		xdr_len_object(sizeof(caps)) +
+		4 +
+		xdr_len_object(conn_krb5->key_len) +
+		xdr_len_object(contsize);
+
+	ret = -ENOMEM;
+	appdata = kzalloc(adatasize, GFP_KERNEL);
+	if (!appdata)
+		goto out;
+	xdr = appdata;
+
+	memcpy(xdr, &net->uuid, 16);		/* appdata.initiatorUuid */
+	xdr += 16 / 4;
+	memcpy(xdr, &server->uuid, 16);		/* appdata.acceptorUuid */
+	xdr += 16 / 4;
+	*xdr++ = htonl(ARRAY_SIZE(caps));	/* appdata.caps.len */
+	memcpy(xdr, &caps, sizeof(caps));	/* appdata.caps */
+	xdr += ARRAY_SIZE(caps);
+	*xdr++ = htonl(conn_krb5->etype);	/* appdata.enctype */
+
+	*xdr++ = htonl(conn_krb5->key_len);	/* appdata.callbackKey.len */
+	K0 = xdr;
+	get_random_bytes(K0, conn_krb5->key_len); /* appdata.callbackKey.data */
+	xdr += xdr_round_up(conn_krb5->key_len) / 4;
+
+	*xdr++ = htonl(contsize);		/* appdata.callbackToken.len */
+	*xdr++ = htonl(1);			/* cont.kvno */
+	*xdr++ = htonl(token_krb5->etype);	/* cont.enctype */
+	*xdr++ = htonl(encsize);		/* cont.encrypted_token.len */
+
+	encbase = xdr;
+	xdr += offset / 4;
+	*xdr++ = htonl(conn_krb5->etype);	/* token.K0.enctype */
+	*xdr++ = htonl(conn_krb5->key_len);	/* token.K0.key.len */
+	memcpy(xdr, K0, conn_krb5->key_len);	/* token.K0.key.data */
+	xdr += xdr_round_up(conn_krb5->key_len) / 4;
+
+	*xdr++ = htonl(RXRPC_SECURITY_ENCRYPT);	/* token.level */
+	*xdr++ = htonl(0);			/* token.starttime */
+	*xdr++ = htonl(0);			/* " */
+	*xdr++ = htonl(0);			/* token.lifetime */
+	*xdr++ = htonl(0);			/* token.bytelife */
+	*xdr++ = htonl(0);			/* token.expirationtime */
+	*xdr++ = htonl(0);			/* " */
+	*xdr++ = htonl(1);			/* token.identities.count */
+	*xdr++ = htonl(0);			/* token.identities[0].kind */
+	*xdr++ = htonl(uuidsize);		/* token.identities[0].data.len */
+	memcpy(xdr, &server->uuid, uuidsize);
+	xdr += xdr_round_up(uuidsize) / 4;
+	*xdr++ = htonl(0);			/* token.identities[0].display.len */
+
+	xdr = encbase + xdr_round_up(encsize);
+
+	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
+		pr_err("Appdata size incorrect %lx != %zx\n",
+		       (unsigned long)xdr - (unsigned long)appdata, adatasize);
+
+	aead = crypto_krb5_prepare_encryption(token_krb5, token_key, RXGK_SERVER_ENC_TOKEN,
+					      GFP_KERNEL);
+	if (IS_ERR(aead)) {
+		ret = PTR_ERR(aead);
+		goto out_token;
+	}
+
+	sg_init_one(&sg, encbase, encsize);
+	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);
+	if (ret < 0)
+		goto out_aead;
+
+	appdata_key = key_alloc(&key_type_user, "rxrpc: afs rxgk appdata",
+				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+				KEY_POS_VIEW | KEY_POS_SEARCH | KEY_USR_VIEW,
+				KEY_ALLOC_NOT_IN_QUOTA, NULL);
+	if (IS_ERR(appdata_key)) {
+		ret = PTR_ERR(appdata_key);
+		goto out_aead;
+	}
+
+	ret = key_instantiate_and_link(appdata_key, appdata, adatasize, NULL, NULL);
+	if (ret < 0) {
+		key_put(appdata_key);
+		goto out_aead;
+	}
+
+	/* Store the appdata before the key pointer */
+	smp_store_release(&server->yfs_rxgk_appdata, appdata_key);
+
+out_aead:
+	crypto_free_aead(aead);
+out_token:
+	kfree(appdata);
+out:
+	return ret;
+}
+#endif /* CONFIG_RXGK */
+
+/*
+ * Create the application data to go in a RESPONSE packet a server's CHALLENGE
+ * from the parameters contained in a key.  The key specifies the security
+ * index and other appropriate parameters such as the encoding type for RxGK.
+ */
+int afs_create_server_appdata(struct afs_server *server, struct key *key)
+{
+	u32 krb5_enctype;
+	int ret;
+	u8 security_index;
+
+	if (!key)
+		return 0;
+
+	rxrpc_kernel_query_key(key, &security_index, &krb5_enctype);
+
+	_enter("%u,%u", security_index, krb5_enctype);
+
+	switch (security_index) {
+#ifdef CONFIG_RXGK
+	case RXRPC_SECURITY_YFS_RXGK:
+		/* Read the key pointer before the appdata */
+		if (smp_load_acquire(&server->yfs_rxgk_appdata))
+			return 0;
+		break;
+#endif
+	default:
+		return 0;
+	}
+
+	ret = 0;
+	mutex_lock(&server->cm_token_lock);
+
+	switch (security_index) {
+#ifdef CONFIG_RXGK
+	case RXRPC_SECURITY_YFS_RXGK:
+		/* Read the key pointer before the appdata */
+		if (smp_load_acquire(&server->yfs_rxgk_appdata))
+			break;
+		ret = afs_create_yfs_rxgk_cm_appdata(server, krb5_enctype);
+		break;
+#endif
+	default:
+		break;
+	}
+
+	mutex_unlock(&server->cm_token_lock);
+	return ret;
+}
+
 /*
  * Respond to an RxGK challenge, adding appdata.
  */
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index a91ad1938d07..e26f7f1e30a2 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -241,9 +241,14 @@ int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	struct afs_endpoint_state *estate, *old;
 	struct afs_addr_list *old_alist = NULL, *alist;
 	unsigned long unprobed;
+	int ret;
 
 	_enter("%pU", &server->uuid);
 
+	ret = afs_create_server_appdata(server, key);
+	if (ret < 0)
+		return ret;
+
 	estate = kzalloc_obj(*estate);
 	if (!estate)
 		return -ENOMEM;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 47e2cae979b6..738d529ec97b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -547,6 +547,7 @@ struct afs_server {
 	struct timer_list	timer;		/* Management timer */
 	struct mutex		cm_token_lock;	/* Lock governing creation of appdata */
 	struct krb5_buffer	cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
+	struct key		*yfs_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
@@ -1089,6 +1090,7 @@ extern bool afs_cm_incoming_call(struct afs_call *);
 /*
  * cm_security.c
  */
+int afs_create_server_appdata(struct afs_server *server, struct key *key);
 void afs_process_oob_queue(struct work_struct *work);
 #ifdef CONFIG_RXGK
 int afs_create_token_key(struct afs_net *net, struct socket *socket);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 0fe162ea2a36..b08d9080b0c5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -399,6 +399,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 			       afs_estate_trace_put_server);
 	afs_put_cell(server->cell, afs_cell_trace_put_server);
 	kfree(server->cm_rxgk_appdata.data);
+	key_put(server->yfs_rxgk_appdata);
 	kfree(server);
 }
 
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0fb4c41c9bbf..c4b68049c06f 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -109,6 +109,8 @@ int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge);
 u32 rxgk_kernel_query_challenge(struct sk_buff *challenge);
 int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
 				     struct krb5_buffer *appdata);
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index,
+			    u32 *_krb5_enctype);
 u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
 				    u16 *_service_id, u32 *_enctype);
 
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index a0aa78d89289..16bab72e6f07 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -893,3 +893,40 @@ static long rxrpc_read(const struct key *key,
 	_leave(" = %zu", size);
 	return size;
 }
+
+/**
+ * rxrpc_kernel_query_key - Query parameters from an rxrpc key
+ * @key: The key to query
+ * @_security_index: Where to return the security index
+ * @_krb5_enctype: Where to return the krb5 encryption type if applicable
+ *
+ * Query an rxrpc authentication key, extracting the security index from the
+ * first token therein.
+ */
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index,
+			    u32 *_krb5_enctype)
+{
+	const struct rxrpc_key_token *token;
+
+	token = key->payload.data[0];
+	if (!token) {
+		*_security_index = 0;
+		*_krb5_enctype = 0;
+		return;
+	}
+
+	*_security_index = token->security_index;
+	switch (token->security_index) {
+	case RXRPC_SECURITY_RXKAD:
+		*_krb5_enctype = 0;
+		break;
+	case RXRPC_SECURITY_YFS_RXGK:
+		*_krb5_enctype = token->rxgk->enctype;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		*_krb5_enctype = 0;
+		break;
+	}
+}
+EXPORT_SYMBOL(rxrpc_kernel_query_key);


