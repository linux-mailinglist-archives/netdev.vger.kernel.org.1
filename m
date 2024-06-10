Return-Path: <netdev+bounces-102315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13990259B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F41F2668C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55D1422CA;
	Mon, 10 Jun 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMkZiDEd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BC13DDCE;
	Mon, 10 Jun 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033196; cv=none; b=Ev9iQ/XO+8wjuUgWVI/FZkeUZyXFWbcj9kaR9kzaX5XYXLZ+QqM/b3sFq9tPTF58vFZdylwI9NjtCq5y8/Mju0B77yj2DhmPRjiZG/vjFWaU7DxR1P28QI8xB1QgyQVlwM/pZvjbSiqS44IYqPWcSKKXx4DwbXX0eZG+Zs/Teuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033196; c=relaxed/simple;
	bh=+P//XT9LpP0LIIRJBKW993XarkxuDVFv2zbFBsCkT3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVQq8Ttlrae6gOyAPO6HDvGgnWV5KrrPcoN+nWcgHyd0JAT8NkxDV7jOUj4rUSBe4IXnRBz8tDYZLcmEE4V4B3IzNvIFj5ArVZrefrKXPmMOixnmyQjJ4Ay8QIQbSBJvneOJRjI75v4Mk9n0yDh6TzlY5sCobi7nma9RKhjWiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMkZiDEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7D2C2BBFC;
	Mon, 10 Jun 2024 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718033195;
	bh=+P//XT9LpP0LIIRJBKW993XarkxuDVFv2zbFBsCkT3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IMkZiDEd9X+iU0t29dUnCUCFNrscsW0jgsnZumoTV91muoYrYy+pCe20PH8op+qF7
	 wwd9wLPnuqQcNrqTZiJ8b7Hy08j/nBPXqzHz5tay7KUZ2rSo8mCF/Ai/0eeGysrQV9
	 p/J2MKg2o4vXLOE9FRSafvwfHV86qRnUV3dZmIj4dlKM3OFVgAnRScqyUhlDNyUsKx
	 xOWcsFYDgY1SOEBTJTxB0P4fer/6KHp4AGGQNW2eqmpD5cM0SRDVdFHaRStBMk+r8/
	 aRrZkBoEc8Tk8v+qT1ezE1T5CMUpTjP5PmTqRqq44Vn5skzh0ho1bqVP0XVbV/CJky
	 6F8yCZ4u86EIg==
Message-ID: <aa571ef1-80dc-4a20-8726-65193b565728@kernel.org>
Date: Mon, 10 Jun 2024 09:26:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/ipv6: Fix the RT cache flush via sysctl using
 a previous delay
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240607112828.30285-1-petr.pavlu@suse.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240607112828.30285-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 5:28 AM, Petr Pavlu wrote:
> The net.ipv6.route.flush system parameter takes a value which specifies
> a delay used during the flush operation for aging exception routes. The
> written value is however not used in the currently requested flush and
> instead utilized only in the next one.
> 
> A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
> of net->ipv6.sysctl.flush_delay into a local delay variable and then
> calls proc_dointvec() which actually updates the sysctl based on the
> provided input.
> 
> Fix the problem by switching the order of the two operations.
> 
> Fixes: 4990509f19e8 ("[NETNS][IPV6]: Make sysctls route per namespace.")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> 
> Changes since v1 [1]:
> - Minimize the fix, correct only the order of operations in
>   ipv6_sysctl_rtcache_flush().
> 
> [1] https://lore.kernel.org/netdev/20240529135251.4074-1-petr.pavlu@suse.com/
> 
>  net/ipv6/route.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index f083d9faba6b..952c2bf11709 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6343,12 +6343,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
>  	if (!write)
>  		return -EINVAL;
>  
> -	net = (struct net *)ctl->extra1;
> -	delay = net->ipv6.sysctl.flush_delay;
>  	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
>  	if (ret)
>  		return ret;
>  
> +	net = (struct net *)ctl->extra1;
> +	delay = net->ipv6.sysctl.flush_delay;
>  	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
>  	return 0;
>  }
> 
> base-commit: 8a92980606e3585d72d510a03b59906e96755b8a


Reviewed-by: David Ahern <dsahern@kernel.org>


