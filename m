Return-Path: <netdev+bounces-55350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA580A829
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C7C1F21036
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783635289;
	Fri,  8 Dec 2023 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIPwRceU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826D347DF
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FDBC433C8;
	Fri,  8 Dec 2023 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702051604;
	bh=6yqhLJTH7cwdGu7GCwuCX26R5k/m2WdF4DPqxvwFoc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OIPwRceUaptuNjQBbl4odDYy8M743FBjDLIL9GcofoZY++eZZzdx1CkcKhQZylBva
	 newygO4IW0RMIBnPClgB4lze5NpRwXleqVsrZd0y0sf89MI9IEJLkioFY5KOPJT8Gd
	 thh1XVB7ZTobVaqTimPHYzhAR6efOm4K4yNZy9Ohw1E6ybfe5z58z+MXXSq3Dul1R9
	 4Ux79+YU9iFuU6NSAZitzMobuKpAEHvh4U6mwXreuGIdO72HCbJtXBpjEDxKh09ZdU
	 XEMsgqqlTZ0BmVuF8d0ZKeRbWKgtofC+j5WTsC/jcfObrIqgyLDzjKHvexaE5kMXIC
	 x8OU9lpmasY/w==
Message-ID: <ac7f9748-7219-4cf1-961d-df4290ccc689@kernel.org>
Date: Fri, 8 Dec 2023 09:06:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ipv6: annotate data-races around
 np->mcast_oif
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231208101244.1019034-1-edumazet@google.com>
 <20231208101244.1019034-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208101244.1019034-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 3:12 AM, Eric Dumazet wrote:
> np->mcast_oif is read locklessly in some contexts.
> 
> Make all accesses to this field lockless, adding appropriate
> annotations.
> 
> This also makes setsockopt( IPV6_MULTICAST_IF ) lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/dccp/ipv6.c                 |  2 +-
>  net/ipv6/datagram.c             |  4 +-
>  net/ipv6/icmp.c                 |  4 +-
>  net/ipv6/ipv6_sockglue.c        | 74 +++++++++++++++++----------------
>  net/ipv6/ping.c                 |  4 +-
>  net/ipv6/raw.c                  |  2 +-
>  net/ipv6/tcp_ipv6.c             |  2 +-
>  net/ipv6/udp.c                  |  2 +-
>  net/l2tp/l2tp_ip6.c             |  2 +-
>  net/netfilter/ipvs/ip_vs_sync.c |  2 +-
>  net/rds/tcp_listen.c            |  2 +-
>  11 files changed, 51 insertions(+), 49 deletions(-)
> 


> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 7d661735cb9d519ab4691979f30365acda0a28c3..fe7e96e69960c013e84b48242e309525f7f618da 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -509,6 +509,34 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  		if (optlen < sizeof(int))
>  			return -EINVAL;
>  		return ip6_sock_set_addr_preferences(sk, val);
> +	case IPV6_MULTICAST_IF:
> +		if (sk->sk_type == SOCK_STREAM)
> +			return -ENOPROTOOPT;
> +		if (optlen < sizeof(int))
> +			return -EINVAL;
> +		if (val) {
> +			struct net_device *dev;
> +			int bound_dev_if, midx;
> +
> +			rcu_read_lock();
> +
> +			dev = dev_get_by_index_rcu(net, val);
> +			if (!dev) {
> +				rcu_read_unlock();
> +				return -ENODEV;
> +			}
> +			midx = l3mdev_master_ifindex_rcu(dev);
> +
> +			rcu_read_unlock();
> +
> +			bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);

you snuck in an extra change with that code move.

Reviewed-by: David Ahern <dsahern@kernel.org>


> +			if (bound_dev_if &&
> +			    bound_dev_if != val &&
> +			    (!midx || midx != bound_dev_if))
> +				return -EINVAL;
> +		}
> +		WRITE_ONCE(np->mcast_oif, val);
> +		return 0;
>  	}
>  	if (needs_rtnl)
>  		rtnl_lock();
> @@ -860,36 +888,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  		break;
>  	}
>  
> -	case IPV6_MULTICAST_IF:
> -		if (sk->sk_type == SOCK_STREAM)
> -			break;
> -		if (optlen < sizeof(int))
> -			goto e_inval;
> -
> -		if (val) {
> -			struct net_device *dev;
> -			int midx;
> -
> -			rcu_read_lock();
> -
> -			dev = dev_get_by_index_rcu(net, val);
> -			if (!dev) {
> -				rcu_read_unlock();
> -				retv = -ENODEV;
> -				break;
> -			}
> -			midx = l3mdev_master_ifindex_rcu(dev);
> -
> -			rcu_read_unlock();
> -
> -			if (sk->sk_bound_dev_if &&
> -			    sk->sk_bound_dev_if != val &&
> -			    (!midx || midx != sk->sk_bound_dev_if))
> -				goto e_inval;
> -		}
> -		np->mcast_oif = val;
> -		retv = 0;
> -		break;
>  	case IPV6_ADD_MEMBERSHIP:
>  	case IPV6_DROP_MEMBERSHIP:
>  	{



