Return-Path: <netdev+bounces-43209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE537D1B87
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90050B21578
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC06D277;
	Sat, 21 Oct 2023 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hMs7tNUT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512915D5
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:36:56 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D11BF
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697873809; x=1698133009;
	bh=EdGsrPs7LWKFDvtCCqzl26z36cN2vAEHn1kSpG58bWs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hMs7tNUTZQtsCOgwF7OLIGjPxfk3DZRnncKk0kK9P+DyfTIqfmhyqni6AfTe8RzB+
	 ADwGEPIxzX2e8Dvj0j2y1vNXLFr8DDeoQRKUCVkwzRfOxwthCClH3O36EXstWWCPFs
	 li6w6DRtf9cUp/ok1orsL05JrXX61leu98cE7RP2iWLHYFkAxR40cuBtiPbfLZdPu6
	 mN95IZVuxy8ru+1YMZfSLQU3UzxcEL4FydPmV9HlMK1iH1djxQPdF+3gUHKZUy6ree
	 DIcjfYZGyQUDcP325j9tsBjCx/so8C7WDqlzkrvxL+0Tp2htt20+e6QxZOBVgrmyRG
	 yPmsB6Bh/3gyg==
Date: Sat, 21 Oct 2023 07:36:31 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <120631ca-3da3-441c-9536-43ee9dbe3b01@proton.me>
In-Reply-To: <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com> <20231017113014.3492773-2-fujita.tomonori@gmail.com> <e361ef91-607d-400b-a721-f846c21e2400@proton.me> <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.10.23 20:42, Andrew Lunn wrote:
>>> +//! All the PHYLIB helper functions for `phy_device` modify some membe=
rs in `phy_device`. Except for
>>> +//! getter functions, [`Device`] methods take `&mut self`. This also a=
pplied to `read()`, which reads
>>> +//! a hardware register and updates the stats.
>>
>> I would use [`Device`] instead of `phy_device`, since the Rust reader
>> might not be aware what wraps `phy_device`.
>=20
> We don't want to hide phy_device too much, since at the moment, the
> abstraction is very minimal. Anybody writing a driver is going to need
> a good understanding of the C code in order to find the helpers they
> need, and then add them to the abstraction. So i would say we need to
> explain the relationship between the C structure and the Rust
> structure, to aid developers.

There is a comment on `Device` that explains that it wraps `phy_device`.
Since [`Device`] is a link, readers who do not know what it means can
immediately click the link and find out. This is not possible with
`phy_device`, since you have to search the web for it, so I would
prefer to use the link.

>>> +    /// Returns true if the link is up.
>>> +    pub fn get_link(&self) -> bool {
>>
>> I still think this name should be changed. My response at [1] has not ye=
t
>> been replied to. This has already been discussed before:
>> - https://lore.kernel.org/rust-for-linux/2023100237-satirical-prance-bd5=
7@gregkh/
>> - https://lore.kernel.org/rust-for-linux/20231004.084644.507845339593987=
55.fujita.tomonori@gmail.com/
>> - https://lore.kernel.org/rust-for-linux/CALNs47syMxiZBUwKLk3vKxzmCbX0FS=
5A37FjwUzZO9Fn-iPaoA@mail.gmail.com/
>>
>> And I want to suggest to change it to `is_link_up`.
>>
>> Reasons why I do not like the name:
>> - `get_`/`put_` are used for ref counting on the C side, I would like to
>>     avoid confusion.
>> - `get` in Rust is often used to fetch a value from e.g. a datastructure
>>     such as a hashmap, so I expect the call to do some computation.
>> - getters in Rust usually are not prefixed with `get_`, but rather are
>>     just the name of the field.
>> - in this case I like the name `is_link_up` much better, since code beco=
mes
>>     a lot more readable with that.
>> - I do not want this pattern as an example for other drivers.
>>
>> [1]: https://lore.kernel.org/rust-for-linux/f5878806-5ba2-d932-858d-dda3=
f55ceb67@proton.me/
>>
>>> +        const LINK_IS_UP: u32 =3D 1;
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        let phydev =3D unsafe { *self.0.get() };
>>> +        phydev.link() =3D=3D LINK_IS_UP
>>> +    }
>=20
> During the reviews we have had a lot of misunderstanding what this
> actually does, given its name. Some thought it poked around in
> registers to get the current state of the link. Some thought it
> triggered the PHY to establish a link. When in fact its just a dumb
> getter. And we have a few other dumb getters and setters.

IMO `is_link_up` would indicate that it is a dumb getter.

> So i would prefer something which indicates its a dumb getter. If the
> norm of Rust is just the field name, lets just use the field name. But
> we should do that for all the getters and setters. Is there a naming
> convention for things which take real actions?

For bool getters it would be the norm to use `is_` as the prefix, see
[1]. In this case I would say it is also natural to not use `is_link`,
but rather `is_link_up`, since the former sounds weird.

[1]: https://doc.rust-lang.org/std/?search=3Dis_

> And maybe we need to add a comment: Get the current link state, as
> stored in the [`Device`]. Set the duplex value in [`Device`], etc.

Sure, we can document dumb getters explicitly, I would prefer to do:
Getter for the current link state. Setter for the duplex value.

I don't think that we need to link to `Device`, since the functions
are defined on that type.

--=20
Cheers,
Benno



