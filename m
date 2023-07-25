Return-Path: <netdev+bounces-21033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115D762369
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F25281AAD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0462591D;
	Tue, 25 Jul 2023 20:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E81C39;
	Tue, 25 Jul 2023 20:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8CC433CB;
	Tue, 25 Jul 2023 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317416;
	bh=iD+9/TG8utnpQ+5LlbD8UraXzNLd0V7t1XEdg0wvaug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u0anNnEfeRUpiGoIA46fKEDt66xPEL2hUj/1tB4QMHfE2rhDV6R5gxZzuQQTlRisG
	 v/+AG1tKQ25YmJPBezw+qNBxbB7GlSUXbpqzLeogwG8kle7VS8gzOWBTsmsvol6jVS
	 xVDgT3DZ+JiMeZImL+TAH/pnmDgaWx50iHJls03Xoxw8ZsP5t5QFhBPoRzYDgS9s4w
	 6ySPNqbe0wccPxJU5ejuzZ41rYQnd1vwG0Zz/E34ngCbJei9UT6URFnAA1GK+6/Fs9
	 Bu57fWSt+VP2DLR/dsVooiXEiJt7I6H51+jJ2aNntH+M6e76Sn4Osq1wdnrzIl2g7S
	 elkCawXIlCrrA==
Subject: [PATCH net-next v2 3/7] net/handshake: Add API for sending TLS
 Closure alerts
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 25 Jul 2023 16:36:44 -0400
Message-ID: 
 <169031739483.15386.5911126621395017786.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
References: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

This helper sends an alert only if a TLS session was established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/handshake.h   |    1 +
 net/handshake/Makefile    |    2 +
 net/handshake/alert.c     |   62 +++++++++++++++++++++++++++++++++++++++++++++
 net/handshake/handshake.h |    4 +++
 net/handshake/tlshd.c     |   23 +++++++++++++++++
 5 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 net/handshake/alert.c

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 2e26e436e85f..bb88dfa6e3c9 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -40,5 +40,6 @@ int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 
 bool tls_handshake_cancel(struct sock *sk);
+void tls_handshake_close(struct socket *sock);
 
 #endif /* _NET_HANDSHAKE_H */
diff --git a/net/handshake/Makefile b/net/handshake/Makefile
index 247d73c6ff6e..ef4d9a2112bd 100644
--- a/net/handshake/Makefile
+++ b/net/handshake/Makefile
@@ -8,6 +8,6 @@
 #
 
 obj-y += handshake.o
-handshake-y := genl.o netlink.o request.o tlshd.o trace.o
+handshake-y := alert.o genl.o netlink.o request.o tlshd.o trace.o
 
 obj-$(CONFIG_NET_HANDSHAKE_KUNIT_TEST) += handshake-test.o
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
new file mode 100644
index 000000000000..999d3ffaf3e3
--- /dev/null
+++ b/net/handshake/alert.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Handle the TLS Alert protocol
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2023, Oracle and/or its affiliates.
+ */
+
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/inet.h>
+
+#include <net/sock.h>
+#include <net/handshake.h>
+#include <net/genetlink.h>
+#include <net/tls.h>
+#include <net/tls_prot.h>
+
+#include "handshake.h"
+
+/**
+ * tls_alert_send - send a TLS Alert on a kTLS socket
+ * @sock: open kTLS socket to send on
+ * @level: TLS Alert level
+ * @description: TLS Alert description
+ *
+ * Returns zero on success or a negative errno.
+ */
+int tls_alert_send(struct socket *sock, u8 level, u8 description)
+{
+	u8 record_type = TLS_RECORD_TYPE_ALERT;
+	u8 buf[CMSG_SPACE(sizeof(record_type))];
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	struct kvec iov;
+	u8 alert[2];
+	int ret;
+
+	alert[0] = level;
+	alert[1] = description;
+	iov.iov_base = alert;
+	iov.iov_len = sizeof(alert);
+
+	memset(buf, 0, sizeof(buf));
+	msg.msg_control = buf;
+	msg.msg_controllen = sizeof(buf);
+	msg.msg_flags = MSG_DONTWAIT;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_TLS;
+	cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(record_type));
+	memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
+
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, iov.iov_len);
+	ret = sock_sendmsg(sock, &msg);
+	return ret < 0 ? ret : 0;
+}
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index 4dac965c99df..af1633d5ad73 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -41,6 +41,7 @@ struct handshake_req {
 
 enum hr_flags_bits {
 	HANDSHAKE_F_REQ_COMPLETED,
+	HANDSHAKE_F_REQ_SESSION,
 };
 
 /* Invariants for all handshake requests for one transport layer
@@ -63,6 +64,9 @@ enum hp_flags_bits {
 	HANDSHAKE_F_PROTO_NOTIFY,
 };
 
+/* alert.c */
+int tls_alert_send(struct socket *sock, u8 level, u8 description);
+
 /* netlink.c */
 int handshake_genl_notify(struct net *net, const struct handshake_proto *proto,
 			  gfp_t flags);
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index b735f5cced2f..bbfb4095ddd6 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -18,6 +18,7 @@
 #include <net/sock.h>
 #include <net/handshake.h>
 #include <net/genetlink.h>
+#include <net/tls_prot.h>
 
 #include <uapi/linux/keyctl.h>
 #include <uapi/linux/handshake.h>
@@ -100,6 +101,9 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (info)
 		tls_handshake_remote_peerids(treq, info);
 
+	if (!status)
+		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
+
 	treq->th_consumer_done(treq->th_consumer_data, -status,
 			       treq->th_peerid[0]);
 }
@@ -424,3 +428,22 @@ bool tls_handshake_cancel(struct sock *sk)
 	return handshake_req_cancel(sk);
 }
 EXPORT_SYMBOL(tls_handshake_cancel);
+
+/**
+ * tls_handshake_close - send a Closure alert
+ * @sock: an open socket
+ *
+ */
+void tls_handshake_close(struct socket *sock)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sock->sk);
+	if (!req)
+		return;
+	if (!test_and_clear_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags))
+		return;
+	tls_alert_send(sock, TLS_ALERT_LEVEL_WARNING,
+		       TLS_ALERT_DESC_CLOSE_NOTIFY);
+}
+EXPORT_SYMBOL(tls_handshake_close);



