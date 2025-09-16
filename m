Return-Path: <netdev+bounces-223655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F9B59D38
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EBF326A9E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD731FEE0;
	Tue, 16 Sep 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftE0QWLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487D29BDB0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039015; cv=none; b=VkKnC0JwHyx41XJxdZA14sw08abE+n9m+7D4t/6g+BE8JmEh4SvwZM7I7aDNT2xfUBbXiNydYRxllUkQj7ROuDKyZBJK0xAr2JsqWoa+TRRqw6chrNLvTjUbJBw/j//1iSim4GklW9GZ9vntUabyP9f/AN+xmvmZ/VLUAApHm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039015; c=relaxed/simple;
	bh=KCpfw7hx6fGDIT+ZeP5i6PBM44Z5wINhjOEh6x0TrOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQODvOO5BSKanDsqoposTggref3wzfhfkDfyfhpVE6k3tsfNSR2npF7CwPyRUkAxxZExTzUdP4jP/H6F0npI9i7JVyYyXqmr6BLvDN5zizWij/ND8RAGwzBpNGqwwKguQhbeXnwdC5ae7kSGUD0T/jgt5XXOfgJY6RBEGkoEm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ftE0QWLT; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b5ecf597acso127410071cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039013; x=1758643813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OWfkG3hNBDa5iD19LBjVEAJ7Tfbw8fdHjrKscMo7cs=;
        b=ftE0QWLTtehv9afupwsfT7NYuaKQQ5xKuIs79UinzIvfcDO8FIc8vyRzzsT7XNb8cO
         tdcJK+l5g75gdJ57I7gJkE4Z8svpFiTQ8/fGhCZQm2RX3hMqInvWsuoFR4mk0/1ADPvP
         tc32zJaf+JZFCxrrCRQoAr6OAJkqx9+Rbq+hhsy4ok3QtyiqnAk82AzNBgkLOF6fhiFV
         VI99wvnnMxLBwZQdfXOCCx9L5bg+zfYHtdpW/s0FOSTbAm+o7d8TJn2ImIf5Uv8NqoqV
         Uy+MyNXaJyDiH9g+fVwJBwDVaAquX0GjkPcSNACJHUJk+IyByc7rnNZTza9Tu8fxYK09
         lDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039013; x=1758643813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OWfkG3hNBDa5iD19LBjVEAJ7Tfbw8fdHjrKscMo7cs=;
        b=ax8wAugHOORtskUpUfEV6jmXB4gtwUIuw+xLTyjgOslYbe/Hyj5FjF2Wmb9PqLjikV
         GgIrpfs6xhlnZK43twSvMLEgs/jsUx4Sy5oAEzpj84yKlzmZbSQVbsy85LZaAVJgniyW
         /lIKmB2dKwatsAElFH+9J2zH7OuOQd1pQ3Pa5Xi/0gM47rEdpDvbBIaPEsrCySNwDJcw
         HVkXmQe3ly1CHe0SrULplu+1LVa/Jv/JNlxjMuDujCt4+H1/Jtysz+NstwbhWVdE0Ypy
         aEdGUJdrgeJVV7a0m0dw6XnNDBSiNFKYn4TQd0a/npeJ/+h0PZ9fBXa1jEOfgI1L3//6
         0sPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wqKAIDFGJI9rnf9Ce83tuXuD9YjYsdvBNjRMKIcMEShqiJOIJoWYUT96v/0HqK/rBRyPZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvX1nYeb0AKCHPBbdkyTHt14VTGFvU2LC+jYVHXCzTMehM3BHD
	UwDXGDPVE5wR8y2VHoHMeml44fONBVPxcsXzBz69An0ICo/ILUdomhskWdNn5dioWwZxfXbEtFM
	/Tg4/eKIvCafBmg==
X-Google-Smtp-Source: AGHT+IFnNuyzkV71Ssk96/NWII1cPlqyTcHLynDFMtCjXtsfKOYcOO5Tl+MQ8JuBew3Q/9qY5ZxgMGdyXFAmGg==
X-Received: from qtbne22.prod.google.com ([2002:a05:622a:8316:b0:4b5:e0ab:fe1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4293:b0:4b7:a8ce:a419 with SMTP id d75a77b69052e-4b7a8cead98mr77800641cf.26.1758039012977;
 Tue, 16 Sep 2025 09:10:12 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:50 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-10-edumazet@google.com>
Subject: [PATCH net-next 09/10] udp: make busylock per socket
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While having all spinlocks packed into an array was a space saver,
this also caused NUMA imbalance and hash collisions.

UDPv6 socket size becomes 1600 after this patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h |  1 +
 include/net/udp.h   |  1 +
 net/ipv4/udp.c      | 20 ++------------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 6ed008ab166557e868c1918daaaa5d551b7989a7..e554890c4415b411f35007d3ece9e6042db7a544 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -109,6 +109,7 @@ struct udp_sock {
 	 */
 	struct hlist_node	tunnel_list;
 	struct numa_drop_counters drop_counters;
+	spinlock_t		busylock ____cacheline_aligned_in_smp;
 };
 
 #define udp_test_bit(nr, sk)			\
diff --git a/include/net/udp.h b/include/net/udp.h
index a08822e294b038c0d00d4a5f5cac62286a207926..eecd64097f91196897f45530540b9c9b68c5ba4e 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -289,6 +289,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
 	struct udp_sock *up = udp_sk(sk);
 
 	sk->sk_drop_counters = &up->drop_counters;
+	spin_lock_init(&up->busylock);
 	skb_queue_head_init(&up->reader_queue);
 	INIT_HLIST_NODE(&up->tunnel_list);
 	up->forward_threshold = sk->sk_rcvbuf >> 2;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 25143f932447df2a84dd113ca33e1ccf15b3503c..7d1444821ee51a19cd5fd0dd5b8d096104c9283c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1689,17 +1689,11 @@ static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
  * to relieve pressure on the receive_queue spinlock shared by consumer.
  * Under flood, this means that only one producer can be in line
  * trying to acquire the receive_queue spinlock.
- * These busylock can be allocated on a per cpu manner, instead of a
- * per socket one (that would consume a cache line per socket)
  */
-static int udp_busylocks_log __read_mostly;
-static spinlock_t *udp_busylocks __read_mostly;
-
-static spinlock_t *busylock_acquire(void *ptr)
+static spinlock_t *busylock_acquire(struct sock *sk)
 {
-	spinlock_t *busy;
+	spinlock_t *busy = &udp_sk(sk)->busylock;
 
-	busy = udp_busylocks + hash_ptr(ptr, udp_busylocks_log);
 	spin_lock(busy);
 	return busy;
 }
@@ -3997,7 +3991,6 @@ static void __init bpf_iter_register(void)
 void __init udp_init(void)
 {
 	unsigned long limit;
-	unsigned int i;
 
 	udp_table_init(&udp_table, "UDP");
 	limit = nr_free_buffer_pages() / 8;
@@ -4006,15 +3999,6 @@ void __init udp_init(void)
 	sysctl_udp_mem[1] = limit;
 	sysctl_udp_mem[2] = sysctl_udp_mem[0] * 2;
 
-	/* 16 spinlocks per cpu */
-	udp_busylocks_log = ilog2(nr_cpu_ids) + 4;
-	udp_busylocks = kmalloc(sizeof(spinlock_t) << udp_busylocks_log,
-				GFP_KERNEL);
-	if (!udp_busylocks)
-		panic("UDP: failed to alloc udp_busylocks\n");
-	for (i = 0; i < (1U << udp_busylocks_log); i++)
-		spin_lock_init(udp_busylocks + i);
-
 	if (register_pernet_subsys(&udp_sysctl_ops))
 		panic("UDP: failed to init sysctl parameters.\n");
 
-- 
2.51.0.384.g4c02a37b29-goog


