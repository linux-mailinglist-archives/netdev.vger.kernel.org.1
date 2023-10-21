Return-Path: <netdev+bounces-43235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5827D1D13
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D1281857
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2523DDC7;
	Sat, 21 Oct 2023 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DXE6ZjRB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22BCA7E;
	Sat, 21 Oct 2023 12:13:43 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2764E9;
	Sat, 21 Oct 2023 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697890415; x=1698149615;
	bh=F2xYuKb48Gv1cahjkNPH3fWN6sBk6ZkPotVy7QzC7d0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DXE6ZjRBPgOy5kqIvlKznKpcuHzoGi2anyQQE+ovUGupVu9pNikMW/d3ToC8MRaBx
	 jidZanLSJmjeUyzhVvDDSV8R4MMb4dORt6zzKAKSWjFUoZzAm84zCSJXrnt+/PfWLx
	 4r+Ae8cn5zr0ZGUibfwfNu44gW9ME/cpZNImB9h7YPuYR+XU8Ma2rfGlHrsTGBRjnZ
	 ijuWQdVufpRg16UaTtuNxUoHGdv9O/WQpINfp3x5dFzbPPVnriRzxLTJ30/ljbm7Am
	 YOyj5FPVngmJLueTktH1Yd2K9MEzQGvvAU0r+S1iPwHg2sVkW9QP3IG5WOE6HgmJkx
	 Cvo/D999tJ8Zg==
Date: Sat, 21 Oct 2023 12:13:32 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me>
In-Reply-To: <20231021.203622.624978584179221727.fujita.tomonori@gmail.com>
References: <4e3e0801-b8b2-457b-aee1-086d20365890@proton.me> <20231021.192741.2305009064677924338.fujita.tomonori@gmail.com> <fa420b54-b381-4534-8568-91286eb7d28b@proton.me> <20231021.203622.624978584179221727.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 13:36, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 11:21:12 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 21.10.23 12:27, FUJITA Tomonori wrote:
>>> On Sat, 21 Oct 2023 08:37:08 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> On 21.10.23 09:30, FUJITA Tomonori wrote:
>>>>> On Sat, 21 Oct 2023 07:25:17 +0000
>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>
>>>>>> On 20.10.23 14:54, FUJITA Tomonori wrote:
>>>>>>> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
>>>>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>>>>
>>>>>>>> On Thu, 19 Oct 2023 15:20:51 +0000
>>>>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>>>
>>>>>>>>> I would like to remove the mutable static variable and simplify
>>>>>>>>> the macro.
>>>>>>>>
>>>>>>>> How about adding DriverVTable array to Registration?
>>>>>>>>
>>>>>>>> /// Registration structure for a PHY driver.
>>>>>>>> ///
>>>>>>>> /// # Invariants
>>>>>>>> ///
>>>>>>>> /// The `drivers` slice are currently registered to the kernel via=
 `phy_drivers_register`.
>>>>>>>> pub struct Registration<const N: usize> {
>>>>>>>>         drivers: [DriverVTable; N],
>>>>>>>> }
>>>>>>>>
>>>>>>>> impl<const N: usize> Registration<{ N }> {
>>>>>>>>         /// Registers a PHY driver.
>>>>>>>>         pub fn register(
>>>>>>>>             module: &'static crate::ThisModule,
>>>>>>>>             drivers: [DriverVTable; N],
>>>>>>>>         ) -> Result<Self> {
>>>>>>>>             let mut reg =3D Registration { drivers };
>>>>>>>>             let ptr =3D reg.drivers.as_mut_ptr().cast::<bindings::=
phy_driver>();
>>>>>>>>             // SAFETY: The type invariants of [`DriverVTable`] ens=
ure that all elements of the `drivers` slice
>>>>>>>>             // are initialized properly. So an FFI call with a val=
id pointer.
>>>>>>>>             to_result(unsafe {
>>>>>>>>                 bindings::phy_drivers_register(ptr, reg.drivers.le=
n().try_into()?, module.0)
>>>>>>>>             })?;
>>>>>>>>             // INVARIANT: The `drivers` slice is successfully regi=
stered to the kernel via `phy_drivers_register`.
>>>>>>>>             Ok(reg)
>>>>>>>>         }
>>>>>>>> }
>>>>>>>
>>>>>>> Scratch this.
>>>>>>>
>>>>>>> This doesn't work. Also simply putting slice of DriverVTable into
>>>>>>> Module strcut doesn't work.
>>>>>>
>>>>>> Why does it not work? I tried it and it compiled fine for me.
>>>>>
>>>>> You can compile but the kernel crashes. The addresses of the callback
>>>>> functions are invalid.
>>>>
>>>> Can you please share your setup and the error? For me it booted
>>>> fine.
>>>
>>> You use ASIX PHY hardware?
>>
>> It seems I have configured something wrong. Can you share your testing
>> setup? Do you use a virtual PHY device in qemu, or do you boot it from
>> real hardware with a real ASIX PHY device?
>=20
> real hardware with real ASIX PHY device.

I see.

> Qemu supports a virtual PHY device?

I have no idea.

[...]

>> I think this is very weird, do you have any idea why this
>> could happen?
>=20
> DriverVtable is created on kernel stack, I guess.

But how does that invalidate the function pointers?

>> If you don't mind, could you try if the following changes
>> anything?
>=20
> I don't think it works. If you use const for DriverTable, DriverTable
> is placed on read-only pages. The C side modifies DriverVTable array
> so it does't work.

Did you try it? Note that I copy the `DriverVTable` into the Module
struct, so it will not be placed on a read-only page.

>>       (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $(=
$f:tt)*) =3D> {
>>           const N: usize =3D $crate::module_phy_driver!(@count_devices $=
($driver),+);
>>           struct Module {
>>               _drivers: [::kernel::net::phy::DriverVTable; N],
>>           }
>>
>>           $crate::prelude::module! {
>>               type: Module,
>>               $($f)*
>>           }
>>
>>           unsafe impl Sync for Module {}
>>
>>           impl ::kernel::Module for Module {
>>               fn init(module: &'static ThisModule) -> Result<Self> {
>> =09=09const DRIVERS: [::kernel::net::phy::DriverVTable; N] =3D [$(::kern=
el::net::phy::create_phy_driver::<$driver>()),+];
>>                   let mut m =3D Module {
>>                       _drivers: unsafe { core::ptr::read(&DRIVERS) },
>>                   };
>>                   let ptr =3D m._drivers.as_mut_ptr().cast::<::kernel::b=
indings::phy_driver>();
>>                   ::kernel::error::to_result(unsafe {
>>                       kernel::bindings::phy_drivers_register(ptr, m._dri=
vers.len().try_into()?, module.as_ptr())
>>                   })?;
>>                   Ok(m)
>>               }
>>           }
>>
>> and also the variation where you replace `const DRIVERS` with
>> `static DRIVERS`.
>=20
> Probably works. But looks like similar with the current code? This is
> simpler?

Just curious if it has to do with using `static` vs `const`.

--=20
Cheers,
Benno


