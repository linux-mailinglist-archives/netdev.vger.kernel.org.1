Return-Path: <netdev+bounces-54951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE7808FD2
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4D61F20FC5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE34D5BF;
	Thu,  7 Dec 2023 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOJhjOPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A3481C9
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010DC433C7;
	Thu,  7 Dec 2023 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973601;
	bh=YvprsAVtt/XopH8kOTaH4FHDHFW4tl+W6pkRwdDiuZw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eOJhjOPDAzv+0GtL7eUzcFAXYIHWNRIjFRQ1PZLTRPfMAV0LQ5SmePSB3kblvY92v
	 Ve2/8AKG4vwAcA47vix7F+B0fdZwYXCOrf4Vif69gq1jauMW8usKNR/uHQgUJVIrPx
	 WAar4wY0Vmwq4xyxt9eZSf5g7et8BEqXcDESSgmjBEQpqA9ep30AWHpX73zWO6kva5
	 sF+pyfN3IZCwQ4GN7IoEQmbtMMky1qlYLB2PneGGzzqMT4BfHfD/T1OFNAWm2AQ+p+
	 OgiQ589cCx7MYCwTb+ecPVGU0eaXtAn/g0cgwJp2M0fJjndiQ2FPql8G4Zb2ROB47E
	 INcPLj46tq8LQ==
Message-ID: <bf30c6ec-d8cf-4093-a8e8-44fbaab06803@kernel.org>
Date: Thu, 7 Dec 2023 11:26:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
 <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
 <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
In-Reply-To: <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 11:25 AM, David Ahern wrote:
> On 12/7/23 11:22 AM, Eric Dumazet wrote:
>> Feel free to amend the patch, but the issue is that we insert a fib
>> gc_link to a list, then free the fi6 object without removing it first
>> from the external list.
> 
> yes, move the insert down:
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b132feae3393..7257ba0e72b7 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3762,12 +3762,6 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>         if (cfg->fc_flags & RTF_ADDRCONF)
>                 rt->dst_nocount = true;
> 
> -       if (cfg->fc_flags & RTF_EXPIRES)
> -               fib6_set_expires_locked(rt, jiffies +
> -
> clock_t_to_jiffies(cfg->fc_expires));
> -       else
> -               fib6_clean_expires_locked(rt);
> -
>         if (cfg->fc_protocol == RTPROT_UNSPEC)
>                 cfg->fc_protocol = RTPROT_BOOT;
>         rt->fib6_protocol = cfg->fc_protocol;
> @@ -3824,6 +3818,12 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>         } else
>                 rt->fib6_prefsrc.plen = 0;
> 
> +
> +       if (cfg->fc_flags & RTF_EXPIRES)
> +               fib6_set_expires_locked(rt, jiffies +
> +
> clock_t_to_jiffies(cfg->fc_expires));
> +       else
> +               fib6_clean_expires_locked(rt);
>         return rt;
>  out:
>         fib6_info_release(rt);


and then failure to insert into the table needs to remove it before the
release too.

