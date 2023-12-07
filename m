Return-Path: <netdev+bounces-54920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E6808EA4
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5647028115B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03081495E1;
	Thu,  7 Dec 2023 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TCx2WNTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF2198B;
	Thu,  7 Dec 2023 09:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701969929; x=1702229129;
	bh=mC8MZw+VCgprIFcpxEjWguJFl3Rg2xJoj+JLq1EE5QU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TCx2WNTG6tDi8ECB2difXmDAxrKHkCUWiWzOnNuNYyfz4MxIY/keq5UNomZG+jCw6
	 dpbJLI718urziYr5S03USXNlozN1VC4JWWLNRhBjerJbRb5kgqpDnN1+eP8mvmgbps
	 TBhSsz2X1CVKyBRtnQI9/uPtLyhrHORJXbIS5Fkja3cO/2FxCbx+RXxcq00QI3LOdp
	 QfUCwiTqZ0PVzIi57sFW3FUb7PISI2vviDNrzuH+xUvmOcRn0gVcfzaxt0ewg+6a8a
	 n1mQpItBaN45Ebn3XkdokkLlz9/QIiqfiAMe/gnFr0BokZgL8peeT/o5cxdt83Fq1X
	 D5/WC65cTBP8Q==
Date: Thu, 07 Dec 2023 17:25:22 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network PHY drivers
Message-ID: <9d38d6f9-3b54-4a6f-a19d-3710db171fed@proton.me>
In-Reply-To: <20231205011420.1246000-2-fujita.tomonori@gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com> <20231205011420.1246000-2-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/5/23 02:14, FUJITA Tomonori wrote:
> @@ -0,0 +1,754 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Network PHY device.
> +//!
> +//! C headers: [`include/linux/phy.h`](../../../../../../../include/linu=
x/phy.h).
> +
> +use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
> +
> +use core::marker::PhantomData;
> +
> +/// PHY state machine states.
> +///
> +/// Corresponds to the kernel's [`enum phy_state`].
> +///
> +/// Some of PHY drivers access to the state of PHY's software state mach=
ine.

This sentence reads a bit weird, what are you trying to say?

> +///
> +/// [`enum phy_state`]: ../../../../../../../include/linux/phy.h
> +#[derive(PartialEq, Eq)]
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

I took a look at `enum phy_state` and found that you only copied the
first sentence of each state description, why is that?

> +}
> +
> +/// A mode of Ethernet communication.
> +///
> +/// PHY drivers get duplex information from hardware and update the curr=
ent state.

Are you trying to say that the driver automatically queries the
hardware? You could express this more clearly.

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
> +/// Wraps the kernel's [`struct phy_device`].
> +///
> +/// A [`Device`] instance is created when a callback in [`Driver`] is ex=
ecuted. A PHY driver
> +/// executes [`Driver`]'s methods during the callback.
> +///
> +/// # Invariants
> +///
> +/// Referencing a `phy_device` using this struct asserts that you are in
> +/// a context where all methods defined on this struct are safe to call.

I know that Alice suggested this, but I reading it now, it sounds a
bit weird. When reading this it sounds like a requirement for everyone
using a `Device`. It would be better to phrase it so that it sounds like
something that users of `Device` can rely upon.

Also, I would prefer for this invariant to be a simple one, for example:
"The mutex of `self.0` is held".
The only problem with that are the `resume` and `suspend` methods.
Andrew mentioned that there is some tribal knowledge on this topic, but
I don't see this written down anywhere here. I can't really suggest an
improvement to invariant without knowing the whole picture.

> +/// [`struct phy_device`]: ../../../../../../../include/linux/phy.h
> +// During the calls to most functions in [`Driver`], the C side (`PHYLIB=
`) holds a lock that is
> +// unique for every instance of [`Device`]. `PHYLIB` uses a different se=
rialization technique for
> +// [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_dev=
ice`'s state with
> +// the lock held, thus guaranteeing that [`Driver::resume`] has exclusiv=
e access to the instance.
> +// [`Driver::resume`] and [`Driver::suspend`] also are called where only=
 one thread can access
> +// to the instance.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::phy_device>);
> +
> +impl Device {
> +    /// Creates a new [`Device`] instance from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For the duration of 'a, the pointer must point at a valid `phy_d=
evice`,
> +    /// and the caller must be in a context where all methods defined on=
 this struct
> +    /// are safe to call.
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
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.

At the moment the invariant only states that "all functions on
`Device` are safe to call". It does not say anything about accessing
fields. I hope this shows why I think the invariant is problematic.

--=20
Cheers,
Benno


