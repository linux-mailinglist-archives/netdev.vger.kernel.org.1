Return-Path: <netdev+bounces-21037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27557623A3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E79A281ADE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63F25939;
	Tue, 25 Jul 2023 20:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C021C39;
	Tue, 25 Jul 2023 20:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE5C433C7;
	Tue, 25 Jul 2023 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317488;
	bh=qYEaGe8x/x/I3W8Vd67YqdHd5WGuBqjX6kbNj9+vGBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RwMbTUWl6R+peBsNeiS6lk2/5GoObI01O+A0LA0YZSv5xidmnXgSzwsd3ZH51F8eE
	 VKvq0m5AW92m7V+dQIpNd+hhse2lODjF8Am3Ce5uI+eFODCMfxedNBC6qupfTV9tpD
	 Kf49hVibdGrZUkKe+H1U0ZHr/7jNXPj9jV8Pzz2l5NL4wHjCHNcC8mhEi5nCZtMQKl
	 4gHTy+biGeKgg63zxKNzXEu/sBiJL4onzJvBEtF+eQJuS9Qc6s4WSNm/azIkTP7fXi
	 jwYwrk/nogZPkPwz0X6pbQl0BJ5YtuzT4oUUNuIh/K3a/3u4jrj134T4dUmNQTW7b5
	 5xo7yPEPQJrYg==
Subject: [PATCH net-next v2 6/7] SUNRPC: Use new helpers to handle TLS Alerts
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 25 Jul 2023 16:37:56 -0400
Message-ID: 
 <169031746673.15386.5483613200274291252.stgit@oracle-102.nfsv4bat.org>
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

Use the helpers to parse the level and description fields in
incoming alerts. "Warning" alerts are discarded, and "fatal"
alerts mean the session is no longer valid.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c  |   48 ++++++++++++++++++++++++++----------------------
 net/sunrpc/xprtsock.c |   43 ++++++++++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 87bf685f2957..2ed29e40c6a9 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -43,7 +43,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tcp_states.h>
-#include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
@@ -226,27 +226,30 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
 }
 
 static int
-svc_tcp_sock_process_cmsg(struct svc_sock *svsk, struct msghdr *msg,
+svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 			  struct cmsghdr *cmsg, int ret)
 {
-	if (cmsg->cmsg_level == SOL_TLS &&
-	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
-		u8 content_type = *((u8 *)CMSG_DATA(cmsg));
-
-		switch (content_type) {
-		case TLS_RECORD_TYPE_DATA:
-			/* TLS sets EOR at the end of each application data
-			 * record, even though there might be more frames
-			 * waiting to be decrypted.
-			 */
-			msg->msg_flags &= ~MSG_EOR;
-			break;
-		case TLS_RECORD_TYPE_ALERT:
-			ret = -ENOTCONN;
-			break;
-		default:
-			ret = -EAGAIN;
-		}
+	u8 content_type = tls_get_record_type(sock->sk, cmsg);
+	u8 level, description;
+
+	switch (content_type) {
+	case 0:
+		break;
+	case TLS_RECORD_TYPE_DATA:
+		/* TLS sets EOR at the end of each application data
+		 * record, even though there might be more frames
+		 * waiting to be decrypted.
+		 */
+		msg->msg_flags &= ~MSG_EOR;
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		tls_alert_recv(sock->sk, msg, &level, &description);
+		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
+			-ENOTCONN : -EAGAIN;
+		break;
+	default:
+		/* discard this record type */
+		ret = -EAGAIN;
 	}
 	return ret;
 }
@@ -258,13 +261,14 @@ svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
+	struct socket *sock = svsk->sk_sock;
 	int ret;
 
 	msg->msg_control = &u;
 	msg->msg_controllen = sizeof(u);
-	ret = sock_recvmsg(svsk->sk_sock, msg, MSG_DONTWAIT);
+	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
 	if (unlikely(msg->msg_controllen != sizeof(u)))
-		ret = svc_tcp_sock_process_cmsg(svsk, msg, &u.cmsg, ret);
+		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
 	return ret;
 }
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 871f141be96f..268a2cc61acd 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -47,7 +47,7 @@
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <net/tcp.h>
-#include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 
 #include <linux/bvec.h>
@@ -360,24 +360,27 @@ static int
 xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 		     struct cmsghdr *cmsg, int ret)
 {
-	if (cmsg->cmsg_level == SOL_TLS &&
-	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
-		u8 content_type = *((u8 *)CMSG_DATA(cmsg));
-
-		switch (content_type) {
-		case TLS_RECORD_TYPE_DATA:
-			/* TLS sets EOR at the end of each application data
-			 * record, even though there might be more frames
-			 * waiting to be decrypted.
-			 */
-			msg->msg_flags &= ~MSG_EOR;
-			break;
-		case TLS_RECORD_TYPE_ALERT:
-			ret = -ENOTCONN;
-			break;
-		default:
-			ret = -EAGAIN;
-		}
+	u8 content_type = tls_get_record_type(sock->sk, cmsg);
+	u8 level, description;
+
+	switch (content_type) {
+	case 0:
+		break;
+	case TLS_RECORD_TYPE_DATA:
+		/* TLS sets EOR at the end of each application data
+		 * record, even though there might be more frames
+		 * waiting to be decrypted.
+		 */
+		msg->msg_flags &= ~MSG_EOR;
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		tls_alert_recv(sock->sk, msg, &level, &description);
+		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
+			-EACCES : -EAGAIN;
+		break;
+	default:
+		/* discard this record type */
+		ret = -EAGAIN;
 	}
 	return ret;
 }
@@ -777,6 +780,8 @@ static void xs_stream_data_receive(struct sock_xprt *transport)
 	}
 	if (ret == -ESHUTDOWN)
 		kernel_sock_shutdown(transport->sock, SHUT_RDWR);
+	else if (ret == -EACCES)
+		xprt_wake_pending_tasks(&transport->xprt, -EACCES);
 	else
 		xs_poll_check_readable(transport);
 out:



