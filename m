Return-Path: <netdev+bounces-176664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D08EA6B3A1
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CF1890649
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E81DEFFC;
	Fri, 21 Mar 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPo3hIMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB117A2E3
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742530578; cv=none; b=LYzmPSSQ45jzhvvzfOEeFOBrSZaexM/DiZ2q8N5Xo/8fZtg8m168yKLSsCkZ8HmMdbSNAP9/GP02vLoAGs7ZNoqo0VaqRLZcGP2aw/i8FC/8TLDUPAKUZuH5fvxQH9fB8+j7kwl2JrCp2usP4WCdPfSpYCuk83PLar9Px80dUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742530578; c=relaxed/simple;
	bh=Uf5y1tDNtC115KzGw/gQTUTDPRzu1vug7BKOieIjouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJC7CjKaUt6zMI3f6rUwDUN0//JZBrSZVKEz1f6gBipmZGwdItcDlJzWToeMceGSRX2lq52wR7/Djo23yWLRCAmZPyxgp3uNyVGd7pz8yW5QzVBV5m1uEepWoCJRcGoYs2Le4BAdgjrKPQRKd16MKIfMPsjVuxZY7NWA6WKntms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPo3hIMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C7C4CEE8;
	Fri, 21 Mar 2025 04:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742530577;
	bh=Uf5y1tDNtC115KzGw/gQTUTDPRzu1vug7BKOieIjouU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPo3hIMlXtnn4Y3lOaAD8cn2mQ4Kg++Qqz4WOfuA5dOL/NvkdaFOssVbmFUWSb/mH
	 /KPXPRxEz+Leq9d0HDFmbTybbDtaVUp4lTHYihaLefFXvLJaSeB+prOD/g8BFxpz2Q
	 AsU4g5VBUh0bni/45q75R4WSWfJ8O3VnqhNBZ/sKez7OWezvhfQ/aX9MKwyURqTJ9q
	 Wzp7/WqmC0XGRcY/rzQnpLLxh4nMT7TDpawu2FyCzDbCpICFCJfjeNON7J9/LipBha
	 mmpbLn6niZ27dcKVVgUotF101d0SGdu5nEJDOekYmeQAILtTApaAEXdxIHEknL+EuQ
	 v5v1rQvHu1DpA==
Date: Thu, 20 Mar 2025 21:16:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, kuniyu@amazon.com
Subject: Re: [PATCH v4 net-next 2/2] udp_tunnel: use static call for GRO
 hooks when possible
Message-ID: <20250321041612.GA2679131@ax162>
References: <cover.1741718157.git.pabeni@redhat.com>
 <6fd1f9c7651151493ecab174e7b8386a1534170d.1741718157.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd1f9c7651151493ecab174e7b8386a1534170d.1741718157.git.pabeni@redhat.com>

Hi Paolo,

On Tue, Mar 11, 2025 at 09:42:29PM +0100, Paolo Abeni wrote:
> It's quite common to have a single UDP tunnel type active in the
> whole system. In such a case we can replace the indirect call for
> the UDP tunnel GRO callback with a static call.
> 
> Add the related accounting in the control path and switch to static
> call when possible. To keep the code simple use a static array for
> the registered tunnel types, and size such array based on the kernel
> config.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>  - fix CONFIG_FOE typo
>  - avoid gaps in gro types array
>  - drop WARN_ON in dummy_gro_rcv()
> 
> v2 -> v3:
>  - avoid unneeded checks in udp_tunnel_update_gro_rcv()
> 
> v1 -> v2:
>  - fix UDP_TUNNEL=n build
> ---
>  include/net/udp_tunnel.h   |   4 ++
>  net/ipv4/udp_offload.c     | 130 ++++++++++++++++++++++++++++++++++++-
>  net/ipv4/udp_tunnel_core.c |   2 +
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index eda0f3e2f65fa..a7b230867eb14 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -205,9 +205,11 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
>  
>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>  void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
>  #else
>  static inline void udp_tunnel_update_gro_lookup(struct net *net,
>  						struct sock *sk, bool add) {}
> +static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
>  #endif
>  
>  static inline void udp_tunnel_cleanup_gro(struct sock *sk)
> @@ -215,6 +217,8 @@ static inline void udp_tunnel_cleanup_gro(struct sock *sk)
>  	struct udp_sock *up = udp_sk(sk);
>  	struct net *net = sock_net(sk);
>  
> +	udp_tunnel_update_gro_rcv(sk, false);
> +
>  	if (!up->tunnel_list.pprev)
>  		return;
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index e36d8a234848f..088aa8cb8ac0c 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -15,6 +15,37 @@
>  #include <net/udp_tunnel.h>
>  
>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +
> +/*
> + * Dummy GRO tunnel callback, exists mainly to avoid dangling/NULL
> + * values for the udp tunnel static call.
> + */
> +static struct sk_buff *dummy_gro_rcv(struct sock *sk,
> +				     struct list_head *head,
> +				     struct sk_buff *skb)
> +{
> +	NAPI_GRO_CB(skb)->flush = 1;
> +	return NULL;
> +}
> +
> +typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
> +						struct list_head *head,
> +						struct sk_buff *skb);
> +
> +struct udp_tunnel_type_entry {
> +	udp_tunnel_gro_rcv_t gro_receive;
> +	refcount_t count;
> +};
> +
> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
> +			      IS_ENABLED(CONFIG_NET_FOU) * 2)

I am seeing a warning in one particular configuration in my matrix when
building with clang:

  $ make -skj"$(nproc)" ARCH=mips LLVM=1 mrproper malta_defconfig net/ipv4/udp_offload.o
  net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
    130 |                                    udp_tunnel_gro_types[0].gro_receive);
        |                                    ^                    ~
  include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
    154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
        |                                                 ^~~~
  net/ipv4/udp_offload.c:47:1: note: array 'udp_tunnel_gro_types' declared here
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        | ^
  1 warning generated.

GCC is more noisy but -Warray-bounds is not on by default yet.

  $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- KCFLAGS=-Warray-bounds mrproper malta_defconfig net/ipv4/udp_offload.o
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:125:44: warning: array subscript <unknown> is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
    125 |                 *cur = udp_tunnel_gro_types[--udp_tunnel_gro_type_nr];
        |                        ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:111:17: warning: array subscript <unknown> is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
    111 |                 refcount_set(&cur->count, 1);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In file included from ./arch/mips/include/generated/asm/rwonce.h:1,
                   from include/linux/compiler.h:390,
                   from include/linux/array_size.h:5,
                   from include/linux/kernel.h:16,
                   from include/linux/skbuff.h:13,
                   from net/ipv4/udp_offload.c:9:
  In function 'arch_atomic_set',
      inlined from 'raw_atomic_set' at include/linux/atomic/atomic-arch-fallback.h:503:2,
      inlined from 'atomic_set' at include/linux/atomic/atomic-instrumented.h:68:2,
      inlined from 'refcount_set' at include/linux/refcount.h:134:2,
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:111:3,
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  include/asm-generic/rwonce.h:55:37: warning: array subscript [3, 536870912] is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
     55 |         *(volatile typeof(x) *)&(x) = (val);                            \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
  include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
     61 |         __WRITE_ONCE(x, val);                                           \
        |         ^~~~~~~~~~~~
  arch/mips/include/asm/atomic.h:34:9: note: in expansion of macro 'WRITE_ONCE'
     34 |         WRITE_ONCE(v->counter, i);                                      \
        |         ^~~~~~~~~~
  arch/mips/include/asm/atomic.h:37:1: note: in expansion of macro 'ATOMIC_OPS'
     37 | ATOMIC_OPS(atomic, int)
        | ^~~~~~~~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: at offset 12 into object 'udp_tunnel_gro_types' of size 0
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:110:44: warning: array subscript <unknown> is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
    110 |                 cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
        |                        ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In file included from include/linux/bpf.h:30,
                   from include/linux/security.h:35,
                   from include/net/scm.h:9,
                   from include/linux/netlink.h:9,
                   from include/uapi/linux/neighbour.h:6,
                   from include/linux/netdevice.h:44,
                   from include/net/sock.h:46,
                   from include/linux/tcp.h:19,
                   from include/linux/ipv6.h:102,
                   from include/net/gro.h:8,
                   from net/ipv4/udp_offload.c:10:
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:130:56: warning: array subscript 0 is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
    130 |                                    udp_tunnel_gro_types[0].gro_receive);
        |                                    ~~~~~~~~~~~~~~~~~~~~^~~
  include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
    154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
        |                                                 ^~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:89:41: warning: array subscript i is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
     89 |                 if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
        |                     ~~~~~~~~~~~~~~~~~~~~^~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~
  In function 'udp_tunnel_update_gro_rcv',
      inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
  net/ipv4/udp_offload.c:90:31: warning: array subscript i is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
     90 |                         cur = &udp_tunnel_gro_types[i];
        |                               ^~~~~~~~~~~~~~~~~~~~~~~~
  net/ipv4/udp_offload.c: In function 'udp_tunnel_update_gro_rcv':
  net/ipv4/udp_offload.c:47:37: note: while referencing 'udp_tunnel_gro_types'
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        |                                     ^~~~~~~~~~~~~~~~~~~~

Should UDP_MAX_TUNNEL_TYPES be at least 1?

Cheers,
Nathan

> +DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
> +static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
> +static struct mutex udp_tunnel_gro_type_lock;
> +static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
> +static unsigned int udp_tunnel_gro_type_nr;
>  static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
>  
>  void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> @@ -43,6 +74,101 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
>  	spin_unlock(&udp_tunnel_gro_lock);
>  }
>  EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +
> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
> +{
> +	struct udp_tunnel_type_entry *cur = NULL;
> +	struct udp_sock *up = udp_sk(sk);
> +	int i, old_gro_type_nr;
> +
> +	if (!up->gro_receive)
> +		return;
> +
> +	mutex_lock(&udp_tunnel_gro_type_lock);
> +	for (i = 0; i < udp_tunnel_gro_type_nr; i++)
> +		if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
> +			cur = &udp_tunnel_gro_types[i];
> +
> +	old_gro_type_nr = udp_tunnel_gro_type_nr;
> +	if (add) {
> +		/*
> +		 * Update the matching entry, if found, or add a new one
> +		 * if needed
> +		 */
> +		if (cur) {
> +			refcount_inc(&cur->count);
> +			goto out;
> +		}
> +
> +		if (unlikely(udp_tunnel_gro_type_nr == UDP_MAX_TUNNEL_TYPES)) {
> +			pr_err_once("Too many UDP tunnel types, please increase UDP_MAX_TUNNEL_TYPES\n");
> +			/* Ensure static call will never be enabled */
> +			udp_tunnel_gro_type_nr = UDP_MAX_TUNNEL_TYPES + 2;
> +			goto out;
> +		}
> +
> +		cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
> +		refcount_set(&cur->count, 1);
> +		cur->gro_receive = up->gro_receive;
> +	} else {
> +		/*
> +		 * The stack cleanups only successfully added tunnel, the
> +		 * lookup on removal should never fail.
> +		 */
> +		if (WARN_ON_ONCE(!cur))
> +			goto out;
> +
> +		if (!refcount_dec_and_test(&cur->count))
> +			goto out;
> +
> +		/* avoid gaps, so that the enable tunnel has always id 0 */
> +		*cur = udp_tunnel_gro_types[--udp_tunnel_gro_type_nr];
> +	}
> +
> +	if (udp_tunnel_gro_type_nr == 1) {
> +		static_call_update(udp_tunnel_gro_rcv,
> +				   udp_tunnel_gro_types[0].gro_receive);
> +		static_branch_enable(&udp_tunnel_static_call);
> +	} else if (old_gro_type_nr == 1) {
> +		static_branch_disable(&udp_tunnel_static_call);
> +		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
> +	}
> +
> +out:
> +	mutex_unlock(&udp_tunnel_gro_type_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
> +
> +static void udp_tunnel_gro_init(void)
> +{
> +	mutex_init(&udp_tunnel_gro_type_lock);
> +}
> +
> +static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
> +					  struct list_head *head,
> +					  struct sk_buff *skb)
> +{
> +	if (static_branch_likely(&udp_tunnel_static_call)) {
> +		if (unlikely(gro_recursion_inc_test(skb))) {
> +			NAPI_GRO_CB(skb)->flush |= 1;
> +			return NULL;
> +		}
> +		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
> +	}
> +	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +}
> +
> +#else
> +
> +static void udp_tunnel_gro_init(void) {}
> +
> +static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
> +					  struct list_head *head,
> +					  struct sk_buff *skb)
> +{
> +	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +}
> +
>  #endif
>  
>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
> @@ -654,7 +780,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  
>  	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
>  	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
> -	pp = call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +	pp = udp_tunnel_gro_rcv(sk, head, skb);
>  
>  out:
>  	skb_gro_flush_final(skb, pp, flush);
> @@ -804,5 +930,7 @@ int __init udpv4_offload_init(void)
>  			.gro_complete =	udp4_gro_complete,
>  		},
>  	};
> +
> +	udp_tunnel_gro_init();
>  	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
>  }
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index b5695826e57ad..c49fceea83139 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -90,6 +90,8 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>  
>  	udp_tunnel_encap_enable(sk);
>  
> +	udp_tunnel_update_gro_rcv(sock->sk, true);
> +
>  	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
>  		udp_tunnel_update_gro_lookup(net, sock->sk, true);
>  }
> -- 
> 2.48.1
> 

