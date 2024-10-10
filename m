Return-Path: <netdev+bounces-134145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D5A998293
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A4C1C26DDE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150811B5337;
	Thu, 10 Oct 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLmSsD5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17711946C8;
	Thu, 10 Oct 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553295; cv=none; b=HgYhN5x0mw0Zigs5RidQtc/oIEngCg8BP4qxl3jo5us6dGa4FoSDINNgDuggE8XykqXXxVf2Bz+qyiZgWy7gsIvRWs4UGQ8sF0+f6wr7tODyeNmgLcfEIKkWLpcZJkGOt3cpJfN6r8sS2VjG3KaazazP/K9O2uGnZNDy0f9ISw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553295; c=relaxed/simple;
	bh=5O+UpFPebLYLebTl+sL0ZAbnmq5acbF5JPs5rpoBhOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBLn5u3AEYDIrhXkw4dhtw8fU0/HVUF6kkFmOnTPEjlj31Kmf/lpW4cElcD56z2m8MNhNE9Hajf0KKzISJZ3xTykSOGghNIwO8G3teI/AlCLt90V3mzEVSWXqPyReyza3FeLE3i3pjAsxpzDsF2e/FoFyVHZ4Uz//EkF/H47vcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLmSsD5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4B2C4CEC5;
	Thu, 10 Oct 2024 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553294;
	bh=5O+UpFPebLYLebTl+sL0ZAbnmq5acbF5JPs5rpoBhOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLmSsD5KzkHUBtJ9uXNBgdVS9SgecIPeX8D+UvKW8HYmavKXNYPS4K9Jr5IGRPDvY
	 nK+sXzXzoTTBDtZaCigThcmqlH9keEM+eInNt/27J7CqWwElbdZjsHtCjwrMQnUFrg
	 QL0gPJNk8C4hfJcR1SLSArNoyX27FxnMCpdq/ngdRPN4x09lg7FEFl4XP5e2NURzUR
	 k6jm1wR+zdYqJZdBfAtzWOnC5NlxcPfAITtreteeHUye4NUs9erqmVf+7wl4p22uSP
	 xPWiLx0Ef71pJ4XDXEo/ceFxN0a1jXw03lPjP6SMiHSNyJStuVAH+r1CF5XdPDbBjo
	 AzgdTCKSe/TZQ==
Date: Thu, 10 Oct 2024 10:41:30 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_compat_ioctl()
Message-ID: <20241010094130.GA1098236@kernel.org>
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
 <20241010090741.1980100-7-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010090741.1980100-7-stefan.wiehler@nokia.com>

On Thu, Oct 10, 2024 at 11:07:44AM +0200, Stefan Wiehler wrote:
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
> must be done under RCU or RTNL lock. Copy from user space must be
> performed beforehand as we are not allowed to sleep under RCU lock.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> ---
> v3:
>   - split into separate patches
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
>   - rebase on top of net tree
>   - add Fixes tag
>   - refactor out paths
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
> ---
>  net/ipv6/ip6mr.c | 46 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index b18eb4ad21e4..415ba6f55a44 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1961,10 +1961,7 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>  	struct mfc6_cache *c;
>  	struct net *net = sock_net(sk);
>  	struct mr_table *mrt;
> -
> -	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
> -	if (!mrt)
> -		return -ENOENT;
> +	int err;
>  
>  	switch (cmd) {
>  	case SIOCGETMIFCNT_IN6:
> @@ -1972,8 +1969,30 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>  			return -EFAULT;
>  		if (vr.mifi >= mrt->maxvif)
>  			return -EINVAL;

Hi Stefan,

mrt is now used uninitialised here.

> +		break;
> +	case SIOCGETSGCNT_IN6:
> +		if (copy_from_user(&sr, arg, sizeof(sr)))
> +			return -EFAULT;
> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +
> +	rcu_read_lock();
> +	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
> +	if (!mrt) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	switch (cmd) {
> +	case SIOCGETMIFCNT_IN6:
> +		if (vr.mifi >= mrt->maxvif) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
> -		rcu_read_lock();
>  		vif = &mrt->vif_table[vr.mifi];
>  		if (VIF_EXISTS(mrt, vr.mifi)) {
>  			vr.icount = READ_ONCE(vif->pkt_in);

...

> @@ -2004,11 +2020,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>  				return -EFAULT;
>  			return 0;
>  		}
> -		rcu_read_unlock();
> -		return -EADDRNOTAVAIL;
> -	default:
> -		return -ENOIOCTLCMD;
> +		err = -EADDRNOTAVAIL;
> +		goto out;
>  	}
> +

I think that this out label should be used consistently once rcu_read_lock
has been taken. With this patch applied there seems to be one case on error
where rcu_read_unlock() before returning, and one case where it isn't
(which looks like it leaks the lock).

> +out:
> +	rcu_read_unlock();
> +	return err;
>  }
>  #endif

-- 
pw-bot: changes-requested

