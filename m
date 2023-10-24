Return-Path: <netdev+bounces-43939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68D7D584B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E9281812
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084713A267;
	Tue, 24 Oct 2023 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TNtI6T01"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABE3A260;
	Tue, 24 Oct 2023 16:29:29 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0210E9;
	Tue, 24 Oct 2023 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698164960; x=1698424160;
	bh=9wCN5hqgjoeWJfYj6IaF7NWT36bB8jzQnGe4cq5/zwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TNtI6T01vp/iSJsaJUbpm4T4Kiv5eI7YMO/RV8vS1VQCcuLxdgE9+aC7Cn2lF7ts0
	 BfdBy0hINwLrWMiaJOQ5oVH/NSUlz2tInL1XUdxwgkD7eFXhraLomhl+/WWkFuXUBX
	 NcTAK2YsS7eynRP2j4kzSfLV0dtmKAOMyXcxVjbNvWCLKpLMZYDu9xypuul0W2tEJl
	 G+o8xP/octkC6pVRharnhuQ/TXlwxdAah/yvKb1VSPxTQv/53jwQiRhFztx0bM6Hhm
	 0SFKHkii1JHkQNWmdV5Bpcfh/3EOVV5hmMfhTNKDBn0H9CEk3ZRX6dLTu6tBfP6vOB
	 N6cSvOslplE1Q==
Date: Tue, 24 Oct 2023 16:29:16 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH net-next v6 3/5] rust: add second `bindgen` pass for enum exhaustiveness checking
Message-ID: <6412a54b-844a-497c-a7e2-2b5f94005226@proton.me>
In-Reply-To: <20231024005842.1059620-4-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com> <20231024005842.1059620-4-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.10.23 02:58, FUJITA Tomonori wrote:
> From: Miguel Ojeda <ojeda@kernel.org>

I think this commit message should also explain what it is
doing and not only the error below.

--=20
Cheers,
Benno

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
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

[...]



