Return-Path: <netdev+bounces-225124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D137FB8EC43
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA173B1921
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31317A2EC;
	Mon, 22 Sep 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKcF5FL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246F15624D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507668; cv=none; b=M74FbzNyW5vhdRw5c2FY2825HGHcpemSXbjS64+6EKsGWWU7HOOP0WWIaYk1wscxySn0mlkc+H6hN2ULdW9BuAJO99PdkD3ofinMRCTQlJKiEpSqX1GpzQ4YMxDdHWtVjcfCVl5jRFwc7700sXK2UM9HaJDC69G0Mbb2OBD2H0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507668; c=relaxed/simple;
	bh=kmPYsjvVDU56tWD2s3M5G4cijGFo0DikIG9/dJ5WLLc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DaSFSDYJDCBGV7LEsKjyPDiBqI2Jq1B+UhVHbvNbKJ21xv9kjzvBKtY2XdCzqdbngNL4wspm0ZHWaT16JiQYPxEXhmzSx5NQk1NIUQh8hGF1QJxHmHGkBNA2DUHvbQC+lzJvVY74qHdr/gec2L9JDJhB9aLu1RAnVnMamSPUsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myKcF5FL; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54a81bf36ebso1275669e0c.3
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 19:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758507665; x=1759112465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TrzAQP2zULlvN2dLBwTtbPsKWCW1AgEN6wqJJcES8Y=;
        b=myKcF5FL4nWte2+20sGiLNMTk6ELuAATwQ0W1iW033jNGIDU7I5eBlzv1TXE6/iUS7
         ZODHxtNWl1lzFMdj35JLXkezIshsosrlLS/4J8zdSFwOeStVHEQSVH39yREjiN/cDKPM
         Q9fbsvpHgtBDphK6Ix5o5/J+OSwJwKwT39GXpvl7P+FCGFe6BtkKQAN0jILV+ETpDQN7
         gt4padDlAEPyb/IWUv2cxi2gTPkqNtBBeYZOqwhDMB8u2FzAPLbyaRC7I6bpJlMaHKs6
         ijbEhoACUx41+U2hHQXlQu4Y4jB/Qm46dM4OUZnDoeZNX1Tet8ZcKXfhIVKYJvDhAhrR
         Tqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507665; x=1759112465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4TrzAQP2zULlvN2dLBwTtbPsKWCW1AgEN6wqJJcES8Y=;
        b=vTSUD9cnrXNIHfqIXpSkqNsimFb+JKoy9KkIlDdAtWqWW9FNRwNtHWVoHI5ZXW9xIe
         DxcIlvZiKrByjhjH1xBwlpzzGFMGc+HlOp0j7xp2As5DID4wwT4B78v4tOxb1BeAZZhr
         5qvN8g2zu3gdii5ySFVcaJXmNDti+afBBLvzJ0IOTgRmxwwzr7aHGEiey1slewG9CvuJ
         5jvrln1Q65f2vGKjhp11ORdqV5P79kf0nrN8qKZNMCTiqTh6iaytSgFH8fy2iU1BbOYE
         yNDVYZMwoaxhYWHHmZ6nT3yhVXRWWf5FZMOCDSg6caxtSGTNHyN0rfBhXlsrgnV8rtnC
         lNZg==
X-Forwarded-Encrypted: i=1; AJvYcCV44I8qeZi8RciZwGc2u+dFhEXLh5FZ3EFrcDeUmioC0JN3o7Hlt47S1Zc/YgYKyrcA7LpdtgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwxGdlwa89q+y+PyrrvmR14jgHwxzt4eCx+kjkWm/GGvk4wI3
	wqz7kYSjQJELnk5HMWTRF7Rkh4wkF+XjD4/F2uoAickwvvuyGAe25aZT
X-Gm-Gg: ASbGnctrYo0uukO1XLxjlZNCynRy/+5BBdp4uPaZl+dqOE3hBD4KpiGCW9Q4EttqdDm
	YIwLJQOrFVxCClrEllanp9J4yTU9r4hk9ZuAK4n5PiSPz2nzmimYSRZICCxcHed8szYuTdLrZMU
	mgT8nJNNlfwT7+sgri8M65qoa7imiXA/OLVxLAVyCjSp3Ze6q98VDOfr5IXv9qfd2VYZywsxA9L
	RAurL8ypZgpL9aGH9gPWb/9A3BVnLhXtKXO5lfftaM54TO0IX8xxzKDapZVhIXj6OVauOM2bu9w
	jGiM57FgFdOcUFRxGvI9vbW/NW/zXcYDKd1a+NVoxvciVMJ/oID1zPFGzWN6+BANXn+6s+i2jhk
	2/CeKN/dLyGJcfia67yeWj9xfuCmNPvKah5fcQflMjrluxNq9QlRKahRdgdciTyD4A/rfvA==
X-Google-Smtp-Source: AGHT+IFG2CMWFSADGyBObgS2k3VUMNhwSWBElAHiDzoayYKY1p+JPUFgF92z8IsGvpnfzGv+OIt33g==
X-Received: by 2002:a05:6122:35c3:b0:54a:89b1:2fbb with SMTP id 71dfb90a1353d-54a89b13c08mr2392062e0c.11.1758507665330;
        Sun, 21 Sep 2025 19:21:05 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54bbc96cd18sm203911e0c.4.2025.09.21.19.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 19:21:04 -0700 (PDT)
Date: Sun, 21 Sep 2025 22:21:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.1fae2e81b156b@gmail.com>
In-Reply-To: <20250921095802.875191-1-edumazet@google.com>
References: <20250921095802.875191-1-edumazet@google.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> busylock was protecting UDP sockets against packet floods,
> but unfortunately was not protecting the host itself.
> 
> Under stress, many cpus could spin while acquiring the busylock,
> and NIC had to drop packets. Or packets would be dropped
> in cpu backlog if RPS/RFS were in place.
> 
> This patch replaces the busylock by intermediate
> lockless queues. (One queue per NUMA node).
> 
> This means that fewer number of cpus have to acquire
> the UDP receive queue lock.
> 
> Most of the cpus can either:
> - immediately drop the packet.
> - or queue it in their NUMA aware lockless queue.
> 
> Then one of the cpu is chosen to process this lockless queue
> in a batch.
> 
> The batch only contains packets that were cooked on the same
> NUMA node, thus with very limited latency impact.
> 
> Tested:
> 
> DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes
> (Intel(R) Xeon(R) 6985P-C)
> 
> Before:
> 
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1004179            0.0
> Udp6InErrors                    3117               0.0
> Udp6RcvbufErrors                3117               0.0
> 
> After:
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1116633            0.0
> Udp6InErrors                    14197275           0.0
> Udp6RcvbufErrors                14197275           0.0
> 
> We can see this host can now proces 14.2 M more packets per second
> while under attack, and the victim socket can receive 11 % more
> packets.

Impressive gains under DoS!

Main concern is that it adds an extra queue/dequeue and thus some
cycle cost for all udp sockets in the common case where they are not
contended. These are simple linked list operations, so I suppose the
only cost may be the cacheline if not warm. Busylock had the nice
property of only being used under mem pressure. Could this benefit
from the same?

> I used a small bpftrace program measuring time (in us) spent in
> __udp_enqueue_schedule_skb().
> 
> Before:
> 
> @udp_enqueue_us[398]:
> [0]                24901 |@@@                                                 |
> [1]                63512 |@@@@@@@@@                                           |
> [2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                |
> [8, 16)            54022 |@@@@@@@@                                            |
> [16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
> [32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
> [64, 128)           4219 |                                                    |
> [128, 256)           188 |                                                    |
> 
> After:
> 
> @udp_enqueue_us[398]:
> [0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]              1111277 |@@@@@@@@@@                                          |
> [2, 4)            501439 |@@@@                                                |
> [4, 8)            102921 |                                                    |
> [8, 16)            29895 |                                                    |
> [16, 32)           43500 |                                                    |
> [32, 64)           31552 |                                                    |
> [64, 128)            979 |                                                    |
> [128, 256)            13 |                                                    |
> 
> Note that the remaining bottleneck for this platform is in
> udp_drops_inc() because we limited struct numa_drop_counters
> to only two nodes so far.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v3: - Moved kfree(up->udp_prod_queue) to udp_destruct_common(),
>       addressing reports from Jakub and syzbot.
> 
>     - Perform SKB_DROP_REASON_PROTO_MEM drops after the queue
>       spinlock is released.
> 
> v2: https://lore.kernel.org/netdev/20250920080227.3674860-1-edumazet@google.com/
>     - Added a kfree(up->udp_prod_queue) in udpv6_destroy_sock() (Jakub feedback on v1)
>     - Added bpftrace histograms in changelog.
> 
> v1: https://lore.kernel.org/netdev/20250919164308.2455564-1-edumazet@google.com/
> 
>  include/linux/udp.h |   9 +++-
>  include/net/udp.h   |  11 ++++-
>  net/ipv4/udp.c      | 114 ++++++++++++++++++++++++++------------------
>  net/ipv6/udp.c      |   5 +-
>  4 files changed, 88 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index e554890c4415b411f35007d3ece9e6042db7a544..58795688a18636ea79aa1f5d06eacc676a2e7849 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -44,6 +44,12 @@ enum {
>  	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
>  };
>  
> +/* per NUMA structure for lockless producer usage. */
> +struct udp_prod_queue {
> +	struct llist_head	ll_root ____cacheline_aligned_in_smp;
> +	atomic_t		rmem_alloc;
> +};
> +
>  struct udp_sock {
>  	/* inet_sock has to be the first member */
>  	struct inet_sock inet;
> @@ -90,6 +96,8 @@ struct udp_sock {
>  						struct sk_buff *skb,
>  						int nhoff);
>  
> +	struct udp_prod_queue *udp_prod_queue;
> +
>  	/* udp_recvmsg try to use this before splicing sk_receive_queue */
>  	struct sk_buff_head	reader_queue ____cacheline_aligned_in_smp;
>  
> @@ -109,7 +117,6 @@ struct udp_sock {
>  	 */
>  	struct hlist_node	tunnel_list;
>  	struct numa_drop_counters drop_counters;
> -	spinlock_t		busylock ____cacheline_aligned_in_smp;
>  };
>  
>  #define udp_test_bit(nr, sk)			\
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 059a0cee5f559b8d75e71031a00d0aa2769e257f..cffedb3e40f24513e44fb7598c0ad917fd15b616 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -284,16 +284,23 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
>  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  				  netdev_features_t features, bool is_ipv6);
>  
> -static inline void udp_lib_init_sock(struct sock *sk)
> +static inline int udp_lib_init_sock(struct sock *sk)
>  {
>  	struct udp_sock *up = udp_sk(sk);
>  
>  	sk->sk_drop_counters = &up->drop_counters;
> -	spin_lock_init(&up->busylock);
>  	skb_queue_head_init(&up->reader_queue);
>  	INIT_HLIST_NODE(&up->tunnel_list);
>  	up->forward_threshold = sk->sk_rcvbuf >> 2;
>  	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> +
> +	up->udp_prod_queue = kcalloc(nr_node_ids, sizeof(*up->udp_prod_queue),
> +				     GFP_KERNEL);
> +	if (!up->udp_prod_queue)
> +		return -ENOMEM;
> +	for (int i = 0; i < nr_node_ids; i++)
> +		init_llist_head(&up->udp_prod_queue[i].ll_root);
> +	return 0;
>  }
>  
>  static inline void udp_drops_inc(struct sock *sk)
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 85cfc32eb2ccb3e229177fb37910fefde0254ffe..fce1d0ffd6361d271ae3528fea026a8d6c07ac6e 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1685,25 +1685,6 @@ static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
>  	udp_rmem_release(sk, udp_skb_truesize(skb), 1, true);
>  }
>  
> -/* Idea of busylocks is to let producers grab an extra spinlock
> - * to relieve pressure on the receive_queue spinlock shared by consumer.
> - * Under flood, this means that only one producer can be in line
> - * trying to acquire the receive_queue spinlock.
> - */
> -static spinlock_t *busylock_acquire(struct sock *sk)
> -{
> -	spinlock_t *busy = &udp_sk(sk)->busylock;
> -
> -	spin_lock(busy);
> -	return busy;
> -}
> -
> -static void busylock_release(spinlock_t *busy)
> -{
> -	if (busy)
> -		spin_unlock(busy);
> -}
> -
>  static int udp_rmem_schedule(struct sock *sk, int size)
>  {
>  	int delta;
> @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, int size)
>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct sk_buff_head *list = &sk->sk_receive_queue;
> +	struct udp_prod_queue *udp_prod_queue;
> +	struct sk_buff *next, *to_drop = NULL;
> +	struct llist_node *ll_list;
>  	unsigned int rmem, rcvbuf;
> -	spinlock_t *busy = NULL;
>  	int size, err = -ENOMEM;
> +	int total_size = 0;
> +	int q_size = 0;
> +	int nb = 0;
>  
>  	rmem = atomic_read(&sk->sk_rmem_alloc);
>  	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>  	size = skb->truesize;
>  
> +	udp_prod_queue = &udp_sk(sk)->udp_prod_queue[numa_node_id()];

There is a small chance that a cpu enqueues to this queue and no
further arrivals on that numa node happen, stranding skbs on this
intermediate queue, right? If so, those are leaked on
udp_destruct_common.

> +
> +	rmem += atomic_read(&udp_prod_queue->rmem_alloc);
> +
>  	/* Immediately drop when the receive queue is full.
>  	 * Cast to unsigned int performs the boundary check for INT_MAX.
>  	 */
> @@ -1747,45 +1737,75 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	if (rmem > (rcvbuf >> 1)) {
>  		skb_condense(skb);
>  		size = skb->truesize;
> -		rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> -		if (rmem > rcvbuf)
> -			goto uncharge_drop;
> -		busy = busylock_acquire(sk);
> -	} else {
> -		atomic_add(size, &sk->sk_rmem_alloc);
>  	}
>  
>  	udp_set_dev_scratch(skb);
>  
> +	atomic_add(size, &udp_prod_queue->rmem_alloc);
> +
> +	if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
> +		return 0;
> +
>  	spin_lock(&list->lock);
> -	err = udp_rmem_schedule(sk, size);
> -	if (err) {
> -		spin_unlock(&list->lock);
> -		goto uncharge_drop;
> -	}
>  
> -	sk_forward_alloc_add(sk, -size);
> +	ll_list = llist_del_all(&udp_prod_queue->ll_root);
>  
> -	/* no need to setup a destructor, we will explicitly release the
> -	 * forward allocated memory on dequeue
> -	 */
> -	sock_skb_set_dropcount(sk, skb);
> +	ll_list = llist_reverse_order(ll_list);
> +
> +	llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
> +		size = udp_skb_truesize(skb);
> +		total_size += size;
> +		err = udp_rmem_schedule(sk, size);
> +		if (unlikely(err)) {
> +			/*  Free the skbs outside of locked section. */
> +			skb->next = to_drop;
> +			to_drop = skb;
> +			continue;
> +		}
> +
> +		q_size += size;
> +		sk_forward_alloc_add(sk, -size);
> +
> +		/* no need to setup a destructor, we will explicitly release the
> +		 * forward allocated memory on dequeue
> +		 */
> +		sock_skb_set_dropcount(sk, skb);

Since drop counters are approximate, read these once and report the
same for all packets in a batch?

> +		nb++;
> +		__skb_queue_tail(list, skb);
> +	}
> +
> +	atomic_add(q_size, &sk->sk_rmem_alloc);
>  
> -	__skb_queue_tail(list, skb);
>  	spin_unlock(&list->lock);
>  
> -	if (!sock_flag(sk, SOCK_DEAD))
> -		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
> +	if (!sock_flag(sk, SOCK_DEAD)) {
> +		/* Multiple threads might be blocked in recvmsg(),
> +		 * using prepare_to_wait_exclusive().
> +		 */
> +		while (nb) {
> +			INDIRECT_CALL_1(sk->sk_data_ready,
> +					sock_def_readable, sk);
> +			nb--;
> +		}
> +	}
> +
> +	if (unlikely(to_drop)) {
> +		for (nb = 0; to_drop != NULL; nb++) {
> +			skb = to_drop;
> +			to_drop = skb->next;
> +			skb_mark_not_on_list(skb);
> +			/* TODO: update SNMP values. */
> +			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
> +		}
> +		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> +	}
>  
> -	busylock_release(busy);
> -	return 0;
> +	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
>  
> -uncharge_drop:
> -	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +	return 0;
>  
>  drop:
>  	udp_drops_inc(sk);
> -	busylock_release(busy);
>  	return err;
>  }
>  EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
> @@ -1803,6 +1823,7 @@ void udp_destruct_common(struct sock *sk)
>  		kfree_skb(skb);
>  	}
>  	udp_rmem_release(sk, total, 0, true);
> +	kfree(up->udp_prod_queue);
>  }
>  EXPORT_IPV6_MOD_GPL(udp_destruct_common);
>  
> @@ -1814,10 +1835,11 @@ static void udp_destruct_sock(struct sock *sk)
>  
>  int udp_init_sock(struct sock *sk)
>  {
> -	udp_lib_init_sock(sk);
> +	int res = udp_lib_init_sock(sk);
> +
>  	sk->sk_destruct = udp_destruct_sock;
>  	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> -	return 0;
> +	return res;
>  }
>  
>  void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 9f4d340d1e3a63d38f80138ef9f6aac4a33afa05..813a2ba75824d14631642bf6973f65063b2825cb 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -67,10 +67,11 @@ static void udpv6_destruct_sock(struct sock *sk)
>  
>  int udpv6_init_sock(struct sock *sk)
>  {
> -	udp_lib_init_sock(sk);
> +	int res = udp_lib_init_sock(sk);
> +
>  	sk->sk_destruct = udpv6_destruct_sock;
>  	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> -	return 0;
> +	return res;
>  }
>  
>  INDIRECT_CALLABLE_SCOPE
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 



