Return-Path: <netdev+bounces-225001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FAB8CDFE
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD3F1B26288
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D98306495;
	Sat, 20 Sep 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSN+mFiG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDC21ABC9;
	Sat, 20 Sep 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389815; cv=none; b=QfTpqDsyZ4kHiHTFxke2ybxLoZDJcD4ficY+Vr+uyR7clYLA3k9wUsoRuVYV7ggeWFia5TzJOel74k0B2PiPaDfrk+Tf1jayVSBEsXXnZ/wLjPImzNtvsNuQ7jSYwMl2Nl04LSG/swLpOq3uYkUj+tbNVplrynIB83ORh2UPaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389815; c=relaxed/simple;
	bh=bBKmMy4eylNzgrCT2jsvWF8aardX3t0sWZo4Y8ORPXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi8RTXRgGJjcvCqBp6ZkjfTYqsMZULcaVc9/gYn47jpLA2cNefs4LnfY6ryCOXRGe/FAozLYFytrPeGkLe3HZoFJiRC48Mqc6hQoseloYvbyBG6WMC0pjY7G5bwC5vCg4BlR52PGd5Gcp1oAN0mr6/h7b7R5kiVBPVel6/x8qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSN+mFiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C7C4CEEB;
	Sat, 20 Sep 2025 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758389815;
	bh=bBKmMy4eylNzgrCT2jsvWF8aardX3t0sWZo4Y8ORPXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sSN+mFiGswwUlZWrglJA/+kCBTrxIDzhE17f0spBJ1cYq9Z339/L+kmMbno708jO9
	 Cd2KSDvYIEUEcjxftQMnk7dLpokp4wjOpVoFYw0hPI7kFSzbhaxS8j2YmXmCk6und9
	 7QZ/qR8Ynuw0a7CSARQVgvyfo1+AcBhMnQISPjk5d+J1SSaMROZxYTC1MLjKETICjK
	 0eoUXBb8CUM9VeMMFU2mH2gMn6JO1qmVlhHVP47l2cx5bPuWifVIVA4kwwCGuhK3ag
	 gcoz8sdoDcDMMh2dAiZD0MhdY//IX4WIcOmcEZRHVlFja3JQgu4s6zp2HoRAgPoC+V
	 +XgMR5xsoLU0Q==
Message-ID: <182ceffb-b038-4c4f-9c3b-383351a043d5@kernel.org>
Date: Sat, 20 Sep 2025 19:36:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250918084823.372000-1-dtatulea@nvidia.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250918084823.372000-1-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/09/2025 10.48, Dragos Tatulea wrote:
> Direct page releases to cache must be done on the same CPU as where NAPI
> is running. Not doing so results in races that are quite difficult to
> debug.
> 
> This change adds a debug configuration which issues a warning when
> such buggy behaviour is encountered.
> 
> Signed-off-by: Dragos Tatulea<dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan<tariqt@nvidia.com>
> ---
>   net/Kconfig.debug    | 10 +++++++
>   net/core/page_pool.c | 66 ++++++++++++++++++++++++++------------------
>   2 files changed, 49 insertions(+), 27 deletions(-)
> 
[...]

> @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
>   		return false;
>   	}
>   
> +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
> +	if (unlikely(!page_pool_napi_local(pool))) {
> +		u32 pp_cpuid = READ_ONCE(pool->cpuid);
> +		u32 cpuid = smp_processor_id();
> +
> +		WARN_RATELIMIT(1, "page_pool %d: direct page release from wrong CPU %d, expected CPU %d",
> +			       pool->user.id, cpuid, pp_cpuid);
> +
> +		return false;
> +	}
> +#endif

The page_pool_recycle_in_cache() is an extreme fast-path for page_pool.
I know this is a debugging patch, but I would like to know the overhead
this adds (when enabled, compared to not enabled).

We (Mina) recently added a benchmark module for page_pool
under tools/testing/selftests/net/bench/page_pool/ that you can use.

Adding a WARN in fast-path code need extra careful review (maybe is it
okay here), this is because it adds an asm instruction (on Intel CPUs
ud2) what influence instruction cache prefetching.  Looks like this only
gets inlined two places (page_pool_put_unrefed_netmem and
page_pool_put_page_bulk), and it might be okay... I think it is.
See how I worked around this in commit 34cc0b338a61 ("xdp: Xdp_frame add
member frame_sz and handle in convert_to_xdp_frame").

--Jesper

