Return-Path: <netdev+bounces-40655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4B7C82B2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9782EB20A3E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34D111BA;
	Fri, 13 Oct 2023 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R//UOl0S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F211C8D
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:03:56 +0000 (UTC)
X-Greylist: delayed 7652 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 03:03:54 PDT
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE3AD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697191432; x=1697450632;
	bh=rlAfCKLKP49LC4pXiy9uBopYGJQ1yllJKjlhXSWm3/0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R//UOl0SHfgGMLr818eMmuBXRG/AguLij7d5WcOvPG/V6Eq7HkWzgTeO2HKDbucJI
	 VZJBRH7lrxEX+RMP1gMpIbIEwnlNo8Sdu5zPaZ2hBkR9A0BzfxcE3CjezEnf7HXUnh
	 q85FoCxQ5OY/cFGaS0iJLwZ46l+0lnShbA03lPIk9Sy9W3LGuQ12StW5CFfWRO+b3Q
	 Du8NtEqxpHevVIPtOQs9IoLAOp4wSjeE/imGtluvXgO4QIrkuA3rhcCM80ZvrRRjFx
	 e/7oy9gWbuxjpiwZUFOKJlklX8lQU6FYS4bHGIqGD2/6iq/WNjywrrUTPSZ7OeAIfT
	 f44vbxwJlOG1A==
Date: Fri, 13 Oct 2023 10:03:43 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me>
In-Reply-To: <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
References: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home> <20231013.144503.60824065586983673.fujita.tomonori@gmail.com> <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me> <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
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

On 13.10.23 11:53, FUJITA Tomonori wrote:
> On Fri, 13 Oct 2023 07:56:07 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>> It's not that we do not trust the subsystems, for example when we regist=
er
>> a callback `foo` and the C side documents that it is ok to sleep within
>> `foo`, then we will assume so. If we would not trust the C side, then we
>> would have to disallow sleeping there, since sleeping while holding a
>> spinlock is UB (and the C side could accidentally be holding a spinlock)=
.
>>
>> But there are certain things where we do not trust the subsystems, these
>> are mainly things where we can afford it from a performance and usabilit=
y
>> perspective (in the example above we could not afford it from a usabilit=
y
>> perspective).
>=20
> You need maintenance cost too here. That's exactly the discussion
> point during reviewing the enum code, the kinda cut-and-paste from C
> code and match code that Andrew and Grek want to avoid.

Indeed, however Trevor already has opened an issue at bindgen [1]
that will fix this maintenance nightmare. It seems to me that the
bindgen developers are willing to implement this. It also seems that
this feature can be implemented rather quickly, so I would not worry
about the ergonomics and choose safety until we can use the new bindgen
feature.

[1]: https://github.com/rust-lang/rust-bindgen/issues/2646

>> In the enum case it would also be incredibly simple for the C side to ju=
st
>> make a slight mistake and set the integer to a value outside of the
>> specified range. This strengthens the case for checking validity here.
>> When an invalid value is given to Rust we have immediate UB. In Rust UB
>> always means that anything can happen so we must avoid it at all costs.
>=20
> I'm not sure the general rules in Rust can be applied to linux kernel.

Rust UB is still forbidden, it can introduce arbitrary misscompilations.

> If the C side (PHYLIB) to set in an invalid value to the state,
> probably the network doesn't work; already anything can happen in the
> system at this point. Then the Rust abstractions get the invalid value
> from the C side and detect an error with a check. The abstractions
> return an error to a Rust PHY driver. Next what can the Rust PHY
> driver do? Stop working? Calling dev_err() to print something and then
> selects the state randomly and continue?

What if the C side has a bug and gives us a bad value by mistake? It is
not required for the network not working for us to receive an invalid
value. Ideally the PHY driver would not even notice this, the abstractions
should handle this fully. Not exactly sure what to do in the error case,
maybe a warn_once and then choose some sane default state?

> What's the practical benefit from the check?

The practical use of the check is that we do not introduce UB.

>> In this case having a check would not really hurt performance and in ter=
ms
>> of usability it also seems reasonable. If it would be bad for performanc=
e,
>> let us know.
>=20
> Bad for maintenance cost. Please read the discussion in the review on rfc=
 v1.

Since this will only be temporary, I believe it to be fine.

--=20
Cheers,
Benno



