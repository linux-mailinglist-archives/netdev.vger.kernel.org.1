Return-Path: <netdev+bounces-161986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CCA24FD7
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DA162B77
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993331FBE87;
	Sun,  2 Feb 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSQjIiBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA78F6C;
	Sun,  2 Feb 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524904; cv=none; b=cdnf6HmeSbM1IH+tQaHvhuM1zFNiCR0gocqlM4vO1IDJafmemm+3UBCMN5G4sb+GGeonK/LlEA9wmUmgylK7OkC5RdONsnstPfW/lkLdBOre0g8N3nS5YGIp64pxSbtmqNOWXnOxfIi3yY/Bu1q+zvKsMbj/nVx909nm3qeIV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524904; c=relaxed/simple;
	bh=e9N21jvtNFe/Msv3sjxMxBadzw9ttdL4zSi3iYNXkh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWihC1AN3oVrMDIVLYKio4B9cY+i4Rf6Sa+w6/cFv7gnnMjLbwSaPxyfIvJwB725uFalRWR3UV7e/D/7KuUGCH/ANCvB6YEdBUIG2axDeqXihOUOavo8c6laEAD65TSoSmYzPb/crFqUJkqm0d1fOkJ1gSan6GIkRnpYgNx0wHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSQjIiBx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso6016719a12.0;
        Sun, 02 Feb 2025 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738524901; x=1739129701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2RaUqVREKbhY3EAZxb9ywq76j5yh9yQJJhOBP/DC3s=;
        b=hSQjIiBxqdbve8d7ZTMGfACdj23sizGwxUM2V0bM2xIxrLbCKdDTyIZ97tWc0ovmOx
         DCYNL4oTJEs21cxzLfWDn4Qa5J7OxGgitcfQguakeG8+yDG+c7uxwlvzE2fnu+NP/HjR
         hkgB0lrzeW3yMtamM3RdSj7oIcFnvQjZjKJRBZtmOC1tpeSUzXKIXO0kkwFzwakr+Ezp
         t3EGkScDk3UoRLGaOa3sw6a9zvihIUYiVJDNhsndQdAHYxHjAGj8x8arwPED2Wi2xiD2
         De7XgDZNsbRa0qmXpA+2HOZI3/NVpZ4Yb/XfzuBdi4pR8wk3jR5OSKzJ0W2S7F0CQ6jd
         hROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738524901; x=1739129701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2RaUqVREKbhY3EAZxb9ywq76j5yh9yQJJhOBP/DC3s=;
        b=GJusjUVgVpdS3X6UCVpkzvskGj447AFOp/E8DJ29rJZ2spWcldbwPSe7dt92qykCrF
         MU7s86g7FBEQnlzAUfY3A3rCEe9VFWVRjVIxZ6ITGUEhWykoIHJWMEZWNNF3rupWzU26
         x8mcVX+DZ4vil5upHPgZdKhijBjX3TC56GvBmOhdvdTsXNyWE+FyzqPZ48H0OSPLLYyd
         gxOvggfhIDz6PrHHpZemj3MjGtmSAGZBtKMcDN1cYz+Pgx7AlSPpEQ2CVHRGK+jlA7NV
         4sorl4EYiyCIyPEnXJuHLDhXZAbvQa8aWzFClNCMbn7X0e6P3XwQ8a+rcuXbtb3EpAIZ
         cFKw==
X-Forwarded-Encrypted: i=1; AJvYcCVOmElvmZmB2baobCqV9++H6nQhuxCVTBR6ujWhm60S+peyV5UMNJsNbY0FnlLRgjfGS8tGtrlT@vger.kernel.org, AJvYcCVTng8BRJ2v7JHkwyvYOS/YTmqZ3KZBdcg1OLyhFeOkRB/k1N6E+WmdJFWsUKaSOBnA/VslRYMRzj2s7vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKr+P+3qU4or4NFaYzc+Qq7hQlFIve6XSJxADPPChHcy3rM17
	eYbavGzCSue6r6LFEGwWzd0Bxjk/qqW/VvHbLSqhLcWKFXOp6A/ZbLBfMfJtLK0dp5VTRtowb28
	3OZ81SlQOCFDZbrg+pV9Bd8CUPvQ=
X-Gm-Gg: ASbGncuW4zI4+/4qorhexhogxf8FSdXNx2d9Z6FYpOVYZxbDaFV+fBwZaE9GQ19urYF
	xS3oEntEfZcOp2waLb5GGyawnnIeoOxZpndquRrowpj6Pf2CxKwwh5jplyNra/BfTluHDUKw=
X-Google-Smtp-Source: AGHT+IH95JH6BXEWseCbWij6poPQoo6VHz2EGWsC8wb+zmfvzv/+jsXglNxU9kzXRPCydDRjxsr3pf3CNr1MEEZXQ0w=
X-Received: by 2002:a05:6402:51d1:b0:5db:f52c:806c with SMTP id
 4fb4d7f45d1cf-5dc5efebd64mr18883801a12.20.1738524900584; Sun, 02 Feb 2025
 11:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201163106.28912-1-mjguzik@gmail.com> <20250201163106.28912-7-mjguzik@gmail.com>
 <20250201181933.07a3e7e2@pumpkin> <CAGudoHFHzEQhkaJCB3z6qCfDtSRq+zZew3fDkAKG-AEjpMq8Nw@mail.gmail.com>
 <20250201215105.55c0319a@pumpkin> <Z56ZZpmAbRCIeI7D@casper.infradead.org> <20250202135503.4e377fb0@pumpkin>
In-Reply-To: <20250202135503.4e377fb0@pumpkin>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 2 Feb 2025 20:34:48 +0100
X-Gm-Features: AWEUYZmIA7JgyTYxCOisCFVJgvPVvJiRJmvsImdxPgYM7n6f_txR06QRSwEKYc0
Message-ID: <CAGudoHED5-oPqb62embitG39P1Rf7EtEVODY38WB25G21-GGyQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] pid: drop irq disablement around pidmap_lock
To: David Laight <david.laight.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, ebiederm@xmission.com, oleg@redhat.com, 
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 2:55=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 1 Feb 2025 22:00:06 +0000
> Matthew Wilcox <willy@infradead.org> wrote:
>
> > On Sat, Feb 01, 2025 at 09:51:05PM +0000, David Laight wrote:
> > > I'm not sure what you mean.
> > > Disabling interrupts isn't as cheap as it ought to be, but probably i=
sn't
> > > that bad.
> >
> > Time it.  You'll see.
>
> The best scheme I've seen is to just increment a per-cpu value.
> Let the interrupt happen, notice it isn't allowed and return with
> interrupts disabled.
> Then re-issue the interrupt when the count is decremented to zero.
> Easy with level sensitive interrupts.
> But I don't think Linux ever uses that scheme.
>

I presume you are talking about the splhigh/splx set of primivitives
from Unix kernels.

While "entering" is indeed cheap, undoing the work still needs to be
atomic vs interrupts.

I see NetBSD uses local cmpxchg8b on the interrupt level and interrupt
mask, while the rest takes the irq trip.

The NetBSD solution is still going to be visibly slower than not
messing with any of it as spin_unlock on amd64 is merely a store of 0
and cmpxchg even without the lock prefix costs several clocks.

Maybe there is other hackery which could be done, but see below.

>
> > > > So while this is indeed a tradeoff, as I understand the sane defaul=
t
> > > > is to *not* disable interrupts unless necessary.
> > >
> > > I bet to differ.
> >
> > You're wrong.  It is utterly standard to take spinlocks without
> > disabling IRQs.  We do it all over the kernel.  If you think that needs
> > to change, then make your case, don't throw a driveby review.
> >
> > And I don't mean by arguing.  Make a change, measure the difference.
>
> The analysis was done on some userspace code that basically does:
>         for (;;) {
>                 pthread_mutex_enter(lock);
>                 item =3D get_head(list);
>                 if (!item)
>                         break;
>                 pthead_mutex_exit(lock);
>                 process(item);
>         }
> For the test there were about 10000 items on the list and 30 threads
> processing it (that was the target of the tests).
> The entire list needs to be processed in 10ms (RTP audio).
> There was a bit more code with the mutex held, but only 100 or so
> instructions.
> Mostly it works fine, some threads get delayed by interrupts (etc) but
> the other threads carry on working and all the items get processed.
>
> However sometimes an interrupt happens while the mutex is held.
> In that case the other 29 threads get stuck waiting for the mutex.
> No progress is made until the interrupt completes and it overruns
> the 10ms period.
>
> While this is a userspace test, the same thing will happen with
> spin locks in the kernel.
>
> In userspace you can't disable interrupts, but for kernel spinlocks
> you can.
>
> The problem is likely to show up as unexpected latency affecting
> code with a hot mutex that is only held for short periods while
> running a lot of network traffic.
> That is also latency that affects all cpu at the same time.
> The interrupt itself will always cause latency to one cpu.
>

Nobody is denying there is potential that lock hold time will get
significantly extended if you get unlucky enough vs interrupts. It is
questioned whether defaulting to irqs off around lock-protected areas
is the right call.

As I noted in my previous e-mail the spin_lock_irq stuff disables
interrupts upfront and does not touch them afterwards even when
waiting for the lock to become free. Patching that up with queued
locks may be non-trivial, if at all possible. Thus contention on
irq-disabled locks *will* add latency to their handling unless this
gets addressed. Note maintaining forward progress guarantee in the
locking mechanism is non-negotiable, so punting to TAS or similar
unfair locks does not cut it.

This is on top of having to solve the overhead problem for taking the
trips (see earlier in the e-mail).

I would argue if the network stuff specifically is known to add
visible latency, then perhaps that's something to investigate.

Anyhow, as Willy said, you are welcome to code this up and demonstrate
it is better overall.

--=20
Mateusz Guzik <mjguzik gmail.com>

