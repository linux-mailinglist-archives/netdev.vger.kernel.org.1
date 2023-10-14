Return-Path: <netdev+bounces-40967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2FD7C9354
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA23282BF9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7C4567B;
	Sat, 14 Oct 2023 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GcFvCnsm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BB53B9;
	Sat, 14 Oct 2023 07:47:35 +0000 (UTC)
X-Greylist: delayed 36964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Oct 2023 00:47:33 PDT
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A3BF;
	Sat, 14 Oct 2023 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697269650; x=1697528850;
	bh=93GkfZGzIApgyXsBVNEfyjY0aJigreNdL+jk3oC3QZ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GcFvCnsmg9i48O0LcWxEfeuv2bIHH5rPskz8l3Mo+RMYhM5EY3oivsTfraxCwx13Z
	 Ql3fFXGWuH0ecaBswpBK4T1tschfYX4DuJBh9CfUmFK9RFdULL0vQDrkAz/Cdk5X/Y
	 Fc50u2lLMeLbYqRxFaMA389lPRcQZ3OvIz9e2x2eP/+a5Cdl7swWEZVbM5hXD52tiI
	 sLfiiarY6lm2hg+cELBst5+IBu86xSJn+0cW5f6vZaYOwvaSgVSlW96pEzLouP/tYT
	 GOQbP9LgUbOgDt4b96cAqR/T3XiDDTcNsSCxUOmFcHvZ2l9UTgcPWnNSRkFncplZhe
	 0sB6pUlPZXSSg==
Date: Sat, 14 Oct 2023 07:47:22 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <de903407-eb53-4d42-af5c-c019ace1b701@proton.me>
In-Reply-To: <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com>
References: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me> <20231013.185348.94552909652217598.fujita.tomonori@gmail.com> <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me> <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com>
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

On 13.10.23 12:53, FUJITA Tomonori wrote:
>>>> In the enum case it would also be incredibly simple for the C side to =
just
>>>> make a slight mistake and set the integer to a value outside of the
>>>> specified range. This strengthens the case for checking validity here.
>>>> When an invalid value is given to Rust we have immediate UB. In Rust U=
B
>>>> always means that anything can happen so we must avoid it at all costs=
.
>>>
>>> I'm not sure the general rules in Rust can be applied to linux kernel.
>>
>> Rust UB is still forbidden, it can introduce arbitrary misscompilations.
>=20
> Can you give a pointer on how it can introduce such?

First, I can point you to [1] that is a list of UB that can occur in
Rust. Second, I can give you an example [2] of UB leading to
miscompilations, compare the executions of both release and debug mode.

[1]: https://doc.rust-lang.org/nomicon/what-unsafe-does.html#what-unsafe-ru=
st-can-do
[2]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D20=
21&gist=3D856cdd7434350e38d3891162e04424db

>>> If the C side (PHYLIB) to set in an invalid value to the state,
>>> probably the network doesn't work; already anything can happen in the
>>> system at this point. Then the Rust abstractions get the invalid value
>>> from the C side and detect an error with a check. The abstractions
>>> return an error to a Rust PHY driver. Next what can the Rust PHY
>>> driver do? Stop working? Calling dev_err() to print something and then
>>> selects the state randomly and continue?
>>
>> What if the C side has a bug and gives us a bad value by mistake? It is
>> not required for the network not working for us to receive an invalid
>> value. Ideally the PHY driver would not even notice this, the abstractio=
ns
>> should handle this fully. Not exactly sure what to do in the error case,
>=20
> Your case is that C side has a good value but somehow gives a bad
> value to the abstractions?

Just think of the C side having some weird bug.

> The abstractions can't handle this. The abstractions works as the part
> of a PHY driver; The abstractions do only what The driver asks.
>=20
> The PHY driver asks the state from the abstractions then the
> abstractions ask the state from PHYLIB. So when the abstractions get a
> bad value from PHYLIB, the abstractions must return something to the
> PHY driver. As I wrote, the abstractions return a random value or an
> error. In either way, probably the system cannot continue.

Sure then let the system BUG if it cannot continue. I think that
allowing UB is worse than BUGing.

>> maybe a warn_once and then choose some sane default state?
>=20
> What sane default? PHY_ERROR?

Sure.

--=20
Cheers,
Benno



