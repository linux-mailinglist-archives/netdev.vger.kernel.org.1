Return-Path: <netdev+bounces-88778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649C8A8852
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9293CB20E8A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDC147C9F;
	Wed, 17 Apr 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ5dyJmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397C146D4B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369555; cv=none; b=adTjZMpTOLJzWNuDjne8lQBbOkTl8EgwwG5M2+mRg54+vkMqZBNpfL8pr1pr4MwLdoZ7mlGv79jpbXrQbDqOCh13vWQ+Wdhh+z9ghprHWPGwugG863o6vmToifuaszDSQ62Hj9rEJVwu1S7t/8yFpAkreSnRAs0T27cNRM0aIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369555; c=relaxed/simple;
	bh=T5xzdtoNGAdFdPNC9y9D52aHQPzaS2jjbs/+x9K3vzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vot0uoHm1snKW/DsFfq6qBfPntbT+yRAghQsdfomxJf5vmZuvW6JyrBMK32DcJA0lDH8dmFlBAkn4ik2LhLfcXQzbuIkFxFS1eEH9FSE1tZr+Ks8cfqDh3HRHR/6GhoRlLIeOKFuXhgx7L0Jo7qt604bxovHxH6pyRzK9it4om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ5dyJmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C5C072AA;
	Wed, 17 Apr 2024 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369554;
	bh=T5xzdtoNGAdFdPNC9y9D52aHQPzaS2jjbs/+x9K3vzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZ5dyJmiHDp5l0Djz5a59ZbRTwDqfm1GbSGTmQl3wyDdwtOYc2kT0FslllIsU1Qtf
	 PpAzgqZy/ps6T1q8LmueLuxtmlFMJYLs+Jm31rdxdvpPLQPVhH+8DxD9WGFhkpAkk/
	 ucIRrM+FEdXC44dOf5pON/XUxyAsMqPYJvPMwaiSKrq9yPAFTMn4lQ9aRfbUupcP/F
	 MBl3IZ/KEuP8Gs0kcGLnBX7Lbehma7uZAUFNlDOBXljw6/eA7IegRV9oMLIVGBp2ur
	 M8yapjbcMtL+M/chX8PO3MyauRAWVU02UlI90ObauXTjKzrGwLx9opTd01ZivozZ3g
	 miaTKz0h8C4Wg==
Date: Wed, 17 Apr 2024 16:59:09 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 05/14] net_sched: sch_codel: implement lockless
 codel_dump()
Message-ID: <20240417155909.GZ2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-6-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:45PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, codel_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in codel_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_codel.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
> index ecb3f164bb25b33bd662c8ee07dc1b5945fd882d..3e8d4fe4d91e3ef2b7715640f6675aa5e8e2a326 100644
> --- a/net/sched/sch_codel.c
> +++ b/net/sched/sch_codel.c
> @@ -118,26 +118,31 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
>  	if (tb[TCA_CODEL_TARGET]) {
>  		u32 target = nla_get_u32(tb[TCA_CODEL_TARGET]);
>  
> -		q->params.target = ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT;
> +		WRITE_ONCE(q->params.target,
> +			   ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT);
>  	}
>  
>  	if (tb[TCA_CODEL_CE_THRESHOLD]) {
>  		u64 val = nla_get_u32(tb[TCA_CODEL_CE_THRESHOLD]);
>  
> -		q->params.ce_threshold = (val * NSEC_PER_USEC) >> CODEL_SHIFT;
> +		WRITE_ONCE(q->params.ce_threshold,
> +			   (val * NSEC_PER_USEC) >> CODEL_SHIFT);
>  	}
>  
>  	if (tb[TCA_CODEL_INTERVAL]) {
>  		u32 interval = nla_get_u32(tb[TCA_CODEL_INTERVAL]);
>  
> -		q->params.interval = ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT;
> +		WRITE_ONCE(q->params.interval,
> +			   ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT);
>  	}
>  
>  	if (tb[TCA_CODEL_LIMIT])
> -		sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
> +		WRITE_ONCE(sch->limit,
> +			   nla_get_u32(tb[TCA_CODEL_LIMIT]));
>  

Hi Eric,

Sorry to be so bothersome.

As a follow-up to our discussion of patch 4/14 (net_choke),
I'm wondering if reading sch->limit in codel_qdisc_enqueue()
should be updated to use READ_ONCE().

>  	if (tb[TCA_CODEL_ECN])
> -		q->params.ecn = !!nla_get_u32(tb[TCA_CODEL_ECN]);
> +		WRITE_ONCE(q->params.ecn,
> +			   !!nla_get_u32(tb[TCA_CODEL_ECN]));
>  
>  	qlen = sch->q.qlen;
>  	while (sch->q.qlen > sch->limit) {

...

