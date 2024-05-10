Return-Path: <netdev+bounces-95443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182818C24AF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F91C21A92
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C716E87D;
	Fri, 10 May 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRUE2dcA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A01DA4E;
	Fri, 10 May 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343595; cv=none; b=FXz6BBn1NFgeoLMfAJb2dVojCI9XhlK9xBI2bFNvgJQ2DZHqUk0FFYB4MHaYk2MlGlB1M1BySeFXOhWzLeLQyzbC/FCaqQIq9aK07SnYJn478ru+ALWYyaPebYaNr2t57w7prsjxBsbscm/912XYNLuDNxB0vRACOlo6+gxRkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343595; c=relaxed/simple;
	bh=0QTGb7ws1UQC09T7WK/RIF3FX3HdoKHcCegXclf7Gfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlXTOQT8X51botzhRlUWVf49oEFYNjsSRZ8JlFZcRbeiolTbf9+ZeBu6uTIoVVJLhysbV23K5scqRm6csHwIp20Af345sY0bli1eRcQH4+//LE91Sp61obNcJ2MaEhww9x3eNs4f2///veWI+OmnE7/N1W89JYN8cmsH/GkOSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRUE2dcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71C2C113CC;
	Fri, 10 May 2024 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715343594;
	bh=0QTGb7ws1UQC09T7WK/RIF3FX3HdoKHcCegXclf7Gfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRUE2dcAxPO9x17TT+k3Umlur0rdkBu3SuqfJvxYBbv1RDVxNzXBT93eSxhOW8igd
	 nTsL763Naz9DaIo0VjMenFRtEtkgCbropKwnpnPGHLUCZrAnF4MVme8Qlb9ptlDUof
	 KghTa0aVh+Duy60x+rXAC9ISTx2m9bo1lFpH022C/+oYCdMn3kS2br49l1CHTc6bmq
	 ESfLMnlESIJp5HOq/61o61R+IlR4ZMYVeYt3mexz+ju8BwwAngn7ujZ1ZwuvyICbNj
	 NrjEa95O6IralrWJNz3nU4BpTzjB4DYUO+wAaYGvR8TcY1KKEPxt6mvOWmSAld0o7q
	 Odt0HWKz0/3pg==
Date: Fri, 10 May 2024 13:19:48 +0100
From: Simon Horman <horms@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net/sched: Get stab before calling ops->change()
Message-ID: <20240510121948.GT2347895@kernel.org>
References: <20240509024043.3532677-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509024043.3532677-1-xiaolei.wang@windriver.com>

On Thu, May 09, 2024 at 10:40:43AM +0800, Xiaolei Wang wrote:
> ops->change() depends on stab, there is such a situation
> When no parameters are passed in for the first time, stab
> is omitted, as in configuration 1 below. At this time, a
> warning "Warning: sch_taprio: Size table not specified, frame
> length estimates may be inaccurate" will be received. When
> stab is added for the second time, parameters, like configuration
> 2 below, because the stab is still empty when ops->change()
> is running, you will also receive the above warning.
> 
> 1. tc qdisc replace dev eth1 parent root handle 100 taprio \
>   num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
>   sched-entry S 1 100000 \
>   sched-entry S 2 100000 \
>   sched-entry S 4 100000 \
>   max-sdu 0 0 0 0 0 0 0 200 \
>   flags 2
> 
>   2. tc qdisc replace dev eth1 parent root overhead 24 handle 100 taprio \
>   num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
>   sched-entry S 1 100000 \
>   sched-entry S 2 100000 \
>   sched-entry S 4 100000 \
>   max-sdu 0 0 0 0 0 0 0 200 \
>   flags 2
> 

Hi Xiaolei Wang,

If this is a fix, targeted at the net tree, then it should probably have
a Fixes tag here (no blank line between it and other tags).

> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  net/sched/sch_api.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 60239378d43f..fec358f497d5 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1404,6 +1404,16 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
>  	struct qdisc_size_table *ostab, *stab = NULL;
>  	int err = 0;
>  
> +	if (tca[TCA_STAB]) {
> +		stab = qdisc_get_stab(tca[TCA_STAB], extack);
> +		if (IS_ERR(stab))
> +			return PTR_ERR(stab);
> +	}
> +
> +	ostab = rtnl_dereference(sch->stab);
> +	rcu_assign_pointer(sch->stab, stab);
> +	qdisc_put_stab(ostab);
> +
>  	if (tca[TCA_OPTIONS]) {
>  		if (!sch->ops->change) {
>  			NL_SET_ERR_MSG(extack, "Change operation not supported by specified qdisc");

I am concerned that in this case the stab will be updated even if the
change operation is rejected by the following code in the if
(tca[TCA_OPTIONS]) block, just below the above hunk.

		if (tca[TCA_INGRESS_BLOCK] || tca[TCA_EGRESS_BLOCK]) {
			NL_SET_ERR_MSG(extack, "Change of blocks is not supported");
			return -EOPNOTSUPP;
		}
...

-- 
pw-bot: under-review

