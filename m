Return-Path: <netdev+bounces-18706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18F758546
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B12281199
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D66168BC;
	Tue, 18 Jul 2023 19:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7246168A1;
	Tue, 18 Jul 2023 19:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F8EC433C8;
	Tue, 18 Jul 2023 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706921;
	bh=JlJvrBCMuSJqKk+McFytPrLKB9QBfH+KxP0ME52UcTg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D/iMmmAhK2QCMiR3pLTqlth/7BpYKAKgClCbWxsm1FjTrVpC/AWydFD4ObXz5+ZAX
	 VXRMtCofDsraQgHjwhaQbE4vaG/84CHuyO6IFk4D1VSx+v0ZFqDgfUayPUsw/gYrqL
	 iQTxmb/XSyAXbT65h5ZyesKTzR52pTkNc45sY0/Aj5Xpy2jFckwUafTLXJTrz0hHQs
	 Kiyi71fhj9uiqHorOIIc4Ea4Do3cDTK5jsGnbF8somjiLR/qW7IElTogIETUHN7Lgw
	 c9kiY9yEc3H4geOnF+wHThXUGbT7Rj9bJU/AeaC/qcsRfCqLpU+6091yOT87HvtMRR
	 P1g9RK7uyjjzQ==
Subject: [PATCH net-next v1 7/7] net/handshake: Trace events for TLS Alert
 helpers
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 15:01:50 -0400
Message-ID: 
 <168970690005.5330.12576672055397583164.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
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

Add observability for the new TLS Alert infrastructure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/handshake.h |  160 ++++++++++++++++++++++++++++++++++++++
 net/handshake/alert.c            |    7 ++
 net/handshake/trace.c            |    2 
 3 files changed, 169 insertions(+)

diff --git a/include/trace/events/handshake.h b/include/trace/events/handshake.h
index 8dadcab5f12a..bdd8a03cf5ba 100644
--- a/include/trace/events/handshake.h
+++ b/include/trace/events/handshake.h
@@ -6,7 +6,86 @@
 #define _TRACE_HANDSHAKE_H
 
 #include <linux/net.h>
+#include <net/tls_prot.h>
 #include <linux/tracepoint.h>
+#include <trace/events/net_probe_common.h>
+
+#define TLS_RECORD_TYPE_LIST \
+	record_type(CHANGE_CIPHER_SPEC) \
+	record_type(ALERT) \
+	record_type(HANDSHAKE) \
+	record_type(DATA) \
+	record_type(HEARTBEAT) \
+	record_type(TLS12_CID) \
+	record_type_end(ACK)
+
+#undef record_type
+#undef record_type_end
+#define record_type(x)		TRACE_DEFINE_ENUM(TLS_RECORD_TYPE_##x);
+#define record_type_end(x)	TRACE_DEFINE_ENUM(TLS_RECORD_TYPE_##x);
+
+TLS_RECORD_TYPE_LIST
+
+#undef record_type
+#undef record_type_end
+#define record_type(x)		{ TLS_RECORD_TYPE_##x, #x },
+#define record_type_end(x)	{ TLS_RECORD_TYPE_##x, #x }
+
+#define show_tls_content_type(type) \
+	__print_symbolic(type, TLS_RECORD_TYPE_LIST)
+
+TRACE_DEFINE_ENUM(TLS_ALERT_LEVEL_WARNING);
+TRACE_DEFINE_ENUM(TLS_ALERT_LEVEL_FATAL);
+
+#define show_tls_alert_level(level) \
+	__print_symbolic(level, \
+		{ TLS_ALERT_LEVEL_WARNING,	"Warning" }, \
+		{ TLS_ALERT_LEVEL_FATAL,	"Fatal" })
+
+#define TLS_ALERT_DESCRIPTION_LIST \
+	alert_description(CLOSE_NOTIFY) \
+	alert_description(UNEXPECTED_MESSAGE) \
+	alert_description(BAD_RECORD_MAC) \
+	alert_description(RECORD_OVERFLOW) \
+	alert_description(HANDSHAKE_FAILURE) \
+	alert_description(BAD_CERTIFICATE) \
+	alert_description(UNSUPPORTED_CERTIFICATE) \
+	alert_description(CERTIFICATE_REVOKED) \
+	alert_description(CERTIFICATE_EXPIRED) \
+	alert_description(CERTIFICATE_UNKNOWN) \
+	alert_description(ILLEGAL_PARAMETER) \
+	alert_description(UNKNOWN_CA) \
+	alert_description(ACCESS_DENIED) \
+	alert_description(DECODE_ERROR) \
+	alert_description(DECRYPT_ERROR) \
+	alert_description(TOO_MANY_CIDS_REQUESTED) \
+	alert_description(PROTOCOL_VERSION) \
+	alert_description(INSUFFICIENT_SECURITY) \
+	alert_description(INTERNAL_ERROR) \
+	alert_description(INAPPROPRIATE_FALLBACK) \
+	alert_description(USER_CANCELED) \
+	alert_description(MISSING_EXTENSION) \
+	alert_description(UNSUPPORTED_EXTENSION) \
+	alert_description(UNRECOGNIZED_NAME) \
+	alert_description(BAD_CERTIFICATE_STATUS_RESPONSE) \
+	alert_description(UNKNOWN_PSK_IDENTITY) \
+	alert_description(CERTIFICATE_REQUIRED) \
+	alert_description_end(NO_APPLICATION_PROTOCOL)
+
+#undef alert_description
+#undef alert_description_end
+#define alert_description(x)		TRACE_DEFINE_ENUM(TLS_ALERT_DESC_##x);
+#define alert_description_end(x)	TRACE_DEFINE_ENUM(TLS_ALERT_DESC_##x);
+
+TLS_ALERT_DESCRIPTION_LIST
+
+#undef alert_description
+#undef alert_description_end
+#define alert_description(x)		{ TLS_ALERT_DESC_##x, #x },
+#define alert_description_end(x)	{ TLS_ALERT_DESC_##x, #x }
+
+#define show_tls_alert_description(desc) \
+	__print_symbolic(desc, TLS_ALERT_DESCRIPTION_LIST)
 
 DECLARE_EVENT_CLASS(handshake_event_class,
 	TP_PROTO(
@@ -106,6 +185,47 @@ DECLARE_EVENT_CLASS(handshake_error_class,
 		),						\
 		TP_ARGS(net, req, sk, err))
 
+DECLARE_EVENT_CLASS(handshake_alert_class,
+	TP_PROTO(
+		const struct sock *sk,
+		unsigned char level,
+		unsigned char description
+	),
+	TP_ARGS(sk, level, description),
+	TP_STRUCT__entry(
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(unsigned int, netns_ino)
+		__field(unsigned long, level)
+		__field(unsigned long, description)
+	),
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		__entry->netns_ino = sock_net(sk)->ns.inum;
+		__entry->level = level;
+		__entry->description = description;
+	),
+	TP_printk("src=%pISpc dest=%pISpc %s: %s",
+		__entry->saddr, __entry->daddr,
+		show_tls_alert_level(__entry->level),
+		show_tls_alert_description(__entry->description)
+	)
+);
+#define DEFINE_HANDSHAKE_ALERT(name)				\
+	DEFINE_EVENT(handshake_alert_class, name,		\
+		TP_PROTO(					\
+			const struct sock *sk,			\
+			unsigned char level,			\
+			unsigned char description		\
+		),						\
+		TP_ARGS(sk, level, description))
+
 
 /*
  * Request lifetime events
@@ -154,6 +274,46 @@ DEFINE_HANDSHAKE_ERROR(handshake_cmd_accept_err);
 DEFINE_HANDSHAKE_FD_EVENT(handshake_cmd_done);
 DEFINE_HANDSHAKE_ERROR(handshake_cmd_done_err);
 
+/*
+ * TLS Record events
+ */
+
+TRACE_EVENT(tls_contenttype,
+	TP_PROTO(
+		const struct sock *sk,
+		unsigned char type
+	),
+	TP_ARGS(sk, type),
+	TP_STRUCT__entry(
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(unsigned int, netns_ino)
+		__field(unsigned long, type)
+	),
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		__entry->netns_ino = sock_net(sk)->ns.inum;
+		__entry->type = type;
+	),
+	TP_printk("src=%pISpc dest=%pISpc %s",
+		__entry->saddr, __entry->daddr,
+		show_tls_content_type(__entry->type)
+	)
+);
+
+/*
+ * TLS Alert events
+ */
+
+DEFINE_HANDSHAKE_ALERT(tls_alert_send);
+DEFINE_HANDSHAKE_ALERT(tls_alert_recv);
+
 #endif /* _TRACE_HANDSHAKE_H */
 
 #include <trace/define_trace.h>
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 93e05d8d599c..e6cbeebe48f5 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -22,6 +22,8 @@
 
 #include "handshake.h"
 
+#include <trace/events/handshake.h>
+
 /**
  * tls_alert_send - send a TLS Alert on a kTLS socket
  * @sock: open kTLS socket to send on
@@ -40,6 +42,8 @@ int tls_alert_send(struct socket *sock, u8 level, u8 description)
 	u8 alert[2];
 	int ret;
 
+	trace_tls_alert_send(sock->sk, level, description);
+
 	alert[0] = level;
 	alert[1] = description;
 	iov.iov_base = alert;
@@ -78,6 +82,7 @@ u8 tls_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
 		return 0;
 
 	record_type = *((u8 *)CMSG_DATA(cmsg));
+	trace_tls_contenttype(sk, record_type);
 	return record_type;
 }
 EXPORT_SYMBOL(tls_record_type);
@@ -103,6 +108,8 @@ bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 	data = iov->iov_base;
 	*level = data[0];
 	*description = data[1];
+
+	trace_tls_alert_recv(sk, *level, *description);
 	return true;
 }
 EXPORT_SYMBOL(tls_alert_recv);
diff --git a/net/handshake/trace.c b/net/handshake/trace.c
index 1c4d8e27e17a..44432d0857b9 100644
--- a/net/handshake/trace.c
+++ b/net/handshake/trace.c
@@ -8,8 +8,10 @@
  */
 
 #include <linux/types.h>
+#include <linux/ipv6.h>
 
 #include <net/sock.h>
+#include <net/inet_sock.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
 



