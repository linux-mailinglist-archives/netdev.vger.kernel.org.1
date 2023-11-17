Return-Path: <netdev+bounces-48685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90347EF3BD
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BB28111B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0C3033E;
	Fri, 17 Nov 2023 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/fzCsec"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C7D52;
	Fri, 17 Nov 2023 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bfg5IxBs6VkVJhM+2t4BCQBz9c4aK7a7Z9rvuBVPhL4=; b=S/fzCseciwvTpIl0+DB8nel+IE
	CvpwAhzRMWdrUfOw3e56+quuotEOdAXdCKNr3oyJw2wRj1ANHSE2tzD34/GbPF9XyODyByPjaKQJQ
	aINX/+dzJfbR4JwAteeDRi8s9dB+DpIyyMPRhHft/+SqPQFjVtJ0s6O3UkayuR3ohGIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3yz4-000RUm-9O; Fri, 17 Nov 2023 14:34:10 +0100
Date: Fri, 17 Nov 2023 14:34:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: fujita.tomonori@gmail.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <61f93419-396d-4592-b28b-9c681952a873@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093903.2514513-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093903.2514513-1-aliceryhl@google.com>

> And you would also update the struct invariant accordingly:
> 
> /// # Invariants
> ///
> /// Referencing a `phy_device` using this struct asserts that the X
> /// mutex is held.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);
> 
> 
> 
> 
> 
> > +// During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
> > +// unique for every instance of [`Device`]. `PHYLIB` uses a different serialization technique for
> > +// [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with
> > +// the lock held, thus guaranteeing that [`Driver::resume`] has exclusive access to the instance.
> > +// [`Driver::resume`] and [`Driver::suspend`] also are called where only one thread can access
> > +// to the instance.
> 
> I used "X mutex" as an example for the synchronization mechanism in the
> above snippets, but it sounds like its more complicated than that? Here
> are some possible alternatives I could come up with:

So X would be phy_device->lock.

Suspend and resume don't have this lock held. I don't actually
remember the details, but there is an email discussion with Russell
King which does explain the problem we had, and why we think it is
safe to not hold the lock.

> /// # Invariants
> ///
> /// Referencing a `phy_device` using this struct asserts that the X
> /// mutex is held, or that the reference has exclusive access to the
> /// entire `phy_device`.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);

You can never have exclusive access to the entire phy_device, because
it contains a mutex. Other threads can block on that mutex, which
involves changing the linked list in the mutex.

But that is also a pretty common pattern, put the mutex inside the
structure it protects. So when you say 'exclusive access to the entire
`phy_device`' you actually mean excluding mutex, spinlocks, atomic
variables, etc?

> /// Referencing a `phy_device` using this struct asserts exclusive
> /// access to the following fields: phy_id, state, speed, duplex. And
> /// read access to the following fields: link, autoneg_complete,
> /// autoneg.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);

For the Rust code, you can maybe do this. But the Rust code calls into
C helpers to get the real work done, and they expect to have access to
pretty much everything in phy_device.

> /// # Invariants
> ///
> /// Referencing a `phy_device` using this struct asserts that the user
> /// is inside a Y scope as defined in Documentation/foo/bar.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);

There is no such documentation that i know of, except it does get
repeated again and again on the mailling lists. Its tribal knowledge.

> But I don't know how these things are actually synchronized. Maybe
> it is some sixth option. I would be happy to help draft these safety
> comments once the actual synchronization mechanism is clear to me.

The model is: synchronisation is not the drivers problem.

With a few years of experience reviewing drivers, you notice that
there are a number of driver writers who have no idea about
locking. They don't even think about it. So where possible, its best
to hide all the locking from them in the core. The core is in theory
developed by developers who do mostly understand locking and have a
better chance of getting it right. Its also exercised a lot more,
since its shared by all drivers.

My experience with this one Rust driver so far is that Rust developers
have problems accepting that its not the drivers problem.

	Andrew

