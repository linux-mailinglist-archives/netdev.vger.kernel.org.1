Return-Path: <netdev+bounces-225234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE66B9041A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E057F3AA1CC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EF303CA3;
	Mon, 22 Sep 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAlpxZjk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61D30146B
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537769; cv=none; b=RViwkZcJ/s5r61BNV9UJbho9LQcOC9aGLt3FEEiGlMlzhMIHUtd1zD9IZe/1EoxO8B7Dj2WkAZAg8z6swe6Oa5mHCIOTq8okvuUQGNhRyBPEF1FbKoJ7xQOQELYtvaNq5YfwLDtYTBy9zsTdGqAgbWSm12mtAQMYNil/RLcCTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537769; c=relaxed/simple;
	bh=kLN4X8qMRT/e/Dih2SudK+B1qWH6yYgnJ2DN40DrkxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BfNzxs4YY0bYUqS9BodDajyHHjPoYuDNpQnFQgJFT1ISF3lkLFD2OtkScWGf3s9fxryT+S3lwucO9hmZ4U56m9xL+9tyFYHAladN/DhMyYwnqnfEQvEIJEtwltn+PImNeFL3mddAIUOQ8Ag9LzJRnUp52XsEGZ8qNAtGJPeJCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAlpxZjk; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-817ecd47971so1025942985a.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758537766; x=1759142566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohTooT7HAUnBY8RWR8dsQblHZTtLaWGaWfmQ2gU+BnI=;
        b=KAlpxZjkB+z4HFAJfN16HYWZlvT19oWYCMWCF/QmtiUE1nu9GEi3n0cLbnhXUXHeFg
         5c7f9OctKzezwR2UxjkeSVLbFmjsmYDzvixlnl15dZ9DuF/pyYahmWEr82ajD32ZXSCi
         N6Mz49b/2vv4veMxzOxD5IGhpANPoT0OIcASVzIbBVdSIN3iFYny0i6RpjHsQ7ZQoEHD
         skusjTvyj70CWDfRxpLN5tLaKfV1SMEbGAQQQc8IpWDs7x/NHS27BMkgV+7yRbmaPwnd
         K58siwHLpHQFBeq18yoRJlzJtA9O9UebdwzCvx38oVkt/6GyJPMQjYXJHWcrvpVcWmZI
         /nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537766; x=1759142566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohTooT7HAUnBY8RWR8dsQblHZTtLaWGaWfmQ2gU+BnI=;
        b=P/xwIbx7Y+DYOxib8M3TZg4gVcVWdLP/28o93OyYi40QwdB572FXxkSeRVARGtJLpR
         7Y6IXRNP8SUlnhBOGOMrUxnq7bHQssDl7dWQUWCbfaKFbqJw0gYOuda+tAWpHmGSIo0m
         kfTDS1u3oHlolDVQ2hQatbPVgnbKHizXf6w3RCiip+1h0P2k9JzrNRKQZYuUm1YbZhYJ
         7ESNnPa1bSHWB1kgdP/HDXT6hfT0DuNyWYXqYPoq09LsM5g/G1Kz0/cuYC3R35zf2kDr
         PMu0b4v3NLR3Lk2tLqk/6+1Z46xjSyydprjtycymo3g7S8P1pu/NaeF3xSjNgMx0SXT1
         0ekw==
X-Forwarded-Encrypted: i=1; AJvYcCXTBDrME8WBRLGWgr7bjjn/izd2uxHEsiOK2hKyqpXcpj1zH9DZOsKbXaSOP17qAZJ+CoEJjKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhq2xxyDIA7dLgr/OADuSy3yC3SI+npd+OXRiNFWVfwDuEIt3j
	aLU+E/NP/zdXtfnQuMFgTwy5Avrk8m7JUjZYeS4mWvUWxHOVTGVw4IgbtcqBmPZMSaCkVDRx+Ka
	ih/MYvJ4Iwc5r2w==
X-Google-Smtp-Source: AGHT+IEseGEQdknQkwK3+moZW42iPmB0S9IVhv5UPqZzZ66MKrYf0F/p2pL6CE22ArzQnTcAAXpPlrTVm5oXGw==
X-Received: from qknvm12.prod.google.com ([2002:a05:620a:718c:b0:844:94f4:636a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a511:b0:836:974d:978e with SMTP id af79cd13be357-836974d995cmr1554584085a.41.1758537766265;
 Mon, 22 Sep 2025 03:42:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:42:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250922104240.2182559-1-edumazet@google.com>
Subject: [PATCH v4 net-next] udp: remove busylock and add per NUMA queues
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

I used a small bpftrace program measuring time (in us) spent in
__udp_enqueue_schedule_skb().

Before:

@udp_enqueue_us[398]:
[0]                24901 |@@@                                                 |
[1]                63512 |@@@@@@@@@                                           |
[2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                |
[8, 16)            54022 |@@@@@@@@                                            |
[16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
[32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
[64, 128)           4219 |                                                    |
[128, 256)           188 |                                                    |

After:

@udp_enqueue_us[398]:
[0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]              1111277 |@@@@@@@@@@                                          |
[2, 4)            501439 |@@@@                                                |
[4, 8)            102921 |                                                    |
[8, 16)            29895 |                                                    |
[16, 32)           43500 |                                                    |
[32, 64)           31552 |                                                    |
[64, 128)            979 |                                                    |
[128, 256)            13 |                                                    |

Note that the remaining bottleneck for this platform is in
udp_drops_inc() because we limited struct numa_drop_counters
to only two nodes so far.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
v4: cache sk_drops_read(), as suggested by Willem.
    This will optimize SOCK_RXQ_OVFL users.

v3: https://lore.kernel.org/netdev/20250921095802.875191-1-edumazet@google.com/
    - Moved kfree(up->udp_prod_queue) to udp_destruct_common(),
      addressing reports from Jakub and syzbot.

    - Perform SKB_DROP_REASON_PROTO_MEM drops after the queue
      spinlock is released.

v2: https://lore.kernel.org/netdev/20250920080227.3674860-1-edumazet@google.com/
    - Added a kfree(up->udp_prod_queue) in udpv6_destroy_sock() (Jakub feedback on v1)
    - Added bpftrace histograms in changelog.

v1: https://lore.kernel.org/netdev/20250919164308.2455564-1-edumazet@google.com/

 include/linux/udp.h |   9 +++-
 include/net/udp.h   |  11 ++++-
 net/ipv4/udp.c      | 117 +++++++++++++++++++++++++++-----------------
 net/ipv6/udp.c      |   5 +-
 4 files changed, 91 insertions(+), 51 deletions(-)

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
index 059a0cee5f559b8d75e71031a00d0aa2769e257f..cffedb3e40f24513e44fb7598c0ad917fd15b616 100644
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
index 85cfc32eb2ccb3e229177fb37910fefde0254ffe..95241093b7f01b2dc31d9520b693f46400e545ff 100644
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
@@ -1718,14 +1699,24 @@ static int udp_rmem_schedule(struct sock *sk, int size)
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
+	struct udp_prod_queue *udp_prod_queue;
+	struct sk_buff *next, *to_drop = NULL;
+	struct llist_node *ll_list;
 	unsigned int rmem, rcvbuf;
-	spinlock_t *busy = NULL;
 	int size, err = -ENOMEM;
+	int total_size = 0;
+	int q_size = 0;
+	int dropcount;
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
@@ -1747,45 +1738,77 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
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
+	dropcount = sock_flag(sk, SOCK_RXQ_OVFL) ? sk_drops_read(sk) : 0;
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
+		if (unlikely(err)) {
+			/*  Free the skbs outside of locked section. */
+			skb->next = to_drop;
+			to_drop = skb;
+			continue;
+		}
+
+		q_size += size;
+		sk_forward_alloc_add(sk, -size);
+
+		/* no need to setup a destructor, we will explicitly release the
+		 * forward allocated memory on dequeue
+		 */
+		SOCK_SKB_CB(skb)->dropcount = dropcount;
+		nb++;
+		__skb_queue_tail(list, skb);
+	}
+
+	atomic_add(q_size, &sk->sk_rmem_alloc);
 
-	__skb_queue_tail(list, skb);
 	spin_unlock(&list->lock);
 
-	if (!sock_flag(sk, SOCK_DEAD))
-		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		/* Multiple threads might be blocked in recvmsg(),
+		 * using prepare_to_wait_exclusive().
+		 */
+		while (nb) {
+			INDIRECT_CALL_1(sk->sk_data_ready,
+					sock_def_readable, sk);
+			nb--;
+		}
+	}
+
+	if (unlikely(to_drop)) {
+		for (nb = 0; to_drop != NULL; nb++) {
+			skb = to_drop;
+			to_drop = skb->next;
+			skb_mark_not_on_list(skb);
+			/* TODO: update SNMP values. */
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
+		}
+		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+	}
 
-	busylock_release(busy);
-	return 0;
+	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
 
-uncharge_drop:
-	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+	return 0;
 
 drop:
 	udp_drops_inc(sk);
-	busylock_release(busy);
 	return err;
 }
 EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
@@ -1803,6 +1826,7 @@ void udp_destruct_common(struct sock *sk)
 		kfree_skb(skb);
 	}
 	udp_rmem_release(sk, total, 0, true);
+	kfree(up->udp_prod_queue);
 }
 EXPORT_IPV6_MOD_GPL(udp_destruct_common);
 
@@ -1814,10 +1838,11 @@ static void udp_destruct_sock(struct sock *sk)
 
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


