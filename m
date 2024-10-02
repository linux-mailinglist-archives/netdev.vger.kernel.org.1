Return-Path: <netdev+bounces-131204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2098D36B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E51F21100
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E11CFEC2;
	Wed,  2 Oct 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GETJ04J0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472B1CF5F8
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872691; cv=none; b=T66Go+ZBu36aJjF0+jVOcRbbsy1HWvDkoTscTLS4zH90BrtR9Q1prF77aPuUIuX8+Sihwgei+vSGumrvpyn7BmX6pFEaXstoS7TC5knh8no5eKfQZBFnYYa9priSnm8kb1I3OaVdxN5C/xZuLtm5wigY+gsjU/XpjQDR1Lbrskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872691; c=relaxed/simple;
	bh=Pn3CYClBVb6o/pVhWHd25JnL1eOmV1/V8byX2TfEZhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFir1rpzxK2WcFOMUOcztib2BQ94Tm483xGaBfG/BuIv+kmOS77h67ExkBKvqUDZa0M+JGXQS3iSwaD2JJXBsXr0lsaDLuSfyy9zFnpmzG9F6YswV9u08XbnKo1zMg222nNVdoPwDNYm9HQl2LF16xLtO+oepooV0u4G9HSH9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GETJ04J0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd3419937so3462259f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727872688; x=1728477488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn3CYClBVb6o/pVhWHd25JnL1eOmV1/V8byX2TfEZhc=;
        b=GETJ04J0B8f+DFCVSsbdafzWZ4lhE4QQjauNnnr4iGkC8cTTcwr3gasz4kHR09Ep2k
         kBbDt3kBambgdyK/9h9LU20oGUPzXpRyXeGhWBWqj7gydh5vYiCUb3cZ7qERofVrjPWN
         MC5+hRSlLkeRliokjYWwyRcWEKZsR8rF7WgkWISGlAo3pQgiYB4any48npFHjB8iNIwi
         S/lhrARfXGxlBr3HitPEFJn/Yftk/UT4y5/UERAVV0a19F5+OAiU8IyK9h/jZ4R8iWQK
         22uP589icZFQrgV9cMjj17R+wEFaDSyGnzzhLrfYudL/rsvuCkt+7LprUPtH8cqmDWZo
         SU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872688; x=1728477488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn3CYClBVb6o/pVhWHd25JnL1eOmV1/V8byX2TfEZhc=;
        b=cWd7e5fumzw5LV4J1qlzhK1WZRgfo1drtpOWbPKNAD5hDZ5X/g0ALFXIe+uUIkgkbG
         /GmQxKRX909Qm8Zu7ARH1m9/IFqGoXZhjG5JSWRtX+F8MUMwiFJyf33VsvFJY4QHORAO
         FbkyNh5Y5fZqAXMs5PLmWdVNf5Bg21RjwlBo29XUlrrvP4rXYlLz/j1eEbYJKXF8BepS
         NuipDgq9NJ7cEG25JkwzcCgmpV4PTBj7OY4iH9QUY75FQlWUTcB9h2o5K9o25qdgUu3a
         5O0b0EuHddNW/ikO3euSEM6TKdCaVeLVxhJ2Rkbnckxu4V8mPI+12d4pEWCXaM+Jm9X7
         ztCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWrWMMrymhW6PdC2S2N59h8J3IE2y1wJuXKTvQbqGlNgIDOBDyuHMxzKiHyqPBsHnWxPnw9KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYbvtDZSdP76Dwo9t8MELnW0oA0s+AFPK0rgvlhgKY7KIuBkZ
	+Lcq9Azjkh3sF0al9VlaNHUCfXglTqH/4ssT1MhisIklvyE1RENHOCnQPPkPDuO92qHirBce1cJ
	agwFA3+lK7rjuvkIZbAFLR8v5tIX9OLvxklwPXZ3yA3Tkov18gw==
X-Google-Smtp-Source: AGHT+IF+H2hRAM6EUPGr2ATFkhEUAoNpz/F+VzyQ3OYvngiPSdQ/zAPeiQgR+DhCsjBfZsD7w6WAeLJHH7yH6F057xM=
X-Received: by 2002:a05:6000:2cb:b0:374:fa0a:773c with SMTP id
 ffacd0b85a97d-37cfba0a409mr1911108f8f.47.1727872688302; Wed, 02 Oct 2024
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com> <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com> <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
In-Reply-To: <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 14:37:55 +0200
Message-ID: <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > I would also document the units for the parameter. Is it picoseconds
> > > or centuries?
> >
> > Rust's Duration is created from seconds and nanoseconds.
>
> How well know is that? And is there a rust-for-linux wide preference
> to use Duration for time? Are we going to get into a situation that
> some abstractions use Duration, others seconds, some milliseconds,
> etc, just like C code?
>
> Anyway, i would still document the parameter is a Duration, since it
> is different to how C fsleep() works.

I'm not necessarily convinced we want to use the Rust Duration type.
Similar questions came up when I added the Ktime type. The Rust
Duration type is rather large.

Alice

