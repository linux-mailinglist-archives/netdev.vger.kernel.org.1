Return-Path: <netdev+bounces-201026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665BAE7E62
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229D4188D7E9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F82066CF;
	Wed, 25 Jun 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jh7DTIjt"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC622AE72;
	Wed, 25 Jun 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845768; cv=none; b=udskNK6BvDr5kCa5H6Jevdkfa1a3MQRoL3zt9vo1KbFpU4pjgIOF8TJ3p5wPypR4u7k6ogwdgSEC57owQ0E5sy/eS9yViECVvFf20QN/sgKgp2FdMLTjAHbn/LSeOoG7gH7IMpt2mb+JLDm1jQp0rxEVG896sC+/ux0LNv+/tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845768; c=relaxed/simple;
	bh=hoXYVcGKL8nbrjdEu9PdN9DpJzSp36bHzkWAwh7+KX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNMj2Q+oyJNCsP6Q0V3hGEldGERbDWhHS+yGatNU7/zU3Gdz6wE03sgMbgDgtqLhOVjwVp2cRuiOzluU8JQ3gW5uMOFVvjUQnkfq5ylPOB8FTfRLqLlfUCuvLkiEDOPgySiM54+ZuPlJb5XwRSE/9y9IS5y+zCbTQbd80gPOsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jh7DTIjt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lM9KIS0AYBEWKGaaAsKELMaV5F+JuydqZO9uuemUpgo=; b=jh7DTIjtHMx4XUomHZZkIBCBXh
	ij5naRo+ER11a3DSmtqca7vIIDirpXisa1CfCjHyeMPIDffk7xVh2/zuKkvMsSufUFZmvVEHOLL6H
	/6SihvZMt4xbN1OR09sWE1JZ2PBlHe7LjfJimudm0n2/Zvj/1p2syh6a97ZgUQXpyphPb2rQby7uZ
	dpzdJ+a16KQCKMQJuvX+H/DBXXhVYdrlZHiE+H5rqBVyoseoDMb//vQPZSMSvyiEBhD92w8I+22Ql
	XUjs91HoDrnWtQv6QPCXxC0zfmTINNPnEIkN5m67FhvyqFsezBXLrGEvRE+1D0QIURnnsjOANmoVy
	JsNJBrRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMxe-00000005lY8-02Za;
	Wed, 25 Jun 2025 10:02:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFC48306158; Wed, 25 Jun 2025 12:02:32 +0200 (CEST)
Date: Wed, 25 Jun 2025 12:02:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 2/8] shazptr: Add refscale test
Message-ID: <20250625100232.GB1613376@noisy.programming.kicks-ass.net>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-3-boqun.feng@gmail.com>

On Tue, Jun 24, 2025 at 08:10:55PM -0700, Boqun Feng wrote:
> Add the refscale test for shazptr to measure the reader side
> performance.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/refscale.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index f11a7c2af778..154520e4ee4c 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -29,6 +29,7 @@
>  #include <linux/reboot.h>
>  #include <linux/sched.h>
>  #include <linux/seq_buf.h>
> +#include <linux/shazptr.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>  #include <linux/stat.h>
> @@ -890,6 +891,43 @@ static const struct ref_scale_ops typesafe_seqlock_ops = {
>  	.name		= "typesafe_seqlock"
>  };
>  
> +static void ref_shazptr_read_section(const int nloops)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{ guard(shazptr)(ref_shazptr_read_section); }
> +		preempt_enable();

		scoped_guard (preempt)
			guard(shazptr)(ref_shazptr_read_section);

> +	}
> +}
> +
> +static void ref_shazptr_delay_section(const int nloops, const int udl, const int ndl)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_delay_section);
> +			un_delay(udl, ndl);
> +		}
> +		preempt_enable();

		scoped_guard (preempt) {
			guard(shazptr)(ref_shazptr_delay_section);
			un_delay(udl, ndl);
		}


> +	}
> +}
> +
> +static bool ref_shazptr_init(void)
> +{
> +	return true;
> +}
> +
> +static const struct ref_scale_ops shazptr_ops = {
> +	.init		= ref_shazptr_init,
> +	.readsection	= ref_shazptr_read_section,
> +	.delaysection	= ref_shazptr_delay_section,
> +	.name		= "shazptr"
> +};
> +
>  static void rcu_scale_one_reader(void)
>  {
>  	if (readdelay <= 0)
> @@ -1197,6 +1235,7 @@ ref_scale_init(void)
>  		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
>  		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
>  		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
> +		&shazptr_ops,
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.39.5 (Apple Git-154)
> 

