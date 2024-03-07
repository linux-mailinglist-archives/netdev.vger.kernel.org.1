Return-Path: <netdev+bounces-78318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C784A874AF2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1781F2A482
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7883A1F;
	Thu,  7 Mar 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npFvsDQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC683A1D
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804135; cv=none; b=AGsEmYqp8wPwLqhyn/tNCrYT7/587NWuHte2CcMPs4+grizOQxIEWJq7Z3qgxoRBLhc2Mi+C3ragGmL44OgekRgMGx0oBS9tpSchrucJGvOfBv3FM0u/Atr6R/asKm8vMJS16oKRLIPtfctELdbaFzBeXpDOJfyyo5ji1eIrTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804135; c=relaxed/simple;
	bh=nhLuP7JLixe3zQA+rA5jJtVvzllt0GnGZhnv+BCB4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k88/za4ZKbioMx5tZYeKCjGpuegabKLk/cdi3XCK7dD8gg3wblr3XHE0PdP+Vj0hTX7Lu/62mSPKsVSG78wuNSPBbfHuY1uDTvQQeKMfQJPDrGHgzOA8etilEze45urBk8yl9OhpNuO4skP6BKGpF4ZobIT3TpcyLygitk7YD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npFvsDQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8134AC433C7;
	Thu,  7 Mar 2024 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709804134;
	bh=nhLuP7JLixe3zQA+rA5jJtVvzllt0GnGZhnv+BCB4Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npFvsDQ17LVPkNfiw6JHpqrg5FU+J187W5JLdwtnMNtnKz6fqMBlxbXTu3NSlGtRb
	 ekway1rH8aM8pmjJUugH98G4j7bfv3lqtdmKexTxUkMfdhn2qwMYhfmIO8AJ2kfbRW
	 V/2SqTW8PHS+lfUw3+KOKKNCypCGCUwoQ90ctIMxxS+yv6ijFF3TBvJXJDaQ3oXgnk
	 W6n/eFPyWYBojtn0aQBC/N4uS7HnvbGv+nyHxKYVXba27VZawGo9kHyHJqX8ZluChj
	 QeOb1DYe1Sj1UsC3oVPrgQt3h2ulqP3JqVWzqqm5aGOsUEBboRZIwTo7EvXWV/Ya21
	 RHh0qSfEUjp7w==
Date: Thu, 7 Mar 2024 09:35:30 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] netlink: let core handle error cases in dump
 operations
Message-ID: <20240307093530.GI281974@kernel.org>
References: <20240306102426.245689-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306102426.245689-1-edumazet@google.com>

+ Ido Schimmel, David Ahern

On Wed, Mar 06, 2024 at 10:24:26AM +0000, Eric Dumazet wrote:
> After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors
> in the core"), we can remove some code that was not 100 % correct
> anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks Eric,

this looks like a nice clean-up in combination with the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/core/rtnetlink.c    | 5 +----
>  net/ipv4/devinet.c      | 4 ----
>  net/ipv4/fib_frontend.c | 7 +------
>  net/ipv6/addrconf.c     | 7 +------
>  4 files changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 780b330f8ef9fa4881b9d51570d1a65f5171ee5d..7eac6765df098fd685937ace63dfb5add9c77731 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2267,11 +2267,8 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
>  				       nlh->nlmsg_seq, 0, flags,
>  				       ext_filter_mask, 0, NULL, 0,
>  				       netnsid, GFP_KERNEL);
> -		if (err < 0) {
> -			if (likely(skb->len))
> -				err = skb->len;
> +		if (err < 0)
>  			break;
> -		}
>  	}
>  	cb->seq = tgt_net->dev_base_seq;
>  	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 4daa8124f247c256c4f8c1ff29ac621570af0755..7a437f0d41905e6acfdc35743afba3a7abfd0dd5 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -1900,8 +1900,6 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
>  			goto done;
>  	}
>  done:
> -	if (err < 0 && likely(skb->len))
> -		err = skb->len;
>  	if (fillargs.netnsid >= 0)
>  		put_net(tgt_net);
>  	rcu_read_unlock();
> @@ -2312,8 +2310,6 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
>  		ctx->all_default++;
>  	}
>  done:
> -	if (err < 0 && likely(skb->len))
> -		err = skb->len;
>  	rcu_read_unlock();
>  	return err;
>  }
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index bf3a2214fe29b6f9b494581b293259e6c5ce6f8c..48741352a88a72e0232977cc9f2cf172f45df89b 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1026,8 +1026,6 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  			goto unlock;
>  		}
>  		err = fib_table_dump(tb, skb, cb, &filter);
> -		if (err < 0 && skb->len)
> -			err = skb->len;
>  		goto unlock;
>  	}
>  
> @@ -1045,11 +1043,8 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
>  				memset(&cb->args[2], 0, sizeof(cb->args) -
>  						 2 * sizeof(cb->args[0]));
>  			err = fib_table_dump(tb, skb, cb, &filter);
> -			if (err < 0) {
> -				if (likely(skb->len))
> -					err = skb->len;
> +			if (err < 0)
>  				goto out;
> -			}
>  			dumped = 1;
>  next:
>  			e++;
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 2f84e6ecf19f48602cadb47bc378c9b5a1cdbf65..f786b65d12e43c53ed36535880f6e6d35879a44e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -793,8 +793,6 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
>  		ctx->all_default++;
>  	}
>  done:
> -	if (err < 0 && likely(skb->len))
> -		err = skb->len;
>  	rcu_read_unlock();
>  	return err;
>  }
> @@ -6158,11 +6156,8 @@ static int inet6_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
>  					NETLINK_CB(cb->skb).portid,
>  					cb->nlh->nlmsg_seq,
>  					RTM_NEWLINK, NLM_F_MULTI);
> -		if (err < 0) {
> -			if (likely(skb->len))
> -				err = skb->len;
> +		if (err < 0)
>  			break;
> -		}
>  	}
>  	rcu_read_unlock();
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
> 

