Return-Path: <netdev+bounces-45012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D537DA81B
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E391F21ACC
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C87168D4;
	Sat, 28 Oct 2023 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B8opr7k1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D018BA4B
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 16:39:17 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59937E5
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=x4bvcsa3tbh4voqt5ttz7sjomm.protonmail; t=1698511154; x=1698770354;
	bh=D+y3FgN/2SDAom2IzHOF0qtYMSU9LzuvA7GEm7I35Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B8opr7k1aJ7R7iNQSTL4pJSZfRGiW8Vm/qBNctA3qeP5xQzUfGzHPJPFosHzmvowB
	 Cxs853AP2DLDNl1ueIr2tUT9kymhtaANkSbnYebixdx8EtVqfAkz0PJ3cL2uJjGDIR
	 +cdNWEGvQ75lpPHR4jptFzleIGa0Xl1utYWwiIF4DnjxLR1gmH4T/r9IlKNH5OiUk1
	 31lDCGGn9w5FOsSV+K63s4pOZHdMYuhNIMucaHk6mgoo0yEVTr54KXuTQ+CEPyBf30
	 txxsuSjOdEV+GH5kgOoL6EoGNSoxXTMKucrOnAXBj8OJMkb9eCBDGKg+jBlti8cDFt
	 eGshkdES3BUWg==
Date: Sat, 28 Oct 2023 16:39:08 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, andrew@lunn.ch
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <91cba75f-0997-43e8-93d0-b795b3783eff@proton.me>
In-Reply-To: <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
References: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me> <20231028.182723.123878459003900402.fujita.tomonori@gmail.com> <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch> <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.10.23 18:09, FUJITA Tomonori wrote:
> On Sat, 28 Oct 2023 16:53:30 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>>>> We need to be careful here, since doing this creates a reference
>>>> `&bindings::phy_device` which asserts that it is immutable. That is no=
t
>>>> the case, since the C side might change it at any point (this is the
>>>> reason we wrap things in `Opaque`, since that allows mutatation even
>>>> through sharde references).
>>>
>>> You meant that the C code might modify it independently anytime, not
>>> the C code called the Rust abstractions might modify it, right?
>>
>> The whole locking model is base around that not happening. Things
>> should only change with the lock held. I you make a call into the C
>> side, then yes, it can and will change it. So you should not cache a
>> value over a C call.
>=20
> Yeah, I understand that. But if I understand Benno correctly, from
> Rust perspective, such might happen.

Yes, that is what I meant. Sure the C side might never modify the
value, but this is not good enough for Rust. It must somehow be ensured
that it never is modified, in order for us to rely on it.

--=20
Cheers,
Benno



