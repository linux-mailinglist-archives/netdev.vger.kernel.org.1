Return-Path: <netdev+bounces-57130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1D812395
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C41F21429
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA179E1A;
	Wed, 13 Dec 2023 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FHC7Lhvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19210A;
	Wed, 13 Dec 2023 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702511506; x=1702770706;
	bh=REj6y8dEHaBWLY7kzjeY2O6pdWcISvgeX6kkBOa/w+I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FHC7LhvxpTJHYWhZrN1u/ur1NfKSvPFzMYRhhiVGHqCyECX8K8X0u2v2jCmK6xSAt
	 dwgQXIhWlZh09XuLHC1qMc7VDpWvT7Oi67G7Sue9g+dl3zBDRcdUYJKOdeo8hmtL/d
	 fcWblAGOkEE9/VNhRKOonGPuHU1gTjyqBkTWl+A8r+q5QLPM/J/XwNNYmQ/0BqLyBI
	 us+xehp/xIbFePUFqFyPOrvxQOzrFGoZJdlFxHUsSyXreXAt9194LWYCJMDsFRXthb
	 GWV0WUvjKFVOKkLT2vBdxj+cGtHEgrZ5YzsKEbDDwrDztcYhFlGHdd/NjKlHkYJOVP
	 LiglNnhS+5Gyw==
Date: Wed, 13 Dec 2023 23:51:31 +0000
To: Andrew Lunn <andrew@lunn.ch>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <15c994fc-e638-4467-81d1-7d1e6e3c21c1@proton.me>
In-Reply-To: <66c532cf-e56f-4364-94dd-c740f9dfdf69@proton.me>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux> <20231212.104650.32537188558147645.fujita.tomonori@gmail.com> <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com> <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch> <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home> <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch> <66c532cf-e56f-4364-94dd-c740f9dfdf69@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/23 00:40, Benno Lossin wrote:
> On 12/13/23 22:48, Andrew Lunn wrote:
>>> Well, a safety comment is a basic part of Rust, which identifies the
>>> safe/unsafe boundary (i.e. where the code could go wrong in memory
>>> safety) and without that, the code will be just using Rust syntax and
>>> grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
>>> boundaries, why do they try to use Rust? Unsafe Rust is harder to write
>>> than C, and safe Rust is pointless without a clear safe/unsafe boundary=
.
>>> Plus the syntax is not liked by anyone last time I heard ;-)
>>
>> Maybe comments are the wrong format for this? Maybe it should be a
>> formal language? It could then be compiled into an executable form and
>> tested? It won't show it is complete, but it would at least show it is
>> correct/incorrect description of the assumptions. For normal builds it
>> would not be included in the final binary, but maybe debug or formal
>> verification builds it would be included?
>=20
> That is an interesting suggestion, do you have any specific tools in
> mind?
> There are some Rust tools for formal verification, see
> https://rust-formal-methods.github.io/tools.html
> but I don't know if they can be used in the kernel, especially since we
> would need a tool that also supports C (I have no experience/knowledge
> of verification tools for C, so maybe you have something).
> Also my experience tells me that there are several issues with formal
> verification in practice:

Don't get me wrong, I would welcome a more formalized approach. I just
have seen what that entails and I believe Rust (with safety comments)
to be a good compromise that still allows programmers with no knowledge
in formal systems to program and reasonable correctness.

> 1. When you want to use some formal system to prove something it is
>    often an "all or nothing" game. So you will have to first verify
>    everything that lies beneath you, or assume that it is correctly
>    implemented. But assuming that everything is correctly implemented is
>    rather dangerous, because if you base your formal system on classical
>    logic [1], then a single contradiction allows you to prove
>    everything. So in order for you to be _sure_ that it is correct, you
>    need to work from the ground up.
>=20
> 2. There is no formal Rust memory model. So proving anything for
>    interoperability between Rust and C is going to be challenging.
>=20
> 3. The burden of fully verifying a program is great. I know this, as I
>    have some experience in this field. Now the programmer not only needs
>    to know how to write a piece of code, but also how to write the
>    required statements in the formal system and most importantly how to
>    prove said statements from the axioms and theorems.
>=20
>=20
> When using safety comments, we avoid the problems of having to prove the
> statements formally (which is _very_ difficult). Of course people still
> need to know how to write safety comments, which is why I am working on
> a standard for safety comments. I hope to post an RFC in a couple weeks.
> It will also make the safety comments more formal by having a fixed
> set of phrases with exact interpretations, so there can be less room for
> misunderstandings.
>=20
>=20
> [2]: You might try to work around this by using a paraconsistent logic,

This should actually be [1]:.

>      but I have little to no experience with that field, so I cannot
>      really say more than "it exists".

--=20
Cheers,
Benno


