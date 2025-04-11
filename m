Return-Path: <netdev+bounces-181566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B246CA85877
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A54E1BC1C2C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326929B22C;
	Fri, 11 Apr 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpqIlG6A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8E29B204
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365234; cv=none; b=tw6r6UP0g9PRrWwwVnjtCOLwtsn1RZzG2hHg6pODh7MF9pbB8+QMsAnlkPSmdVZQOvzwxb9Po+1ZQHVOOu3rTnlDpCOfEYUIjeOV+lfsnLsc65r4icsoRWewNVDD/07vOy6X77NTawuKSRLENbCbgGLQ8YnloJsoYDU0w8Lyh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365234; c=relaxed/simple;
	bh=5lA9NiZ8Lq/pEIh1ueDy1EupoFjGim8wWrWAsF9DIas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmT+QoYADC7v/4h1TPnuGl3cj58aFfH5ftXTEdfaToLAr/0hKjapiehFiwnFVbptI0FnWs3YVPN0ZdW+sx9ond2u01j906PwR4fPvOLFHyMu2kRyPNtG6SK+3H3nhY+xs09f5XaXcyhBXZ23wkmmojKSmmTAtWgkYdUegwCGjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpqIlG6A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYxQ4k6mvghi3fdzoTuanwgygcaCPIWovbiEhS+87Io=;
	b=cpqIlG6AqphdQ2xfn3s/Pnbp1fVkg6jG1OQfO9oAnXRcSN0JWJ/EkgfGqSj6g010r5Gs5/
	5+JCQ9zi0vHOHDZPpqRkCKE/yXAx32wQecyX8ZJ4nKQTh+0rVCsCDbQe25WidNHHyjxv6M
	60TvkeY8JMiibO8GAITq++rKNFaYJ0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-ZuoAQfmGOnqdVvInshqfyw-1; Fri,
 11 Apr 2025 05:53:44 -0400
X-MC-Unique: ZuoAQfmGOnqdVvInshqfyw-1
X-Mimecast-MFC-AGG-ID: ZuoAQfmGOnqdVvInshqfyw_1744365222
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E175D186096C;
	Fri, 11 Apr 2025 09:53:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2035319560AD;
	Fri, 11 Apr 2025 09:53:25 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 04/14] rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE
Date: Fri, 11 Apr 2025 10:52:49 +0100
Message-ID: <20250411095303.2316168-5-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Allow the app to request that CHALLENGEs be passed to it through an
out-of-band queue that allows recvmsg() to pick it up so that the app can
add data to it with sendmsg().

This will allow the application (AFS or userspace) to interact with the
process if it wants to and put values into user-defined fields.  This will
be used by AFS when talking to a fileserver to supply that fileserver with
a crypto key by which callback RPCs can be encrypted (ie. notifications
from the fileserver to the client).

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
 Documentation/networking/rxrpc.rst |   2 +
 fs/afs/Makefile                    |   1 +
 fs/afs/cm_security.c               |  73 ++++++
 fs/afs/internal.h                  |   6 +
 fs/afs/main.c                      |   1 +
 fs/afs/rxrpc.c                     |  18 ++
 include/net/af_rxrpc.h             |  24 ++
 include/trace/events/rxrpc.h       |  18 +-
 include/uapi/linux/rxrpc.h         |  46 +++-
 net/rxrpc/Makefile                 |   1 +
 net/rxrpc/af_rxrpc.c               |  52 +++-
 net/rxrpc/ar-internal.h            |  51 +++-
 net/rxrpc/call_object.c            |   2 +-
 net/rxrpc/conn_event.c             | 134 +++++++++-
 net/rxrpc/conn_object.c            |   1 +
 net/rxrpc/insecure.c               |  13 +-
 net/rxrpc/io_thread.c              |  12 +-
 net/rxrpc/oob.c                    | 379 +++++++++++++++++++++++++++++
 net/rxrpc/output.c                 |  56 +++++
 net/rxrpc/recvmsg.c                | 120 +++++++--
 net/rxrpc/rxkad.c                  | 288 ++++++++++++++--------
 net/rxrpc/sendmsg.c                |  15 +-
 net/rxrpc/server_key.c             |  40 +++
 23 files changed, 1188 insertions(+), 165 deletions(-)
 create mode 100644 fs/afs/cm_security.c
 create mode 100644 net/rxrpc/oob.c

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 2680abd1cb26..eb941b2577dd 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -1179,7 +1179,9 @@ API Function Reference
 
 .. kernel-doc:: net/rxrpc/af_rxrpc.c
 .. kernel-doc:: net/rxrpc/key.c
+.. kernel-doc:: net/rxrpc/oob.c
 .. kernel-doc:: net/rxrpc/peer_object.c
 .. kernel-doc:: net/rxrpc/recvmsg.c
+.. kernel-doc:: net/rxrpc/rxkad.c
 .. kernel-doc:: net/rxrpc/sendmsg.c
 .. kernel-doc:: net/rxrpc/server_key.c
diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 5efd7e13b304..b49b8fe682f3 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -8,6 +8,7 @@ kafs-y := \
 	addr_prefs.o \
 	callback.o \
 	cell.o \
+	cm_security.o \
 	cmservice.o \
 	dir.o \
 	dir_edit.o \
diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
new file mode 100644
index 000000000000..efe6a23c8477
--- /dev/null
+++ b/fs/afs/cm_security.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache manager security.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include "internal.h"
+#include "afs_fs.h"
+#include "protocol_yfs.h"
+#define RXRPC_TRACE_ONLY_DEFINE_ENUMS
+#include <trace/events/rxrpc.h>
+
+/*
+ * Respond to an RxGK challenge, adding appdata.
+ */
+static int afs_respond_to_challenge(struct sk_buff *challenge)
+{
+	struct rxrpc_peer *peer;
+	unsigned long peer_data;
+	u16 service_id;
+	u8 security_index;
+
+	rxrpc_kernel_query_challenge(challenge, &peer, &peer_data,
+				     &service_id, &security_index);
+
+	_enter("%u,%u", service_id, security_index);
+
+	switch (service_id) {
+		/* We don't send CM_SERVICE RPCs, so don't expect a challenge
+		 * therefrom.
+		 */
+	case FS_SERVICE:
+	case VL_SERVICE:
+	case YFS_FS_SERVICE:
+	case YFS_VL_SERVICE:
+		break;
+	default:
+		pr_warn("Can't respond to unknown challenge %u:%u",
+			service_id, security_index);
+		return rxrpc_kernel_reject_challenge(challenge, RX_USER_ABORT, -EPROTO,
+						     afs_abort_unsupported_sec_class);
+	}
+
+	switch (security_index) {
+	case RXRPC_SECURITY_RXKAD:
+		return rxkad_kernel_respond_to_challenge(challenge);
+
+	default:
+		return rxrpc_kernel_reject_challenge(challenge, RX_USER_ABORT, -EPROTO,
+						     afs_abort_unsupported_sec_class);
+	}
+}
+
+/*
+ * Process the OOB message queue, processing challenge packets.
+ */
+void afs_process_oob_queue(struct work_struct *work)
+{
+	struct afs_net *net = container_of(work, struct afs_net, rx_oob_work);
+	struct sk_buff *oob;
+	enum rxrpc_oob_type type;
+
+	while ((oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
+		switch (type) {
+		case RXRPC_OOB_CHALLENGE:
+			afs_respond_to_challenge(oob);
+			break;
+		}
+		rxrpc_kernel_free_oob(oob);
+	}
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 440b0e731093..b3612b700c6a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -281,6 +281,7 @@ struct afs_net {
 	struct socket		*socket;
 	struct afs_call		*spare_incoming_call;
 	struct work_struct	charge_preallocation_work;
+	struct work_struct	rx_oob_work;
 	struct mutex		socket_mutex;
 	atomic_t		nr_outstanding_calls;
 	atomic_t		nr_superblocks;
@@ -1058,6 +1059,11 @@ extern void __net_exit afs_cell_purge(struct afs_net *);
  */
 extern bool afs_cm_incoming_call(struct afs_call *);
 
+/*
+ * cm_security.c
+ */
+void afs_process_oob_queue(struct work_struct *work);
+
 /*
  * dir.c
  */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index c845c5daaeba..02475d415d88 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -73,6 +73,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	generate_random_uuid((unsigned char *)&net->uuid);
 
 	INIT_WORK(&net->charge_preallocation_work, afs_charge_preallocation);
+	INIT_WORK(&net->rx_oob_work, afs_process_oob_queue);
 	mutex_init(&net->socket_mutex);
 
 	net->cells = RB_ROOT;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a4734304e542..212af2aa85bf 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -25,12 +25,14 @@ static void afs_process_async_call(struct work_struct *);
 static void afs_rx_new_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_rx_discard_new_call(struct rxrpc_call *, unsigned long);
 static void afs_rx_attach(struct rxrpc_call *rxcall, unsigned long user_call_ID);
+static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob);
 static int afs_deliver_cm_op_id(struct afs_call *);
 
 static const struct rxrpc_kernel_ops afs_rxrpc_callback_ops = {
 	.notify_new_call	= afs_rx_new_call,
 	.discard_new_call	= afs_rx_discard_new_call,
 	.user_attach_call	= afs_rx_attach,
+	.notify_oob		= afs_rx_notify_oob,
 };
 
 /* asynchronous incoming call initial processing */
@@ -56,6 +58,7 @@ int afs_open_socket(struct afs_net *net)
 		goto error_1;
 
 	socket->sk->sk_allocation = GFP_NOFS;
+	socket->sk->sk_user_data = net;
 
 	/* bind the callback manager's address to make this a server socket */
 	memset(&srx, 0, sizeof(srx));
@@ -71,6 +74,10 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		goto error_2;
 
+	ret = rxrpc_sock_set_manage_response(socket->sk, true);
+	if (ret < 0)
+		goto error_2;
+
 	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
 	if (ret == -EADDRINUSE) {
 		srx.transport.sin6.sin6_port = 0;
@@ -131,6 +138,7 @@ void afs_close_socket(struct afs_net *net)
 
 	kernel_sock_shutdown(net->socket, SHUT_RDWR);
 	flush_workqueue(afs_async_calls);
+	net->socket->sk->sk_user_data = NULL;
 	sock_release(net->socket);
 
 	_debug("dework");
@@ -957,3 +965,13 @@ noinline int afs_protocol_error(struct afs_call *call,
 		call->unmarshalling_error = true;
 	return -EBADMSG;
 }
+
+/*
+ * Wake up OOB notification processing.
+ */
+static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
+{
+	struct afs_net *net = sk->sk_user_data;
+
+	schedule_work(&net->rx_oob_work);
+}
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index ebb6092c488b..0b209f703ffc 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -16,6 +16,7 @@ struct sock;
 struct socket;
 struct rxrpc_call;
 struct rxrpc_peer;
+struct krb5_buffer;
 enum rxrpc_abort_reason;
 
 enum rxrpc_interruptibility {
@@ -24,6 +25,10 @@ enum rxrpc_interruptibility {
 	RXRPC_UNINTERRUPTIBLE,	/* Call should not be interruptible at all */
 };
 
+enum rxrpc_oob_type {
+	RXRPC_OOB_CHALLENGE,	/* Security challenge for a connection */
+};
+
 /*
  * Debug ID counter for tracing.
  */
@@ -37,6 +42,7 @@ struct rxrpc_kernel_ops {
 				unsigned long user_call_ID);
 	void (*discard_new_call)(struct rxrpc_call *call, unsigned long user_call_ID);
 	void (*user_attach_call)(struct rxrpc_call *call, unsigned long user_call_ID);
+	void (*notify_oob)(struct sock *sk, struct sk_buff *oob);
 };
 
 typedef void (*rxrpc_notify_rx_t)(struct sock *, struct rxrpc_call *,
@@ -88,5 +94,23 @@ void rxrpc_kernel_set_max_life(struct socket *, struct rxrpc_call *,
 
 int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
 int rxrpc_sock_set_security_keyring(struct sock *, struct key *);
+int rxrpc_sock_set_manage_response(struct sock *sk, bool set);
+
+enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
+					   struct rxrpc_peer **_peer,
+					   unsigned long *_peer_appdata);
+struct sk_buff *rxrpc_kernel_dequeue_oob(struct socket *sock,
+					 enum rxrpc_oob_type *_type);
+void rxrpc_kernel_free_oob(struct sk_buff *oob);
+void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
+				  struct rxrpc_peer **_peer,
+				  unsigned long *_peer_appdata,
+				  u16 *_service_id, u8 *_security_index);
+int rxrpc_kernel_reject_challenge(struct sk_buff *challenge, u32 abort_code,
+				  int error, enum rxrpc_abort_reason why);
+int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge);
+u32 rxgk_kernel_query_challenge(struct sk_buff *challenge);
+int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
+				     struct krb5_buffer *appdata);
 
 #endif /* _NET_RXRPC_H */
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index cad50d91077e..08ecebd90595 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -25,6 +25,7 @@
 	EM(afs_abort_probeuuid_negative,	"afs-probeuuid-neg")	\
 	EM(afs_abort_send_data_error,		"afs-send-data")	\
 	EM(afs_abort_unmarshal_error,		"afs-unmarshal")	\
+	EM(afs_abort_unsupported_sec_class,	"afs-unsup-sec-class")	\
 	/* rxperf errors */						\
 	EM(rxperf_abort_general_error,		"rxperf-error")		\
 	EM(rxperf_abort_oom,			"rxperf-oom")		\
@@ -77,6 +78,7 @@
 	EM(rxrpc_abort_call_timeout,		"call-timeout")		\
 	EM(rxrpc_abort_no_service_key,		"no-serv-key")		\
 	EM(rxrpc_abort_nomem,			"nomem")		\
+	EM(rxrpc_abort_response_sendmsg,	"resp-sendmsg")		\
 	EM(rxrpc_abort_service_not_offered,	"serv-not-offered")	\
 	EM(rxrpc_abort_shut_down,		"shut-down")		\
 	EM(rxrpc_abort_unsupported_security,	"unsup-sec")		\
@@ -133,24 +135,33 @@
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
 	EM(rxrpc_skb_get_local_work,		"GET locl-work") \
+	EM(rxrpc_skb_get_post_oob,		"GET post-oob ") \
 	EM(rxrpc_skb_get_reject_work,		"GET rej-work ") \
 	EM(rxrpc_skb_get_to_recvmsg,		"GET to-recv  ") \
 	EM(rxrpc_skb_get_to_recvmsg_oos,	"GET to-recv-o") \
 	EM(rxrpc_skb_new_encap_rcv,		"NEW encap-rcv") \
 	EM(rxrpc_skb_new_error_report,		"NEW error-rpt") \
 	EM(rxrpc_skb_new_jumbo_subpacket,	"NEW jumbo-sub") \
+	EM(rxrpc_skb_new_response_rxgk,		"NEW resp-rxgk") \
+	EM(rxrpc_skb_new_response_rxkad,	"NEW resp-rxkd") \
 	EM(rxrpc_skb_new_unshared,		"NEW unshared ") \
 	EM(rxrpc_skb_put_call_rx,		"PUT call-rx  ") \
+	EM(rxrpc_skb_put_challenge,		"PUT challenge") \
 	EM(rxrpc_skb_put_conn_secured,		"PUT conn-secd") \
 	EM(rxrpc_skb_put_conn_work,		"PUT conn-work") \
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
+	EM(rxrpc_skb_put_oob,			"PUT oob      ") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_purge_oob,		"PUT purge-oob") \
+	EM(rxrpc_skb_put_response,		"PUT response ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
+	EM(rxrpc_skb_see_oob_challenge,		"SEE oob-chall") \
 	EM(rxrpc_skb_see_recvmsg,		"SEE recvmsg  ") \
+	EM(rxrpc_skb_see_recvmsg_oob,		"SEE recvm-oob") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
@@ -216,9 +227,11 @@
 	EM(rxrpc_conn_free,			"FREE        ") \
 	EM(rxrpc_conn_get_activate_call,	"GET act-call") \
 	EM(rxrpc_conn_get_call_input,		"GET inp-call") \
+	EM(rxrpc_conn_get_challenge_input,	"GET inp-chal") \
 	EM(rxrpc_conn_get_conn_input,		"GET inp-conn") \
 	EM(rxrpc_conn_get_idle,			"GET idle    ") \
 	EM(rxrpc_conn_get_poke_abort,		"GET pk-abort") \
+	EM(rxrpc_conn_get_poke_response,	"GET response") \
 	EM(rxrpc_conn_get_poke_secured,		"GET secured ") \
 	EM(rxrpc_conn_get_poke_timer,		"GET poke    ") \
 	EM(rxrpc_conn_get_service_conn,		"GET svc-conn") \
@@ -226,10 +239,12 @@
 	EM(rxrpc_conn_new_service,		"NEW service ") \
 	EM(rxrpc_conn_put_call,			"PUT call    ") \
 	EM(rxrpc_conn_put_call_input,		"PUT inp-call") \
+	EM(rxrpc_conn_put_challenge_input,	"PUT inp-chal") \
 	EM(rxrpc_conn_put_conn_input,		"PUT inp-conn") \
 	EM(rxrpc_conn_put_discard_idle,		"PUT disc-idl") \
 	EM(rxrpc_conn_put_local_dead,		"PUT loc-dead") \
 	EM(rxrpc_conn_put_noreuse,		"PUT noreuse ") \
+	EM(rxrpc_conn_put_oob,			"PUT oob     ") \
 	EM(rxrpc_conn_put_poke,			"PUT poke    ") \
 	EM(rxrpc_conn_put_service_reaped,	"PUT svc-reap") \
 	EM(rxrpc_conn_put_unbundle,		"PUT unbundle") \
@@ -331,6 +346,7 @@
 	EM(rxrpc_recvmsg_full,			"FULL") \
 	EM(rxrpc_recvmsg_hole,			"HOLE") \
 	EM(rxrpc_recvmsg_next,			"NEXT") \
+	EM(rxrpc_recvmsg_oobq,			"OOBQ") \
 	EM(rxrpc_recvmsg_requeue,		"REQU") \
 	EM(rxrpc_recvmsg_return,		"RETN") \
 	EM(rxrpc_recvmsg_terminal,		"TERM") \
@@ -456,7 +472,7 @@
 	EM(rxrpc_tx_point_conn_abort,		"ConnAbort") \
 	EM(rxrpc_tx_point_reject,		"Reject") \
 	EM(rxrpc_tx_point_rxkad_challenge,	"RxkadChall") \
-	EM(rxrpc_tx_point_rxkad_response,	"RxkadResp") \
+	EM(rxrpc_tx_point_response,		"Response") \
 	EM(rxrpc_tx_point_version_keepalive,	"VerKeepalive") \
 	E_(rxrpc_tx_point_version_reply,	"VerReply")
 
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index 8f8dc7a937a4..c4e9833b0a12 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -36,26 +36,33 @@ struct sockaddr_rxrpc {
 #define RXRPC_MIN_SECURITY_LEVEL	4	/* minimum security level */
 #define RXRPC_UPGRADEABLE_SERVICE	5	/* Upgrade service[0] -> service[1] */
 #define RXRPC_SUPPORTED_CMSG		6	/* Get highest supported control message type */
+#define RXRPC_MANAGE_RESPONSE		7	/* [clnt] Want to manage RESPONSE packets */
 
 /*
  * RxRPC control messages
  * - If neither abort or accept are specified, the message is a data message.
  * - terminal messages mean that a user call ID tag can be recycled
+ * - C/S/- indicate whether these are applicable to client, server or both
  * - s/r/- indicate whether these are applicable to sendmsg() and/or recvmsg()
  */
 enum rxrpc_cmsg_type {
-	RXRPC_USER_CALL_ID	= 1,	/* sr: user call ID specifier */
-	RXRPC_ABORT		= 2,	/* sr: abort request / notification [terminal] */
-	RXRPC_ACK		= 3,	/* -r: [Service] RPC op final ACK received [terminal] */
-	RXRPC_NET_ERROR		= 5,	/* -r: network error received [terminal] */
-	RXRPC_BUSY		= 6,	/* -r: server busy received [terminal] */
-	RXRPC_LOCAL_ERROR	= 7,	/* -r: local error generated [terminal] */
-	RXRPC_NEW_CALL		= 8,	/* -r: [Service] new incoming call notification */
-	RXRPC_EXCLUSIVE_CALL	= 10,	/* s-: Call should be on exclusive connection */
-	RXRPC_UPGRADE_SERVICE	= 11,	/* s-: Request service upgrade for client call */
-	RXRPC_TX_LENGTH		= 12,	/* s-: Total length of Tx data */
-	RXRPC_SET_CALL_TIMEOUT	= 13,	/* s-: Set one or more call timeouts */
-	RXRPC_CHARGE_ACCEPT	= 14,	/* s-: Charge the accept pool with a user call ID */
+	RXRPC_USER_CALL_ID	= 1,	/* -sr: User call ID specifier */
+	RXRPC_ABORT		= 2,	/* -sr: Abort request / notification [terminal] */
+	RXRPC_ACK		= 3,	/* S-r: RPC op final ACK received [terminal] */
+	RXRPC_NET_ERROR		= 5,	/* --r: Network error received [terminal] */
+	RXRPC_BUSY		= 6,	/* C-r: Server busy received [terminal] */
+	RXRPC_LOCAL_ERROR	= 7,	/* --r: Local error generated [terminal] */
+	RXRPC_NEW_CALL		= 8,	/* S-r: New incoming call notification */
+	RXRPC_EXCLUSIVE_CALL	= 10,	/* Cs-: Call should be on exclusive connection */
+	RXRPC_UPGRADE_SERVICE	= 11,	/* Cs-: Request service upgrade for client call */
+	RXRPC_TX_LENGTH		= 12,	/* -s-: Total length of Tx data */
+	RXRPC_SET_CALL_TIMEOUT	= 13,	/* -s-: Set one or more call timeouts */
+	RXRPC_CHARGE_ACCEPT	= 14,	/* Ss-: Charge the accept pool with a user call ID */
+	RXRPC_OOB_ID		= 15,	/* -sr: OOB message ID */
+	RXRPC_CHALLENGED	= 16,	/* C-r: Info on a received CHALLENGE */
+	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
+	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
+	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
 	RXRPC__SUPPORTED
 };
 
@@ -118,4 +125,19 @@ enum rxrpc_cmsg_type {
 #define RXKADDATALEN		19270411	/* user data too long */
 #define RXKADILLEGALLEVEL	19270412	/* caller not authorised to use encrypted conns */
 
+/*
+ * Challenge information in the RXRPC_CHALLENGED control message.
+ */
+struct rxrpc_challenge {
+	__u16		service_id;	/* The service ID of the connection (may be upgraded) */
+	__u8		security_index;	/* The security index of the connection */
+	__u8		pad;		/* Round out to a multiple of 4 bytes. */
+	/* ... The security class gets to append extra information ... */
+};
+
+struct rxgk_challenge {
+	struct rxrpc_challenge	base;
+	__u32			enctype;	/* Krb5 encoding type */
+};
+
 #endif /* _UAPI_LINUX_RXRPC_H */
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index 210b75e3179e..0981941dea73 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -24,6 +24,7 @@ rxrpc-y := \
 	local_object.o \
 	misc.o \
 	net_ns.o \
+	oob.o \
 	output.o \
 	peer_event.o \
 	peer_object.o \
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 2e4f6c9ef3de..3a558c1a541e 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -633,7 +633,10 @@ static int rxrpc_sendmsg(struct socket *sock, struct msghdr *m, size_t len)
 		fallthrough;
 	case RXRPC_SERVER_BOUND:
 	case RXRPC_SERVER_LISTENING:
-		ret = rxrpc_do_sendmsg(rx, m, len);
+		if (m->msg_flags & MSG_OOB)
+			ret = rxrpc_sendmsg_oob(rx, m, len);
+		else
+			ret = rxrpc_do_sendmsg(rx, m, len);
 		/* The socket has been unlocked */
 		goto out;
 	default:
@@ -668,7 +671,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	unsigned int min_sec_level;
+	unsigned int min_sec_level, val;
 	u16 service_upgrade[2];
 	int ret;
 
@@ -749,6 +752,26 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			rx->service_upgrade.to = service_upgrade[1];
 			goto success;
 
+		case RXRPC_MANAGE_RESPONSE:
+			ret = -EINVAL;
+			if (optlen != sizeof(unsigned int))
+				goto error;
+			ret = -EISCONN;
+			if (rx->sk.sk_state != RXRPC_UNBOUND)
+				goto error;
+			ret = copy_safe_from_sockptr(&val, sizeof(val),
+						     optval, optlen);
+			if (ret)
+				goto error;
+			ret = -EINVAL;
+			if (val > 1)
+				goto error;
+			if (val)
+				set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+			else
+				clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+			goto success;
+
 		default:
 			break;
 		}
@@ -855,6 +878,8 @@ static int rxrpc_create(struct net *net, struct socket *sock, int protocol,
 	rx->calls = RB_ROOT;
 
 	spin_lock_init(&rx->incoming_lock);
+	skb_queue_head_init(&rx->recvmsg_oobq);
+	rx->pending_oobq = RB_ROOT;
 	INIT_LIST_HEAD(&rx->sock_calls);
 	INIT_LIST_HEAD(&rx->to_be_accepted);
 	INIT_LIST_HEAD(&rx->recvmsg_q);
@@ -888,8 +913,10 @@ static int rxrpc_shutdown(struct socket *sock, int flags)
 	lock_sock(sk);
 
 	if (sk->sk_state < RXRPC_CLOSE) {
+		spin_lock_irq(&rx->recvmsg_lock);
 		sk->sk_state = RXRPC_CLOSE;
 		sk->sk_shutdown = SHUTDOWN_MASK;
+		spin_unlock_irq(&rx->recvmsg_lock);
 	} else {
 		ret = -ESHUTDOWN;
 	}
@@ -900,6 +927,23 @@ static int rxrpc_shutdown(struct socket *sock, int flags)
 	return ret;
 }
 
+/*
+ * Purge the out-of-band queue.
+ */
+static void rxrpc_purge_oob_queue(struct sock *sk)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sk);
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&rx->recvmsg_oobq)))
+		rxrpc_kernel_free_oob(skb);
+	while (!RB_EMPTY_ROOT(&rx->pending_oobq)) {
+		skb = rb_entry(rx->pending_oobq.rb_node, struct sk_buff, rbnode);
+		rb_erase(&skb->rbnode, &rx->pending_oobq);
+		rxrpc_kernel_free_oob(skb);
+	}
+}
+
 /*
  * RxRPC socket destructor
  */
@@ -907,6 +951,7 @@ static void rxrpc_sock_destructor(struct sock *sk)
 {
 	_enter("%p", sk);
 
+	rxrpc_purge_oob_queue(sk);
 	rxrpc_purge_queue(&sk->sk_receive_queue);
 
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
@@ -945,7 +990,9 @@ static int rxrpc_release_sock(struct sock *sk)
 		break;
 	}
 
+	spin_lock_irq(&rx->recvmsg_lock);
 	sk->sk_state = RXRPC_CLOSE;
+	spin_unlock_irq(&rx->recvmsg_lock);
 
 	if (rx->local && rx->local->service == rx) {
 		write_lock(&rx->local->services_lock);
@@ -957,6 +1004,7 @@ static int rxrpc_release_sock(struct sock *sk)
 	rxrpc_discard_prealloc(rx);
 	rxrpc_release_calls_on_socket(rx);
 	flush_workqueue(rxrpc_workqueue);
+	rxrpc_purge_oob_queue(sk);
 	rxrpc_purge_queue(&sk->sk_receive_queue);
 
 	rxrpc_unuse_local(rx->local, rxrpc_local_unuse_release_sock);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c267b8ac1bb5..31d05784c530 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -39,6 +39,7 @@ struct rxrpc_txqueue;
 enum rxrpc_skb_mark {
 	RXRPC_SKB_MARK_PACKET,		/* Received packet */
 	RXRPC_SKB_MARK_ERROR,		/* Error notification */
+	RXRPC_SKB_MARK_CHALLENGE,	/* Challenge notification */
 	RXRPC_SKB_MARK_SERVICE_CONN_SECURED, /* Service connection response has been verified */
 	RXRPC_SKB_MARK_REJECT_BUSY,	/* Reject with BUSY */
 	RXRPC_SKB_MARK_REJECT_ABORT,	/* Reject with ABORT (code in skb->priority) */
@@ -149,6 +150,9 @@ struct rxrpc_sock {
 	const struct rxrpc_kernel_ops *app_ops;	/* Table of kernel app notification funcs */
 	struct rxrpc_local	*local;		/* local endpoint */
 	struct rxrpc_backlog	*backlog;	/* Preallocation for services */
+	struct sk_buff_head	recvmsg_oobq;	/* OOB messages for recvmsg to pick up */
+	struct rb_root		pending_oobq;	/* OOB messages awaiting userspace to respond to */
+	u64			oob_id_counter;	/* OOB message ID counter */
 	spinlock_t		incoming_lock;	/* Incoming call vs service shutdown lock */
 	struct list_head	sock_calls;	/* List of calls owned by this socket */
 	struct list_head	to_be_accepted;	/* calls awaiting acceptance */
@@ -159,6 +163,7 @@ struct rxrpc_sock {
 	struct rb_root		calls;		/* User ID -> call mapping */
 	unsigned long		flags;
 #define RXRPC_SOCK_CONNECTED		0	/* connect_srx is set */
+#define RXRPC_SOCK_MANAGE_RESPONSE	1	/* User wants to manage RESPONSE packets */
 	rwlock_t		call_lock;	/* lock for calls */
 	u32			min_sec_level;	/* minimum security level */
 #define RXRPC_SECURITY_MAX	RXRPC_SECURITY_ENCRYPT
@@ -202,7 +207,7 @@ struct rxrpc_host_header {
  */
 struct rxrpc_skb_priv {
 	union {
-		struct rxrpc_connection *conn;	/* Connection referred to (poke packet) */
+		struct rxrpc_connection *poke_conn;	/* Conn referred to (poke packet) */
 		struct {
 			u16		offset;		/* Offset of data */
 			u16		len;		/* Length of data */
@@ -216,6 +221,19 @@ struct rxrpc_skb_priv {
 			u16		nr_acks;	/* Number of acks+nacks */
 			u8		reason;		/* Reason for ack */
 		} ack;
+		struct {
+			struct rxrpc_connection *conn;	/* Connection referred to */
+			union {
+				u32 rxkad_nonce;
+			};
+		} chall;
+		struct {
+			rxrpc_serial_t	challenge_serial;
+			u32		kvno;
+			u32		version;
+			u16		len;
+			u16		ticket_len;
+		} resp;
 	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
 };
@@ -269,9 +287,24 @@ struct rxrpc_security {
 	/* issue a challenge */
 	int (*issue_challenge)(struct rxrpc_connection *);
 
+	/* Validate a challenge packet */
+	bool (*validate_challenge)(struct rxrpc_connection *conn,
+				   struct sk_buff *skb);
+
+	/* Fill out the cmsg for recvmsg() to pass on a challenge to userspace.
+	 * The security class gets to add additional information.
+	 */
+	int (*challenge_to_recvmsg)(struct rxrpc_connection *conn,
+				    struct sk_buff *challenge,
+				    struct msghdr *msg);
+
+	/* Parse sendmsg() control message and respond to challenge. */
+	int (*sendmsg_respond_to_challenge)(struct sk_buff *challenge,
+					    struct msghdr *msg);
+
 	/* respond to a challenge */
-	int (*respond_to_challenge)(struct rxrpc_connection *,
-				    struct sk_buff *);
+	int (*respond_to_challenge)(struct rxrpc_connection *conn,
+				    struct sk_buff *challenge);
 
 	/* verify a response */
 	int (*verify_response)(struct rxrpc_connection *,
@@ -526,6 +559,7 @@ struct rxrpc_connection {
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
 	};
+	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
 	unsigned long		flags;
 	unsigned long		events;
 	unsigned long		idle_timestamp;	/* Time at which last became idle */
@@ -1199,8 +1233,11 @@ void rxrpc_error_report(struct sock *);
 bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 			s32 abort_code, int err);
 int rxrpc_io_thread(void *data);
+void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
+	if (!local->io_thread)
+		return;
 	wake_up_process(READ_ONCE(local->io_thread));
 }
 
@@ -1289,6 +1326,13 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
 	return net_generic(net, rxrpc_net_id);
 }
 
+/*
+ * out_of_band.c
+ */
+void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb);
+void rxrpc_add_pending_oob(struct rxrpc_sock *rx, struct sk_buff *skb);
+int rxrpc_sendmsg_oob(struct rxrpc_sock *rx, struct msghdr *msg, size_t len);
+
 /*
  * output.c
  */
@@ -1300,6 +1344,7 @@ void rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_send_data_req
 void rxrpc_send_conn_abort(struct rxrpc_connection *conn);
 void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb);
 void rxrpc_send_keepalive(struct rxrpc_peer *);
+void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 
 /*
  * peer_event.c
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index d48e9b021d85..dfa9f3d672c9 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -145,8 +145,8 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	INIT_LIST_HEAD(&call->recvmsg_link);
 	INIT_LIST_HEAD(&call->sock_link);
 	INIT_LIST_HEAD(&call->attend_link);
-	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->recvmsg_queue);
+	skb_queue_head_init(&call->rx_queue);
 	skb_queue_head_init(&call->rx_oos_queue);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->notify_lock);
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 4d9c5e21ba78..232b6986da83 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -19,7 +19,7 @@
 /*
  * Set the completion state on an aborted connection.
  */
-static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff *skb,
+static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn,
 				   s32 abort_code, int err,
 				   enum rxrpc_call_completion compl)
 {
@@ -49,12 +49,20 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 int rxrpc_abort_conn(struct rxrpc_connection *conn, struct sk_buff *skb,
 		     s32 abort_code, int err, enum rxrpc_abort_reason why)
 {
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
-	if (rxrpc_set_conn_aborted(conn, skb, abort_code, err,
+	u32 cid = conn->proto.cid, call = 0, seq = 0;
+
+	if (skb) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+		cid  = sp->hdr.cid;
+		call = sp->hdr.callNumber;
+		seq  = sp->hdr.seq;
+	}
+
+	if (rxrpc_set_conn_aborted(conn, abort_code, err,
 				   RXRPC_CALL_LOCALLY_ABORTED)) {
-		trace_rxrpc_abort(0, why, sp->hdr.cid, sp->hdr.callNumber,
-				  sp->hdr.seq, abort_code, err);
+		trace_rxrpc_abort(0, why, cid, call, seq, abort_code, err);
 		rxrpc_poke_conn(conn, rxrpc_conn_get_poke_abort);
 	}
 	return -EPROTO;
@@ -67,7 +75,7 @@ static void rxrpc_input_conn_abort(struct rxrpc_connection *conn,
 				   struct sk_buff *skb)
 {
 	trace_rxrpc_rx_conn_abort(conn, skb);
-	rxrpc_set_conn_aborted(conn, skb, skb->priority, -ECONNABORTED,
+	rxrpc_set_conn_aborted(conn, skb->priority, -ECONNABORTED,
 			       RXRPC_CALL_REMOTELY_ABORTED);
 }
 
@@ -248,7 +256,10 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_CHALLENGE:
-		return conn->security->respond_to_challenge(conn, skb);
+		ret = conn->security->respond_to_challenge(conn, skb);
+		sp->chall.conn = NULL;
+		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+		return ret;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		ret = conn->security->verify_response(conn, skb);
@@ -270,7 +281,8 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			 * we've already received the packet, put it on the
 			 * front of the queue.
 			 */
-			sp->conn = rxrpc_get_connection(conn, rxrpc_conn_get_poke_secured);
+			sp->poke_conn = rxrpc_get_connection(
+				conn, rxrpc_conn_get_poke_secured);
 			skb->mark = RXRPC_SKB_MARK_SERVICE_CONN_SECURED;
 			rxrpc_get_skb(skb, rxrpc_skb_get_conn_secured);
 			skb_queue_head(&conn->local->rx_queue, skb);
@@ -391,6 +403,61 @@ static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
 	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
 }
 
+/*
+ * Post a CHALLENGE packet to the socket of one of a connection's calls so that
+ * it can get application data to include in the packet, possibly querying
+ * userspace.
+ */
+static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
+				 struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxrpc_call *call = NULL;
+	struct rxrpc_sock *rx;
+	bool respond = false;
+
+	sp->chall.conn =
+		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
+
+	if (!conn->security->challenge_to_recvmsg) {
+		rxrpc_post_packet_to_conn(conn, skb);
+		return true;
+	}
+
+	rcu_read_lock();
+
+	for (int i = 0; i < ARRAY_SIZE(conn->channels); i++) {
+		if (conn->channels[i].call) {
+			call = conn->channels[i].call;
+			rx = rcu_dereference(call->socket);
+			if (!rx) {
+				call = NULL;
+				continue;
+			}
+
+			respond = true;
+			if (test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags))
+				break;
+			call = NULL;
+		}
+	}
+
+	if (!respond) {
+		rcu_read_unlock();
+		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+		sp->chall.conn = NULL;
+		return false;
+	}
+
+	if (call)
+		rxrpc_notify_socket_oob(call, skb);
+	rcu_read_unlock();
+
+	if (!call)
+		rxrpc_post_packet_to_conn(conn, skb);
+	return true;
+}
+
 /*
  * Input a connection-level packet.
  */
@@ -411,6 +478,16 @@ bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_buff *skb)
 		return true;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:
+		rxrpc_see_skb(skb, rxrpc_skb_see_oob_challenge);
+		if (rxrpc_is_conn_aborted(conn)) {
+			if (conn->completion == RXRPC_CALL_LOCALLY_ABORTED)
+				rxrpc_send_conn_abort(conn);
+			return true;
+		}
+		if (!conn->security->validate_challenge(conn, skb))
+			return false;
+		return rxrpc_post_challenge(conn, skb);
+
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		if (rxrpc_is_conn_aborted(conn)) {
 			if (conn->completion == RXRPC_CALL_LOCALLY_ABORTED)
@@ -436,6 +513,19 @@ void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff *skb)
 	if (test_and_clear_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events))
 		rxrpc_abort_calls(conn);
 
+	if (conn->tx_response) {
+		struct sk_buff *skb;
+
+		spin_lock_irq(&conn->local->lock);
+		skb = conn->tx_response;
+		conn->tx_response = NULL;
+		spin_unlock_irq(&conn->local->lock);
+
+		if (conn->state != RXRPC_CONN_ABORTED)
+			rxrpc_send_response(conn, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_response);
+	}
+
 	if (skb) {
 		switch (skb->mark) {
 		case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
@@ -452,3 +542,31 @@ void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff *skb)
 	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
 		rxrpc_process_delayed_final_acks(conn, false);
 }
+
+/*
+ * Post a RESPONSE message to the I/O thread for transmission.
+ */
+void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxrpc_local *local = conn->local;
+	struct sk_buff *old;
+
+	_enter("%x", sp->resp.challenge_serial);
+
+	spin_lock_irq(&local->lock);
+	old = conn->tx_response;
+	if (old) {
+		struct rxrpc_skb_priv *osp = rxrpc_skb(skb);
+
+		/* Always go with the response to the most recent challenge. */
+		if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))
+			conn->tx_response = old;
+		else
+			old = skb;
+	} else {
+		conn->tx_response = skb;
+	}
+	spin_unlock_irq(&local->lock);
+	rxrpc_poke_conn(conn, rxrpc_conn_get_poke_response);
+}
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 2f1fd1e2e7e4..f1e36cba9f4c 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -329,6 +329,7 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	}
 
 	rxrpc_purge_queue(&conn->rx_queue);
+	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
 
 	rxrpc_kill_client_conn(conn);
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index e068f9b79d02..1f7c136d6d0e 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -42,13 +42,19 @@ static void none_free_call_crypto(struct rxrpc_call *call)
 {
 }
 
-static int none_respond_to_challenge(struct rxrpc_connection *conn,
-				     struct sk_buff *skb)
+static bool none_validate_challenge(struct rxrpc_connection *conn,
+				    struct sk_buff *skb)
 {
 	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_challenge);
 }
 
+static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,
+					     struct msghdr *msg)
+{
+	return -EINVAL;
+}
+
 static int none_verify_response(struct rxrpc_connection *conn,
 				struct sk_buff *skb)
 {
@@ -82,7 +88,8 @@ const struct rxrpc_security rxrpc_no_security = {
 	.alloc_txbuf			= none_alloc_txbuf,
 	.secure_packet			= none_secure_packet,
 	.verify_packet			= none_verify_packet,
-	.respond_to_challenge		= none_respond_to_challenge,
+	.validate_challenge		= none_validate_challenge,
+	.sendmsg_respond_to_challenge	= none_sendmsg_respond_to_challenge,
 	.verify_response		= none_verify_response,
 	.clear				= none_clear,
 };
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 64f8d77b8731..27b650d30f4d 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -489,8 +489,8 @@ int rxrpc_io_thread(void *data)
 				rxrpc_free_skb(skb, rxrpc_skb_put_error_report);
 				break;
 			case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
-				rxrpc_input_conn_event(sp->conn, skb);
-				rxrpc_put_connection(sp->conn, rxrpc_conn_put_poke);
+				rxrpc_input_conn_event(sp->poke_conn, skb);
+				rxrpc_put_connection(sp->poke_conn, rxrpc_conn_put_poke);
 				rxrpc_free_skb(skb, rxrpc_skb_put_conn_secured);
 				break;
 			default:
@@ -501,9 +501,11 @@ int rxrpc_io_thread(void *data)
 		}
 
 		/* Deal with connections that want immediate attention. */
-		spin_lock_irq(&local->lock);
-		list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
-		spin_unlock_irq(&local->lock);
+		if (!list_empty_careful(&local->conn_attend_q)) {
+			spin_lock_irq(&local->lock);
+			list_splice_tail_init(&local->conn_attend_q, &conn_attend_q);
+			spin_unlock_irq(&local->lock);
+		}
 
 		while ((conn = list_first_entry_or_null(&conn_attend_q,
 							struct rxrpc_connection,
diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
new file mode 100644
index 000000000000..3601022b9190
--- /dev/null
+++ b/net/rxrpc/oob.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Out of band message handling (e.g. challenge-response)
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/net.h>
+#include <linux/gfp.h>
+#include <linux/skbuff.h>
+#include <linux/export.h>
+#include <linux/sched/signal.h>
+#include <net/sock.h>
+#include <net/af_rxrpc.h>
+#include "ar-internal.h"
+
+enum rxrpc_oob_command {
+	RXRPC_OOB_CMD_UNSET,
+	RXRPC_OOB_CMD_RESPOND,
+} __mode(byte);
+
+struct rxrpc_oob_params {
+	u64			oob_id;		/* ID number of message if reply */
+	s32			abort_code;
+	enum rxrpc_oob_command	command;
+	bool			have_oob_id:1;
+};
+
+/*
+ * Post an out-of-band message for attention by the socket or kernel service
+ * associated with a reference call.
+ */
+void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+
+	rcu_read_lock();
+
+	rx = rcu_dereference(call->socket);
+	if (rx) {
+		sk = &rx->sk;
+		spin_lock_irq(&rx->recvmsg_lock);
+
+		if (sk->sk_state < RXRPC_CLOSE) {
+			skb->skb_mstamp_ns = rx->oob_id_counter++;
+			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
+			skb_queue_tail(&rx->recvmsg_oobq, skb);
+
+			trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
+			if (rx->app_ops)
+				rx->app_ops->notify_oob(sk, skb);
+		}
+
+		spin_unlock_irq(&rx->recvmsg_lock);
+		if (!rx->app_ops && !sock_flag(sk, SOCK_DEAD))
+			sk->sk_data_ready(sk);
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Locate the OOB message to respond to by its ID.
+ */
+static struct sk_buff *rxrpc_find_pending_oob(struct rxrpc_sock *rx, u64 oob_id)
+{
+	struct rb_node *p;
+	struct sk_buff *skb;
+
+	p = rx->pending_oobq.rb_node;
+	while (p) {
+		skb = rb_entry(p, struct sk_buff, rbnode);
+
+		if (oob_id < skb->skb_mstamp_ns)
+			p = p->rb_left;
+		else if (oob_id > skb->skb_mstamp_ns)
+			p = p->rb_right;
+		else
+			return skb;
+	}
+
+	return NULL;
+}
+
+/*
+ * Add an OOB message into the pending-response set.  We always assign the next
+ * value from a 64-bit counter to the oob_id, so just assume we're always going
+ * to be on the right-hand edge of the tree and that the counter won't wrap.
+ * The tree is also given a ref to the message.
+ */
+void rxrpc_add_pending_oob(struct rxrpc_sock *rx, struct sk_buff *skb)
+{
+	struct rb_node **pp = &rx->pending_oobq.rb_node, *p = NULL;
+
+	while (*pp) {
+		p = *pp;
+		pp = &(*pp)->rb_right;
+	}
+
+	rb_link_node(&skb->rbnode, p, pp);
+	rb_insert_color(&skb->rbnode, &rx->pending_oobq);
+}
+
+/*
+ * Extract control messages from the sendmsg() control buffer.
+ */
+static int rxrpc_sendmsg_oob_cmsg(struct msghdr *msg, struct rxrpc_oob_params *p)
+{
+	struct cmsghdr *cmsg;
+	int len;
+
+	if (msg->msg_controllen == 0)
+		return -EINVAL;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			return -EINVAL;
+
+		len = cmsg->cmsg_len - sizeof(struct cmsghdr);
+		_debug("CMSG %d, %d, %d",
+		       cmsg->cmsg_level, cmsg->cmsg_type, len);
+
+		if (cmsg->cmsg_level != SOL_RXRPC)
+			continue;
+
+		switch (cmsg->cmsg_type) {
+		case RXRPC_OOB_ID:
+			if (len != sizeof(p->oob_id) || p->have_oob_id)
+				return -EINVAL;
+			memcpy(&p->oob_id, CMSG_DATA(cmsg), sizeof(p->oob_id));
+			p->have_oob_id = true;
+			break;
+		case RXRPC_RESPOND:
+			if (p->command != RXRPC_OOB_CMD_UNSET)
+				return -EINVAL;
+			p->command = RXRPC_OOB_CMD_RESPOND;
+			break;
+		case RXRPC_ABORT:
+			if (len != sizeof(p->abort_code) || p->abort_code)
+				return -EINVAL;
+			memcpy(&p->abort_code, CMSG_DATA(cmsg), sizeof(p->abort_code));
+			if (p->abort_code == 0)
+				return -EINVAL;
+			break;
+		case RXRPC_RESP_RXGK_APPDATA:
+			if (p->command != RXRPC_OOB_CMD_RESPOND)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	switch (p->command) {
+	case RXRPC_OOB_CMD_RESPOND:
+		if (!p->have_oob_id)
+			return -EBADSLT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Allow userspace to respond to an OOB using sendmsg().
+ */
+static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
+				struct rxrpc_oob_params *p,
+				struct msghdr *msg)
+{
+	struct rxrpc_connection *conn;
+	struct rxrpc_skb_priv *sp;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rxrpc_find_pending_oob(rx, p->oob_id);
+	if (skb)
+		rb_erase(&skb->rbnode, &rx->pending_oobq);
+	release_sock(&rx->sk);
+	if (!skb)
+		return -EBADSLT;
+
+	sp = rxrpc_skb(skb);
+
+	switch (p->command) {
+	case RXRPC_OOB_CMD_RESPOND:
+		ret = -EPROTO;
+		if (skb->mark != RXRPC_OOB_CHALLENGE)
+			break;
+		conn = sp->chall.conn;
+		ret = -EOPNOTSUPP;
+		if (!conn->security->sendmsg_respond_to_challenge)
+			break;
+		if (p->abort_code) {
+			rxrpc_abort_conn(conn, NULL, p->abort_code, -ECONNABORTED,
+					 rxrpc_abort_response_sendmsg);
+			ret = 0;
+		} else {
+			ret = conn->security->sendmsg_respond_to_challenge(skb, msg);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+	return ret;
+}
+
+/*
+ * Send an out-of-band message or respond to a received out-of-band message.
+ * - caller gives us the socket lock
+ * - the socket may be either a client socket or a server socket
+ */
+int rxrpc_sendmsg_oob(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
+{
+	struct rxrpc_oob_params p = {};
+	int ret;
+
+	_enter("");
+
+	ret = rxrpc_sendmsg_oob_cmsg(msg, &p);
+	if (ret < 0)
+		goto error_release_sock;
+
+	if (p.have_oob_id)
+		return rxrpc_respond_to_oob(rx, &p, msg);
+
+	release_sock(&rx->sk);
+
+	switch (p.command) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+
+error_release_sock:
+	release_sock(&rx->sk);
+	return ret;
+}
+
+/**
+ * rxrpc_kernel_query_oob - Query the parameters of an out-of-band message
+ * @oob: The message to query
+ * @_peer: Where to return the peer record
+ * @_peer_appdata: The application data attached to a peer record
+ *
+ * Extract useful parameters from an out-of-band message.  The source peer
+ * parameters are returned through the argument list and the message type is
+ * returned.
+ *
+ * Return:
+ * * %RXRPC_OOB_CHALLENGE - Challenge wanting a response.
+ */
+enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
+					   struct rxrpc_peer **_peer,
+					   unsigned long *_peer_appdata)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
+	enum rxrpc_oob_type type = oob->mark;
+
+	switch (type) {
+	case RXRPC_OOB_CHALLENGE:
+		*_peer		= sp->chall.conn->peer;
+		*_peer_appdata	= 0; /* TODO: retrieve appdata */
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		*_peer		= NULL;
+		*_peer_appdata	= 0;
+		break;
+	}
+
+	return type;
+}
+EXPORT_SYMBOL(rxrpc_kernel_query_oob);
+
+/**
+ * rxrpc_kernel_dequeue_oob - Dequeue and return the front OOB message
+ * @sock: The socket to query
+ * @_type: Where to return the message type
+ *
+ * Dequeue the front OOB message, if there is one, and return it and
+ * its type.
+ *
+ * Return: The sk_buff representing the OOB message or %NULL if the queue was
+ * empty.
+ */
+struct sk_buff *rxrpc_kernel_dequeue_oob(struct socket *sock,
+					 enum rxrpc_oob_type *_type)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sk_buff *oob;
+
+	oob = skb_dequeue(&rx->recvmsg_oobq);
+	if (oob)
+		*_type = oob->mark;
+	return oob;
+}
+EXPORT_SYMBOL(rxrpc_kernel_dequeue_oob);
+
+/**
+ * rxrpc_kernel_free_oob - Free an out-of-band message
+ * @oob: The OOB message to free
+ *
+ * Free an OOB message along with any resources it holds.
+ */
+void rxrpc_kernel_free_oob(struct sk_buff *oob)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
+
+	switch (oob->mark) {
+	case RXRPC_OOB_CHALLENGE:
+		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
+		break;
+	}
+
+	rxrpc_free_skb(oob, rxrpc_skb_put_purge_oob);
+}
+EXPORT_SYMBOL(rxrpc_kernel_free_oob);
+
+/**
+ * rxrpc_kernel_query_challenge - Query the parameters of a challenge
+ * @challenge: The challenge to query
+ * @_peer: Where to return the peer record
+ * @_peer_appdata: The application data attached to a peer record
+ * @_service_id: Where to return the connection service ID
+ * @_security_index: Where to return the connection security index
+ *
+ * Extract useful parameters from a CHALLENGE message.
+ */
+void rxrpc_kernel_query_challenge(struct sk_buff *challenge,
+				  struct rxrpc_peer **_peer,
+				  unsigned long *_peer_appdata,
+				  u16 *_service_id, u8 *_security_index)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
+
+	*_peer		= sp->chall.conn->peer;
+	*_peer_appdata	= 0; /* TODO: retrieve appdata */
+	*_service_id	= sp->hdr.serviceId;
+	*_security_index = sp->hdr.securityIndex;
+}
+EXPORT_SYMBOL(rxrpc_kernel_query_challenge);
+
+/**
+ * rxrpc_kernel_reject_challenge - Allow a kernel service to reject a challenge
+ * @challenge: The challenge to be rejected
+ * @abort_code: The abort code to stick into the ABORT packet
+ * @error: Local error value
+ * @why: Indication as to why.
+ *
+ * Allow a kernel service to reject a challenge by aborting the connection if
+ * it's still in an abortable state.  The error is returned so this function
+ * can be used with a return statement.
+ *
+ * Return: The %error parameter.
+ */
+int rxrpc_kernel_reject_challenge(struct sk_buff *challenge, u32 abort_code,
+				  int error, enum rxrpc_abort_reason why)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
+
+	_enter("{%x},%d,%d,%u", sp->hdr.serial, abort_code, error, why);
+
+	rxrpc_abort_conn(sp->chall.conn, NULL, abort_code, error, why);
+	return error;
+}
+EXPORT_SYMBOL(rxrpc_kernel_reject_challenge);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 95905b85a8d7..04c900990a40 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -916,3 +916,59 @@ void rxrpc_send_keepalive(struct rxrpc_peer *peer)
 	peer->last_tx_at = ktime_get_seconds();
 	_leave("");
 }
+
+/*
+ * Send a RESPONSE message.
+ */
+void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *response)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(response);
+	struct scatterlist sg[16];
+	struct bio_vec bvec[16];
+	struct msghdr msg;
+	size_t len = sp->resp.len;
+	__be32 wserial;
+	u32 serial = 0;
+	int ret, nr_sg;
+
+	_enter("C=%x,%x", conn->debug_id, sp->resp.challenge_serial);
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	ret = skb_to_sgvec(response, sg, 0, len);
+	if (ret < 0)
+		goto fail;
+	nr_sg = ret;
+
+	for (int i = 0; i < nr_sg; i++)
+		bvec_set_page(&bvec[i], sg_page(&sg[i]), sg[i].length, sg[i].offset);
+
+	iov_iter_bvec(&msg.msg_iter, WRITE, bvec, nr_sg, len);
+
+	msg.msg_name	= &conn->peer->srx.transport;
+	msg.msg_namelen	= conn->peer->srx.transport_len;
+	msg.msg_control	= NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags	= MSG_SPLICE_PAGES;
+
+	serial = rxrpc_get_next_serials(conn, 1);
+	wserial = htonl(serial);
+
+	ret = skb_store_bits(response, offsetof(struct rxrpc_wire_header, serial),
+			     &wserial, sizeof(wserial));
+	if (ret < 0)
+		goto fail;
+
+	rxrpc_local_dont_fragment(conn->local, false);
+
+	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
+	if (ret < 0)
+		goto fail;
+
+	conn->peer->last_tx_at = ktime_get_seconds();
+	return;
+
+fail:
+	trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
+			    rxrpc_tx_point_response);
+	kleave(" = %d", ret);
+}
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 4c622752a569..86a27fb55a1c 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -154,6 +154,82 @@ static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff *skb)
 	return call->security->verify_packet(call, skb);
 }
 
+/*
+ * Transcribe a call's user ID to a control message.
+ */
+static int rxrpc_recvmsg_user_id(struct rxrpc_call *call, struct msghdr *msg,
+				 int flags)
+{
+	if (!test_bit(RXRPC_CALL_HAS_USERID, &call->flags))
+		return 0;
+
+	if (flags & MSG_CMSG_COMPAT) {
+		unsigned int id32 = call->user_call_ID;
+
+		return put_cmsg(msg, SOL_RXRPC, RXRPC_USER_CALL_ID,
+				sizeof(unsigned int), &id32);
+	} else {
+		unsigned long idl = call->user_call_ID;
+
+		return put_cmsg(msg, SOL_RXRPC, RXRPC_USER_CALL_ID,
+				sizeof(unsigned long), &idl);
+	}
+}
+
+/*
+ * Deal with a CHALLENGE packet.
+ */
+static int rxrpc_recvmsg_challenge(struct socket *sock, struct msghdr *msg,
+				   struct sk_buff *challenge, unsigned int flags)
+{
+	struct rxrpc_skb_priv *sp = rxrpc_skb(challenge);
+	struct rxrpc_connection *conn = sp->chall.conn;
+
+	return conn->security->challenge_to_recvmsg(conn, challenge, msg);
+}
+
+/*
+ * Process OOB packets.  Called with the socket locked.
+ */
+static int rxrpc_recvmsg_oob(struct socket *sock, struct msghdr *msg,
+			     unsigned int flags)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sk_buff *skb;
+	bool need_response = false;
+	int ret;
+
+	skb = skb_peek(&rx->recvmsg_oobq);
+	if (!skb)
+		return -EAGAIN;
+	rxrpc_see_skb(skb, rxrpc_skb_see_recvmsg);
+
+	ret = put_cmsg(msg, SOL_RXRPC, RXRPC_OOB_ID, sizeof(u64),
+		       &skb->skb_mstamp_ns);
+	if (ret < 0)
+		return ret;
+
+	switch ((enum rxrpc_oob_type)skb->mark) {
+	case RXRPC_OOB_CHALLENGE:
+		need_response = true;
+		ret = rxrpc_recvmsg_challenge(sock, msg, skb, flags);
+		break;
+	default:
+		WARN_ONCE(1, "recvmsg() can't process unknown OOB type %u\n",
+			  skb->mark);
+		ret = -EIO;
+		break;
+	}
+
+	if (!(flags & MSG_PEEK))
+		skb_unlink(skb, &rx->recvmsg_oobq);
+	if (need_response)
+		rxrpc_add_pending_oob(rx, skb);
+	else
+		rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+	return ret;
+}
+
 /*
  * Deliver messages to a call.  This keeps processing packets until the buffer
  * is filled and we find either more DATA (returns 0) or the end of the DATA
@@ -165,6 +241,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 			      size_t len, int flags, size_t *_offset)
 {
 	struct rxrpc_skb_priv *sp;
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	struct sk_buff *skb;
 	rxrpc_seq_t seq = 0;
 	size_t remain;
@@ -207,7 +284,6 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 			trace_rxrpc_recvdata(call, rxrpc_recvmsg_next, seq,
 					     sp->offset, sp->len, ret2);
 			if (ret2 < 0) {
-				kdebug("verify = %d", ret2);
 				ret = ret2;
 				goto out;
 			}
@@ -255,6 +331,13 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 
 		if (!(flags & MSG_PEEK))
 			rxrpc_rotate_rx_window(call);
+
+		if (!rx->app_ops &&
+		    !skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
+			trace_rxrpc_recvdata(call, rxrpc_recvmsg_oobq, seq,
+					     rx_pkt_offset, rx_pkt_len, ret);
+			break;
+		}
 	}
 
 out:
@@ -262,6 +345,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 		call->rx_pkt_offset = rx_pkt_offset;
 		call->rx_pkt_len = rx_pkt_len;
 	}
+
 done:
 	trace_rxrpc_recvdata(call, rxrpc_recvmsg_data_return, seq,
 			     rx_pkt_offset, rx_pkt_len, ret);
@@ -301,6 +385,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	/* Return immediately if a client socket has no outstanding calls */
 	if (RB_EMPTY_ROOT(&rx->calls) &&
 	    list_empty(&rx->recvmsg_q) &&
+	    skb_queue_empty_lockless(&rx->recvmsg_oobq) &&
 	    rx->sk.sk_state != RXRPC_SERVER_LISTENING) {
 		release_sock(&rx->sk);
 		return -EAGAIN;
@@ -322,7 +407,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (ret)
 			goto wait_error;
 
-		if (list_empty(&rx->recvmsg_q)) {
+		if (list_empty(&rx->recvmsg_q) &&
+		    skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
 			if (signal_pending(current))
 				goto wait_interrupted;
 			trace_rxrpc_recvmsg(0, rxrpc_recvmsg_wait, 0);
@@ -332,6 +418,15 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto try_again;
 	}
 
+	/* Deal with OOB messages before we consider getting normal data. */
+	if (!skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
+		ret = rxrpc_recvmsg_oob(sock, msg, flags);
+		release_sock(&rx->sk);
+		if (ret == -EAGAIN)
+			goto try_again;
+		goto error_no_call;
+	}
+
 	/* Find the next call and dequeue it if we're not just peeking.  If we
 	 * do dequeue it, that comes with a ref that we will need to release.
 	 * We also want to weed out calls that got requeued whilst we were
@@ -342,7 +437,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
-	    skb_queue_empty(&call->recvmsg_queue)) {
+	    skb_queue_empty(&call->recvmsg_queue) &&
+	    skb_queue_empty(&rx->recvmsg_oobq)) {
 		list_del_init(&call->recvmsg_link);
 		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
@@ -377,21 +473,9 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (test_bit(RXRPC_CALL_RELEASED, &call->flags))
 		BUG();
 
-	if (test_bit(RXRPC_CALL_HAS_USERID, &call->flags)) {
-		if (flags & MSG_CMSG_COMPAT) {
-			unsigned int id32 = call->user_call_ID;
-
-			ret = put_cmsg(msg, SOL_RXRPC, RXRPC_USER_CALL_ID,
-				       sizeof(unsigned int), &id32);
-		} else {
-			unsigned long idl = call->user_call_ID;
-
-			ret = put_cmsg(msg, SOL_RXRPC, RXRPC_USER_CALL_ID,
-				       sizeof(unsigned long), &idl);
-		}
-		if (ret < 0)
-			goto error_unlock_call;
-	}
+	ret = rxrpc_recvmsg_user_id(call, msg, flags);
+	if (ret < 0)
+		goto error_unlock_call;
 
 	if (msg->msg_name && call->peer) {
 		size_t len = sizeof(call->dest_srx);
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 6cb37b0eb77f..8ddccee69009 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -697,62 +697,6 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 	return 0;
 }
 
-/*
- * send a Kerberos security response
- */
-static int rxkad_send_response(struct rxrpc_connection *conn,
-			       struct rxrpc_host_header *hdr,
-			       struct rxkad_response *resp,
-			       const struct rxkad_key *s2)
-{
-	struct rxrpc_wire_header whdr;
-	struct msghdr msg;
-	struct kvec iov[3];
-	size_t len;
-	u32 serial;
-	int ret;
-
-	_enter("");
-
-	msg.msg_name	= &conn->peer->srx.transport;
-	msg.msg_namelen	= conn->peer->srx.transport_len;
-	msg.msg_control	= NULL;
-	msg.msg_controllen = 0;
-	msg.msg_flags	= 0;
-
-	memset(&whdr, 0, sizeof(whdr));
-	whdr.epoch	= htonl(hdr->epoch);
-	whdr.cid	= htonl(hdr->cid);
-	whdr.type	= RXRPC_PACKET_TYPE_RESPONSE;
-	whdr.flags	= conn->out_clientflag;
-	whdr.securityIndex = hdr->securityIndex;
-	whdr.serviceId	= htons(hdr->serviceId);
-
-	iov[0].iov_base	= &whdr;
-	iov[0].iov_len	= sizeof(whdr);
-	iov[1].iov_base	= resp;
-	iov[1].iov_len	= sizeof(*resp);
-	iov[2].iov_base	= (void *)s2->ticket;
-	iov[2].iov_len	= s2->ticket_len;
-
-	len = iov[0].iov_len + iov[1].iov_len + iov[2].iov_len;
-
-	serial = rxrpc_get_next_serial(conn);
-	whdr.serial = htonl(serial);
-
-	rxrpc_local_dont_fragment(conn->local, false);
-	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
-	if (ret < 0) {
-		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
-				    rxrpc_tx_point_rxkad_response);
-		return -EAGAIN;
-	}
-
-	conn->peer->last_tx_at = ktime_get_seconds();
-	_leave(" = 0");
-	return 0;
-}
-
 /*
  * calculate the response checksum
  */
@@ -772,12 +716,21 @@ static void rxkad_calc_response_checksum(struct rxkad_response *response)
  * encrypt the response packet
  */
 static int rxkad_encrypt_response(struct rxrpc_connection *conn,
-				  struct rxkad_response *resp,
+				  struct sk_buff *response,
 				  const struct rxkad_key *s2)
 {
 	struct skcipher_request *req;
 	struct rxrpc_crypt iv;
 	struct scatterlist sg[1];
+	size_t encsize = sizeof(((struct rxkad_response *)0)->encrypted);
+	int ret;
+
+	sg_init_table(sg, ARRAY_SIZE(sg));
+	ret = skb_to_sgvec(response, sg,
+			   sizeof(struct rxrpc_wire_header) +
+			   offsetof(struct rxkad_response, encrypted), encsize);
+	if (ret < 0)
+		return ret;
 
 	req = skcipher_request_alloc(&conn->rxkad.cipher->base, GFP_NOFS);
 	if (!req)
@@ -786,88 +739,205 @@ static int rxkad_encrypt_response(struct rxrpc_connection *conn,
 	/* continue encrypting from where we left off */
 	memcpy(&iv, s2->session_key, sizeof(iv));
 
-	sg_init_table(sg, 1);
-	sg_set_buf(sg, &resp->encrypted, sizeof(resp->encrypted));
 	skcipher_request_set_sync_tfm(req, conn->rxkad.cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, sg, sg, sizeof(resp->encrypted), iv.x);
-	crypto_skcipher_encrypt(req);
+	skcipher_request_set_crypt(req, sg, sg, encsize, iv.x);
+	ret = crypto_skcipher_encrypt(req);
 	skcipher_request_free(req);
-	return 0;
+	return ret;
 }
 
 /*
- * respond to a challenge packet
+ * Validate a challenge packet.
  */
-static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
-				      struct sk_buff *skb)
+static bool rxkad_validate_challenge(struct rxrpc_connection *conn,
+				     struct sk_buff *skb)
 {
-	const struct rxrpc_key_token *token;
 	struct rxkad_challenge challenge;
-	struct rxkad_response *resp;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	u32 version, nonce, min_level;
-	int ret = -EPROTO;
+	u32 version, min_level;
+	int ret;
 
 	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
 
-	if (!conn->key)
-		return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
-					rxkad_abort_chall_no_key);
+	if (!conn->key) {
+		rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+				 rxkad_abort_chall_no_key);
+		return false;
+	}
 
 	ret = key_validate(conn->key);
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, RXKADEXPIRED, ret,
-					rxkad_abort_chall_key_expired);
+	if (ret < 0) {
+		rxrpc_abort_conn(conn, skb, RXKADEXPIRED, ret,
+				 rxkad_abort_chall_key_expired);
+		return false;
+	}
 
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  &challenge, sizeof(challenge)) < 0)
-		return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
-					rxkad_abort_chall_short);
+			  &challenge, sizeof(challenge)) < 0) {
+		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
+				 rxkad_abort_chall_short);
+		return false;
+	}
 
 	version = ntohl(challenge.version);
-	nonce = ntohl(challenge.nonce);
+	sp->chall.rxkad_nonce = ntohl(challenge.nonce);
 	min_level = ntohl(challenge.min_level);
 
-	trace_rxrpc_rx_challenge(conn, sp->hdr.serial, version, nonce, min_level);
+	trace_rxrpc_rx_challenge(conn, sp->hdr.serial, version,
+				 sp->chall.rxkad_nonce, min_level);
 
-	if (version != RXKAD_VERSION)
-		return rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
-					rxkad_abort_chall_version);
+	if (version != RXKAD_VERSION) {
+		rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
+				 rxkad_abort_chall_version);
+		return false;
+	}
 
-	if (conn->security_level < min_level)
-		return rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EACCES,
-					rxkad_abort_chall_level);
+	if (conn->security_level < min_level) {
+		rxrpc_abort_conn(conn, skb, RXKADLEVELFAIL, -EACCES,
+				 rxkad_abort_chall_level);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Insert the header into the response.
+ */
+static noinline
+int rxkad_insert_response_header(struct rxrpc_connection *conn,
+				 const struct rxrpc_key_token *token,
+				 struct sk_buff *challenge,
+				 struct sk_buff *response,
+				 size_t *offset)
+{
+	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
+	struct {
+		struct rxrpc_wire_header whdr;
+		struct rxkad_response	resp;
+	} h;
+	int ret;
+
+	h.whdr.epoch			= htonl(conn->proto.epoch);
+	h.whdr.cid			= htonl(conn->proto.cid);
+	h.whdr.callNumber		= 0;
+	h.whdr.serial			= 0;
+	h.whdr.seq			= 0;
+	h.whdr.type			= RXRPC_PACKET_TYPE_RESPONSE;
+	h.whdr.flags			= conn->out_clientflag;
+	h.whdr.userStatus		= 0;
+	h.whdr.securityIndex		= conn->security_ix;
+	h.whdr.cksum			= 0;
+	h.whdr.serviceId		= htons(conn->service_id);
+	h.resp.version			= htonl(RXKAD_VERSION);
+	h.resp.__pad			= 0;
+	h.resp.encrypted.epoch		= htonl(conn->proto.epoch);
+	h.resp.encrypted.cid		= htonl(conn->proto.cid);
+	h.resp.encrypted.checksum	= 0;
+	h.resp.encrypted.securityIndex	= htonl(conn->security_ix);
+	h.resp.encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
+	h.resp.encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
+	h.resp.encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
+	h.resp.encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
+	h.resp.encrypted.inc_nonce	= htonl(csp->chall.rxkad_nonce + 1);
+	h.resp.encrypted.level		= htonl(conn->security_level);
+	h.resp.kvno			= htonl(token->kad->kvno);
+	h.resp.ticket_len		= htonl(token->kad->ticket_len);
+
+	rxkad_calc_response_checksum(&h.resp);
+
+	ret = skb_store_bits(response, *offset, &h, sizeof(h));
+	*offset += sizeof(h);
+	return ret;
+}
+
+/*
+ * respond to a challenge packet
+ */
+static int rxkad_respond_to_challenge(struct rxrpc_connection *conn,
+				      struct sk_buff *challenge)
+{
+	const struct rxrpc_key_token *token;
+	struct rxrpc_skb_priv *csp, *rsp;
+	struct sk_buff *response;
+	size_t len, offset = 0;
+	int ret = -EPROTO;
+
+	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
+
+	ret = key_validate(conn->key);
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, challenge, RXKADEXPIRED, ret,
+					rxkad_abort_chall_key_expired);
 
 	token = conn->key->payload.data[0];
 
 	/* build the response packet */
-	resp = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
-	if (!resp)
-		return -ENOMEM;
+	len = sizeof(struct rxrpc_wire_header) +
+		sizeof(struct rxkad_response) +
+		token->kad->ticket_len;
+
+	response = alloc_skb_with_frags(0, len, 0, &ret, GFP_NOFS);
+	if (!response)
+		goto error;
+	rxrpc_new_skb(response, rxrpc_skb_new_response_rxkad);
+	response->len = len;
+	response->data_len = len;
+
+	offset = 0;
+	ret = rxkad_insert_response_header(conn, token, challenge, response,
+					   &offset);
+	if (ret < 0)
+		goto error;
+
+	ret = rxkad_encrypt_response(conn, response, token->kad);
+	if (ret < 0)
+		goto error;
+
+	ret = skb_store_bits(response, offset, token->kad->ticket,
+			     token->kad->ticket_len);
+	if (ret < 0)
+		goto error;
 
-	resp->version			= htonl(RXKAD_VERSION);
-	resp->encrypted.epoch		= htonl(conn->proto.epoch);
-	resp->encrypted.cid		= htonl(conn->proto.cid);
-	resp->encrypted.securityIndex	= htonl(conn->security_ix);
-	resp->encrypted.inc_nonce	= htonl(nonce + 1);
-	resp->encrypted.level		= htonl(conn->security_level);
-	resp->kvno			= htonl(token->kad->kvno);
-	resp->ticket_len		= htonl(token->kad->ticket_len);
-	resp->encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
-	resp->encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
-	resp->encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
-	resp->encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
-
-	/* calculate the response checksum and then do the encryption */
-	rxkad_calc_response_checksum(resp);
-	ret = rxkad_encrypt_response(conn, resp, token->kad);
-	if (ret == 0)
-		ret = rxkad_send_response(conn, &sp->hdr, resp, token->kad);
-	kfree(resp);
+	csp = rxrpc_skb(challenge);
+	rsp = rxrpc_skb(response);
+	rsp->resp.len = len;
+	rsp->resp.challenge_serial = csp->hdr.serial;
+	rxrpc_post_response(conn, response);
+	response = NULL;
+	ret = 0;
+
+error:
+	rxrpc_free_skb(response, rxrpc_skb_put_response);
 	return ret;
 }
 
+/*
+ * RxKAD does automatic response only as there's nothing to manage that isn't
+ * already in the key.
+ */
+static int rxkad_sendmsg_respond_to_challenge(struct sk_buff *challenge,
+					      struct msghdr *msg)
+{
+	return -EINVAL;
+}
+
+/**
+ * rxkad_kernel_respond_to_challenge - Respond to a challenge with appdata
+ * @challenge: The challenge to respond to
+ *
+ * Allow a kernel application to respond to a CHALLENGE.
+ *
+ * Return: %0 if successful and a negative error code otherwise.
+ */
+int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge)
+{
+	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
+
+	return rxkad_respond_to_challenge(csp->chall.conn, challenge);
+}
+EXPORT_SYMBOL(rxkad_kernel_respond_to_challenge);
+
 /*
  * decrypt the kerberos IV ticket in the response
  */
@@ -1276,6 +1346,8 @@ const struct rxrpc_security rxkad = {
 	.verify_packet			= rxkad_verify_packet,
 	.free_call_crypto		= rxkad_free_call_crypto,
 	.issue_challenge		= rxkad_issue_challenge,
+	.validate_challenge		= rxkad_validate_challenge,
+	.sendmsg_respond_to_challenge	= rxkad_sendmsg_respond_to_challenge,
 	.respond_to_challenge		= rxkad_respond_to_challenge,
 	.verify_response		= rxkad_verify_response,
 	.clear				= rxkad_clear,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 2342b5f1547c..ebbb78b842de 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -758,14 +758,21 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	if (rxrpc_call_is_complete(call)) {
 		/* it's too late for this call */
 		ret = -ESHUTDOWN;
-	} else if (p.command == RXRPC_CMD_SEND_ABORT) {
+		goto out_put_unlock;
+	}
+
+	switch (p.command) {
+	case RXRPC_CMD_SEND_ABORT:
 		rxrpc_propose_abort(call, p.abort_code, -ECONNABORTED,
 				    rxrpc_abort_call_sendmsg);
 		ret = 0;
-	} else if (p.command != RXRPC_CMD_SEND_DATA) {
-		ret = -EINVAL;
-	} else {
+		break;
+	case RXRPC_CMD_SEND_DATA:
 		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 out_put_unlock:
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index eb7525e92951..36b05fd842a7 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -171,3 +171,43 @@ int rxrpc_sock_set_security_keyring(struct sock *sk, struct key *keyring)
 	return ret;
 }
 EXPORT_SYMBOL(rxrpc_sock_set_security_keyring);
+
+/**
+ * rxrpc_sock_set_manage_response - Set the manage-response flag for a kernel service
+ * @sk: The socket to set the keyring on
+ * @set: True to set, false to clear the flag
+ *
+ * Set the flag on an rxrpc socket to say that the caller wants to manage the
+ * RESPONSE packet and the user-defined data it may contain.  Setting this
+ * means that recvmsg() will return messages with RXRPC_CHALLENGED in the
+ * control message buffer containing information about the challenge.
+ *
+ * The user should respond to the challenge by passing RXRPC_RESPOND or
+ * RXRPC_RESPOND_ABORT control messages with sendmsg() to the same call.
+ * Supplementary control messages, such as RXRPC_RESP_RXGK_APPDATA, may be
+ * included to indicate the parts the user wants to supply.
+ *
+ * The server will be passed the response data with a RXRPC_RESPONDED control
+ * message when it gets the first data from each call.
+ *
+ * Note that this is only honoured by security classes that need auxiliary data
+ * (e.g. RxGK).  Those that don't offer the facility (e.g. RxKAD) respond
+ * without consulting userspace.
+ *
+ * Return: The previous setting.
+ */
+int rxrpc_sock_set_manage_response(struct sock *sk, bool set)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sk);
+	int ret;
+
+	lock_sock(sk);
+	ret = !!test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	if (set)
+		set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	else
+		clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	release_sock(sk);
+	return ret;
+}
+EXPORT_SYMBOL(rxrpc_sock_set_manage_response);


