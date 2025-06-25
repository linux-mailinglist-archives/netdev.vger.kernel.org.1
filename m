Return-Path: <netdev+bounces-201182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A5DAE854F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05DB16386F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036EE263C91;
	Wed, 25 Jun 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OefvGm+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058825B30D;
	Wed, 25 Jun 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859768; cv=none; b=rlRdlR7OJwJ4RnTj5GYCfpLeVpnImjtzQxjTqsthHZdkSaLeJFqULxV3HJ0g02WcFs+FAnPZLyj66o0E2rxWm/fXI3JacBkWbO1ZGxijtRK2vKRbTP2NRc7mOHRKnkvlcChCub/kuN9Kartmoec3FuvZ6hL/kZpDF6UHwLhkTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859768; c=relaxed/simple;
	bh=9kJ9xOiUhXy15Ss4GSJWQ9GtdxWtoOrSKNYadAxcrOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofk+C6Dpk41n+mIxe7DpGt95HW6q3/Jgf398oQBVpwpMA7m20sGFyHY8f46eEufQfxnln0/PoiyKyVkVS5oyxzJHBA7powvXzZgSSHwpcyzj2XToYhdD96lbgORJirFNKZMeYYk/G5DIC2OfRiQ9PLvB1Y2qpwBlTTN10B4JrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OefvGm+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F8C4CEEA;
	Wed, 25 Jun 2025 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750859768;
	bh=9kJ9xOiUhXy15Ss4GSJWQ9GtdxWtoOrSKNYadAxcrOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OefvGm+IRrzqsZYijzGg39UNvgHzVos0tUrfbVDfd4RppokvGnFwq+UNqf3duDNXk
	 iOPGVz03R+hTFQ5475anEAKRdyvMyCvE6FXxBwM3d9v4VvAXMJ3jwE++qTGQGDBG+I
	 Nz53Rbb3Z8vlOYpvkW5nb8sX5D4K5PPqJXSSd+w8LKWd9wGbZUC00unwwZ74vEJzCp
	 iqYUVJb9For3eA/vp5dQvppdomzAVbWdysKYleHKp4NdxgwLXLAAH4FvFnyzJcBq6l
	 aScIAnfGQ+gdvsH6e0gBYq/g5GFUwOVFZAacLdgeDLO51HAcfNtAW9tcZU7ki5H5XF
	 OAw90eyOWHkRA==
Date: Wed, 25 Jun 2025 15:56:05 +0200
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
Message-ID: <aFv_9f9w_HdTj9Xj@localhost.localdomain>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625031101.12555-5-boqun.feng@gmail.com>

Le Tue, Jun 24, 2025 at 08:10:57PM -0700, Boqun Feng a écrit :
> +static void synchronize_shazptr_normal(void *ptr)
> +{
> +	int cpu;
> +	unsigned long blocking_grp_mask = 0;
> +
> +	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> +
> +	for_each_possible_cpu(cpu) {
> +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> +		void *val;
> +
> +		/* Pair with smp_store_release() in shazptr_clear(). */
> +		val = smp_load_acquire(slot);
> +
> +		if (val == ptr || val == SHAZPTR_WILDCARD)
> +			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> +	}
> +
> +	/* Found blocking slots, prepare to wait. */
> +	if (blocking_grp_mask) {

synchronize_rcu() here would be enough since all users have preemption disabled.
But I guess this defeats the performance purpose? (If so this might need a
comment somewhere).

I guess blocking_grp_mask is to avoid allocating a cpumask (again for
performance purpose? So I guess synchronize_shazptr_normal() has some perf
expectations?)

One possibility is to have the ptr contained in:

struct hazptr {
       void *ptr;
       struct cpumask scan_mask
};

And then the caller could simply scan itself those remaining CPUs without
relying on the kthread.

But I'm sure there are good reasons for now doing that :-)

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

