Return-Path: <netdev+bounces-120605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9D959EFF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B3A28436F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220B1AF4D6;
	Wed, 21 Aug 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dolPsNWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430A1547D7
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248067; cv=none; b=JkQlFQB3Wdn907Ottr445T4zJJpD42MhJqV0xZ0T6CSZ61CKQ+rkiZfivSoDS6UjDvNjLH+0HfdFIGw3W7Y2WAMW5iz0GOTmhSqcJV0eBuHlnl2a2NuRUViS+G0q0caIZrti4xJw9HQJ5JX95x0/a95d7RsabdIRWmserCnRtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248067; c=relaxed/simple;
	bh=gwLjHNTsXHMmlKgeIfCrG8pO4t2Y8x/pcVf6IX7HJS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2Gx3jp14gTp/VkAs81aM2zt41N4M3QtIiTgj1g+xVv8ldMeLo+DkgJYn/Yb8A9CVt3pw3lQoqx6P1K2vZsvekwU/AwlCvqcuSAhiaC5CSbJwnA3k0naMMUMKphelHYcUFWhZeruzX4uanCdiJLQpInPsodk+4ePrSxpa5t8Frg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dolPsNWv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so48418185e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724248064; x=1724852864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZR2V02XpqNEW9fvu30UGOqjOdE3SQr9bcH8M/YKkZE=;
        b=dolPsNWvrSeN1bjtX6ZyZ4JT8coc+48QIJvDg6MwxbHw4pe3mbqEbesmqh2lL+eRSt
         ReiP3BYXHER5gTs/Jgp7JRX0IWMn6sHNnDz11HD7NaNDq9cJKYxk1YaAP+epj1nRgN9h
         Sj7nO0Ht/2ie9fOWrMi51EH3Vy6GHn3Gk0K0fchKPqn9daRfq3eI4R9HalWAJ9asFj6h
         GMAfKvdYGyPmjpsjCxvrZm+xtqrdrSYM4MTJ6uJQuR94rao+lhvsaPPrk/apjYCHkvpX
         YFgneHgTgJYG89FU7AH00ltJjxOda2SnkXlEoYvjNcTsNKeQlI8Q1W/gIeDUqATCQfRg
         3ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248064; x=1724852864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZR2V02XpqNEW9fvu30UGOqjOdE3SQr9bcH8M/YKkZE=;
        b=Gx16ljDc/jiDKUy1QDGEVUk/pakHDf5PD1ZAB1qmfeiyh9KSx1G932P2YCQ8l9L9RX
         BAN1zF4MGrRfQOaPmFZR/fWGvd1VgsJpPj7uLo85nFWJi51SxoeeGRCrNjWQPYNrrps4
         ooBf3T/nKvFXKA7gewGiPj5rftj4cifg1QZr/oVT9DlMv8U3P7LHoDlFN8zu9lHNLPbB
         r6RC4jzw0qgs9ElfyUuewJBw9L58FEiouL2gb+uabrZs8kmtUsakSkNHrAbHqNsL5+Cn
         dIpW+gbnJjKpJkIFQJ3kLx8HDxk990OqIwQxgeW9oqE4KVLyvg/l0yxWWcWwBPOTSG4l
         haBA==
X-Forwarded-Encrypted: i=1; AJvYcCWekusfWEeKt8VUNUdYLNo5NAB8UQMMCaZdXPTsstqg+ZqRXITj6WSCOdq1BTDZX+hZXXE4E6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAou88uUKIUF0KSp4qaqE9lnMMite5S8mbxR+bC1PQshWEzfkD
	bcrC1ig1IXV+x2sh85Frobf1EO1PEC0s3TL8vlLudAWaiDHtI1KjXngM092Q9IIAUoAFCu0Hpjj
	9WX5DMfv7cjnDk0jYgNRW4CVwAhHwUZiJGyIz
X-Google-Smtp-Source: AGHT+IE+WRPQ5cxJkts/8lQ1Pyrz4IDfgbmZOe9kRkxkJ6+Ctq49hnrFtuGR4cuPoH3txY4c4UXweZZ+1LQnmVHuF+A=
X-Received: by 2002:a05:600c:4e91:b0:426:6f5f:9da6 with SMTP id
 5b1f17b1804b1-42abf096794mr15321995e9.27.1724248063553; Wed, 21 Aug 2024
 06:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com> <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
In-Reply-To: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Aug 2024 15:47:31 +0200
Message-ID: <CAH5fLgiRPOVRsF5yz6d-fOciHg1EcwjD21eAgu4sSynSSsgf5A@mail.gmail.com>
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

On Wed, Aug 21, 2024 at 2:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail=
.com> wrote:
> >
> > From: Michal Rostecki <vadorovsky@gmail.com>
> >
> > `CStr` became a part of `core` library in Rust 1.75. This change replac=
es
> > the custom `CStr` implementation with the one from `core`.
> >
> > `core::CStr` behaves generally the same as the removed implementation,
> > with the following differences:
> >
> > - It does not implement `Display`.
> > - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> > - It has `as_ptr()` method instead of `as_char_ptr()`, which also retur=
ns
> >   `*const c_char`.
> >
> > The first two differences are handled by providing the `CStrExt` trait,
> > with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
> > `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
> > implementation.
> >
> > `DerefMut` implementation for `CString` is removed here, as it's not
> > being used anywhere.
> >
> > Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
>
> A few comments:
>
> * I would probably add CStrExt to the kernel prelude.
> * I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
> `DerefMut for CString` instead of the other way around.
> * Perhaps we should remove the `c_str!` macro and use c"" instead?

Ah, also, please add this tag:

Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Alice

