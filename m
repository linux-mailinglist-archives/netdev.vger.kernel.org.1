Return-Path: <netdev+bounces-224798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC189B8A9E0
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB01896D14
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9A262FFC;
	Fri, 19 Sep 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8oI/fCq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDB23815B
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300194; cv=none; b=cb8momLt/J6dlZeEBCoMqasU3G4+Gj9ZZlHAXH+EtqjiqTTS70GKCpbGfePrR4phTwo+EUosnXnc3af7wJW/Pw9iY/1wGpJmLNWyoEJFjt469tAInLApuN6s/JdpMslOzSCLg95+E+RK3Gv6pVKugM5tAp0vDoFp1mgXarSTwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300194; c=relaxed/simple;
	bh=zbm3o6Ng68IEa9whdgv13thRvsNX7qiwaOFnLQ8D4DI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nJzCFj1ID/UEHViNOMoZ1jCKRuErnEvo3mmWzaNs/Dy4wZ3+aGefwNlQUOYh62dAaNd1V60h4fX8tDlcsQMDGK4hXd1HSlaccOc4HYvOjrSveaMTg5+jLh//z6HRIJAg76Tnl4HIxyTj5pduIH++8Gm7lVCNtcEcvu6bDRFYAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8oI/fCq; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8163f552e5aso551785185a.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758300191; x=1758904991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rj1j/kniAhzQMyIzqXMbtpvNHeL+/U6/XA35pgEnftQ=;
        b=w8oI/fCqIHB2OQyDC3vrqKa+7ZJpzWjtyhh61i7f8D/QVQUc6OHgnSvfaXP/W6LMKw
         MnehhBZWILeJckJ6NrkEUJYL4agT5stXYnFQnll0NNVJ8XuWgixqvP9R0mN8zH8LBHvh
         bt0XiXp+4GEY+W3LCs4KUEZGc22IQfejp52iSbHiaYEmUjOD8w8UWymgVbw5YgQhghPK
         pFvSqTVB0W4L9csnMOSahyV8c2o2TQ4VxxnLyZI332xf4iBGTK2pn4s1Xozqk/+Th36L
         4i86aMIayJgdCoS0QpH9mWg7Pj458hgSPr7AxSv0IEbxdRZAveekQQNobFh9cOgXIJ2b
         v0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300191; x=1758904991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rj1j/kniAhzQMyIzqXMbtpvNHeL+/U6/XA35pgEnftQ=;
        b=GqV5R79Bb6N+1YhxbhXWxePGxhx+dAJeOQV3Y3oa/HJOtOynDv3IRxsTaoMJaoZpgg
         5WyWrWN5SE7RnDCjIlDft7fTCInSieV0M0MdVxQxZtRHoiV9WPOzi70EX5n4keUwoGeu
         CwHY4RgZGe0+9SYHwb5erHdfFkGnothSOIrOlhZhuOEt63FsfOqUNWu+06/iUkSvW61E
         TQUbY8iOpVst/set6L/bKW0UzglO9aViRK3pGuTulyxhqEhQYvsdfAkhyKrQ5UgNfG+X
         H4cNDLFuOSnBovkcddAa/smAb1SathiCp5/6RPwqdwceE6mq5X2pJz+O0qz1UxQH7qd5
         B3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCV04hs2LGQGjhXhAa9BJ5iYovv08krCpytqykr/DaBqCEW9RKB8k0+3/r3r5NZXNbKNIs2kgSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxx6EmaNW5UM7xPkbxaw0x0QwvdVgpLUeoKHzsLc6tI5rUlIM6
	JNiSg1l8kCVQuzDlua7sFvYmePxTzsHmzuaTQWjNuR/ujWo5OSr3aW79QEIXJkoebQjGyerZ9dX
	rRq6wlELcSBiPtQ==
X-Google-Smtp-Source: AGHT+IGxQSajpAAixwGX0TYGpRgB/bSi3asRMFxsh+Qm7r4KSIFOaGHNz6nn8qI8fTqlKCYotPNwwAYEfXGPRw==
X-Received: from qknqj4.prod.google.com ([2002:a05:620a:8804:b0:827:fe2f:3f45])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2115:b0:803:12:b4d1 with SMTP id af79cd13be357-83bac2c4a6bmr411154985a.64.1758300190798;
 Fri, 19 Sep 2025 09:43:10 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:43:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919164308.2455564-1-edumazet@google.com>
Subject: [PATCH net-next] udp: remove busylock and add per NUMA queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

busylock was protecting UDP sockets against packet floods,
but unfortunately was not protecting the host itself.

Under stress, many cpus could spin while acquiring the busylock,
and NIC had to drop packets. Or packets would be dropped
in cpu backlog if RPS/RFS were in place.

This patch replaces the busylock by intermediate
lockless queues. (One queue per NUMA node).

This means that fewer number of cpus have to acquire
the UDP receive queue lock.

Most of the cpus can either:
- immediately drop the packet.
- or queue it in their NUMA aware lockless queue.

Then one of the cpu is chosen to process this lockless queue
in a batch.

The batch only contains packets that were cooked on the same
NUMA node, thus with very limited latency impact.

Tested:

DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes
(Intel(R) Xeon(R) 6985P-C)

Before:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 1004179            0.0
Udp6InErrors                    3117               0.0
Udp6RcvbufErrors                3117               0.0

After:
nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 1116633            0.0
Udp6InErrors                    14197275           0.0
Udp6RcvbufErrors                14197275           0.0

We can see this host can now proces 14.2 M more packets per second
while under attack, and the victim socket can receive 11 % more
packets.

Note that the remaining bottleneck for this platform is in
udp_drops_inc() because we limited struct numa_drop_counters
to only two nodes so far.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h |  9 ++++-
 include/net/udp.h   | 11 ++++-
 net/ipv4/udp.c      | 99 ++++++++++++++++++++++++---------------------
 net/ipv6/udp.c      |  5 ++-
 4 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index e554890c4415b411f35007d3ece9e6042db7a544..58795688a18636ea79aa1f5d06eacc676a2e7849 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -44,6 +44,12 @@ enum {
 	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
 };
 
+/* per NUMA structure for lockless producer usage. */
+struct udp_prod_queue {
+	struct llist_head	ll_root ____cacheline_aligned_in_smp;
+	atomic_t		rmem_alloc;
+};
+
 struct udp_sock {
 	/* inet_sock has to be the first member */
 	struct inet_sock inet;
@@ -90,6 +96,8 @@ struct udp_sock {
 						struct sk_buff *skb,
 						int nhoff);
 
+	struct udp_prod_queue *udp_prod_queue;
+
 	/* udp_recvmsg try to use this before splicing sk_receive_queue */
 	struct sk_buff_head	reader_queue ____cacheline_aligned_in_smp;
 
@@ -109,7 +117,6 @@ struct udp_sock {
 	 */
 	struct hlist_node	tunnel_list;
 	struct numa_drop_counters drop_counters;
-	spinlock_t		busylock ____cacheline_aligned_in_smp;
 };
 
 #define udp_test_bit(nr, sk)			\
diff --git a/include/net/udp.h b/include/net/udp.h
index eecd64097f91196897f45530540b9c9b68c5ba4e..ae750324bc87a79d0e9182c5589371d82be3e3ee 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -284,16 +284,23 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 				  netdev_features_t features, bool is_ipv6);
 
-static inline void udp_lib_init_sock(struct sock *sk)
+static inline int udp_lib_init_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
 
 	sk->sk_drop_counters = &up->drop_counters;
-	spin_lock_init(&up->busylock);
 	skb_queue_head_init(&up->reader_queue);
 	INIT_HLIST_NODE(&up->tunnel_list);
 	up->forward_threshold = sk->sk_rcvbuf >> 2;
 	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
+
+	up->udp_prod_queue = kcalloc(nr_node_ids, sizeof(*up->udp_prod_queue),
+				     GFP_KERNEL);
+	if (!up->udp_prod_queue)
+		return -ENOMEM;
+	for (int i = 0; i < nr_node_ids; i++)
+		init_llist_head(&up->udp_prod_queue[i].ll_root);
+	return 0;
 }
 
 static inline void udp_drops_inc(struct sock *sk)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0c40426628eb2306b609881341a51307c4993871..f2d95fe18aec8f317ab33b4ed3306149fce6690b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1685,25 +1685,6 @@ static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
 	udp_rmem_release(sk, udp_skb_truesize(skb), 1, true);
 }
 
-/* Idea of busylocks is to let producers grab an extra spinlock
- * to relieve pressure on the receive_queue spinlock shared by consumer.
- * Under flood, this means that only one producer can be in line
- * trying to acquire the receive_queue spinlock.
- */
-static spinlock_t *busylock_acquire(struct sock *sk)
-{
-	spinlock_t *busy = &udp_sk(sk)->busylock;
-
-	spin_lock(busy);
-	return busy;
-}
-
-static void busylock_release(spinlock_t *busy)
-{
-	if (busy)
-		spin_unlock(busy);
-}
-
 static int udp_rmem_schedule(struct sock *sk, int size)
 {
 	int delta;
@@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, int size)
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
+	struct udp_prod_queue *udp_prod_queue;
+	struct llist_node *ll_list;
 	unsigned int rmem, rcvbuf;
-	spinlock_t *busy = NULL;
 	int size, err = -ENOMEM;
+	struct sk_buff *next;
+	int total_size = 0;
+	int q_size = 0;
+	int nb = 0;
 
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
 
+	udp_prod_queue = &udp_sk(sk)->udp_prod_queue[numa_node_id()];
+
+	rmem += atomic_read(&udp_prod_queue->rmem_alloc);
+
 	/* Immediately drop when the receive queue is full.
 	 * Cast to unsigned int performs the boundary check for INT_MAX.
 	 */
@@ -1747,45 +1737,60 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	if (rmem > (rcvbuf >> 1)) {
 		skb_condense(skb);
 		size = skb->truesize;
-		rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
-		if (rmem > rcvbuf)
-			goto uncharge_drop;
-		busy = busylock_acquire(sk);
-	} else {
-		atomic_add(size, &sk->sk_rmem_alloc);
 	}
 
 	udp_set_dev_scratch(skb);
 
+	atomic_add(size, &udp_prod_queue->rmem_alloc);
+
+	if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
+		return 0;
+
 	spin_lock(&list->lock);
-	err = udp_rmem_schedule(sk, size);
-	if (err) {
-		spin_unlock(&list->lock);
-		goto uncharge_drop;
-	}
 
-	sk_forward_alloc_add(sk, -size);
+	ll_list = llist_del_all(&udp_prod_queue->ll_root);
 
-	/* no need to setup a destructor, we will explicitly release the
-	 * forward allocated memory on dequeue
-	 */
-	sock_skb_set_dropcount(sk, skb);
+	ll_list = llist_reverse_order(ll_list);
+
+	llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
+		size = udp_skb_truesize(skb);
+		total_size += size;
+		err = udp_rmem_schedule(sk, size);
+		if (err) {
+			udp_drops_inc(sk);
+			// TODO update SNMP values.
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
+			continue;
+		}
+
+		q_size += size;
+		sk_forward_alloc_add(sk, -size);
+
+		/* no need to setup a destructor, we will explicitly release the
+		 * forward allocated memory on dequeue
+		 */
+		sock_skb_set_dropcount(sk, skb);
+		nb++;
+		__skb_queue_tail(list, skb);
+	}
+
+	atomic_add(q_size, &sk->sk_rmem_alloc);
 
-	__skb_queue_tail(list, skb);
 	spin_unlock(&list->lock);
 
-	if (!sock_flag(sk, SOCK_DEAD))
-		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
 
-	busylock_release(busy);
-	return 0;
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		while (nb) {
+			INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+			nb--;
+		}
+	}
 
-uncharge_drop:
-	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	return 0;
 
 drop:
 	udp_drops_inc(sk);
-	busylock_release(busy);
 	return err;
 }
 EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
@@ -1814,10 +1819,11 @@ static void udp_destruct_sock(struct sock *sk)
 
 int udp_init_sock(struct sock *sk)
 {
-	udp_lib_init_sock(sk);
+	int res = udp_lib_init_sock(sk);
+
 	sk->sk_destruct = udp_destruct_sock;
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
-	return 0;
+	return res;
 }
 
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
@@ -2906,6 +2912,7 @@ void udp_destroy_sock(struct sock *sk)
 			udp_tunnel_cleanup_gro(sk);
 		}
 	}
+	kfree(up->udp_prod_queue);
 }
 
 typedef struct sk_buff *(*udp_gro_receive_t)(struct sock *sk,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9f4d340d1e3a63d38f80138ef9f6aac4a33afa05..813a2ba75824d14631642bf6973f65063b2825cb 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -67,10 +67,11 @@ static void udpv6_destruct_sock(struct sock *sk)
 
 int udpv6_init_sock(struct sock *sk)
 {
-	udp_lib_init_sock(sk);
+	int res = udp_lib_init_sock(sk);
+
 	sk->sk_destruct = udpv6_destruct_sock;
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
-	return 0;
+	return res;
 }
 
 INDIRECT_CALLABLE_SCOPE
-- 
2.51.0.470.ga7dc726c21-goog


