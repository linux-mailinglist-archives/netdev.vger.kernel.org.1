Return-Path: <netdev+bounces-38797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D17BC88F
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6CC1C2093B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9028E06;
	Sat,  7 Oct 2023 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ujKLv4NU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2720314;
	Sat,  7 Oct 2023 15:13:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04FBA;
	Sat,  7 Oct 2023 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t43UbWO5VvFPxgnRpq0+0SD6kkLI0LxFhGg55Vsxqno=; b=ujKLv4NU3aHEqqZ9cVh6ku9n3R
	gmKIjCd0Met7btdyhXoo6Z1K0G40/KLoLlpW9VUaadeXAlQfKroAYu29fz/wnDAUWxZPCBxeXpIDG
	dM3BB9HECcyR74+4cLp8C7o1rrXchKSeU2H+1cHmUmFEpkn98R2mpiV9mzCFeTYbHinM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qp8ze-000K13-Pf; Sat, 07 Oct 2023 17:13:26 +0200
Date: Sat, 7 Oct 2023 17:13:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
Message-ID: <7edb5c43-f17b-4352-8c93-ae5bb9a54412@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-2-fujita.tomonori@gmail.com>
 <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The safety comment here still needs something like
> 
>     with the exception of fields that are synchronized via the `lock` mutex

I'm not sure that really adds much useful information. Which values
are protected by the lock? More importantly, which are not protected
by the lock?

As a general rule of thumb, driver writers don't understand
locking. Yes, there are some which do, but many don't. So the
workaround to that is make it so they don't need to understand
locking. All the locking happens in the core.

The exception is suspend and resume, which are called without the
lock. So if i was to add a comment about locking, i would only put a
comment on those two.

> > +    /// Executes software reset the PHY via BMCR_RESET bit.
> > +    pub fn genphy_soft_reset(&mut self) -> Result {
> > +        let phydev = self.0.get();
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        // So an FFI call with a valid pointer.
> > +        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
> > +    }
> > +
> > +    /// Initializes the PHY.
> > +    pub fn init_hw(&mut self) -> Result {
> > +        let phydev = self.0.get();
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        // so an FFI call with a valid pointer.
> > +        to_result(unsafe { bindings::phy_init_hw(phydev) })
> > +    }
> 
> Andrew, are there any restrictions about calling phy_init_hw more than
> once? Or are there certain things that you are not allowed to do until
> you call that function?

phy_init_hw can be called multiple times. It used by drivers as a work
around to broken hardware/firmware to get the device back into a good
state. It is also used during resume, since often the PHY looses its
settings when suspended.

> > +    unsafe extern "C" fn read_mmd_callback(
> > +        phydev: *mut bindings::phy_device,
> > +        devnum: i32,
> > +        regnum: u16,
> > +    ) -> i32 {
> > +        from_result(|| {
> > +            // SAFETY: The C API guarantees that `phydev` is valid while this function is running.
> > +            let dev = unsafe { Device::from_raw(phydev) };
> > +            let ret = T::read_mmd(dev, devnum as u8, regnum)?;
> > +            Ok(ret.into())
> > +        })
> > +    }
> 
> Since your're reading a bus, it probably doesn't hurt to do a quick
> check when converting
> 
>     let devnum_u8 = u8::try_from(devnum).(|_| {
>         warn_once!("devnum {devnum} exceeds u8 limits");
>         code::EINVAL
>     })?

I would actually say this is the wrong place to do that. Such checks
should happen in the core, so it checks all drivers, not just the
current one Rust driver. Feel free to submit a C patch adding this.

	Andrew

