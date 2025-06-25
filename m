Return-Path: <netdev+bounces-201099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D3AE81D6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D9F3B290D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBCD25D8FB;
	Wed, 25 Jun 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QrYLXkTh"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37725BEEC;
	Wed, 25 Jun 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851649; cv=none; b=calkawZPrcEtgjheX+14ARxpvxJkoxnRjrNln/zKZvMD2fm15muAe69mSnLfF3h7/SylXuBAy6Hlc78Gm5qjM3v0VQ5+qVz/Q5gVhEZt9Vut6GRZirWK5sxCBkWCzAsuAgwt3iw+2yVduIcO2fvSOfuQcXGSKcXJb/mGhf0YkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851649; c=relaxed/simple;
	bh=uY6RFzWQv+0n90gOzscfCZplXmNlWoXCFt0YTZXikzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7r+9iQMuxXQNZDM4eVrHCZVdb3MR476iyZLUuIQmv+IPHXVt+Pa/cFNw+mpNguNsSAeoXtX2F9WXcWsqk2aM2sj2fSNFZOVlyo/89gf9BTl73GGbV0MHtTbd2JxVs8Xri7MDNyEDu89j7KxrYf9R8fG4X8dXyYyWdmywEYMsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QrYLXkTh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u24hZkHf06T4OB4HIHNxmrjaJ9u6QgZP82b5qhOGNCI=; b=QrYLXkThNMY6yQ3TkhExUf5+NB
	yf9eh1KtODMRX4Vt2EFoBmEEETBjIA0VheGJ3+KJEPv7NkJd9O6RqpRNXu3eIB27GddUZujfIvxav
	XwRBocMvVtnlpA2beD4Qa1vgvmCih5MATkWYLoqc1RVlSabmxpImHuk3txEW1oYFUqq7o+eSET6BP
	N9c1mbMSGjAetYY0hKUJnl8G3xmAtskFNu14ItRUsEjZeYGzjdaw+CzIu7CUfV3Rw2eRyAavlmlv4
	v+bdRW31ABCqwRCJVZsaNsyCzAxLNs+IEatJAu6YQE5LdxjtlZ4iRx2UmgQ0YxZFgSqDkfxvA0bj9
	YnIOaamQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOUZ-00000005prz-2L8O;
	Wed, 25 Jun 2025 11:40:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6A02308983; Wed, 25 Jun 2025 13:40:37 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:40:37 +0200
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
Message-ID: <20250625114037.GD1613376@noisy.programming.kicks-ass.net>
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

On Tue, Jun 24, 2025 at 08:10:57PM -0700, Boqun Feng wrote:

> +/* Scan structure for synchronize_shazptr(). */
> +struct shazptr_scan {
> +	/* The scan kthread */
> +	struct task_struct *thread;
> +
> +	/* Wait queue for the scan kthread */
> +	struct swait_queue_head wq;
> +
> +	/* Whether the scan kthread has been scheduled to scan */
> +	bool scheduled;
> +
> +	/* The lock protecting ->queued and ->scheduled */
> +	struct mutex lock;
> +
> +	/* List of queued synchronize_shazptr() request. */
> +	struct list_head queued;
> +
> +	int cpu_grp_size;
> +
> +	/* List of scanning synchronize_shazptr() request. */
> +	struct list_head scanning;
> +
> +	/* Buffer used for hazptr slot scan, nr_cpu_ids slots*/
> +	struct shazptr_snapshot* snaps;
> +};

I find this style very hard to read, also the order of things is weird.

struct shazptr_scan {
	struct task_struct	*thread;
	struct swait_queue_head wq;
	struct list_head	scanning;

	struct mutex		lock;
	struct list_head	queued;    /* __guarded_by(lock) */
	bool			scheduled; /* __guarded_by(lock) */

	struct shazptr_snapshot snaps[0] __counted_by(nr_cpu_ids);
};

(the __guarded_by() thing will come with Thread-Safety support that
Google is still cooking in clang)

> +static struct shazptr_scan shazptr_scan;

And then make this a pointer, and allocate the whole thing as a single
data structure with however much snaps data you need.

