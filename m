Return-Path: <netdev+bounces-136723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38D9A2C2B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623DF1F21FCB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28921E0B74;
	Thu, 17 Oct 2024 18:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D41E0090;
	Thu, 17 Oct 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189738; cv=none; b=HyR4ZRJypbc8RJcxTEILz/h6xtcs8u7i+8r54R6hpwkf2/wSJ2DKeMQNiNu8mJUBX69yztm8aI1SJoQTbUBOf45KELktkUu7FMuW4H/MU09VDokwOArnO2u5KTqB+rW11hOYHbSMejCrhZ6g1i4rVxZYWmoxdMX5w5EQDA6OGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189738; c=relaxed/simple;
	bh=uuaudKX2orE9wyDF+rH3EySw0ewulqXBQVobjQsJkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDO7lkfLQ1zjTYNI52qPASOui7ahJ6TvrBMLBlX+9r4TY3VeNCQVIdXRbe35vS4RCKhsW6029B2BBQLab1/VT8XP/s5BkTcdN7Q+n3FU4Mfsze04Gb2kV+7csR+hdGkN3D/VopyYNHL7Q2rBwR+9wz8f5YJZwyUSy9wS8Jw5d2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1VEp-00079c-Jr; Thu, 17 Oct 2024 20:28:43 +0200
Date: Thu, 17 Oct 2024 20:28:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 07/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6_mroute_setsockopt()
Message-ID: <20241017182843.GD25857@breakpoint.cc>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-8-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017174109.85717-8-stefan.wiehler@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stefan Wiehler <stefan.wiehler@nokia.com> wrote:
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
> must be read under RCU or RTNL lock.
> 
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  net/ipv6/ip6mr.c | 165 +++++++++++++++++++++++++++--------------------
>  1 file changed, 95 insertions(+), 70 deletions(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 90d0f09cdd4e..4726b9e156c7 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1667,7 +1667,7 @@ EXPORT_SYMBOL(mroute6_is_socket);
>  int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  			  unsigned int optlen)
>  {
> -	int ret, parent = 0;
> +	int ret, flags, v, parent = 0;
>  	struct mif6ctl vif;
>  	struct mf6cctl mfc;
>  	mifi_t mifi;
> @@ -1678,48 +1678,103 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
>  		return -EOPNOTSUPP;
>  
> +	switch (optname) {
> +	case MRT6_ADD_MIF:
> +		if (optlen < sizeof(vif))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
> +			return -EFAULT;
> +		break;
> +
> +	case MRT6_DEL_MIF:
> +		if (optlen < sizeof(mifi_t))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&mifi, optval, sizeof(mifi_t)))
> +			return -EFAULT;
> +		break;
> +
> +	case MRT6_ADD_MFC:
> +	case MRT6_DEL_MFC:
> +	case MRT6_ADD_MFC_PROXY:
> +	case MRT6_DEL_MFC_PROXY:
> +		if (optlen < sizeof(mfc))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&mfc, optval, sizeof(mfc)))
> +			return -EFAULT;
> +		break;
> +
> +	case MRT6_FLUSH:
> +		if (optlen != sizeof(flags))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
> +			return -EFAULT;
> +		break;
> +
> +	case MRT6_ASSERT:
> +#ifdef CONFIG_IPV6_PIMSM_V2
> +	case MRT6_PIM:
> +#endif
> +#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
> +	case MRT6_TABLE:
> +#endif
> +		if (optlen != sizeof(v))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&v, optval, sizeof(v)))
> +			return -EFAULT;
> +		break;
> +	/*
> +	 *	Spurious command, or MRT6_VERSION which you cannot
> +	 *	set.
> +	 */
> +	default:
> +		return -ENOPROTOOPT;
> +	}
> +
> +	rcu_read_lock();

RCU read section start ...

>  	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
> +	if (!mrt) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
>  
>  	if (optname != MRT6_INIT) {
>  		if (sk != rcu_access_pointer(mrt->mroute_sk) &&
> -		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
> -			return -EACCES;
> +		    !ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +			ret = -EACCES;
> +			goto out;
> +		}
>  	}
>  
>  	switch (optname) {
>  	case MRT6_INIT:
> -		if (optlen < sizeof(int))
> -			return -EINVAL;
> +		if (optlen < sizeof(int)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  
> -		return ip6mr_sk_init(mrt, sk);
> +		ret = ip6mr_sk_init(mrt, sk);

ip6mr_sk_init() calls rtnl_lock(), which can sleep.

> +		goto out;
>  
>  	case MRT6_DONE:
> -		return ip6mr_sk_done(sk);
> +		ret = ip6mr_sk_done(sk);

Likewise.

>  	case MRT6_ADD_MIF:
> -		if (optlen < sizeof(vif))
> -			return -EINVAL;
> -		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
> -			return -EFAULT;
> -		if (vif.mif6c_mifi >= MAXMIFS)
> -			return -ENFILE;
> +		if (vif.mif6c_mifi >= MAXMIFS) {
> +			ret = -ENFILE;
> +			goto out;
> +		}
>  		rtnl_lock();

Same, sleeping function called in rcu read side section.

Maybe its time to add refcount_t to struct mr_table?

