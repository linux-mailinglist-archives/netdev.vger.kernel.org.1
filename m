Return-Path: <netdev+bounces-41001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D867C954B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EB91C209F9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C2215484;
	Sat, 14 Oct 2023 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edRHmV8N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177E14000;
	Sat, 14 Oct 2023 16:15:07 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2EA9;
	Sat, 14 Oct 2023 09:15:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso77058b3a.0;
        Sat, 14 Oct 2023 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697300104; x=1697904904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ReLwwBtvn/90jTyNwk8GvzhJUbDobklfrzrvvO0Nto=;
        b=edRHmV8NasHpOhugomx5zhxkzRVdZeyGeoQfVuIhRh53tOevcaD0PQ5PK33YRWdHeF
         QxGBY0V1Ro16decBWuwvl2UtJEMbWiqWVDfQU0vdsIaGgr50R9xLitvNcVZek/7cz0Zu
         s5GCAjYlePfPc0dS3K2wHf4OPHP6E1n9CJ1sKPIZS/gDjSCTMxzvFo/1WzGCH569L2XT
         48l10u7wpQG0ouwlXyqruopJqt730O7ZsSc4GVzJpOyEUKiGmP+Isb2DZqEUkTIppLUN
         W+bz3I6tHkLTLlrsa2yyOsj7i7S87i9JyN4QsHYNZaaq+8FkSU8ACwnbZevIGNy0j2pn
         8Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697300104; x=1697904904;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ReLwwBtvn/90jTyNwk8GvzhJUbDobklfrzrvvO0Nto=;
        b=vLtHzmLAm1onn6CwQt2AvKVt5bCriNt3Z/FpLEQLSFnRIvNTLeNrd1lIWQdoVCbW8m
         tgpFmdzO/nAl0nEC7ZXKVod6vqx8z2e3Y6Q1GFyhlpVVzewyjwxcvv7ZW90BXa0Dvjsh
         KxEwqZst90JOJAAj3MGcOi2Duc4RjY4gGzvScxSwQ1s8hYp0GMu/btcxhM934U3lSxS2
         4VexLsLehCXgeZlzYRgwP71Pcj9z8zUesS+hExOq9we+dSCvqvahpz1rpTsqohZIUm8a
         Dnjt1Wk1lLABgAQ5B3F869tdZOboQVjlm9pUffAnkjGGd3Tg+55zfqZW9nUgxE2nhyrH
         1BpA==
X-Gm-Message-State: AOJu0Yx9bg/B5LifNhDWjBb5gAZ3QdONN/2/hoLUmJKxMfmNaYJmiTnQ
	B0+Fg48/wCWweDDIKI0CgFg=
X-Google-Smtp-Source: AGHT+IEkQLsLqkJ5u32m6FH58FNIW33VMRSdFb/Vgn7h4bNV9n1/0QuBSbtBpNWRZTgU62Tvuyy4gA==
X-Received: by 2002:a05:6a00:2e92:b0:692:b3d4:e6c3 with SMTP id fd18-20020a056a002e9200b00692b3d4e6c3mr32661667pfb.0.1697300103820;
        Sat, 14 Oct 2023 09:15:03 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k27-20020aa7999b000000b006bd67a7a7b3sm56030pfh.68.2023.10.14.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 09:15:03 -0700 (PDT)
Date: Sun, 15 Oct 2023 01:15:02 +0900 (JST)
Message-Id: <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
References: <4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
	<20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
	<3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 14 Oct 2023 14:54:30 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 14.10.23 12:32, FUJITA Tomonori wrote:
>> On Sat, 14 Oct 2023 08:07:03 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>> On 14.10.23 09:22, FUJITA Tomonori wrote:
>>>> On Fri, 13 Oct 2023 21:31:16 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>>>>
>>>>> In some other thread you mentioned that no lock is held for
>>>>> `resume`/`suspend`, how does this interact with it?
>>>>
>>>> The same quesiton, 4th time?
>>>
>>> Yes, it is not clear to me from the code/safety comment alone why
>>> this is safe. Please improve the comment such that that is the case.
>>>
>>>> PHYLIB is implemented in a way that PHY drivers exlusively access to
>>>> phy_device during the callbacks.
>>>
>>> As I suggested in a previous thread, it would be extremely helpful
>>> if you add a comment on the `phy` abstractions module that explains
>>> how `PHYLIB` is implemented. Explain that it takes care of locking
>>> and other safety related things.
>> 
>>  From my understanding, the callers of suspend() try to call suspend()
>> for a device only once. They lock a device and get the current state
>> and update the sate, then unlock the device. If the state is a
>> paticular value, then call suspend(). suspend() and resume() are also
>> called where only one thread can access a device.
> 
> Maybe explain this in the docs? In the future, when I will come
> into contact with this again, I will probably have forgotten this
> conversation, but the docs are permanent and can be re-read.

You meant adding this to the code?  like dding this to Device's #
Safety comment?


>> Anyway,
>> 
>> phy_id()
>> state()
>> get_link()
>> is_autoneg_enabled()
>> is_autoneg_completed()
>> 
>> doesn't modify Self.
> 
> yes, these should all be `&self`.
> 
>> The rest modifies then need to be &mut self? Note that function like read_*
>> updates the C data structure.
> 
> What exactly does it update? In Rust there is interior mutability
> which is used to implement mutexes. Interior mutability allows
> you to modify values despite only having a `&T` (for more info
> see [1]). Our `Opaque<T>` type uses this pattern as well (since
> you get a `*mut T` from `&Opaque<T>`) and it is the job of the
> abstraction writer to figure out what mutability to use.
> 
> [1]: https://doc.rust-lang.org/reference/interior-mutability.html
> 
> I have no idea what exactly `read_*` modifies on the C side.
> Mapping C functions to `&self`, `&mut self` and other receiver types
> is not obvious in all cases. I would focus more on the following aspect
> of `&mut self` and `&self`:
> 
> Since `&mut self` is unique, only one thread per instance of `Self`
> can call that function. So use this when the C side would use a lock.
> (or requires that only one thread calls that code)

I guess that the rest are &mut self but let me continue to make sure.

I think that you already know that Device instance only was created in
the callbacks. Before the callbacks are called, PHYLIB holds
phydev->lock except for resume()/suspend(). As explained in the
previous mail, only one thread calls resume()/suspend().

btw, methods in Device calling a C side function like mdiobus_read,
mdiobus_write, etc which never touch phydev->lock. Note that the c
side functions in resume()/suspned() methods don't touch phydev->lock
too.

There are two types how the methods in Device changes the C side data.

1. read/write/read_paged

They call the C side functions, mdiobus_read, mdiobus_write,
phy_read_paged, respectively.

phy_device has a pointer to mii_bus object. It has stats for
read/write. So everytime they are called, stats is updated.

2. the rest

The C side functions in the rest of methods in Device updates some
members in phy_device like set_speed() method does.


> Since multiple `&self` references are allowed to coexist, you should
> use this for functions which perform their own serialization/do not
> require serialization.

just to be sure, the C side guarantees that only one reference exists.


> If you cannot decide what certain function receivers should be, then
> we can help you, but I would need more info on what the C side is doing.

If you need more info on the C side, please let me know.


>>>>>> +/// Defines certain other features this PHY supports (like interrupts).
>>>>>
>>>>> Maybe add a link where these flags can be used.
>>>>
>>>> I already put the link to here in trait Driver.
>>>
>>> I am asking about a link here, as it is a bit confusing when
>>> you just stumble over this flag module here. It doesn't hurt
>>> to link more.
>> 
>> I can't find the code does the similar. What exactly do you expect?
>> Like this?
>> 
>> /// Defines certain other features this PHY supports (like interrupts) for [`Driver`]'s `FLAGS`.
> 
> IIRC you can directly link to the field:
> 
>      [`Driver::FLAGS`]
> 
> Also maybe split the sentence. So one idea would be:
> 
>      /// Defines certain other features this PHY supports (like interrupts).
>      ///
>      /// These flag values are used in [`Driver::FLAGS`].

Thanks, will do.




