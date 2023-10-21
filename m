Return-Path: <netdev+bounces-43242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28957D1D40
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A51B21070
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD36D528;
	Sat, 21 Oct 2023 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Zg0Is2zo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A052D52D;
	Sat, 21 Oct 2023 13:36:14 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7591E7;
	Sat, 21 Oct 2023 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wrbvkq3udzhmvi3ybcbf4gm3na.protonmail; t=1697895367; x=1698154567;
	bh=NSAOegpxQQ769gmP/Dk7eXp/yHb9+2knFQzuunERR4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zg0Is2zopKZwc8pxxzYtcJGn+7s+QUrwrjB8+6LbjKbLaJLk9P+/5Q9e9ighDk7Cv
	 jGtQ1gZwTvEIqh69rCF40IDUIYD4TL3bxDPMQ5avuexBQ6MmLZc5vYSCsvsEXaKbks
	 leGeFUvPlEzQvTKult3V2NZ3fKM0c6WSZQD/q8f0n/nzjYyMRIUTQXyCOPQmGUrOut
	 qsuVjioG1wikhLWe9z2V6AEj6DULR5S+bo6XfwpjruyimIe0ghgOnFPxGpxbYZGvII
	 qwOFG66h0Qpe+S507f65c7EL/Vy+pc4m8OY6K3yqknww9h1bjs0Asn9IN2xa+422CT
	 SZJXabsI1v85g==
Date: Sat, 21 Oct 2023 13:35:57 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <cd3ff8e6-214e-4a80-980e-e92751223002@proton.me>
In-Reply-To: <20231021.223115.1115424295905877996.fujita.tomonori@gmail.com>
References: <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me> <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com> <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me> <20231021.223115.1115424295905877996.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 15:31, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 13:05:59 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 21.10.23 15:00, FUJITA Tomonori wrote:
>>> On Sat, 21 Oct 2023 12:50:10 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>>> I think this is very weird, do you have any idea why this
>>>>>>>> could happen?
>>>>>>>
>>>>>>> DriverVtable is created on kernel stack, I guess.
>>>>>>
>>>>>> But how does that invalidate the function pointers?
>>>>>
>>>>> Not only funciton pointers. You can't store something on stack for
>>>>> later use.
>>>>
>>>> It is not stored on the stack, it is only created on the stack and
>>>> moved to a global static later on. The `module!` macro creates a
>>>> `static mut __MOD: Option<Module>` where the module data is stored in.
>>>
>>> I know. The problem is that we call phy_drivers_register() with
>>> DriverVTable on stack. Then it was moved.
>>
>> I see, what exactly is the problem with that? In other words:
>> why does PHYLIB need `phy_driver` to stay at the same address?
>=20
> phy_driver_register stores addresses that you passed.

But the function pointers don't change?

>> This is an important requirement in Rust. Rust can ensure that
>> types are not moved by means of pinning them. In this case, Wedson's
>> patch below should fix the issue completely.
>>
>> But we should also fix this in the abstractions, the `DriverVTable`
>> type should only be constructible in a pinned state. For this purpose
>> we have the `pin-init` API [2].
>=20
> You can create DriverVTable freely. The restriction is what
> phy_driver_register takes.=20

Sure you can also keep it this way, I just thought only allowing
pinned creation makes things simpler.

> Currently, it needs &'static DriverVTable
> array so it works.

That is actually also incorrect. As the C side is going to modify
the `DriverVTable`, you should actually use `&'static mut DriverVTable`.
But since it is not allowed to be moved you have to use
`Pin<&'static mut DriverVTable>`.

> The C side uses static allocation too. If someone asks for, we could
> loosen the restriction with a complicated implentation. But I doubt
> that someone would ask for such.

With Wedson's patch you also would be using the static allocation
from `module!`. What my problem is, is that you are using a `static mut`
which is `unsafe` and you do not actually have to use it (with
Wedson's patch of course).

--=20
Cheers,
Benno



