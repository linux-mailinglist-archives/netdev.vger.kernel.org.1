Return-Path: <netdev+bounces-40296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570EB7C690E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DBF28283A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075820B24;
	Thu, 12 Oct 2023 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="D59rv2EE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169211F19A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:10:59 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF19D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697101855; x=1697361055;
	bh=8jDZPX4hjFEpQv8WV/8kN1M/ScjjkFaT06ttwkOb56Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D59rv2EE9Idi5ypnoOcSwq2/2rLprl/QZ8ZzpKnjs/78fPFwPr0JUZsKW0Fd863LW
	 SkPd0b7jkZiVxF2szVO6LDzn1OwrvGA20ilRpMYGGRrgaiFiECJnt0dQau6pJSBmG/
	 GVyekQMcoCwcG+SA62brZe1eGBjFq1tiq7n3kYUiJ218BQWZcjhhd355ipLvb0ThTA
	 kdyrYTb0eYutoSb5HMcQ7bix7ChgTGQSYNzlUQX52DsTj1EagRnoBbwKu11M6X8Sc6
	 6GhOf0Rv5AZpywYBPbnp5Iz3kz0DyK6cl4tnOIpRVp1m+ldOyTLghOgtexbU3LhHNY
	 FCjo9rnd1f9aw==
Date: Thu, 12 Oct 2023 09:10:41 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <f3fa33f8-f4b0-463c-8ba3-5f0a8b8f6788@proton.me>
In-Reply-To: <20231012.165810.303016284319181876.fujita.tomonori@gmail.com>
References: <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com> <ZSeckzvOTyre3SVM@boqun-archlinux> <CALNs47tKwVE_GF-kec_mAi2NZLe53t2Jcsec=vsoJXT01AYLQQ@mail.gmail.com> <20231012.165810.303016284319181876.fujita.tomonori@gmail.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12.10.23 09:58, FUJITA Tomonori wrote:
> On Thu, 12 Oct 2023 03:32:44 -0400
> Trevor Gross <tmgross@umich.edu> wrote:
>=20
>> On Thu, Oct 12, 2023 at 3:13=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>>
>>> If `Device::from_raw`'s safety requirement is "only called in callbacks
>>> with phydevice->lock held, etc.", then the exclusive access is
>>> guaranteed by the safety requirement, therefore `mut` can be drop. It's
>>> a matter of the exact semantics of the APIs.
>>>
>>> Regards,
>>> Boqun
>>
>> That is correct to my understanding, the core handles
>> locking/unlocking and no driver functions are called if the core
>> doesn't hold an exclusive lock first. Which also means the wrapper
>> type can't be `Sync`.
>>
>> Andrew said a bit about it in the second comment here:
>> https://lore.kernel.org/rust-for-linux/ec6d8479-f893-4a3f-bf3e-aa0c81c4a=
dad@lunn.ch/
>=20
> resume/suspend are called without the mutex hold but we don't need the
> details. PHYLIB guarantees the exclusive access inside the
> callbacks. I updated the comment and drop mut in Device's methods.

The details about this stuff are _extremely_ important, if there is a
mistake with the way `unsafe` requirements are written/interpreted, then
the Rust guarantee of "memory safety in safe code" flies out the window.
The whole idea is to offload all the dangerous stuff into smaller regions
that can be scrutinized more easily and for that we need all of the details=
.

What would be really helpful for me, as I have extremely limited
knowledge of the C side, would be an explaining comment in the phy
abstractions that explains the way the C side phy abstractions work. So
for example it would say that locking is handled by the phy core and (at
the moment) neither the Rust abstractions nor the driver code needs to
concern itself with locking. There you could also write that `resume` and
`suspend` are called without the mutex being held. We don't really have a
precedent for this (as there have been no drivers merged), but it would be
really helpful for me. If this exists in some other documentation, feel
free to just link that.

--=20
Cheers,
Benno



