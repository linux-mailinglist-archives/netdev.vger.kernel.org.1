Return-Path: <netdev+bounces-44104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AEA7D639B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF8D281C91
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5919470;
	Wed, 25 Oct 2023 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hILbAoB+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50D5397
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:38:51 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0FB421A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698219395; x=1698478595;
	bh=WtaH2VYNqQ1NUpWC3BRY7Yh1+MQ2ThKNN/Y+SoWHNBQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hILbAoB+p85PUJdzduxvaMYL5Zvic1/d15XAmff0QPlW0Lc53vW5eMyks2UZ+ttq2
	 H3laKnmQKb2lv4+WE8LvEV4gi82GISUf+JwRy0zWLm4CAYXQZQC4hz2UR4d4hlbJjX
	 4FBT5RUtZyyCWSjgK4j7d/ngY1aDuK1tC8p4vCv4x1lwhXOxHdis3SA8/p+tieGzPX
	 ygpYMGO2yaPVWdmaMTYMLVT4Fgjoau3wmfN+WjhzrygR3SmO63P/jsLM2iqTzRyh38
	 nvtYThBhLXRzzDgr8bMYpoYJKbl33YovUPuAG8+j441589ICF9D7aTLjQtUM9Mn5hZ
	 hXt3cagqZvnCA==
Date: Wed, 25 Oct 2023 07:36:13 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com, ojeda@kernel.org
Subject: Re: [PATCH net-next v6 3/5] rust: add second `bindgen` pass for enum exhaustiveness checking
Message-ID: <c7662771-ea67-43ae-a4b2-6ffac29c0509@proton.me>
In-Reply-To: <20231025.103333.1621473047809401289.fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-4-fujita.tomonori@gmail.com> <6412a54b-844a-497c-a7e2-2b5f94005226@proton.me> <20231025.103333.1621473047809401289.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.10.23 03:33, FUJITA Tomonori wrote:
> On Tue, 24 Oct 2023 16:29:16 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 24.10.23 02:58, FUJITA Tomonori wrote:
>>> From: Miguel Ojeda <ojeda@kernel.org>
>>
>> I think this commit message should also explain what it is
>> doing and not only the error below.
>=20
> Looks ok?
>=20
> This patch makes sure that the C's enum phy_state is sync with Rust
> sides. If not, compiling fails. Note that this is a temporary
> solution. It will be replaced with bindgen when it supports generating
> the enum conversion code.

The solution that is implemented does not only work for `phy_state`, but
also other enums (you still have to manually add them). Also it would be
good to say that the error below is the error that one will receive when
the enum is out of sync/not all C variants are in Rust.

--=20
Cheers,
Benno

>=20
>      error[E0005]: refutable pattern in function argument
>           --> rust/bindings/bindings_enum_check.rs:29:6
>            |
>      29    |       (phy_state::PHY_DOWN
>            |  ______^
>      30    | |     | phy_state::PHY_READY
>      31    | |     | phy_state::PHY_HALTED
>      32    | |     | phy_state::PHY_ERROR
>      ...     |
>      35    | |     | phy_state::PHY_NOLINK
>      36    | |     | phy_state::PHY_CABLETEST): phy_state,
>            | |______________________________^ pattern `phy_state::PHY_NEW=
` not covered
>            |
>      note: `phy_state` defined here
>           --> rust/bindings/bindings_generated_enum_check.rs:60739:10
>            |
>      60739 | pub enum phy_state {
>            |          ^^^^^^^^^
>      ...
>      60745 |     PHY_NEW =3D 5,
>            |     ------- not covered
>            =3D note: the matched value is of type `phy_state`
>=20



