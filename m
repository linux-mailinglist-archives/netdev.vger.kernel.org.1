Return-Path: <netdev+bounces-22009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3884F765A88
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693CE1C216A1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78202715E;
	Thu, 27 Jul 2023 17:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A127155;
	Thu, 27 Jul 2023 17:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBE6C433C7;
	Thu, 27 Jul 2023 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690479468;
	bh=QaNK9hk2HpOQmQAQ7sH5iMshAw6ApAwr/mrgE8tyYQc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tRoiLLVMXly4eqj26fqrlSPgpYTbRlwTX0aXEhPukriBEKoAW3TM8qHfHR6qMInAI
	 CD3GIIUtdswdVhBp++nFRL9IF3Q/msH+GwlWKtOqjjWnc2UGTmyhe2GyQo7NN8oiTW
	 gTEZpvzmoI+7r+fWqOV72oZDAOUv2PM4vTiGcjB9AFG5EYuBYJs9BmblWUSCQYu3Cp
	 hQh/a6eFP6fEpSug1AkuLoVXYhdGN4YH0o3jw9bLV6TTO8EVsMbex4N3Dq+RmfoQ2O
	 4vdqSKHpoR3LbVWgAA03duo01FZxP/dvNUHJemAW4PjxM6R3ewmKkogN8alMoqdQR6
	 lNsa7EmUUaI7A==
Subject: [PATCH net-next v3 6/7] SUNRPC: Use new helpers to handle TLS Alerts
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Thu, 27 Jul 2023 13:37:37 -0400
Message-ID: 
 <169047944747.5241.1974889594004407123.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
References: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
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
 net/sunrpc/svcsock.c  |   47 +++++++++++++++++++++++++----------------------
 net/sunrpc/xprtsock.c |   42 +++++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cca6ee716020..2ed29e40c6a9 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -43,7 +43,6 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tcp_states.h>
-#include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/uaccess.h>
@@ -227,27 +226,30 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
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
@@ -259,13 +261,14 @@ svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
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
index 5096aa62de5c..268a2cc61acd 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -47,7 +47,6 @@
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <net/tcp.h>
-#include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
 
@@ -361,24 +360,27 @@ static int
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
@@ -778,6 +780,8 @@ static void xs_stream_data_receive(struct sock_xprt *transport)
 	}
 	if (ret == -ESHUTDOWN)
 		kernel_sock_shutdown(transport->sock, SHUT_RDWR);
+	else if (ret == -EACCES)
+		xprt_wake_pending_tasks(&transport->xprt, -EACCES);
 	else
 		xs_poll_check_readable(transport);
 out:



