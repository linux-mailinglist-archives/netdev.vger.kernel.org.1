Return-Path: <netdev+bounces-120526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5655959B4C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C201C21856
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43317E00D;
	Wed, 21 Aug 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="el4ac9Ch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A514B979
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242141; cv=none; b=Zd8BUCGEkjcCcZov9WlK/xN2BgQZc7sXk3gWYuAGPFRkTpycKTwqs1NQ5SRTOyWBiu09m1Lu3ccpBAogUa3JPmoZ+d4JIXBWULMk9HNYD/IeqhzA6w+AnCGEX7zG27+tlWx5IevKqdcg7VgKrNgiSvQyXWAwAo0WDW1nRd/oYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242141; c=relaxed/simple;
	bh=DA1X9Ve0Vn6diqrYfPjFkkduWMPJiWV9pT4xIJEPvqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7l+a6nWBATCZoEy6CPcWbRXG8zMw51w/i/KbEvLC34I3fLcBhyu1iRvO//xR+Zsz/4Ludakq7Xbl8dZo1nBW7Xke00MFAw49Aap1LPk7mFTYu1puAJWSVedoCWdRtYHTuusDYk+kmK2RClKFqpVc+ky2gjXwMAiE4REPNL/40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=el4ac9Ch; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37182eee02dso432309f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724242137; x=1724846937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=el4ac9ChIdU3dbBwOzt1Ipwcxb58MCdsiuKZO3aBWpLg7jNbUs066ybdpBPeCYXCTn
         7gicQIB1zld37AXYhH5LqLi5QzYsaMWDfWln8mU8FGHaTmcwg4plNC7FxPOCOVr1WoeM
         YJZOMOBMehuGPWIDYYukie6A1j0LoQbimC9sEqdsljqKu2F987/mcxABHlMHETQXW/6z
         2PlpI3gKBbvHJPY3tna82klmpc1iFjRXYV7Gg3MfHccFrdUy+/skUWRs5xU34Y+v9IL/
         xCOcuZhEAYb1Wk5NB3832Z2tKroexKQrUsZfhTf+V0Zy/o9NLuwfCAnn6Vdx9huXTllR
         ODPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242137; x=1724846937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=rJGcUq8Dkw0i0BDTDkPr7hhAYYWn51L+XaV5MMwfFW5ZZF+c7ejgInQG4kY0D6CisW
         qVPgHycoP4pe8VIQdqIdlG5xVisFRsn2VpLIML+E/JV50Ff1Y8bp5tnB2gtWqI1YtTrF
         6YyNhqOc9B8vTXUBMSCL1XenbN9wlKxVGOq2neiVlpMxV5PRIu8DLx2tfFqW8mRIEzvu
         SY+2JatBJDTyB0a/Xy1h2/Ip7A/WFnE+EzHYbP2Wg169MM7cF/dpNApUSCCwtcdDgFzN
         KrK7cMlO3LPA1yA1x/D8WBtneb8O2w7UW5QWxCM4xgFNfkLOjCik6ze85FRfp3d85Zn1
         z99Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnh9jC3agv2nXGDi6Gm2o5+InI3UjHwtGCtjxsqnALlj9XRbpKhxcn3lC+fB7F4uJOJ7FdjJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIUTK+j6KfhIyt2qTWO9RBi72yv5jH7JLmB/ojWcSlhM9V+QE
	XCOsQfjRU1+XXYQLjQ45ABB/8IThmJyBMfenHAU3XpOvsDp0wKx8hdvhbbI345Bjg6MEwqzlh4z
	AMs9kXlav0Jho9a2ceyykE9W65DKcjsKZGWPu
X-Google-Smtp-Source: AGHT+IF/+B4e2rOwDucRvS4kWT6EeKo58j00U+Ub/62J14Eex9C5zjjnxt5zAjMaLCrIZo2JrYvwnhV20MJ6wjBJhW4=
X-Received: by 2002:a05:6000:b01:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-372fd98d681mr1189198f8f.0.1724242136775; Wed, 21 Aug 2024
 05:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com>
In-Reply-To: <20240819153656.28807-2-vadorovsky@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Aug 2024 14:08:44 +0200
Message-ID: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
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

On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail.c=
om> wrote:
>
> From: Michal Rostecki <vadorovsky@gmail.com>
>
> `CStr` became a part of `core` library in Rust 1.75. This change replaces
> the custom `CStr` implementation with the one from `core`.
>
> `core::CStr` behaves generally the same as the removed implementation,
> with the following differences:
>
> - It does not implement `Display`.
> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> - It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
>   `*const c_char`.
>
> The first two differences are handled by providing the `CStrExt` trait,
> with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
> `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
> implementation.
>
> `DerefMut` implementation for `CString` is removed here, as it's not
> being used anywhere.
>
> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>

A few comments:

* I would probably add CStrExt to the kernel prelude.
* I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
`DerefMut for CString` instead of the other way around.
* Perhaps we should remove the `c_str!` macro and use c"" instead?

Alice

