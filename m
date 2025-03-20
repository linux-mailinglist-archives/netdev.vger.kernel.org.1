Return-Path: <netdev+bounces-176443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27DA6A615
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C2B17DDE3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780C21E0BE;
	Thu, 20 Mar 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyllKpO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4A1F869E
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472968; cv=none; b=Ar8nrO+Py9U3b2Whm3JWXa27oWNyIZS24CJXCqBxW8Kmh2/RWftzrbr+W3xLG1WZ6i/wAJrXUB8RPwbgZMGjlspuyQwKjzWCJw1idDIWvaARQIFUn5SXj9Kd70JYVlJ7lUFqiE9dIQ/5sJ7mSAHWBSbxDi4jOCldwh/tYHoJlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472968; c=relaxed/simple;
	bh=QmXLmzVrRpcdEvWJDNkqXWwMmSed/ELuoRrpAH730fM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gzFqpowwXqymqeKUPCS/C4GSIpIFkvPWWT1C0Kq8r6I3TT0F0JQPYZy/de66YkMYFrIa5KZ52OUvt8fStkYnK9Y0XuHdhCkRDhrBDCuXXb50ziPshakOW+u6IowrKgNonGb3zFEkX+u+5kG8o+rwVgLPsjUNIVuB/sW1RUV/1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyllKpO5; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e9083404b7so13885196d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742472966; x=1743077766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+EDx1LIjYwJL+kHiqVtNHYA+3RtWkPI5Ty6spRvXCVI=;
        b=VyllKpO5tW4rFWtXso3DRFwOPVomLWjnH9SQ0uvkQwY/cwJ8mK6ZjtgQ/lQIjziHwm
         74ei4WIAlg90l6jxzfelu3aFBjqwvuQ5gWrgUGnRDWktOvbAnX27oNycCre2KJJOLcxa
         V5NxpDwQCs9YgZjpgmE3pbvA1vzB9oIPEXQ11uybr65hjuh0BXBdu2T3fUC+VrJqBiq5
         285VN/Uz5fQUpIb4BlzV41CfbI00mrjG5yB4gSdUaLSECa8OhX1A1+2tVUuokLMJ+OUo
         9Uqv63EL0ldR4johO2lLTZoWcmfprGnSkz5ii1JeEVgmLlcynLu0jmOg7MJgGPTFiNoI
         1TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742472966; x=1743077766;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EDx1LIjYwJL+kHiqVtNHYA+3RtWkPI5Ty6spRvXCVI=;
        b=KKaHcggXguBLY6gAJfWF1re85GKqdKwaHhETwxsSzdWlqWeeNUIfp2kpGP2kzEGO88
         OhgMSk2VM3PjoCjS/6MNIYt66H0wDKPYsBoVj1alifFrUNnCxrq1W0ub0dOKI3MSqXgB
         g8+tShTo3/LZtQqGVjoPNzeMSaFYDYsRWUZGDZQCUz4aA2VgoA7IkhXIsxd2F7ZBuCv8
         D8CKCpUTCyliIjE0lk9BxT48C+TUYqnASocGCTeHxfRlBcsTKBh5UjTOqEHzQgRT5s4c
         qZt7awJLk4frNrlRC16gQRrk6h2WDxRgIsElcbvO+z74WoK2iwaMeEdUY1Izl0Pxoqke
         4+jw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+3cIHe2izVA0nR0RFMWk+buZoCiBPUqr7iCXkkUudlLgFSas4CmdPgM5aTTXNT41hlXBcCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhpKV2hPlhcZ+fk4+FqCf0sQIMmuKVaK5Ishyd7XsFBwZqpUr
	0epNnPEhLA7FRfwasZX4Pdtn7W6dEvD/azIjD3CNyIu/NCd2bdtJzsjvJK1dZrRUzxwEIs+W2Bi
	CYkU/M3dgGg==
X-Google-Smtp-Source: AGHT+IGu5AU+MQT8Ooub0nCRcTNVliY5sT+ndgPzzTWGds3C28W4mQpztRyunTg2HArLQ6sbEdJFR9RxIc4kOA==
X-Received: from qvbqp9.prod.google.com ([2002:a05:6214:5989:b0:6e8:e874:5753])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29e7:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6eb35370ddcmr37640436d6.44.1742472965846;
 Thu, 20 Mar 2025 05:16:05 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:16:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320121604.3342831-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: avoid atomic operations on sk->sk_rmem_alloc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP uses generic skb_set_owner_r() and sock_rfree()
for received packets, with socket lock being owned.

Switch to private versions, avoiding two atomic operations
per packet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h       | 15 +++++++++++++++
 net/ipv4/tcp.c          | 18 ++++++++++++++++--
 net/ipv4/tcp_fastopen.c |  2 +-
 net/ipv4/tcp_input.c    |  6 +++---
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d08fbf90495de69b157d3c87c50e82d781a365df..dd6d63a6f42b99774e9461b69d3e7932cf629082 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -779,6 +779,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rfree(struct sk_buff *skb);
 
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
@@ -2898,4 +2899,18 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+/* version of skb_set_owner_r() avoiding one atomic_add() */
+static inline void tcp_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
+{
+	skb_orphan(skb);
+	skb->sk = sk;
+	skb->destructor = tcp_sock_rfree;
+
+	sock_owned_by_me(sk);
+	atomic_set(&sk->sk_rmem_alloc,
+		   atomic_read(&sk->sk_rmem_alloc) + skb->truesize);
+
+	sk_forward_alloc_add(sk, -skb->truesize);
+}
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 989c3c3d8e757361a0ac4a9f039a3cfca10d9612..b1306038b8e6e8c55fd1b4803c5d8ca626491aae 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1525,11 +1525,25 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	__tcp_cleanup_rbuf(sk, copied);
 }
 
+/* private version of sock_rfree() avoiding one atomic_sub() */
+void tcp_sock_rfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+	unsigned int len = skb->truesize;
+
+	sock_owned_by_me(sk);
+	atomic_set(&sk->sk_rmem_alloc,
+		   atomic_read(&sk->sk_rmem_alloc) - len);
+
+	sk_forward_alloc_add(sk, len);
+	sk_mem_reclaim(sk);
+}
+
 static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	__skb_unlink(skb, &sk->sk_receive_queue);
-	if (likely(skb->destructor == sock_rfree)) {
-		sock_rfree(skb);
+	if (likely(skb->destructor == tcp_sock_rfree)) {
+		tcp_sock_rfree(skb);
 		skb->destructor = NULL;
 		skb->sk = NULL;
 		return skb_attempt_defer_free(skb);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 1a6b1bc5424514e27a99cbb2fcedf001afd51d98..ca40665145c692ce0de518886bb366406606f7ac 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -189,7 +189,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	tcp_segs_in(tp, skb);
 	__skb_pull(skb, tcp_hdrlen(skb));
 	sk_forced_mem_schedule(sk, skb->truesize);
-	skb_set_owner_r(skb, sk);
+	tcp_skb_set_owner_r(skb, sk);
 
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 72382ee4456dbd89fd1b69f3bdbf6b9c8ef5aa78..cac6e86196975cc793f499126302fc5220a1dfc7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5171,7 +5171,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		if (tcp_is_sack(tp))
 			tcp_grow_window(sk, skb, false);
 		skb_condense(skb);
-		skb_set_owner_r(skb, sk);
+		tcp_skb_set_owner_r(skb, sk);
 	}
 }
 
@@ -5187,7 +5187,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
 		tcp_add_receive_queue(sk, skb);
-		skb_set_owner_r(skb, sk);
+		tcp_skb_set_owner_r(skb, sk);
 	}
 	return eaten;
 }
@@ -5504,7 +5504,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
-		skb_set_owner_r(nskb, sk);
+		tcp_skb_set_owner_r(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
 		/* Copy data, releasing collapsed skbs. */
-- 
2.49.0.rc1.451.g8f38331e32-goog


