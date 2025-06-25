Return-Path: <netdev+bounces-201115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FFAE823C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA9F5A759C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3125DAE2;
	Wed, 25 Jun 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISCEm7UK"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917625EF82;
	Wed, 25 Jun 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852613; cv=none; b=Kwb57SsYM2OLUyxT3LJAFvSM+6/c6NYg0Vvm6eG7CQVBOgQQmRjTrJ4cleC4bwftHxRGHImM+yWuEMnpyR+HJ5hH/nPY49c64PVwLiOryABD4+p3QqJGT7s9hM4zUrdJU1Gal0vREyLNYliKx4zadoWXY3TnX+uZsOxW17LTHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852613; c=relaxed/simple;
	bh=cVo9Xcg87O0oGsmnAr6w6S5Wjns36e/PNeBgLvqTRLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdgFBY7/IeQP9ZduzPfeV9fklaww5wWMwrWWinDjmFTczkB9D/d9EhThlkVEcHxF7USIwCmOeCSjD7mGkHUaOQtYMUMFrEa9wi7DRDNWRJ9DGq5O8f5i2e2VQAZkL3HG+18ar/Ca1u6/fVJgTPx2JwY8ajtSizfsGKm+YNO90C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ISCEm7UK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bsdjmw/s0xK6OKQhogNcYxPwxByyT90uqYrflwQOPIs=; b=ISCEm7UK2/Ndd5WFsguA3KwXrV
	z7CtUSXJmkgIQUwR5ohAVehe5E6T9QnfoFrtrhtS7F6/T+ooG3P8tkd8nIUVMkn6uPBkTWqQnPsyH
	m4IQlmMhQnTYfEZTz2L5X78guxhKsBstJBSoxsF0UAXFBVNDZ6RuYqDWkWCWb7x08Yvyx/r1GgbMz
	645hx+s+deLXYHnXtJiJ7kavlHG/WH6DMrbDvK/zKs5eO8hE9Fd0SRkoWdlIS/BgAq+OnDRhdm21r
	3T90GLZ16Fw0s9Y0FKnEgO9u8o62mDPgbkDDiGWAeopsqRACPP7AA5m7t4M+3LLdL0AtGJlscMn+A
	3m1FwSZg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOk8-00000005qQC-0LQ8;
	Wed, 25 Jun 2025 11:56:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FFF030BAFF; Wed, 25 Jun 2025 13:56:43 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:56:43 +0200
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
Subject: Re: [PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Message-ID: <20250625115643.GE1613376@noisy.programming.kicks-ass.net>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-5-boqun.feng@gmail.com>


Response is a bit weird because non-linear editing..

On Tue, Jun 24, 2025 at 08:10:57PM -0700, Boqun Feng wrote:

> +	/* Whether the scan kthread has been scheduled to scan */
> +	bool scheduled;

> +static int __noreturn shazptr_scan_kthread(void *unused)
> +{
> +	for (;;) {
> +		swait_event_idle_exclusive(shazptr_scan.wq,
> +					   READ_ONCE(shazptr_scan.scheduled));

This seems weird; why use a whole wait-queue, in exclusive mode no less,
for something that is one known thread.

Also, I think this thing needs to be FREEZABLE, otherwise suspend might
have issues.

Why not just write it like:

		for (;;) {
			set_current_state(TASK_IDLE | TASK_FREEZABLE);
			if (!list_empty(&scan->queue))
				break;
			schedule();
		}
		__set_current_state(TASK_RUNNABLE);

		for (;;) {
			scoped_guard (mutex, scan->lock) {
				if (list_empty(scan->queued) &&
				    list_empty(scan->scanning))
					break;
			}

			shazptr_do_scan(scan);
		}


> +		shazptr_do_scan(&shazptr_scan);
> +
> +		scoped_guard(mutex, &shazptr_scan.lock) {
> +			if (list_empty(&shazptr_scan.queued) &&
> +			    list_empty(&shazptr_scan.scanning))
> +				shazptr_scan.scheduled = false;

This condition, why can't we directly use this condition instead of
scheduled?

> +		}
> +	}
> +}


> +static void synchronize_shazptr_normal(void *ptr)
> +{

> +
> +	/* Found blocking slots, prepare to wait. */
> +	if (blocking_grp_mask) {
> +		struct shazptr_scan *scan = &shazptr_scan;
> +		struct shazptr_wait wait = {
> +			.blocking_grp_mask = blocking_grp_mask,
> +		};
> +
> +		INIT_LIST_HEAD(&wait.list);
> +		init_completion(&wait.done);
> +
> +		scoped_guard(mutex, &scan->lock) {
> +			list_add_tail(&wait.list, &scan->queued);
> +
> +			if (!scan->scheduled) {
> +				WRITE_ONCE(scan->scheduled, true);
> +				swake_up_one(&shazptr_scan.wq);
> +			}

Or perhaps; just write this like:

			bool was_empty = list_empty(&scan->queued);
			list_add_tail(&wait.list, &scan->queued);
			if (was_empty)
				wake_up_process(scan->thread);

> +		}
> +
> +		wait_for_completion(&wait.done);
> +	}
> +}


