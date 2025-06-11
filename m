Return-Path: <netdev+bounces-196578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40FAD5705
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DC318895D2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DA28751B;
	Wed, 11 Jun 2025 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT61unBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18F35897;
	Wed, 11 Jun 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648687; cv=none; b=iaKfl/B8rjVHhgDu+2tWuXot3IJTeH0XHUbBQM3RIdQnsWDTSlxKRXTxqgJQ2GcpFOeAZyNliZm7AAkqSpQzN8FOYM1usuwK7fXe6a1gXmg7vZMyduv122uTpDpTcoRiCHCj7Zuf8t3hzbL9lP4XXulR/wGyLSOmdFfetIqK0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648687; c=relaxed/simple;
	bh=PRa45XHRyBZTLzhuAprRop3kJMcOBLwjBiDC1TfDrp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVl3F3tQ4tYsNBMS3QJviojSWshcjQwjdixwfyaQpPTVueHQWrSZknHIGaOlga+Z5Dp4aoJeM684j2KtiKDeuw8cyXCw3ckVnLm1PmJXjbH4GSmCgoPgnyiBQp3NBl2aI1XjcV0byU43CvA+kLrACAE388auaqhjZe+bPANxbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT61unBB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553644b8f56so6387574e87.1;
        Wed, 11 Jun 2025 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749648683; x=1750253483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by0JqHx34YNkgxgVF7BPRx6qQXycEbtV2xtHdw17AjI=;
        b=nT61unBB7HEaAnN6ln5NwuHGoFuVOZOCDP+LsxO58fuf+2XBJ9+uAXGbuB5qGS7ytJ
         DLbj+gdW209Y0+IE1FTLp5SZbI5MShngIpnQ1rZpjviQZn7ZmL3oeUl4Kbda0JnqskLE
         YYGa9Vs0biZKEFReV5pFYunRYlDmtwmALPxOBnWdcI3tUYKlL6d4wFEhTTs88f2YDLYy
         Saec2OA4aeyohZi5G0dQn3dCkDhak0UjZ0EqSDaZWdWaig8Wivb2LessszQXCPGVi6Vr
         sSXgWd39xdEutecaPeHNDz7Y72/P9pUTmTQ/QW/wx0izs/XoG/xbl2DQWJaJ2nWvcXmh
         3O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749648683; x=1750253483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by0JqHx34YNkgxgVF7BPRx6qQXycEbtV2xtHdw17AjI=;
        b=sd7ZePgDX7Qa3v/wUdK0GZ2BguyPa2OjpkhSB19lAfgOYdMiEe+TqsqqOSq0W08lSl
         qGVsDbaPZI69Dwtzn9tFzBCpOd/H75fTlYwrGN0s5rdNYlUtf6kJ/F+JtwR7PNQSJZsF
         +CuPcGcEEUTGf0lJOWfQ+yZ22NJ44h5zg9FWKChmh2V5k1o9osKVNX0/iiq9Cd6lixbR
         uSRhP8adHxY5Mfb4aHV8Gt/5Z9VlK9uXvn7RKWwuFe5Z9HCCRqChTekf/tXNNfV1mZj9
         3KACmpcw/9Xq1sjjneXAcFSRbSh7Mf+F30hIcB1LqVI3NWk3A0aic6hKQYOoV2A6vvdv
         dcFA==
X-Forwarded-Encrypted: i=1; AJvYcCV28bTH7E8vzYn/SZK/JIes0NjQNxftPPc+vlc9/XMPGLoD0aBTAny32oZfrGj9r99sgcq847HD@vger.kernel.org, AJvYcCWWLYkVAalHk/8+s7wbxitykKKPA0zRO6HiN4oLR/41pDcbIjclDOaeU2Ok46//4Tq/WDHD+e7Hz7H1sIE=@vger.kernel.org, AJvYcCWvjQzg2SKUt8RND9kovSGvsDrwbRBuKoEmAe7OpbBhjsMcjarJMDXYKqq3mT3Sa+2e2kFOLCYQpxmZdNNDDqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3daWXrbbJlB6eRNXerRpN9YI+Ja82OAixmnLzRQ6amjF+LfT
	lrh7enR40qt/FHO+T3AjwXghrGusFWsZvY3OrSIWh3MgV4Rgi6TCneyDK0ZFMp0moFTLahOYuBX
	0+/bFkHsJwHjJikoWwrr2TZgsoWnZH1o=
X-Gm-Gg: ASbGncvp/g+bxiP/FQn4y6+3jzcra6hXdQyO+mSXtfxvbDLEHJZu8ZkaKFGcnGmZlFU
	i3dxs8JcoumQc6OmAToGmpmwwyYz+WlVlETvobQKz/Qv1P9NW6UZGX5gESEuLkaPMwm2G7vWKll
	xS1oSAnd2ppUm7UlLnkrrK2W7Lq8S5XIiMUVDL1zEUal5ScyIR6GXGp/+4RKg=
X-Google-Smtp-Source: AGHT+IEDPWyfJNtGTu4LypSaugkwIwqz2/qnaItV9jD0VPbgjbjAa2W2Tl+OD/G9iuaydAxR42mAP7rdnWAmqEma1yk=
X-Received: by 2002:a05:6512:3089:b0:550:dee7:54b5 with SMTP id
 2adb3069b0e04-5539c171886mr1139842e87.41.1749648683215; Wed, 11 Jun 2025
 06:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com> <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
In-Reply-To: <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 09:30:46 -0400
X-Gm-Features: AX0GCFtT1DHjt0sfo9S71NUi0h0ys836XgvRmUssTQNIwrVYzCc2sCzzIIu5zYw
Message-ID: <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Jun 11, 2025 at 12:28=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > Use the ffi type rather than the resolved underlying type.
> >
> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
>
> Does this need to be backported? If not, I wouldn't include a Fixes tag.

I'm fine with omitting it. I wanted to leave a breadcrumb to the
commit that introduced the current code.

>
> > +            DuplexMode::Full =3D> bindings::DUPLEX_FULL,
> > +            DuplexMode::Half =3D> bindings::DUPLEX_HALF,
> > +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN,
> > +        } as crate::ffi::c_int;
>
> This file imports the prelude, so this can just be c_int without the
> crate::ffI:: path.

This has come up a few times now; should we consider denying
unused_qualifications?

https://doc.rust-lang.org/stable/nightly-rustc/rustc_lint/builtin/static.UN=
USED_QUALIFICATIONS.html

