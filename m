Return-Path: <netdev+bounces-40969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B427C935F
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF51B20AF9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA363AE;
	Sat, 14 Oct 2023 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="A5rFhRsb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20963AA
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 08:07:21 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C8BF
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697270838; x=1697530038;
	bh=Qzmlposn48sGLfw9zonilaLcg4tsJqZySBdJhgZdJMM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=A5rFhRsbRWzNaY5DWLpaSwInsmIuUUPb2UW8kCiVJHSQxrkGTHubYKaLI0uWB6SA1
	 TMuwNrAxZ9w7qj4tZj76VtH3DdREtad+hOVAjSW+FEqCWF3ROlQPJRvjECEjOXbmCs
	 2RUy8UjzE4sVzJvtBykRHm7CgfdXEw0jrn+8dyfU5YmqhGrZZvVdKgJ1ibouHHjiW9
	 rSoF625XIT+1x32UY8u1FKqa3QUk6eUEKoKUHxnp2oac2xhU+fe1egq47u6bwYsYJT
	 IigMu1APqRbVefodtpPbiglTa8YG6bl3nIgdlyI+UFY0y5fKdudKTrOZdxnPyh18O0
	 JmCegalvKWllg==
Date: Sat, 14 Oct 2023 08:07:03 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
In-Reply-To: <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com> <20231012125349.2702474-2-fujita.tomonori@gmail.com> <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me> <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14.10.23 09:22, FUJITA Tomonori wrote:
> On Fri, 13 Oct 2023 21:31:16 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>
>> In some other thread you mentioned that no lock is held for
>> `resume`/`suspend`, how does this interact with it?
>=20
> The same quesiton, 4th time?

Yes, it is not clear to me from the code/safety comment alone why
this is safe. Please improve the comment such that that is the case.

> PHYLIB is implemented in a way that PHY drivers exlusively access to
> phy_device during the callbacks.

As I suggested in a previous thread, it would be extremely helpful
if you add a comment on the `phy` abstractions module that explains
how `PHYLIB` is implemented. Explain that it takes care of locking
and other safety related things.

>>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut =
Self {
>>> +        // SAFETY: The safety requirements guarantee the validity of t=
he dereference, while the
>>> +        // `Device` type being transparent makes the cast ok.
>>> +        unsafe { &mut *ptr.cast() }
>>
>> please refactor to
>>
>>       // CAST: ...
>>       let ptr =3D ptr.cast::<Self>();
>>       // SAFETY: ...
>>       unsafe { &mut *ptr }
>=20
> I can but please tell the exactly comments for after CAST and SAFETY.
>=20
> I can't find the description of CAST comment in
> Documentation/rust/coding-guidelines.rst. So please add why and how to
> avoid repeating the same review comment in the future.

I haven't had the time to finish my work on the standardization of
`SAFETY` (and also `CAST`) comments, but I am working on that.

        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::=
phy_device`.
        let ptr =3D ptr.cast::<Self>();
        // SAFETY: by the function requirements the pointer is valid and we=
 have unique access for
        // the duration of `'a`.
        unsafe { &mut *ptr }

>>> +    /// Returns true if auto-negotiation is completed.
>>> +    pub fn is_autoneg_completed(&self) -> bool {
>>> +        const AUTONEG_COMPLETED: u32 =3D 1;
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        let phydev =3D unsafe { *self.0.get() };
>>> +        phydev.autoneg_complete() =3D=3D AUTONEG_COMPLETED
>>> +    }
>>> +
>>> +    /// Sets the speed of the PHY.
>>> +    pub fn set_speed(&self, speed: u32) {
>>
>> This function modifies state, but is `&self`?
>=20
> Boqun asked me to drop mut on v3 review and then you ask why on v4?
> Trying to find a way to discourage developpers to write Rust
> abstractions? :)
>=20
> I would recommend the Rust reviewers to make sure that such would
> not happen. I really appreciate comments but inconsistent reviewing is
> painful.

I agree with Boqun. Before Boqun's suggestion all functions were
`&mut self`. Now all functions are `&self`. Both are incorrect. A
function that takes `&mut self` can modify the state of `Self`,
but it is weird for it to not modify anything at all. Such a
function also can only be called by a single thread (per instance
of `Self`) at a time. Functions with `&self` cannot modify the
state of `Self`, except of course with interior mutability. If
they do modify state with interior mutability, then they should
have a good reason to do that.

What I want you to do here is think about which functions should
be `&mut self` and which should be `&self`, since clearly just
one or the other is wrong here.

>>> +        let phydev =3D self.0.get();
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        // So an FFI call with a valid pointer.
>>> +        let ret =3D unsafe { bindings::phy_read_paged(phydev, page.int=
o(), regnum.into()) };
>>> +        if ret < 0 {
>>> +            Err(Error::from_errno(ret))
>>> +        } else {
>>> +            Ok(ret as u16)
>>> +        }
>>> +    }
>>
>> [...]
>>
>>> +}
>>> +
>>> +/// Defines certain other features this PHY supports (like interrupts)=
.
>>
>> Maybe add a link where these flags can be used.
>=20
> I already put the link to here in trait Driver.

I am asking about a link here, as it is a bit confusing when
you just stumble over this flag module here. It doesn't hurt
to link more.

>>> +pub struct Registration {
>>> +    drivers: &'static [DriverType],
>>> +}
>>> +
>>> +impl Registration {
>>> +    /// Registers a PHY driver.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The values of the `drivers` array must be initialized properly=
.
>>
>> With the above change you do not need this (since all instances of
>> `DriverType` are always initialized). But I am not sure if it would be
>=20
> Nice.
>=20
>=20
>> fine to call `phy_driver_register` multiple times with the same driver
>> without unregistering it first.
>=20
> The second call `phy_driver_register` with the same drivers (without
> unregistered) returns an error. You don't need to worry.

I see, then it's fine.

>>> +    /// Get a `mask` as u32.
>>> +    pub const fn mask_as_int(&self) -> u32 {
>>> +        self.mask.as_int()
>>> +    }
>>> +
>>> +    // macro use only
>>> +    #[doc(hidden)]
>>> +    pub const fn as_mdio_device_id(&self) -> bindings::mdio_device_id =
{
>>
>> I would name this just `mdio_device_id`.
>=20
> Either is fine by me. Please tell me why for future reference.

Functions starting with `as_` or `to_` in Rust generally indicate
some kind of conversion. `to_` functions generally take just `self`
by value and `as_` conversions take just `&self`/`&mut self`. See
`Option::as_ref` or `Option::as_mut`. This function is not really
a conversion, rather it is a getter.

--=20
Cheers,
Benno



