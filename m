Return-Path: <netdev+bounces-23848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434476DDC7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A081C21051
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60011FBC;
	Thu,  3 Aug 2023 02:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6257F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D4C433C8;
	Thu,  3 Aug 2023 02:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691028042;
	bh=Z5aWxJBi0e7hIPzWUxMtGRgPbOWyMuVi4/7/7MSOAtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oq6dfdONFoo/G9s8gWch26lK4bW7D34X8R4VFu7dtlgWCw2CE7jrLT+sNQcykXTjU
	 SJhDu/52OBVK6O0eSNyhyxGdFpjk18qHT+HnDn4Rwx9tuKCeOGNJx21NNzQwvBiUv7
	 3gPx65N/kmuL7iMaULOdKi1EuqeMY7DnjQoJl0se99Ax831uFEc68km/mlu1alBans
	 +l7F8QD3A/2au0Tq7XxRaVT9M8P1IdtzsUlkyvHVLKVLzwhE48MkwOe5QeIX47GCUo
	 dNXDyjAa9i4Ll9YczF6by/NtfOAPykZlYG3vikd8mLMp7M3fvsNS03bu3DXOp0cBeE
	 JOb8St4ky/ZXQ==
Message-ID: <e8ca99dd-416a-f1a0-c858-1d8889a83592@kernel.org>
Date: Wed, 2 Aug 2023 20:00:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: thinker.li@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-2-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802004303.567266-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index bac768d36cc1..3059e439817a 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
>  			list_add(&rt->nh_list, &rt->nh->f6i_list);
>  		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
>  		fib6_start_gc(info->nl_net, rt);
> +
> +		if (fib6_has_expires(rt))
> +			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);

This should go before the start_gc.

--
pw-bot: cr

