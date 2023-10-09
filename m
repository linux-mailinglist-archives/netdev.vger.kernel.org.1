Return-Path: <netdev+bounces-39068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE87BDB73
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814982816B1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEC19445;
	Mon,  9 Oct 2023 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W5Ujpxxj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC718C20;
	Mon,  9 Oct 2023 12:20:11 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35ED1985;
	Mon,  9 Oct 2023 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wlwc3qh2lfhy3o5h4fyrbsv7ny.protonmail; t=1696854002; x=1697113202;
	bh=yjfGcAHi1QQ6I/ZAwmL7ny5XdCgHyFFdQ/iRSH+WP3c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W5Ujpxxj7zzv9eDfEXtu5npmQUpc3rCam+QXmZlcmXOeE3IgSuYcaGM6sFouGHzlu
	 E3fgdE+pmPyQOf9YT06YieodqjyRznkxezzw7wjkuMEK2KPIJCJlgAkOukCxAicFSh
	 Wji/MCfq70xIRChWKt3hWPkF/jTNHRcy013rdHQh/RUIEf50P+TyGQXa/GbSk4Wgtd
	 I83jPox4qjox3PP+SfcfA/L7Q4G23Shwfb7VEEGKuGpPObZItDrSFyprmgmla/F5b7
	 zbKiGFnN+mb7dC40cqq+wj6A3cDZU0yTPgrb0r0T8J30NItpC6wgHmOLtNx8mzE4lb
	 Q5+Bv3/P//y2Q==
Date: Mon, 09 Oct 2023 12:19:54 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
In-Reply-To: <20231009013912.4048593-2-fujita.tomonori@gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-2-fujita.tomonori@gmail.com>
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

On 09.10.23 03:39, FUJITA Tomonori wrote:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
>=20
> This feature is enabled with CONFIG_RUST_PHYLIB_BINDINGS.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>   init/Kconfig                    |   8 +
>   rust/Makefile                   |   1 +
>   rust/bindings/bindings_helper.h |   3 +
>   rust/kernel/lib.rs              |   3 +
>   rust/kernel/net.rs              |   6 +
>   rust/kernel/net/phy.rs          | 733 ++++++++++++++++++++++++++++++++
>   6 files changed, 754 insertions(+)
>   create mode 100644 rust/kernel/net.rs
>   create mode 100644 rust/kernel/net/phy.rs
>=20
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..7ea415c9b144 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1903,6 +1903,14 @@ config RUST
>=20
>   =09  If unsure, say N.
>=20
> +config RUST_PHYLIB_BINDINGS
> +        bool "PHYLIB bindings support"
> +        depends on RUST
> +        depends on PHYLIB=3Dy
> +        help
> +          Adds support needed for PHY drivers written in Rust. It provid=
es
> +          a wrapper around the C phlib core.
> +
>   config RUSTC_VERSION_TEXT
>   =09string
>   =09depends on RUST
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..f67e55945b36 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -331,6 +331,7 @@ quiet_cmd_bindgen =3D BINDGEN $@
>         cmd_bindgen =3D \
>   =09$(BINDGEN) $< $(bindgen_target_flags) \
>   =09=09--use-core --with-derive-default --ctypes-prefix core::ffi --no-l=
ayout-tests \
> +=09=09--rustified-enum phy_state\
>   =09=09--no-debug '.*' \
>   =09=09-o $@ -- $(bindgen_c_flags_final) -DMODULE \
>   =09=09$(bindgen_target_cflags) $(bindgen_target_extra)
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
> index 000000000000..cc1de17cd5fa
> --- /dev/null
> +++ b/rust/kernel/net.rs
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Networking.
> +
> +#[cfg(CONFIG_RUST_PHYLIB_BINDINGS)]
> +pub mod phy;
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> new file mode 100644
> index 000000000000..f31983bf0460
> --- /dev/null
> +++ b/rust/kernel/net/phy.rs
> @@ -0,0 +1,733 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Network PHY device.
> +//!
> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
> +
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
> +    /// Full-duplex mode
> +    Half,
> +    /// Half-duplex mode
> +    Full,
> +    /// Unknown
> +    Unknown,
> +}
> +
> +/// An instance of a PHY device.
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
> +    /// For the duration of the lifetime 'a, the pointer must be valid f=
or writing and nobody else
> +    /// may read or write to the `phy_device` object.
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mu=
t Self {
> +        unsafe { &mut *ptr.cast() }

Missing `SAFETY` comment.

> +    }
> +
> +    /// Gets the id of the PHY.
> +    pub fn phy_id(&mut self) -> u32 {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }
> +
> +    /// Gets the state of the PHY.
> +    pub fn state(&mut self) -> DeviceState {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let state =3D unsafe { (*phydev).state };
> +        // FIXME: enum-cast
> +        match state {
> +            bindings::phy_state::PHY_DOWN =3D> DeviceState::Down,
> +            bindings::phy_state::PHY_READY =3D> DeviceState::Ready,
> +            bindings::phy_state::PHY_HALTED =3D> DeviceState::Halted,
> +            bindings::phy_state::PHY_ERROR =3D> DeviceState::Error,
> +            bindings::phy_state::PHY_UP =3D> DeviceState::Up,
> +            bindings::phy_state::PHY_RUNNING =3D> DeviceState::Running,
> +            bindings::phy_state::PHY_NOLINK =3D> DeviceState::NoLink,
> +            bindings::phy_state::PHY_CABLETEST =3D> DeviceState::CableTe=
st,
> +        }
> +    }
> +
> +    /// Returns true if the link is up.
> +    pub fn get_link(&mut self) -> bool {

I would call this function `is_link_up`.

> +        const LINK_IS_UP: u32 =3D 1;
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).link() =3D=3D LINK_IS_UP }

Can you move the call to `link` and the `=3D=3D` operation out
of the `unsafe` block? They are safe operations. (also do
that below where possible)

> +    }
> +
> +    /// Returns true if auto-negotiation is enabled.
> +    pub fn is_autoneg_enabled(&mut self) -> bool {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).autoneg() =3D=3D bindings::AUTONEG_ENABLE }
> +    }
> +
> +    /// Returns true if auto-negotiation is completed.
> +    pub fn is_autoneg_completed(&mut self) -> bool {
> +        const AUTONEG_COMPLETED: u32 =3D 1;
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).autoneg_complete() =3D=3D AUTONEG_COMPLETED }
> +    }
> +
> +    /// Sets the speed of the PHY.
> +    pub fn set_speed(&mut self, speed: u32) {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).speed =3D speed as i32 };
> +    }
> +
> +    /// Sets duplex mode.
> +    pub fn set_duplex(&mut self, mode: DuplexMode) {
> +        let phydev =3D self.0.get();
> +        let v =3D match mode {
> +            DuplexMode::Full =3D> bindings::DUPLEX_FULL as i32,
> +            DuplexMode::Half =3D> bindings::DUPLEX_HALF as i32,
> +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN as i32,
> +        };
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        unsafe { (*phydev).duplex =3D v };
> +    }
> +
> +    /// Reads a given C22 PHY register.
> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret =3D unsafe {
> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.ad=
dr, regnum.into())
> +        };

Just a general question, all of these unsafe calls do not have
additional requirements? So aside from the pointers being
valid, there are no timing/locking/other safety requirements
for calling the functions?

> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Writes a given C22 PHY register.
> +    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe {
> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.a=
ddr, regnum.into(), val)
> +        })
> +    }
> +
> +    /// Reads a paged register.
> +    pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> =
{
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret =3D unsafe { bindings::phy_read_paged(phydev, page.into(=
), regnum.into()) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Resolves the advertisements into PHY settings.
> +    pub fn resolve_aneg_linkmode(&mut self) {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        unsafe { bindings::phy_resolve_aneg_linkmode(phydev) };
> +    }
> +
> +    /// Executes software reset the PHY via BMCR_RESET bit.
> +    pub fn genphy_soft_reset(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
> +    }
> +
> +    /// Initializes the PHY.
> +    pub fn init_hw(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // so an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::phy_init_hw(phydev) })
> +    }
> +
> +    /// Starts auto-negotiation.
> +    pub fn start_aneg(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::phy_start_aneg(phydev) })
> +    }
> +
> +    /// Resumes the PHY via BMCR_PDOWN bit.
> +    pub fn genphy_resume(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_resume(phydev) })
> +    }
> +
> +    /// Suspends the PHY via BMCR_PDOWN bit.
> +    pub fn genphy_suspend(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_suspend(phydev) })
> +    }
> +
> +    /// Checks the link status and updates current link state.
> +    pub fn genphy_read_status(&mut self) -> Result<u16> {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret =3D unsafe { bindings::genphy_read_status(phydev) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Updates the link status.
> +    pub fn genphy_update_link(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_update_link(phydev) })
> +    }
> +
> +    /// Reads Link partner ability.
> +    pub fn genphy_read_lpa(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_read_lpa(phydev) })
> +    }
> +
> +    /// Reads PHY abilities.
> +    pub fn genphy_read_abilities(&mut self) -> Result {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe { bindings::genphy_read_abilities(phydev) })
> +    }
> +}
> +
> +/// Defines certain other features this PHY supports (like interrupts).
> +pub mod flags {
> +    /// PHY is internal.
> +    pub const IS_INTERNAL: u32 =3D bindings::PHY_IS_INTERNAL;
> +    /// PHY needs to be reset after the refclk is enabled.
> +    pub const RST_AFTER_CLK_EN: u32 =3D bindings::PHY_RST_AFTER_CLK_EN;
> +    /// Polling is used to detect PHY status changes.
> +    pub const POLL_CABLE_TEST: u32 =3D bindings::PHY_POLL_CABLE_TEST;
> +    /// Don't suspend.
> +    pub const ALWAYS_CALL_SUSPEND: u32 =3D bindings::PHY_ALWAYS_CALL_SUS=
PEND;
> +}
> +
> +/// An adapter for the registration of a PHY driver.
> +struct Adapter<T: Driver> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: Driver> Adapter<T> {
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn soft_reset_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::soft_reset(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn get_features_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::get_features(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_dev=
ice) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::suspend(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_devi=
ce) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::resume(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn config_aneg_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::config_aneg(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn read_status_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::read_status(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn match_phy_device_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: Preconditions ensure `phydev` is valid.
> +        let dev =3D unsafe { Device::from_raw(phydev) };
> +        T::match_phy_device(dev) as i32
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn read_mmd_callback(
> +        phydev: *mut bindings::phy_device,
> +        devnum: i32,
> +        regnum: u16,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            // CAST: the C side verifies devnum < 32.
> +            let ret =3D T::read_mmd(dev, devnum as u8, regnum)?;
> +            Ok(ret.into())
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn write_mmd_callback(
> +        phydev: *mut bindings::phy_device,
> +        devnum: i32,
> +        regnum: u16,
> +        val: u16,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: Preconditions ensure `phydev` is valid.
> +            let dev =3D unsafe { Device::from_raw(phydev) };
> +            T::write_mmd(dev, devnum as u8, regnum, val)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    unsafe extern "C" fn link_change_notify_callback(phydev: *mut bindin=
gs::phy_device) {
> +        // SAFETY: Preconditions ensure `phydev` is valid.
> +        let dev =3D unsafe { Device::from_raw(phydev) };
> +        T::link_change_notify(dev);
> +    }
> +}
> +
> +/// Creates the kernel's `phy_driver` instance.
> +///
> +/// This is used by [`module_phy_driver`] macro to create a static array=
 of phy_driver`.

Missing '`'.

> +pub const fn create_phy_driver<T: Driver>() -> Opaque<bindings::phy_driv=
er> {
> +    Opaque::new(bindings::phy_driver {
> +        name: T::NAME.as_char_ptr().cast_mut(),
> +        flags: T::FLAGS,
> +        phy_id: T::PHY_DEVICE_ID.id,
> +        phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
> +        soft_reset: if T::HAS_SOFT_RESET {
> +            Some(Adapter::<T>::soft_reset_callback)
> +        } else {
> +            None
> +        },
> +        get_features: if T::HAS_GET_FEATURES {
> +            Some(Adapter::<T>::get_features_callback)
> +        } else {
> +            None
> +        },
> +        match_phy_device: if T::HAS_MATCH_PHY_DEVICE {
> +            Some(Adapter::<T>::match_phy_device_callback)
> +        } else {
> +            None
> +        },
> +        suspend: if T::HAS_SUSPEND {
> +            Some(Adapter::<T>::suspend_callback)
> +        } else {
> +            None
> +        },
> +        resume: if T::HAS_RESUME {
> +            Some(Adapter::<T>::resume_callback)
> +        } else {
> +            None
> +        },
> +        config_aneg: if T::HAS_CONFIG_ANEG {
> +            Some(Adapter::<T>::config_aneg_callback)
> +        } else {
> +            None
> +        },
> +        read_status: if T::HAS_READ_STATUS {
> +            Some(Adapter::<T>::read_status_callback)
> +        } else {
> +            None
> +        },
> +        read_mmd: if T::HAS_READ_MMD {
> +            Some(Adapter::<T>::read_mmd_callback)
> +        } else {
> +            None
> +        },
> +        write_mmd: if T::HAS_WRITE_MMD {
> +            Some(Adapter::<T>::write_mmd_callback)
> +        } else {
> +            None
> +        },
> +        link_change_notify: if T::HAS_LINK_CHANGE_NOTIFY {
> +            Some(Adapter::<T>::link_change_notify_callback)
> +        } else {
> +            None
> +        },
> +        // SAFETY: The rest is zeroed out to initialize `struct phy_driv=
er`,
> +        // sets `Option<&F>` to be `None`.
> +        ..unsafe { core::mem::MaybeUninit::<bindings::phy_driver>::zeroe=
d().assume_init() }
> +    })
> +}
> +
> +/// Corresponds to functions in `struct phy_driver`.
> +///
> +/// This is used to register a PHY driver.
> +#[vtable]
> +pub trait Driver {
> +    /// Defines certain other features this PHY supports.
> +    const FLAGS: u32 =3D 0;
> +    /// The friendly name of this PHY type.
> +    const NAME: &'static CStr;
> +    /// This driver only works for PHYs with IDs which match this field.
> +    const PHY_DEVICE_ID: DeviceId =3D DeviceId::new_with_custom_mask(0, =
0);
> +
> +    /// Issues a PHY software reset.
> +    fn soft_reset(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Probes the hardware to determine what abilities it has.
> +    fn get_features(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Returns true if this is a suitable driver for the given phydev.
> +    /// If not implemented, matching is based on [`PHY_DEVICE_ID`].
> +    fn match_phy_device(_dev: &mut Device) -> bool {
> +        false
> +    }
> +
> +    /// Configures the advertisement and resets auto-negotiation
> +    /// if auto-negotiation is enabled.
> +    fn config_aneg(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Determines the negotiated speed and duplex.
> +    fn read_status(_dev: &mut Device) -> Result<u16> {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Suspends the hardware, saving state if needed.
> +    fn suspend(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Resumes the hardware, restoring state if needed.
> +    fn resume(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Overrides the default MMD read function for reading a MMD regist=
er.
> +    fn read_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16) -> Result<=
u16> {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Overrides the default MMD write function for writing a MMD regis=
ter.
> +    fn write_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16, _val: u16=
) -> Result {
> +        Err(code::ENOTSUPP)
> +    }
> +
> +    /// Callback for notification of link change.
> +    fn link_change_notify(_dev: &mut Device) {}
> +}
> +
> +/// Registration structure for a PHY driver.
> +///
> +/// # Invariants
> +///
> +/// The `drivers` points to an array of `struct phy_driver`, which is
> +/// registered to the kernel via `phy_drivers_register`.

Since it is a reference you do not need to explicitly state
that it points to an array of `struct phy_driver`. Instead I would
suggest the following invariant:

All elements of the `drivers` slice are valid and currently registered
to the kernel via `phy_drivers_register`.

> +pub struct Registration {
> +    drivers: Option<&'static [Opaque<bindings::phy_driver>]>,

Why is this an `Option`?

> +}
> +
> +impl Registration {
> +    /// Registers a PHY driver.
> +    #[must_use]
> +    pub fn register(
> +        module: &'static crate::ThisModule,
> +        drivers: &'static [Opaque<bindings::phy_driver>],
> +    ) -> Result<Self> {
> +        if drivers.len() =3D=3D 0 {
> +            return Err(code::EINVAL);
> +        }
> +        // SAFETY: `drivers` has static lifetime and used only in the C =
side.
> +        to_result(unsafe {
> +            bindings::phy_drivers_register(drivers[0].get(), drivers.len=
() as i32, module.0)
> +        })?;

This `register` function seems to assume that the values of the
`drivers` array are initialized and otherwise also considered valid.
So please change that or make this function `unsafe`.

> +        Ok(Registration {

Please add an `INVARIANT` comment similar to a `SAFETY` comment
that explains why the invariant is upheld.

> +            drivers: Some(drivers),
> +        })
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        if let Some(drv) =3D self.drivers.take() {
> +            // SAFETY: The type invariants guarantee that self.drivers i=
s valid.
> +            unsafe { bindings::phy_drivers_unregister(drv[0].get(), drv.=
len() as i32) };
> +        }
> +    }
> +}
> +
> +// SAFETY: `Registration` does not expose any of its state across thread=
s.
> +unsafe impl Send for Registration {}

Question: is it ok for two different threads to call `phy_drivers_register`
and `phy_drivers_unregister`? If no, then `Send` must not be implemented.

> +
> +// SAFETY: `Registration` does not expose any of its state across thread=
s.
> +unsafe impl Sync for Registration {}
> +
> +/// Represents the kernel's `struct mdio_device_id`.
> +pub struct DeviceId {
> +    /// Corresponds to `phy_id` in `struct mdio_device_id`.
> +    pub id: u32,
> +    mask: DeviceMask,
> +}
> +
> +impl DeviceId {
> +    /// Creates a new instance with the exact match mask.
> +    pub const fn new_with_exact_mask(id: u32) -> Self {
> +        DeviceId {
> +            id,
> +            mask: DeviceMask::Exact,
> +        }
> +    }
> +
> +    /// Creates a new instance with the model match mask.
> +    pub const fn new_with_model_mask(id: u32) -> Self {
> +        DeviceId {
> +            id,
> +            mask: DeviceMask::Model,
> +        }
> +    }
> +
> +    /// Creates a new instance with the vendor match mask.
> +    pub const fn new_with_vendor_mask(id: u32) -> Self {
> +        DeviceId {
> +            id,
> +            mask: DeviceMask::Vendor,
> +        }
> +    }
> +
> +    /// Creates a new instance with a custom match mask.
> +    pub const fn new_with_custom_mask(id: u32, mask: u32) -> Self {
> +        DeviceId {
> +            id,
> +            mask: DeviceMask::Custom(mask),
> +        }
> +    }
> +
> +    /// Creates a new instance from [`Driver`].
> +    pub const fn new_with_driver<T: Driver>() -> Self {
> +        T::PHY_DEVICE_ID
> +    }
> +
> +    /// Get a mask as u32.
> +    pub const fn mask_as_int(self) -> u32 {
> +        self.mask.as_int()
> +    }
> +}
> +
> +enum DeviceMask {
> +    Exact,
> +    Model,
> +    Vendor,
> +    Custom(u32),
> +}
> +
> +impl DeviceMask {
> +    const MASK_EXACT: u32 =3D !0;
> +    const MASK_MODEL: u32 =3D !0 << 4;
> +    const MASK_VENDOR: u32 =3D !0 << 10;
> +
> +    const fn as_int(self) -> u32 {
> +        match self {
> +            DeviceMask::Exact =3D> Self::MASK_EXACT,
> +            DeviceMask::Model =3D> Self::MASK_MODEL,
> +            DeviceMask::Vendor =3D> Self::MASK_VENDOR,
> +            DeviceMask::Custom(mask) =3D> mask,
> +        }
> +    }
> +}
> +
> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of `struct phy_driver` and registers it.
> +/// This also corresponds to the kernel's MODULE_DEVICE_TABLE macro, whi=
ch embeds the information
> +/// for module loading into the module binary file. Every driver needs a=
n entry in device_table.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +///
> +/// use kernel::net::phy::{self, DeviceId, Driver};
> +/// use kernel::prelude::*;
> +///
> +/// kernel::module_phy_driver! {
> +///     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
> +///     device_table: [
> +///         DeviceId::new_with_driver::<PhyAX88772A>(),
> +///         DeviceId::new_with_driver::<PhyAX88772C>(),
> +///         DeviceId::new_with_driver::<PhyAX88796B>()
> +///     ],
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_phy_driver {
> +    (@replace_expr $_t:tt $sub:expr) =3D> {$sub};
> +
> +    (@count_devices $($x:expr),*) =3D> {
> +        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
> +    };
> +
> +    (@device_table [$($dev:expr),+]) =3D> {
> +        #[no_mangle]
> +        static __mod_mdio__phydev_device_table: [

Shouldn't this have a unique name? If we define two different
phy drivers with this macro we would have a symbol collision?

> +            kernel::bindings::mdio_device_id;

Please use absolute paths in macros:
`::kernel::bindings::mdio_device_id` (also below).

> +            $crate::module_phy_driver!(@count_devices $($dev),+) + 1
> +        ] =3D [
> +            $(kernel::bindings::mdio_device_id {
> +                phy_id: $dev.id,
> +                phy_id_mask: $dev.mask_as_int()
> +            }),+,
> +            kernel::bindings::mdio_device_id {
> +                phy_id: 0,
> +                phy_id_mask: 0
> +            }
> +        ];
> +    };
> +
> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f=
:tt)*) =3D> {
> +        struct Module {
> +            _reg: kernel::net::phy::Registration,
> +        }
> +
> +        $crate::prelude::module! {
> +             type: Module,
> +             $($f)*
> +        }
> +
> +        static mut DRIVERS: [
> +            kernel::types::Opaque<kernel::bindings::phy_driver>;
> +            $crate::module_phy_driver!(@count_devices $($driver),+)
> +        ] =3D [
> +            $(kernel::net::phy::create_phy_driver::<$driver>()),+
> +        ];
> +
> +        impl kernel::Module for Module {
> +            fn init(module: &'static ThisModule) -> Result<Self> {
> +                // SAFETY: static `DRIVERS` array is used only in the C =
side.

In order for this SAFETY comment to be correct, you need to ensure
that nobody else can access the `DRIVERS` static. You can do that by
placing both the `static mut DRIVERS` and the `impl ::kernel::Module
for Module` items inside of a `const _: () =3D {}`, so like this:

     const _: () =3D {
         static mut DRIVERS: [...] =3D ...;
         impl ::kernel::Module for Module { ... }
     };

You can also mention this in the SAFETY comment.

> +                let mut reg =3D unsafe { kernel::net::phy::Registration:=
:register(module, &DRIVERS) }?;
> +
> +                Ok(Module {
> +                    _reg: reg,
> +                })
> +            }
> +        }
> +
> +        $crate::module_phy_driver!(@device_table [$($dev),+]);
> +    }
> +}
> --
> 2.34.1
>=20
>=20


