Return-Path: <netdev+bounces-40869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D266B7C8F1B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8841C28233F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D770266A0;
	Fri, 13 Oct 2023 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W3F9nVQ1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A774241FF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:31:33 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC6B7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697232686; x=1697491886;
	bh=xFnu/cVH22vc/MtKK0j1gDECBOUmGrUdl9GeHISpbck=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W3F9nVQ1dq1l3UiNwNnSjWKoT92xd0S5C8qsclAE9yYse+FohNjFJ5kqOAkD7Mtmn
	 N3W8q8is56KmnmHl3i8o2fLgoeM0HXaJaFcJJ9zGeSEhsX5LbtfKSArpxHRUXV3bQ+
	 9awwW7gnfP2On7f3Alve2c2x/zYbNM4ekLG8QIhRh7PMXoqBZdwU/brm5sUC9okh1P
	 z9qPkdXPV1uNcdsBv2/n61LVyUQRRESYeFUb7ITzj03x8C9dzf8CXhTy4a8s4gY8OX
	 1RtThBiefXetfH8ocyQJyJviR0ZTEMrQB84Bl+RuWoaIyt+DvhFdWuVCvWksDTlrY3
	 FHg/ldAmBzUYQ==
Date: Fri, 13 Oct 2023 21:31:16 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
In-Reply-To: <20231012125349.2702474-2-fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com> <20231012125349.2702474-2-fujita.tomonori@gmail.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12.10.23 14:53, FUJITA Tomonori wrote:
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
>   init/Kconfig                    |   8 +
>   rust/Makefile                   |   1 +
>   rust/bindings/bindings_helper.h |   3 +
>   rust/kernel/lib.rs              |   3 +
>   rust/kernel/net.rs              |   6 +
>   rust/kernel/net/phy.rs          | 679 ++++++++++++++++++++++++++++++++
>   6 files changed, 700 insertions(+)
>   create mode 100644 rust/kernel/net.rs
>   create mode 100644 rust/kernel/net/phy.rs
>=20
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..0fc6f5568748 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1903,6 +1903,14 @@ config RUST
>=20
>   =09  If unsure, say N.
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

I find it a bit weird that this is its own option under "General". I think
it would be reasonable to put it under "Rust", since that would also scale
better when other subsystems do this.

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

Please change this to Miguel's solution.

>   =09=09--no-debug '.*' \
>   =09=09-o $@ -- $(bindgen_c_flags_final) -DMODULE \
>   =09=09$(bindgen_target_cflags) $(bindgen_target_extra)

[...]

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
> +    /// This function can be called only in the callbacks in `phy_driver=
`. PHYLIB guarantees

"can be called in" -> "must only be called from"

> +    /// the exclusive access for the duration of the lifetime `'a`.

In some other thread you mentioned that no lock is held for
`resume`/`suspend`, how does this interact with it?

> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Se=
lf {
> +        // SAFETY: The safety requirements guarantee the validity of the=
 dereference, while the
> +        // `Device` type being transparent makes the cast ok.
> +        unsafe { &mut *ptr.cast() }

please refactor to

     // CAST: ...
     let ptr =3D ptr.cast::<Self>();
     // SAFETY: ...
     unsafe { &mut *ptr }

> +    }

[...]

> +    /// Returns true if auto-negotiation is completed.
> +    pub fn is_autoneg_completed(&self) -> bool {
> +        const AUTONEG_COMPLETED: u32 =3D 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let phydev =3D unsafe { *self.0.get() };
> +        phydev.autoneg_complete() =3D=3D AUTONEG_COMPLETED
> +    }
> +
> +    /// Sets the speed of the PHY.
> +    pub fn set_speed(&self, speed: u32) {

This function modifies state, but is `&self`?

> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let mut phydev =3D unsafe { *self.0.get() };
> +        phydev.speed =3D speed as i32;
> +    }
> +
> +    /// Sets duplex mode.
> +    pub fn set_duplex(&self, mode: DuplexMode) {

This function modifies state, but is `&self`?

> +        let v =3D match mode {
> +            DuplexMode::Full =3D> bindings::DUPLEX_FULL as i32,
> +            DuplexMode::Half =3D> bindings::DUPLEX_HALF as i32,
> +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN as i32,
> +        };
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        let mut phydev =3D unsafe { *self.0.get() };
> +        phydev.duplex =3D v;

Note that this piece of code will actually not do the correct thing. It
will create a copy of `phydev` on the stack and modify that instead of the
pointee of `self`. I think the code was fine before this change.

> +    }
> +
> +    /// Reads a given C22 PHY register.
> +    pub fn read(&self, regnum: u16) -> Result<u16> {

No idea if this function should be `&mut self` or `&self`. Would
it be ok for mutltiple threads to call this function concurrently?
If yes, then leave it as `&self`, if no then change it to `&mut self`.

> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret =3D unsafe {
> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.ad=
dr, regnum.into())
> +        };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Writes a given C22 PHY register.
> +    pub fn write(&self, regnum: u16, val: u16) -> Result {

This should probably be `&mut self`, but not sure.

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
> +    pub fn read_paged(&self, page: u16, regnum: u16) -> Result<u16> {

Again same question (also for all other functions below that call the C
side).

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

[...]

> +}
> +
> +/// Defines certain other features this PHY supports (like interrupts).

Maybe add a link where these flags can be used.

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

[...]

> +
> +/// Corresponds to functions in `struct phy_driver`.
> +///
> +/// This is used to register a PHY driver.
> +#[vtable]
> +pub trait Driver {
> +    /// Defines certain other features this PHY supports.
> +    /// It is a combination of the flags in the [`flags`] module.
> +    const FLAGS: u32 =3D 0;

What would happen if I set this to some value that is not a combination of
the flag values above? I expect that bits that are not part of the flag
values above to be ignored.

> +    /// The friendly name of this PHY type.
> +    const NAME: &'static CStr;
> +
> +    /// This driver only works for PHYs with IDs which match this field.

Mention that the default value is 0.

> +    const PHY_DEVICE_ID: DeviceId =3D DeviceId::new_with_custom_mask(0, =
0);

[...]

> +}
> +
> +/// Registration structure for a PHY driver.
> +///
> +/// # Invariants
> +///
> +/// All elements of the `drivers` slice are valid and currently register=
ed
> +/// to the kernel via `phy_drivers_register`.

Since `DriverType` is now safe a wrapper type, this invariant should be
moved to that type instead.

> +pub struct Registration {
> +    drivers: &'static [DriverType],
> +}
> +
> +impl Registration {
> +    /// Registers a PHY driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The values of the `drivers` array must be initialized properly.

With the above change you do not need this (since all instances of
`DriverType` are always initialized). But I am not sure if it would be
fine to call `phy_driver_register` multiple times with the same driver
without unregistering it first.

I thought about this implementation of `Registration` a bit and I think
there are two possible ways to avoid both this `unsafe` function and the
mutable static in the `module_phy_driver` macro from patch 2:

Option 1:
- make the constructor of `DriverType` register the driver and the `Drop`
   impl unregister the driver.
- remove the `Registration` type.
- in the `module_phy_driver` macro create the array of `DriverType`s inside
   of the `Module` struct.

The disadvantage of this solution is that `phy_drivers_register` is called
for every driver (and also `phy_drivers_unregister`). But if you and Andrew
think that that is fine, then go with this option. The other advantage of
this solution is that it also becomes safely usable without the
`module_phy_driver` macro. For exmaple when a more complex `Module`
struct is needed by a driver.

Option 2:
- remove the `Registration` type.
- in the `module_phy_driver` macro: create the array of `DriverType`s insid=
e
   of the `Module` struct.
- in the `module_phy_driver` macro: register the drivers in the
   `Module::init` function and unregister them in the `Drop` impl of
   `Module`.

This approach only has one call to `phy_drivers_(un)register`, but cannot
really be used safely without the `module_phy_driver` macro.

> +    pub unsafe fn register(
> +        module: &'static crate::ThisModule,
> +        drivers: &'static [DriverType],
> +    ) -> Result<Self> {
> +        if drivers.is_empty() {
> +            return Err(code::EINVAL);
> +        }
> +        // SAFETY: The safety requirements of the function ensure that `=
drivers` array are initialized properly.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe {
> +            bindings::phy_drivers_register(drivers[0].0.get(), drivers.l=
en().try_into()?, module.0)
> +        })?;
> +        // INVARIANT: The safety requirements of the function and the su=
ccess of `phy_drivers_register` ensure
> +        // the invariants.
> +        Ok(Registration { drivers })
> +    }
> +}

[...]

> +
> +    /// Get a `mask` as u32.
> +    pub const fn mask_as_int(&self) -> u32 {
> +        self.mask.as_int()
> +    }
> +
> +    // macro use only
> +    #[doc(hidden)]
> +    pub const fn as_mdio_device_id(&self) -> bindings::mdio_device_id {

I would name this just `mdio_device_id`.

--=20
Cheers,
Benno

> +        bindings::mdio_device_id {
> +            phy_id: self.id,
> +            phy_id_mask: self.mask.as_int(),
> +        }
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
> +    const fn as_int(&self) -> u32 {
> +        match self {
> +            DeviceMask::Exact =3D> Self::MASK_EXACT,
> +            DeviceMask::Model =3D> Self::MASK_MODEL,
> +            DeviceMask::Vendor =3D> Self::MASK_VENDOR,
> +            DeviceMask::Custom(mask) =3D> *mask,
> +        }
> +    }
> +}
> --
> 2.34.1
>


