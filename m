Return-Path: <netdev+bounces-39112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305F7BE1F3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FB31C2084A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA4F347BC;
	Mon,  9 Oct 2023 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gaLin2YS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC0341A4;
	Mon,  9 Oct 2023 13:57:15 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE67D8;
	Mon,  9 Oct 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1696859832; x=1697119032;
	bh=FwSGHcrVnSSYolYJQcNNUOZ78iLldMRaS9quJsHI12o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gaLin2YScPe+VHS37wm8ClKR2fuMw6e8cGbYdvwsmMwCWGMxwxmywjtFEzgBJghjr
	 byaqTKLv5v/fXjj8p1lqxMT17N+BVmOjal1hUwQCmg2LVNd40tTULU2d+eJINth0th
	 cmDAYc4a/0pRbpvJeoU8MM8MyJM0WMc/m14KaK6vzj86Zvt43uu52YEITuEB4NQJvZ
	 arF1Ro9e4+4tw6SBye2nbPKdm5v5Ds4KtYOQPVT15amr4gHOhATxs/hoEcXDyDnx04
	 MAgLj3aligWdyjvNxcQKgL/9I4sU5xZOFhPWhWgQMV93DI82i5Sw6gkns1+3hD6xed
	 eFCVBGyr/UUTA==
Date: Mon, 09 Oct 2023 13:56:58 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <f5878806-5ba2-d932-858d-dda3f55ceb67@proton.me>
In-Reply-To: <4ced711a-009c-4e57-a758-1d13d97e18d2@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-2-fujita.tomonori@gmail.com> <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me> <4ced711a-009c-4e57-a758-1d13d97e18d2@lunn.ch>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09.10.23 15:02, Andrew Lunn wrote:
> On Mon, Oct 09, 2023 at 12:19:54PM +0000, Benno Lossin wrote:
>>> +impl Device {
>>> +    /// Creates a new [`Device`] instance from a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// For the duration of the lifetime 'a, the pointer must be valid=
 for writing and nobody else
>>> +    /// may read or write to the `phy_device` object.
>>> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a =
mut Self {
>>> +        unsafe { &mut *ptr.cast() }
>>
>> Missing `SAFETY` comment.
>=20
> Hi Benno
>=20
> It is normal on Linux kernel mailing lists to trim the text to what is
> just relevant to the reply. Comments don't get lost that way.

Sure, I will keep it in mind.

>=20
>>> +    /// Returns true if the link is up.
>>> +    pub fn get_link(&mut self) -> bool {
>>
>> I would call this function `is_link_up`.
>=20
> Please read the discussion on the previous versions of this patch. If
> you still want to change the name, please give a justification.

As Fujita wrote in [1], `get_foo` is not really common in Rust.
And here it seems weird to, since the return type is a bool. To
me `get_foo` means "fetch me a foo" and that is not what this
function is doing. Also given the documentation explicitly states
"Returns true if the link is up", I think that `is_link_up` or similar
fits very well.

>>> +    /// Reads a given C22 PHY register.
>>> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
>>> +        let phydev =3D self.0.get();
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type =
invariant of `Self`.
>>> +        // So an FFI call with a valid pointer.
>>> +        let ret =3D unsafe {
>>> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.=
addr, regnum.into())
>>> +        };
>>
>> Just a general question, all of these unsafe calls do not have
>> additional requirements? So aside from the pointers being
>> valid, there are no timing/locking/other safety requirements
>> for calling the functions?
>=20
> Locking has been discussed a number of times already. What do you mean
> by timing?

A few different things:
- atomic/raw atomic context
- another function has to be called prior

I have limited knowledge of the C side and have cannot sift through
the C code for every `unsafe` function call. Just wanted to ensure
that someone has checked that these safety requirements are exhaustive.

>>> +macro_rules! module_phy_driver {
>>> +    (@replace_expr $_t:tt $sub:expr) =3D> {$sub};
>>> +
>>> +    (@count_devices $($x:expr),*) =3D> {
>>> +        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize)=
)*
>>> +    };
>>> +
>>> +    (@device_table [$($dev:expr),+]) =3D> {
>>> +        #[no_mangle]
>>> +        static __mod_mdio__phydev_device_table: [
>>
>> Shouldn't this have a unique name? If we define two different
>> phy drivers with this macro we would have a symbol collision?
>=20
> I assume these are the equivalent of C static. It is not visible
> outside the scope of this object file. The kernel has lots of tables
> and they are mostly of very limited visibility scope, because only the
> method registering/unregistering the table needs to see it.
The `#[no_mangle]` attribute in Rust disables standard symbol name
mangling, see [2]. So if this macro is invoked twice, it will result
in a compile error.

[1]: https://lore.kernel.org/rust-for-linux/20231004.084644.507845339593987=
55.fujita.tomonori@gmail.com/
[2]: https://doc.rust-lang.org/reference/abi.html#the-no_mangle-attribute

--
Cheers,
Benno


