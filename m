Return-Path: <netdev+bounces-192403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494AABFC3E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912B41B65923
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C910825A321;
	Wed, 21 May 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYioET72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C1186294
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848514; cv=none; b=tm/MpMCISx9w6JxDZvMjPONlRwntfBT4feNaVNtSNb++gPTq/lx/Tx2QbJOMPQtANDIte/r56iaTIqk3CIq8Sh5bQV/Jqxa/fTkfv/97y9RQwq18ygk6XEBozMcGlAfo2P/e4u5jhPlzkXyQnAhmyhUXdMW7sc7U5/ikrDsVJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848514; c=relaxed/simple;
	bh=WqiAKdQmLRGE4vQU9UQt+uy5R6G7d5xpFTq7WJCe0TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpHHPCDZbE6kObwpzLKjCXGb5eeMBe3Di+us3mI9Aim2pf0RP305bpUuaZ2c0Md3z7QAscz/LuFthjodQvNJzIbwkXMTob2FiUDYUyHjCGqRduoiHUrIFUydV5C/JvQSckZCM6X9yvq/25A4tIZWJ38Hgnvarb9aVXobW3tQu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYioET72; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231ba6da557so755165ad.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747848512; x=1748453312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ6/nDsL/7HWTDo9vMiFq9o/FXVwMAe6cyE0Jbdzda4=;
        b=cYioET723HlbH5obtmOrzI3aXdMqxSt7NrgA8oq72VUYyI3DAoVZpGWHrx35567VkO
         yrMa939mbfd05T6V6zSkrClpJUoF96VQr8twzFIWUBmfuNgfGpCK2W3kLSRpuT8qK9Oo
         9hWtSKe7w0/8Zw8ebqzFJD8YoutLVnK30uZUPn3BTLnsg50jxMr3QSBUCCJfFHTJdkGQ
         io+2JFg5Am9+fPibiBw/x8kaCrP5POZUSlVJhH8BILySLTXfeC0xAzNZkNBzZSTob2+G
         gxFcBxANhha1zUxJaBNE7ZC6bai9s1BiaLiI7iHzLyEIpTi7+EAHLJGLyv9prNozY3yr
         SGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848512; x=1748453312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ6/nDsL/7HWTDo9vMiFq9o/FXVwMAe6cyE0Jbdzda4=;
        b=eVUlYmm9Vbzns26/U6gVzKM7FJDkIj9JmqHhyIgQgFqlKEWCouHSKLqIdg1MOrvc/C
         tWTC6vp9IyqeLIVTAa+yCuha7BS8JJ7lArlcSExIv0au8A/dvysdzbWev8v4clUxWNvk
         3r8LVm5Dqb4aDsOX6yJI2MfHyynWKf9mRB27JRA8LyYyXgh4t/c9UeW6KRnXRB5PAShZ
         MYpwE0tKYmyiB77irWUUPpGu5IxJXX82idNbcBO59ZZZWJEi+7qO8VTZwIuHUsOwsBNL
         Cd5tIvXhHabS1dsehHEk/nQ4V91TWQHGlNMTtlmKY4IxR1PDgXbwkMNNu34Y07op08Dd
         v1uw==
X-Forwarded-Encrypted: i=1; AJvYcCWswI9QO7oJAyIUulIIpH2f1Bdp4J1ukWWm51U/IkVkhNzYAGmiLhjfVduI5coOSfmUNTnbXVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSoMxyP1WExX61A6c9pnOGi9eK0biPwTTGxBtEotGkIh5ycWJ
	O0mgfwbdWGxvBnkP4S6N8HlXlU1T4VDTRiPyUoyBEG9ZytEnzMG8B6BKQKXH9tIMlroyvbqs2kV
	LgTZByiRz3l6jIi/8YSZT5ZFYzrJLkdlw7DUvk1aE
X-Gm-Gg: ASbGncuTXCCsDHQv2vztf4wU7Kn2zAfk1LRQ7+OYPsdflxuLbxSvI5qFewVNfU5Oyw7
	psaDLo0f9xasab3EnzSJywHqGGLaxWOks42NFph3/NIz4nskR6m4mXsH0wzmiohcUFopDzYCzzU
	9pzmMHD9j9G17Fmglzu+tTflTxeHYqASjhZbZRdLeYES9+/m86BphxKV1Ok1DwOEYVy4f8/BeqT
	5DY2N6dzFD6
X-Google-Smtp-Source: AGHT+IGatenDoeCDj3HUfb9Czrc0sWSOwsReYpgqYJNubdndYwqwFsf9cfL/kLDTyUs+h7diMr8unctSe9K6h5sUNv8=
X-Received: by 2002:a17:902:d4d1:b0:216:4d90:47af with SMTP id
 d9443c01a7336-23204178cc2mr11285515ad.29.1747848512188; Wed, 21 May 2025
 10:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519224325.3117279-1-skhawaja@google.com> <20250520190941.56523ded@kernel.org>
 <CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
In-Reply-To: <CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 21 May 2025 10:28:20 -0700
X-Gm-Features: AX0GCFs8Xi2coGOfPbl26_AaM4Hp3ImNKN7Q3OJ-3iwO0eTOMRNArTrvz1nzd1g
Message-ID: <CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
To: Wei Wang <weiwan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:41=E2=80=AFAM Wei Wang <weiwan@google.com> wrote:
>
> On Tue, May 20, 2025 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 19 May 2025 22:43:25 +0000 Samiullah Khawaja wrote:
> > > -/* Called with irq disabled */
> > > -static inline void ____napi_schedule(struct softnet_data *sd,
> > > -                                  struct napi_struct *napi)
> > > +static inline bool ____try_napi_schedule_threaded(struct softnet_dat=
a *sd,
> > > +                                               struct napi_struct *n=
api)
> > >  {
> > >       struct task_struct *thread;
> > > +     unsigned long new, val;
> > >
> > > -     lockdep_assert_irqs_disabled();
> > > +     do {
> > > +             val =3D READ_ONCE(napi->state);
> > > +
> > > +             if (!(val & NAPIF_STATE_THREADED))
> > > +                     return false;
> >
> > Do we really need to complicate the fastpath to make the slowpath easy?
> >
> > Plus I'm not sure it works.
> >
> >           CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (conf=
ig)
> >                          if (test_bit(NAPI_STATE_SCHED_THREADED))
> >                                ...
> >
> >   ____napi_schedule()
> >   cmpxchg(...)
> >   wake_up_process(thread);
> >                                                        clear_bit(NAPI_S=
TATE_THREADED)
> >                                                        kthread_stop(thr=
ead)
> >
> >                          if (kthread_should_stop())
> >                                 exit
> >
> > Right?
+1

If the kthread checks whether it was not SCHED before it died then
this should not occur.
> >
> Hmm right... I think the main issue is that while dev_set_threaded()
> clears STATE_THREADED, SCHED_THREADED could already be set meaning the
> napi is already scheduled. And napi_thread_wait() does not really
> check STATE_THREADED...
>
> > I think the shutting down thread should do this:
> >
> >         while (true) {
> >                 state =3D READ_ONCE()
> >
> >                 // safe to clear if thread owns the NAPI,
> >                 // or NAPI is completely idle
> >                 if (state & SCHED_THREADED || !(state & SCHED)) {
This might suffer from the problem you highlighted earlier,
CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)

  ____napi_schedule()
    if (test_bit(NAPI_STATE_THREADED))
    if (thread) {

 kthread_stop()
                              if (state & SCHED_THREADED || !(state & SCHED=
)) {
                                   state &=3D ~THREADED;
                              if (try_cmp_xchg())
                                   break

       set_bit(NAPI_STATE_SCHED_THREADED)
       wake_up_process(thread);

This would happen without the try_cmp_xchg logic that I added in my
patch in the __napi_schedule (in the fast path). __napi_schedule would
have to make sure that the kthread is not stopping while it is trying
to do SCHED. This is similar to the logic we have in
napi_schedule_prep that handles the STATE_DISABLE, STATE_SCHED and
STATE_MISSED scenarios. Also if it falls back to normal softirq, it
needs to make sure that the kthread is not polling at the same time.

> I think we should make sure SCHED_THREADED is cleared as well, or
> otherwise the thread is in the middle of calling napi_threaded_poll()
> and we can't just disable the thread?
+1

We need to make sure that any scheduled polling should be completed.

>
> >                         state &=3D ~THREADED;
>
> STATE_THREADED to be exact. Right?
>
> >                 } else {
> >                         msleep(1);
> >                         continue;
> >                 }
> >
> >                 if (try_cmpxchg())
> >                         break;
> >         }
> >
> > But that's just an idea, it could also be wrong... :S

