Return-Path: <netdev+bounces-147176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310E9D7F50
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFF9B222C7
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8118E047;
	Mon, 25 Nov 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ni7VOp8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CD7082C
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525170; cv=none; b=RjG6KzrfPLvggeD+Nmu1br5z+BWtna+egqI+PSKMdd5sZFFfIFkPA+T29lFKbu3eCoBJ8irxK2GhpBdmPPipVIaM2aFRGLHZoq+xYiIEfDRbiFLKK3IThQhLq5LHvq84lQX0aaRlMjkqIk9HXpqEonxUiyqQh0m2reJIybxlYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525170; c=relaxed/simple;
	bh=7yeqh8mSpcpqY013Nd8GMY529z54HpOWd7EOpKC2kSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqsiB4gb3A66ypSfxw3BaVGrNBoU85d2ecctdQPINWF89duhNlm2otxLqs8/y6StqZ1vHfh2ZX01pewSibQD/mmuva0PwgV3pijDWOzVrvmAgQ1NZrEDb5y++KuUX6dTVmbxoWJDPOcPp6b2ne7+AlajVH4na70Ea3HdSzrb9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ni7VOp8i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316cce103dso53219635e9.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525166; x=1733129966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p2MlDzA7dqrElrwy+KJ7tN4JmHOF22/NGKBLlAmx+Q=;
        b=Ni7VOp8iPgMDHcK56OnuH7JNTtc+HI6jxAp5F6B3r6xK3TF/4PkFiJ8CPG66q49rO/
         bBYQabi/A1J/8bmAMepYxagda8BtMRhQlpKz/FiblFcyAr3NSBW3cuktUnuiDDtUCJZd
         sxKZ6WOd53r1onZbv+9byUmdAIg7+zaF0qARlMEk0z+jCkJKkAqNv3mAVdJODHbWgG5k
         ElU37Vo1pawtJU6bGyQ9Y0YPCtrz7BhGRRo/hm5IGvY3d3aVSoMP1rAqU9SmwU7J0Iex
         CZoiFCrAzFQ5YE89l/2sLsxPMAVqwvlL3RujlK/g5lMXC1IAOe3JRR0BRUO05bEDthZd
         nsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525166; x=1733129966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p2MlDzA7dqrElrwy+KJ7tN4JmHOF22/NGKBLlAmx+Q=;
        b=L13dz3F+Owyfl1RqnMc4sK4lfxUPi0DK1cQt0c1e54C4PI9BE/gyyAWl9F30TSj51C
         dOTmNIvdTVwuAB1YMEx7c3M8gE0FPt6QclA8fHnK3GG4NpoH2Vnnen1pyxY1ZPAKBq4x
         HB2zjdgB8pYMnWhWE+ejeAkCQa/OzJWB/5ZYtxo3oolCM+sntPohSfCO7miS6JZM+nW/
         bV0A43FDIxjXfLRAw6JZsVHcFuuktTrf2Q5duQdnpjbcUEqZqWazuJKo64+k366oUiLL
         2mQd99UE+lQkYiS5x0l3W0/Sm5RZ0UWQTl45HS9gpkP0desNPJo9Gk9Me+bkfiVUtkFA
         HQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzFNrRXLsAeu3WxDIo8LJuS5DpywMUuy3Um8GmpiJ1r+vogKdjdoHMINKvjDP4Yy1H2slmqsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOwWsDqGg4ohsv153MTrDH3D2XSWNwWFIoiJkqa1a6sXs09qi
	7m3v+SNOB/vNlgZwrt3ftKuCiW1JGc5Eb80pClob5pL1DwPP3BIIaOsNMnDYH3AC3vYqpZrcWIX
	sMeF3/Yd+zsuZbue721gt/y3gAXlBrk7aLe3p
X-Gm-Gg: ASbGnctue49rbfubzeEWClj4zustjDPDmusa0ZTT6NJT0XVNS3aoR60L1B2SYNc+uD3
	s/6vAiR3SKKYlnvR7qUS9nR49MvjGtjHwozYQuPpzOJgRdtrkPA5c0CrxSTjO7A==
X-Google-Smtp-Source: AGHT+IFYOF/TAUWVLBDEfvxfi8/wxmxgjijqnjz3cOLzclsiUIjHCZdK96AUcPZYb9goN+8u8cSs7q0J/CqX3J6/090=
X-Received: by 2002:a05:600c:4f83:b0:42f:8229:a09e with SMTP id
 5b1f17b1804b1-433ce4ad08fmr116754985e9.29.1732525166556; Mon, 25 Nov 2024
 00:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113174438.327414-3-sergeantsagara@protonmail.com> <20241124162700.4ec4b6ce@kernel.org>
In-Reply-To: <20241124162700.4ec4b6ce@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 09:59:13 +0100
Message-ID: <CAH5fLgiFFhrDd+=+0gsnaWdV=EeiExo3SQxg2=2c3m-5Z5Tgqg@mail.gmail.com>
Subject: Re: [PATCH net] rust: net::phy scope ThisModule usage in the
 module_phy_driver macro
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 1:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Nov 2024 17:45:22 +0000 Rahul Rameshbabu wrote:
> > Similar to the use of $crate::Module, ThisModule should be referred to =
as
> > $crate::ThisModule in the macro evaluation. The reason the macro previo=
usly
> > did not cause any errors is because all the users of the macro would us=
e
> > kernel::prelude::*, bringing ThisModule into scope.
>
> You say "previously", does it mean there are no in-tree users where
> this could cause bugs? If so no Fixes tag necessary..
>
> > Fixes: 2fe11d5ab35d ("rust: net::phy add module_phy_driver macro")
> > Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> > ---
> >
> > Notes:
> >     How I came up with this change:
> >
> >     I was working on my own rust bindings and rust driver when I compar=
ed my
> >     macro_rule to the one used for module_phy_driver. I noticed, if I m=
ade a
> >     driver that does not use kernel::prelude::*, that the ThisModule ty=
pe
> >     identifier used in the macro would cause an error without being sco=
ped in
> >     the macro_rule. I believe the correct implementation for the macro =
is one
> >     where the types used are correctly expanded with needed scopes.
>
> Rust experts, does the patch itself make sense?

Yes, the macro should not rely on the user having random things in
scope when calling the macro. This change is good.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> > diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> > index 910ce867480a..80f9f571b88c 100644
> > --- a/rust/kernel/net/phy.rs
> > +++ b/rust/kernel/net/phy.rs
> > @@ -837,7 +837,7 @@ const fn as_int(&self) -> u32 {
> >  ///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
> >  ///
> >  ///     impl ::kernel::Module for Module {
> > -///         fn init(module: &'static ThisModule) -> Result<Self> {
> > +///         fn init(module: &'static ::kernel::ThisModule) -> Result<S=
elf> {
> >  ///             let drivers =3D unsafe { &mut DRIVERS };
> >  ///             let mut reg =3D ::kernel::net::phy::Registration::regi=
ster(
> >  ///                 module,
> > @@ -899,7 +899,7 @@ struct Module {
> >                  [$($crate::net::phy::create_phy_driver::<$driver>()),+=
];
> >
> >              impl $crate::Module for Module {
> > -                fn init(module: &'static ThisModule) -> Result<Self> {
> > +                fn init(module: &'static $crate::ThisModule) -> Result=
<Self> {
> >                      // SAFETY: The anonymous constant guarantees that =
nobody else can access
> >                      // the `DRIVERS` static. The array is used only in=
 the C side.
> >                      let drivers =3D unsafe { &mut DRIVERS };
> >
> > base-commit: 73af53d82076bbe184d9ece9e14b0dc8599e6055
>

