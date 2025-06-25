Return-Path: <netdev+bounces-201116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A3AE823D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB36166209
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6025D902;
	Wed, 25 Jun 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GxgxDxqk"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409A3074A3;
	Wed, 25 Jun 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852778; cv=none; b=ESXN362riCc1b4clh5TyVQ8/cxNc8HprxND/+6qA8B1a9BrjvSdaNYLtbQYn52ey4/NR4uwlkkA1qd4Oh/l9ZVUgLVYM+2HW0nmkxm2XEw/EiK9u3udG9HymU8rhQcrSu0K9JXvab0obyWHsMZcgj+TA/3WAp8xKxlrDkLdrKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852778; c=relaxed/simple;
	bh=h+ijjXmu1wbbYsnqfLBqzy4tn+a/qz1U+zrds/X3Kcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3tWxh6yyU2mQ+voivnR3OUG9ZCCbe8ba+o7GAEvqUBAX+r0vUq1vXYa8aY+sC+cKxHSoo0lkBCvB78LW+W20MNV8QJqgWCs+Poyij2PkNORA9E/q279Uon1lwIsV9tbWqeEnRNP3RDdx5fol1mVeJ50iaAtRq0HqD0J0hgRsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GxgxDxqk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1FV/d7UHobYsdaZhzKxACw6BcxJHdtRiAt5NxAf4NVw=; b=GxgxDxqkDRxEdL43N34W39XuQT
	YDHapwgoUxVZUNSbYEbq93ugYbrsaJ5Sis50AhYDccjm1nPJVHISqjZ/H3GY3xWIgiC37h+s3c0HE
	QW8yvE4x/YEisxxYyqxP/jW7fRS00je1c4xzYxOYWczNg7kICKQbjR6LrPhOrZbk7SgZgqtdKfR3W
	70BEEqnmQ5Ygw7uomYXvMypVpRYPt6jYHyIK8paFhA7Lr6EBCsCcJrGwmdpAJ2pgjIJPec6wsi/rH
	kTbGWtZplXTAKFeIbebByABQhDBRyqHuNFrSf2qjEZ3yC4kRmG/pvSlWe05bDzY70we/ksK2125cP
	2UI5ed5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOmo-00000005qSR-2Dk6;
	Wed, 25 Jun 2025 11:59:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEB6C306158; Wed, 25 Jun 2025 13:59:29 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:59:29 +0200
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
Subject: Re: [PATCH 8/8] locking/lockdep: Use shazptr to protect the key
 hashlist
Message-ID: <20250625115929.GF1613376@noisy.programming.kicks-ass.net>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-9-boqun.feng@gmail.com>

On Tue, Jun 24, 2025 at 08:11:01PM -0700, Boqun Feng wrote:

> +	/* Need preemption disable for using shazptr. */
> +	guard(preempt)();
> +
> +	/* Protect the list search with shazptr. */
> +	guard(shazptr)(hash_head);

OK, this is the end of the series, and so far every single user is doing
both a preempt and a shazptr guard. Why can't we simplify this and have
the shazptr guard imply preempt-disable?

