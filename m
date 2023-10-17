Return-Path: <netdev+bounces-41946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6D77CC5F0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5821F231D9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE641750;
	Tue, 17 Oct 2023 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aUdLydFI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6E4446F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:32:25 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5425C92
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697553141; x=1697812341;
	bh=LeJACiK8k41rGXlYq+ParZetrisZUYGK8XTW8D7eDjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aUdLydFImzx7+pqR4Q+AgNBQ3up0/Rzg4ahMlmdSccGQ0QSZW+X7CFG18IVqaZIpY
	 uqYPgndSZ7qZafT/WY0GYXEoAVWkog3kDf/mUtxa3UCp9wH8nfEuEyNPilZ3+zOhAU
	 xuTxzrUErA2qkCohjjsDwLzTRrc1yTtB4MnLMKCtYqavbuBgN7DC0QSnpx6JIP/YKd
	 uGr3DsKVdvNUGIH/Q+MqEiuaWMMV8xf4SgRBv+YMI/o0/9FZEBIUYo7LxyqtwXJInE
	 iX30QAODQDY+gEHOpkbsVqYE1gK2EwOwA9Z5P5ydWSfOPC45wscswhzf4Lzkc4YZgm
	 R0hmhhG2Pfd+g==
Date: Tue, 17 Oct 2023 14:32:07 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
In-Reply-To: <2023101756-procedure-uninvited-f6c9@gregkh>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me> <20231015.011502.276144165010584249.fujita.tomonori@gmail.com> <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com> <98471d44-c267-4c80-ba54-82ab2563e465@proton.me> <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch> <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me> <2023101756-procedure-uninvited-f6c9@gregkh>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.10.23 16:21, Greg KH wrote:
> On Tue, Oct 17, 2023 at 02:04:33PM +0000, Benno Lossin wrote:
>> On 17.10.23 14:38, Andrew Lunn wrote:
>>>>> Because set_speed() updates the member in phy_device and read()
>>>>> updates the object that phy_device points to?
>>>>
>>>> `set_speed` is entirely implemented on the Rust side and is not protec=
ted
>>>> by a lock.
>>>
>>> With the current driver, all entry points into the driver are called
>>> from the phylib core, and the core guarantees that the lock is
>>> taken. So it should not matter if its entirely implemented in the Rust
>>> side, somewhere up the call stack, the lock was taken.
>>
>> Sure that might be the case, I am trying to guard against this future
>> problem:
>>
>>       fn soft_reset(driver: &mut Driver) -> Result {
>>           let driver =3D driver
>>           thread::scope(|s| {
>>               let thread_a =3D s.spawn(|| {
>>                   for _ in 0..100_000_000 {
>>                       driver.set_speed(10);
>>                   }
>>               });
>>               let thread_b =3D s.spawn(|| {
>>                   for _ in 0..100_000_000 {
>>                       driver.set_speed(10);
>>                   }
>>               });
>>               thread_a.join();
>>               thread_b.join();
>>           });
>>           Ok(())
>>       }
>>
>> This code spawns two new threads both of which can call `set_speed`,
>> since it takes `&self`. But this leads to a data race, since those
>> accesses are not serialized. I know that this is a very contrived
>> example, but you never when this will become reality, so we should
>> do the right thing now and just use `&mut self`, since that is exactly
>> what it is for.
>=20
> Kernel code is written for the use cases today, don't worry about
> tomorrow, you can fix the issue tomorrow if you change something that
> requires it.

The kind of coding style that (mis)-uses interior mutability is not
something that we can change over night. We should do it properly to
begin with.

> And what "race" are you getting here?  You don't have threads in the
> kernel :)

I chose threads, since I am a lot more familiar with that, but the
kernel also has workqueues which execute stuff concurrently (if I
remember correctly). We also have patches for bindings for the workqueue
so they are not that far away.

> Also, if two things are setting the speed, wonderful, you get some sort
> of value eventually, you have much bigger problems in your code as you
> shouldn't have been doing that in the first place.

This is not allowed in Rust, it is UB and will lead to bad things.

>> Not that we do not even have a way to create threads on the Rust side
>> at the moment.
>=20
> Which is a good thing :)
>=20
>> But we should already be thinking about any possible code pattern.
>=20
> Again, no, deal with what we have today, kernel code is NOT
> future-proof, that's not how we write this stuff.

While I made my argument for future proofing, I think that we
should just be using the standard Rust stuff where it applies.

When you want to modify something, use `&mut T`, if not then use
`&T`. Only deviate from this if you have a good argument.

--=20
Cheers,
Benno


