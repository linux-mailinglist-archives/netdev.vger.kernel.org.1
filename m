Return-Path: <netdev+bounces-160377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B95A1972A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150873AAC90
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DC215198;
	Wed, 22 Jan 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWOUPjRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102921518B
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565633; cv=none; b=P86f6E9FtbNZjhzvGCqQQKdvzs7ne6WV0yD8yI52dJdqnKDOIVtgjSMf+HVaFc51PgHIU6ly0k1iTdeIHtd5aYjkpdt3t5k1qwJn2evTS2wyS9I0B/jFpqmuumn6Af19hjY5GrqKZq3/pFL1FR0+KpZ26E8Yx1XSKKaRsAUIQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565633; c=relaxed/simple;
	bh=JNLfOH2aw7sz7Mhi4i5wKbrYE0THrHyy8wbZWOqimvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uofs7MlAxmqmb9NwCKoww3lJZv5NEu4PzieGCdyXzFMLAEaokbo9h46wG7ogOEBLGuS3CsuIgcQrE+fZPX00xLp3xOB5HfqjNcWaxvE/0MY0yR78TI9GSCFnvZG0Bo1iToFQ0bWR/V/8g+4CdgqZ5gl6KsV77FRrs1R9BpQr7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWOUPjRt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43675b1155bso82475395e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737565630; x=1738170430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjbbvIvJnn+F42E7z2PwvrYdTyPTjvfdjZn3qHYBHrA=;
        b=WWOUPjRt7XNJyqqqB59mk7D0us2lGq9SVJFuATIKcpbIFl6R87t0xIfUFk/jwsauPW
         QYDxXFFreDZNgYZ2ntwtK9g47wBfv6Qnskg2/lbvS+rVb3vZ4QNZSJXx+bZT9rrvqn48
         ddqftx7bHREFKvwoeiaGbAkYWtlsRMj4E9VExung3xVlxTm11gdL5+Mpuo8RtkMGDqV3
         WXcl2roFjVp4tXDPjIwhRWvyB9c0kE8JmHC+BZZvjXjMfqba17gqbjHl6BGtMc3DOSVZ
         MYf1C99YBBLScrthPPgOzB2/Ho7tuzJB+VKcTbxs3Iym8G/rXngM90QRfJ3oAexPj6GT
         qhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565630; x=1738170430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjbbvIvJnn+F42E7z2PwvrYdTyPTjvfdjZn3qHYBHrA=;
        b=czZ/6GYwSm5ZSBjmPyTAPzjpfrFlI1ionSBVYScvIOXdaS8bPFlc9h8eQDG7gkjPxM
         9K/khZ/CRLOZtoUvlOSiVIuVU/x6mO2SQb4x7TYi6vFKrBQSOWPlZlcmUCOdNiRZe+SC
         hvVY9bIwoMG9LMVB8QOzxs5V8Sb22ZH3s24ChymiwlKtqUQpwsPWc20h7bEYzcWLG/zk
         0DeMQFaMMvamjn4lQ2KQ53VZBUjDYBZzctNv+RY3zt42c38VUyZWPiq8iC6AToQkkuoi
         PZhpfgsEmo5c+Gmg0U6lbEQtMof1s/3Ii43/lsm0U5faU+sgdLnejesQC+H+4ZMRyija
         zTxg==
X-Forwarded-Encrypted: i=1; AJvYcCVIt/b5FnB21A/hINtrOhfN0YgXRHoSpvdg3g41hZuwjYh6SEno1RVMomCk2X4jXBjec31MtzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/onSC6/u08YLe3nqLo8ryPorCEWr1CFus5g5ovA79G5/oZ+1
	Ivm2f1O3xpMfCkM4f/1cSSP0Cb3FjL08/vWR2RJ8s/XPHBteTQn/TyyA1KqX6tvH5Vq5H32RMHZ
	le/AHc5SMfNSjnURhBpG62jl0QnR3h9g9lSaA
X-Gm-Gg: ASbGnctAbmm2yPSp/BqDijg3KyjeO4dcVnI6BD62viULfn07F2TqnfoWgnyQSWqxFtf
	OcAW3VYwxFBTEvbUMQKuSLEuiZ4Ilr3NJ9coXTis3vKOEFW9vMa0/
X-Google-Smtp-Source: AGHT+IH6TtBLgKrmRaEuAzXOid7fbYxQlKAbzpwzx1uSou94uVrj8sOvdmqZwkIgQNpxwgf91vHw3VHXDN5R2jcADck=
X-Received: by 2002:a5d:5984:0:b0:38a:4de1:ac6 with SMTP id
 ffacd0b85a97d-38bf56555e9mr19777380f8f.6.1737565629943; Wed, 22 Jan 2025
 09:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-5-fujita.tomonori@gmail.com> <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
 <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com> <20250122170537.1a92051c.gary@garyguo.net>
In-Reply-To: <20250122170537.1a92051c.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 18:06:58 +0100
X-Gm-Features: AWEUYZmQ38ItMMuP4jNhT2eiJ2jH0mWYg_mL8dk2ga5-CGUrqvDz4IBv-_0ZZi4
Message-ID: <CAH5fLgiEn27VMUfrXcidu0rUpM7MPZVCOjywa-vQBO7dOdQrRQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: Gary Guo <gary@garyguo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, miguel.ojeda.sandonis@gmail.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 6:05=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 18 Jan 2025 17:02:24 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > On Fri, 17 Jan 2025 19:59:15 +0100
> > Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > > On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
> > > <fujita.tomonori@gmail.com> wrote:
> > >>
> > >> +/// `delta` must be 0 or greater and no more than `u32::MAX / 2` mi=
croseconds.
> > >> +/// If a value outside the range is given, the function will sleep
> > >> +/// for `u32::MAX / 2` microseconds (=3D ~2147 seconds or ~36 minut=
es) at least.
> > >
> > > I would emphasize with something like:
> > >
> > >     `delta` must be within [0, `u32::MAX / 2`] microseconds;
> > > otherwise, it is erroneous behavior. That is, it is considered a bug
> > > to call this function with an out-of-range value, in which case the
> > > function will sleep for at least the maximum value in the range and
> > > may warn in the future.
> >
> > Thanks, I'll use the above instead.
> >
> > > In addition, I would add a new paragraph how the behavior differs
> > > w.r.t. the C `fsleep()`, i.e. IIRC from the past discussions,
> > > `fsleep()` would do an infinite sleep instead. So I think it is
> > > important to highlight that.
> >
> > /// The above behavior differs from the kernel's [`fsleep`], which coul=
d sleep
> > /// infinitely (for [`MAX_JIFFY_OFFSET`] jiffies).
> >
> > Looks ok?
> >
> > >> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit=
 architectures.
> > >> +    // Considering that fsleep rounds up the duration to the neares=
t millisecond,
> > >> +    // set the maximum value to u32::MAX / 2 microseconds.
> > >
> > > Nit: please use Markdown code spans in normal comments (no need for
> > > intra-doc links there).
> >
> > Understood.
> >
> > >> +    let duration =3D if delta > MAX_DURATION || delta.is_negative()=
 {
> > >> +        // TODO: add WARN_ONCE() when it's supported.
> > >
> > > Ditto (also "Add").
> >
> > Oops, I'll fix.
> >
> > > By the way, can this be written differently maybe? e.g. using a range
> > > since it is `const`?
> >
> > A range can be used for a custom type?
>
> Yes, you can say `!(Delta::ZERO..MAX_DURATION).contains(&delta)`.
> (You'll need to add `Delta::ZERO`).

It would need to use ..=3D instead of .. to match the current check.

Alice

