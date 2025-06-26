Return-Path: <netdev+bounces-201574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08660AE9F4B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F731669CC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BE2E7632;
	Thu, 26 Jun 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwNa5DVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B32E762B;
	Thu, 26 Jun 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945509; cv=none; b=EZYl3w3lrksLYqVuvH9i5S9bNisbn7V499aMB2p5rNMyzqFiw+ino5dzo9fcTzA0YrQahiEEO7D2rgmeNTW6ATxAF+SwUidgDHkl9V/GZ5ekP6bj8HKT+YDdfZHHQhubpBjzJUpQjAEemj7WhHcHtrCOmv2f2w4VtJZ40SE6e+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945509; c=relaxed/simple;
	bh=G279dACHtQvr3AjwMIYy7wmCNZM5C1w9YX3eXJKhFSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIZXHkjLI01hyFtIBqj9Q5GR1iU280dvDPiT1uE9BPX0k6rVw3DDHz307NOtRigadumgZ0Vsd+jmwzxWO9FvW+yBRx3gsX2AjiYN+m6kTXQcMaolJ0ysxAMWZYmgch3/xmt/bj1GOLOVghChvN4rUzjMlpKoubYbVGxnvXVbdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwNa5DVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A88C4CEEB;
	Thu, 26 Jun 2025 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750945508;
	bh=G279dACHtQvr3AjwMIYy7wmCNZM5C1w9YX3eXJKhFSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwNa5DVPovInvWtSyNR5k6Xt3oecX3INIfSI0xRQvnUup7AabTSxuAI7zvQRJKPDs
	 FvbtobTvPIXqRM0Ct4N+WEYpGkXc8sFPMGuOvPfQ6Shj0oASPfzYRmoLpltIe5eJtC
	 oyqnp80GFfqM2nJhrCvChKs/BdoDzfXq+cNxqgOBj3P9LA7G6aYUx3xxViPKQTNGvu
	 SNAJ5SxHLYkCp5VSOdp73j0BGDtXgb5nkVs5gUXSxy9OMQL+cBMjghENAX+Vlk+eoK
	 N6rGDBjryfheyn5rQAuXuE7LZofUTw1ZluFnUdzeORoGriYB6SDwoklM0KphSvpUiq
	 Fi8rdbImiwtGg==
Date: Thu, 26 Jun 2025 15:45:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
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
Subject: Re: [PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Message-ID: <aF1O4aH7m43xAbCZ@localhost.localdomain>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-5-boqun.feng@gmail.com>
 <aFv_9f9w_HdTj9Xj@localhost.localdomain>
 <aFwUxblhRjh24JF1@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFwUxblhRjh24JF1@Mac.home>

Le Wed, Jun 25, 2025 at 08:24:53AM -0700, Boqun Feng a écrit :
> On Wed, Jun 25, 2025 at 03:56:05PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Jun 24, 2025 at 08:10:57PM -0700, Boqun Feng a écrit :
> > > +static void synchronize_shazptr_normal(void *ptr)
> > > +{
> > > +	int cpu;
> > > +	unsigned long blocking_grp_mask = 0;
> > > +
> > > +	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> > > +		void *val;
> > > +
> > > +		/* Pair with smp_store_release() in shazptr_clear(). */
> > > +		val = smp_load_acquire(slot);
> > > +
> > > +		if (val == ptr || val == SHAZPTR_WILDCARD)
> > > +			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> > > +	}
> > > +
> > > +	/* Found blocking slots, prepare to wait. */
> > > +	if (blocking_grp_mask) {
> > 
> > synchronize_rcu() here would be enough since all users have preemption disabled.
> > But I guess this defeats the performance purpose? (If so this might need a
> > comment somewhere).
> > 
> 
> synchronize_shazptr_normal() cannot wait for a whole grace period,
> because the point of hazard pointers is to avoid waiting for unrelated
> readers.

Fair enough!

> 
> > I guess blocking_grp_mask is to avoid allocating a cpumask (again for
> > performance purpose? So I guess synchronize_shazptr_normal() has some perf
> 
> If we are talking about {k,v}malloc allocation:
> synchronize_shazptr_normal() would mostly be used in cleanup/free path
> similar to synchronize_rcu(), therefor I would like to avoid "allocating
> memory to free memory".

Good point!

> 
> > expectations?)
> > 
> > One possibility is to have the ptr contained in:
> > 
> > struct hazptr {
> >        void *ptr;
> >        struct cpumask scan_mask
> > };
> > 
> 
> You mean updaters passing a `struct hazptr *` into
> synchronize_shazptr_normal()? That may be a good idea, if multiple
> updaters can share the same `struct hazptr *`, we can add that later,
> but...
> 
> > And then the caller could simply scan itself those remaining CPUs without
> > relying on the kthread.
> 
> .. this is a bad idea, sure, we can always burn some CPU time to scan,
> but local optimization doesn't mean global optimization, if in the
> future, we have a lots of synchronize_shazptr_normal()s happening at
> the same time, the self busy-waiting scan would become problematic.

Ok.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

