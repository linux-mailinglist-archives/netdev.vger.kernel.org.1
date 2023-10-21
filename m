Return-Path: <netdev+bounces-43240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959EA7D1D32
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D52810AE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B45D284;
	Sat, 21 Oct 2023 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ETuzSGBK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B310F4;
	Sat, 21 Oct 2023 13:06:15 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61843D63;
	Sat, 21 Oct 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697893567; x=1698152767;
	bh=ky5vuudROl9mBaFjtQ2wP9XGF0JvQa4QEu594/a8Q98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ETuzSGBKtXvjj09UrA4oYX0oc6cJ2dcH8YzvpafWmRNDfigOsKQucHnmRRhK5bU0C
	 NabYDj1+LNYuE/NrvhBnqUKfoyD60bXUIUDe+117ckgG6pj6Le9QF8uuEmaVZG8cm9
	 lAyEXpT4na+03AdlGwHqoXQUGv9COAjDyT0EPhcc+0zE//JRt9FARLd4SVXeLyPwme
	 M+E1XI6Gq1ps508OBjAcujcFBGhZJKJdvd3na0P0komipcf/zVjmuqLTYJROfF5kI+
	 fT8Qlwr83FAsOIqJI5ITZtY0KScu3lznT1b66eLXLFPifOS0UqLpQ+1r6//H9Ez0l8
	 k+3SWBuEeFsow==
Date: Sat, 21 Oct 2023 13:05:59 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>
In-Reply-To: <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com>
References: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me> <20231021.213834.76499402455687702.fujita.tomonori@gmail.com> <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me> <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 15:00, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 12:50:10 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>> I think this is very weird, do you have any idea why this
>>>>>> could happen?
>>>>>
>>>>> DriverVtable is created on kernel stack, I guess.
>>>>
>>>> But how does that invalidate the function pointers?
>>>
>>> Not only funciton pointers. You can't store something on stack for
>>> later use.
>>
>> It is not stored on the stack, it is only created on the stack and
>> moved to a global static later on. The `module!` macro creates a
>> `static mut __MOD: Option<Module>` where the module data is stored in.
>=20
> I know. The problem is that we call phy_drivers_register() with
> DriverVTable on stack. Then it was moved.

I see, what exactly is the problem with that? In other words:
why does PHYLIB need `phy_driver` to stay at the same address?

This is an important requirement in Rust. Rust can ensure that
types are not moved by means of pinning them. In this case, Wedson's
patch below should fix the issue completely.

But we should also fix this in the abstractions, the `DriverVTable`
type should only be constructible in a pinned state. For this purpose
we have the `pin-init` API [2].

Are there any other things in PHY that must not change address?

[2]: https://rust-for-linux.github.io/docs/v6.6-rc2/kernel/init/index.html

--=20
Cheers,
Benno

>> It seems that constructing the driver table not at that location
>> is somehow interfering with something?
>>
>> Wedson has a patch [1] to create in-place initialized modules, but
>> it probably is not completely finished, as he has not yet begun to
>> post it to the list. But I am sure that it is mature enough for
>> you to test this hypothesis.
>>
>> [1]: https://github.com/wedsonaf/linux/commit/484ec70025ff9887d9ca228ec6=
31264039cee35


