Return-Path: <netdev+bounces-201735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70430AEAD0C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C41C21CE9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BD194AD5;
	Fri, 27 Jun 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdfZsgQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A08219E8;
	Fri, 27 Jun 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993008; cv=none; b=dpYIUWKpCyck6P4QYO+TFgjMekkSbZGi46Op3iTVy6omoxsu/S5x+TquigVCA6MUJC2/IkHzEHIE0H3m9KLjSADAUUpYbwnB3Ste0Nx9vPyT0kpD3MKaQFW8T5MQvOnhNAj4eoir32gsOXzSBJMJQhycts8+/nv67vcVyuOBWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993008; c=relaxed/simple;
	bh=6HaipL2Nb3QqfyHkXwTX10Vg5Q0zLosiWZASw1iDunI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iygLSTWcfVFe73Ih9S0g7nScfwqovRsLZBtKjIbZygZZLLw0UvPFs2m4rj8TyTIOiio6qYdhYMGiV4i+PqUsTeg9f/UkqjgUHqb3d2tcYXeN6XdhT7V/F2jhMXba/v6LHDN7XCB+RRja6MFwQ26AFR3VgpQAIunoVNNQtmgoxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdfZsgQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB8C4CEEE;
	Fri, 27 Jun 2025 02:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750993008;
	bh=6HaipL2Nb3QqfyHkXwTX10Vg5Q0zLosiWZASw1iDunI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OdfZsgQJGCnp3QbzwZi/zpPrlV5AoEmH+oQkmwbR6fdiolFsnMuFy5CbxALNOtiIl
	 K3izNJ445A48065KWMd5dheH849l83Vg0XMaYNBhLm/OHhNIMjXaWIAMIyuVXX1oHj
	 8ST9CyjCzuLKEuS6AE3RJY1depX4h/si9ywALa8ffHaOKsQEI7czwRP/P4hOmBzHTL
	 OYSohwCRSgjkzUGQQTKYP6tl5FEs0XMZ0lIalMChEoUf33q/JnyYOB+RIxzXSE8QQG
	 36bti5RB2cXv7p2zSLKRKySeQrSPbG5gyEzSFr01Z9EIFDkIW2IhWckSxMUE7rmMJt
	 HDlifh/m7lBFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99F29CE0C3C; Thu, 26 Jun 2025 19:56:47 -0700 (PDT)
Date: Thu, 26 Jun 2025 19:56:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
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
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <a8e06076-3f66-441f-9ccb-0b368d95e1a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <aFvl96hO03K1gd2m@infradead.org>
 <aFwC-dvuyYRYSWpY@Mac.home>
 <aF0eEfoWVCyoIAgx@infradead.org>
 <aF1rjV8XQozi7hXB@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1rjV8XQozi7hXB@Mac.home>

On Thu, Jun 26, 2025 at 08:47:25AM -0700, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 03:16:49AM -0700, Christoph Hellwig wrote:
> > On Wed, Jun 25, 2025 at 07:08:57AM -0700, Boqun Feng wrote:
> > > Sure, I will put one for the future version, here is the gist:
> > 
> > Thanks a lot!
> > 
> > > The updater's wait can finish immediately if no one is accessing 'a', in
> > > other words it doesn't need to wait for reader 2.
> > 
> > So basically it is the RCU concept, but limited to protecting exactly
> > one pointer update per critical section with no ability for the read
> > to e.g. acquire a refcount on the objected pointed to by that pointer?
> 
> For the current simple hazard pointer, yes. But simple hazard pointers
> is easily to extend so support reading:
> 
> 	{ gp is a global pointer }
> 
> 	Reader				Updater
> 	======				=======
> 	g = shazptr_acquire(p):
> 	      WRITE_ONCE(*this_cpu_ptr(slot), gp);
> 	      smp_mb();
> 	
> 	if (READ_ONCE(gp) == *this_cpu_ptr(slot)) {
> 	    // still being protected.
> 	    <can read gp here>
> 					to_free = READ_ONCE(gp);
> 					WRITE_ONCE(gp, new);
> 					synchronize_shazptr(to_free):
> 					  smp_mb();
> 					  // wait on the slot of reader
> 					  // CPU being 0.
> 					  READ_ONCE(per_cpu(reader, slot));
> 	}
> 
> 	shazptr_clear(g):
> 	  WRITE_ONCE(*this_cpu_ptr(slot), NULL); // unblock synchronize_shazptr()
> 
> 
> Usually the shazptr_acqurie() + "pointer comparison"* is called
> shazptr_try_protect().
> 
> I will add a document about this in the next version along with other
> bits of hazard pointers.
> 
> [*]: The pointer comparison is more complicated topic, but Mathieu has
>      figured out how to do it correctly:
> 
>      https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/

It might be helpful to add that, at a high level, hazard pointers
are a scalable replacement for reference counting.  At a similarly
high level, RCU is a scalable replacement for reader-writer locking.
At lower levels, there is considerable overlap in applicability, so that
you can use RCU to replace many reference-counting use cases and hazard
pointers to replace many reader-writer-locking use cases..

Plus, as both Mathieu and Boqun pointed out, both RCU and hazard pointers
can be combined with other synchronization mechanisms, including each
other.

							Thanx, Paul

