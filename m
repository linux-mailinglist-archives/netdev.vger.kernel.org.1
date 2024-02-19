Return-Path: <netdev+bounces-72881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BDE85A052
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E651C20BA3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C925114;
	Mon, 19 Feb 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp7nDrH2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A24B5B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336460; cv=none; b=qGpAR6+jN8s6bYFEaNRHBs7/dcH7Dzx9x2NcJD9Zt6XITZbWpOhmjXMVprB7ZeZwH30d+F7GW4zBELKjkTmgB7PeeiPZuY/OrH2nyBOPuHILetuuIDM5E5TymemGa5c4RMU4qMpvAdzg2jLtciJY4pBkG56IcdW0vdtmmrLS8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336460; c=relaxed/simple;
	bh=eKHerGPEm1F87r5a7mg/1cWsJuRlXJiKhVep+HDLxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+QUyic1ovXgzec3BAhvVcXsQ+WWqEm/gWFIiGjfHqcTY7fjU3wlWQsVYkFciziV3BqPBTTLHEoJcg0NL/LBRTkcmoIEWEqILnE/yuOGMnOAbwktAs6PaCMhC6chKPgGs9SC9gfVdu7n7mGtG6GmI2AIb0ZOZDyu8SGWhjDvXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp7nDrH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045EBC433C7;
	Mon, 19 Feb 2024 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708336460;
	bh=eKHerGPEm1F87r5a7mg/1cWsJuRlXJiKhVep+HDLxh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp7nDrH2Mqp3D2zSx67dpacfwIA6q3rcY5WVWlmwaUeY/SIqUt2cqmiG47tC7LrAx
	 NFhiS3clwx4c3S2YRVFqs78sVjlgCxJtIWJHILfwqbeaQjEm88jnC+vLB2l/O4kPJ8
	 kPJqcjz0LlLvQcBrPXIciCwO218P86d9Ro2zVPtwSkortU9IWf/2IFfdzfWc6jYY+h
	 F5bLZlBGsAj588H/u/TV3XDhfqBznqmPP+pANOzjL5YU2HJkpXMpdkTe0Crwl4uVur
	 g2smtLmHcD4kWqQOmW9BG0A0t44kzHi1ahplalKt5dl7IRsnBervhZjin4Ng7QqC1v
	 SkutIXVLuDpXg==
Date: Mon, 19 Feb 2024 09:52:47 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mctp: take ownership of skb in mctp_local_output
Message-ID: <20240219095247.GV40273@kernel.org>
References: <f05c0c62d33fda70c7443287b2769d3eb1b3356c.1707983334.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05c0c62d33fda70c7443287b2769d3eb1b3356c.1707983334.git.jk@codeconstruct.com.au>

On Thu, Feb 15, 2024 at 03:53:09PM +0800, Jeremy Kerr wrote:
> Currently, mctp_local_output only takes ownership of skb on success, and
> we may leak an skb if mctp_local_output fails in specific states; the
> skb ownership isn't transferred until the actual output routing occurs.
> 
> Instead, make mctp_local_output free the skb on all error paths up to
> the route action, so it always consumes the passed skb.
> 
> Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

...

> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index 7a47a58aa54b..a64788bc40a8 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -888,7 +888,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
>  		dev = dev_get_by_index_rcu(sock_net(sk), cb->ifindex);
>  		if (!dev) {
>  			rcu_read_unlock();
> -			return rc;
> +			goto out_free;
>  		}
>  		rt->dev = __mctp_dev_get(dev);
>  		rcu_read_unlock();
> @@ -903,7 +903,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
>  		rt->mtu = 0;
>  
>  	} else {
> -		return -EINVAL;
> +		goto out_free;

Hi Jeremy,

Previously this path returned -EINVAL. Now it will return rc.
But by my reading rc is set to -ENODEV here.
Should that be addressed?

>  	}
>  
>  	spin_lock_irqsave(&rt->dev->addrs_lock, flags);
> @@ -966,12 +966,17 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
>  		rc = mctp_do_fragment_route(rt, skb, mtu, tag);
>  	}
>  
> +	/* route output functions consume the skb, even on error */
> +	skb = NULL;
> +
>  out_release:
>  	if (!ext_rt)
>  		mctp_route_release(rt);
>  
>  	mctp_dev_put(tmp_rt.dev);
>  
> +out_free:
> +	kfree_skb(skb);
>  	return rc;
>  }
>  
> -- 
> 2.39.2
> 
> 

