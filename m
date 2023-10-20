Return-Path: <netdev+bounces-43088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F37D15EE
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1288C282623
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A01DFE3;
	Fri, 20 Oct 2023 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bri4C+w5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA91D6BE;
	Fri, 20 Oct 2023 18:42:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5D1A8;
	Fri, 20 Oct 2023 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fzLPwxBO4eTsZi7lhB7UsZ4CqCFBDHmJkwyiD5oBlHs=; b=bri4C+w5o+dRM/auPkE+tsUaGM
	AfW58BYEC2JPdNoNmjK0Q3uBlCQ1xjncZgXawAg8KrIJ2PSU+sEA4lCRuBSP3Uvhnmhv/OqKLWrvQ
	fDe0QwBThDZtaUvIhuJ6o9cAQbrLQL9iyBh7AG2n8Q9gyU9A9XTGWvLVhbYMOdW6bsRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qtuRm-002oIw-SV; Fri, 20 Oct 2023 20:42:10 +0200
Date: Fri, 20 Oct 2023 20:42:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
 <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>

> > +//! All the PHYLIB helper functions for `phy_device` modify some members in `phy_device`. Except for
> > +//! getter functions, [`Device`] methods take `&mut self`. This also applied to `read()`, which reads
> > +//! a hardware register and updates the stats.
> 
> I would use [`Device`] instead of `phy_device`, since the Rust reader
> might not be aware what wraps `phy_device`.

We don't want to hide phy_device too much, since at the moment, the
abstraction is very minimal. Anybody writing a driver is going to need
a good understanding of the C code in order to find the helpers they
need, and then add them to the abstraction. So i would say we need to
explain the relationship between the C structure and the Rust
structure, to aid developers.

> > +    /// Returns true if the link is up.
> > +    pub fn get_link(&self) -> bool {
> 
> I still think this name should be changed. My response at [1] has not yet
> been replied to. This has already been discussed before:
> - https://lore.kernel.org/rust-for-linux/2023100237-satirical-prance-bd57@gregkh/
> - https://lore.kernel.org/rust-for-linux/20231004.084644.50784533959398755.fujita.tomonori@gmail.com/
> - https://lore.kernel.org/rust-for-linux/CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com/
> 
> And I want to suggest to change it to `is_link_up`.
> 
> Reasons why I do not like the name:
> - `get_`/`put_` are used for ref counting on the C side, I would like to
>    avoid confusion.
> - `get` in Rust is often used to fetch a value from e.g. a datastructure
>    such as a hashmap, so I expect the call to do some computation.
> - getters in Rust usually are not prefixed with `get_`, but rather are
>    just the name of the field.
> - in this case I like the name `is_link_up` much better, since code becomes
>    a lot more readable with that.
> - I do not want this pattern as an example for other drivers.
> 
> [1]: https://lore.kernel.org/rust-for-linux/f5878806-5ba2-d932-858d-dda3f55ceb67@proton.me/
> 
> > +        const LINK_IS_UP: u32 = 1;
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        let phydev = unsafe { *self.0.get() };
> > +        phydev.link() == LINK_IS_UP
> > +    }

During the reviews we have had a lot of misunderstanding what this
actually does, given its name. Some thought it poked around in
registers to get the current state of the link. Some thought it
triggered the PHY to establish a link. When in fact its just a dumb
getter. And we have a few other dumb getters and setters.

So i would prefer something which indicates its a dumb getter. If the
norm of Rust is just the field name, lets just use the field name. But
we should do that for all the getters and setters. Is there a naming
convention for things which take real actions?

And maybe we need to add a comment: Get the current link state, as
stored in the [`Device`]. Set the duplex value in [`Device`], etc.

   Andrew

