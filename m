Return-Path: <netdev+bounces-53160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212A801805
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7921F21034
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27003F8C3;
	Fri,  1 Dec 2023 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBOLWp66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDE51C25
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 23:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD71FC433C8;
	Fri,  1 Dec 2023 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701474309;
	bh=QdM9GLjsIHa2nVQBKUP1xpBFF5Q0ObM8zbnyWYoRzS8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XBOLWp6657Xp0Goo21kUeVnKTqDa93nfH8Slf9SNnoO8m2VNQHL9lZQuwTVmpBKIP
	 2xIBn6KbNm+nfvyChRh+13zOc6UJunZF2qTmpJs3NZ5pOe0GTx9rOibZCt6t8cwMmi
	 vanBldfcDO1P3dEkoFQBPg5KqJyr5CJr03A9AxnCUazizlZ05XB/vEexIueXtW2XUy
	 A7Md/ks/+yacZwTTv6EAtD+0D2GVDNCsUxjOPJllmU1l6POTZGYJN4hG4lkdJQCSRT
	 5FUFregou2c/vKjMdp4JRaTj0WG6nkB+CCBMzPvL3BWWeDUTPEk+RYW0pgGSUmHddQ
	 NqYySxnUH5uMQ==
Date: Fri, 1 Dec 2023 15:45:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: David Laight <David.Laight@aculab.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
    Stephen Hemminger <stephen@networkplumber.org>, 
    Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    "jakub@cloudflare.com" <jakub@cloudflare.com>
Subject: Re: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
In-Reply-To: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
Message-ID: <896de7c3-5d7f-4b06-5159-ed58c350bafc@kernel.org>
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Nov 2023, David Laight wrote:

> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
>
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
>
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
>
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
> include/net/inet_sock.h         |  5 +----
> include/net/ip.h                |  7 ++++++-
> include/net/netns/ipv4.h        |  3 +--
> net/ipv4/af_inet.c              |  4 +---
> net/ipv4/inet_connection_sock.c | 29 ++++++++++------------------
> net/ipv4/ip_sockglue.c          | 34 ++++++++++++++++-----------------
> net/ipv4/sysctl_net_ipv4.c      | 12 ++++--------
> 7 files changed, 40 insertions(+), 54 deletions(-)
>
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 74db6d97cae1..ebf71410aa2b 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -234,10 +234,7 @@ struct inet_sock {
> 	int			uc_index;
> 	int			mc_index;
> 	__be32			mc_addr;
> -	struct {
> -		__u16 lo;
> -		__u16 hi;
> -	}			local_port_range;
> +	u32			local_port_range;
>
> 	struct ip_mc_socklist __rcu	*mc_list;
> 	struct inet_cork_full	cork;
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 1fc4c8d69e33..154f9dd75fe6 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -349,7 +349,12 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
> 	} \
> }
>
> -void inet_get_local_port_range(const struct net *net, int *low, int *high);
> +static inline void inet_get_local_port_range(const struct net *net, int *low, int *high)
> +{
> +	u32 range = READ_ONCE(net->ipv4.ip_local_ports.range);
> +	*low = range & 0xffff;
> +	*high = range >> 16;
> +}
> void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
>
> #ifdef CONFIG_SYSCTL
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 73f43f699199..30ba5359da84 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -19,8 +19,7 @@ struct hlist_head;
> struct fib_table;
> struct sock;
> struct local_ports {
> -	seqlock_t	lock;
> -	int		range[2];
> +	u32		range;	/* high << 16 | low */
> 	bool		warned;
> };
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..b8964b40c3c0 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1847,9 +1847,7 @@ static __net_init int inet_init_net(struct net *net)
> 	/*
> 	 * Set defaults for local port range
> 	 */
> -	seqlock_init(&net->ipv4.ip_local_ports.lock);
> -	net->ipv4.ip_local_ports.range[0] =  32768;
> -	net->ipv4.ip_local_ports.range[1] =  60999;
> +	net->ipv4.ip_local_ports.range =  60999 << 16 | 32768;

Hi David -

Better to use unsigned integer constants here, since 60999 << 16 doesn't 
fit in a signed int on 32-bit platforms.

>
> 	seqlock_init(&net->ipv4.ping_group_range.lock);
> 	/*
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 394a498c2823..1a45d41f8b39 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -117,34 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
> 	return !sk->sk_rcv_saddr;
> }
>
> -void inet_get_local_port_range(const struct net *net, int *low, int *high)
> -{
> -	unsigned int seq;
> -
> -	do {
> -		seq = read_seqbegin(&net->ipv4.ip_local_ports.lock);
> -
> -		*low = net->ipv4.ip_local_ports.range[0];
> -		*high = net->ipv4.ip_local_ports.range[1];
> -	} while (read_seqretry(&net->ipv4.ip_local_ports.lock, seq));
> -}
> -EXPORT_SYMBOL(inet_get_local_port_range);
> -
> void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
> {
> 	const struct inet_sock *inet = inet_sk(sk);
> 	const struct net *net = sock_net(sk);
> 	int lo, hi, sk_lo, sk_hi;
> +	u32 sk_range;
>
> 	inet_get_local_port_range(net, &lo, &hi);
>
> -	sk_lo = inet->local_port_range.lo;
> -	sk_hi = inet->local_port_range.hi;
> +	sk_range = READ_ONCE(inet->local_port_range);
> +	if (unlikely(sk_range)) {
> +		sk_lo = sk_range & 0xffff;
> +		sk_hi = sk_range >> 16;
>
> -	if (unlikely(lo <= sk_lo && sk_lo <= hi))
> -		lo = sk_lo;
> -	if (unlikely(lo <= sk_hi && sk_hi <= hi))
> -		hi = sk_hi;
> +		if (unlikely(lo <= sk_lo && sk_lo <= hi))
> +			lo = sk_lo;
> +		if (unlikely(lo <= sk_hi && sk_hi <= hi))
> +			hi = sk_hi;
> +	}
>
> 	*low = lo;
> 	*high = hi;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 2efc53526a38..bf940fe249a5 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1055,6 +1055,20 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
> 	case IP_TOS:	/* This sets both TOS and Precedence */
> 		ip_sock_set_tos(sk, val);
> 		return 0;
> +
> +	case IP_LOCAL_PORT_RANGE:
> +	{
> +		const __u16 lo = val;
> +		const __u16 hi = val >> 16;

Suggest casting 'val' to an unsigned int before shifting right, even 
though assigning to a __u16 will mask off any surprising bits introduced 
by an arithmetic right shift of a 32-bit signed int.

> +
> +		if (optlen != sizeof(__u32))
> +			return -EINVAL;
> +		if (lo != 0 && hi != 0 && lo > hi)
> +			return -EINVAL;
> +
> +		WRITE_ONCE(inet->local_port_range, val);
> +		return 0;
> +	}
> 	}
>
> 	err = 0;
> @@ -1332,20 +1346,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
> 		err = xfrm_user_policy(sk, optname, optval, optlen);
> 		break;
>
> -	case IP_LOCAL_PORT_RANGE:
> -	{
> -		const __u16 lo = val;
> -		const __u16 hi = val >> 16;
> -
> -		if (optlen != sizeof(__u32))
> -			goto e_inval;
> -		if (lo != 0 && hi != 0 && lo > hi)
> -			goto e_inval;
> -
> -		inet->local_port_range.lo = lo;
> -		inet->local_port_range.hi = hi;
> -		break;
> -	}
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;
> @@ -1692,6 +1692,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
> 			return -EFAULT;
> 		return 0;
> 	}
> +	case IP_LOCAL_PORT_RANGE:
> +		val = READ_ONCE(inet->local_port_range);
> +		goto copyval;
> 	}
>
> 	if (needs_rtnl)
> @@ -1721,9 +1724,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
> 		else
> 			err = ip_get_mcast_msfilter(sk, optval, optlen, len);
> 		goto out;
> -	case IP_LOCAL_PORT_RANGE:
> -		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
> -		break;
> 	case IP_PROTOCOL:
> 		val = inet_sk(sk)->inet_num;
> 		break;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index f63a545a7374..b008b6b5e85d 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -54,22 +54,18 @@ static void set_local_port_range(struct net *net, int range[2])
> {
> 	bool same_parity = !((range[0] ^ range[1]) & 1);
>
> -	write_seqlock_bh(&net->ipv4.ip_local_ports.lock);
> 	if (same_parity && !net->ipv4.ip_local_ports.warned) {
> 		net->ipv4.ip_local_ports.warned = true;
> 		pr_err_ratelimited("ip_local_port_range: prefer different parity for start/end values.\n");
> 	}
> -	net->ipv4.ip_local_ports.range[0] = range[0];
> -	net->ipv4.ip_local_ports.range[1] = range[1];
> -	write_sequnlock_bh(&net->ipv4.ip_local_ports.lock);
> +	WRITE_ONCE(net->ipv4.ip_local_ports.range, range[1] << 16 | range[0]);

Similar, make sure the value is cast to unsigned before shifting here.


- Mat


