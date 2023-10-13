Return-Path: <netdev+bounces-40622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C637C7F12
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E42282BB8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CB101FC;
	Fri, 13 Oct 2023 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TmXpMAyX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19B101FA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 07:56:30 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E683
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697183778; x=1697442978;
	bh=UZGfM3Rzw5Jfe7SzIeQMyGeW+azbdrzWJPYuE7Tu0Hw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TmXpMAyXR4uvg7TwsYpg4VdUGDSBznLK5V1AH8czm26vnD+ou72oE1TvevdBb/Ij4
	 VFB7B+0+3fTus31hyJ2tdrVbt5n2Llq89Rm0bqPCpJb6MmnIlkO/xeId+GAmgyiGcP
	 QLv+z1szzCxLWdRaWZ4vkIiG+UQwtLcrdvMO5Cz2BseXV6npr4vLMbBZsJJltitdGs
	 YqXooDVOU4+XjsSSQjKieGkcZUJV/+b/+Co89FFKkHrLDKYGF8iXsOM8kDpm4fprpf
	 OcSBp5/Vxnz0d9pmWcjCVbLQxrbGcyDXsUVXlMxVwuL3LSiLsw52Kb3Y3Mu98Vk2gE
	 nrxy3JP3Wrbew==
Date: Fri, 13 Oct 2023 07:56:07 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
In-Reply-To: <20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
References: <20231012.165810.303016284319181876.fujita.tomonori@gmail.com> <f3fa33f8-f4b0-463c-8ba3-5f0a8b8f6788@proton.me> <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home> <20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13.10.23 07:45, FUJITA Tomonori wrote:
> On Thu, 12 Oct 2023 21:17:14 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
>> After re-read my email exchange with Tomo, I realised I need to explain
>> this a little bit. The minimal requirement of a Rust binding is
>> soundness: it means if one only uses safe APIs, one cannot introduce
>> memory/type safety issue (i.e. cannot have an object in an invalid
>> state), this is a tall task, because you can have zero assumption of the
>> API users, you can only encode the usage requirement in the type system.
>>
>> Of course the type system doesn't always work, hence we have unsafe API,
>> but still the soundness of Rust bindings means using safe APIs +
>> *correctly* using unsafe APIs cannot introduce memory/type safety
>> issues.
>>
>> Tomo, this is why we gave you a hard time here ;-) Unsafe Rust APIs must
>> be very clear on the correct usage and safe Rust APIs must not assume
>> how users would call it. Hope this help explain a little bit, we are not
>> poking random things here, soundness is the team effort from everyone
>> ;-)
>=20
> Understood, so let me know if you still want to improve something in
> v4 patchset :) I tried to addressed all the review comments.
>=20
> btw, what's the purpose of using Rust in linux kernel? Creating sound
> Rust abstractions? Making linux kernel more reliable, or something
> else?  For me, making linux kernel more reliable is the whole
> point. Thus I still can't understand the slogan that Rust abstractions
> can't trust subsystems.

For me it is making the Linux kernel more reliable. The Rust abstractions
are just a tool for that goal: we offload the difficult task of handling
the C <-> Rust interactions and other `unsafe` features into those
abstractions. Then driver authors do not need to concern themselves with
that and can freely write drivers in safe Rust. Since there will be a lot
more drivers than abstractions, this will pay off in the end, since we will
have a lot less `unsafe` code than safe code.

Concentrating the difficult/`unsafe` code in the abstractions make it
easier to review (compared to `unsafe` code in every driver) and easier to
maintain, if we find a soundness issue, we only have to fix it in the
abstractions.

> Rust abstractions always must check the validity of values that
> subsysmtes give because subsysmtes might give an invalid value. Like
> the enum state issue, if PHYLIB has a bug then give a random value, so
> the abstraction have to prevent the invalid value in Rust with
> validity checking. But with such critical bug, likely the system
> cannot continue to run anyway. Preventing the invalid state in Rust
> aren't useful much for system reliability.

It's not that we do not trust the subsystems, for example when we register
a callback `foo` and the C side documents that it is ok to sleep within
`foo`, then we will assume so. If we would not trust the C side, then we
would have to disallow sleeping there, since sleeping while holding a
spinlock is UB (and the C side could accidentally be holding a spinlock).

But there are certain things where we do not trust the subsystems, these
are mainly things where we can afford it from a performance and usability
perspective (in the example above we could not afford it from a usability
perspective).

In the enum case it would also be incredibly simple for the C side to just
make a slight mistake and set the integer to a value outside of the
specified range. This strengthens the case for checking validity here.
When an invalid value is given to Rust we have immediate UB. In Rust UB
always means that anything can happen so we must avoid it at all costs.
In this case having a check would not really hurt performance and in terms
of usability it also seems reasonable. If it would be bad for performance,
let us know.

--=20
Cheers,
Benno



