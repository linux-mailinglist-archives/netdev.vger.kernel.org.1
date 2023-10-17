Return-Path: <netdev+bounces-41715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAB7CBBFF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0AD28195C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ADE1799D;
	Tue, 17 Oct 2023 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="an3awQH8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4B15AF6;
	Tue, 17 Oct 2023 07:06:50 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98898FA;
	Tue, 17 Oct 2023 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=d5oaf4mv5zdbxedkqx2nwkv43a.protonmail; t=1697526404; x=1697785604;
	bh=XqkBEpi4mNdgMi3RMiTEutxr7PRCospT+z+f6hHfMM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=an3awQH8zowz5K7/zRx11FJxa/mAPvbJW8v0idbiRDz75IwAFRhZvmVbiP7ocTBsc
	 x+JXhA5qVK/jdfRzO/28l53sf5cHlCO8nXewBrCWBGYhHLzIwJSivAT0/FmC1MHmep
	 6Cl2W2TczlORZJzfQTdR932FHdk2VtAPkMbFyPmDoAmzF6eo5pRr21hrXd3vf4lQ+s
	 MrJqKNVHRen59s3PHoCDCKpEKjlmISz896ncb7wuW5RlZd8kR7MlZr87ixRrrmzAf3
	 xMgsGgn5ZRy2aDdGBJHhXNmWOUJrTzDryJgM3TJYyO/dPW7mi19o+vBLEfN049i6u+
	 MyjerMF+qmUXg==
Date: Tue, 17 Oct 2023 07:06:38 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
In-Reply-To: <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me> <20231015.011502.276144165010584249.fujita.tomonori@gmail.com> <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
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

On 15.10.23 00:39, FUJITA Tomonori wrote:
> On Sat, 14 Oct 2023 17:07:09 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>>> btw, methods in Device calling a C side function like mdiobus_read,
>>> mdiobus_write, etc which never touch phydev->lock. Note that the c
>>> side functions in resume()/suspned() methods don't touch phydev->lock
>>> too.
>>>
>>> There are two types how the methods in Device changes the C side data.
>>>
>>> 1. read/write/read_paged
>>>
>>> They call the C side functions, mdiobus_read, mdiobus_write,
>>> phy_read_paged, respectively.
>>>
>>> phy_device has a pointer to mii_bus object. It has stats for
>>> read/write. So everytime they are called, stats is updated.
>>
>> I think for reading & updating some stats using `&self`
>> should be fine. `write` should probably be `&mut self`.
>=20
> Can you tell me why exactly you think in that way?
>=20
> Firstly, you think that reading & updating some stats using `&self` shoul=
d be fine.
>=20
> What's the difference between read() and set_speed(), which you think, ne=
eds &mut self.
>=20
> Because set_speed() updates the member in phy_device and read()
> updates the object that phy_device points to?

`set_speed` is entirely implemented on the Rust side and is not protected
by a lock. Since data races in Rust are UB, this function must be `&mut`,
in order to guarantee that no data races occur. This is the case, because
our `Opaque` forces you to use interior mutability and thus sidestep this
rule (modifying through a `&T`).

>=20
>=20
> Secondly, What's the difference between read() and write(), where you
> think that read() is &self write() is &mut self.

This is just the standard Rust way of using mutability. For reading one
uses `&self` and for writing `&mut self`. The only thing that is special
here is the stats that are updated. But I thought that it still could fit
Rust by the following pattern:
```rust
     pub struct TrackingReader {
         buf: [u8; 64],
         num_of_reads: Mutex<usize>,
     }

     impl TrackingReader {
         pub fn read(&self, idx: usize) -> u8 {
             *self.num_of_reads.lock() +=3D 1;
             self.buf[idx]
         }
     }

```

And after taking a look at `mdiobus_read` I indeed found a mutex.

> read() is reading from hardware register. write() is writing a value
> to hardware register. Both updates the object that phy_device points
> to?

Indeed, I was just going with the standard way of suggesting `&self`
for reads, there are of course exceptions where `&mut self` would make
sense. That being said in this case both options are sound, since
the C side locks a mutex.

>>>> Since multiple `&self` references are allowed to coexist, you should
>>>> use this for functions which perform their own serialization/do not
>>>> require serialization.
>>>
>>> just to be sure, the C side guarantees that only one reference exists.
>>
>> I see, then the `from_raw` function should definitely return
>> a `&mut Device`. Note that you can still call `&T` functions
>> when you have a `&mut T`.
>=20
> It already returns &mut Device so no change is necessary here, right?

Yes it already is correct.

> unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self
> {
>=20
> If you want more additional comment on from_raw(), please let me know.
>=20
>=20
>>>> If you cannot decide what certain function receivers should be, then
>>>> we can help you, but I would need more info on what the C side is doin=
g.
>>>
>>> If you need more info on the C side, please let me know.
>>
>> What about these functions?
>> - resolve_aneg_linkmode
>> - genphy_soft_reset
>> - init_hw
>> - start_aneg
>> - genphy_read_status
>> - genphy_update_link
>> - genphy_read_lpa
>> - genphy_read_abilities
>=20
> As Andrew replied, all the functions update some member in phy_device.

Do all of these functions lock the `bus->mdio_lock`? If yes, then you
can just treat them like `read` or `write` (both `&self` and `&mut self`
will be sound) and use the standard Rust way of setting the mutability.
So if it changes some internal state, I would go with `&mut self`.

--=20
Cheers,
Benno



