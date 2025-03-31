Return-Path: <netdev+bounces-178257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38493A760B6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566501888831
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F741C5D4E;
	Mon, 31 Mar 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3qY9BXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA17083C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407996; cv=none; b=D7uMgAM7YhLuNobDWCP6kPDZWBj5tcMOQTn9PGgGAv2wEf+V7xYM9491x5pWAKl9dxyUZyQTeKe5GrSYLa0XCIjEbot+4fYjiWJYx38j31u/ecvRWA0fP/YBb7JVsdcz37eg6NRDlcRXV2Y/nIe1pvMxQgFu4lQY1C2bYyNehgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407996; c=relaxed/simple;
	bh=Zk5zm2C3bg0Ci1xNcIXMleySnerXShrcl/JW3f6P4wo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GOwZ5rNV6EXJ2BujG5Fjj/BCYMiLOozGfeAnLkdE7NlCc6S1fqpXTznOma85K6hjp8OxD7AT83OjPzHOteoqUBNL93Y0+XJXz1FMj+RQuJGr5jGBhZ0k2sZ2kvw34qDI/FCKCF+YU84jFXYdrHcGyN/x34+8G9BJ6qxLkHxpTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3qY9BXL; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4769273691dso79387851cf.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743407991; x=1744012791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pSaHw7+7pp4TGXvaWxerphGGl9LOneJTVXKMOlHKAyM=;
        b=g3qY9BXL13ZUpcMXRRawlNGPm6GPbMaNzRaziNL164EEnEPNr4eEPNshL0ccMTBvm2
         5Vh5NeK1cwvacyyD16ttIUun9lX76NbfGsk+0mqaJRqErnduMgRwCeNyZj+faKSLSz/g
         0vgPtvdTS7ldYVVzboGOQn0tX72/q93ymh1pgnYTRnlBl9kmjBo6LFZjBL0NVCoJ9d5P
         ICtvHW5C6tJ4EoPaaNRUb1S60JW9LNCpWbDw/v6FWBBcdQOwXF17ndciK0KD06NkUr6K
         Z6+wiMUSR1znir2VfxrSGRrViM2q+qIF4JZ2z+q24wFCGE2G13tjhpIZnIuIlglTqhmG
         Hhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743407991; x=1744012791;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSaHw7+7pp4TGXvaWxerphGGl9LOneJTVXKMOlHKAyM=;
        b=bmgmQ9IDVyfRRkhh3FBPTgKJftx74ZMzN0Eo1bV8X4PjGob/a4yy1VRU8zjxpqR5ow
         LgfJtTqcJ4ZoTtbPH8dBCNREnZK8LhqeIBNCEkMC4jKHKv6tb+YkbigLHQjiTF0GiB9P
         hAxRbGzxaO2V1PEHF6GbalYus/ZJJ4YLgYgofca3llkTxDW2HOoXqCkI4LwhZkK1kwRr
         YkGPNcLMIkmhPJEV398lbxFJLZgHmgRjt7+2X4/yo+fk3oR/cAnu7JVGywAB1OWxaJzV
         cDOfE0xPbn7J5cDIsk89/zU5vk+Co6HcG9/JKnOof3j7x2/+H0kg3EfIfFTb4xJd1UZu
         3i1A==
X-Forwarded-Encrypted: i=1; AJvYcCXYwMOChaOGPB0r9WYt1//2eBMH8tzK83JJ/TE1hfA8kIQuOXlFj0piARG/Gw+kzqbSUCd1ceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNSqCHM3Inul7/z6fYLhnpvcDpBTZT2BF47ZqAEwIGC4ACuDt
	DBS6rJg4MXq3oLOfG/pus6yZhUAJm/y9bvU+msFGk/CMuv2KQC5je820N1M52JE+PlOCGw2QsAa
	+NjsSoZsGrQ==
X-Google-Smtp-Source: AGHT+IHMJRKNTM5kfVhRn4RblysqB5zEQIunU7dsps7ZXL8apK6+c1uwRRG1ClX4BOAFvIA20P5pKy90iAqMdA==
X-Received: from qtbhg20.prod.google.com ([2002:a05:622a:6114:b0:476:7b50:740])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d44:0:b0:476:b7e2:385c with SMTP id d75a77b69052e-477e4b1e81cmr100827071cf.2.1743407991376;
 Mon, 31 Mar 2025 00:59:51 -0700 (PDT)
Date: Mon, 31 Mar 2025 07:59:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331075946.31960-1-edumazet@google.com>
Subject: [PATCH net] Revert "tcp: avoid atomic operations on sk->sk_rmem_alloc"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 0de2a5c4b824da2205658ebebb99a55c43cdf60f.

I forgot that a TCP socket could receive messages in its error queue.

sock_queue_err_skb() can be called without socket lock being held,
and changes sk->sk_rmem_alloc.

The fact that skbs in error queue are limited by sk->sk_rcvbuf
means that error messages can be dropped if socket receive
queues are full, which is an orthogonal issue.

In future kernels, we could use a separate sk->sk_error_mem_alloc
counter specifically for the error queue.

Fixes: 0de2a5c4b824 ("tcp: avoid atomic operations on sk->sk_rmem_alloc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h       | 15 ---------------
 net/ipv4/tcp.c          | 18 ++----------------
 net/ipv4/tcp_fastopen.c |  2 +-
 net/ipv4/tcp_input.c    |  6 +++---
 4 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index df04dc09c519d850579e22a17f49eeec7d22c607..4450c384ef178e860bd76c23653e9ce9d7a7289b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -779,7 +779,6 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
-void tcp_sock_rfree(struct sk_buff *skb);
 
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
@@ -2899,18 +2898,4 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
-/* version of skb_set_owner_r() avoiding one atomic_add() */
-static inline void tcp_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
-{
-	skb_orphan(skb);
-	skb->sk = sk;
-	skb->destructor = tcp_sock_rfree;
-
-	sock_owned_by_me(sk);
-	atomic_set(&sk->sk_rmem_alloc,
-		   atomic_read(&sk->sk_rmem_alloc) + skb->truesize);
-
-	sk_forward_alloc_add(sk, -skb->truesize);
-}
-
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ea8de00f669d059d97766529e3b8c53d5040456d..6edc441b37023de48281aa810aa7a36199fd8bc3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1525,25 +1525,11 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	__tcp_cleanup_rbuf(sk, copied);
 }
 
-/* private version of sock_rfree() avoiding one atomic_sub() */
-void tcp_sock_rfree(struct sk_buff *skb)
-{
-	struct sock *sk = skb->sk;
-	unsigned int len = skb->truesize;
-
-	sock_owned_by_me(sk);
-	atomic_set(&sk->sk_rmem_alloc,
-		   atomic_read(&sk->sk_rmem_alloc) - len);
-
-	sk_forward_alloc_add(sk, len);
-	sk_mem_reclaim(sk);
-}
-
 static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	__skb_unlink(skb, &sk->sk_receive_queue);
-	if (likely(skb->destructor == tcp_sock_rfree)) {
-		tcp_sock_rfree(skb);
+	if (likely(skb->destructor == sock_rfree)) {
+		sock_rfree(skb);
 		skb->destructor = NULL;
 		skb->sk = NULL;
 		return skb_attempt_defer_free(skb);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index ca40665145c692ce0de518886bb366406606f7ac..1a6b1bc5424514e27a99cbb2fcedf001afd51d98 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -189,7 +189,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	tcp_segs_in(tp, skb);
 	__skb_pull(skb, tcp_hdrlen(skb));
 	sk_forced_mem_schedule(sk, skb->truesize);
-	tcp_skb_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
 
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e1f952fbac48dfdc4f4f75a50a85b4904b93bbe2..a35018e2d0ba27b14d0b59d3728f7181b1a51161 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5171,7 +5171,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		if (tcp_is_sack(tp))
 			tcp_grow_window(sk, skb, false);
 		skb_condense(skb);
-		tcp_skb_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 	}
 }
 
@@ -5187,7 +5187,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
 		tcp_add_receive_queue(sk, skb);
-		tcp_skb_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 	}
 	return eaten;
 }
@@ -5504,7 +5504,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
-		tcp_skb_set_owner_r(nskb, sk);
+		skb_set_owner_r(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
 		/* Copy data, releasing collapsed skbs. */
-- 
2.49.0.472.ge94155a9ec-goog


