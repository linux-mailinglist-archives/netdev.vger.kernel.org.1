Return-Path: <netdev+bounces-43237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4A7D1D2A
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5F428230B
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36501C2D;
	Sat, 21 Oct 2023 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imxkYajm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7575A48;
	Sat, 21 Oct 2023 12:47:21 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DB1A4;
	Sat, 21 Oct 2023 05:47:17 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a87ac9d245so18604647b3.3;
        Sat, 21 Oct 2023 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697892436; x=1698497236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak0J9I1wxFXOFeFSUtB9w8Likk7tXaYYsKRE/whJO7k=;
        b=imxkYajmixTDAXaGgQgmwQgfo6S9yksyu+7MDR6/F6Lqkx+jgREH2PzuZ5zaJY8Uch
         0sOEic10PcGPqYtKCzYumGVmWKmCCQd916TJJYWi1gtjt4lpohqd99dZ1wv+2gWvvgX9
         cD93pbVGM+Dej+chn91OFQXXtXqqZ+VEIjGNX9JTPjY9tBSSiEfr7XVusy47p7QTgWjO
         akdcEwMzZxvwmraQeHZqUC0L4PPRekB4/crW3DApyCdYQiCari1S1y3BeAKPWA5KMpE9
         IUSfAXDRQLnalX57Q+01okVLL5vjO/xXqlvSPtJ1co99qVv8UGyYaq2pc8B32w+FTUgC
         GddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697892436; x=1698497236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak0J9I1wxFXOFeFSUtB9w8Likk7tXaYYsKRE/whJO7k=;
        b=g11McG/HGcHmgWVBL9W+CrrD3Yl6L+4Mv5yETZ1lOQgYbtg3pFiCIc8JOxdFPllgf7
         f3qOAhtwcWM5YEoJB4wVMKPQwGYex5TO9qkpAEWgZciLek2j5lvDoAJaPGqjMO0fiYTy
         OGqync3m/cUEcOip7yTumqSDtZe0lINJQQfaiZhOl4uY1OEWZnPxrspE1FTyxvywc2XM
         gQWLYsN36DcN+nCoj11wKRgC0N+bdRhMiFMZmXCNZznRiJrfmGGBnvpgPMGO80I32HCu
         XZAcopP1IWnYgeT4+d2+ZnxQY23cwIe+GAWfu9KEPw2iUFu/j0yy6uWk2y/u4ioZkuIq
         bbkA==
X-Gm-Message-State: AOJu0Yyr5kRzgiuGeiaNnDY7Ep9h6ZwBpU8QeEHg/z1R+EqTOnN++z1k
	ydq0BqQT9wox5mtOiWPZaIxtoy5lsUUKhp+PKrPquT/Pp0Da2ULl
X-Google-Smtp-Source: AGHT+IEeqtZaOp4XqRgyXGo/jA+okPIOTbzyiTwAKkpSrVQPXQcZCy/7MUrRMlw8uZKFEGWHDGRB177BLApEYx+MMtM=
X-Received: by 2002:a05:690c:10:b0:5a7:b53f:c304 with SMTP id
 bc16-20020a05690c001000b005a7b53fc304mr5334065ywb.37.1697892436166; Sat, 21
 Oct 2023 05:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com> <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
 <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
In-Reply-To: <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Oct 2023 14:47:04 +0200
Message-ID: <CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> We don't want to hide phy_device too much, since at the moment, the
> abstraction is very minimal. Anybody writing a driver is going to need
> a good understanding of the C code in order to find the helpers they
> need, and then add them to the abstraction. So i would say we need to
> explain the relationship between the C structure and the Rust
> structure, to aid developers.

I don't see how exposing `phy_device` in the documentation (note: not
the implementation) helps with that. If someone has to add things to
the abstraction, then at that point they need to be reading the
implementation of the abstraction, and thus they should read the
comments.

That is why the helpers should in general not be mentioned in the
documentation, i.e. a Rust API user should not care / need to know
about them.

If we mix things up in the docs, then it actually becomes harder later
on to properly split it; and in the Rust side we want to maintain this
 "API documentation" vs. "implementation comments" split. Thus it is
important to do it right in the first examples we will have in-tree.

And if an API is not abstracted yet, it should not be documented. APIs
and their docs should be added together, in the same patch, wherever
possible. Of course, implementation comments are different, and
possibly a designer of an abstraction may establish some rules or
guidelines for future APIs added -- that is fine, but if the user does
not need to know, it should not be in the docs, even if it is added
early.

Regarding this, part of the `phy` module documentation (i.e. the three
paragraphs) in this patch currently sounds more like an implementation
comment to me. It should probably be rewritten/split properly in docs
vs. comments.

> During the reviews we have had a lot of misunderstanding what this
> actually does, given its name. Some thought it poked around in
> registers to get the current state of the link. Some thought it
> triggered the PHY to establish a link. When in fact its just a dumb
> getter. And we have a few other dumb getters and setters.
>
> So i would prefer something which indicates its a dumb getter. If the

Agreed.

> norm of Rust is just the field name, lets just use the field name. But
> we should do that for all the getters and setters. Is there a naming
> convention for things which take real actions?

For the getters, there is
https://rust-lang.github.io/api-guidelines/naming.html#getter-names-follow-=
rust-convention-c-getter.

For "actual actions" that are non-trivial, starting with a prefix that
is not `set_*` would probably be ideal, i.e. things like read, load,
push, init, register, attach, resolve, link, lock, add, create,
find...

Cheers,
Miguel

