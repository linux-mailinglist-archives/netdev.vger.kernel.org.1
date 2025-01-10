Return-Path: <netdev+bounces-157032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9098A08C0F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17AC7A321E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB220A5E4;
	Fri, 10 Jan 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ex0dNZcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8485209F38
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501414; cv=none; b=gBPLSyllbxh4Ompt8wFUWcV6Wv6QPzTowD4Q2zVCa0i88jsaZWVoyyL4AU5QASAv7xME5J4Vh4A23ujevwuSvj6wXs2cF2C6w+Qr9ZceIFQw6GYl16ZvX9uDrRIgN3oqEhcQq20Nko/GmaJ/GFrll9GdyOLqKw/Znf686rJweeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501414; c=relaxed/simple;
	bh=xT4XRrxCb/VGArLZh51hm11TmE5zQ6NNQWzATlNQdwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnBv87H2tSYIyB2CiSc90iohjzuoZlJrG4YRmUMWP9Rlc8jA+ldl6PONO/MUkuaf23hLQzWWUF8LYDYnVu3DY3+UpWvtGYMVavZkHCnJPqmV+dLmNyTW35r+JCy6J0h0UPqUCpao+JG3ri1ZspHJ31F8lwampGEuMQOIc+IYzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ex0dNZcl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501413; x=1768037413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/PxlOJHunfq5Qyeg2TKAnZcJ1aS74/HChKuENexILO8=;
  b=ex0dNZcl/t6oZZ8oBzA69XZPnL2BtZCLunz2BarQ8R0i6YmByLbEnLo0
   CL8z/baCii2kCEaymzXnZ9/XHruaEsTKQIVJOOaoYkmyVjlBfjI3FHav8
   BQZttFHAAdIPfxb7G9GKiMTyVu8zU5AOyhAXhK6c0iL1YS2tm+Fqr9RVR
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="163180613"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:30:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:12565]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.73:2525] with esmtp (Farcaster)
 id dfa61a1e-d74a-4538-94b1-cd68d97b1151; Fri, 10 Jan 2025 09:30:10 +0000 (UTC)
X-Farcaster-Flow-ID: dfa61a1e-d74a-4538-94b1-cd68d97b1151
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/12] af_unix: Set drop reason in unix_stream_sendmsg().
Date: Fri, 10 Jan 2025 18:26:36 +0900
Message-ID: <20250110092641.85905-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
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

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h |  6 +++++
 net/unix/af_unix.c            | 41 ++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 6 deletions(-)

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
index 6505eeab9957..17b9e9bce055 100644
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
@@ -2249,6 +2265,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len)
 {
+	enum skb_drop_reason reason;
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb = NULL;
 	struct sock *other = NULL;
@@ -2314,8 +2331,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		/* Only send the fds in the first buffer */
 		err = unix_scm_to_skb(&scm, skb, !fds_sent);
-		if (err < 0)
+		if (err < 0) {
+			reason = unix_scm_err_to_reason(err);
 			goto out_free;
+		}
 
 		fds_sent = true;
 
@@ -2323,8 +2342,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
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
@@ -2333,15 +2354,23 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
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
 			goto out_pipe_unlock;
+		}
+
+		if (other->sk_shutdown & RCV_SHUTDOWN) {
+			reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
+			goto out_pipe_unlock;
+		}
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2371,7 +2400,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
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


