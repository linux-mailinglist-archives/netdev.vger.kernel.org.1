Return-Path: <netdev+bounces-177798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D3A71CB1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422817A5717
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAA1F8691;
	Wed, 26 Mar 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvfDAytm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACA1F3B9C;
	Wed, 26 Mar 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009029; cv=none; b=f7J36hK1K0hHtjkeTA8uM6k5mCtsGAla0JyFs9o2JXfFFxcFh3AVwbRqLqpwDMOZd1G9ZgitlCiH1wtEk7iqgTdEN5AOCqPBks59jdkd98NxU3RvqjiB1vaxFytsU/LGnjWiQcZZkzs/JLf1UNjDH2Cf8EypBzvmACNKRiypvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009029; c=relaxed/simple;
	bh=hkIJzrJAVgxxOP85pPnj+37jDRnxpFLezcnaPyrWpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIZWIkakPVTZC7297rUPCiq5XAuYBnqT3VYWlMm/fDAQSBJ3aWVfLqSnOgZqmtbUdpmDrcNQd0Uucsc5WHgUyqS9mZnFKB7aGQXlwycbGVZ9DMfzHlTvpcwDtRiaGSaQjVVuGSGqiOhLt1ZuBzGJrA2fF9sGz25RXOd5mgMAbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvfDAytm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FE3C4CEE2;
	Wed, 26 Mar 2025 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009029;
	bh=hkIJzrJAVgxxOP85pPnj+37jDRnxpFLezcnaPyrWpvs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mvfDAytmpL7i7EhFSpSNezQTfKEEygd/ubBKkMi0d6lv6oxpT4eVa2FFov9B822B8
	 rl7I50FL9M1PwHryplpqEdr6yjEV4IoGKfmj7sGVzIDcdkkBm7NzLhhcbhYE6p+1mn
	 Nl6Ks9ij0YTw2QVflM0WhIb60AEPerO6qnuitEBQn1NQ5XI65FEjFxaSd61SH+LTe1
	 z6j3RC8tPDuxXigkW3GodZyeQx/80t8jJTXRoGriePR/rG1rL47fTFDJXZa3WFwNtv
	 x932nzD7KA6WceqNIycp37pmy83W/HJonUI/SBFMpWFja2IJ1fzYU8gGgywZ/8xJjq
	 hdjAoq1lYmxQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FCB9CE0C2A; Wed, 26 Mar 2025 10:10:28 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:10:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
 <Z-QvvzFORBDESCgP@Mac.home>
 <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>

On Wed, Mar 26, 2025 at 01:02:12PM -0400, Waiman Long wrote:
> 
> On 3/26/25 12:47 PM, Boqun Feng wrote:
> > On Wed, Mar 26, 2025 at 12:40:59PM -0400, Waiman Long wrote:
> > > On 3/26/25 11:39 AM, Waiman Long wrote:
> > > > On 3/26/25 1:25 AM, Boqun Feng wrote:
> > > > > > It looks like you are trying hard to find a use case for hazard pointer in
> > > > > > the kernel 🙂
> > > > > > 
> > > > > Well, if it does the job, why not use it 😉 Also this shows how
> > > > > flexible hazard pointers can be.
> > > > > 
> > > > > At least when using hazard pointers, the reader side of the hash list
> > > > > iteration is still lockless. Plus, since the synchronization part
> > > > > doesn't need to wait for the RCU readers in the whole system, it will be
> > > > > faster (I tried with the protecting-the-whole-hash-list approach as
> > > > > well, it's the same result on the tc command). This is why I choose to
> > > > > look into hazard pointers. Another mechanism can achieve the similar
> > > > > behavior is SRCU, but SRCU is slightly heavier compared to hazard
> > > > > pointers in this case (of course SRCU has more functionalities).
> > > > > 
> > > > > We can provide a lockdep_unregister_key_nosync() without the
> > > > > synchronize_rcu() in it and let users do the synchronization, but it's
> > > > > going to be hard to enforce and review, especially when someone
> > > > > refactors the code and move the free code to somewhere else.
> > > > Providing a second API and ask callers to do the right thing is probably
> > > > not a good idea and mistake is going to be made sooner or later.
> > > > > > Anyway, that may work. The only problem that I see is the issue of nesting
> > > > > > of an interrupt context on top of a task context. It is possible that the
> > > > > > first use of a raw_spinlock may happen in an interrupt context. If the
> > > > > > interrupt happens when the task has set the hazard pointer and iterating the
> > > > > > hash list, the value of the hazard pointer may be overwritten. Alternatively
> > > > > > we could have multiple slots for the hazard pointer, but that will make the
> > > > > > code more complicated. Or we could disable interrupt before setting the
> > > > > > hazard pointer.
> > > > > Or we can use lockdep_recursion:
> > > > > 
> > > > > 	preempt_disable();
> > > > > 	lockdep_recursion_inc();
> > > > > 	barrier();
> > > > > 
> > > > > 	WRITE_ONCE(*hazptr, ...);
> > > > > 
> > > > > , it should prevent the re-entrant of lockdep in irq.
> > > > That will probably work. Or we can disable irq. I am fine with both.
> > > > > > The solution that I am thinking about is to have a simple unfair rwlock to
> > > > > > protect just the hash list iteration. lockdep_unregister_key() and
> > > > > > lockdep_register_key() take the write lock with interrupt disabled. While
> > > > > > is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
> > > > > > and we don't need RCU to protect the iteration process and so the last
> > > > > > synchronize_rcu() call isn't needed. The level of contention should be low
> > > > > > enough that live lock isn't an issue.
> > > > > > 
> > > > > This could work, one thing though is that locks don't compose. Using a
> > > > > hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
> > > > > -> "hash write_lock" dependency, and that means you cannot
> > > > > lockdep_lock() while you're holding a hash read_lock, although it's
> > > > > not the case today, but it certainly complicates the locking design
> > > > > inside lockdep where there's no lockdep to help 😉
> > > > Thinking about it more, doing it in a lockless way is probably a good
> > > > idea.
> > > > 
> > > If we are using hazard pointer for synchronization, should we also take off
> > > "_rcu" from the list iteration/insertion/deletion macros to avoid the
> > > confusion that RCU is being used?
> > > 
> > We can, but we probably want to introduce a new set of API with suffix
> > "_lockless" or something because they will still need a lockless fashion
> > similar to RCU list iteration/insertion/deletion.
> 
> The lockless part is just the iteration of the list. Insertion and deletion
> is protected by lockdep_lock().
> 
> The current hlist_*_rcu() macros are doing the right things for lockless use
> case too. We can either document that RCU is not being used or have some
> _lockless helpers that just call the _rcu equivalent.

We used to have _lockless helper, but we got rid of them.  Not necessarily
meaning that we should not add them back in, but...  ;-)

							Thanx, Paul

