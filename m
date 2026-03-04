Return-Path: <netdev+bounces-263606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIh5CunTp2nNkAAAu9opvQ
	(envelope-from <netdev+bounces-263606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:40:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BB1FB422
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D9730F7FDA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E133806A8;
	Wed,  4 Mar 2026 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfDP4xHP"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB3381AF4
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606309; cv=none; b=VReWhW5xhHX0lkBc3hOUhQCsl3W/Zxctu3k9gh6s2T87pBtMIfVaFMlXhtVMViDERY1Rky00y9LS/inD9y9IHr7EwlGszONxzgWjIOj0k6upAiyvNrkwHbDtwYmagUJmHG+ebS8ExDCZ5vXYyFN7RSIIGGjcb7nGTfkDL6z3wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606309; c=relaxed/simple;
	bh=rnvgDuIM8vQ4Ur2khkq6Tdvxz0lxrQhZ/hIDvNzyy0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWjLn4xdOtux9Owtmo6MnqOhSxTje9eVr7jSW/SZlYp1e50JdYIACQkGpX5i6PQxoWob+L6125E18uJH2Y1X3cmDRvK6FHYdnPXeeqjJbBxJR+NbrXDDcuU+GhK/rVveTzTAu+S0ie4C8PJkj+tgJBKQz+rLsbp5A6TWQCIRrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfDP4xHP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOpTXC80TFbvx4uT0sZN6YnfWzBhPWN4KMs+EKSr7jQ=;
	b=xfDP4xHPEXKJwwyYAnMNy7mgd5Pd43uM7Ho6f2jDCU6ljHy6Gj141uHst5V5g4l6/XC/7S
	J1Jf33ygGa0eJtR7tct3MO1tBTXJ032HyyW+jflHGZL5MidbafqtCEJRPM3ew3bNXPezn+
	OY6J7HrtubuC74j7W3yDI4MIh2/2ma0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 3/7] tcp_bpf: refactor recvmsg with read actor abstraction
Date: Wed,  4 Mar 2026 14:33:54 +0800
Message-ID: <20260304063643.14581-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BE2BB1FB422
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Refactor the read operation with no functional changes.

tcp_bpf has two read paths: strparser and non-strparser. Currently
the differences are implemented directly in their respective recvmsg
functions, which works fine. However, upcoming splice support would
require duplicating the same logic for both paths. To avoid this,
extract the strparser-specific differences into an independent
abstraction that can be reused by splice.

For ingress_msg data processing, introduce a function pointer
callback approach. The current implementation passes
sk_msg_recvmsg_actor(), which performs copy_page_to_iter() - the
same copy logic previously embedded in sk_msg_recvmsg(). This
provides the extension point for future splice support, where a
different actor can be plugged in.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  12 ++++-
 net/core/skmsg.c      |  24 +++++++--
 net/ipv4/tcp_bpf.c    | 123 ++++++++++++++++++++++++++++--------------
 3 files changed, 112 insertions(+), 47 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f9..d53756914b2f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -143,8 +143,16 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes);
 int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
-int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
-		     int len, int flags, int *copied_from_self);
+typedef int (*sk_msg_read_actor_t)(void *arg, struct page *page,
+				   unsigned int offset, size_t len);
+/* Core function for reading ingress_msg, dispatches to the given actor */
+int sk_msg_read_core(struct sock *sk, struct sk_psock *psock,
+		     size_t len, int flags,
+		     sk_msg_read_actor_t actor, void *actor_arg,
+		     int *copied_from_self);
+int sk_msg_recvmsg_actor(void *arg, struct page *page,
+			 unsigned int offset, size_t len);
+
 bool sk_msg_is_readable(struct sock *sk);
 
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2e26174c9919..6a906bfe3aa4 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -409,10 +409,12 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 
-int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
-		     int len, int flags, int *copied_from_self)
+/* Core function for reading ingress_msg, dispatches to the given actor */
+int sk_msg_read_core(struct sock *sk, struct sk_psock *psock,
+		     size_t len, int flags,
+		     sk_msg_read_actor_t actor, void *actor_arg,
+		     int *copied_from_self)
 {
-	struct iov_iter *iter = &msg->msg_iter;
 	int peek = flags & MSG_PEEK;
 	struct sk_msg *msg_rx;
 	int i, copied = 0;
@@ -440,7 +442,8 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copied + copy > len)
 				copy = len - copied;
 			if (copy)
-				copy = copy_page_to_iter(page, sge->offset, copy, iter);
+				copy = actor(actor_arg, page,
+					     sge->offset, copy);
 			if (!copy) {
 				copied = copied ? copied : -EFAULT;
 				goto out;
@@ -495,12 +498,23 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 out:
 	return copied;
 }
+EXPORT_SYMBOL_GPL(sk_msg_read_core);
+
+int sk_msg_recvmsg_actor(void *arg, struct page *page,
+			 unsigned int offset, size_t len)
+{
+	struct msghdr *msg = arg;
+
+	return copy_page_to_iter(page, offset, len, &msg->msg_iter);
+}
+EXPORT_SYMBOL_GPL(sk_msg_recvmsg_actor);
 
 /* Receive sk_msg from psock->ingress_msg to @msg. */
 int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags)
 {
-	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
+	return sk_msg_read_core(sk, psock, len, flags,
+				sk_msg_recvmsg_actor, msg, NULL);
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
 
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index c449a044895e..606c2b079f86 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -218,31 +218,26 @@ static bool is_next_msg_fin(struct sk_psock *psock)
 	return false;
 }
 
-static int tcp_bpf_recvmsg_parser(struct sock *sk,
-				  struct msghdr *msg,
-				  size_t len,
-				  int flags,
-				  int *addr_len)
+/*
+ * __tcp_bpf_recvmsg_parser - inner recvmsg for strparser path
+ *
+ * Handles TCP seq tracking, pre-accept receive_queue draining, FIN detection,
+ * and receive window updates. The actual data read is delegated to @actor.
+ *
+ * Caller must hold a psock ref. Socket lock is acquired/released internally.
+ * Returns bytes read, or negative error.
+ */
+static int __tcp_bpf_recvmsg_parser(struct sock *sk, struct sk_psock *psock,
+				    sk_msg_read_actor_t actor, void *actor_arg,
+				    size_t len, int flags)
 {
 	int peek = flags & MSG_PEEK;
-	struct sk_psock *psock;
-	struct tcp_sock *tcp;
+	struct tcp_sock *tcp = tcp_sk(sk);
 	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
 
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
-
-	if (!len)
-		return 0;
-
-	psock = sk_psock_get(sk);
-	if (unlikely(!psock))
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
-
 	lock_sock(sk);
-	tcp = tcp_sk(sk);
 	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
@@ -264,7 +259,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 
 msg_bytes_ready:
-	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
+	copied = sk_msg_read_core(sk, psock, len, flags,
+				  actor, actor_arg, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
 	 * shutdown with a FIN pkt. So check here the other case is
 	 * some error on copy_page_to_iter which would be unexpected.
@@ -329,10 +325,34 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 unlock:
 	release_sock(sk);
-	sk_psock_put(sk, psock);
 	return copied;
 }
 
+static int tcp_bpf_recvmsg_parser(struct sock *sk,
+				  struct msghdr *msg,
+				  size_t len,
+				  int flags,
+				  int *addr_len)
+{
+	struct sk_psock *psock;
+	int ret;
+
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
+	if (!len)
+		return 0;
+
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock))
+		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+
+	ret = __tcp_bpf_recvmsg_parser(sk, psock,
+				       sk_msg_recvmsg_actor, msg, len, flags);
+	sk_psock_put(sk, psock);
+	return ret;
+}
+
 static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 {
 	bool slow;
@@ -351,29 +371,25 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
-static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-			   int flags, int *addr_len)
+/*
+ * __tcp_bpf_recvmsg - inner recvmsg for non-parser (verdict only) path
+ *
+ * No TCP seq tracking needed (tcp_eat_skb handles it at verdict time).
+ * Returns bytes read, 0 if caller should fall back to the normal TCP
+ * read path (data on receive_queue but not in psock), or negative error.
+ *
+ * Caller must hold a psock ref. Socket lock is acquired/released internally.
+ */
+static int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
+			     sk_msg_read_actor_t actor, void *actor_arg,
+			     size_t len, int flags)
 {
-	struct sk_psock *psock;
 	int copied, ret;
 
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
-
-	if (!len)
-		return 0;
-
-	psock = sk_psock_get(sk);
-	if (unlikely(!psock))
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
-	if (!skb_queue_empty(&sk->sk_receive_queue) &&
-	    sk_psock_queue_empty(psock)) {
-		sk_psock_put(sk, psock);
-		return tcp_recvmsg(sk, msg, len, flags, addr_len);
-	}
 	lock_sock(sk);
 msg_bytes_ready:
-	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	copied = sk_msg_read_core(sk, psock, len, flags,
+				  actor, actor_arg, NULL);
 	if (!copied) {
 		long timeo;
 		int data;
@@ -388,8 +404,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
 			release_sock(sk);
-			sk_psock_put(sk, psock);
-			return tcp_recvmsg(sk, msg, len, flags, addr_len);
+			return 0;
 		}
 		copied = -EAGAIN;
 	}
@@ -397,7 +412,35 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 unlock:
 	release_sock(sk);
+	return ret;
+}
+
+static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			   int flags, int *addr_len)
+{
+	struct sk_psock *psock;
+	int ret;
+
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
+	if (!len)
+		return 0;
+
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock))
+		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+	if (!skb_queue_empty(&sk->sk_receive_queue) &&
+	    sk_psock_queue_empty(psock)) {
+		sk_psock_put(sk, psock);
+		return tcp_recvmsg(sk, msg, len, flags, addr_len);
+	}
+
+	ret = __tcp_bpf_recvmsg(sk, psock, sk_msg_recvmsg_actor, msg,
+				len, flags);
 	sk_psock_put(sk, psock);
+	if (!ret)
+		return tcp_recvmsg(sk, msg, len, flags, addr_len);
 	return ret;
 }
 
-- 
2.43.0


