Return-Path: <netdev+bounces-88606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7638A7E66
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD4281791
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40397EF1B;
	Wed, 17 Apr 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ofZ3Vm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E656CDA8
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342954; cv=none; b=tHFfdzUwxI0NNGiUFDtsMatcmLra9oZnkWxdMeFTZF6GcsyvTTuhDPsUY8V7IRC0FSWrN4uUkLMoz5osfqAOgqL/t4+vDQw38Rr6GiCPbTBVh+dgpCdeT+mEiqu9SOxDhVtexcsAISv+jCIKMf2L6aDniDck+hJ7er4k2KThOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342954; c=relaxed/simple;
	bh=s7MqT9pXd0kbuCaAXMjSvbDzjWO7b17I9zlKSyXm9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft+lsNvfwATCKnVjT03Lz1kUFUDyTtENgazACz1AnqOyISE0wm27DTrWg7D9gXZJTVUvB18nsvO1IHgMgDA9ShZa8IIKg2fVWYmshRMLffFqkNg0hhF+NlnOHSTRF3PtrMawpP9R3Mg93SZjBPKk92NgNC2YQdRDURfKoVxd5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ofZ3Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1433C072AA;
	Wed, 17 Apr 2024 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342954;
	bh=s7MqT9pXd0kbuCaAXMjSvbDzjWO7b17I9zlKSyXm9g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7ofZ3VmpRkf9j6JEdc9KaRYvc4+wsR2C0/EgSm8QOjKIx33XcRMMQwnenp7xuMdX
	 xW0r1jYTESj/iFEBazdpE2qMZpmi1JMyecRHCpCRXC1TnziJ2Jc+6eI8ey8LzYD2RY
	 +TvuAgSnoW+za8Ac6M9WewI0j1xggp2R/WnbNfNMPb8uAcP9R3wIzIO2SRfAUe/CFA
	 AxWq/jTiXNVfxFsJjFKbaR5UIasOJh0UQB+1HrLUZtxghRNkkPaGelzqoc96uG+dAC
	 FIXe9r2beSh7lrwl4cl3lNd60vtGaUrrDXJyrF7DYLMOSBLsbuvmMfbtr4TFA/mFLO
	 vrjv528ZHjJ7w==
Date: Wed, 17 Apr 2024 09:35:49 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	cake@lists.bufferbloat.net
Subject: Re: [PATCH net-next 02/14] net_sched: cake: implement lockless
 cake_dump()
Message-ID: <20240417083549.GA3846178@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415132054.3822230-3-edumazet@google.com>

+ Toke Høiland-Jørgensen <toke@toke.dk>
  cake@lists.bufferbloat.net

On Mon, Apr 15, 2024 at 01:20:42PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, cake_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in cake_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

> @@ -2774,68 +2783,71 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
>  {
>  	struct cake_sched_data *q = qdisc_priv(sch);
>  	struct nlattr *opts;
> +	u16 rate_flags;
>  
>  	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
>  	if (!opts)
>  		goto nla_put_failure;
>  
> -	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64, q->rate_bps,
> -			      TCA_CAKE_PAD))
> +	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
> +			      READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
>  		goto nla_put_failure;
>  
>  	if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE,
> -			q->flow_mode & CAKE_FLOW_MASK))
> +			READ_ONCE(q->flow_mode) & CAKE_FLOW_MASK))
>  		goto nla_put_failure;

Hi Eric,

q->flow_mode is read twice in this function. Once here...

>  
> -	if (nla_put_u32(skb, TCA_CAKE_RTT, q->interval))
> +	if (nla_put_u32(skb, TCA_CAKE_RTT, READ_ONCE(q->interval)))
>  		goto nla_put_failure;
>  
> -	if (nla_put_u32(skb, TCA_CAKE_TARGET, q->target))
> +	if (nla_put_u32(skb, TCA_CAKE_TARGET, READ_ONCE(q->target)))
>  		goto nla_put_failure;
>  
> -	if (nla_put_u32(skb, TCA_CAKE_MEMORY, q->buffer_config_limit))
> +	if (nla_put_u32(skb, TCA_CAKE_MEMORY,
> +			READ_ONCE(q->buffer_config_limit)))
>  		goto nla_put_failure;
>  
> +	rate_flags = READ_ONCE(q->rate_flags);
>  	if (nla_put_u32(skb, TCA_CAKE_AUTORATE,
> -			!!(q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
> +			!!(rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
>  		goto nla_put_failure;
>  
>  	if (nla_put_u32(skb, TCA_CAKE_INGRESS,
> -			!!(q->rate_flags & CAKE_FLAG_INGRESS)))
> +			!!(rate_flags & CAKE_FLAG_INGRESS)))
>  		goto nla_put_failure;
>  
> -	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, q->ack_filter))
> +	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, READ_ONCE(q->ack_filter)))
>  		goto nla_put_failure;
>  
>  	if (nla_put_u32(skb, TCA_CAKE_NAT,
> -			!!(q->flow_mode & CAKE_FLOW_NAT_FLAG)))
> +			!!(READ_ONCE(q->flow_mode) & CAKE_FLOW_NAT_FLAG)))
>  		goto nla_put_failure;

... and once here.

I am assuming that it isn't a big deal, but perhaps it is better to save
q->flow_mode into a local variable.

Also, more importantly, q->flow_mode does not seem to be handled
using WRITE_ONCE() in cake_change(). It's a non-trivial case,
which I guess is well served by a mechanism built around a local variable.

...

