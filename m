Return-Path: <netdev+bounces-218390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8CBB3C468
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054585805FC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A427054B;
	Fri, 29 Aug 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvSEvIJl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3519261B9A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504606; cv=none; b=PAgKtbmk99Qmv9D8F64bTLYF7AgcQnEFjxfAcFTcTBQgXoerbINnE15eoVi1mcY+gmnKCDs+xpEZP0NqZiTSKy42KrsyMabwrF4URrnz7W3UdqT4V3p79Gts5H3QMxB6rQq2QUW9bm9mD3GXCXS/xx7TGuXUi4c5YDfDsQirrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504606; c=relaxed/simple;
	bh=GIbwBBbcac3XCzW2Gux+FN/MnrZGr1wA2l3inZn3L6Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gu0xnpT6bE9ASfEpOBzapWdRGfonTTIe8IE0GvYmLYG0O6L9DIA5To1KO3k2t9gExTHo3XaW6Gds4BqxNUldPKDRrl8EDV3TgSK153cdEg6xou7Nl/7g3MoPIlm3aIzOvAND87h+o3ZjTIVkrzVw0z5OiaV75maWTyttH3Ykoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvSEvIJl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246f49067bdso25629035ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504604; x=1757109404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuB625VJn6WBEgaZx7WOFuBv9B0QBQM3XnzgoAXT5Ck=;
        b=NvSEvIJl1bVIk2FP1kdcPW4i8RPqLKlcmjJAcSw9ZO0MdgHEcIq+VYBIlK5bkap8t+
         ZcfKJ7hBhmq9F3FqLf2eEKm3QxguAxWd0/JMRI4ITKMkdmNzvhTwMB5F1ebOWe7GBtTK
         PMfGOPJ+CP2rddBy0sqocERe/9Kfz8SP+eqd95fumYN9NWuTm5SP2/rjDtmR+KcLQHLi
         70mzdQT8Xi56F+4fVUi5ZHFRU5x5F28z7pHuTedEWaPMVT1WVp104GgbyoCXmDtIoe03
         FZlMGyuSLwYSeQT3f6lzTOvnJX3lXxvRPSDFCMfrMnK3SGwOpMrLs+yd15ILnWvurRPE
         PnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504604; x=1757109404;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuB625VJn6WBEgaZx7WOFuBv9B0QBQM3XnzgoAXT5Ck=;
        b=Y9B/TIjsvLayku4+e5c6yFanIXZCBAWUfR4GJIdcan34BzqoyWi696KBq9UOUCgmsL
         ro+WBsdIK3UmexjRwd7oJfAJML8Wbk8jM0QU+vDHSWaTKDhki6/BVs5xE76K9gporsZR
         uNERnPPEZpH7TZBgV8Bstz7m0Ua5g5i/s2OAotc5qqXr9aw0sHn8SzoqLQdS1hjIyleq
         QACaE92MosU5hgkkPOnsHKM1GmtguVlPT8PYdca8fmo3Uhi+H/HHze8t8Gr3xf4LznSO
         FZ6yK6bqdXVo8tPhALaSqZzuN8RrxtQa2JJzq9VXvObgXhc8Fs3KPD2AO3+tY64l+bLe
         S32A==
X-Forwarded-Encrypted: i=1; AJvYcCWz66c/0wHzWAqvanbrLP4EFa8eqK7nGLiIBqJJtV/ieYbFM+T7SrCy1hwZAKl6h4YQGQ8h8bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6grVTGx1686pGyT1sZ/eOnQWTXgCKRZNn0dL+0NoOfapeJ//
	zhejPdtPo31Zu7X2IFIyQXE+6jR8qXH6ZLvGX1qhkt/mZy6U+aFS+qscqKd2Mro4ES/qD9FZ0IZ
	s+l0+rA==
X-Google-Smtp-Source: AGHT+IFD3y4gGV90L1R1RhC4T9B5hEINisNZMPxJUHt/my5onPEo72hgFJLGDCkSj8cLUCLyX27YBt1NSKI=
X-Received: from pjbsp13.prod.google.com ([2002:a17:90b:52cd:b0:327:e57c:38aa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf09:b0:248:df64:ec6a
 with SMTP id d9443c01a7336-24944a27103mr1655525ad.15.1756504603877; Fri, 29
 Aug 2025 14:56:43 -0700 (PDT)
Date: Fri, 29 Aug 2025 21:56:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829215641.711664-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tcp: Remove sk->sk_prot->orphan_count.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TCP tracks the number of orphaned (SOCK_DEAD but not yet destructed)
sockets in tcp_orphan_count.

In some code that was shared with DCCP, tcp_orphan_count is referenced
via sk->sk_prot->orphan_count.

Let's reference tcp_orphan_count directly.

inet_csk_prepare_for_destroy_sock() is moved to inet_connection_sock.c
due to header dependency.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.c   |  4 ++--
 .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.h   |  1 -
 include/net/inet_connection_sock.h                    |  8 +-------
 include/net/sock.h                                    |  2 --
 include/net/tcp.h                                     | 10 ++++++++++
 net/ipv4/inet_connection_sock.c                       | 11 +++++++++--
 net/ipv4/inet_hashtables.c                            |  2 +-
 net/ipv4/tcp.c                                        |  2 +-
 net/ipv4/tcp_ipv4.c                                   |  1 -
 net/ipv6/tcp_ipv6.c                                   |  1 -
 10 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 000116e47e38..4ee970f3bad6 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -505,7 +505,7 @@ static void reset_listen_child(struct sock *child)
 
 	chtls_send_reset(child, CPL_ABORT_SEND_RST, skb);
 	sock_orphan(child);
-	INC_ORPHAN_COUNT(child);
+	tcp_orphan_count_inc();
 	if (child->sk_state == TCP_CLOSE)
 		inet_csk_destroy_sock(child);
 }
@@ -870,7 +870,7 @@ static void do_abort_syn_rcv(struct sock *child, struct sock *parent)
 		 * created only after 3 way handshake is done.
 		 */
 		sock_orphan(child);
-		INC_ORPHAN_COUNT(child);
+		tcp_orphan_count_inc();
 		chtls_release_resources(child);
 		chtls_conn_done(child);
 	} else {
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
index 667effc2a23c..29ceff5a5fcb 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
@@ -95,7 +95,6 @@ struct deferred_skb_cb {
 #define WSCALE_OK(tp) ((tp)->rx_opt.wscale_ok)
 #define TSTAMP_OK(tp) ((tp)->rx_opt.tstamp_ok)
 #define SACK_OK(tp) ((tp)->rx_opt.sack_ok)
-#define INC_ORPHAN_COUNT(sk) this_cpu_inc(*(sk)->sk_prot->orphan_count)
 
 /* TLS SKB */
 #define skb_ulp_tls_inline(skb)      (ULP_SKB_CB(skb)->ulp.tls.ofld)
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 1735db332aab..0737d8e178dd 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -299,14 +299,8 @@ reqsk_timeout(struct request_sock *req, unsigned long max_timeout)
 	return (unsigned long)min_t(u64, timeout, max_timeout);
 }
 
-static inline void inet_csk_prepare_for_destroy_sock(struct sock *sk)
-{
-	/* The below has to be done to allow calling inet_csk_destroy_sock */
-	sock_set_flag(sk, SOCK_DEAD);
-	this_cpu_inc(*sk->sk_prot->orphan_count);
-}
-
 void inet_csk_destroy_sock(struct sock *sk);
+void inet_csk_prepare_for_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
 
 /*
diff --git a/include/net/sock.h b/include/net/sock.h
index 0dbc3cbe1b47..e79c04f7220b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1359,8 +1359,6 @@ struct proto {
 	unsigned int		useroffset;	/* Usercopy region offset */
 	unsigned int		usersize;	/* Usercopy region size */
 
-	unsigned int __percpu	*orphan_count;
-
 	struct request_sock_ops	*rsk_prot;
 	struct timewait_sock_ops *twsk_prot;
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 16dc9cebb9d2..0fb7923b8367 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -54,6 +54,16 @@ extern struct inet_hashinfo tcp_hashinfo;
 DECLARE_PER_CPU(unsigned int, tcp_orphan_count);
 int tcp_orphan_count_sum(void);
 
+static inline void tcp_orphan_count_inc(void)
+{
+	this_cpu_inc(tcp_orphan_count);
+}
+
+static inline void tcp_orphan_count_dec(void)
+{
+	this_cpu_dec(tcp_orphan_count);
+}
+
 DECLARE_PER_CPU(u32, tcp_tw_isn);
 
 void tcp_time_wait(struct sock *sk, int state, int timeo);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d..142ff8d86fc2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1296,12 +1296,19 @@ void inet_csk_destroy_sock(struct sock *sk)
 
 	xfrm_sk_free_policy(sk);
 
-	this_cpu_dec(*sk->sk_prot->orphan_count);
+	tcp_orphan_count_dec();
 
 	sock_put(sk);
 }
 EXPORT_SYMBOL(inet_csk_destroy_sock);
 
+void inet_csk_prepare_for_destroy_sock(struct sock *sk)
+{
+	/* The below has to be done to allow calling inet_csk_destroy_sock */
+	sock_set_flag(sk, SOCK_DEAD);
+	tcp_orphan_count_inc();
+}
+
 /* This function allows to force a closure of a socket after the call to
  * tcp_create_openreq_child().
  */
@@ -1369,7 +1376,7 @@ static void inet_child_forget(struct sock *sk, struct request_sock *req,
 
 	sock_orphan(child);
 
-	this_cpu_inc(*sk->sk_prot->orphan_count);
+	tcp_orphan_count_inc();
 
 	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(req)->tfo_listener) {
 		BUG_ON(rcu_access_pointer(tcp_sk(child)->fastopen_rsk) != req);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ff47303fe7e0..b880b7a0dd73 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -707,7 +707,7 @@ bool inet_ehash_nolisten(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ok) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	} else {
-		this_cpu_inc(*sk->sk_prot->orphan_count);
+		tcp_orphan_count_inc();
 		inet_sk_set_state(sk, TCP_CLOSE);
 		sock_set_flag(sk, SOCK_DEAD);
 		inet_csk_destroy_sock(sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9bc8317e92b7..40b774b4f587 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3195,7 +3195,7 @@ void __tcp_close(struct sock *sk, long timeout)
 	/* remove backlog if any, without releasing ownership. */
 	__release_sock(sk);
 
-	this_cpu_inc(tcp_orphan_count);
+	tcp_orphan_count_inc();
 
 	/* Have we already been destroyed by a softirq or backlog? */
 	if (state != TCP_CLOSE && sk->sk_state == TCP_CLOSE)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7c1d612afca1..1e58a8a9ff7a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3517,7 +3517,6 @@ struct proto tcp_prot = {
 	.leave_memory_pressure	= tcp_leave_memory_pressure,
 	.stream_memory_free	= tcp_stream_memory_free,
 	.sockets_allocated	= &tcp_sockets_allocated,
-	.orphan_count		= &tcp_orphan_count,
 
 	.memory_allocated	= &net_aligned_data.tcp_memory_allocated,
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b4e56b877273..07ba32156770 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2353,7 +2353,6 @@ struct proto tcpv6_prot = {
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
 
 	.memory_pressure	= &tcp_memory_pressure,
-	.orphan_count		= &tcp_orphan_count,
 	.sysctl_mem		= sysctl_tcp_mem,
 	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_wmem),
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
-- 
2.51.0.318.gd7df087d1a-goog


