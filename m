Return-Path: <netdev+bounces-43238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125917D1D2B
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675211F2183A
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F04C8D;
	Sat, 21 Oct 2023 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BlhO2fQc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66ED1C2D;
	Sat, 21 Oct 2023 12:50:40 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED28D67;
	Sat, 21 Oct 2023 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ulq4cgznrva4rbsiugi3bn56dq.protonmail; t=1697892632; x=1698151832;
	bh=mUvvlqyD8IEurUV2prfLhSa/rMiUG3VhlUtbjIzzdww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BlhO2fQcmd+sPa0UaOB3PNCvqJomrRogZg7v6eauDTfDFXTBHehEf6JsD9zZyS3lv
	 vCEbfEedBc5qjik8EPfgeXoeB2HPc49jT/8aem/UTPdejeA03kjexseHoqMZUnsQJg
	 bajZNmyabUELeH+QODENpmcHL0vWguTZ9bfoH+xOB61GXXBz07xd/d7llVYoKfjeBK
	 eSRWr2WXGvLuK7W80L9jSD4mt8/kFr8pLZ6MGNZlK3QnWHXslgxGVPUQkq/xGduiHf
	 Tl7A66h67Za15cz0CH7C22CB+3ttgn+G+FvyxOUM/VGXNrSMt6H4tYVvIP4j93RZbL
	 mCgEETOI8Sh8w==
Date: Sat, 21 Oct 2023 12:50:10 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me>
In-Reply-To: <20231021.213834.76499402455687702.fujita.tomonori@gmail.com>
References: <fa420b54-b381-4534-8568-91286eb7d28b@proton.me> <20231021.203622.624978584179221727.fujita.tomonori@gmail.com> <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me> <20231021.213834.76499402455687702.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 14:38, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 12:13:32 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>>>>> Can you please share your setup and the error? For me it booted
>>>>>> fine.
>>>>>
>>>>> You use ASIX PHY hardware?
>>>>
>>>> It seems I have configured something wrong. Can you share your testing
>>>> setup? Do you use a virtual PHY device in qemu, or do you boot it from
>>>> real hardware with a real ASIX PHY device?
>>>
>>> real hardware with real ASIX PHY device.
>>
>> I see.
>>
>>> Qemu supports a virtual PHY device?
>>
>> I have no idea.
>=20
> When I had a look at Qemu several months ago, it didn't support such.
>=20
>> [...]
>>
>>>> I think this is very weird, do you have any idea why this
>>>> could happen?
>>>
>>> DriverVtable is created on kernel stack, I guess.
>>
>> But how does that invalidate the function pointers?
>=20
> Not only funciton pointers. You can't store something on stack for
> later use.

It is not stored on the stack, it is only created on the stack and
moved to a global static later on. The `module!` macro creates a
`static mut __MOD: Option<Module>` where the module data is stored in.

It seems that constructing the driver table not at that location
is somehow interfering with something?

Wedson has a patch [1] to create in-place initialized modules, but
it probably is not completely finished, as he has not yet begun to
post it to the list. But I am sure that it is mature enough for
you to test this hypothesis.

[1]: https://github.com/wedsonaf/linux/commit/484ec70025ff9887d9ca228ec6312=
64039cee355

--=20
Cheers,
Benno

>>>> If you don't mind, could you try if the following changes
>>>> anything?
>>>
>>> I don't think it works. If you use const for DriverTable, DriverTable
>>> is placed on read-only pages. The C side modifies DriverVTable array
>>> so it does't work.
>>
>> Did you try it? Note that I copy the `DriverVTable` into the Module
>> struct, so it will not be placed on a read-only page.
>=20
> Ah, I misunderstood code. It doesn't work. DriverVTable on stack.
>=20
>=20
>>>>        (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+],=
 $($f:tt)*) =3D> {
>>>>            const N: usize =3D $crate::module_phy_driver!(@count_device=
s $($driver),+);
>>>>            struct Module {
>>>>                _drivers: [::kernel::net::phy::DriverVTable; N],
>>>>            }
>>>>
>>>>            $crate::prelude::module! {
>>>>                type: Module,
>>>>                $($f)*
>>>>            }
>>>>
>>>>            unsafe impl Sync for Module {}
>>>>
>>>>            impl ::kernel::Module for Module {
>>>>                fn init(module: &'static ThisModule) -> Result<Self> {
>>>> =09=09const DRIVERS: [::kernel::net::phy::DriverVTable; N] =3D [$(::ke=
rnel::net::phy::create_phy_driver::<$driver>()),+];
>>>>                    let mut m =3D Module {
>>>>                        _drivers: unsafe { core::ptr::read(&DRIVERS) },
>>>>                    };
>>>>                    let ptr =3D m._drivers.as_mut_ptr().cast::<::kernel=
::bindings::phy_driver>();
>>>>                    ::kernel::error::to_result(unsafe {
>>>>                        kernel::bindings::phy_drivers_register(ptr, m._=
drivers.len().try_into()?, module.as_ptr())
>>>>                    })?;
>>>>                    Ok(m)
>>>>                }
>>>>            }
>>>>
>>>> and also the variation where you replace `const DRIVERS` with
>>>> `static DRIVERS`.
>>>
>>> Probably works. But looks like similar with the current code? This is
>>> simpler?
>>
>> Just curious if it has to do with using `static` vs `const`.
>=20
> static doesn't work too due to the same reason.



