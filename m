Return-Path: <netdev+bounces-44109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665A57D6493
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9337B210F2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93C1C6B1;
	Wed, 25 Oct 2023 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hOOB0OVS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D22D612;
	Wed, 25 Oct 2023 08:09:10 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E3B0;
	Wed, 25 Oct 2023 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pbiatbmtjvehtemhxk6v3pvs3m.protonmail; t=1698221346; x=1698480546;
	bh=8lAwT9IHW6GkNLF5ITp7gMY3w5vgVitDmLaNquf5Xnk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hOOB0OVSpOrvydemWzMc2ruLKIPw4f27/Mo63sMBE/5vrG+Q7wAHhypyq8R19jI93
	 ZQnFdz3MaFgJGbUhmOzviq+7yOefOHHJmwR8TmzjB3zjdh4vL+s4cWx+BNpnbTusdr
	 hY0MsqhEkJ+0yaMDeXf9BkwMqZXkPvZTPjv8c+TddKeqt0KhYPNySk4uL4iDYGky8V
	 vARqkNMfGavFeLUFJK0oUrEqIOARkeJE3wq4bOtZDj8WkLC7txedmPun+y6mND2hLu
	 FJS2rlGjdjWNy4EFyICnbN7geC0xgA1wlo5QB0nK/WZbKEmp0wTU5luefvXdPy5F4e
	 sxzmt0SF7BtAg==
Date: Wed, 25 Oct 2023 08:08:53 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver macro
Message-ID: <04c4c645-d70c-41b2-9ff6-e5784dc84785@proton.me>
In-Reply-To: <20231025.165710.1134967889825495180.fujita.tomonori@gmail.com>
References: <ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me> <20231025.090243.1437967503809186729.fujita.tomonori@gmail.com> <42eeb38d-6d24-4c56-8ffd-27c48405cae9@proton.me> <20231025.165710.1134967889825495180.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.10.23 09:57, FUJITA Tomonori wrote:
> On Wed, 25 Oct 2023 07:29:32 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 25.10.23 02:02, FUJITA Tomonori wrote:
>>> On Tue, 24 Oct 2023 16:28:02 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> On 24.10.23 02:58, FUJITA Tomonori wrote:
>>>>> This macro creates an array of kernel's `struct phy_driver` and
>>>>> registers it. This also corresponds to the kernel's
>>>>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>>>>> loading into the module binary file.
>>>>>
>>>>> A PHY driver should use this macro.
>>>>>
>>>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>>>> ---
>>>>>     rust/kernel/net/phy.rs | 129 ++++++++++++++++++++++++++++++++++++=
+++++
>>>>>     1 file changed, 129 insertions(+)
>>>>>
>>>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>>>> index 2d821c2475e1..f346b2b4d3cb 100644
>>>>> --- a/rust/kernel/net/phy.rs
>>>>> +++ b/rust/kernel/net/phy.rs
>>>>> @@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
>>>>>             }
>>>>>         }
>>>>>     }
>>>>> +
>>>>> +/// Declares a kernel module for PHYs drivers.
>>>>> +///
>>>>> +/// This creates a static array of kernel's `struct phy_driver` and =
registers it.
>>>>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macr=
o, which embeds the information
>>>>> +/// for module loading into the module binary file. Every driver nee=
ds an entry in `device_table`.
>>>>> +///
>>>>> +/// # Examples
>>>>> +///
>>>>> +/// ```ignore
>>>>
>>>> Is this example ignored, because it does not compile?
>>>
>>> The old version can't be compiled but the current version can so I'll
>>> drop ignore.
>>>
>>>
>>>> I think Wedson was wrapping his example with `module!` inside
>>>> of a module, so maybe try that?
>>>
>>> I'm not sure what you mean.
>>
>> Wedson did this [1], note the `# mod module_fs_sample`:
>>
>> /// # Examples
>> ///
>> /// ```
>> /// # mod module_fs_sample {
>> /// use kernel::prelude::*;
>> /// use kernel::{c_str, fs};
>> ///
>> /// kernel::module_fs! {
>> ///     type: MyFs,
>> ///     name: "myfs",
>> ///     author: "Rust for Linux Contributors",
>> ///     description: "My Rust fs",
>> ///     license: "GPL",
>> /// }
>> ///
>> /// struct MyFs;
>> /// impl fs::FileSystem for MyFs {
>> ///     const NAME: &'static CStr =3D c_str!("myfs");
>> /// }
>> /// # }
>> /// ```
>>
>> [1]: https://github.com/wedsonaf/linux/commit/e909f439481cf6a3df00c7064b=
0d64cee8630fe9#diff-9b893393ed2a537222d79f6e2fceffb7e9d8967791c2016962be317=
1c446210fR104-R124
>=20
> You are suggesting like the following?
>=20
> /// # Examples
> ///
> /// ```
> /// # mod module_phy_driver_sample {
> ...
> /// # }
> /// ```
>=20
> What benefits?

IIRC Wedson mentioned that without that it did not compile. So
if it compiles for you without it, I would not add it.

--=20
Cheers,
Benno



