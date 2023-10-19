Return-Path: <netdev+bounces-42693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FE7CFDB9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EAE2820D0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3872FE1F;
	Thu, 19 Oct 2023 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c1zN6LDN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2992FE1D;
	Thu, 19 Oct 2023 15:21:10 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7158138;
	Thu, 19 Oct 2023 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697728864; x=1697988064;
	bh=gSIBCUVFkXS9f9uN3ALCSQfYKKLDT6D80K45dyGIRkQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c1zN6LDN3YpMsvzwjBY703VZneh/thw11uujVWxLCXiq529Hwg/gtm3xxfDWGJ8+9
	 nWWdWlzljInKjEA1t808B3so0cXAWGQQyHunOO2tmJSgBviSAhJwhUwrq3C2WNrVOA
	 dZfOMQLXtg3J9gUbgSngZLR/hDlIy/k3ZCPH6uE8YvxGq1s7wQo2ZxzV2cH31VR8QP
	 ELGl3MzF4sUh4SmXJ3zNl5i3XOh0kJpb1BpLbm5FxAStDtX86wVgTNpjbeHWbbCFeA
	 KSE02AIn9JqgG0STZo3SJvxb3h8gkLQVUNUMLQ9BFxd4LJkwLac+x8QehdAQsQMvOJ
	 rr1PGJs8mcvOQ==
Date: Thu, 19 Oct 2023 15:20:51 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
In-Reply-To: <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me> <20231019.092436.1433321157817125498.fujita.tomonori@gmail.com> <0e8d2538-284b-4811-a2e7-99151338c255@proton.me> <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.23 16:42, FUJITA Tomonori wrote:
>>>>> +/// Registration structure for a PHY driver.
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// The `drivers` slice are currently registered to the kernel via `=
phy_drivers_register`.
>>>>> +pub struct Registration {
>>>>> +    drivers: &'static [DriverType],
>>>>> +}
>>>>
>>>> You did not reply to my suggestion [2] to remove this type,
>>>> what do you think?
>>>>
>>>> [2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1=
eca63c45cf@proton.me/
>>>
>>> I tried before but I'm not sure it simplifies the implementation.
>>>
>>> Firstly, instead of Reservation, we need a public function like
>>>
>>> pub fn phy_drivers_register(module: &'static crate::ThisModule, drivers=
: &[DriverVTable]) -> Result {
>>>       to_result(unsafe {
>>>           bindings::phy_drivers_register(drivers[0].0.get(), drivers.le=
n().try_into()?, module.0)
>>>       })
>>> }
>>>
>>> This is because module.0 is private.
>>
>> Why can't this be part of the macro?
>=20
> I'm not sure I correctly understand what you suggest so you meant the fol=
lowing?
>=20
>      (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f=
:tt)*) =3D> {
>          struct Module {
>               _drv:  [
>                  ::kernel::net::phy::DriverVTable;
>                  $crate::module_phy_driver!(@count_devices $($driver),+)
>              ],
>          }
>          unsafe impl Sync for Module {}
>=20
>          $crate::prelude::module! {
>              type: Module,
>              $($f)*
>          }
>=20
>          impl ::kernel::Module for Module {
>              fn init(module: &'static ThisModule) -> Result<Self> {
>                  let drv =3D [
>                      $(::kernel::net::phy::create_phy_driver::<$driver>()=
),+
>                  ];
>                  ::kernel::error::to_result(unsafe {
>                      ::kernel::bindings::phy_drivers_register(drv[0].0.ge=
t(), drv.len().try_into()?, module.0)

You can just do this (I omitted the `::kernel::` prefix for
readability, if you add this in the macro, please include it):

     // CAST: `DriverVTable` is `repr(transparent)` and wrapping `bindings:=
:phy_driver`.
     let ptr =3D drv.as_mut_ptr().cast::<bindings::phy_driver>();
     let len =3D drv.len().try_into()?;
     // SAFETY: ...
     to_result(unsafe { bindings::phy_drivers_register(ptr, len, module.0) =
})?;

>                  })?;
>=20
>                  Ok(Module {
>                      _drv: drv,
>                  })
>              }
>          }
>=20
> Then we got the following error:
>=20
> error[E0616]: field `0` of struct `DriverVTable` is private
>    --> drivers/net/phy/ax88796b_rust.rs:12:1
>       |
>       12 | / kernel::module_phy_driver! {
>       13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>       14 | |     device_table: [
>       15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
>       ...  |
>       22 | |     license: "GPL",
>       23 | | }
>          | |_^ private field
> =09   |
> =09      =3D note: this error originates in the macro
> =09      `kernel::module_phy_driver` (in Nightly builds, run with
> =09      -Z macro-backtrace for more info)
>=20
> error[E0616]: field `0` of struct `kernel::ThisModule` is private
>    --> drivers/net/phy/ax88796b_rust.rs:12:1
>       |
>       12 | / kernel::module_phy_driver! {
>       13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>       14 | |     device_table: [
>       15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
>       ...  |
>       22 | |     license: "GPL",
>       23 | | }
>          | |_^ private field
>=20
>=20
>>> Also if we keep DriverVtable.0 private, we need another public function=
.
>>>
>>> pub unsafe fn phy_drivers_unregister(drivers: &'static [DriverVTable])
>>> {
>>>       unsafe {
>>>           bindings::phy_drivers_unregister(drivers[0].0.get(), drivers.=
len() as i32)
>>>       };
>>> }
>>>
>>> DriverVTable isn't guaranteed to be registered to the kernel so needs
>>> to be unsafe, I guesss.
>>
>> In one of the options I suggest to make that an invariant of `DriverVTab=
le`.
>>
>>>
>>> Also Module trait support exit()?
>>
>> Yes, just implement `Drop` and do the cleanup there.
>>
>> In the two options that I suggested there is a trade off. I do not know
>> which option is better, I hoped that you or Andrew would know more:
>> Option 1:
>> * advantages:
>>     - manual creation of a phy driver module becomes possible.
>>     - less complex `module_phy_driver` macro.
>>     - no static variable needed.
>> * disadvantages:
>>     - calls `phy_drivers_register` for every driver on module
>>       initialization.
>>     - calls `phy_drivers_unregister` for every driver on module
>>       exit.
>>
>> Option 2:
>> * advantages:
>>     - less complex `module_phy_driver` macro.
>>     - no static variable needed.
>>     - only a single call to
>>       `phy_drivers_register`/`phy_drivers_unregister`.
>> * disadvantages:
>>     - no safe manual creation of phy drivers possible, the only safe
>>       way is to use the `module_phy_driver` macro.
>>
>> I suppose that it would be ok to call the register function multiple
>> times, since it only is on module startup/shutdown and it is not
>> performance critical.
>=20
> I think that we can use the current implantation using Reservation
> struct until someone requests manual creation. I doubt that we will
> need to support such.

I would like to remove the mutable static variable and simplify
the macro.

--=20
Cheers,
Benno



