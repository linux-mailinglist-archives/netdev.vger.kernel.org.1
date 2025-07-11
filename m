Return-Path: <netdev+bounces-205993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D1B0107F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C266445DA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806F24B28;
	Fri, 11 Jul 2025 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcpwcl8/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A5101E6;
	Fri, 11 Jul 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195534; cv=none; b=Fp8SuVS56tWu36CcbxZmS5MpRj1jvqoRZ89KlmdgqwzOKDqkC0foaJZaI2kykldMWOsyCrYB15t542JcYfEOlo/R+od6TDfj1uTBrPj4qfoTBCS8w1Ig2GHZCsDKuFeAO0LLaL4VyE82cXu93MhLiSeq+fjH9BGlPHri3HnRS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195534; c=relaxed/simple;
	bh=9fouTm43jiHtRBKygiC6C3rLdluYTMFoMz6wUMkIBkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtF3tcYkqiaeMs2UO7EhlPMcuLGzbBr66ZJkDTsbkfSuhxVxc3aW+iSSRqa7LLfyz4yoP0jWW/BOihAwpmWLhRJMsilVxO1AKUIGChX1xd+0LzMjaL45KlLoyk57f9p8PmYvQ16m4C15096+NICvqEKWjirbgEMfnmQUK0DnI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcpwcl8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A11C4CEE3;
	Fri, 11 Jul 2025 00:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195533;
	bh=9fouTm43jiHtRBKygiC6C3rLdluYTMFoMz6wUMkIBkI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zcpwcl8/Sujvaj4OJ2pjpqMUsAUPOj7WbJmJN+3+yG7EJge2OGGe5DHFLHR+Kbs/U
	 i8Drq1E2p6mWuU9e1QTBs8HIL+pxPeWCFhPnTZMdackfpUwiND0mZ84vKxMr1yViyV
	 qKvh0jtigblI2+ULy2V6tDNUj69rEfjBIfy30Zc9c+/w6cS74BZVPyXuv5DKGRIaCh
	 C40ZEyn+xHrGsSB79LrApYLiIMCQ/PAro9F6KzdAp3qBxGWryIZxsJibI2VEitotEL
	 l7LFQ8VMXeNZsGierY73JzKpeqMFViOqXNgIB3fsIGu0cSNOX2lfO6MQrXrbm2gYJJ
	 6IOfGzvCidICA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0768CCE0A44; Thu, 10 Jul 2025 17:58:53 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:58:52 -0700
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
Subject: Re: [RFC PATCH 5/8] shazptr: Allow skip self scan in
 synchronize_shaptr()
Message-ID: <26ae1833-517e-47ea-ae5a-9bd8bdb6b4ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-6-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:52PM -0700, Boqun Feng wrote:
> Add a module parameter for shazptr to allow skip the self scan in
> synchronize_shaptr(). This can force every synchronize_shaptr() to use
> shazptr scan kthread, and help testing the shazptr scan kthread.
> 
> Another reason users may want to set this paramter is to reduce the self
> scan CPU cost in synchronize_shaptr().
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

One nit below, but nevertheless:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/shazptr.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
> index a8559cb559f8..b3f7e8390eb2 100644
> --- a/kernel/locking/shazptr.c
> +++ b/kernel/locking/shazptr.c
> @@ -14,11 +14,17 @@
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
>  #include <linux/list.h>
> +#include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/shazptr.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>  
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "shazptr."

I do not believe that you need this when the desired MODULE_PARAM_PREFIX
matches the name of the file, as it does in this case.  For example,
kernel/rcu/tree.c needs this to get the "rcutree." prefix, but
kernel/rcu/refscale.c can do without it.

> +
>  DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
>  EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
>  
> @@ -252,6 +258,10 @@ static void synchronize_shazptr_busywait(void *ptr)
>  	}
>  }
>  
> +/* Disabled by default. */
> +static int skip_synchronize_self_scan;
> +module_param(skip_synchronize_self_scan, int, 0644);
> +
>  static void synchronize_shazptr_normal(void *ptr)
>  {
>  	int cpu;
> @@ -259,15 +269,19 @@ static void synchronize_shazptr_normal(void *ptr)
>  
>  	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
>  
> -	for_each_possible_cpu(cpu) {
> -		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> -		void *val;
> +	if (unlikely(skip_synchronize_self_scan)) {
> +		blocking_grp_mask = ~0UL;
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> +			void *val;
>  
> -		/* Pair with smp_store_release() in shazptr_clear(). */
> -		val = smp_load_acquire(slot);
> +			/* Pair with smp_store_release() in shazptr_clear(). */
> +			val = smp_load_acquire(slot);
>  
> -		if (val == ptr || val == SHAZPTR_WILDCARD)
> -			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> +			if (val == ptr || val == SHAZPTR_WILDCARD)
> +				blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> +		}
>  	}
>  
>  	/* Found blocking slots, prepare to wait. */
> -- 
> 2.47.1
> 

