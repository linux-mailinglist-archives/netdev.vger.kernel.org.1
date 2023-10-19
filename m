Return-Path: <netdev+bounces-42651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828D7CFB82
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D21C20D1C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1127477;
	Thu, 19 Oct 2023 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a/kX2NAt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B033DDA6;
	Thu, 19 Oct 2023 13:45:40 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC669B;
	Thu, 19 Oct 2023 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697723134; x=1697982334;
	bh=EiI9bLDH0OdYLGe7aBG2i8406QJY+5bMoCJHU+OywOs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a/kX2NAtx7a9jm2ubPX0kPZ3x4PPH15mrQglzJ3V4yDK4WYF37FWIMu9nieobODpC
	 Tyswr1Afw9JZc7yWH2RceYypZxQW6NFYGK1HeTpTWPsSS6UQZunVdtnTE59XDPHu6q
	 eT7xHhU2J7hcniW7vM3vLTqTtfxroLVUYixUvde/jUGUyfJeXwoxMa9kMSreps6+Lh
	 i8sevU+Yi20wQnbkJ9MVF9Nd5760ollY5ECQ0fNB3GwSDVNi6chYSpV5tVVDSb1RKt
	 BwYlymErFD5FWQ1kdMGu22ZnjQOdTZCGXePNTDfz6NO8dUtXFlBtA2ukxzWoM2oe02
	 xAX4cBLmc84zg==
Date: Thu, 19 Oct 2023 13:45:27 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <0e8d2538-284b-4811-a2e7-99151338c255@proton.me>
In-Reply-To: <20231019.092436.1433321157817125498.fujita.tomonori@gmail.com>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com> <20231017113014.3492773-2-fujita.tomonori@gmail.com> <e361ef91-607d-400b-a721-f846c21e2400@proton.me> <20231019.092436.1433321157817125498.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.23 02:24, FUJITA Tomonori wrote:
> On Wed, 18 Oct 2023 15:07:52 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>> new file mode 100644
>>> index 000000000000..7d4927ece32f
>>> --- /dev/null
>>> +++ b/rust/kernel/net/phy.rs
>>> @@ -0,0 +1,701 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> +
>>> +//! Network PHY device.
>>> +//!
>>> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h=
).
>>> +//!
>>
>> Add a new section "# Abstraction Overview" or similar.
>=20
> With the rest of comments on this secsion addressed, how about the follow=
ing?
>=20
> //! Network PHY device.
> //!
> //! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
> //!
> //! # Abstraction Overview
> //!
> //! "During the calls to most functions in [`Driver`], the C side (`PHYLI=
B`) holds a lock that is unique

Please remove the quotes ", they were intended to separate my comments
from my suggestion.

> //! for every instance of [`Device`]". `PHYLIB` uses a different serializ=
ation technique for
> //! [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_dev=
ice`'s state with the lock hold,

hold -> held

> //! to guarantee that [`Driver::resume`] accesses to the instance exclusi=
vely. [`Driver::resume`] and

to guarantee -> thus guaranteeing
accesses to the instance exclusively. -> has exclusive access to the instan=
ce.

> //! [`Driver::suspend`] also are called where only one thread can access =
to the instance.
> //!
> //! All the PHYLIB helper functions for [`Device`] modify some members in=
 [`Device`]. Except for

PHYLIB -> `PHYLIB`

> //! getter functions, [`Device`] methods take `&mut self`. This also appl=
ied to `[Device::read]`,

`[Device::read]` -> [`Device::read`]

> //! which reads a hardware register and updates the stats.

Otherwise this looks good.

[...]

>>> +impl Device {
>>> +    /// Creates a new [`Device`] instance from a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function must only be called from the callbacks in `phy_d=
river`. PHYLIB guarantees
>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>
>> I would not put the second sentence in the `# Safety` section. Just move=
 it
>> above. The reason behind this is the following: the second sentence is n=
ot
>> a precondition needed to call the function.
>=20
> Where is the `above`? You meant the following?
>=20
> impl Device {
>      /// Creates a new [`Device`] instance from a raw pointer.
>      ///
>      /// `PHYLIB` guarantees the exclusive access for the duration of the=
 lifetime `'a`.
>      ///
>      /// # Safety
>      ///
>      /// This function must only be called from the callbacks in `phy_dri=
ver`.
>      unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a  mut S=
elf {

Yes this is what I had in mind. Although now that I see it in code,
I am not so sure that this comment is needed. If you feel the same
way, just remove it.

That being said, I am not too happy with the safety requirement of this
function. It does not really match with the safety comment in the function
body. Since I have not yet finished my safety standardization, I think we
can defer that problem until it is finished. Unless some other reviewer
wants to change this, you can keep it as is.

>>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut =
Self {
>>> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindi=
ngs::phy_device`.
>>> +        let ptr =3D ptr.cast::<Self>();
>>> +        // SAFETY: by the function requirements the pointer is valid a=
nd we have unique access for
>>> +        // the duration of `'a`.
>>> +        unsafe { &mut *ptr }
>>> +    }
>>> +
>>> +    /// Gets the id of the PHY.
>>> +    pub fn phy_id(&self) -> u32 {
>>> +        let phydev =3D self.0.get();
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        unsafe { (*phydev).phy_id }
>>> +    }
>>> +
>>> +    /// Gets the state of the PHY.
>>> +    pub fn state(&self) -> DeviceState {
>>> +        let phydev =3D self.0.get();
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        let state =3D unsafe { (*phydev).state };
>>> +        // TODO: this conversion code will be replaced with automatica=
lly generated code by bindgen
>>> +        // when it becomes possible.
>>> +        // better to call WARN_ONCE() when the state is out-of-range (=
needs to add WARN_ONCE support).
>>> +        match state {
>>> +            bindings::phy_state_PHY_DOWN =3D> DeviceState::Down,
>>> +            bindings::phy_state_PHY_READY =3D> DeviceState::Ready,
>>> +            bindings::phy_state_PHY_HALTED =3D> DeviceState::Halted,
>>> +            bindings::phy_state_PHY_ERROR =3D> DeviceState::Error,
>>> +            bindings::phy_state_PHY_UP =3D> DeviceState::Up,
>>> +            bindings::phy_state_PHY_RUNNING =3D> DeviceState::Running,
>>> +            bindings::phy_state_PHY_NOLINK =3D> DeviceState::NoLink,
>>> +            bindings::phy_state_PHY_CABLETEST =3D> DeviceState::CableT=
est,
>>> +            _ =3D> DeviceState::Error,
>>> +        }
>>> +    }
>>> +
>>> +    /// Returns true if the link is up.
>>> +    pub fn get_link(&self) -> bool {
>>
>> I still think this name should be changed. My response at [1] has not ye=
t
>> been replied to. This has already been discussed before:
>> - https://lore.kernel.org/rust-for-linux/2023100237-satirical-prance-bd5=
7@gregkh/
>> - https://lore.kernel.org/rust-for-linux/20231004.084644.507845339593987=
55.fujita.tomonori@gmail.com/
>> - https://lore.kernel.org/rust-for-linux/CALNs47syMxiZBUwKLk3vKxzmCbX0FS=
5A37FjwUzZO9Fn-iPaoA@mail.gmail.com/
>>
>> And I want to suggest to change it to `is_link_up`.
>>
>> Reasons why I do not like the name:
>> - `get_`/`put_` are used for ref counting on the C side, I would like to
>>     avoid confusion.
>> - `get` in Rust is often used to fetch a value from e.g. a datastructure
>>     such as a hashmap, so I expect the call to do some computation.
>> - getters in Rust usually are not prefixed with `get_`, but rather are
>>     just the name of the field.
>> - in this case I like the name `is_link_up` much better, since code beco=
mes
>>     a lot more readable with that.
>> - I do not want this pattern as an example for other drivers.
>>
>> [1]: https://lore.kernel.org/rust-for-linux/f5878806-5ba2-d932-858d-dda3=
f55ceb67@proton.me/
>=20
> IIRC, Andrew suggested the current name. If the change is fine by him,
> I'll rename.
>=20
>=20
>>> +/// An instance of a PHY driver.
>>> +///
>>> +/// Wraps the kernel's `struct phy_driver`.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// `self.0` is always in a valid state.
>>> +#[repr(transparent)]
>>> +pub struct DriverType(Opaque<bindings::phy_driver>);
>>
>> I think `DriverVTable` is a better name.
>=20
> Renamed.
>=20
>>> +/// Creates the kernel's `phy_driver` instance.
>>
>> This function returns a `DriverType`, not a `phy_driver`.
>=20
> How about?
>=20
> /// Creates the [`DriverVTable`] instance from [`Driver`] trait.

Sounds good, but to this sounds a bit more natural:

     /// Creates a [`DriverVTable`] instance from a [`Driver`].

>>> +///
>>> +/// This is used by [`module_phy_driver`] macro to create a static arr=
ay of `phy_driver`.
>>> +///
>>> +/// [`module_phy_driver`]: crate::module_phy_driver
>>> +pub const fn create_phy_driver<T: Driver>() -> DriverType {
>>> +    // All the fields of `struct phy_driver` are initialized properly.
>>> +    // It ensures the invariants.
>>
>> Use `// INVARIANT: `.
>=20
> Oops,
>=20
> // INVARIANT: All the fields of `struct phy_driver` are initialized prope=
rly.
> DriverVTable(Opaque::new(bindings::phy_driver {
>      name: T::NAME.as_char_ptr().cast_mut(),

Seems good.

>=20
>=20
>>> +/// Registration structure for a PHY driver.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The `drivers` slice are currently registered to the kernel via `ph=
y_drivers_register`.
>>> +pub struct Registration {
>>> +    drivers: &'static [DriverType],
>>> +}
>>
>> You did not reply to my suggestion [2] to remove this type,
>> what do you think?
>>
>> [2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1ec=
a63c45cf@proton.me/
>=20
> I tried before but I'm not sure it simplifies the implementation.
>=20
> Firstly, instead of Reservation, we need a public function like
>=20
> pub fn phy_drivers_register(module: &'static crate::ThisModule, drivers: =
&[DriverVTable]) -> Result {
>      to_result(unsafe {
>          bindings::phy_drivers_register(drivers[0].0.get(), drivers.len()=
.try_into()?, module.0)
>      })
> }
>=20
> This is because module.0 is private.

Why can't this be part of the macro?

> Also if we keep DriverVtable.0 private, we need another public function.
>=20
> pub unsafe fn phy_drivers_unregister(drivers: &'static [DriverVTable])
> {
>      unsafe {
>          bindings::phy_drivers_unregister(drivers[0].0.get(), drivers.len=
() as i32)
>      };
> }
>=20
> DriverVTable isn't guaranteed to be registered to the kernel so needs
> to be unsafe, I guesss.

In one of the options I suggest to make that an invariant of `DriverVTable`=
.

>=20
> Also Module trait support exit()?

Yes, just implement `Drop` and do the cleanup there.

In the two options that I suggested there is a trade off. I do not know
which option is better, I hoped that you or Andrew would know more:
Option 1:
* advantages:
   - manual creation of a phy driver module becomes possible.
   - less complex `module_phy_driver` macro.
   - no static variable needed.
* disadvantages:
   - calls `phy_drivers_register` for every driver on module
     initialization.
   - calls `phy_drivers_unregister` for every driver on module
     exit.

Option 2:
* advantages:
   - less complex `module_phy_driver` macro.
   - no static variable needed.
   - only a single call to
     `phy_drivers_register`/`phy_drivers_unregister`.
* disadvantages:
   - no safe manual creation of phy drivers possible, the only safe
     way is to use the `module_phy_driver` macro.

I suppose that it would be ok to call the register function multiple
times, since it only is on module startup/shutdown and it is not
performance critical.

--=20
Cheers,
Benno



