Return-Path: <netdev+bounces-57128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF32812361
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEDF1C20828
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1479497;
	Wed, 13 Dec 2023 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DdazQN4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B83244
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 15:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702510843; x=1702770043;
	bh=X9Z37I6bksf/OaTroQaTzF/noy3oa2pTTydb77vHyUQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DdazQN4HXYU6WOxV9j2u2Udengbtc59hlk8tSuzcGc6/y0d1Y36kiM8fsPJWsb/AB
	 kDFVSzu75AGlpt9fLw1i4bzL+Qgl9VrgDPq+UjsZaAqVl2MHFXneBXuh8lwwb9TCWw
	 2q8LGQpVKOI3xk0WB6K/wTx/jkYu2FapGPOJHl/PBABrqCFHyk/2w1nb2I7TEEAntS
	 VEd18tXl4I8RzCgPQeuPPb9P+vb16PyFfoQafwNgG54F0PaHtulV3ZEZMQcgN7T8sH
	 OdLBG05YMG6x/TLqNigNOJHkl5t65rfaknm/JT8s+YEYAmUwXrnA9MtjuER98VMEFX
	 ylSxV6GyaQ9Hw==
Date: Wed, 13 Dec 2023 23:40:26 +0000
To: Andrew Lunn <andrew@lunn.ch>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <66c532cf-e56f-4364-94dd-c740f9dfdf69@proton.me>
In-Reply-To: <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux> <20231212.104650.32537188558147645.fujita.tomonori@gmail.com> <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com> <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch> <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home> <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/23 22:48, Andrew Lunn wrote:
>> Well, a safety comment is a basic part of Rust, which identifies the
>> safe/unsafe boundary (i.e. where the code could go wrong in memory
>> safety) and without that, the code will be just using Rust syntax and
>> grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
>> boundaries, why do they try to use Rust? Unsafe Rust is harder to write
>> than C, and safe Rust is pointless without a clear safe/unsafe boundary.
>> Plus the syntax is not liked by anyone last time I heard ;-)
>=20
> Maybe comments are the wrong format for this? Maybe it should be a
> formal language? It could then be compiled into an executable form and
> tested? It won't show it is complete, but it would at least show it is
> correct/incorrect description of the assumptions. For normal builds it
> would not be included in the final binary, but maybe debug or formal
> verification builds it would be included?

That is an interesting suggestion, do you have any specific tools in
mind?
There are some Rust tools for formal verification, see
https://rust-formal-methods.github.io/tools.html
but I don't know if they can be used in the kernel, especially since we
would need a tool that also supports C (I have no experience/knowledge
of verification tools for C, so maybe you have something).
Also my experience tells me that there are several issues with formal
verification in practice:

1. When you want to use some formal system to prove something it is
   often an "all or nothing" game. So you will have to first verify
   everything that lies beneath you, or assume that it is correctly
   implemented. But assuming that everything is correctly implemented is
   rather dangerous, because if you base your formal system on classical
   logic [1], then a single contradiction allows you to prove
   everything. So in order for you to be _sure_ that it is correct, you
   need to work from the ground up.

2. There is no formal Rust memory model. So proving anything for
   interoperability between Rust and C is going to be challenging.

3. The burden of fully verifying a program is great. I know this, as I
   have some experience in this field. Now the programmer not only needs
   to know how to write a piece of code, but also how to write the
   required statements in the formal system and most importantly how to
   prove said statements from the axioms and theorems.


When using safety comments, we avoid the problems of having to prove the
statements formally (which is _very_ difficult). Of course people still
need to know how to write safety comments, which is why I am working on
a standard for safety comments. I hope to post an RFC in a couple weeks.
It will also make the safety comments more formal by having a fixed
set of phrases with exact interpretations, so there can be less room for
misunderstandings.


[2]: You might try to work around this by using a paraconsistent logic,
     but I have little to no experience with that field, so I cannot
     really say more than "it exists".


>> Having a correct safety comment is really the bottom line. Without that,
>> it's just bad Rust code, which I don't think netdev doesn't want either?
>> Am I missing something here?
>=20
> It seems much easier to agree actual code is correct, maybe because it
> is a formal language, with a compiler, and a method to test it. Is

I disagree. You always have to consider the entire kernel when you want
to determine if some piece of code is correct. This is by the nature of
the formal language, anything can affect anything.
For example you consider this:

    foo(void **ptr) {
        *ptr =3D NULL;
        synchronize_rcu()
        print(**x)
    }

How do you know that this is correct? Well you have to look at all
locations where `foo` is invoked and see if after a `synchronize_rcu`
the supplied pointer is valid.

If we do the safety comment stuff correctly, then we have a _local_
property, so something where you do not have to consider the entire
kernel. Instead you assume that all other safety comments are correct
and then only verify the boundary. If all boundaries agree, we have a
reasonably correct program.

> that code really bad without the comments? It would be interesting to
> look back and see how much the actual code has changed because of
> these comments? I _think_ most of the review comments have resulted in
> changes to the comments, not the executable code itself. Does that
> mean it is much harder to write correct comments than correct code?

The code not having changed does not mean that it is correct. There are
no obvious issues present, but can we really know that it is correct?
Only time will tell (or a formal verification).

The issue that we currently have with this patch series is that the
people who know how the stuff works and the people who know how to
write good safety comments are not the same. I hope that my safety
standard will help close this gap.

For example we do not know how the synchronization mechanism for
`phy_suspend` and `phy_resume` work, but you mentioned in some previous
thread that the knowledge is actually somewhere out there. It would help
us a lot if you could give us a link or an explanation. Then we can work
on a suitable safety comment.

--=20
Cheers,
Benno


