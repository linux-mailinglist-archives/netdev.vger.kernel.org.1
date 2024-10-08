Return-Path: <netdev+bounces-133325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00780995A0E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E114028393F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7139215F57;
	Tue,  8 Oct 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BcJ7mDDi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32038215005;
	Tue,  8 Oct 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426382; cv=none; b=Qors2qJerpWeo6ykh8AHEJEmV8FrTY04NZy/S6D9TgwUHJQ6TGxOvuxaSTlkBeJWdbbBi5lpkRhNy9sezX2EJvPV6oQFi/sS9Ii1JtGmX5FXWgC0OLgKzUivk2N5n9ApTl20UV7HRfbU+IAWQ4BAB/syeyPcZNp5WUdxRggTHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426382; c=relaxed/simple;
	bh=BEN+Imuy9+OSJ/g5BEyh4iCRtXORsG6ZCXrGS4TpajA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAWWB/l4w/Cp4/7usaKv8cgy3nWLhr1Icry5cNGdv75tYRefmSuJqsL5CDfxoX5hQqzDJj/yi8XgHvygjcXstXtTb4XceN5Lz6k8qDKglod/1qiQ3UcsgemO7+A/JU4GRvCHBowV90n8l2+xAgmUtadBGCCeKG/5KG2bkTaWhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BcJ7mDDi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/tQgqoykOqtITtW4+3hZ4DRT8pHz+6Smc5S01M5iIBg=; b=Bc
	J7mDDidO5lxkneR+wsaAezc6SZh3Tpg2WJtraXNn99w7CB9jRQ3QmPsvFJjLc+3K5elD+fZqTWX6L
	J3JdfqF6VfAJovlZaAYLGoyE0unwrzTx4ynqhBXVAxMPFgrofJqk9WpbqWFi1DmTwd27m5m/fr6sB
	F+OzLrflP62rj4w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syIeW-009Q4p-RL; Wed, 09 Oct 2024 00:26:00 +0200
Date: Wed, 9 Oct 2024 00:26:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <32e97ba4-a47b-488a-b098-725faae21d7d@lunn.ch>
References: <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
 <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
 <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>
 <ZwWp9C2X_QIrTJEq@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwWp9C2X_QIrTJEq@boqun-archlinux>

On Tue, Oct 08, 2024 at 02:53:56PM -0700, Boqun Feng wrote:
> On Tue, Oct 08, 2024 at 07:16:42PM +0200, Andrew Lunn wrote:
> > On Tue, Oct 08, 2024 at 03:14:05PM +0200, Miguel Ojeda wrote:
> > > On Tue, Oct 8, 2024 at 2:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > As far as i see, might_sleep() will cause UAF where there is going to
> > > > be a UAF anyway. If you are using it correctly, it does not cause UAF.
> > > 
> > > This already implies that it is an unsafe function (in general, i.e.
> > > modulo klint, or a way to force the user to have to write `unsafe`
> > > somewhere else, or what I call ASHes -- "acknowledged soundness
> > > holes").
> > > 
> > > If we consider as safe functions that, if used correctly, do not cause
> > > UB, then all functions would be safe.
> > 
> > From what i hear, klint is still WIP. So we have to accept there will
> > be bad code out there, which will UAF. We want to find such bad code,
> 
> If you don't believe in klint

I did not say that. It is WIP, and without it i assume nothing is
detecting at compile time that the code is broken. Hence we need to
find the problem at runtime, which is what might_sleep() is all about.

> might_sleep() is useful because it checks preemption count and task
> state, which is provided by __might_sleep() as well. I don't think
> causing UAF helps we detect atomic context violation faster than what
> __might_sleep() already have. Again, could you provide an example that
> help me understand your reasoning here?

> > while (1) {
> >     <reader>                        <updater>
> >     rcu_read_lock();
> >     p = rcu_dereference(gp);
> >     mutex_lock(&lock)
> >     a = READ_ONCE(p->a);
> >     mutex_unlock(&lock)
> >     rcu_read_unlock();
> > }

The mutex lock is likely to be uncontested, so you don't sleep, and so
don't trigger the UAF. The code is clearly broken, but you survive.
Until the lock is contested, you do sleep, RCU falls apart, resulting
in a UAF.

Now if you used might_sleep(), every time you go around that loop you
do some of the same processing as actually sleeping, so are much more
likely to trigger the UAF.

might_sleep() as you pointed out, is also active when
CONFIG_DEBUG_ATOMIC_SLEEP is false. Thus it is also going to trigger
the broken code to UAF faster. And i expect a lot of testing is done
without CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_PROVE_LOCKING.

Once klint is completed, and detects all these problems at compile
time, we can then discard all this might_sleep stuff. But until then,
the faster code explodes, the more likely it is going to be quickly
and cheaply fixed.

	Andrew

