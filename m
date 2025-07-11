Return-Path: <netdev+bounces-205988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B588CB01056
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496C04A8233
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917EFC0A;
	Fri, 11 Jul 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht6nADHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66289BE4E;
	Fri, 11 Jul 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194561; cv=none; b=VdckZYcBdqT6drDu0xRtaJv5mN3uYQsD+XzvdwWhYcwEbdNlDKnoYr1zH7TKCh2BjDmpoKpP0QMRodElFeic5H5nXOM/DQuXKfRB1rA24xRlKFHPdpGRnVRVCdUsFKIzc09GzcBYYK/CbIWcZs2bLoHBgKObPsMTwBOrZO8w3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194561; c=relaxed/simple;
	bh=ZPROHW5I2v7PfsViAgwJuGt3ZTDGvRoJiDVHbKH1zmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYeSny6+rO8RpxQhXlTGMDnQ6d3gWzaa2XH2sFnmDfnHNYDvTq9Yiu/NkfD1kpIt991Z7FSFfAlRWOFSnYGexPDNWZZxBb0wKOz46451fWQlydv4F+yKuKXzmjklOY8qYO4g48qb5QXWaCUzDYqaQ2TiWBRmjYf7+p2NETEhJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht6nADHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA5FC4CEE3;
	Fri, 11 Jul 2025 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194561;
	bh=ZPROHW5I2v7PfsViAgwJuGt3ZTDGvRoJiDVHbKH1zmQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ht6nADHhTKqdgJkLXFDphtNqrdOYcxSQxoLZ/0ccLb5wIAWqwtqwZ+vQF+nONKgDG
	 VLB6Tu3DS7TdURpO4jU3bba6svVflwIQSWsJStfmqKm5BuUU1PweF/4gC0g7JmPZMQ
	 gMovLy8kS1t5wjTCgwAHnWaPcyIt3SdFdH10A6REWNONALSPTWAXv8Wr8n0M7uHetU
	 lWuTFY4XOAuM6I5KezFXraE4QhFnAdY0wY44DvLGkAj3cBVOI8XYkN9gUIBnf0lx8g
	 ryZONRgKcAvpvidrC0TYoXe/xhHAlgEAncCa5EdOgFRcGbxT2exXPG6e++ZwCw8tbO
	 Vo68K0aFvnuAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85F7FCE0A44; Thu, 10 Jul 2025 17:42:40 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:42:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] shazptr: Add refscale test for wildcard
Message-ID: <ccb7d433-0ff8-4bbc-8c76-be2d391fb06a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-4-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:50PM -0700, Boqun Feng wrote:
> Add the refscale test for shazptr, which starts another shazptr critical
> section inside an existing one to measure the reader side performance
> when wildcard logic is triggered.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

With or without the same ref_shazptr_init() fix as the preview patch:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/refscale.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 154520e4ee4c..fdbb4a2c91fe 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -928,6 +928,44 @@ static const struct ref_scale_ops shazptr_ops = {
>  	.name		= "shazptr"
>  };
>  
> +static void ref_shazptr_wc_read_section(const int nloops)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_read_section);
> +			/* Trigger wildcard logic */
> +			guard(shazptr)(ref_shazptr_wc_read_section);
> +		}
> +		preempt_enable();
> +	}
> +}
> +
> +static void ref_shazptr_wc_delay_section(const int nloops, const int udl, const int ndl)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_delay_section);
> +			/* Trigger wildcard logic */
> +			guard(shazptr)(ref_shazptr_wc_delay_section);
> +			un_delay(udl, ndl);
> +		}
> +		preempt_enable();
> +	}
> +}
> +
> +static const struct ref_scale_ops shazptr_wildcard_ops = {
> +	.init		= ref_shazptr_init,
> +	.readsection	= ref_shazptr_wc_read_section,
> +	.delaysection	= ref_shazptr_wc_delay_section,
> +	.name		= "shazptr_wildcard"
> +};
> +
>  static void rcu_scale_one_reader(void)
>  {
>  	if (readdelay <= 0)
> @@ -1235,7 +1273,7 @@ ref_scale_init(void)
>  		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
>  		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
>  		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
> -		&shazptr_ops,
> +		&shazptr_ops, &shazptr_wildcard_ops,
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.47.1
> 

