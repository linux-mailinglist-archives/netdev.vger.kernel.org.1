Return-Path: <netdev+bounces-259085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJfOG2OTlGl3FgIAu9opvQ
	(envelope-from <netdev+bounces-259085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:12:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3D14DEEB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C39653009B0E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD436E460;
	Tue, 17 Feb 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED0eagEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C836D4E0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344734; cv=none; b=HnqfTrU7woDnD9yLBdZmXnBzmrQ8hxX9C1Leyg39G0pzikvLg+2lyQ3iXR3hdSUnNExwAyMnv27ZdKCo8PIuQiOJh1HHe4vjwGONry8B37XKKltYyR4XUfQHdsLGftchNDgKOau9Abimo9ba6AwVp2SzBpdSWYeT09upJ9qS8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344734; c=relaxed/simple;
	bh=va5IQmUOeukDdY+Smw7NVB8ZT0GBNgJGhbtfiGxrM9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ypfhr2hVT5x16ryAGHfIzWP3SrzNLTCNiH/a8swcpzxNLS8IBqQyDdf2A224Pko5GpfwxD/0yyX/skI4elmy1FROGgae6qfiDslvjmsW8OEdL5rVz0kGqsu5KV+F9w3IGVBpbCis3YerI0mchA3z/N6C86ep/K41oKsnYYsq9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED0eagEX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70ab7f67fso4324706085a.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771344732; x=1771949532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmseZ8mhA4Y9pMCincHkiIN77VZDfky12cUI2X3jfK0=;
        b=ED0eagEXaYUiSn5yvNHkRuUaCwK/o1KbLdeELAymjTErwJlCydSTgm6Q476E7bbbyp
         PE2qnwxRz1Xpw6e+7slw+8X6FClDbxfYTUL9mNLfdPe3ASd5nbfoRyogbpsyRJJ1Vn1A
         MJDrOGDqzRymtEvOZxlcgK5HeZPvHIO8WGc4uHRMiwIDv3CpG/jYqdMRHGmJ5zPNMGjQ
         8ZUnZ63eUFWuRVw+tTGEZrksp+LNZ/A+jP5NyH5mg/zIjI/gweJMc1EUC7mkpKHuJpcU
         H5djmw0cG8Rw6XHFp6PC1J6PrvsidIDJlpnO4Br/pRBRr4dGJPUL/5AqIJbiHyC3BKvg
         l7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344732; x=1771949532;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmseZ8mhA4Y9pMCincHkiIN77VZDfky12cUI2X3jfK0=;
        b=iuyfMCeQEYZ6m95tj/FqTQpeGxuDGcgxjJfQRyyLzx/Onwtbb/lMi26Ua6vQ5fS+7a
         6uZ9ZyqPaO/wvqXb2ntAJVyejQ9bRoM0uvsCldLYCxUOGcd84LbGz/9Vj3C0WHLGEuvq
         WZtepbs6LxQ/1QNRGRv6IAiQyAReQwWxxjoKBOEc/YQqFaeGk9UoRBhnfEO0ACmlW3vu
         UqCnQ66vKV4iIBcQr+RRyUK4p1do3yFzSWjZ+B0kXf8PACu03raR2/9jNJThAnNiV4fw
         wu5p2+REJN8+dKxEYC1ys/3vqyzJP0bMtux1BOLXxMyExe0TVWyQYLXjSSEz9SKXmAyn
         GTMw==
X-Forwarded-Encrypted: i=1; AJvYcCVXNuFY9qHi/Wf7fUKt17qGh5IfPleRd1hbQRHIxkeej5L1DEg4yXGEmzjEaprebtUl6iCvudc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsMETUhkDJBKSW0nnmFJT0WwSfQYx6TVE/QXrV2SMbN2jCwUG
	2XxORRK6JLaZFnjmEaHEsqJeos8o0mSHUfmXw9UO8Fot86kDlYvEXKZFRslzvbVPaLfYVaQflpt
	tJcR9oJyfpfrfJQ==
X-Received: from qkntr13.prod.google.com ([2002:a05:620a:2d8d:b0:8cb:4c74:5ab9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4494:b0:8c5:3256:2f3c with SMTP id af79cd13be357-8cb4c0147d5mr1415282185a.55.1771344731555;
 Tue, 17 Feb 2026 08:12:11 -0800 (PST)
Date: Tue, 17 Feb 2026 16:12:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217161205.2079883-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix potential race in tcp_v6_syn_recv_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259085-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,937b5bbb6a815b3e5d0b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2E3D14DEEB
X-Rspamd-Action: no action

Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
is done too late.

After tcp_v4_syn_recv_sock(), the child socket is already visible
from TCP ehash table and other cpus might use it.

Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
bad things can happen as syzbot found.

Move the problematic code in tcp_v6_mapped_child_init()
and call this new helper from tcp_v4_syn_recv_sock() before
the ehash insertion.

This allows the removal of one tcp_sync_mss(), since
tcp_v4_syn_recv_sock() will call it with the correct
context.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h |  4 +-
 include/net/tcp.h                  |  4 +-
 net/ipv4/syncookies.c              |  2 +-
 net/ipv4/tcp_fastopen.c            |  2 +-
 net/ipv4/tcp_ipv4.c                |  8 ++-
 net/ipv4/tcp_minisocks.c           |  2 +-
 net/ipv6/tcp_ipv6.c                | 98 +++++++++++++-----------------
 net/mptcp/subflow.c                |  6 +-
 net/smc/af_smc.c                   |  6 +-
 9 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ecb362025c4e5183ec78aef4b45c249da87c19ea..5cb3056d6ddc7cb9489131f503b32f3dac211bec 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -42,7 +42,9 @@ struct inet_connection_sock_af_ops {
 				      struct request_sock *req,
 				      struct dst_entry *dst,
 				      struct request_sock *req_unhash,
-				      bool *own_req);
+				      bool *own_req,
+				      void (*opt_child_init)(struct sock *newsk,
+							     const struct sock *sk));
 	u16	    net_header_len;
 	int	    (*setsockopt)(struct sock *sk, int level, int optname,
 				  sockptr_t optval, unsigned int optlen);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..eb8bf63fdafc3243469f293fd06aef0ce086c5a4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -544,7 +544,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req);
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk));
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 569befcf021ba5598e57ee3256843c141aeb412b..061751aabc8e16c5d536a19f7b920d1bca2b0f4f 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -203,7 +203,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						 NULL, &own_req);
+						 NULL, &own_req, NULL);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
 		sock_rps_save_rxhash(child, skb);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index b30090cff3cf7d925dc46694860abd3ca5516d70..df803f088f454cf157e0efbba8e2ff3f6d205530 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -333,7 +333,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	bool own_req;
 
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 NULL, &own_req);
+							 NULL, &own_req, NULL);
 	if (!child)
 		return NULL;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6264fc0b2be53854598d7c37ce1c7928d2e0b507..2980c175d326b6c6ebd4acba0c4333f481617579 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1705,7 +1705,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req)
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	bool found_dup_sk = false;
@@ -1757,6 +1759,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	}
 	sk_setup_caps(newsk, dst);
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (opt_child_init)
+		opt_child_init(newsk, sk);
+#endif
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ec128865f5c029c971eb00cb9ee058b742efafd1..d9c5a43bd2818c17d79d8433ac5dd2bdd199b812 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -925,7 +925,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	 * socket is created, wait for troubles.
 	 */
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 req, &own_req);
+							 req, &own_req, NULL);
 	if (!child)
 		goto listen_overflow;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d10487b4e5bff87d4ff2a7b912a826964101a163..e46a0efae01235ae7430ed268b92cb47309b8d28 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1312,11 +1312,48 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
 		sizeof(struct inet6_skb_parm));
 }
 
+/* Called from tcp_v4_syn_recv_sock() for v6_mapped children. */
+static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
+{
+	struct inet_sock *newinet = inet_sk(newsk);
+	struct ipv6_pinfo *newnp;
+
+	newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
+	newinet->ipv6_fl_list = NULL;
+
+	memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
+
+	newnp->saddr = newsk->sk_v6_rcv_saddr;
+
+	inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
+	if (sk_is_mptcp(newsk))
+		mptcpv6_handle_mapped(newsk, true);
+	newsk->sk_backlog_rcv = tcp_v4_do_rcv;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+	tcp_sk(newsk)->af_specific = &tcp_sock_ipv6_mapped_specific;
+#endif
+
+	newnp->ipv6_mc_list = NULL;
+	newnp->ipv6_ac_list = NULL;
+	newnp->pktoptions  = NULL;
+	newnp->opt	   = NULL;
+
+	/* tcp_v4_syn_recv_sock() has initialized newinet->mc_{index,ttl} */
+	newnp->mcast_oif   = newinet->mc_index;
+	newnp->mcast_hops  = newinet->mc_ttl;
+
+	newnp->rcv_flowinfo = 0;
+	if (inet6_test_bit(REPFLOW, sk))
+		newnp->flow_label = 0;
+}
+
 static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 					 struct request_sock *req,
 					 struct dst_entry *dst,
 					 struct request_sock *req_unhash,
-					 bool *own_req)
+					 bool *own_req,
+					 void (*opt_child_init)(struct sock *newsk,
+								const struct sock *sk))
 {
 	const struct ipv6_pinfo *np = tcp_inet6_sk(sk);
 	struct inet_request_sock *ireq;
@@ -1332,61 +1369,10 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 #endif
 	struct flowi6 fl6;
 
-	if (skb->protocol == htons(ETH_P_IP)) {
-		/*
-		 *	v6 mapped
-		 */
-
-		newsk = tcp_v4_syn_recv_sock(sk, skb, req, dst,
-					     req_unhash, own_req);
-
-		if (!newsk)
-			return NULL;
-
-		newinet = inet_sk(newsk);
-		newinet->pinet6 = tcp_inet6_sk(newsk);
-		newinet->ipv6_fl_list = NULL;
-
-		newnp = tcp_inet6_sk(newsk);
-		newtp = tcp_sk(newsk);
-
-		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-
-		newnp->saddr = newsk->sk_v6_rcv_saddr;
-
-		inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
-		if (sk_is_mptcp(newsk))
-			mptcpv6_handle_mapped(newsk, true);
-		newsk->sk_backlog_rcv = tcp_v4_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-		newtp->af_specific = &tcp_sock_ipv6_mapped_specific;
-#endif
-
-		newnp->ipv6_mc_list = NULL;
-		newnp->ipv6_ac_list = NULL;
-		newnp->pktoptions  = NULL;
-		newnp->opt	   = NULL;
-		newnp->mcast_oif   = inet_iif(skb);
-		newnp->mcast_hops  = ip_hdr(skb)->ttl;
-		newnp->rcv_flowinfo = 0;
-		if (inet6_test_bit(REPFLOW, sk))
-			newnp->flow_label = 0;
-
-		/*
-		 * No need to charge this sock to the relevant IPv6 refcnt debug socks count
-		 * here, tcp_create_openreq_child now does this for us, see the comment in
-		 * that function for the gory details. -acme
-		 */
-
-		/* It is tricky place. Until this moment IPv4 tcp
-		   worked with IPv6 icsk.icsk_af_ops.
-		   Sync it now.
-		 */
-		tcp_sync_mss(newsk, inet_csk(newsk)->icsk_pmtu_cookie);
-
-		return newsk;
-	}
-
+	if (skb->protocol == htons(ETH_P_IP))
+		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
+					    req_unhash, own_req,
+					    tcp_v6_mapped_child_init);
 	ireq = inet_rsk(req);
 
 	if (sk_acceptq_is_full(sk))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f66129f1e649248e00215d254c925f66c3fffa6a..8b25dd86ffeb668b98fd41026fb084dab7dc23b8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -808,7 +808,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  void (*opt_child_init)(struct sock *newsk,
+								 const struct sock *sk))
 {
 	struct mptcp_subflow_context *listener = mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
@@ -855,7 +857,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 create_child:
 	child = listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						     req_unhash, own_req);
+						     req_unhash, own_req, opt_child_init);
 
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(child);
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d8201eb3ac5f3d87a15f385862c4ae82ae3a24ff..18c56b0d7ad531e575266ad7f38187973422151f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -124,7 +124,9 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  void (*opt_child_init)(struct sock *newsk,
+								 const struct sock *sk))
 {
 	struct smc_sock *smc;
 	struct sock *child;
@@ -142,7 +144,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 
 	/* passthrough to original syn recv sock fct */
 	child = smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
-					       own_req);
+					       own_req, opt_child_init);
 	/* child must not inherit smc or its ops */
 	if (child) {
 		rcu_assign_sk_user_data(child, NULL);
-- 
2.53.0.310.g728cabbaf7-goog


