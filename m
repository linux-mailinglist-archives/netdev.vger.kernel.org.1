Return-Path: <netdev+bounces-41047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBB7C9703
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049E6B20C42
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAA266DF;
	Sat, 14 Oct 2023 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="m3sVoeLO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21F266BD
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 22:19:15 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E9D8
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697321950; x=1697581150;
	bh=l4XFrMjQW18yqdquNHTsf/sls3PbYQHpxSo7wLyS/cE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m3sVoeLOtZABfHAN73YOjRGSY+WaWumRVt0TUvQb7AkSpzErOOMfdLS+OfWV9FMWM
	 wpoYT9+kUfmBsQg2zFHwdocF4VzpND9dg8HNa+x5xCNnkMQ/gN62zoWVesxmns2Q5/
	 ZfGWGzD41TVYGmR4V2axUiwaYtyMME/oFc7hOILSpCIFSKY1UfIzAgTXHONSV6t08R
	 aTpe2trOzMiq+dRlP9nKA9ttKJJRbvubgfZhNiKUl2MCMOtIwr90FqH0HyLwTeNfgR
	 x6mHyA5xqIk9ajsTENsO7g+UhTfFCT78AJECJE94Q6/ZMLk2QuXjZ7wMPHSc1i6FeU
	 Vapvww9+Vu7qg==
Date: Sat, 14 Oct 2023 22:18:58 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com, tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
Message-ID: <c807ef34-3926-4284-ab18-b516c8af57c7@proton.me>
In-Reply-To: <72a268b1-aabc-4d98-aba4-4d92c3f3dd21@lunn.ch>
References: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me> <20231013.185348.94552909652217598.fujita.tomonori@gmail.com> <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me> <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com> <de903407-eb53-4d42-af5c-c019ace1b701@proton.me> <72a268b1-aabc-4d98-aba4-4d92c3f3dd21@lunn.ch>
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

On 14.10.23 23:55, Andrew Lunn wrote:
>>> The PHY driver asks the state from the abstractions then the
>>> abstractions ask the state from PHYLIB. So when the abstractions get a
>>> bad value from PHYLIB, the abstractions must return something to the
>>> PHY driver. As I wrote, the abstractions return a random value or an
>>> error. In either way, probably the system cannot continue.
>>
>> Sure then let the system BUG if it cannot continue. I think that
>> allowing UB is worse than BUGing.
>=20
> There is nothing a PHY driver can do which justifies calling BUG().

I was mostly replying to Tomonori's comment "In either way, probably
the system cannot continue.". I think that defaulting the value to
`PHY_ERROR` when it is out of range to be a lot better way of handling
this.

> BUG() indicates the system is totally messed up, and running further
> is going to result in more file system corruption, causing more data
> loss, so we need to stop the machine immediately.
>=20
> Anyway, we are talking about this bit of code in the C driver:
>=20
>          /* Reset PHY, otherwise MII_LPA will provide outdated informatio=
n.
>           * This issue is reproducible only with some link partner PHYs
>           */
>          if (phydev->state =3D=3D PHY_NOLINK) {
>                  phy_init_hw(phydev);
>                  _phy_start_aneg(phydev);
>          }
>=20

I think that we are talking about `Device::state` i.e. the
Rust wrapper function of `phydev->state`.

> and what we should do if phydev->state is not one of the values
> defined in enum phy_state, but is actually 42. The system will
> continue, but it could be that the hardware reports the wrong value
> for LPA, the Link Partner Advertisement. That is not critical
> information, the link is likely to work, but the debug tool ethtool(1)
> will report the wrong value.
>=20
> Can we turn this UB into DB? I guess you can make the abstraction
> accept any value, validate it against the values in enum phy_state, do
> a WARN_ON_ONCE() if its not valid so we get a stack trace, and pass
> the value on. Life will likely continue, hopefully somebody will
> report the stack trace, and we can try to figure out what went wrong.

Then we are on the same page, as that would be my preferred solution.

--=20
Cheers,
Benno


