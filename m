Return-Path: <netdev+bounces-58289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78B815B93
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431B51F2393A
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE74328C5;
	Sat, 16 Dec 2023 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6zBWbkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067434543
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5180C433C7;
	Sat, 16 Dec 2023 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702757579;
	bh=LIm7Dz5snfAFXUEJzX/fp4f2C8YE/qn45EFVgfIsR14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6zBWbkIMVihQHhLVsH++QxmIrSGloeTl7CRdruBHTGJeRMxhhasu2D7/IniSa0Uf
	 TkdTZrTeRQCAyY1a2/oHUKg0kAG2wRsmRs6kAml/lVhjqH5jUs1k/aOP0CZ2s5LFH9
	 pi556JTIwZC1H1nAbPFifj4non3zC8T+EubT20Bw/EHLJAo2upvNlRSfAUs4JxUH1j
	 LqN6eeu4h0Kj006v4f5SIXNAaqKY4UrALTP+IBPAjPLiQvV9fdCo1wOm3WT/++4lP9
	 yIk2LobajZ595SXHjAKMNTZwiSaubZYMt5g3s2JGNtmbGbtgjNY8pqSyvaJEbcBOth
	 ANLp+Q5R9lxWA==
Date: Sat, 16 Dec 2023 20:12:54 +0000
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 3/3] net: sched: Add initial TC error skb
 drop reasons
Message-ID: <20231216201254.GV6288@kernel.org>
References: <20231214203532.3594232-1-victor@mojatatu.com>
 <20231214203532.3594232-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214203532.3594232-4-victor@mojatatu.com>

On Thu, Dec 14, 2023 at 05:35:32PM -0300, Victor Nogueira wrote:
> Continue expanding Daniel's patch by adding new skb drop reasons that
> are idiosyncratic to TC.
> 
> More specifically:
> 
> - SKB_DROP_REASON_TC_EXT_COOKIE_ERROR: An error occurred whilst
>   processing a tc ext cookie.
> 
> - SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.
> 
> - SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
>   iterations
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/dropreason-core.h | 18 +++++++++++++++---
>  net/sched/act_api.c           |  3 ++-
>  net/sched/cls_api.c           | 22 ++++++++++++++--------
>  3 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 278e4c7d465c..dea361b3555d 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -85,8 +85,10 @@
>  	FN(IPV6_NDISC_BAD_OPTIONS)	\
>  	FN(IPV6_NDISC_NS_OTHERHOST)	\
>  	FN(QUEUE_PURGE)			\
> -	FN(TC_ERROR)			\
> +	FN(TC_COOKIE_ERROR)		\
>  	FN(PACKET_SOCK_ERROR)		\
> +	FN(TC_CHAIN_NOTFOUND)		\
> +	FN(TC_RECLASSIFY_LOOP)		\
>  	FNe(MAX)
>  
>  /**
> @@ -377,13 +379,23 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>  	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
>  	SKB_DROP_REASON_QUEUE_PURGE,
> -	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
> -	SKB_DROP_REASON_TC_ERROR,
> +	/**
> +	 * @SKB_DROP_REASON_TC_EXT_COOKIE_ERROR: An error occurred whilst

nit: @SKB_DROP_REASON_TC_COOKIE_ERROR

> +	 * processing a tc ext cookie.
> +	 */
> +	SKB_DROP_REASON_TC_COOKIE_ERROR,
>  	/**
>  	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
>  	 * after its filter matches an incoming packet.
>  	 */
>  	SKB_DROP_REASON_PACKET_SOCK_ERROR,
> +	/** @SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed. */
> +	SKB_DROP_REASON_TC_CHAIN_NOTFOUND,
> +	/**
> +	 * @SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
> +	 * iterations.
> +	 */
> +	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen

...

