Return-Path: <netdev+bounces-304218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmExO75+RmpHXQsAu9opvQ
	(envelope-from <netdev+bounces-304218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8006F933A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RcvPPoMb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304218-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2DCD313F942
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78E414DE6;
	Thu,  2 Jul 2026 14:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2C414DF7
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003800; cv=none; b=j2KfumTl5h7bnuVVrQtLM5oEN62Qm+iykr6M81EW3bhep/2LxxP2mCoJGtaL3If82CGut3ThNbyAJVyoyU7A8ZTYdj4ONsrvOTgFZT5L5QlBykIQ14mmXF3CEXzumh7lb/a1C/dZkx/iAUO/u+lT2c+apiaLtqUCmOQjZpvchdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003800; c=relaxed/simple;
	bh=Z2rfdMC6OtClbHViSfYSzS/sIN+awOTyNss+eFL70oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6WeHA1KtE5vkuONuHEQKSFmYl+l4rXk31MMRTF08lXEP7nP2xy4QaEdt0xL5NTCcy78Z+l+O07eURrs1ouPXoWnP2XnXrNfxCDwQjjtrkkiHzf0xWBXR/7diN+xyniEanuTc81zXGI4sv0XzF+xbj0fkmfP9lwnchwpXLV+qSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcvPPoMb; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783003796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixoDC/cAaTWzYFhi7xThhzZ+DbyBwlASJtUPTgOFKUo=;
	b=RcvPPoMb9HSgropB4gO60L9isMl8IYjh7+6ZnHJ0kXUP19w72/lcZsEkAfxZI+86gK/7WU
	LAx83mV17qUoRWifnoxNqLweP6S9GZlU5jJ5iCsV+WtVQa3xcNe9sMAIrx2/9RNvlt2P7R
	Ah7Y7ryIFWPs6MO+Y2RAl1eIQEB+uzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-xWAbx1fxODiSpqK5zrWEnQ-1; Thu,
 02 Jul 2026 10:49:52 -0400
X-MC-Unique: xWAbx1fxODiSpqK5zrWEnQ-1
X-Mimecast-MFC-AGG-ID: xWAbx1fxODiSpqK5zrWEnQ_1783003787
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910E61833384;
	Thu,  2 Jul 2026 14:49:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 501ED3001D8B;
	Thu,  2 Jul 2026 14:49:43 +0000 (UTC)
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
Subject: [PATCH net 4/4] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Date: Thu,  2 Jul 2026 15:49:18 +0100
Message-ID: <20260702144919.172295-5-dhowells@redhat.com>
In-Reply-To: <20260702144919.172295-1-dhowells@redhat.com>
References: <20260702144919.172295-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304218-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appdata.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E8006F933A

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

With this in mind, make the following changes to the rxrpc server:

 (1) Remove the OOB queuing stuff and retire the related CMSG values and
     sockopt.

 (2) Revert to making the connection event processor work item parse the
     CHALLENGE and generate the RESPONSE directly.

 (3) Add another (optional) parameter that is passed in when an rxrpc
     client call is created and ends up attached to the connection bundle
     and is a user-type key containing the application data.

 (4) RESPONSE generation looks at the bundle and if the app-data is there,
     it will include it (if the security class is YFS-RxGK; RxKAD ignores
     it).

 (5) The AFS filesystem driver will create an app-data key when it probes a
     fileserver and will attach it to the afs_server struct.  This is then
     picked up when a call is made to that server and passed to rxrpc.

 (6) Direct userspace users of AF_RXRPC can partake by creating a user-type
     key containing the app-data they want to use and passing its serial ID
     in a CMSG of type RXRPC_RESPONSE_APPDATA in the initial sendmsg() of a
     call.

To support this, I've made a change outside of afs and rxrc:

 (7) Add a refcount to the user-type key payload.  The problem is that the
     RESPONSE packet generator needs to look at the length of the app-data,
     allocate a buffer for the packet and then copy the app-data in - but
     the RCU read lock cannot be held across the allocation and the key
     might get updated.  To get around this, a ref is taken on the payload
     before the allocation and then put afterwards.

 (8) Since the DNS resolver makes use of the user-defined type's code, but
     allocates the payload itself, make it initialise the refcount.

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
 fs/afs/cm_security.c         | 151 ++++++--------
 fs/afs/fs_probe.c            |   5 +
 fs/afs/internal.h            |  37 ++--
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               |  39 ++--
 fs/afs/server.c              |   2 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  20 +-
 include/trace/events/afs.h   |   1 +
 include/trace/events/rxrpc.h |   2 -
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  22 +-
 net/rxrpc/call_object.c      |   4 +-
 net/rxrpc/conn_client.c      |   2 +
 net/rxrpc/conn_event.c       |  68 +-----
 net/rxrpc/key.c              |  36 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/recvmsg.c          |  84 +-------
 net/rxrpc/rxgk.c             | 128 +++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          |  15 ++
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 26 files changed, 238 insertions(+), 915 deletions(-)
 delete mode 100644 net/rxrpc/oob.c

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index 103168c70dd4..db2a3b30f020 100644
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
@@ -19,97 +21,66 @@
 #define xdr_len_object(x) (4 + round_up((x), sizeof(__be32)))
 
 #ifdef CONFIG_RXGK
-static int afs_create_yfs_cm_token(struct sk_buff *challenge,
-				   struct afs_server *server);
+static int afs_create_yfs_cm_token(struct afs_server *server, u32 krb5_enctype);
 #endif
 
 /*
- * Respond to an RxGK challenge, adding appdata.
+ * Create the application data to go in a RESPONSE packet a server's CHALLENGE
+ * from the parameters contained in a key.  The key specifies the security
+ * index and other appropriate parameters such as the encoding type for RxGK.
  */
-static int afs_respond_to_challenge(struct sk_buff *challenge)
+int afs_create_server_appdata(struct afs_server *server, struct key *key)
 {
-#ifdef CONFIG_RXGK
-	struct krb5_buffer appdata = {};
-	struct afs_server *server;
-#endif
-	struct rxrpc_peer *peer;
-	unsigned long peer_data;
-	u16 service_id;
+	u32 krb5_enctype;
+	int ret;
 	u8 security_index;
 
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
+	if (!key)
+		return 0;
+
+	/* Read APPDATA flag before cm_rxgk_appdata */
+	if (test_bit_acquire(AFS_SERVER_FL_APPDATA, &server->flags))
+		return 0;
+
+	rxrpc_kernel_query_key(key, &security_index, &krb5_enctype);
+
+	_enter("%u,%u", security_index, krb5_enctype);
 
-	switch (security_index) {
+	ret = 0;
+	mutex_lock(&server->cm_token_lock);
+
+	/* Read APPDATA flag before cm_rxgk_appdata */
+	if (!test_bit_acquire(AFS_SERVER_FL_APPDATA, &server->flags)) {
+		switch (security_index) {
+		case 0:
+			break;
 #ifdef CONFIG_RXKAD
-	case RXRPC_SECURITY_RXKAD:
-		return rxkad_kernel_respond_to_challenge(challenge);
+		case RXRPC_SECURITY_RXKAD:
+			set_bit(AFS_SERVER_FL_APPDATA, &server->flags);
+			break;
 #endif
 
 #ifdef CONFIG_RXGK
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
+		case RXRPC_SECURITY_RXGK:
+			set_bit(AFS_SERVER_FL_APPDATA, &server->flags);
 			break;
-		}
-		return rxgk_kernel_respond_to_challenge(challenge, &appdata);
-#endif
 
-	default:
-		return rxrpc_kernel_reject_challenge(challenge, RX_USER_ABORT, -EPROTO,
-						     afs_abort_unsupported_sec_class);
-	}
-}
+		case RXRPC_SECURITY_YFS_RXGK:
+			ret = afs_create_yfs_cm_token(server, krb5_enctype);
+			if (ret < 0)
+				break;
+			set_bit(AFS_SERVER_FL_APPDATA, &server->flags);
+			break;
+#endif
 
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
+		default:
+			WARN_ON_ONCE(1);
 			break;
 		}
-		rxrpc_kernel_free_oob(oob);
 	}
+
+	mutex_unlock(&server->cm_token_lock);
+	return ret;
 }
 
 #ifdef CONFIG_RXGK
@@ -177,37 +148,34 @@ int afs_create_token_key(struct afs_net *net, struct socket *socket)
 /*
  * Create an YFS RxGK GSS token to use as a ticket to the specified fileserver.
  */
-static int afs_create_yfs_cm_token(struct sk_buff *challenge,
-				   struct afs_server *server)
+static int afs_create_yfs_cm_token(struct afs_server *server, u32 enctype)
 {
 	const struct krb5_enctype *conn_krb5, *token_krb5;
 	const struct krb5_buffer *token_key;
 	struct crypto_aead *aead;
 	struct scatterlist sg;
 	struct afs_net *net = server->cell->net;
-	const struct key *key = net->fs_cm_token_key;
+	const struct key *cm_key = net->fs_cm_token_key;
+	struct key *appdata_key = NULL;
 	size_t keysize, uuidsize, authsize, toksize, encsize, contsize, adatasize, offset;
 	__be32 caps[1] = {
 		[0] = htonl(AFS_CAP_ERROR_TRANSLATION),
 	};
 	__be32 *xdr;
 	void *appdata, *K0, *encbase;
-	u32 enctype;
 	int ret;
 
-	if (!key)
+	if (!cm_key)
 		return -ENOKEY;
 
 	/* Assume that the fileserver is happy to use the same encoding type as
 	 * we were told to use by the token obtained by the user.
 	 */
-	enctype = rxgk_kernel_query_challenge(challenge);
-
 	conn_krb5 = crypto_krb5_find_enctype(enctype);
 	if (!conn_krb5)
 		return -ENOPKG;
-	token_krb5 = key->payload.data[0];
-	token_key = (const struct krb5_buffer *)&key->payload.data[2];
+	token_krb5 = cm_key->payload.data[0];
+	token_key = (const struct krb5_buffer *)&cm_key->payload.data[2];
 
 	/* struct rxgk_key {
 	 *	afs_uint32	enctype;
@@ -327,9 +295,22 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
 	if (ret < 0)
 		goto out_aead;
 
-	server->cm_rxgk_appdata.len  = adatasize;
-	server->cm_rxgk_appdata.data = appdata;
-	appdata = NULL;
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
+	server->cm_rxgk_appdata = appdata_key;
 
 out_aead:
 	crypto_free_aead(aead);
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
index 0b72a8566299..3e61c543a50c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -283,7 +283,6 @@ struct afs_net {
 	struct socket		*socket;
 	struct afs_call		*spare_incoming_call;
 	struct work_struct	charge_preallocation_work;
-	struct work_struct	rx_oob_work;
 	struct mutex		socket_mutex;
 	atomic_t		nr_outstanding_calls;
 	atomic_t		nr_superblocks;
@@ -547,7 +546,7 @@ struct afs_server {
 	struct work_struct	destroyer;	/* Work item to try and destroy a server */
 	struct timer_list	timer;		/* Management timer */
 	struct mutex		cm_token_lock;	/* Lock governing creation of appdata */
-	struct krb5_buffer	cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
+	struct key		*cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
@@ -559,6 +558,7 @@ struct afs_server {
 #define AFS_SERVER_FL_NOT_FOUND	6		/* VL server says no such server */
 #define AFS_SERVER_FL_VL_FAIL	7		/* Failed to access VL server */
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
+#define AFS_SERVER_FL_APPDATA	9		/* Set if appdata created */
 #define AFS_SERVER_FL_IS_YFS	16		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.InlineBulkStatus */
 #define AFS_SERVER_FL_NO_RM2	18		/* Fileserver doesn't support YFS.RemoveFile2 */
@@ -1090,7 +1090,7 @@ extern bool afs_cm_incoming_call(struct afs_call *);
 /*
  * cm_security.c
  */
-void afs_process_oob_queue(struct work_struct *work);
+int afs_create_server_appdata(struct afs_server *server, struct key *key);
 #ifdef CONFIG_RXGK
 int afs_create_token_key(struct afs_net *net, struct socket *socket);
 #else
@@ -1417,21 +1417,6 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 		       __builtin_return_address(0));
 }
 
-static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
-				    gfp_t gfp)
-{
-	struct afs_addr_list *alist = op->estate->addresses;
-
-	op->call	= call;
-	op->type	= call->type;
-	call->op	= op;
-	call->key	= op->key;
-	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
-	call->service_id = op->server->service_id;
-	afs_make_call(call, gfp);
-}
-
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
 	call->iov_len = size;
@@ -1763,6 +1748,22 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 	return &vnode->netfs.inode;
 }
 
+static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
+				    gfp_t gfp)
+{
+	struct afs_addr_list *alist = op->estate->addresses;
+
+	op->call	= call;
+	op->type	= call->type;
+	call->op	= op;
+	call->server	= afs_use_server(op->server, false, afs_server_trace_use_call);
+	call->key	= op->key;
+	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
+	call->service_id = op->server->service_id;
+	afs_make_call(call, gfp);
+}
+
 /*
  * Note that a dentry got changed.  We need to set d_fsdata to the data version
  * number derived from the result of the operation.  It doesn't matter if
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
index 05fcb9b6adde..ae48c15b3db9 100644
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
@@ -348,6 +340,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	struct msghdr msg;
 	struct kvec iov[1];
 	unsigned int debug_id = call->debug_id;
+	struct key *app_data = NULL;
 	size_t len;
 	bool write_iter = call->write_iter;
 	s64 tx_total_len;
@@ -380,8 +373,25 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 		call->drop_ref = true;
 	}
 
+	if (call->key && call->server) {
+		u32 krb5_enctype = 0;
+		u8 security_index = 0;
+
+		rxrpc_kernel_query_key(call->key, &security_index, &krb5_enctype);
+		switch (security_index) {
+#ifdef CONFIG_RXGK
+		case RXRPC_SECURITY_YFS_RXGK:
+			app_data = call->server->cm_rxgk_appdata;
+			break;
+#endif
+		default:
+			break;
+		}
+	}
+
 	/* create a call */
-	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
+	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer,
+					 call->key, app_data,
 					 (unsigned long)call,
 					 tx_total_len,
 					 call->max_lifespan,
@@ -987,14 +997,3 @@ noinline int afs_protocol_error(struct afs_call *call,
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
index 0fe162ea2a36..76a9f25ce490 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -398,7 +398,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
 	afs_put_cell(server->cell, afs_cell_trace_put_server);
-	kfree(server->cm_rxgk_appdata.data);
+	key_put(server->cm_rxgk_appdata);
 	kfree(server);
 }
 
diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..7002a993a472 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -26,6 +26,7 @@
  */
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
+	refcount_t	ref;
 	unsigned short	datalen;	/* length of this data */
 	char		data[] __aligned(__alignof__(u64)); /* actual data */
 };
@@ -37,6 +38,7 @@ struct key_preparsed_payload;
 
 extern int user_preparse(struct key_preparsed_payload *prep);
 extern void user_free_preparse(struct key_preparsed_payload *prep);
+void put_user_key_payload(struct user_key_payload *payload);
 extern int user_update(struct key *key, struct key_preparsed_payload *prep);
 extern void user_revoke(struct key *key);
 extern void user_destroy(struct key *key);
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0fb4c41c9bbf..5651a10ba26e 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -55,6 +55,7 @@ void rxrpc_kernel_set_notifications(struct socket *sock,
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
@@ -91,24 +92,7 @@ bool rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
 
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
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index, u32 *_krb5_enctype);
 u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
 				    u16 *_service_id, u32 *_enctype);
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index cf7218efb861..3d96082e6eac 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -148,6 +148,7 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
 	EM(afs_server_trace_update,		"UPDATE   ") \
 	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
+	EM(afs_server_trace_use_call,		"USE call ") \
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
 	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
 	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 704a10de6670..8fc4192e0392 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -262,7 +262,6 @@
 	EM(rxrpc_conn_free,			"FREE        ") \
 	EM(rxrpc_conn_get_activate_call,	"GET act-call") \
 	EM(rxrpc_conn_get_call_input,		"GET inp-call") \
-	EM(rxrpc_conn_get_challenge_input,	"GET inp-chal") \
 	EM(rxrpc_conn_get_conn_input,		"GET inp-conn") \
 	EM(rxrpc_conn_get_idle,			"GET idle    ") \
 	EM(rxrpc_conn_get_poke_abort,		"GET pk-abort") \
@@ -274,7 +273,6 @@
 	EM(rxrpc_conn_new_service,		"NEW service ") \
 	EM(rxrpc_conn_put_call,			"PUT call    ") \
 	EM(rxrpc_conn_put_call_input,		"PUT inp-call") \
-	EM(rxrpc_conn_put_challenge_input,	"PUT inp-chal") \
 	EM(rxrpc_conn_put_conn_input,		"PUT inp-conn") \
 	EM(rxrpc_conn_put_discard_idle,		"PUT disc-idl") \
 	EM(rxrpc_conn_put_local_dead,		"PUT loc-dead") \
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index d9735abd4c79..7d6a50151931 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -58,11 +58,7 @@ enum rxrpc_cmsg_type {
 	RXRPC_TX_LENGTH		= 12,	/* -s-: Total length of Tx data */
 	RXRPC_SET_CALL_TIMEOUT	= 13,	/* -s-: Set one or more call timeouts */
 	RXRPC_CHARGE_ACCEPT	= 14,	/* Ss-: Charge the accept pool with a user call ID */
-	RXRPC_OOB_ID		= 15,	/* -sr: OOB message ID */
-	RXRPC_CHALLENGED	= 16,	/* C-r: Info on a received CHALLENGE */
-	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
-	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
-	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
+	RXRPC_RESPONSE_APPDATA	= 20,	/* Cs-: User key holding app data for RESPONSE */
 	RXRPC__SUPPORTED
 };
 
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..aa3c058f4095 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -208,6 +208,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
 	}
+	refcount_set(&upayload->ref, 1);
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
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
index 9ab0f22c881e..9d5ce1c7ad0d 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -318,6 +318,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
  * @sock: The socket on which to make the call
  * @peer: The peer to contact
  * @key: The security context to use (defaults to socket setting)
+ * @app_data: The security response application data (or NULL)
  * @user_call_ID: The ID to use
  * @tx_total_len: Total length of data to transmit during the call (or -1)
  * @hard_timeout: The maximum lifespan of the call in sec
@@ -340,6 +341,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
@@ -368,6 +370,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 		key = NULL; /* a no-security key */
 
 	memset(&p, 0, sizeof(p));
+	p.app_data		= app_data;
 	p.user_call_ID		= user_call_ID;
 	p.tx_total_len		= tx_total_len;
 	p.interruptibility	= interruptibility;
@@ -595,10 +598,7 @@ static int rxrpc_sendmsg(struct socket *sock, struct msghdr *m, size_t len)
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
index ce946b0a03e2..101ac7544758 100644
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
@@ -516,6 +504,7 @@ struct rxrpc_bundle {
 	struct rxrpc_local	*local;		/* Representation of local endpoint */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	struct list_head	proc_link;	/* Link in net->bundle_proc_list */
 	const struct rxrpc_security *security;	/* applied security module */
 	refcount_t		ref;
@@ -719,6 +708,7 @@ struct rxrpc_call {
 	struct rxrpc_sock __rcu	*socket;	/* socket responsible */
 	struct rxrpc_net	*rxnet;		/* Network namespace to which call belongs */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	const struct rxrpc_security *security;	/* applied security module */
 	struct mutex		user_mutex;	/* User access mutex */
 	struct sockaddr_rxrpc	dest_srx;	/* Destination address */
@@ -913,6 +903,7 @@ enum rxrpc_command {
 };
 
 struct rxrpc_call_params {
+	struct key		*app_data;	/* Security response app data */
 	s64			tx_total_len;	/* Total Tx data length (if send data) */
 	unsigned long		user_call_ID;	/* User's call ID */
 	struct {
@@ -1375,13 +1366,6 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
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
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e..2df3d0190a89 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -198,7 +198,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	ktime_t now;
 	int ret;
 
-	_enter("");
+	_enter("%p", p->app_data);
 
 	call = rxrpc_alloc_call(rx, gfp, debug_id);
 	if (!call)
@@ -211,6 +211,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	call->interruptibility	= p->interruptibility;
 	call->tx_total_len	= p->tx_total_len;
 	call->key		= key_get(cp->key);
+	call->app_data		= key_get(p->app_data);
 	call->peer		= rxrpc_get_peer(cp->peer, rxrpc_peer_get_call);
 	call->local		= rxrpc_get_local(cp->local, rxrpc_local_get_call);
 	call->security_level	= cp->security_level;
@@ -697,6 +698,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
 	key_put(call->key);
+	key_put(call->app_data);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..5cbfa7b223e0 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -81,6 +81,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->local		= call->local;
 		bundle->peer		= rxrpc_get_peer(call->peer, rxrpc_peer_get_bundle);
 		bundle->key		= key_get(call->key);
+		bundle->app_data	= key_get(call->app_data);
 		bundle->security	= call->security;
 		bundle->exclusive	= test_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
@@ -118,6 +119,7 @@ static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 	write_unlock(&bundle->local->rxnet->conn_lock);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
+	key_put(bundle->app_data);
 	kfree(bundle);
 }
 
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
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index a0aa78d89289..2dddbe3cad5c 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -893,3 +893,39 @@ static long rxrpc_read(const struct key *key,
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
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index, u32 *_krb5_enctype)
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
index efcba4b2e74f..2859a80e1876 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -215,61 +215,6 @@ static int rxrpc_recvmsg_user_id(struct rxrpc_call *call, struct msghdr *msg,
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
@@ -281,7 +226,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 			      size_t len, int flags, size_t *_offset)
 {
 	struct rxrpc_skb_priv *sp;
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	struct sk_buff *skb;
 	rxrpc_seq_t seq = 0;
 	size_t remain;
@@ -376,13 +320,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 
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
@@ -419,7 +356,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	trace_rxrpc_recvmsg(0, rxrpc_recvmsg_enter, 0);
 
-	if (flags & (MSG_OOB | MSG_TRUNC))
+	if (flags & MSG_TRUNC)
 		return -EOPNOTSUPP;
 
 	timeo = sock_rcvtimeo(&rx->sk, flags & MSG_DONTWAIT);
@@ -430,14 +367,12 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
@@ -453,8 +388,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (ret)
 			goto wait_error;
 
-		if (list_empty(&rx->recvmsg_q) &&
-		    skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
+		if (list_empty(&rx->recvmsg_q)) {
 			if (signal_pending(current))
 				goto wait_interrupted;
 			trace_rxrpc_recvmsg(0, rxrpc_recvmsg_wait, 0);
@@ -464,15 +398,6 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
@@ -483,8 +408,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
-	    skb_queue_empty(&call->recvmsg_queue) &&
-	    skb_queue_empty(&rx->recvmsg_oobq)) {
+	    skb_queue_empty(&call->recvmsg_queue)) {
 		list_del_init(&call->recvmsg_link);
 		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d24..9ab766d5f0b6 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/key-type.h>
+#include <keys/user-type.h>
 #include "ar-internal.h"
 #include "rxgk_common.h"
 
@@ -734,37 +735,6 @@ static bool rxgk_validate_challenge(struct rxrpc_connection *conn,
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
@@ -837,7 +807,7 @@ static noinline ssize_t rxgk_insert_response_header(struct rxrpc_connection *con
  */
 static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 					    struct sk_buff *challenge,
-					    const struct krb5_buffer *appdata,
+					    const struct user_key_payload *appdata,
 					    struct sk_buff *response,
 					    size_t offset)
 {
@@ -859,20 +829,20 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
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
@@ -890,7 +860,7 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 	ret = skb_store_bits(response, offset, &b, sizeof(b));
 	if (ret < 0)
 		return ret;
-	return sizeof(a) + xdr_round_up(appdata->len) + sizeof(b);
+	return sizeof(a) + xdr_round_up(appdata->datalen) + sizeof(b);
 }
 
 static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
@@ -923,7 +893,7 @@ static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
  */
 static int rxgk_construct_response(struct rxrpc_connection *conn,
 				   struct sk_buff *challenge,
-				   struct krb5_buffer *appdata)
+				   const struct user_key_payload *appdata)
 {
 	struct rxrpc_skb_priv *csp, *rsp;
 	struct rxgk_context *gk;
@@ -936,7 +906,7 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
 
-	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
+	auth_len = 20 + (4 + appdata->datalen) + 12 + (1 + 4) * 4;
 	authx_len = crypto_krb5_how_much_buffer(gk->krb5, KRB5_ENCRYPT_MODE,
 						auth_len, &auth_offset);
 	len = sizeof(struct rxrpc_wire_header) +
@@ -1011,66 +981,36 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
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
-
-static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
-						struct sk_buff *challenge)
-{
-	struct krb5_buffer appdata = {};
-
-	return rxgk_respond_to_challenge(conn, challenge, &appdata);
-}
-
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
-	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
-
-	return rxgk_respond_to_challenge(csp->chall.conn, challenge, appdata);
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
+	if (conn->bundle->app_data) {
+		rcu_read_lock();
+		appdata = (struct user_key_payload *)
+			user_key_payload_rcu(conn->bundle->app_data);
+		if (!refcount_inc_not_zero(&appdata->ref))
+			appdata = NULL;
+		rcu_read_unlock();
+		if (!appdata)
+			return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EKEYREVOKED,
+						rxgk_abort_chall_key_expired);
 	}
 
-	return rxgk_kernel_respond_to_challenge(challenge, &appdata);
+	ret = rxgk_construct_response(conn, challenge, appdata);
+
+	if (appdata != &dummy)
+		put_user_key_payload(appdata);
+	return ret;
 }
 
 /*
@@ -1346,9 +1286,7 @@ const struct rxrpc_security rxgk_yfs = {
 	.free_call_crypto		= rxgk_free_call_crypto,
 	.issue_challenge		= rxgk_issue_challenge,
 	.validate_challenge		= rxgk_validate_challenge,
-	.challenge_to_recvmsg		= rxgk_challenge_to_recvmsg,
-	.sendmsg_respond_to_challenge	= rxgk_sendmsg_respond_to_challenge,
-	.respond_to_challenge		= rxgk_respond_to_challenge_no_appdata,
+	.respond_to_challenge		= rxgk_respond_to_challenge,
 	.verify_response		= rxgk_verify_response,
 	.clear				= rxgk_clear,
 	.default_decode_ticket		= rxgk_yfs_decode_ticket,
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
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 4c754f78ece9..225eec410bed 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -506,6 +506,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 {
 	struct cmsghdr *cmsg;
+	key_serial_t key_id;
+	key_ref_t key;
 	bool got_user_ID = false;
 	int len;
 
@@ -590,6 +592,18 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 				return -ERANGE;
 			break;
 
+		case RXRPC_RESPONSE_APPDATA:
+			if (len != sizeof(key_serial_t))
+				return -EINVAL;
+			if (p->call.app_data)
+				return -EINVAL;
+			key_id = *(key_serial_t *)CMSG_DATA(cmsg);
+			key = lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			p->call.app_data = key_ref_to_ptr(key);
+			break;
+
 		default:
 			return -EINVAL;
 		}
@@ -789,6 +803,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 
 error_release_sock:
 	release_sock(&rx->sk);
+	key_put(p.call.app_data);
 	return ret;
 }
 
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
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f927..90c1bd5d7dfe 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -67,6 +67,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	upayload = kmalloc_flex(*upayload, data, datalen);
 	if (!upayload)
 		return -ENOMEM;
+	refcount_set(&upayload->ref, 1);
 
 	/* attach the data */
 	prep->quotalen = datalen;
@@ -88,12 +89,22 @@ EXPORT_SYMBOL_GPL(user_free_preparse);
 
 static void user_free_payload_rcu(struct rcu_head *head)
 {
-	struct user_key_payload *payload;
+	struct user_key_payload *payload =
+		container_of(head, struct user_key_payload, rcu);
 
-	payload = container_of(head, struct user_key_payload, rcu);
 	kfree_sensitive(payload);
 }
 
+/*
+ * Free a user defined key payload.
+ */
+void put_user_key_payload(struct user_key_payload *payload)
+{
+	if (payload && refcount_dec_and_test(&payload->ref))
+		call_rcu(&payload->rcu, user_free_payload_rcu);
+}
+EXPORT_SYMBOL_GPL(put_user_key_payload);
+
 /*
  * update a user defined key
  * - the key's semaphore is write-locked
@@ -115,8 +126,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, prep->payload.data[0]);
 	prep->payload.data[0] = NULL;
 
-	if (zap)
-		call_rcu(&zap->rcu, user_free_payload_rcu);
+	put_user_key_payload(zap);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(user_update);
@@ -134,7 +144,7 @@ void user_revoke(struct key *key)
 
 	if (upayload) {
 		rcu_assign_keypointer(key, NULL);
-		call_rcu(&upayload->rcu, user_free_payload_rcu);
+		put_user_key_payload(upayload);
 	}
 }
 
@@ -147,9 +157,8 @@ void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data[0];
 
-	kfree_sensitive(upayload);
+	put_user_key_payload(upayload);
 }
-
 EXPORT_SYMBOL_GPL(user_destroy);
 
 /*


