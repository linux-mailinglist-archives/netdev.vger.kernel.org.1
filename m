Return-Path: <netdev+bounces-161990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28BA24FF7
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 21:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C8E1883D1A
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEBF20B814;
	Sun,  2 Feb 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw1lMt8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1C8F6C;
	Sun,  2 Feb 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529097; cv=none; b=eXa8eYv31cNvh6DS7qKQu4J3bw+t3a85kdF/7mwpxX1I8H/lGVdxyoRtRiQE6Il5bb1e4uUFbw5czc80GYmMWtlzEqxLtIalGfUFBtKB8KW8PFCtjxOEjOO5CrBh/pNgKfmhZKJ80wChDMzGipzZkYGjg+M0CULCaGLXT2CygtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529097; c=relaxed/simple;
	bh=ByIT6O2MQ8AeBF3aaiyNh/HTBIpkXFi2GmOxu/ewkjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRjPqBK52iAfNAJ9toSlnA/XbbHL2+b7uyWkvr5BF2NVFp6sUWxStdoHw8NBPXYeMr3wiCqAMQJX8awB6j7S1rc5sxVMt2UtCM/xrVPEm9d0TVB44PXYk9YD3m3jkmt8g07nig4Ddj6QsPPcY3Ay0RX6n6k8F8vS2nPDTO0HqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw1lMt8M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436345cc17bso27501185e9.0;
        Sun, 02 Feb 2025 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738529093; x=1739133893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbSx/ISaCz+L+0YMvLHQK84mnVS9XArcMwXBbJKLocA=;
        b=Pw1lMt8MBAg/XEOr0QY98X3tsMAmix8xhZ5oyFJCYppt/p/o11hnE45ZZEABNv+Uas
         e8IJfhmRFemZHAvo9Iii3dTd6s4HlYbeLh/aaTldO8gD5oyyeIBsDMG+m1v3fjOnPSGO
         KwoIC35kKnnPrgPUpq1WPLsmuSARqp3HazTiDmn+emCeCrtHFacZJHKK+N6IxQJpLLob
         tHXQzYIigCXfIGIkAUiD0KSd1TRFoSn3R8WQxsfhtPRzkJOSApjD6hbxxKhpT8t2T8Es
         5Rgy7s+IKSJEBMPDQPuoSRO6m3nD0L1y4Yf7TglbgWgcpGh+CHI9k74DG6ykVxcg3Ktb
         48kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738529093; x=1739133893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbSx/ISaCz+L+0YMvLHQK84mnVS9XArcMwXBbJKLocA=;
        b=RmrekS4elt9eknXVLo/ThCRR27p6ac+H6RynLMUpCdeHLg3/5VfCjDBFmkYOeIB3uL
         c00748FLBKKXUsmx82u8ptzp4ensBm+qxX7jF8MhllHZXgdWquKlnF6TUwAXMaE56VwP
         BCG2B2fo0H+lEyDMMmji3Mt2y174Qk6wDxLi9cugTKmZCGjTThCu9Wand2BSICz/twqx
         1WWFSjl7aT5X1tFUKRDgAh7et3k1coCHVjwtm2PLv7b0IcqvjiR868qUv85YJIUgdlDE
         ZGP1RdaPWibtGR+e+3HxXannXSz8Gn/BcfeNBVPlKRuAg/MMi7TxBxsqgeriRZyuf5sc
         VlNw==
X-Forwarded-Encrypted: i=1; AJvYcCUKQKyXRDnxFTBx2+2gTyHseATzwGLEULONvo40yWoRg1CHAss/MSb600Dy4eqsaphc9jhuM/Z/vt+dNOg=@vger.kernel.org, AJvYcCW7RaRiRv4/Q/zlyLu95a/3BEjAHmDbVL8nq9FXYoJna5t67NqBhBYW7H4QVh1EZXj6LJ9RXzz5@vger.kernel.org
X-Gm-Message-State: AOJu0YyInnQF/hIhLRZypiFY78RfjNQTLzJL5zZRv3jr1ao3VfPWX1WR
	ZCaojyyk/BjcW85d9ypj/aulbRMh9aH+hEUEC6Oy2aXkIVFBeBmc
X-Gm-Gg: ASbGncuI63JaPJFbI7oYXJHb9nq2EAA68o7AoxsQeGF0Jvt77No3GDbh91TiRXuRipn
	4XiEvnBBshNw5riY1Poq3MM4tHV3Lzv0szcks1Xo0P7cKZ/9r1P9O78cgjtdsrgAqLdt6jVpR5S
	ZJ2lKAITLKmrhPjpfosgPXQHQOIPArQPiG4D2j2lWtobzhAgI3ioZ47HyrCvEj2Cp9USmTpW7qM
	67yuo8x3DbK+e46x40qsDW6/Hc/a9k1pXgvIAQL3Q/+WphxMmre4sU3sWgwKgfcAdl79FL0+qUc
	lAjSwPP4OrPT8cQJhHJ56FJ/XB/Y2AVHky+Dea0LCmekYVXDEf/H6Q==
X-Google-Smtp-Source: AGHT+IHLsWh/YGpljPw48TJZyadtyPAWHtbeX9ie2f3Bzm4IzJqabYq5/PboSRajCtTjNtqAWvC6/w==
X-Received: by 2002:a05:6000:1561:b0:38c:5b52:3a47 with SMTP id ffacd0b85a97d-38c5b523e1dmr9683706f8f.4.1738529093086;
        Sun, 02 Feb 2025 12:44:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b595asm10875448f8f.66.2025.02.02.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 12:44:52 -0800 (PST)
Date: Sun, 2 Feb 2025 20:44:49 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, ebiederm@xmission.com,
 oleg@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/6] pid: drop irq disablement around pidmap_lock
Message-ID: <20250202204449.77cab5e5@pumpkin>
In-Reply-To: <CAGudoHED5-oPqb62embitG39P1Rf7EtEVODY38WB25G21-GGyQ@mail.gmail.com>
References: <20250201163106.28912-1-mjguzik@gmail.com>
	<20250201163106.28912-7-mjguzik@gmail.com>
	<20250201181933.07a3e7e2@pumpkin>
	<CAGudoHFHzEQhkaJCB3z6qCfDtSRq+zZew3fDkAKG-AEjpMq8Nw@mail.gmail.com>
	<20250201215105.55c0319a@pumpkin>
	<Z56ZZpmAbRCIeI7D@casper.infradead.org>
	<20250202135503.4e377fb0@pumpkin>
	<CAGudoHED5-oPqb62embitG39P1Rf7EtEVODY38WB25G21-GGyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Feb 2025 20:34:48 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Sun, Feb 2, 2025 at 2:55=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sat, 1 Feb 2025 22:00:06 +0000
> > Matthew Wilcox <willy@infradead.org> wrote:
> > =20
> > > On Sat, Feb 01, 2025 at 09:51:05PM +0000, David Laight wrote: =20
> > > > I'm not sure what you mean.
> > > > Disabling interrupts isn't as cheap as it ought to be, but probably=
 isn't
> > > > that bad. =20
> > >
> > > Time it.  You'll see. =20
> >
> > The best scheme I've seen is to just increment a per-cpu value.
> > Let the interrupt happen, notice it isn't allowed and return with
> > interrupts disabled.
> > Then re-issue the interrupt when the count is decremented to zero.
> > Easy with level sensitive interrupts.
> > But I don't think Linux ever uses that scheme.
> > =20
>=20
> I presume you are talking about the splhigh/splx set of primivitives
> from Unix kernels.
>=20
> While "entering" is indeed cheap, undoing the work still needs to be
> atomic vs interrupts.
>=20
> I see NetBSD uses local cmpxchg8b on the interrupt level and interrupt
> mask, while the rest takes the irq trip.
>=20
> The NetBSD solution is still going to be visibly slower than not
> messing with any of it as spin_unlock on amd64 is merely a store of 0
> and cmpxchg even without the lock prefix costs several clocks.
>=20
> Maybe there is other hackery which could be done, but see below.

I was thinking it might be possible to merge an 'interrupts disabled' count
with the existing 'pre-emption disabled' count.
IIRC (on x86 at least) this is just a per-cpu variabled accessed from %fs/%=
gs.
So you add one to disable pre-emption and (say) 1<<16 to disable interrupts.
If an interrupt happens while the count is 'big' the count value is changed
so the last decrement of 1<<16 will set carry (or overflow), and a return
from interrupt is done that leaves interrupts disabled (traditionally easy).
The interrupt enable call just subtracts the 1<<16 and checks for carry (or
overflow), if not set all is fine, it set it needs to call something to
re-issue the interrupt - that is probably the hard bit.

>=20
> > =20
> > > > > So while this is indeed a tradeoff, as I understand the sane defa=
ult
> > > > > is to *not* disable interrupts unless necessary. =20
> > > >
> > > > I bet to differ. =20
> > >
> > > You're wrong.  It is utterly standard to take spinlocks without
> > > disabling IRQs.  We do it all over the kernel.  If you think that nee=
ds
> > > to change, then make your case, don't throw a driveby review.
> > >
> > > And I don't mean by arguing.  Make a change, measure the difference. =
=20
> >
> > The analysis was done on some userspace code that basically does:
> >         for (;;) {
> >                 pthread_mutex_enter(lock);
> >                 item =3D get_head(list);
> >                 if (!item)
> >                         break;
> >                 pthead_mutex_exit(lock);
> >                 process(item);
> >         }
> > For the test there were about 10000 items on the list and 30 threads
> > processing it (that was the target of the tests).
> > The entire list needs to be processed in 10ms (RTP audio).
> > There was a bit more code with the mutex held, but only 100 or so
> > instructions.
> > Mostly it works fine, some threads get delayed by interrupts (etc) but
> > the other threads carry on working and all the items get processed.
> >
> > However sometimes an interrupt happens while the mutex is held.
> > In that case the other 29 threads get stuck waiting for the mutex.
> > No progress is made until the interrupt completes and it overruns
> > the 10ms period.
> >
> > While this is a userspace test, the same thing will happen with
> > spin locks in the kernel.
> >
> > In userspace you can't disable interrupts, but for kernel spinlocks
> > you can.
> >
> > The problem is likely to show up as unexpected latency affecting
> > code with a hot mutex that is only held for short periods while
> > running a lot of network traffic.
> > That is also latency that affects all cpu at the same time.
> > The interrupt itself will always cause latency to one cpu.
> > =20
>=20
> Nobody is denying there is potential that lock hold time will get
> significantly extended if you get unlucky enough vs interrupts. It is
> questioned whether defaulting to irqs off around lock-protected areas
> is the right call.

I really commented because you were changing one lock which could
easily be 'hot' enough for there to be side effects, without even
a comment about any pitfalls.

	David

>=20
> As I noted in my previous e-mail the spin_lock_irq stuff disables
> interrupts upfront and does not touch them afterwards even when
> waiting for the lock to become free. Patching that up with queued
> locks may be non-trivial, if at all possible. Thus contention on
> irq-disabled locks *will* add latency to their handling unless this
> gets addressed. Note maintaining forward progress guarantee in the
> locking mechanism is non-negotiable, so punting to TAS or similar
> unfair locks does not cut it.
>=20
> This is on top of having to solve the overhead problem for taking the
> trips (see earlier in the e-mail).
>=20
> I would argue if the network stuff specifically is known to add
> visible latency, then perhaps that's something to investigate.
>=20
> Anyhow, as Willy said, you are welcome to code this up and demonstrate
> it is better overall.
>=20


