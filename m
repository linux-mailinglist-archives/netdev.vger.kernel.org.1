Return-Path: <netdev+bounces-179554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22630A7D968
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC1E1694BA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D7236A84;
	Mon,  7 Apr 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBmfGVTg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06423BD14
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017361; cv=none; b=r5eEh6atMF+hNd/hABN2vUudave4NPMLtX8KLyMojHxEQYbbPiC9jIcWHB1lUd1BgrlUv4YYMsubhDoqSTZOTSKhVf+zyGtCUnSoCqGYO3elYPGDgxGHaW5TLs6Ne/GODC6WhaeT6sQYZrotcoec4Xn+v0v8vlGm1AuOmYuXvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017361; c=relaxed/simple;
	bh=7PFTZoiRqZIFa1S8HY4RFZuUY5xB8XsvuPDPPg2SagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvr4T6yO4ClttnVi2R7Fg1JNv2YQgDO2sJyW2Jj/2h7vn6MnD/fD1RzMJUtiKoo1pvP+PUjx05KvXlqhcjYE3Oz2+E66TVJIG9Z/0wxlzZJZzgm0RgPzhYyuifCEZfY8RSFISCwIFHYQG2iC7xVjvlydh+tbIm4ydYtxDGQ6MyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBmfGVTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQnfS10ACDviDWjLmMuus06T4pE/Wv9vuCbqkyyDBV0=;
	b=aBmfGVTgpWw1vFdN5uYG7MsfxwIkhHHPq2ce/Zkz5PubkpnEUssjHvYJj7BbqRgbLOxR/d
	XmKLyICeFBu/9xRijWasH9KdBx7OUlQRC2+OhKm2uao0kimSr4gmIMPxK+ldGJ+pUCuLC0
	l9j/0nTCBcfTzMH9oEiJMVUf09EDkas=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-GJFFchXJOB2eUC-6sZ1Xaw-1; Mon,
 07 Apr 2025 05:15:55 -0400
X-MC-Unique: GJFFchXJOB2eUC-6sZ1Xaw-1
X-Mimecast-MFC-AGG-ID: GJFFchXJOB2eUC-6sZ1Xaw_1744017353
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A574C180AF4C;
	Mon,  7 Apr 2025 09:15:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42BFB180094A;
	Mon,  7 Apr 2025 09:15:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/12] afs: Use rxgk RESPONSE to pass token for callback channel
Date: Mon,  7 Apr 2025 10:14:41 +0100
Message-ID: <20250407091451.1174056-11-dhowells@redhat.com>
In-Reply-To: <20250407091451.1174056-1-dhowells@redhat.com>
References: <20250407091451.1174056-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Implement in kafs the hook for adding appdata into a RESPONSE packet
generated in response to an RxGK CHALLENGE packet, and include the key for
securing the callback channel so that notifications from the fileserver get
encrypted.

This will be necessary when more complex notifications are used that convey
changed data around.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/Kconfig       |   1 +
 fs/afs/cm_security.c | 255 +++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h    |  12 ++
 fs/afs/rxrpc.c       |   7 +-
 fs/afs/server.c      |   2 +
 5 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index fc8ba9142f2f..682bd8ec2c10 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -5,6 +5,7 @@ config AFS_FS
 	select AF_RXRPC
 	select DNS_RESOLVER
 	select NETFS_SUPPORT
+	select CRYPTO_KRB5
 	help
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index e8eb63e4d124..68c70fc53333 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -8,11 +8,21 @@
 #include <linux/slab.h>
 #include <crypto/krb5.h>
 #include "internal.h"
+#include "afs_cm.h"
 #include "afs_fs.h"
 #include "protocol_yfs.h"
 #define RXRPC_TRACE_ONLY_DEFINE_ENUMS
 #include <trace/events/rxrpc.h>
 
+#define RXGK_SERVER_ENC_TOKEN 1036U // 0x40c
+#define xdr_round_up(x) (round_up((x), sizeof(__be32)))
+#define xdr_len_object(x) (4 + round_up((x), sizeof(__be32)))
+
+#ifdef CONFIG_RXGK
+static int afs_create_yfs_cm_token(struct sk_buff *challenge,
+				   struct afs_server *server);
+#endif
+
 /*
  * Respond to an RxGK challenge, adding appdata.
  */
@@ -20,6 +30,7 @@ static int afs_respond_to_challenge(struct sk_buff *challenge)
 {
 #ifdef CONFIG_RXGK
 	struct krb5_buffer appdata = {};
+	struct afs_server *server;
 #endif
 	struct rxrpc_peer *peer;
 	unsigned long peer_data;
@@ -55,7 +66,23 @@ static int afs_respond_to_challenge(struct sk_buff *challenge)
 
 #ifdef CONFIG_RXGK
 	case RXRPC_SECURITY_RXGK:
+		return rxgk_kernel_respond_to_challenge(challenge, &appdata);
+
 	case RXRPC_SECURITY_YFS_RXGK:
+		switch (service_id) {
+		case FS_SERVICE:
+		case YFS_FS_SERVICE:
+			server = (struct afs_server *)peer_data;
+			if (!server->cm_rxgk_appdata.data) {
+				mutex_lock(&server->cm_token_lock);
+				if (!server->cm_rxgk_appdata.data)
+					afs_create_yfs_cm_token(challenge, server);
+				mutex_unlock(&server->cm_token_lock);
+			}
+			if (server->cm_rxgk_appdata.data)
+				appdata = server->cm_rxgk_appdata;
+			break;
+		}
 		return rxgk_kernel_respond_to_challenge(challenge, &appdata);
 #endif
 
@@ -83,3 +110,231 @@ void afs_process_oob_queue(struct work_struct *work)
 		rxrpc_kernel_free_oob(oob);
 	}
 }
+
+#ifdef CONFIG_RXGK
+/*
+ * Create a securities keyring for the cache manager and attach a key to it for
+ * the RxGK tokens we want to use to secure the callback connection back from
+ * the fileserver.
+ */
+int afs_create_token_key(struct afs_net *net, struct socket *socket)
+{
+	const struct krb5_enctype *krb5;
+	struct key *ring;
+	key_ref_t key;
+	char K0[32], *desc;
+	int ret;
+
+	ring = keyring_alloc("kafs",
+			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+			     KEY_POS_SEARCH | KEY_POS_WRITE |
+			     KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH,
+			     KEY_ALLOC_NOT_IN_QUOTA,
+			     NULL, NULL);
+	if (IS_ERR(ring))
+		return PTR_ERR(ring);
+
+	ret = rxrpc_sock_set_security_keyring(socket->sk, ring);
+	if (ret < 0)
+		goto out;
+
+	ret = -ENOPKG;
+	krb5 = crypto_krb5_find_enctype(KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96);
+	if (!krb5)
+		goto out;
+
+	if (WARN_ON_ONCE(krb5->key_len > sizeof(K0)))
+		goto out;
+
+	ret = -ENOMEM;
+	desc = kasprintf(GFP_KERNEL, "%u:%u:%u:%u",
+			 YFS_CM_SERVICE, RXRPC_SECURITY_YFS_RXGK, 1, krb5->etype);
+	if (!desc)
+		goto out;
+
+	wait_for_random_bytes();
+	get_random_bytes(K0, krb5->key_len);
+
+	key = key_create(make_key_ref(ring, true),
+			 "rxrpc_s", desc,
+			 K0, krb5->key_len,
+			 KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_USR_VIEW,
+			 KEY_ALLOC_NOT_IN_QUOTA);
+	kfree(desc);
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		goto out;
+	}
+
+	net->fs_cm_token_key = key_ref_to_ptr(key);
+	ret = 0;
+out:
+	key_put(ring);
+	return ret;
+}
+
+/*
+ * Create an YFS RxGK GSS token to use as a ticket to the specified fileserver.
+ */
+static int afs_create_yfs_cm_token(struct sk_buff *challenge,
+				   struct afs_server *server)
+{
+	const struct krb5_enctype *conn_krb5, *token_krb5;
+	const struct krb5_buffer *token_key;
+	struct crypto_aead *aead;
+	struct scatterlist sg;
+	struct afs_net *net = server->cell->net;
+	const struct key *key = net->fs_cm_token_key;
+	size_t keysize, uuidsize, authsize, toksize, encsize, contsize, adatasize, offset;
+	__be32 caps[1] = {
+		[0] = htonl(AFS_CAP_ERROR_TRANSLATION),
+	};
+	__be32 *xdr;
+	void *appdata, *K0, *encbase;
+	u32 enctype;
+	int ret;
+
+	if (!key)
+		return -ENOKEY;
+
+	/* Assume that the fileserver is happy to use the same encoding type as
+	 * we were told to use by the token obtained by the user.
+	 */
+	enctype = rxgk_kernel_query_challenge(challenge);
+
+	conn_krb5 = crypto_krb5_find_enctype(enctype);
+	if (!conn_krb5)
+		return -ENOPKG;
+	token_krb5 = key->payload.data[0];
+	token_key = (const struct krb5_buffer *)&key->payload.data[2];
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
+		pr_err("Appdata size incorrect %zx != %zx\n",
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
+	server->cm_rxgk_appdata.len  = adatasize;
+	server->cm_rxgk_appdata.data = appdata;
+	appdata = NULL;
+
+out_aead:
+	crypto_free_aead(aead);
+out_token:
+	kfree(appdata);
+out:
+	return ret;
+}
+#endif /* CONFIG_RXGK */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 178804817efb..1124ea4000cb 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -20,6 +20,7 @@
 #include <linux/uuid.h>
 #include <linux/mm_types.h>
 #include <linux/dns_resolver.h>
+#include <crypto/krb5.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
@@ -308,6 +309,7 @@ struct afs_net {
 	struct list_head	fs_probe_slow;	/* List of afs_server to probe at 5m intervals */
 	struct hlist_head	fs_proc;	/* procfs servers list */
 
+	struct key		*fs_cm_token_key; /* Key for creating CM tokens */
 	struct work_struct	fs_prober;
 	struct timer_list	fs_probe_timer;
 	atomic_t		servers_outstanding;
@@ -543,6 +545,8 @@ struct afs_server {
 	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
 	struct work_struct	destroyer;	/* Work item to try and destroy a server */
 	struct timer_list	timer;		/* Management timer */
+	struct mutex		cm_token_lock;	/* Lock governing creation of appdata */
+	struct krb5_buffer	cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
@@ -1065,6 +1069,14 @@ extern bool afs_cm_incoming_call(struct afs_call *);
  * cm_security.c
  */
 void afs_process_oob_queue(struct work_struct *work);
+#ifdef CONFIG_RXGK
+int afs_create_token_key(struct afs_net *net, struct socket *socket);
+#else
+static inline int afs_create_token_key(struct afs_net *net, struct socket *socket)
+{
+	return 0;
+}
+#endif
 
 /*
  * dir.c
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 00b3bc087f61..c1cadf8fb346 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -78,6 +78,10 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
+	ret = afs_create_token_key(net, socket);
+	if (ret < 0)
+		pr_err("Couldn't create RxGK CM key: %d\n", ret);
+
 	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
 	if (ret == -EADDRINUSE) {
 		srx.transport.sin6.sin6_port = 0;
@@ -140,6 +144,7 @@ void afs_close_socket(struct afs_net *net)
 	flush_workqueue(afs_async_calls);
 	net->socket->sk->sk_user_data = NULL;
 	sock_release(net->socket);
+	key_put(net->fs_cm_token_key);
 
 	_debug("dework");
 	_leave("");
@@ -820,7 +825,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 	trace_afs_cb_call(call);
 	call->work.func = call->type->work;
 
-	/* pass responsibility for the remainer of this message off to the
+	/* pass responsibility for the remainder of this message off to the
 	 * cache manager op */
 	return call->type->deliver(call);
 }
diff --git a/fs/afs/server.c b/fs/afs/server.c
index c530d1ca15df..72f7aa649544 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -131,6 +131,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell, const uuid_t *
 	timer_setup(&server->timer, afs_server_timer, 0);
 	INIT_LIST_HEAD(&server->volumes);
 	init_waitqueue_head(&server->probe_wq);
+	mutex_init(&server->cm_token_lock);
 	INIT_LIST_HEAD(&server->probe_link);
 	INIT_HLIST_NODE(&server->proc_link);
 	spin_lock_init(&server->probe_lock);
@@ -396,6 +397,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
 	afs_put_cell(server->cell, afs_cell_trace_put_server);
+	kfree(server->cm_rxgk_appdata.data);
 	kfree(server);
 }
 


