Return-Path: <netdev+bounces-192425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ABABFD93
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFA618898A9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860EF19EEBD;
	Wed, 21 May 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7ztdBc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB179172BD5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857107; cv=none; b=T8E4Jo2PyTiX5vipcZU0jkpYSTvHUDVbQ9du1Fnls9r7jXYe1QVpfS8V+izfvB6GOxoTmZvpZ77OvWOVJn/uM06wStM9IczrL/rUtcpecxt+jkEHlG8AlptNzjBN+3fda8XFquk/PrlDQjI0uxXCdkWYa+LwIdQis633GeVno1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857107; c=relaxed/simple;
	bh=ena1yUYJ2wsrAoXFW7QUwDTaSoM9tZqaKrYzQuSLIrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PO5sY3oiPn5dMfvign9ke/qmsI+cmW31dC3iMbIyjk/PACybhhz0BFlS44ld0liykgL31p4WY1slUDugZsVKrQdhWC/wko0T4dCCNtXh2quB0badSLa6uUq/sGnedCf17Ggn1M6I5IvqsN/FbfkXqK0ttf8cVcLuQUzGCFNo91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7ztdBc0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so1133135ad.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747857105; x=1748461905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24QkK8RqceHZ0n8fspRthg5IU3y9ZWuF2kXH2roLMcw=;
        b=t7ztdBc0linE7tejnWqCUUNMNFO1y2uJMKRjR1Uuz4UYQpVohXTR6sApvrc+a56ZFt
         446R2hAQWm7+L+H6ISe8dnsE1WiSHJS5sG2ODHjL19s4whXwKdjV0adJ7lN/IA6tezr/
         8VB5v8GB/WISOFEW26gex463w14q5cmwPZt7nNpCMFYl0SAidgc4GRDo6xbvB7rBiOhI
         gg7YlS3IrSaBzRCJ1K5meXMXw8kTDJNWekgStfI/jsur/8GdCwDpU2C5i2Y9wmB5FT0Y
         HqrB2njmUcliGe6I28KGcjNyKWYW2zSPt6ZC02EETM6wxfv1yu/F3akuw+ab+s+tJse1
         Mebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747857105; x=1748461905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24QkK8RqceHZ0n8fspRthg5IU3y9ZWuF2kXH2roLMcw=;
        b=PBR/0pBrtKmcEQCd/0ySy5h7U9zYfjylMfEZJOk5ia2E8JGKI6bjvZJbyuNl9+gJfg
         sVTlcRlKrARc62dK9OcCodW0omZAzhgB7psIcpg2PQ4DWnkHsjtUs/1ue1f90rLCnBAK
         5CTRyLZCGo8Q+QzKP67ewbHx+q2GocsGY6Ndobj2b+wH/3895wyliNQTfJySvIWTa4LT
         uidjl0oD271rctZuhDrfgN5DqOYTw/obWeGIXyBqXxe4idwMM/tis/9a0K8p8iAKhMxK
         ctQ7jqLXKoePjjiEL6RaZHlWQoZyxn53lBz5Ync4XYLDT9q//GZaAkkYV0M62pNu/671
         6iyA==
X-Forwarded-Encrypted: i=1; AJvYcCXc0S2XAJvgTU7+6csUBytnwoFrT8UJ7OPf8uENa31rS/oIZh9HK2jjH2PAHg6Kon7hDxeFWRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBL0UX7ofFUU+kxMdQB0SzFdnqEKNkuXa1mgjTno+6ob/TP7up
	kBHHDiOwvBey8zWw6Hxt1HhYdTKli2sYWL6CQCf14mgRuXZRqF91tpalp7PC2xzYQXjZRljZedL
	+6D6/+avxGggglN2JabJg1jqZMHLqbCdPppsKf5iq
X-Gm-Gg: ASbGncvXSBzVSCf5EQsyeNDjdORR2h6325Ohc7ZTMVMsrn8DQmuq4V0BTdyK962lEmq
	38sO01oYWfH36Hf9SoBXnFNLX2WR+3EFW7aGkib7ITHNgQKToDKZP9zckaWJWEv4Ocyhf9l3NyP
	UQWvu/0mEnGQ2JFz7B5b8zKBFImdCeKYH5+2eRPtwD0ABz18/HOF+HUTe7cvurAEkzrQLDIcly2
	Q==
X-Google-Smtp-Source: AGHT+IEw7QjYcO39DU2lh94EzpQDBQiY1mpPkffvqtX5xrKS3CeXjaTkwYJTMWaovZr8s1w6VMqCq1bDCJP1g8o4f6Y=
X-Received: by 2002:a17:903:11c8:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-231ffd0e31cmr12604085ad.6.1747857104779; Wed, 21 May 2025
 12:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519224325.3117279-1-skhawaja@google.com> <20250520190941.56523ded@kernel.org>
 <CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com> <CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
In-Reply-To: <CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 21 May 2025 12:51:33 -0700
X-Gm-Features: AX0GCFvJhS0qV67VSS1iubwXI2_JV8lgsH2eWi6Kg-ik3yQBzT0rkFMl9D3FbfY
Message-ID: <CAAywjhTjdgjz=oD0NUtp-k7Lccek-4e9wCJfMG-p0AGpDHwJiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
To: Wei Wang <weiwan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:28=E2=80=AFAM Samiullah Khawaja <skhawaja@google=
.com> wrote:
>
> On Wed, May 21, 2025 at 9:41=E2=80=AFAM Wei Wang <weiwan@google.com> wrot=
e:
> >
> > On Tue, May 20, 2025 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 19 May 2025 22:43:25 +0000 Samiullah Khawaja wrote:
> > > > -/* Called with irq disabled */
> > > > -static inline void ____napi_schedule(struct softnet_data *sd,
> > > > -                                  struct napi_struct *napi)
> > > > +static inline bool ____try_napi_schedule_threaded(struct softnet_d=
ata *sd,
> > > > +                                               struct napi_struct =
*napi)
> > > >  {
> > > >       struct task_struct *thread;
> > > > +     unsigned long new, val;
> > > >
> > > > -     lockdep_assert_irqs_disabled();
> > > > +     do {
> > > > +             val =3D READ_ONCE(napi->state);
> > > > +
> > > > +             if (!(val & NAPIF_STATE_THREADED))
> > > > +                     return false;
> > >
> > > Do we really need to complicate the fastpath to make the slowpath eas=
y?
> > >
> > > Plus I'm not sure it works.
> > >
> > >           CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (co=
nfig)
> > >                          if (test_bit(NAPI_STATE_SCHED_THREADED))
> > >                                ...
> > >
> > >   ____napi_schedule()
> > >   cmpxchg(...)
> > >   wake_up_process(thread);
> > >                                                        clear_bit(NAPI=
_STATE_THREADED)
> > >                                                        kthread_stop(t=
hread)
> > >
> > >                          if (kthread_should_stop())
> > >                                 exit
> > >
> > > Right?
> +1
>
> If the kthread checks whether it was not SCHED before it died then
> this should not occur.
> > >
> > Hmm right... I think the main issue is that while dev_set_threaded()
> > clears STATE_THREADED, SCHED_THREADED could already be set meaning the
> > napi is already scheduled. And napi_thread_wait() does not really
> > check STATE_THREADED...
> >
> > > I think the shutting down thread should do this:
> > >
> > >         while (true) {
> > >                 state =3D READ_ONCE()
> > >
> > >                 // safe to clear if thread owns the NAPI,
> > >                 // or NAPI is completely idle
> > >                 if (state & SCHED_THREADED || !(state & SCHED)) {
> This might suffer from the problem you highlighted earlier,
> CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)
>
>   ____napi_schedule()
>     if (test_bit(NAPI_STATE_THREADED))
>     if (thread) {
>
>  kthread_stop()
>                               if (state & SCHED_THREADED || !(state & SCH=
ED)) {
>                                    state &=3D ~THREADED;
>                               if (try_cmp_xchg())
>                                    break
>
>        set_bit(NAPI_STATE_SCHED_THREADED)
>        wake_up_process(thread);
>
> This would happen without the try_cmp_xchg logic that I added in my
> patch in the __napi_schedule (in the fast path). __napi_schedule would
> have to make sure that the kthread is not stopping while it is trying
> to do SCHED. This is similar to the logic we have in
> napi_schedule_prep that handles the STATE_DISABLE, STATE_SCHED and
> STATE_MISSED scenarios. Also if it falls back to normal softirq, it
> needs to make sure that the kthread is not polling at the same time.
Discard this as the SCHED would be set in napi_schedule_prepare before
__napi_schedule is called in IRQ, so try_cmp_xchg would return false.
I think if the thread stops if the napi is idle(SCHED is not) set then
it should do. This should make sure any pending SCHED_THREADED are
also done. The existing logic in napi_schedulle_prep should handle all
the cases.
>
> > I think we should make sure SCHED_THREADED is cleared as well, or
> > otherwise the thread is in the middle of calling napi_threaded_poll()
> > and we can't just disable the thread?
> +1
>
> We need to make sure that any scheduled polling should be completed.
>
> >
> > >                         state &=3D ~THREADED;
> >
> > STATE_THREADED to be exact. Right?
> >
> > >                 } else {
> > >                         msleep(1);
> > >                         continue;
> > >                 }
> > >
> > >                 if (try_cmpxchg())
> > >                         break;
> > >         }
> > >
> > > But that's just an idea, it could also be wrong... :S

