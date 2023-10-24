Return-Path: <netdev+bounces-43937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0F7D5842
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C51C1C20B18
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B083995D;
	Tue, 24 Oct 2023 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YvYHivHi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AC200CC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:28:14 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF3AC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698164891; x=1698424091;
	bh=98N9uf5cvl0J5A8D85/ZuRYIyJrQH+TppzADUVcMh9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YvYHivHiiDzSOg1r/g2PyKTudaqnKVcbPLYXEDhqcmr1LJcWtCLB56+sXhXgSng5a
	 pbTc4s9rxGdOfRbIK4YXpKU72nIuA4XnrunTWoNcsz8McV7inI1kuGfk1BabVQOfBx
	 dK/rzFppfobiuuVAmHPsG5CXJ0QHh4AXaU/T4R0DNKmihTsoXQtBUvXerhvloj668j
	 RmJ3Ckole9ZpZLfQoxYstsC4qHI8OPZgO125C/0QjTkX9vRK1r7ZTwPQzmTFeEbEtB
	 52hb4rg9So1kaSRWck+weakzb0zc7hLEA0cr6+KYfyK/7O17Ydyv4K7tZyX28+918W
	 JCkhfSBjlmdlQ==
Date: Tue, 24 Oct 2023 16:28:02 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver macro
Message-ID: <ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me>
In-Reply-To: <20231024005842.1059620-3-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-3-fujita.tomonori@gmail.com>
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
> This macro creates an array of kernel's `struct phy_driver` and
> registers it. This also corresponds to the kernel's
> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
> loading into the module binary file.
>=20
> A PHY driver should use this macro.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>   rust/kernel/net/phy.rs | 129 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 129 insertions(+)
>=20
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 2d821c2475e1..f346b2b4d3cb 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
>           }
>       }
>   }
> +
> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of kernel's `struct phy_driver` and regi=
sters it.
> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, w=
hich embeds the information
> +/// for module loading into the module binary file. Every driver needs a=
n entry in `device_table`.
> +///
> +/// # Examples
> +///
> +/// ```ignore

Is this example ignored, because it does not compile?

I think Wedson was wrapping his example with `module!` inside
of a module, so maybe try that?

> +/// use kernel::c_str;
> +/// use kernel::net::phy::{self, DeviceId};
> +/// use kernel::prelude::*;
> +///
> +/// kernel::module_phy_driver! {
> +///     drivers: [PhyAX88772A],
> +///     device_table: [
> +///         DeviceId::new_with_driver::<PhyAX88772A>(),
> +///     ],
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +///
> +/// struct PhyAX88772A;
> +///
> +/// impl phy::Driver for PhyAX88772A {
> +///     const NAME: &'static CStr =3D c_str!("Asix Electronics AX88772A"=
);
> +///     const PHY_DEVICE_ID: phy::DeviceId =3D phy::DeviceId::new_with_e=
xact_mask(0x003b1861);
> +/// }
> +/// ```
> +///
> +/// This expands to the following code:
> +///
> +/// ```ignore
> +/// use kernel::c_str;
> +/// use kernel::net::phy::{self, DeviceId};
> +/// use kernel::prelude::*;
> +///
> +/// struct Module {
> +///     _reg: ::kernel::net::phy::Registration,
> +/// }
> +///
> +/// module! {
> +///     type: Module,
> +///     name: "rust_asix_phy",
> +///     author: "Rust for Linux Contributors",
> +///     description: "Rust Asix PHYs driver",
> +///     license: "GPL",
> +/// }
> +///
> +/// const _: () =3D {
> +///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] =3D [
> +///         ::kernel::net::phy::create_phy_driver::<PhyAX88772A>::(),
> +///     ];
> +///
> +///     impl ::kernel::Module for Module {
> +///        fn init(module: &'static ThisModule) -> Result<Self> {
> +///            let mut reg =3D unsafe { ::kernel::net::phy::Registration=
::register(module, Pin::static_mut(&mut DRIVERS)) }?;

Can you please format this as well?

> +///            Ok(Module { _reg: reg })
> +///        }
> +///     }
> +/// }
> +///
> +/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_de=
vice_id; 2] =3D [
> +///     ::kernel::bindings::mdio_device_id {
> +///         phy_id: 0x003b1861,
> +///         phy_id_mask: 0xffffffff,
> +///     },
> +///     ::kernel::bindings::mdio_device_id {
> +///         phy_id: 0,
> +///         phy_id_mask: 0,
> +///     }
> +/// ];
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
> +            ::kernel::bindings::mdio_device_id;
> +            $crate::module_phy_driver!(@count_devices $($dev),+) + 1
> +        ] =3D [
> +            $($dev.mdio_device_id()),+,
> +            ::kernel::bindings::mdio_device_id {
> +                phy_id: 0,
> +                phy_id_mask: 0
> +            }
> +        ];
> +    };
> +
> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f=
:tt)*) =3D> {
> +        struct Module {
> +            _reg: ::kernel::net::phy::Registration,
> +        }
> +
> +        $crate::prelude::module! {
> +            type: Module,
> +            $($f)*
> +        }
> +
> +        const _: () =3D {
> +            static mut DRIVERS: [
> +                ::kernel::net::phy::DriverVTable;
> +                $crate::module_phy_driver!(@count_devices $($driver),+)
> +            ] =3D [
> +                $(::kernel::net::phy::create_phy_driver::<$driver>()),+
> +            ];
> +
> +            impl ::kernel::Module for Module {
> +                fn init(module: &'static ThisModule) -> Result<Self> {
> +                    // SAFETY: The anonymous constant guarantees that no=
body else can access the `DRIVERS` static.
> +                    // The array is used only in the C side.
> +                    let mut reg =3D unsafe { ::kernel::net::phy::Registr=
ation::register(module, core::pin::Pin::static_mut(&mut DRIVERS)) }?;

Can you put the safe operations outside of the `unsafe` block?

Since `rustfmt` does not work well within `macro_rules`, you
have to manually format this code. One trick I use to do this
is to replace all meta variables with normal variables and
just put it in `rustfmt` and then revert the replacement in
the output.

--=20
Cheers,
Benno

> +                    Ok(Module { _reg: reg })
> +                }
> +            }
> +        };
> +
> +        $crate::module_phy_driver!(@device_table [$($dev),+]);
> +    }
> +}
> --
> 2.34.1
>=20



