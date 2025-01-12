Return-Path: <netdev+bounces-157494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69822A0A724
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E773A5D98
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454E1EA73;
	Sun, 12 Jan 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OJnwVFdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399A6FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655074; cv=none; b=Gz5c8cIpJTLrXcUOGdpXV/OsHF3q0bUGYZzPWsw6BNzx5i7iFxfnRoeTU4D0B6F+kd9VJUnPje4wO19Lx+CDWQW9lap2QP4CSFJDkNf5jTXt9mWQj2shoLHpeITxGDnqaB4WLMjWIBcoCX1n4Mu2BLvBxz5e3yHt2VtZhBguhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655074; c=relaxed/simple;
	bh=cQ1G3C2OcrFaEoFueeDlrVp+yfV5Cviip3JgUG/ojig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5Q2S2+IfzBrDqemjK/YQHD9ANCMGlpbu+a+3hKEDvJIYIiAdCbo5sevahilTD6BFsWj0F5XYT+FMn7OT67LR2szvN9DqGgHrgEZ/lkk4kgsOFQ4GbJb07xGyjBU+I9knYecogwytDZ+0u+8OZLV4EiOoSjZ/cwshwuZl/ESY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OJnwVFdV; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655073; x=1768191073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yq25I1r294buJuzBOSq9Xu6ix7QkaDslqAR9CMz5uFw=;
  b=OJnwVFdV7vrU77tjTr/c+K8wHRaCbu7OOtfkB5PGHoUmqywJjnSSUVVu
   YpHkDQ0F3X1QlKmoA3QotIyPYvXyu5YmjRUiIBPsY9tG0/K9ND7k12W7v
   XSCXT2qpN6XPht0i64MW/wrF7bz0Ov/jXpe6h7fNYTFqgXgvBe9/Wxyrs
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="710225674"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:11:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 7ce7da8c-0e25-4314-93d5-7caf79c96d30; Sun, 12 Jan 2025 04:11:08 +0000 (UTC)
X-Farcaster-Flow-ID: 7ce7da8c-0e25-4314-93d5-7caf79c96d30
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/11] af_unix: Set drop reason in unix_stream_sendmsg().
Date: Sun, 12 Jan 2025 13:08:05 +0900
Message-ID: <20250112040810.14145-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sendmsg() to a SOCK_STREAM socket could fail for various reasons.

Let's set drop reasons respectively.

  * NOMEM                  : Failed to allocate SCM_RIGHTS-related structs
  * UNIX_INFLIGHT_FD_LIMIT : The number of inflight fd reached RLIMIT_NOFILE
  * SKB_UCOPY_FAULT        : Failed to copy data from iov_iter to skb
  * SOCKET_CLOSE           : The peer socket was close()d
  * SOCKET_RCV_SHUTDOWN    : The peer socket called shutdown(SHUT_RD)

unix_scm_err_to_reason() will be reused in queue_oob() and
unix_dgram_sendmsg().

While at it, size and data_len are moved to the while loop scope.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h |  6 +++++
 net/unix/af_unix.c            | 50 +++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 1b5e962f7f33..dea6bbe3ceaa 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -11,6 +11,7 @@
 	FN(SOCKET_INVALID_STATE)	\
 	FN(SOCKET_RCVBUFF)		\
 	FN(SOCKET_RCV_SHUTDOWN)		\
+	FN(UNIX_INFLIGHT_FD_LIMIT)	\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(UDP_CSUM)			\
@@ -150,6 +151,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/** @SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN: socket is shutdown(SHUT_RD) */
 	SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN,
+	/**
+	 * @SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT: too many file descriptors
+	 * are passed via SCM_RIGHTS but not yet received, reaching RLIMIT_NOFILE.
+	 */
+	SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b190ea8b8e9d..8c8d8fc3cb94 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1907,6 +1907,22 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
+static enum skb_drop_reason unix_scm_err_to_reason(int err)
+{
+	switch (err) {
+	case -ENOMEM:
+		return SKB_DROP_REASON_NOMEM;
+	case -ETOOMANYREFS:
+		return SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT;
+	}
+
+	DEBUG_NET_WARN_ONCE(1,
+			    "Define a drop reason for %d in unix_scm_to_skb().",
+			    err);
+
+	return SKB_DROP_REASON_NOT_SPECIFIED;
+}
+
 static bool unix_passcred_enabled(const struct socket *sock,
 				  const struct sock *other)
 {
@@ -2249,14 +2265,13 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len)
 {
+	enum skb_drop_reason reason;
 	struct sock *sk = sock->sk;
 	struct sock *other = NULL;
-	int err, size;
-	struct sk_buff *skb;
-	int sent = 0;
 	struct scm_cookie scm;
 	bool fds_sent = false;
-	int data_len;
+	struct sk_buff *skb;
+	int err, sent = 0;
 
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
@@ -2294,7 +2309,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	while (sent < len) {
-		size = len - sent;
+		int size = len - sent;
+		int data_len;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb = sock_alloc_send_pskb(sk, 0, 0,
@@ -2320,8 +2336,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		/* Only send the fds in the first buffer */
 		err = unix_scm_to_skb(&scm, skb, !fds_sent);
-		if (err < 0)
+		if (err < 0) {
+			reason = unix_scm_err_to_reason(err);
 			goto out_free;
+		}
 
 		fds_sent = true;
 
@@ -2329,8 +2347,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
 						   sk->sk_allocation);
-			if (err < 0)
+			if (err < 0) {
+				reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
 				goto out_free;
+			}
 
 			size = err;
 			refcount_add(size, &sk->sk_wmem_alloc);
@@ -2339,15 +2359,23 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			skb->data_len = data_len;
 			skb->len = size;
 			err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
-			if (err)
+			if (err) {
+				reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
 				goto out_free;
+			}
 		}
 
 		unix_state_lock(other);
 
-		if (sock_flag(other, SOCK_DEAD) ||
-		    (other->sk_shutdown & RCV_SHUTDOWN))
+		if (sock_flag(other, SOCK_DEAD)) {
+			reason = SKB_DROP_REASON_SOCKET_CLOSE;
+			goto out_pipe;
+		}
+
+		if (other->sk_shutdown & RCV_SHUTDOWN) {
+			reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
 			goto out_pipe;
+		}
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2376,7 +2404,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
 out_free:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 out_err:
 	scm_destroy(&scm);
 	return sent ? : err;
-- 
2.39.5 (Apple Git-154)


