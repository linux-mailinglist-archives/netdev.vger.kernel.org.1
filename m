Return-Path: <netdev+bounces-160417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2FA1998A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A46816BD51
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67F215F4E;
	Wed, 22 Jan 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZozxSEn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5841607AC
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576855; cv=none; b=O52QnybjuaHEQQEKpqb7VqI7tnq9nRQp8l3vx2P3v7MRcRIPGGqUcpL3Qduw6+8KM6CQp0lC4bQPFF793otdxpNdoFCZGDH2JwwdY1E6ZkaWvGVuepWPcowq/nqSvYM2zXbqjt6DL3PAqqZiXRkkVH3dJh3vuVtOG1QLaH9pgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576855; c=relaxed/simple;
	bh=MQPfRLJVD9+rimsW6bt9LJMO5UnWiyoW3E9uObuUFJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkCNzauGHOPINO6kZDplCgk7wXiOKRKCg1VKQ9Pwxd3YrucgyNO07ogU+VFfSTAFs9nF32T/IIeAOCbAwTxX+/ReEFc+DK286Vf0HMy30bQ61YoNKrV/1edgr6Yp3XFqdyrsn3RC9YEEHVipg+70me1AXWAh4DKxecviTmcQd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZozxSEn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38637614567so42668f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737576851; x=1738181651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=799enZDRd68J8NTgzAbvdBKg9qVwFJkLjqAu2nTRthw=;
        b=3ZozxSEnucGoZNGBnpDYKO955PjINK9VdHMvZ0mTMyuyh72XAE0O29k3vKQcUiMQLB
         boVOANXhUMyU9uvNWl8FsP6wnUJiKf8ZXapR4V4prbYdvIYe3OykhJVipAFdy2XZVqDz
         K7UCWkNCt1gEtiFxxLZ00J8Yz1un3hMwJUjArj8Wy3+Cg3TIZ7bsyCWzQKQuYaAudm2o
         zOQgJqfLiB8YmGZ8MkRxOkRmkMuuASzgTvGanP6VSvavtptUDSF6HtgtLe0wUAzV7HSE
         eN1Q2na7FWeGxCQWIdO4EiDjIT1cDpFuTDF1GJLRce9tzd7FnSEPFSQWBOOJ2i0lYnIV
         nEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576851; x=1738181651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=799enZDRd68J8NTgzAbvdBKg9qVwFJkLjqAu2nTRthw=;
        b=IQ7qS7v/3SBKW2XH6nMmVHtUZQuIogLyR8mpU7cPL8KOg9LBJNVyU8As9l5uiFJVXa
         q543bVEEAkaXcYAvgDSqpzW6Vj3Dr87+fEwzNwDokOOWdIWyT8884QJW3RsdJCx92HQZ
         jYOkt/vN5OB+fpFLx5JHztVIe8klr97xOc11pwW4X0oQAVGN/VXYnOg+Dz4QByCq/UYi
         e06n6hat66v0tT9VqVN2a/4ZFKiyZpwPcQNeXUCETb+/MBCRkA/CoCDwh1dcG6zV+gj5
         c5IPsKeVuHxGS4aPGIIh/SL3dD/froudZv2+/G5LLfcSEZHeGEBm1a9oCUBr5O0NzniY
         CXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+uHsfkDum2YYPGuFeIg2iEzqVhJMQLWroxeZ1aauWzzYPXtplEs8vvaEDe87M/t4uzu/1FZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySU/lk+numcNvBbI0dJ+ysGm76kpnUg+UVk8TC10vnjXTfQjkq
	SIwZq9H4bSMlDGk/gf9B46BZFopqvhGs61UoRwMUTe9DbfAqMtT7mo41Swt5s144GbiAzwP2FZ7
	9Hha/shC4690hBvUUwCyM/XIJ4+H6PS6O3Sd5
X-Gm-Gg: ASbGnctLotwN7GdR29R4tCI/d4VX+7qrMBMdTa8VLY3LxLfYxW8Q0oI2AaoJ+Tem6I8
	ebCCEGv2pXgXVp4o2wW8DYOz25OFQh1ojHMo4nzL158p142+sIIEw
X-Google-Smtp-Source: AGHT+IHHFJjH3/hicgLxucZeztnwvP00UZVJLyNNL4Qv38atEuZl6Zz5YU/+f4EcPOoU7U3mCW/FWaYwviSq9tl1AGs=
X-Received: by 2002:adf:fd84:0:b0:385:faf5:eb9f with SMTP id
 ffacd0b85a97d-38bf57c91e7mr22722774f8f.48.1737576851500; Wed, 22 Jan 2025
 12:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-7-fujita.tomonori@gmail.com> <20250122183612.60f3c62d.gary@garyguo.net>
In-Reply-To: <20250122183612.60f3c62d.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 21:14:00 +0100
X-Gm-Features: AWEUYZm3UTAucx2cFmk1mTUAxOJsE7LEBH5OM1aMznsLuIfD4fH93uCjGIhAd_Q
Message-ID: <CAH5fLgiMnifHoEkExSQVcv+7amO5aXSqd9kaGfM5af4eapcHzA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
To: Gary Guo <gary@garyguo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
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

On Wed, Jan 22, 2025 at 7:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 16 Jan 2025 13:40:58 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > Add read_poll_timeout functions which poll periodically until a
> > condition is met or a timeout is reached.
> >
> > C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> > and a simple wrapper for Rust doesn't work. So this implements the
> > same functionality in Rust.
> >
> > The C version uses usleep_range() while the Rust version uses
> > fsleep(), which uses the best sleep method so it works with spans that
> > usleep_range() doesn't work nicely with.
> >
> > Unlike the C version, __might_sleep() is used instead of might_sleep()
> > to show proper debug info; the file name and line
> > number. might_resched() could be added to match what the C version
> > does but this function works without it.
> >
> > The sleep_before_read argument isn't supported since there is no user
> > for now. It's rarely used in the C version.
> >
> > core::panic::Location::file() doesn't provide a null-terminated string
> > so add __might_sleep_precision() helper function, which takes a
> > pointer to a string with its length.
> >
> > read_poll_timeout() can only be used in a nonatomic context. This
> > requirement is not checked by these abstractions, but it is intended
> > that klint [1] or a similar tool will be used to check it in the
> > future.
> >
> > Link: https://rust-for-linux.com/klint [1]
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> >  include/linux/kernel.h |  2 +
> >  kernel/sched/core.c    | 28 +++++++++++---
> >  rust/helpers/helpers.c |  1 +
> >  rust/helpers/kernel.c  | 13 +++++++
> >  rust/kernel/cpu.rs     | 13 +++++++
> >  rust/kernel/error.rs   |  1 +
> >  rust/kernel/io.rs      |  5 +++
> >  rust/kernel/io/poll.rs | 84 ++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs     |  2 +
> >  9 files changed, 144 insertions(+), 5 deletions(-)
> >  create mode 100644 rust/helpers/kernel.c
> >  create mode 100644 rust/kernel/cpu.rs
> >  create mode 100644 rust/kernel/io.rs
> >  create mode 100644 rust/kernel/io/poll.rs
> >
> > diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> > new file mode 100644
> > index 000000000000..033f3c4e4adf
> > --- /dev/null
> > +++ b/rust/kernel/io.rs
> > @@ -0,0 +1,5 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Input and Output.
> > +
> > +pub mod poll;
> > diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> > new file mode 100644
> > index 000000000000..da8e975d8e50
> > --- /dev/null
> > +++ b/rust/kernel/io/poll.rs
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! IO polling.
> > +//!
> > +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.=
h).
> > +
> > +use crate::{
> > +    cpu::cpu_relax,
> > +    error::{code::*, Result},
> > +    time::{delay::fsleep, Delta, Instant},
> > +};
> > +
> > +use core::panic::Location;
> > +
> > +/// Polls periodically until a condition is met or a timeout is reache=
d.
> > +///
> > +/// Public but hidden since it should only be used from public macros.
> > +///
> > +/// ```rust
> > +/// use kernel::io::poll::read_poll_timeout;
> > +/// use kernel::time::Delta;
> > +/// use kernel::sync::{SpinLock, new_spinlock};
> > +///
> > +/// let lock =3D KBox::pin_init(new_spinlock!(()), kernel::alloc::flag=
s::GFP_KERNEL)?;
> > +/// let g =3D lock.lock();
> > +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), De=
lta::from_micros(42));
> > +/// drop(g);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +#[track_caller]
> > +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>
> I wonder if we can lift the `T: Copy` restriction and have `Cond` take
> `&T` instead. I can see this being useful in many cases.
>
> I know that quite often `T` is just an integer so you'd want to pass by
> value, but I think almost always `Cond` is a very simple closure so
> inlining would take place and they won't make a performance difference.

Yeah, I think it should be

Cond: FnMut(&T) -> bool,

with FnMut as well.

Alice

