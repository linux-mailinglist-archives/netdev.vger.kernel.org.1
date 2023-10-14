Return-Path: <netdev+bounces-40998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC57C9513
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333CC2821B7
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF012B85;
	Sat, 14 Oct 2023 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fZV7pCx/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830E1C37;
	Sat, 14 Oct 2023 14:54:42 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83BBCA;
	Sat, 14 Oct 2023 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=aapgcoreyve7viqas4we2bfzem.protonmail; t=1697295277; x=1697554477;
	bh=XXNmtZQfD1GZlm+M68oqWPkuIinrZT4vMVVECOA0CwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fZV7pCx/nRHzDSlA5snca/pM9VrOLzj76YNBykf34BZ1DnvvR2D/WL20/WS0mm4E7
	 D18Yw2FqkAQNl6FA1BjS2L2KFT79+Q5fP2sSi7TdWpApOWnEAyqpYGQAbDNYTwl1MQ
	 ki66jYG54Bdl/N5SE9sGPBZZOTeOD7jWShjJ5UDjsQjU1G0xriLqlV0viR+FwqiIzn
	 H8N7+obzwkXv0UxqVxcG7eSEn4yOOD4std1TD/gDkqgInC1trTMQ4C66g7fDzn8EJy
	 QdWrkb3kq3QivxqS/SmzMDJysuDfleUfWbeur4TpRKE3FXeEm4xzR+kRq3ws6sFGN4
	 I1rvpICRTW/SA==
Date: Sat, 14 Oct 2023 14:54:30 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
In-Reply-To: <20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
References: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me> <20231014.162210.522439670437191285.fujita.tomonori@gmail.com> <4791a460-09e0-4478-8f38-ae371e37416b@proton.me> <20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
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

On 14.10.23 12:32, FUJITA Tomonori wrote:
> On Sat, 14 Oct 2023 08:07:03 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 14.10.23 09:22, FUJITA Tomonori wrote:
>>> On Fri, 13 Oct 2023 21:31:16 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>>>
>>>> In some other thread you mentioned that no lock is held for
>>>> `resume`/`suspend`, how does this interact with it?
>>>
>>> The same quesiton, 4th time?
>>
>> Yes, it is not clear to me from the code/safety comment alone why
>> this is safe. Please improve the comment such that that is the case.
>>
>>> PHYLIB is implemented in a way that PHY drivers exlusively access to
>>> phy_device during the callbacks.
>>
>> As I suggested in a previous thread, it would be extremely helpful
>> if you add a comment on the `phy` abstractions module that explains
>> how `PHYLIB` is implemented. Explain that it takes care of locking
>> and other safety related things.
>=20
>  From my understanding, the callers of suspend() try to call suspend()
> for a device only once. They lock a device and get the current state
> and update the sate, then unlock the device. If the state is a
> paticular value, then call suspend(). suspend() and resume() are also
> called where only one thread can access a device.

Maybe explain this in the docs? In the future, when I will come
into contact with this again, I will probably have forgotten this
conversation, but the docs are permanent and can be re-read.

>>>>> +    /// Returns true if auto-negotiation is completed.
>>>>> +    pub fn is_autoneg_completed(&self) -> bool {
>>>>> +        const AUTONEG_COMPLETED: u32 =3D 1;
>>>>> +        // SAFETY: `phydev` is pointing to a valid object by the typ=
e invariant of `Self`.
>>>>> +        let phydev =3D unsafe { *self.0.get() };
>>>>> +        phydev.autoneg_complete() =3D=3D AUTONEG_COMPLETED
>>>>> +    }
>>>>> +
>>>>> +    /// Sets the speed of the PHY.
>>>>> +    pub fn set_speed(&self, speed: u32) {
>>>>
>>>> This function modifies state, but is `&self`?
>>>
>>> Boqun asked me to drop mut on v3 review and then you ask why on v4?
>>> Trying to find a way to discourage developpers to write Rust
>>> abstractions? :)
>>>
>>> I would recommend the Rust reviewers to make sure that such would
>>> not happen. I really appreciate comments but inconsistent reviewing is
>>> painful.
>>
>> I agree with Boqun. Before Boqun's suggestion all functions were
>> `&mut self`. Now all functions are `&self`. Both are incorrect. A
>> function that takes `&mut self` can modify the state of `Self`,
>> but it is weird for it to not modify anything at all. Such a
>> function also can only be called by a single thread (per instance
>> of `Self`) at a time. Functions with `&self` cannot modify the
>> state of `Self`, except of course with interior mutability. If
>> they do modify state with interior mutability, then they should
>> have a good reason to do that.
>>
>> What I want you to do here is think about which functions should
>> be `&mut self` and which should be `&self`, since clearly just
>> one or the other is wrong here.
>=20
> https://lore.kernel.org/netdev/20231011.231607.1747074555988728415.fujita=
.tomonori@gmail.com/T/#mb7d219b2e17d3f3e31a0d05697d91eb8205c5c6e
>=20
> Hmm, I undertood that he suggested all mut.

That remark seems to me to only apply to the return type of
`assume_locked` in that thread.

> Anyway,
>=20
> phy_id()
> state()
> get_link()
> is_autoneg_enabled()
> is_autoneg_completed()
>=20
> doesn't modify Self.

yes, these should all be `&self`.

> The rest modifies then need to be &mut self? Note that function like read=
_*
> updates the C data structure.

What exactly does it update? In Rust there is interior mutability
which is used to implement mutexes. Interior mutability allows
you to modify values despite only having a `&T` (for more info
see [1]). Our `Opaque<T>` type uses this pattern as well (since
you get a `*mut T` from `&Opaque<T>`) and it is the job of the
abstraction writer to figure out what mutability to use.

[1]: https://doc.rust-lang.org/reference/interior-mutability.html

I have no idea what exactly `read_*` modifies on the C side.
Mapping C functions to `&self`, `&mut self` and other receiver types
is not obvious in all cases. I would focus more on the following aspect
of `&mut self` and `&self`:

Since `&mut self` is unique, only one thread per instance of `Self`
can call that function. So use this when the C side would use a lock.
(or requires that only one thread calls that code)

Since multiple `&self` references are allowed to coexist, you should
use this for functions which perform their own serialization/do not
require serialization.

If you cannot decide what certain function receivers should be, then
we can help you, but I would need more info on what the C side is doing.

>>>>> +        let phydev =3D self.0.get();
>>>>> +        // SAFETY: `phydev` is pointing to a valid object by the typ=
e invariant of `Self`.
>>>>> +        // So an FFI call with a valid pointer.
>>>>> +        let ret =3D unsafe { bindings::phy_read_paged(phydev, page.i=
nto(), regnum.into()) };
>>>>> +        if ret < 0 {
>>>>> +            Err(Error::from_errno(ret))
>>>>> +        } else {
>>>>> +            Ok(ret as u16)
>>>>> +        }
>>>>> +    }
>>>>
>>>> [...]
>>>>
>>>>> +}
>>>>> +
>>>>> +/// Defines certain other features this PHY supports (like interrupt=
s).
>>>>
>>>> Maybe add a link where these flags can be used.
>>>
>>> I already put the link to here in trait Driver.
>>
>> I am asking about a link here, as it is a bit confusing when
>> you just stumble over this flag module here. It doesn't hurt
>> to link more.
>=20
> I can't find the code does the similar. What exactly do you expect?
> Like this?
>=20
> /// Defines certain other features this PHY supports (like interrupts) fo=
r [`Driver`]'s `FLAGS`.

IIRC you can directly link to the field:

     [`Driver::FLAGS`]

Also maybe split the sentence. So one idea would be:

     /// Defines certain other features this PHY supports (like interrupts)=
.
     ///
     /// These flag values are used in [`Driver::FLAGS`].

--=20
Cheers,
Benno



