Return-Path: <netdev+bounces-43935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFD7D5810
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB10281690
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD038BC9;
	Tue, 24 Oct 2023 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FeRf3q57"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98939946
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:23:54 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98210D0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zcv7pcgwfngtfhiy4puqsu6o44.protonmail; t=1698164627; x=1698423827;
	bh=5U/dEfgJXHyTK/sepiAPLQXu8435jTLdFMh5GjWgAT4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FeRf3q57tVN20zHAyMJ/tUHMpHGiEmVEkhAYPnwLwu9uHCtP4j4bpZrmv2PKzwclF
	 iGnWthuiXBPHBZcdN1qlRbIZKxrK9ls3XlAGlj/gFrPpCN0+XdOoSTYQn9HsrrCZCk
	 FCnDjl1ZuLPbnUNUWM2G9X3htJ61mPySTMqX7I5rwyxccWkFZnLMOnyytVjQ/Rnzip
	 mb9zJb+M9Z9/vGfEUbV3BolrBpzrBKb7mtQfA3BIY53+1TgaIqgsqzE+27KdUcs9C3
	 MuPr/bU9PbsPkSn1YpsESwAIN+G+vwIH1EcPtuBXDMDhoEcRh6a54IgttwKNCHpCOm
	 VN1vCmHLZ7Tkw==
Date: Tue, 24 Oct 2023 16:23:20 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network PHY drivers
Message-ID: <1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me>
In-Reply-To: <20231024005842.1059620-2-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-2-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.10.23 02:58, FUJITA Tomonori wrote:
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

[...]

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> new file mode 100644
> index 000000000000..2d821c2475e1
> --- /dev/null
> +++ b/rust/kernel/net/phy.rs
> @@ -0,0 +1,708 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Network PHY device.
> +//!
> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
> +
> +use crate::{
> +    bindings,
> +    error::*,
> +    prelude::{vtable, Pin},
> +    str::CStr,
> +    types::Opaque,
> +};
> +use core::marker::PhantomData;
> +
> +/// PHY state machine states.
> +///
> +/// Corresponds to the kernel's [`enum phy_state`](https://docs.kernel.o=
rg/networking/kapi.html#c.phy_state).

Please use `rustfmt`, this line is 109 characters long.

Also it might make sense to use a relative link, since then it also
works offline (though you have to build the C docs).

> +/// Some of PHY drivers access to the state of PHY's software state mach=
ine.
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
> +/// A mode of Ethernet communication.
> +///
> +/// PHY drivers get duplex information from hardware and update the curr=
ent state.
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
> +/// Wraps the kernel's [`struct phy_device`](https://docs.kernel.org/net=
working/kapi.html#c.phy_device).
> +/// A [`Device`] instance is created when a callback in [`Driver``] is e=
xecuted. A PHY driver executes
> +/// [`Driver`]'s methods during the callback.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always in a valid state.
> +// During the calls to most functions in [`Driver`], the C side (`PHYLIB=
`) holds a lock that is unique
> +// for every instance of [`Device`]. `PHYLIB` uses a different serializa=
tion technique for
> +// [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_dev=
ice`'s state with the lock held,
> +// thus guaranteeing that [`Driver::resume`] has exclusive access to the=
 instance. [`Driver::resume`] and
> +// [`Driver::suspend`] also are called where only one thread can access =
to the instance.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::phy_device>);
> +
> +impl Device {
> +    /// Creates a new [`Device`] instance from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called from the callbacks in `phy_dri=
ver`.
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
> +    /// Gets the current link state. It returns true if the link is up.
> +    pub fn get_link(&self) -> bool {
> +        const LINK_IS_UP: u32 =3D 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let phydev =3D unsafe { *self.0.get() };
> +        phydev.link() =3D=3D LINK_IS_UP
> +    }

Can we please change this name? I think Tomo is waiting for Andrew to
give his OK. All the other getter functions already follow the Rust
naming convention, so this one should as well. I think using
`is_link_up` would be ideal, since `link()` reads a bit weird in code:

     if dev.link() {
         // ...
     }

vs

     if dev.is_link_up() {
         // ...
     }

> +
> +    /// Gets the current auto-negotiation configuration. It returns true=
 if auto-negotiation is enabled.

Move the second sentence into a new line, it should not be part of the
one-line summary.

> +    pub fn is_autoneg_enabled(&self) -> bool {
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let phydev =3D unsafe { *self.0.get() };
> +        phydev.autoneg() =3D=3D bindings::AUTONEG_ENABLE
> +    }
> +
> +    /// Gets the current auto-negotiation state. It returns true if auto=
-negotiation is completed.
Same here.

--
Cheers,
Benno

> +    pub fn is_autoneg_completed(&self) -> bool {
> +        const AUTONEG_COMPLETED: u32 =3D 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let phydev =3D unsafe { *self.0.get() };
> +        phydev.autoneg_complete() =3D=3D AUTONEG_COMPLETED
> +    }
[...]


