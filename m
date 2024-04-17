Return-Path: <netdev+bounces-88692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0C8A83FD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F4285C8A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60B13F014;
	Wed, 17 Apr 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgGKogq/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12113D265
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359650; cv=none; b=B7ZyUHs678MTVACXIbC6TqNgYzNCNWtFIwlZKj0Aawi8PVldDK1wRXj1zsp6EO4dE9Qhokmz0DBzO8Yud4ulhNy/MZIu6xiqevQpyfyVndmB90L364Gqz7SqlS1neICeB8/rSuwJ+Wkcf8Ql66OS3tSyTI6z/2I7MO2GSHyyaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359650; c=relaxed/simple;
	bh=jwJJ8rkbGnXillPq8GD+1sFN4L9SJymklLL4WgTsdsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyzXJV/SA2fDTx2WmRJA+Zzi5Rxw4FVH9cBZOCw1NzW7LyhVSCX1ZArwCpgn2WNPPe4ZSpda55720pQqAD2QpwompMtC1zOamjrEAOfE3uuvXDZ6Nk3w1lXJxo81DcnP/cpDs/AWRnBWxT2n6EdyWHLdxlSSgpJpWcy5IES8N1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgGKogq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D700C3277B;
	Wed, 17 Apr 2024 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713359649;
	bh=jwJJ8rkbGnXillPq8GD+1sFN4L9SJymklLL4WgTsdsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgGKogq/TQniHcx8btt6qatA2o8ABb/MHVZFOUj+07+kZ8jU+Xc2KgTzyYJQwgiDO
	 nVIf46qTd2XPtYXfeH/MQyFjd+RhFQRqC4BLzpyZmOLM9w8f4k+28wO17MnFDyLyO3
	 GvppJCH2PfibKacMa4NE1mvhk14JEis2RvYe9vrNWmwlw09vfWzvA6HG4cxbWSZBOO
	 0B7NrZq360tefPsUDO4f/e+NQx1syeNupFGpjsBzZVRnwUsKpR3kyqaynhlrZicSV6
	 Q+ScKqP4qTLlE+hXEg5xkCIEtomMfRyEj8H0rpz1Y425d04Mz+HtSy0uAS4lBNKtTg
	 cda0dwZbqpghQ==
Date: Wed, 17 Apr 2024 14:14:04 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 04/14] net_sched: sch_choke: implement lockless
 choke_dump()
Message-ID: <20240417131404.GX2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-5-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:44PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, choke_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in choke_change().
> 
> Also use READ_ONCE(q->limit) in choke_enqueue() as the value
> could change from choke_change().

Hi Eric,

I'm wondering if you could expand on why q->limit needs this treatment
but not other fields, f.e. q->parms.qth_min (aka p->qth_min).

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/red.h     | 10 +++++-----
>  net/sched/sch_choke.c | 23 ++++++++++++-----------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/red.h b/include/net/red.h

...

> @@ -244,7 +244,7 @@ static inline void red_set_parms(struct red_parms *p,
>  		max_P = red_maxp(Plog);
>  		max_P *= delta; /* max_P = (qth_max - qth_min)/2^Plog */
>  	}
> -	p->max_P = max_P;
> +	WRITE_ONCE(p->max_P, max_P);
>  	max_p_delta = max_P / delta;
>  	max_p_delta = max(max_p_delta, 1U);
>  	p->max_P_reciprocal  = reciprocal_value(max_p_delta);

A little further down in this function p->Scell_log is set.
I think it also needs the WRITE_ONCE() treatment as it
is read in choke_dump().

> diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c

...

> @@ -431,15 +431,16 @@ static int choke_init(struct Qdisc *sch, struct nlattr *opt,
>  static int choke_dump(struct Qdisc *sch, struct sk_buff *skb)
>  {
>  	struct choke_sched_data *q = qdisc_priv(sch);
> +	u8 Wlog = READ_ONCE(q->parms.Wlog);
>  	struct nlattr *opts = NULL;
>  	struct tc_red_qopt opt = {
> -		.limit		= q->limit,
> -		.flags		= q->flags,
> -		.qth_min	= q->parms.qth_min >> q->parms.Wlog,
> -		.qth_max	= q->parms.qth_max >> q->parms.Wlog,
> -		.Wlog		= q->parms.Wlog,
> -		.Plog		= q->parms.Plog,
> -		.Scell_log	= q->parms.Scell_log,
> +		.limit		= READ_ONCE(q->limit),
> +		.flags		= READ_ONCE(q->flags),
> +		.qth_min	= READ_ONCE(q->parms.qth_min) >> Wlog,
> +		.qth_max	= READ_ONCE(q->parms.qth_max) >> Wlog,
> +		.Wlog		= Wlog,
> +		.Plog		= READ_ONCE(q->parms.Plog),
> +		.Scell_log	= READ_ONCE(q->parms.Scell_log),
>  	};
>  
>  	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);

