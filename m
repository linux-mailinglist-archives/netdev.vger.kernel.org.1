Return-Path: <netdev+bounces-121629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7C95DC6F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E81F2292D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5C1547DA;
	Sat, 24 Aug 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ks+hFJNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3514E2F5
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484304; cv=none; b=papWqUHgxOq4Z5+5eFwv2J1jlgNHyl8+RjHmIu09370cijK10+34nI8DAW4ARQUE7pJ1+x7W8OKef4q24F6ajQ6ZX3anXbDNc5nAYq5ZpwJE7eQyDFKTaEUzUsrXaFcar/Zc7rf3CebfApV6e89hp1nrBGegr/SF0JONI3iZMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484304; c=relaxed/simple;
	bh=g6xKvcThqp7cNcb49IH7d8Zjo3rGrlE8E1s03ZsRXRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+5DMlhA2rM75A4YviWw6b6Xz3GfECi/xDPIZnULFaox7ZRuxcWgKkNpOjFLSmxCUifjTM6vnohmCkBVoPr/HKe+0GtsXdSgh0LGUTpQweEJ4XGrJrhBhdFWY/jTZ912sezgRSvUSixglAllwVhMyJExBZgOqJ6Me1pq67jGNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ks+hFJNL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c32daf0797so27734207b3.0
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724484302; x=1725089102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6+A2VuRa3vINzgOnqqBfzLTYjWfMi7SqqtjGQfCE/k=;
        b=ks+hFJNLofwzsobn9TTYFw2gv5rAS3vQxO3b+A8iAK7NGdFj7AUwBHLP/E4yCmxADZ
         RY46MpzI/fB6iQ3eu4l6YCmDnfmxq/qqehSwyBMpwQbnjuldxdEoqZW7QzGMVkrkjgSy
         5x11LvGkzpYCowgCyrlGl1aNI0naFgXr7GQ5UtVCFuUu1x3jwPa55RKG222dn733RPIn
         wl4Wozpl0pCn4Za8GngqgF+tZX5Cbjgd3IhP7IcjnpKV2lAzjFaoaGuQMIL+Sv5b2YMZ
         okJupbJfq0aZlDRaRzdCaPDWec+sEYfylPvKxPRFMFlKugnMXj1vG/hvZbYZ8t6QVx3v
         utSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724484302; x=1725089102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6+A2VuRa3vINzgOnqqBfzLTYjWfMi7SqqtjGQfCE/k=;
        b=aqY6+ycadPcxHLye6ZIoUHa8HTZfgTiBDcTyIDL2u55P2bm3BKk+JuGIjzaHFDg5g6
         uhWaNyrhpYL2yPBgwk9F5hVV65G1t2/JsYV/zkn6yH+LzS+E0DLJvqwlEWizCY1rqNb2
         V/AuVVCdYiDrT0CSEhc5FsyB0gmaRtpF2C2nGdLuG2bAbM/4/omZRGtRplsYY9kzwscN
         xdhwVpZWwupCaDCEZ599pJFKyI1wJUz3hxKdWw+8TS4A+MrBN0BccllHvKYz4fm/c8S9
         mdGci5ld30BXBlHz6dF1etEY+CIW8eN0y9vVmNLhERRl4Z4a6nKn0hTZ1xDtv8qFVqZw
         4/iA==
X-Forwarded-Encrypted: i=1; AJvYcCXjp0+dh2g385m4poisgw+nt9knZW1B35oPCetlYPAd67RCj+lg7GJUGg+bVNMBXFYWMaFlHcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjob/gRC+56lAj5PVX1Y86mY9REoPg8lx3lUVYQNtogtvzE6Q+
	fp6edXJobD3tsA+p9TI1iJJ6wsk1R7Pc1LP7iAEWwJ9jzdQrffHpRRSLxxIn7HYmNuj0/9zK8vL
	EkpqRZFS613Ft3k0AsrLjgcu9X+uGxFsxnbGJkQ==
X-Google-Smtp-Source: AGHT+IG1BlHDuekV5AcLsj47uYwHvnVdzGRFSDLUmEl/F7Nsu+5/w5qTxjhDCMbQGyjdd5802kibXL0vaoVv13Foy4o=
X-Received: by 2002:a05:690c:6606:b0:61b:1e81:4eb8 with SMTP id
 00721157ae682-6c62538d6f6mr67130637b3.9.1724484302011; Sat, 24 Aug 2024
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com> <36272d4a-eb95-4842-b171-ad6ec39a7631@gmail.com>
In-Reply-To: <36272d4a-eb95-4842-b171-ad6ec39a7631@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 02:24:50 -0500
Message-ID: <CALNs47uKWTH9mUhEp1-f=zX8fgPpWExQWct0YYa2Q9H6yuaKJA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:43=E2=80=AFAM Michal Rostecki <vadorovsky@gmail.=
com> wrote:
>
> On 8/19/24 17:36, Michal Rostecki wrote:
> > From: Michal Rostecki <vadorovsky@gmail.com>
> >
> > `CStr` became a part of `core` library in Rust 1.75. This change replac=
es
> > the custom `CStr` implementation with the one from `core`.

[ very long snip ]

> > @@ -180,7 +180,7 @@ macro_rules! assert {{
> >       #[allow(unused)]
> >       macro_rules! assert_eq {{
> >           ($left:expr, $right:expr $(,)?) =3D> {{{{
> > -            kernel::kunit_assert_eq!("{kunit_name}", "{real_path}", __=
DOCTEST_ANCHOR - {line}, $left, $right);
> > +            kernel::kunit_assert_eq!(c"{kunit_name}", c"{real_path}", =
__DOCTEST_ANCHOR - {line}, $left, $right);
> >           }}}}
> >       }}
> >
>
> I forgot to include the version history before sending the patch, sorry.

For future reference - when replying, you should delete irrelevant
bits of the message you are replying to, otherwise things get kind of
messy.

- Trevor

