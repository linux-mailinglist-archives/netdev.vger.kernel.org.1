Return-Path: <netdev+bounces-44103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB47D62B0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BBC281C9B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7181775F;
	Wed, 25 Oct 2023 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X4dgopWo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59C17752
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:29:50 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB0196
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698218987; x=1698478187;
	bh=pED421TpJJHdwgV8n4kqv80TVW0BbxvrXYVTO6FpFxA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X4dgopWo79I0GxpjG3ndFyC1410JKqYjg4ipQghQizShDPiDBA4I5DAqHD18jWcxX
	 xDm3kixN9uQDxNDbBCs39jidkYkgrnzAwCw7HxkmpgIMa2/JbzjsNiYdijvSwLTPsz
	 4A8fq6kF4dD3UDGT7T/StJYNb3kb8ufd5q0dFVuD+ECsMrr2miKZ+KcmbnA1ZdKwKa
	 pQ3ETBQGUQob+lq4VWEoK3Lm+a7szSyuSpeZ7HWajPYq8cw9zRHcXicAiKVVVCvl2d
	 p0j3b0pjVoNMBnZhea7DHgQ5zJ3YgU+OD2AA4o6HTBoe6OxNIWJT2iroYhFIpJSwuv
	 j2QPoytVIQweA==
Date: Wed, 25 Oct 2023 07:29:32 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver macro
Message-ID: <42eeb38d-6d24-4c56-8ffd-27c48405cae9@proton.me>
In-Reply-To: <20231025.090243.1437967503809186729.fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-3-fujita.tomonori@gmail.com> <ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me> <20231025.090243.1437967503809186729.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.10.23 02:02, FUJITA Tomonori wrote:
> On Tue, 24 Oct 2023 16:28:02 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 24.10.23 02:58, FUJITA Tomonori wrote:
>>> This macro creates an array of kernel's `struct phy_driver` and
>>> registers it. This also corresponds to the kernel's
>>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>>> loading into the module binary file.
>>>
>>> A PHY driver should use this macro.
>>>
>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> ---
>>>    rust/kernel/net/phy.rs | 129 +++++++++++++++++++++++++++++++++++++++=
++
>>>    1 file changed, 129 insertions(+)
>>>
>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>> index 2d821c2475e1..f346b2b4d3cb 100644
>>> --- a/rust/kernel/net/phy.rs
>>> +++ b/rust/kernel/net/phy.rs
>>> @@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
>>>            }
>>>        }
>>>    }
>>> +
>>> +/// Declares a kernel module for PHYs drivers.
>>> +///
>>> +/// This creates a static array of kernel's `struct phy_driver` and re=
gisters it.
>>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro,=
 which embeds the information
>>> +/// for module loading into the module binary file. Every driver needs=
 an entry in `device_table`.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```ignore
>>
>> Is this example ignored, because it does not compile?
>=20
> The old version can't be compiled but the current version can so I'll
> drop ignore.
>=20
>=20
>> I think Wedson was wrapping his example with `module!` inside
>> of a module, so maybe try that?
>=20
> I'm not sure what you mean.

Wedson did this [1], note the `# mod module_fs_sample`:

/// # Examples
///
/// ```
/// # mod module_fs_sample {
/// use kernel::prelude::*;
/// use kernel::{c_str, fs};
///
/// kernel::module_fs! {
///     type: MyFs,
///     name: "myfs",
///     author: "Rust for Linux Contributors",
///     description: "My Rust fs",
///     license: "GPL",
/// }
///
/// struct MyFs;
/// impl fs::FileSystem for MyFs {
///     const NAME: &'static CStr =3D c_str!("myfs");
/// }
/// # }
/// ```

[1]: https://github.com/wedsonaf/linux/commit/e909f439481cf6a3df00c7064b0d6=
4cee8630fe9#diff-9b893393ed2a537222d79f6e2fceffb7e9d8967791c2016962be3171c4=
46210fR104-R124

>>> +/// use kernel::c_str;
>>> +/// use kernel::net::phy::{self, DeviceId};
>>> +/// use kernel::prelude::*;

[...]

>>> +        const _: () =3D {
>>> +            static mut DRIVERS: [
>>> +                ::kernel::net::phy::DriverVTable;
>>> +                $crate::module_phy_driver!(@count_devices $($driver),+=
)
>>> +            ] =3D [
>>> +                $(::kernel::net::phy::create_phy_driver::<$driver>()),=
+
>>> +            ];
>>> +
>>> +            impl ::kernel::Module for Module {
>>> +                fn init(module: &'static ThisModule) -> Result<Self> {
>>> +                    // SAFETY: The anonymous constant guarantees that =
nobody else can access the `DRIVERS` static.
>>> +                    // The array is used only in the C side.
>>> +                    let mut reg =3D unsafe { ::kernel::net::phy::Regis=
tration::register(module, core::pin::Pin::static_mut(&mut DRIVERS)) }?;
>>
>> Can you put the safe operations outside of the `unsafe` block?
>=20
> fn init(module: &'static ThisModule) -> Result<Self> {
>      // SAFETY: The anonymous constant guarantees that nobody else can ac=
cess
>      // the `DRIVERS` static. The array is used only in the C side.
>      let mut reg =3D ::kernel::net::phy::Registration::register(
>          module,
>          core::pin::Pin::static_mut(unsafe { &mut DRIVERS }),
>      )?;
>      Ok(Module { _reg: reg })
> }

Here the `unsafe` block and the `SAFETY` comment are pretty far away.
What about this?:

fn init(module: &'static ThisModule) -> Result<Self> {
     // SAFETY: The anonymous constant guarantees that nobody else can acce=
ss
     // the `DRIVERS` static. The array is used only in the C side.
     let drivers =3D unsafe { &mut DRIVERS };
     let mut reg =3D
         ::kernel::net::phy::Registration::register(module, ::core::pin::Pi=
n::static_mut(drivers))?;
     Ok(Module { _reg: reg })
}

Also note that I added `::` to the front of `core`.

--=20
Cheers,
Benno



