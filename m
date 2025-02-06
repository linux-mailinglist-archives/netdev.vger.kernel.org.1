Return-Path: <netdev+bounces-163314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC58A29E89
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39111888B86
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75238385;
	Thu,  6 Feb 2025 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VnbRlnNJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418729CE7
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806571; cv=none; b=pff1QlvaHUCqIJOuaBvf0tzXoeiv+deQYM+0XspkNscUvb+7p+YcYwqzQc5hD8oH2Z4DpgqJt+FqEX0/Z78ljG+a+JUkcNcVg1mKE5H+zJBzeCSZ8ZGaCzmiq2olraf4HUxjiPRPGFiaju21HjUYWeaYb61bk1Lo8CwE7NIT3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806571; c=relaxed/simple;
	bh=p6Jja403508AzvUky0URVH7Xxr51fWogYAlWxhd+mSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKfhX7q0YldBRx8/ihRzFAOslqvDTklpQyhufqoJnmXiKXvmAKJIB/YRJIWvTFVNBgm/TAvUCqE7SHyiKif6Emde3MUY6OypcLWmcXR1hDkKWJZCjmB6tRnbhEQTi4CTb5co49XxT00h+P06N/fpxmls4xchkaJC0HeQSUcOeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VnbRlnNJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yoUO0hE+nfNkNjlqjrDnBNTDzWdDi+DfYeBQdZ3tzE4=; b=Vn
	bRlnNJrjvFZF1pgUHqOJHbPXe8BhSOyPa252gJjKrzxHrzyHh4yO8ez/504+3EFvwC2NRD6wCURHe
	6QhRDkF3aUO0Kcq4YxSXuJErOhsJZJc1eqFmka9QLKytaj8kUyJfBISlw3OQ73ixbK7nd0Nu5A47K
	dBwk3jqdLjppvxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfr17-00BMZE-Jr; Thu, 06 Feb 2025 02:49:21 +0100
Date: Thu, 6 Feb 2025 02:49:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
Message-ID: <32afcb33-84f3-4f08-862a-6c1687314841@lunn.ch>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
 <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
 <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
 <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com>
 <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>
 <9a3a38c2-3752-4ad2-a473-4d8f47ce7bc6@lunn.ch>
 <CAGXJAmzD7AR7vf54CVGHnRqwJnJFpO_aEQ5s8w-OdXjw0c8FKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmzD7AR7vf54CVGHnRqwJnJFpO_aEQ5s8w-OdXjw0c8FKg@mail.gmail.com>

On Wed, Feb 05, 2025 at 03:56:36PM -0800, John Ousterhout wrote:
> On Mon, Feb 3, 2025 at 9:58 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > > If that happens then it could grab the lock instead of the desired
> > > > > application, which would defeat the performance optimization and delay the
> > > > > application a bit. This would be no worse than if the APP_NEEDS_LOCK
> > > > > mechanism were not present.
> > > >
> > > > Then I suggest using plain unlock/lock() with no additional spinning in
> > > > between.
> > >
> > > My concern here is that the unlock/lock sequence will happen so fast
> > > that the other thread never actually has a chance to get the lock. I
> > > will do some measurements to see what actually happens; if lock
> > > ownership is successfully transferred in the common case without a
> > > spin, then I'll remove it.
> >
> > https://docs.kernel.org/locking/mutex-design.html
> >
> > If there is a thread waiting for the lock, it will spin for a while
> > trying to acquire it. The document also mentions that when there are
> > multiple waiters, the algorithm tries to be fair. So if there is a
> > fast unlock/lock, it should act fairly with the other waiter.
> 
> The link above refers to mutexes, whereas the code in question uses spinlocks.

Ah, sorry, could not see that from the context in the email.

> * With the call to homa_spin the handoff fails 0.3-1% of the time.
> This happens because of delays in the needy thread, typically an
> interrupt that keeps it from retrying the lock quickly. This surprised
> me as I thought that interrupts  were disabled by spinlocks, but I
> definitely see the interrupts happening; maybe only *some* interrupts
> (softirqs?) are disabled by spinlocks?

By defaults, spinlocks don't disable interrupts. Which is why you
cannot use them in interrupt handlers. There is however

spin_lock_irqsave(lock, flags);
spin_unlock_irqrestore(lock, flags);

which saves the current interrupt state into flags, and disable
interrupts if needed. The state is then restore when you unlock.

Also, when PREEMPT_RT is enabled for real time support, spinlocks get
turned into mutexes.

	Andrew

