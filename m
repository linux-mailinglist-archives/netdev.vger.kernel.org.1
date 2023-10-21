Return-Path: <netdev+bounces-43210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64907D1BB4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF21C20A5A
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D7D278;
	Sat, 21 Oct 2023 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SNfP5092"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6FD26E
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 08:01:25 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCDFA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ykkevadawfaqxisg5zx7hk7smi.protonmail; t=1697875278; x=1698134478;
	bh=mP22JDGD2h5CuyoloxwngO7jOMB/Bob2dii4u95J0yg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SNfP50929aX4msrWmtqEC4uqo1piKvYDrO7FvSCi+oLt5lOmjsifvYqJomF+e88cx
	 ziMDSsRk5KUul9DRhNmjgvOe6Etze6YJ16gSOHDCVuXcLo/zP+VTSUqjSStpyemIEr
	 CcPmY/FKFQ9gPBY3hMnhQLdaoR/+IDiYeyDSc+oyt13oiWbjZJEm4KiJnH2Wld5Jue
	 RJVtUFBIUjxw6Zsk1DFDQdTqhITZKbsJgd4tOR7GNeEE9eqtOtVXmemIrosbW5vSaP
	 15/oTkzGwQM2GUJhqUWS0V9EK2hGkPgmezKK5bRwuD0a8dqv37wubz74qkPARzST47
	 ycsS9cGtQEw4Q==
Date: Sat, 21 Oct 2023 08:01:15 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <d7098404-e34e-4067-8d0e-778922aa15a1@proton.me>
In-Reply-To: <b58e0874-b0d4-4218-a457-4e2e753e0b17@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com> <20231017113014.3492773-2-fujita.tomonori@gmail.com> <de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch> <20231019.094147.1808345526469629486.fujita.tomonori@gmail.com> <64748f96-ac67-492b-89c7-aea859f1d419@proton.me> <b58e0874-b0d4-4218-a457-4e2e753e0b17@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.10.23 21:50, Andrew Lunn wrote:
>> I will try to explain things a bit more.
>>
>> So this case is a bit difficult to figure out, because what is
>> going on is not really a pattern that is used in Rust.
>=20
> It is however a reasonably common pattern in the kernel. It stems from
> driver writers often don't understand locking. So the core does the
> locking, leaving the driver writers to just handle the problems of the
> hardware.

I have seen this pattern the first time here, I am sure more experienced
members such as Miguel and Wedson have seen it before.

I am not saying that it is incompatible with Rust, just that it
wouldn't be done like this if it were purely Rust.

> Rust maybe makes locking more of a visible issue, but if driver
> writers don't understand locking, the language itself does not make
> much difference.

I think Rust will make a big difference:
- you cannot access data protected by a lock without locking the
   lock beforehand.
- you cannot forget to unlock a lock.

>> We already have exclusive access to the `phy_device`, so in Rust
>> you would not need to lock anything to also have exclusive access to the
>> embedded `mii_bus`.
>=20
> I would actually say its not the PHY drivers problem at all. The
> mii_bus is a property of the MDIO layers, and it is the MDIO layers
> problem to impose whatever locking it needs for its properties.

Since the MDIO layer would provide its own serialization, in Rust
we would not protect the `mdio_device` with a lock. In this case
it could just be a coincidence that both locks are locked, since
IIUC `phy_device` is locked whenever callbacks are called.

> Also, mii_bus is not embedded. Its a pointer to an mii_bus. The phy
> lock protects the pointer. But its the MDIO layer which needs to
> protect what the pointer points to.

Oh I overlooked the `*`. Then it depends what type of pointer that is,
is the `mii_bus` unique or is it shared? If it is shared, then Rust
would also need another lock there.

--=20
Cheers,
Benno



