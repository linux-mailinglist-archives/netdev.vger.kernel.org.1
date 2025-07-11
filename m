Return-Path: <netdev+bounces-205995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C239B01085
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84118563677
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F562770B;
	Fri, 11 Jul 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YycH4XLx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FADDBC;
	Fri, 11 Jul 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195622; cv=none; b=ON1IihgWAR/R5gbv1JOB+bss7N32dLUDxIcUjEnTn9gYlT55PbrablQ+EKszk5jDeuvAe7Ud7i19f5hXY2FO9He5kn/H11umEOdyDuZGPFN8dpDpSnh1znnsQ2FfQbefGWLHfc+XYsCX6lxjwYFY0VSeckxaE72WouLpFR+sf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195622; c=relaxed/simple;
	bh=MJuGJlagsCsxyWHy4O2CpzzmsL/8SnYaAOmQQNeXOkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRPnM6A92Zryai3ijFnJF7eEp3EJT0gOYM9TtBrqbt/paQpG5mAtzMJ806QC1k6hMmH0+2ZdDYKE6lYNlciWH2DLvFvJq9RmL5+Myf7FNbs+b1OsY2I1C6/CBTITeqea4Tnw/RNP7mG8/CZE6hcNtuTyLwFwTbbHjxRi0xxConQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YycH4XLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FCDC4CEE3;
	Fri, 11 Jul 2025 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195621;
	bh=MJuGJlagsCsxyWHy4O2CpzzmsL/8SnYaAOmQQNeXOkM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YycH4XLxGkztwoGXGaVe6/Y008hg/nhlIqaXMaoISYbg7cxGfORcAY+bRX0/Zzcql
	 aO1ri6Ntyp+a1fVNbmIp0jRQkVOJUSmLMYxbIdpIFyI54ALlGKzzk/n8CtdqLa/nbj
	 Jh0z9zdBino527mrqdE6EHHoBQwD+Wz3/ot6nBC3owtoSWcu5MHIeKnSG9ChQjAvcM
	 onYwkS4B6tkl+lTlfi6GrPM3oVKhryBThnJ+jGAbDn6WH2nwhi29dXG3QGUGueBCAp
	 a+7p3gsBkYGcbSXEX+pIIFh6pC1gkPrudaayEW9kWQaGgK+NsRqQfYy0/0ZBJxVzMo
	 VYuP88JDquQaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53464CE0A44; Thu, 10 Jul 2025 18:00:21 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:00:21 -0700
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
Subject: Re: [RFC PATCH 6/8] rcuscale: Allow rcu_scale_ops::get_gp_seq to be
 NULL
Message-ID: <6dbbdfa0-ca6b-425a-85a0-7c80041573fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-7-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-7-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:53PM -0700, Boqun Feng wrote:
> For synchronization mechanisms similar to RCU, there could be no "grace
> period" concept (e.g. hazard pointers), therefore allow
> rcu_scale_ops::get_gp_seq to be a NULL pointer for these cases, and
> simply treat started and finished grace period as 0.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcuscale.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 0f3059b1b80d..d9bff4b1928b 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -568,8 +568,10 @@ rcu_scale_writer(void *arg)
>  		if (gp_exp) {
>  			b_rcu_gp_test_started =
>  				cur_ops->exp_completed() / 2;
> -		} else {
> +		} else if (cur_ops->get_gp_seq) {
>  			b_rcu_gp_test_started = cur_ops->get_gp_seq();
> +		} else {
> +			b_rcu_gp_test_started = 0;
>  		}
>  	}
>  
> @@ -625,9 +627,11 @@ rcu_scale_writer(void *arg)
>  				if (gp_exp) {
>  					b_rcu_gp_test_finished =
>  						cur_ops->exp_completed() / 2;
> -				} else {
> +				} else if (cur_ops->get_gp_seq) {
>  					b_rcu_gp_test_finished =
>  						cur_ops->get_gp_seq();
> +				} else {
> +					b_rcu_gp_test_finished = 0;
>  				}
>  				if (shutdown) {
>  					smp_mb(); /* Assign before wake. */
> -- 
> 2.47.1
> 

