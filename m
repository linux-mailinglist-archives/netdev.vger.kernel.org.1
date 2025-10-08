Return-Path: <netdev+bounces-228228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A8BC53D8
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261473A6935
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC2285C82;
	Wed,  8 Oct 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFkqMo2h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB72857C1
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930713; cv=none; b=agQDYhFjIEYBGmMIahkuaD6ydR/pI5bpUj+6wUFUiyl2g9OyC7vVF1GENQwKaTeEnM3ku8ZO2QJRuIfu3eilDcDIuSV46COw12ZAT+MMIowc1EJDrA+ILt+Vm7yjL4ncllHZLq9ua3424Ca09IKkfrvu7b/qjEbZT6Ndk//QmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930713; c=relaxed/simple;
	bh=G8u+LAR3PkPZ1Bqhpts44wjJgaoKPNN1DWmr9ZqoRfY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sF1bEKIKwr23ybsFiwZYnt1D+VF28QDMTutOHLjo/iUm/ce9eGgS7v2u2BlZAl3O4Q2eIqOEvoPj3YOr1qpYQ9QPOZaOyCfm4FGAgYvIMr9H5rUp5UFd6fzSzkw1p2cM/CrlPbpKxXTQkjLDBZmPpDUb9DYUE/4OuW8L3kEKxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFkqMo2h; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5a7b2a6b13bso6577852137.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759930710; x=1760535510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktxhg5wwLxcdKUFYn95ck3tvHW6ioWDk0A+FHHJhiqM=;
        b=ZFkqMo2h2di+cTeWBGtqIdohOVGbiRRYxVluEg4HGdFiqB22kE8wW0OBCE1QCVcCr1
         EtFcfkAKFjPw1breuDdys466V8ectt4SIqDvDaISrf4FdpNGT1B0sUOu/1w5L7hIEAQ/
         57MiUrf2fhvIwU6ENZI7kqspmSkEj+yGQNW1hoKbCnrnIcpqutMENv6hiqNnhUJUVZlp
         J1Dwe1z04S0SI0PVfVolJni7pFznrREggmr74rqTHSyJwe82MChbcaJryqDlDMU00IgS
         RIZaKIzbmptqxLlVspGO+xr/TFnUQWYzQsLxrB04YcN/U142m+v2zEjTj+LGLglXjpiy
         3jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930710; x=1760535510;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktxhg5wwLxcdKUFYn95ck3tvHW6ioWDk0A+FHHJhiqM=;
        b=tOEEOQ3hIFX/KJiaUvxCKDwsa3GZMdEdZCQdJCsBFOev84Z+K3wfvOWRkoCiT54PLk
         XL+vW+M7iGN5l/FxRkmVzrXXjhsxAo7hutf2diIlasb6h/uYQ763vliAEYvKoCj3qxPt
         GcCFc8UAPprM3TIofY6mAGRMPXUvCdHzzdq//4e514RbkqTOrUAdZkVheBzoXws27f00
         QA1gCVvR4+Gr6dZfFf1Tn3iQYoOqI+vbXEw2v/GAWoKx2c+cvojkHJK6ER7RPkh0TejU
         4G7iEgIGqVBxh6u5tFeLVmjsDMstJjYa3Qpc1sWTHJewON5+M2v/W3IMmP2u0Z/V0pBo
         +iTg==
X-Forwarded-Encrypted: i=1; AJvYcCXp2dZjDh9qWrRZxCy9ghcDPZ/ssnpu1R8wVPImHpN5BpMZcNYyNJKhxLawibuXYRXhXULkZuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmNRr9rcvXdoIeLdNTIHpPOE5Q2xsGHm2jnMDi1IQjoPd5Xum
	0hbQqBEczMMbS7Ck3ayFWta5puganiw8U0IgEqvu0Qq4G7ET0J2EOhLj
X-Gm-Gg: ASbGncuxHFbT1Z5g5v2LzJ6Ayaum4GsyNi9hdfkfhKXGPl0Bs2lwgqzqmkMy+euKMum
	5odzaYG4BsMgpblnuJAOfvSPUtM6qnTHPLTBtB9FF87BoyrSzziGaMWdz0qpz1wH5YU8FaJM8dC
	Mi6TsfJjaybB5L/4Qq2JqGuiTQthGJnJWGZSpPlQD+b5jaRgEXgaGaz4HX+QnJ/EKeqyed9Z0AI
	H+DGZigZExkAFWlWfpWraVuosh5eN+8zJNMG0TeMJT0EhxXn2kFmRJvDr3WlgS91FHcWcXDaWfx
	Z6dsowyZzhyBvmaiZojNB+CqOP9Bvfxny0gJ3Dd7CfANZ0mIiMvgtps2FQ5Uqacp8e8SefxxaoW
	5KC/yG/fdJ07aWxmRJnDTWVVHkeaJN0dNc+4ZXS/LCXgjt4tcQTJYiU49Gu0cYHI4fX8PYpFSGr
	n/f6trMSOVPEVcjM1oiA==
X-Google-Smtp-Source: AGHT+IGx3cbUaBrt8z/a4G22ni1DiTp+n4L3u5aNuopeDocVhWqzWl6znd3dDAYg1T/52USjuIAsUQ==
X-Received: by 2002:a05:6102:6c2:b0:4fb:ebe1:7db1 with SMTP id ada2fe7eead31-5d5e220448dmr1480521137.12.1759930710060;
        Wed, 08 Oct 2025 06:38:30 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-92eb4da21c3sm4235402241.7.2025.10.08.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:38:29 -0700 (PDT)
Date: Wed, 08 Oct 2025 09:38:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.5c18588531fd@gmail.com>
In-Reply-To: <20251008104612.1824200-5-edumazet@google.com>
References: <20251008104612.1824200-1-edumazet@google.com>
 <20251008104612.1824200-5-edumazet@google.com>
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
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
> This is a followup of commit 726e9e8b94b9 ("tcp: refine
> skb->ooo_okay setting") and to the prior commit in this series
> ("net: control skb->ooo_okay from skb_set_owner_w()")
> 
> skb->ooo_okay might never be set for bulk flows that always
> have at least one skb in a qdisc queue of NIC queue,
> especially if TX completion is delayed because of a stressed cpu.
> 
> The so-called "strange attractors" has caused many performance
> issues, we need to do better.
> 
> We have tried very hard to avoid reorders because TCP was
> not dealing with them nicely a decade ago.
> 
> Use the new net.core.txq_reselection_ms sysctl to let
> flows follow XPS and select a more efficient queue.
> 
> After this patch, we no longer have to make sure threads
> are pinned to cpus, they now can be migrated without
> adding too much spinlock/qdisc/TX completion pressure anymore.
> 
> TX completion part was problematic, because it added false sharing
> on various socket fields, but also added false sharing and spinlock
> contention in mm layers. Calling skb_orphan() from ndo_start_xmit()
> is not an option unfortunately.
> 
> Note for later: move sk->sk_tx_queue_mapping closer
> to sk_tx_queue_mapping_jiffies for better cache locality.
> 
> Tested:
> 
> Used a host with 32 TX queues, shared by groups of 8 cores.
> XPS setup :
> 
> echo ff >/sys/class/net/eth1/queue/tx-0/xps_cpus
> echo ff00 >/sys/class/net/eth1/queue/tx-1/xps_cpus
> echo ff0000 >/sys/class/net/eth1/queue/tx-2/xps_cpus
> echo ff000000 >/sys/class/net/eth1/queue/tx-3/xps_cpus
> echo ff,00000000 >/sys/class/net/eth1/queue/tx-4/xps_cpus
> echo ff00,00000000 >/sys/class/net/eth1/queue/tx-5/xps_cpus
> echo ff0000,00000000 >/sys/class/net/eth1/queue/tx-6/xps_cpus
> echo ff000000,00000000 >/sys/class/net/eth1/queue/tx-7/xps_cpus
> ...
> 
> Launched a tcp_stream with 15 threads and 1000 flows, initially affined to core 0-15
> 
> taskset -c 0-15 tcp_stream -T15 -F1000 -l1000 -c -H target_host
> 
> Checked that only queues 0 and 1 are used as instructed by XPS :
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 123489410b 1890p
>  backlog 69809026b 1064p
>  backlog 52401054b 805p

Just in case it's not clear to all readers, this implies MQ + some
per queue qdisc, right. Here MQ + FQ.
 
> Then force each thread to run on cpu 1,9,17,25,33,41,49,57,65,73,81,89,97,105,113,121
> 
> C=1;PID=`pidof tcp_stream`;for P in `ls /proc/$PID/task`; do taskset -pc $C $P; C=$(($C + 8));done
> 
> Set txq_reselection_ms to 1000
> echo 1000 > /proc/sys/net/core/txq_reselection_ms

Just curious: is the once per second heuristic based on anything. Is
it likely to set another (more aggressive) value here?

Series looks great to me, btw, thanks.

> 
> Check that the flows have migrated nicely:
> 
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 130508314b 1916p
>  backlog 8584380b 126p
>  backlog 8584380b 126p
>  backlog 8379990b 123p
>  backlog 8584380b 126p
>  backlog 8487484b 125p
>  backlog 8584380b 126p
>  backlog 8448120b 124p
>  backlog 8584380b 126p
>  backlog 8720640b 128p
>  backlog 8856900b 130p
>  backlog 8584380b 126p
>  backlog 8652510b 127p
>  backlog 8448120b 124p
>  backlog 8516250b 125p
>  backlog 7834950b 115p
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h | 40 +++++++++++++++++++---------------------
>  net/core/dev.c     | 27 +++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2794bc5c565424491a064049d3d76c3fb7ba1ed8..61f92bb03e00d7167cccfe70da16174f2b40f6de 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -485,6 +485,7 @@ struct sock {
>  	unsigned long		sk_pacing_rate; /* bytes per second */
>  	atomic_t		sk_zckey;
>  	atomic_t		sk_tskey;
> +	unsigned long		sk_tx_queue_mapping_jiffies;
>  	__cacheline_group_end(sock_write_tx);
>  
>  	__cacheline_group_begin(sock_read_tx);
> @@ -1984,6 +1985,14 @@ static inline int sk_receive_skb(struct sock *sk, struct sk_buff *skb,
>  	return __sk_receive_skb(sk, skb, nested, 1, true);
>  }
>  
> +/* This helper checks if a socket is a full socket,
> + * ie _not_ a timewait or request socket.
> + */
> +static inline bool sk_fullsock(const struct sock *sk)
> +{
> +	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
> +}
> +
>  static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
>  {
>  	/* sk_tx_queue_mapping accept only upto a 16-bit value */
> @@ -1992,7 +2001,15 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
>  	/* Paired with READ_ONCE() in sk_tx_queue_get() and
>  	 * other WRITE_ONCE() because socket lock might be not held.
>  	 */
> -	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
> +	if (READ_ONCE(sk->sk_tx_queue_mapping) != tx_queue) {
> +		WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
> +		WRITE_ONCE(sk->sk_tx_queue_mapping_jiffies, jiffies);
> +		return;
> +	}
> +
> +	/* Refresh sk_tx_queue_mapping_jiffies if too old. */
> +	if (time_is_before_jiffies(READ_ONCE(sk->sk_tx_queue_mapping_jiffies) + HZ))
> +		WRITE_ONCE(sk->sk_tx_queue_mapping_jiffies, jiffies);
>  }
>  
>  #define NO_QUEUE_MAPPING	USHRT_MAX
> @@ -2005,19 +2022,7 @@ static inline void sk_tx_queue_clear(struct sock *sk)
>  	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
>  }
>  
> -static inline int sk_tx_queue_get(const struct sock *sk)
> -{
> -	if (sk) {
> -		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
> -		 * and sk_tx_queue_set().
> -		 */
> -		int val = READ_ONCE(sk->sk_tx_queue_mapping);
> -
> -		if (val != NO_QUEUE_MAPPING)
> -			return val;
> -	}
> -	return -1;
> -}7
> +int sk_tx_queue_get(const struct sock *sk);
>  
>  static inline void __sk_rx_queue_set(struct sock *sk,
>  				     const struct sk_buff *skb,
> @@ -2945,13 +2950,6 @@ skb_sk_is_prefetched(struct sk_buff *skb)
>  #endif /* CONFIG_INET */
>  }
>  
> -/* This helper checks if a socket is a full socket,
> - * ie _not_ a timewait or request socket.
> - */
> -static inline bool sk_fullsock(const struct sock *sk)
> -{
> -	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
> -}
>  
>  static inline bool
>  sk_is_refcounted(struct sock *sk)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a64cef2c537e98ee87776e6f8d3ca3d98f0711b3..c302fd5bb57894c6e5651b7adc8d033ac719070a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4591,6 +4591,30 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(dev_pick_tx_zero);
>  
> +int sk_tx_queue_get(const struct sock *sk)
> +{
> +	int val;
> +
> +	if (!sk)
> +		return -1;
> +	/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
> +	 * and sk_tx_queue_set().
> +	 */
> +	val = READ_ONCE(sk->sk_tx_queue_mapping);
> +
> +	if (val == NO_QUEUE_MAPPING)
> +		return -1;
> +
> +	if (sk_fullsock(sk) &&
> +	    time_is_before_jiffies(
> +			READ_ONCE(sk->sk_tx_queue_mapping_jiffies) +
> +			READ_ONCE(sock_net(sk)->core.sysctl_txq_reselection)))
> +		return -1;
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(sk_tx_queue_get);
> +
>  u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
>  		     struct net_device *sb_dev)
>  {
> @@ -4606,8 +4630,7 @@ u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
>  		if (new_index < 0)
>  			new_index = skb_tx_hash(dev, sb_dev, skb);
>  
> -		if (queue_index != new_index && sk &&
> -		    sk_fullsock(sk) &&
> +		if (sk && sk_fullsock(sk) &&
>  		    rcu_access_pointer(sk->sk_dst_cache))
>  			sk_tx_queue_set(sk, new_index);
>  
> -- 
> 2.51.0.710.ga91ca5db03-goog
> 



