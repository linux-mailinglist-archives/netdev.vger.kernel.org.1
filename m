Return-Path: <netdev+bounces-133092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9599487D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8BB280944
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47431DE8BA;
	Tue,  8 Oct 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HxEeYtdl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0E1DE890;
	Tue,  8 Oct 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389598; cv=none; b=R77Vl5sVvOyFZ04OSV/t8eD6QMYUJ0bOkF/2lNwlT9xptmGfrLQq2b33pmoZWbQs9Kv0ek3EUCqN7NSxi/+26g4WW+9+f7AFKKmSNJRcT8KjcNRxMyzwUvoJDxECFgwWC5GArjIv0LYpcpY9u9vGQyIhcoKxJUpgGZY5lqNnVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389598; c=relaxed/simple;
	bh=b/rICZn5YA7qU14yNCJqxyA1CIc9OyL1ccsTZ3xGe2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jac7H5h43rcWEs9IfA1CWmrSnG/4j5EbB9ijOYuwzV+YODiuOltxy//8HGigw5XdZu2FLm82JPe5jzad1xt4Cxa7EIqsX1MF30DRLAJ+PKmd1ipb7Hn0lwAmWU2PmPkX76Ojb7U3rXv8bV6I55VdZy+gRouGNtugr171zP5668Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HxEeYtdl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ur4KGvVtjMfD5527Us45mYK0/mg6HZ64NcNM+M8g7Lk=; b=HxEeYtdlazJMqfuGVAAHlAOjAX
	dA+dkW9Q1aXqRdu1sr+9W3dwCFUYSzQD3nLz0GVSiRXA7owcPZEDkLXKQFmxPG8ODs/OP+HlUq7J9
	ekzLOZFGVOkt7Lrhp+zCOhTjFzQXjziNgWDchbg60cimr4ItrXkc3i5ilhybcAlwXQC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sy959-009Mkd-Ib; Tue, 08 Oct 2024 14:12:51 +0200
Date: Tue, 8 Oct 2024 14:12:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
References: <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwRq7PzAPzCAIBVv@boqun-archlinux>

> Because of the might_resched() in might_sleep(), it will report the
> quiescent state of the current CPU, and RCU will pass a grace period if
> all CPUs have passed a quiescent state. So for example if someone writes
> the following:
> 
>     <reader>			<updater>
>     rcu_read_lock();
>     p = rcu_dereference(gp);
>     might_sleep():
>       might_resched():
> 				todo = gp;
> 				rcu_assign_pointer(gp, NULL);
> 				synchronize_rcu();
> 
>         rcu_all_qs(); // report a quiescent state inside RCU read-side
> 	              // critical section, which may make a grace period
> 		      // pass even there is an active RCU reader
> 
> 				kfree(todo);
> 

You are obviously missing something here. The call that actually sleeps

      mutex_lock(&lock)

>     a = READ_ONCE(p->a); // UAF
>     rcu_read_unlock();

A might_sleep() should be paired with something which does actually
sleep, under some condition.  At least, that is how it is used in C.
The iopoll being re-implemented here is an example of that.

So take the might_sleep out above, just leaving the mutex_lock. If the
mutex is uncontested, the code does not sleep and everything is O.K?
If it needs to wait for the mutex, it triggers a UAF.

The might_sleep() will also trigger a stack trace, if its is enabled,
because you are not allowed to sleep inside rcu_read_lock(), it is an
example of atomic context.

As far as i see, might_sleep() will cause UAF where there is going to
be a UAF anyway. If you are using it correctly, it does not cause UAF.

> We probably call the reader side code a "wrong annotation", however,
> it's still unsafe code because of the UAF. Also you seems to assume that
> might_sleep() is always attached to a sleepable function, which is not
> an invalid assumption, but we couldn't use it for reasoning the
> safe/unsafe property of Rust functions unless we can encode this in the
> type system.

How are any of the sleeping call encoded in the type system? I assume
any use of a mutex lock, sleep, wait for completion, etc are not all
marked as unsafe? There is some sort of wrapper around them? Why not
just extend that wrapper to might_sleep().

> For Rust code, without klint rule, might_sleep() needs to
> be unsafe. So we have two options for might_sleep().
> 
> * Since we rely on klint for atomic context detection, we can mark the
>   trivial wrapper (as what Alice presented in the other email) as safe,
>   but we need to begin to add klint annotation for that function, unless
>   Gary finds a smart way to auto-annotate functions.

Are there klint annotations for all sleeping functions?

> * Instead of might_sleep(), we provide the wrapper of __might_sleep(),
>   since it doesn't have might_resched() in it, it should be safe. And
>   all we care about here is the debugging rather than voluntary context
>   switch. (Besides I think preempt=volunatry is eventually going to be
>   gone because of PREEMPT_AUTO [1], if that happens I think the
>   might_resched() might be dropped entirely).

__might_sleep() might be safe, but your code is still broken and going
to UAF at some point. Don't you want that UAF to happen more reliably
and faster so you can find the issue? That would be the advantage of
might_sleep() over __might_sleep().

	Andrew

