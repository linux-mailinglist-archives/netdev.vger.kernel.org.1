Return-Path: <netdev+bounces-205997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB5B0108B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E611CA0EE1
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A62E40B;
	Fri, 11 Jul 2025 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UffrceSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C452745E;
	Fri, 11 Jul 2025 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195799; cv=none; b=hunsHC7bX9WvTmRjBxD/4/2zsaxFnDmwEf4rlpsjmfXRDh8mkXQJSs/1Oc4UMpmM9qCyT/kP4BwNwRHuWptVac+njlev1j6Gi79v0eadPrx0Tg+G1zJthmHXnoM3boeXDVfErvE78Uqce6BWTzIWlvIRdqJbyMDFdVEFRnqK2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195799; c=relaxed/simple;
	bh=rRGd51Wi/wDKoo3MftlDcLUEgCw/Zs3CnYkieFYpZ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow2QlMGCIdjw3xTHZv6Sw78Lz/TVryQgtLueXb2EWp9gnhW6sftbpzqeXDxj1BfHeqInp/aO3OoYS+fw22vWdDIyxU2oW8XhMVgKcn4bFh0/DhqtpxUPqF/HQeGlMlFVfFQikQlimuzCkxQKHY+065Vrhhjkxssr2VO7EhGS58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UffrceSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BA5C4CEE3;
	Fri, 11 Jul 2025 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195796;
	bh=rRGd51Wi/wDKoo3MftlDcLUEgCw/Zs3CnYkieFYpZ7k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UffrceSQYPPgWZpb06pFbf0N/mcN1A6WqEWN287pO53iZearX/WQRQ1GbCUMe2AhL
	 9qUIiD5WFn3rf87n6kOMosYJEtfUmbYtI2Xmls8eMC4Ujhsk1auXEp/r1YcFU4ngQ3
	 0AZpWWb598N9cXvj2Is9Qwk+dOIfiCE5Q6xptpoBv9ELyE38Ual/nVlonbiGuiOHW0
	 CuUg4yjgYuUG/ErYTdn8STXX6IvFUABXhDHqe+0fQLTSMsCJjyqak65FCw/X1+IpeZ
	 v3Jo81NR4kPnVEDKHE8bKrEAKlo0ey492+pu7n4m7GWZC3HyLQ2VvQwxOXPr9tldT+
	 qSnAlqCKW2XXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43CFDCE0A44; Thu, 10 Jul 2025 18:03:16 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:03:16 -0700
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
Subject: Re: [RFC PATCH 7/8] rcuscale: Add tests for simple hazard pointers
Message-ID: <dd9b0591-aea2-4a50-bf4e-276224f15f68@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-8-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-8-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:54PM -0700, Boqun Feng wrote:
> Add two rcu_scale_ops to include tests from simple hazard pointers
> (shazptr). One is with evenly distributed readers, and the other is with
> all WILDCARD readers. This could show the best and worst case scenarios
> for the synchronization time of simple hazard pointers.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Cute trick using the CPU number plus one as a stand-in for a pointer.  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcuscale.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index d9bff4b1928b..cab42bcc1d26 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -32,6 +32,7 @@
>  #include <linux/freezer.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
> +#include <linux/shazptr.h>
>  #include <linux/stat.h>
>  #include <linux/srcu.h>
>  #include <linux/slab.h>
> @@ -429,6 +430,54 @@ static struct rcu_scale_ops tasks_tracing_ops = {
>  
>  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
>  
> +static int shazptr_scale_read_lock(void)
> +{
> +	long cpu = raw_smp_processor_id();
> +
> +	/* Use cpu + 1 as the key */
> +	guard(shazptr)((void *)(cpu + 1));
> +
> +	return 0;
> +}
> +
> +static int shazptr_scale_wc_read_lock(void)
> +{
> +	guard(shazptr)(SHAZPTR_WILDCARD);
> +
> +	return 0;
> +}
> +
> +
> +static void shazptr_scale_read_unlock(int idx)
> +{
> +	/* Do nothing, it's OK since readers are doing back-to-back lock+unlock*/
> +}
> +
> +static void shazptr_scale_sync(void)
> +{
> +	long cpu = raw_smp_processor_id();
> +
> +	synchronize_shazptr((void *)(cpu + 1));
> +}
> +
> +static struct rcu_scale_ops shazptr_ops = {
> +	.ptype		= RCU_FLAVOR,
> +	.readlock	= shazptr_scale_read_lock,
> +	.readunlock	= shazptr_scale_read_unlock,
> +	.sync		= shazptr_scale_sync,
> +	.exp_sync	= shazptr_scale_sync,
> +	.name		= "shazptr"
> +};
> +
> +static struct rcu_scale_ops shazptr_wc_ops = {
> +	.ptype		= RCU_FLAVOR,
> +	.readlock	= shazptr_scale_wc_read_lock,
> +	.readunlock	= shazptr_scale_read_unlock,
> +	.sync		= shazptr_scale_sync,
> +	.exp_sync	= shazptr_scale_sync,
> +	.name		= "shazptr_wildcard"
> +};
> +
>  static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
>  {
>  	if (!cur_ops->gp_diff)
> @@ -1090,7 +1139,8 @@ rcu_scale_init(void)
>  	long i;
>  	long j;
>  	static struct rcu_scale_ops *scale_ops[] = {
> -		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		&rcu_ops, &srcu_ops, &srcud_ops, &shazptr_ops, &shazptr_wc_ops,
> +		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.47.1
> 

