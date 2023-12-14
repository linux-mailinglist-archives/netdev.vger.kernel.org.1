Return-Path: <netdev+bounces-57234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51898127C1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D1A1F210D0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF57CA61;
	Thu, 14 Dec 2023 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arz0/bvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EC63D9
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A6C433C7;
	Thu, 14 Dec 2023 06:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702534286;
	bh=tYFL0xD01DL2MkUj1sOCXb3o3sRscD10LSd8tR8Yt8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Arz0/bvyp42JbQoRq9zAEMpVJelWpH9VuO6S25uY2JrVkJtUeUdY8Oo5T3H7v79r/
	 yqbTI1qlh/Yg/XnMzA7DwiknH9rhqO3rzl2ltB4OxgUs9EJ36BkgvbfLQDngoYN0IQ
	 uR1eemwbnLtBs6g+C1t+D3pEoxn+9XgKL4WUlfatA1Qns6jDGF3q0v7ZMLzqScg4la
	 ew8qP89OIKCoNW+zo/vyGjnXvSecMs8G8S1KXlj7x86ZOSHvmoF26s0YazZhWbPfgg
	 1PM4Yimg4Gna8ptd8kAe2DYkeh08jGgw22O+ss2MuI6MxWRRBj60TrWVQR7yNgXVp1
	 iGHfFW0AqBp6g==
Message-ID: <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
Date: Wed, 13 Dec 2023 22:11:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-2-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231213213735.434249-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 2:37 PM, thinker.li@gmail.com wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b132feae3393..dcaeb88d73aa 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3763,10 +3763,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>  		rt->dst_nocount = true;
>  
>  	if (cfg->fc_flags & RTF_EXPIRES)
> -		fib6_set_expires_locked(rt, jiffies +
> -					clock_t_to_jiffies(cfg->fc_expires));
> +		__fib6_set_expires(rt, jiffies +
> +				   clock_t_to_jiffies(cfg->fc_expires));
>  	else
> -		fib6_clean_expires_locked(rt);
> +		__fib6_clean_expires(rt);

as Eric noted in a past comment, the clean is not needed in this
function since memory is initialized to 0 (expires is never set).

Also, this patch set does not fundamentally change the logic, so it
cannot fix the bug reported in

https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/

please hold off future versions of this set until the problem in that
stack traced is fixed. I have tried a few things using RA's, but have
not been able to recreate UAF.

