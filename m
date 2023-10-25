Return-Path: <netdev+bounces-44102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346107D6263
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD757281C73
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F247F501;
	Wed, 25 Oct 2023 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UdT00F8R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD4168BD
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:24:26 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9990
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698218662; x=1698477862;
	bh=hLPUnAQmcv+2moapPNcEY4GyhmvLPh8pt/AJMsWAKHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UdT00F8RI5b96NFbHX2ffdLniDKZKSHBFYK4a4oseLKmITQQoGoUTn7Z1wS5OY9xd
	 ONmyNaTHryLTqKswE0j1/8/pMBC0ktrypUmsGG85VZP0BpPEwkRHhcPAuf/2/e2Cdb
	 4IX95UAB1sdc68gynVOqEDfKFZNhzNfC+LrjYXF9LrJ6Rn28eEP69Vntfq4lQKz6qM
	 llG9Q0RBGT5a19hwQEXXvTVqUX/i7X2/GXNjWpbc/WJTV4DcdbOj5u4VZ8zHQQrIwN
	 JIo0cS89lVkW8L6tN/NhWWhbJhz9F8Gbcft9P1WFaxieTpRrJ2L27UHxACjibxI+Oh
	 jfXBwrrVdHWcQ==
Date: Wed, 25 Oct 2023 07:24:00 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network PHY drivers
Message-ID: <46b4ea56-1b66-4a8f-8c30-ecea895638b2@proton.me>
In-Reply-To: <20231025.101046.1989690650451477174.fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-2-fujita.tomonori@gmail.com> <1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me> <20231025.101046.1989690650451477174.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.10.23 03:10, FUJITA Tomonori wrote:
> On Tue, 24 Oct 2023 16:23:20 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 24.10.23 02:58, FUJITA Tomonori wrote:
>>> This patch adds abstractions to implement network PHY drivers; the
>>> driver registration and bindings for some of callback functions in
>>> struct phy_driver and many genphy_ functions.
>>>
>>> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=3Dy.
>>>
>>> This patch enables unstable const_maybe_uninit_zeroed feature for
>>> kernel crate to enable unsafe code to handle a constant value with
>>> uninitialized data. With the feature, the abstractions can initialize
>>> a phy_driver structure with zero easily; instead of initializing all
>>> the members by hand. It's supposed to be stable in the not so distant
>>> future.
>>>
>>> Link: https://github.com/rust-lang/rust/pull/116218
>>>
>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>
>> [...]
>>
>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>> new file mode 100644
>>> index 000000000000..2d821c2475e1
>>> --- /dev/null
>>> +++ b/rust/kernel/net/phy.rs
>>> @@ -0,0 +1,708 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> +
>>> +//! Network PHY device.
>>> +//!
>>> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h=
).
>>> +
>>> +use crate::{
>>> +    bindings,
>>> +    error::*,
>>> +    prelude::{vtable, Pin},
>>> +    str::CStr,
>>> +    types::Opaque,
>>> +};
>>> +use core::marker::PhantomData;
>>> +
>>> +/// PHY state machine states.
>>> +///
>>> +/// Corresponds to the kernel's [`enum phy_state`](https://docs.kernel=
.org/networking/kapi.html#c.phy_state).
>>
>> Please use `rustfmt`, this line is 109 characters long.
>=20
> Hmm, `make rustfmt` doesn't warn on my env. `make rustfmtcheck` or
> `make rustdoc` doesn't.

Sorry, my bad, `rustfmt` does not format comments, so you have to do
them manually.

> What's the limit?

The limit is 100 characters.

>> Also it might make sense to use a relative link, since then it also
>> works offline (though you have to build the C docs).
>=20
> /// Corresponds to the kernel's [`enum phy_state`](../../../../../network=
ing/kapi.html#c.phy_state).
>=20
> 101 characters too long?
>=20
> Then we could write:
>=20
> /// PHY state machine states.
> ///
> /// Corresponds to the kernel's
> /// [`enum phy_state`](../../../../../networking/kapi.html#c.phy_state).
> ///
> /// Some of PHY drivers access to the state of PHY's software state machi=
ne.

That is one way, another would be to do:

/// PHY state machine states.
///
/// Corresponds to the kernel's [`enum phy_state`].
///
/// Some of PHY drivers access to the state of PHY's software state machine=
.
///
/// [`enum phy_state`]: ../../../../../networking/kapi.html#c.phy_state

But as I noted before, then people who only build the rustdoc will not
be able to view it. I personally would prefer to have the correct link
offline, but do not know about others.

>>> +    /// Gets the current link state. It returns true if the link is up=
.

I just noticed this as well, here also please split the line.

>>> +    pub fn get_link(&self) -> bool {
>>> +        const LINK_IS_UP: u32 =3D 1;
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        let phydev =3D unsafe { *self.0.get() };
>>> +        phydev.link() =3D=3D LINK_IS_UP
>>> +    }
>>
>> Can we please change this name? I think Tomo is waiting for Andrew to
>> give his OK. All the other getter functions already follow the Rust
>> naming convention, so this one should as well. I think using
>> `is_link_up` would be ideal, since `link()` reads a bit weird in code:
>>
>>       if dev.link() {
>>           // ...
>>       }
>>
>> vs
>>
>>       if dev.is_link_up() {
>>           // ...
>>       }
>=20
> I'll go with is_link_up()
>=20
>=20
>>> +    /// Gets the current auto-negotiation configuration. It returns tr=
ue if auto-negotiation is enabled.
>>
>> Move the second sentence into a new line, it should not be part of the
>> one-line summary.
>=20
> Oops, make one-line?
>=20
> /// Gets the current auto-negotiation configuration and returns true if a=
uto-negotiation is enabled.
>=20
> Or
>=20
> /// Gets the current auto-negotiation configuration.
> ///
> /// It returns true if auto-negotiation is enabled.

I would prefer this, since the function name itself already is
pretty self-explanatory. If someone really wants to understand
it, they probably have to read the source code.

--=20
Cheers,
Benno


