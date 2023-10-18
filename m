Return-Path: <netdev+bounces-42285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25037CE0C1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F51C20DF8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645937CB8;
	Wed, 18 Oct 2023 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZArW5i6Y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C93C1E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:08:09 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F956116
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697641682; x=1697900882;
	bh=+IKFV6e5sIzuS8thFVUuReFSKW1fjaZxUO9mhGaa0gY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZArW5i6YdG8AJzi6Rzz6d4VR+Mhf5/34g02G3/4xX1el5jO2QAxHOY95bq9u6aqv2
	 w9qfr65vhT7OGJvEqDTpdopM5SWkLC6ulaab8iivGSHhpR+TZmfOuRcJ8G+MuCgqVY
	 RzNh7wpVVNuC+0tP8Vo8W6ELtUV77sTiqATQ0w/OW4clmCE7fHL+lRmhKtbaQ4NB3N
	 DdNtyMjS0YIskaKkZ9sfrbqfkNZi69onoOQF/vEERNRrH1aM3ynfcU9cMCuREKHqxT
	 hL72b/OdIz2VB0+dmv0PKMwAZluYNXCoT3JFCuAR65jbR+jZhSuWVUZEz71qwMp7Vm
	 diln6fC6nzeXQ==
Date: Wed, 18 Oct 2023 15:07:52 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
In-Reply-To: <20231017113014.3492773-2-fujita.tomonori@gmail.com>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com> <20231017113014.3492773-2-fujita.tomonori@gmail.com>
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

On 17.10.23 13:30, FUJITA Tomonori wrote:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
>=20
> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=3Dy.
>=20
> This patch enables unstable const_maybe_uninit_zeroed feature for
> kernel crate to enable unsafe code to handle a constant value with
> uninitialized data. With the feature, the abstractions can initialize
> a phy_driver structure with zero easily; instead of initializing all
> the members by hand. It's supposed to be stable in the not so distant
> future.
>=20
> Link: https://github.com/rust-lang/rust/pull/116218
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>   drivers/net/phy/Kconfig         |   8 +
>   rust/bindings/bindings_helper.h |   3 +
>   rust/kernel/lib.rs              |   3 +
>   rust/kernel/net.rs              |   6 +
>   rust/kernel/net/phy.rs          | 701 ++++++++++++++++++++++++++++++++
>   5 files changed, 721 insertions(+)
>   create mode 100644 rust/kernel/net.rs
>   create mode 100644 rust/kernel/net/phy.rs
>=20
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 421d2b62918f..0faebdb184ca 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -60,6 +60,14 @@ config FIXED_PHY
>=20
>   =09  Currently tested with mpc866ads and mpc8349e-mitx.
>=20
> +config RUST_PHYLIB_ABSTRACTIONS
> +        bool "PHYLIB abstractions support"
> +        depends on RUST
> +        depends on PHYLIB=3Dy
> +        help
> +          Adds support needed for PHY drivers written in Rust. It provid=
es
> +          a wrapper around the C phylib core.
> +
>   config SFP
>   =09tristate "SFP cage support"
>   =09depends on I2C && PHYLINK
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index c91a3c24f607..ec4ee09a34ad 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,9 @@
>=20
>   #include <kunit/test.h>
>   #include <linux/errname.h>
> +#include <linux/ethtool.h>
> +#include <linux/mdio.h>
> +#include <linux/phy.h>
>   #include <linux/slab.h>
>   #include <linux/refcount.h>
>   #include <linux/wait.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e8811700239a..0588422e273c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>   #![no_std]
>   #![feature(allocator_api)]
>   #![feature(coerce_unsized)]
> +#![feature(const_maybe_uninit_zeroed)]
>   #![feature(dispatch_from_dyn)]
>   #![feature(new_uninit)]
>   #![feature(receiver_trait)]
> @@ -36,6 +37,8 @@
>   pub mod ioctl;
>   #[cfg(CONFIG_KUNIT)]
>   pub mod kunit;
> +#[cfg(CONFIG_NET)]
> +pub mod net;
>   pub mod prelude;
>   pub mod print;
>   mod static_assert;
> diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
> new file mode 100644
> index 000000000000..fe415cb369d3
> --- /dev/null
> +++ b/rust/kernel/net.rs
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Networking.
> +
> +#[cfg(CONFIG_RUST_PHYLIB_ABSTRACTIONS)]
> +pub mod phy;
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> new file mode 100644
> index 000000000000..7d4927ece32f
> --- /dev/null
> +++ b/rust/kernel/net/phy.rs
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Network PHY device.
> +//!
> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
> +//!

Add a new section "# Abstraction Overview" or similar.

> +//! The C side (PHYLIB) guarantees that there is only one thread accessi=
ng to one `phy_device` instance
> +//! during a callback in `phy_driver`. The callback safely accesses to t=
he instance exclusively.
> +//! Except for `resume()` and `suspend()`, PHYLIB holds `phy_device`'s l=
ock during a callback.

I would start with "During the calls to most functions in [`Driver`],
the C side (`PHYLIB`) holds a lock that is unique for every instance of
[`Device`]". Then you can note the exception for `resume` and `suspend`
(and also link them e.g. [`Driver::resume`]).

> +//! PHYLIB doesn't hold `phy_device`'s lock in both `resume()` and `susp=
end()`. Instead, PHYLIB
> +//! updates `phy_device`'s state with `phy_device`'s lock hold, to guara=
ntee that resume() accesses
> +//! to the instance exclusively. Note that `resume()` and `suspend()` al=
so are called where only
> +//! one thread can access to the instance.

I would just write "`PHYLIB` uses a different serialization technique for
[`Driver::resume`] and [`Driver::suspend`]: <use the above explanation>".

> +//! This abstractions creates [`Device`] instance only during a callback=
 so it's guaranteed that
> +//! only one reference exists. All its methods can accesses to the insta=
nce exclusively.

Not really sure if this is needed, what are you trying to explain here?

> +//! All the PHYLIB helper functions for `phy_device` modify some members=
 in `phy_device`. Except for
> +//! getter functions, [`Device`] methods take `&mut self`. This also app=
lied to `read()`, which reads
> +//! a hardware register and updates the stats.

I would use [`Device`] instead of `phy_device`, since the Rust reader
might not be aware what wraps `phy_device`.

> +use crate::{bindings, error::*, prelude::vtable, str::CStr, types::Opaqu=
e};
> +use core::marker::PhantomData;
> +
> +/// Corresponds to the kernel's `enum phy_state`.
> +#[derive(PartialEq)]
> +pub enum DeviceState {
> +    /// PHY device and driver are not ready for anything.
> +    Down,
> +    /// PHY is ready to send and receive packets.
> +    Ready,
> +    /// PHY is up, but no polling or interrupts are done.
> +    Halted,
> +    /// PHY is up, but is in an error state.
> +    Error,
> +    /// PHY and attached device are ready to do work.
> +    Up,
> +    /// PHY is currently running.
> +    Running,
> +    /// PHY is up, but not currently plugged in.
> +    NoLink,
> +    /// PHY is performing a cable test.
> +    CableTest,
> +}
> +
> +/// Represents duplex mode.
> +pub enum DuplexMode {
> +    /// PHY is in full-duplex mode.
> +    Full,
> +    /// PHY is in half-duplex mode.
> +    Half,
> +    /// PHY is in unknown duplex mode.
> +    Unknown,
> +}
> +
> +/// An instance of a PHY device.
> +///
> +/// Wraps the kernel's `struct phy_device`.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always in a valid state.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::phy_device>);
> +
> +impl Device {
> +    /// Creates a new [`Device`] instance from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called from the callbacks in `phy_dri=
ver`. PHYLIB guarantees
> +    /// the exclusive access for the duration of the lifetime `'a`.

I would not put the second sentence in the `# Safety` section. Just move it
above. The reason behind this is the following: the second sentence is not
a precondition needed to call the function.

> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Se=
lf {
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::phy_device`.
> +        let ptr =3D ptr.cast::<Self>();
> +        // SAFETY: by the function requirements the pointer is valid and=
 we have unique access for
> +        // the duration of `'a`.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Gets the id of the PHY.
> +    pub fn phy_id(&self) -> u32 {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }
> +
> +    /// Gets the state of the PHY.
> +    pub fn state(&self) -> DeviceState {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let state =3D unsafe { (*phydev).state };
> +        // TODO: this conversion code will be replaced with automaticall=
y generated code by bindgen
> +        // when it becomes possible.
> +        // better to call WARN_ONCE() when the state is out-of-range (ne=
eds to add WARN_ONCE support).
> +        match state {
> +            bindings::phy_state_PHY_DOWN =3D> DeviceState::Down,
> +            bindings::phy_state_PHY_READY =3D> DeviceState::Ready,
> +            bindings::phy_state_PHY_HALTED =3D> DeviceState::Halted,
> +            bindings::phy_state_PHY_ERROR =3D> DeviceState::Error,
> +            bindings::phy_state_PHY_UP =3D> DeviceState::Up,
> +            bindings::phy_state_PHY_RUNNING =3D> DeviceState::Running,
> +            bindings::phy_state_PHY_NOLINK =3D> DeviceState::NoLink,
> +            bindings::phy_state_PHY_CABLETEST =3D> DeviceState::CableTes=
t,
> +            _ =3D> DeviceState::Error,
> +        }
> +    }
> +
> +    /// Returns true if the link is up.
> +    pub fn get_link(&self) -> bool {

I still think this name should be changed. My response at [1] has not yet
been replied to. This has already been discussed before:
- https://lore.kernel.org/rust-for-linux/2023100237-satirical-prance-bd57@g=
regkh/
- https://lore.kernel.org/rust-for-linux/20231004.084644.50784533959398755.=
fujita.tomonori@gmail.com/
- https://lore.kernel.org/rust-for-linux/CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A3=
7FjwUzZO9Fn-iPaoA@mail.gmail.com/

And I want to suggest to change it to `is_link_up`.

Reasons why I do not like the name:
- `get_`/`put_` are used for ref counting on the C side, I would like to
   avoid confusion.
- `get` in Rust is often used to fetch a value from e.g. a datastructure
   such as a hashmap, so I expect the call to do some computation.
- getters in Rust usually are not prefixed with `get_`, but rather are
   just the name of the field.
- in this case I like the name `is_link_up` much better, since code becomes
   a lot more readable with that.
- I do not want this pattern as an example for other drivers.

[1]: https://lore.kernel.org/rust-for-linux/f5878806-5ba2-d932-858d-dda3f55=
ceb67@proton.me/

> +        const LINK_IS_UP: u32 =3D 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let phydev =3D unsafe { *self.0.get() };
> +        phydev.link() =3D=3D LINK_IS_UP
> +    }

[...]

> +/// An instance of a PHY driver.
> +///
> +/// Wraps the kernel's `struct phy_driver`.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always in a valid state.
> +#[repr(transparent)]
> +pub struct DriverType(Opaque<bindings::phy_driver>);

I think `DriverVTable` is a better name.

> +/// Creates the kernel's `phy_driver` instance.

This function returns a `DriverType`, not a `phy_driver`.

> +///
> +/// This is used by [`module_phy_driver`] macro to create a static array=
 of `phy_driver`.
> +///
> +/// [`module_phy_driver`]: crate::module_phy_driver
> +pub const fn create_phy_driver<T: Driver>() -> DriverType {
> +    // All the fields of `struct phy_driver` are initialized properly.
> +    // It ensures the invariants.

Use `// INVARIANT: `.

> +    DriverType(Opaque::new(bindings::phy_driver {

[...]

> +
> +/// Registration structure for a PHY driver.
> +///
> +/// # Invariants
> +///
> +/// The `drivers` slice are currently registered to the kernel via `phy_=
drivers_register`.
> +pub struct Registration {
> +    drivers: &'static [DriverType],
> +}

You did not reply to my suggestion [2] to remove this type,
what do you think?

[2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1eca63=
c45cf@proton.me/

--=20
Cheers,
Benno

> +
> +impl Registration {
> +    /// Registers a PHY driver.
> +    pub fn register(
> +        module: &'static crate::ThisModule,
> +        drivers: &'static [DriverType],
> +    ) -> Result<Self> {
> +        if drivers.is_empty() {
> +            return Err(code::EINVAL);
> +        }
> +        // SAFETY: The type invariants of [`DriverType`] ensure that all=
 elements of the `drivers` slice
> +        // are initialized properly. So an FFI call with a valid pointer=
.
> +        to_result(unsafe {
> +            bindings::phy_drivers_register(drivers[0].0.get(), drivers.l=
en().try_into()?, module.0)
> +        })?;
> +        // INVARIANT: The `drivers` slice is successfully registered to =
the kernel via `phy_drivers_register`.
> +        Ok(Registration { drivers })
> +    }
> +}

[...]



