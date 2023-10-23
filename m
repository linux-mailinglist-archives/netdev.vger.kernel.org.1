Return-Path: <netdev+bounces-43346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA37D2A8A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EEE1C208BC
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68D63C0;
	Mon, 23 Oct 2023 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PFFo+cjK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A472C9A;
	Mon, 23 Oct 2023 06:38:05 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE578188;
	Sun, 22 Oct 2023 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698043082; x=1698302282;
	bh=rNhkkbSrWyTbIysWFN3HxjEX4U7X0PvyuV1DDIY+xBk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PFFo+cjKoKfUwgm0SDsziaXQpNwxHNHzF4Id3ZYzbBAxuSAKu1Z8iGnD4oOoRU+/s
	 Yy96M4fsx2Saqpjy0BfcpExa6mtpqe5nWn1c7uU7zYbHZizemdI6lx6AolwaLsYDtI
	 UCsumdHZrYiuVpSSKjwYqUKme06D15+WImqUjsJGqnumJ69Id6/gbdfixeYf5604c2
	 WRhSKD7v09jf80bYgxeJR7xQErJqh/hGxbKzmaqIsvrXka2liTIiEJmAxOZWr2PQ3x
	 dNqrNPN79/ktMBvsEJuO5RzfPHhRIqN84IZuKv8ciTGK/y/8XMphMH9ZLGTtu2+EhY
	 Rl/DxVOYxe2XA==
Date: Mon, 23 Oct 2023 06:37:46 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <8096fd6e-53b7-4f26-91cf-44e6f46b6ec3@proton.me>
In-Reply-To: <7e6ae279-9667-409f-9818-95683118971f@proton.me>
References: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me> <20231021.223115.1115424295905877996.fujita.tomonori@gmail.com> <cd3ff8e6-214e-4a80-980e-e92751223002@proton.me> <20231022.064501.394351620043801227.fujita.tomonori@gmail.com> <7e6ae279-9667-409f-9818-95683118971f@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.10.23 08:35, Benno Lossin wrote:
> On 21.10.23 23:45, FUJITA Tomonori wrote:
>> On Sat, 21 Oct 2023 13:35:57 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>
>>>> Currently, it needs &'static DriverVTable
>>>> array so it works.
>>>
>>> That is actually also incorrect. As the C side is going to modify
>>> the `DriverVTable`, you should actually use `&'static mut DriverVTable`=
.
>>> But since it is not allowed to be moved you have to use
>>> `Pin<&'static mut DriverVTable>`.
>>
>> I updated Registration::register(). Needs to add comments on requirement=
?
>>
>> impl Registration {
>>       /// Registers a PHY driver.
>>       pub fn register(
>>           module: &'static crate::ThisModule,
>>           drivers: Pin<&'static mut [DriverVTable]>,
>>       ) -> Result<Self> {
>>           // SAFETY: The type invariants of [`DriverVTable`] ensure that=
 all elements of the `drivers` slice
>>           // are initialized properly. So an FFI call with a valid point=
er.
>=20
> This SAFETY comment needs to mention that `drivers[0].0.get()` are

Sorry, I meant `drivers` instead of `drivers[0].0.get()`

--=20
Cheers,
Benno

> pinned and will not change address.
>=20
>>           to_result(unsafe {
>>               bindings::phy_drivers_register(drivers[0].0.get(), drivers=
.len().try_into()?, module.0)
>>           })?;
>>           // INVARIANT: The `drivers` slice is successfully registered t=
o the kernel via `phy_drivers_register`.
>>           Ok(Registration { drivers })
>>       }
>> }
>=20
> Otherwise this looks good.
>=20
>>
>>
>>>> The C side uses static allocation too. If someone asks for, we could
>>>> loosen the restriction with a complicated implentation. But I doubt
>>>> that someone would ask for such.
>>>
>>> With Wedson's patch you also would be using the static allocation
>>> from `module!`. What my problem is, is that you are using a `static mut=
`
>>> which is `unsafe` and you do not actually have to use it (with
>>> Wedson's patch of course).
>>
>> Like your vtable patch, I improve the code when something useful is
>> available.
>=20
> Sure. If you have the time though, it would be helpful to know
> if the patch actually fixes the issue. I am pretty sure it will,
> but you never know unless you try.



