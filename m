Return-Path: <netdev+bounces-41010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748157C9590
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A321C281A7D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD81A289;
	Sat, 14 Oct 2023 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TLMxKNc1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C61C37;
	Sat, 14 Oct 2023 17:07:27 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67ECB7;
	Sat, 14 Oct 2023 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697303242; x=1697562442;
	bh=ZR21X9J3jEWPSpUV4O8rXiY6YshMjO/0/WphT8SqxWQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TLMxKNc1T8D0JiRv5DapCcC6yic5gPlRBudZdk0HbDteQn4i76J1PVaa+R1tLddX+
	 PhO8Mggu1lJ1s3atVZJRzOVTo1ZNfghL2EuWGdU1RD1xYjaqZmPU24EK1LewTO1ar9
	 sOrsKiWdG7sUA9dNlC49B/UUk/vqTjaglvtrush4ILvczKktRHPkFSCCtM2Cs1wruc
	 UhxW9Bqp2ILPoLUPIgt9Ch1+Mlwqngv49MiocbHQKshA+nvgaA3bLcDObFrioimXgf
	 L0meWIs3OtrMVy39/yUv7ti0x5C6NdbGRbusvZPgxgGr8IWyyQAEjsOb15Bt5njFlm
	 ZvS5HK4Sp9DHQ==
Date: Sat, 14 Oct 2023 17:07:09 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
In-Reply-To: <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
References: <4791a460-09e0-4478-8f38-ae371e37416b@proton.me> <20231014.193231.787565106108242584.fujita.tomonori@gmail.com> <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me> <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
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

On 14.10.23 18:15, FUJITA Tomonori wrote:
> On Sat, 14 Oct 2023 14:54:30 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 14.10.23 12:32, FUJITA Tomonori wrote:
>>> On Sat, 14 Oct 2023 08:07:03 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> On 14.10.23 09:22, FUJITA Tomonori wrote:
>>>>> On Fri, 13 Oct 2023 21:31:16 +0000
>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>> +    /// the exclusive access for the duration of the lifetime `'a`=
.
>>>>>>
>>>>>> In some other thread you mentioned that no lock is held for
>>>>>> `resume`/`suspend`, how does this interact with it?
>>>>>
>>>>> The same quesiton, 4th time?
>>>>
>>>> Yes, it is not clear to me from the code/safety comment alone why
>>>> this is safe. Please improve the comment such that that is the case.
>>>>
>>>>> PHYLIB is implemented in a way that PHY drivers exlusively access to
>>>>> phy_device during the callbacks.
>>>>
>>>> As I suggested in a previous thread, it would be extremely helpful
>>>> if you add a comment on the `phy` abstractions module that explains
>>>> how `PHYLIB` is implemented. Explain that it takes care of locking
>>>> and other safety related things.
>>>
>>>   From my understanding, the callers of suspend() try to call suspend()
>>> for a device only once. They lock a device and get the current state
>>> and update the sate, then unlock the device. If the state is a
>>> paticular value, then call suspend(). suspend() and resume() are also
>>> called where only one thread can access a device.
>>
>> Maybe explain this in the docs? In the future, when I will come
>> into contact with this again, I will probably have forgotten this
>> conversation, but the docs are permanent and can be re-read.
>=20
> You meant adding this to the code?  like dding this to Device's #
> Safety comment?

I would not put it in the `# Safety` section. Instead, put this
information on the phy module itself (the `//!` comments at the very
top of the file). I also would suggest to not take the above paragraph
word by word, but to improve and extend it.

>>> Anyway,
>>>
>>> phy_id()
>>> state()
>>> get_link()
>>> is_autoneg_enabled()
>>> is_autoneg_completed()
>>>
>>> doesn't modify Self.
>>
>> yes, these should all be `&self`.
>>
>>> The rest modifies then need to be &mut self? Note that function like re=
ad_*
>>> updates the C data structure.
>>
>> What exactly does it update? In Rust there is interior mutability
>> which is used to implement mutexes. Interior mutability allows
>> you to modify values despite only having a `&T` (for more info
>> see [1]). Our `Opaque<T>` type uses this pattern as well (since
>> you get a `*mut T` from `&Opaque<T>`) and it is the job of the
>> abstraction writer to figure out what mutability to use.
>>
>> [1]: https://doc.rust-lang.org/reference/interior-mutability.html
>>
>> I have no idea what exactly `read_*` modifies on the C side.
>> Mapping C functions to `&self`, `&mut self` and other receiver types
>> is not obvious in all cases. I would focus more on the following aspect
>> of `&mut self` and `&self`:
>>
>> Since `&mut self` is unique, only one thread per instance of `Self`
>> can call that function. So use this when the C side would use a lock.
>> (or requires that only one thread calls that code)
>=20
> I guess that the rest are &mut self but let me continue to make sure.
>=20
> I think that you already know that Device instance only was created in
> the callbacks. Before the callbacks are called, PHYLIB holds
> phydev->lock except for resume()/suspend(). As explained in the
> previous mail, only one thread calls resume()/suspend().

The information in this paragraph would also fit nicely into the
phy module docs.

> btw, methods in Device calling a C side function like mdiobus_read,
> mdiobus_write, etc which never touch phydev->lock. Note that the c
> side functions in resume()/suspned() methods don't touch phydev->lock
> too.
>=20
> There are two types how the methods in Device changes the C side data.
>=20
> 1. read/write/read_paged
>=20
> They call the C side functions, mdiobus_read, mdiobus_write,
> phy_read_paged, respectively.
>=20
> phy_device has a pointer to mii_bus object. It has stats for
> read/write. So everytime they are called, stats is updated.

I think for reading & updating some stats using `&self`
should be fine. `write` should probably be `&mut self`.

> 2. the rest
>=20
> The C side functions in the rest of methods in Device updates some
> members in phy_device like set_speed() method does.

Those setter functions should be `&mut self`.

>> Since multiple `&self` references are allowed to coexist, you should
>> use this for functions which perform their own serialization/do not
>> require serialization.
>=20
> just to be sure, the C side guarantees that only one reference exists.

I see, then the `from_raw` function should definitely return
a `&mut Device`. Note that you can still call `&T` functions
when you have a `&mut T`.

>> If you cannot decide what certain function receivers should be, then
>> we can help you, but I would need more info on what the C side is doing.
>=20
> If you need more info on the C side, please let me know.

What about these functions?
- resolve_aneg_linkmode
- genphy_soft_reset
- init_hw
- start_aneg
- genphy_read_status
- genphy_update_link
- genphy_read_lpa
- genphy_read_abilities

--=20
Cheers,
Benno



