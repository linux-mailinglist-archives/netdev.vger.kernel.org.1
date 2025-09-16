Return-Path: <netdev+bounces-223665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B6B59DB4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32247AC765
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84912F25F6;
	Tue, 16 Sep 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXZ01S4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3A125A0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040307; cv=none; b=nV+AigbEwQ44ByX+j8awdJ9VNRSuzNqSH78OvUOZKolg4jjpNLMsoF9gn4uTdvQWfe38vxyU9c6e/0bzFW7nH1MavoVLD+tUuSS4MbjJupynWamLKscgaL4M+TjjHOFQQtloyr4vOnavwB0YGJgOjGJhXrILwVi4qL/o4S9V5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040307; c=relaxed/simple;
	bh=deiYmJzpkVi4CGQYbM0VcfgGoW4J9enAWmyJ0OVvjP8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RczCJM7PeNi7oQcOULD/qTxBvvkRuDKzLXC5TSCcDEDofao/+jkHLT+UI7OYS9esH7IrLB71f3ifPCfQ6IKxWeX82pXmygR8LhnmQelIWG0yCQBmoh96hMc3IO6xMgicvwym+eOhLpz9wsZQFb5hJJFnTnxn5cQrk/7574Ycn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXZ01S4I; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so57013011cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040305; x=1758645105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3thcXCJGWQqBUKpiMu+dIKFMFwLuSav3muO6LZ21lvI=;
        b=jXZ01S4IInnARiXIK7QyrmD/UxbzwWOuO+Lrnau4UkIOzeaF0rjO8d3d31RPrE4s95
         DqoCjLW3DZ9rGS6xRj/qWa+vM5gidNvxjb4OIXTdr6HdnV0ETUouKtd6uO5Qif66hi2G
         zWLTIRv4I7xcjpiT2a2x27TSbCEAedMMZtcG+RvIlnHvfyErLF7sgcyzp/d3k9sUj86U
         SDoZZcxnlmuJ0eK9HZITg9Og1jsWIKPdhs3oYCjy7z2370oE4CjvqXeh3Gop/67BMi9U
         PmP6v/47u/tH6Qjkewu0OnUUwLgnWRdSeu7wInHM6cm7xW2/ckNsURdsRrYhL384/27H
         JuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040305; x=1758645105;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3thcXCJGWQqBUKpiMu+dIKFMFwLuSav3muO6LZ21lvI=;
        b=QpW5OSX+jn2feN8Jw2lRiwmsOHCmPgFek0khCY5bsfKL+7S1xy2+O7zeOM/L0LWpTp
         3JN84SR/+fV0PlrpCkqHUuhl7HlGVnfn99pyBm2UravYZlT+OLiL4F1V0N1zN5vSFHlM
         3RzEzCcmMN5FKnFMbxW2IwyvOY4E/8ijDmW0E4hssbXILSc2XH+msQiJLcc3RUH+E9Ho
         wkrBUy7YrK4K+3U0gOFfUFQA8btBcmS0agRy4ijj+401bcqbUNM5EdsDueUoPGcwsyxI
         B6IDg0Ag+WVAOhEbMOptzwqCLnjw1fHusVMpiFUW1e8jJ/VAapph5X30T01PBteeLHaw
         fK/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmaRj+5r9ptZuVoCWcL7L2uIJAEOABQTn7ybeAPSLWQ5vyUtoZEWHhPnsKqMdVTQTdEf6bigw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjD19OBBQyo4LJ1pWpwPMmsy+Yo5R/Vejlh2x2k+pSOJHTSPm
	7waVVzmloc4WaSOj8/w4wan9pTyvHdraHjm3Yv1GJr7DqmZYxeZO5WNh
X-Gm-Gg: ASbGncuEi0sEXjBllDHQISkM+fS7eX3a7Bjx3+9L8KVrdIVry2j4lx9X2qhUciCwFWP
	WOo1/M6SZAaw/d4ORRlMvIbKU4UTh0vaAgUaOPIe+k6ItoxwZ7sYRfpZHQQjOHpHAoi6n523zSt
	vhGOmhXnOihXEQnTDe1/tVy6thIq4JiQaRe6/4yY487uGtjKkQTl0F4GfmEnDJDSJ3ArTy0j3E8
	wnRgk7zXUwBC1c3E3lweULMC2R4cRNGF3GHgOKPilo9X2c6rbWkgEKVvWKC1w0U8g0xXjrkVNQx
	wfD+mp4Ck9F3N4lm/t5iwLl+BkuZD0Yw/G79YdyRLpP9CGCCUS9bF8qEHznZnB7Sh0Hxy2Gu7KR
	0qChOfp7uFlKaqI79cjBSxjMmtHzQhOy98HS2vwswLkDDfavlTTAzeIZ7javmXwYc6D3XhZDZ7o
	MVbeoNRJoi9kW3
X-Google-Smtp-Source: AGHT+IEz3bi1pc1LarIzgSi+oFSCj2GkT9FVKeMlA8b2cg5DBcXcQMdvmQqvXVjGt/jHHQzscOmLZA==
X-Received: by 2002:a05:622a:5e0b:b0:4b4:8f9f:7469 with SMTP id d75a77b69052e-4b7882704c6mr132025571cf.18.1758040304527;
        Tue, 16 Sep 2025 09:31:44 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dad799sm87539891cf.28.2025.09.16.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:31:43 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:31:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.e4b37db8cf47@gmail.com>
In-Reply-To: <20250916160951.541279-10-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-10-edumazet@google.com>
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
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
> While having all spinlocks packed into an array was a space saver,
> this also caused NUMA imbalance and hash collisions.
> 
> UDPv6 socket size becomes 1600 after this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/udp.h |  1 +
>  include/net/udp.h   |  1 +
>  net/ipv4/udp.c      | 20 ++------------------
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 6ed008ab166557e868c1918daaaa5d551b7989a7..e554890c4415b411f35007d3ece9e6042db7a544 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -109,6 +109,7 @@ struct udp_sock {
>  	 */
>  	struct hlist_node	tunnel_list;
>  	struct numa_drop_counters drop_counters;
> +	spinlock_t		busylock ____cacheline_aligned_in_smp;
>  };
>  
>  #define udp_test_bit(nr, sk)			\
> diff --git a/include/net/udp.h b/include/net/udp.h
> index a08822e294b038c0d00d4a5f5cac62286a207926..eecd64097f91196897f45530540b9c9b68c5ba4e 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -289,6 +289,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
>  	struct udp_sock *up = udp_sk(sk);
>  
>  	sk->sk_drop_counters = &up->drop_counters;
> +	spin_lock_init(&up->busylock);
>  	skb_queue_head_init(&up->reader_queue);
>  	INIT_HLIST_NODE(&up->tunnel_list);
>  	up->forward_threshold = sk->sk_rcvbuf >> 2;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 25143f932447df2a84dd113ca33e1ccf15b3503c..7d1444821ee51a19cd5fd0dd5b8d096104c9283c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1689,17 +1689,11 @@ static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
>   * to relieve pressure on the receive_queue spinlock shared by consumer.
>   * Under flood, this means that only one producer can be in line
>   * trying to acquire the receive_queue spinlock.
> - * These busylock can be allocated on a per cpu manner, instead of a
> - * per socket one (that would consume a cache line per socket)
>   */
> -static int udp_busylocks_log __read_mostly;
> -static spinlock_t *udp_busylocks __read_mostly;
> -
> -static spinlock_t *busylock_acquire(void *ptr)
> +static spinlock_t *busylock_acquire(struct sock *sk)
>  {
> -	spinlock_t *busy;
> +	spinlock_t *busy = &udp_sk(sk)->busylock;
>  
> -	busy = udp_busylocks + hash_ptr(ptr, udp_busylocks_log);
>  	spin_lock(busy);
>  	return busy;
>  }
> @@ -3997,7 +3991,6 @@ static void __init bpf_iter_register(void)
>  void __init udp_init(void)
>  {
>  	unsigned long limit;
> -	unsigned int i;
>  
>  	udp_table_init(&udp_table, "UDP");
>  	limit = nr_free_buffer_pages() / 8;
> @@ -4006,15 +3999,6 @@ void __init udp_init(void)
>  	sysctl_udp_mem[1] = limit;
>  	sysctl_udp_mem[2] = sysctl_udp_mem[0] * 2;
>  
> -	/* 16 spinlocks per cpu */
> -	udp_busylocks_log = ilog2(nr_cpu_ids) + 4;
> -	udp_busylocks = kmalloc(sizeof(spinlock_t) << udp_busylocks_log,
> -				GFP_KERNEL);

A per sock busylock is preferable over increasing this array to be
full percpu (and converting percpu to avoid false sharing)?

Because that would take a lot of space on modern server platforms?
Just trying to understand the trade-off made.

> -	if (!udp_busylocks)
> -		panic("UDP: failed to alloc udp_busylocks\n");
> -	for (i = 0; i < (1U << udp_busylocks_log); i++)
> -		spin_lock_init(udp_busylocks + i);
> -
>  	if (register_pernet_subsys(&udp_sysctl_ops))
>  		panic("UDP: failed to init sysctl parameters.\n");
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 



