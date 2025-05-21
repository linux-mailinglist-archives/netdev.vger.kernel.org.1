Return-Path: <netdev+bounces-192392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8DABFB6D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAA64E649B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2A22B5B6;
	Wed, 21 May 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ayjjj5/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EB22C321
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845677; cv=none; b=mN2RV332F3dluoI3AaI5D7qffKuoQXK7WiAx3jK/TQimuMgaVkAm/4jDEER30sY8WOBq/p4f520IRFI2VuUoP0R9TJdOYlAjh3Vnwtn7yZkPouHLA01Eni2FP4XY5Sx0zgMxoMeVW6Pf4p2yAwUwcpvBZUP92zTgvVpL7mQ7CIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845677; c=relaxed/simple;
	bh=dgwnCQk5WY5Zqe+WehS0RfJHGuUxJkaFP1Z2dQlHdxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPMfW4e3Af4GWHRIPqz1lsOLMFwUlymubn25NYMGmz8V34pPYUjFLGS7bpu7k/P7IRPqKubVVnCfOL5x1DJzJZx3KdWCkTwQKMRvrC96QT0vZoiLsmWSebtJDpi2Men7q1uHayGndRFY8LCHb8mctAPywgrYv0E1krQn5RG6D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ayjjj5/E; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47e9fea29easo1796131cf.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747845675; x=1748450475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkVj3AiXyQU0EH6GVq8LFq5HOurR8Z/AjSu1EEik5y0=;
        b=Ayjjj5/E8HIcWPGJ2qDgjy0PwNYtrKzG43c72Le1Dh9Ma6xGUIjEZgURl9zrakZCfi
         EQqLWjiP2TXhHOSm/gXiMrIfvSSJ9YeXzNQuiA6593bBn+7FL6U5xRhB3ekzOxsvGV/o
         xba0OrR8qziK116rJnj9T8NNhhl380H8k+nQz4MQ9JuZs5LwiexekRUTnpPOY9LS0YvA
         TY8lZpupJeicwSTuWlBPeQzESzXZbDbjFZtFlwVpbV+peOAb3tZuhTlBR86ZkTyX2D9A
         YXEtXcg+g7uDpAhWjaIxKyja0g7Vi8aq7I/I37p1FGUwidXKQp3PSJuDQMXPWsxwuaHg
         LDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845675; x=1748450475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkVj3AiXyQU0EH6GVq8LFq5HOurR8Z/AjSu1EEik5y0=;
        b=Jm1lR3uXf9mts2GAUJpSDemYJ+BZRrjVW1j6F4PxQ+qRbxAQWvfGbLUowp7pFsjJaD
         5z95wo5+mgRW47lyIgaBYndbqZfOUV6fTYM99UDceuJRLbPVu0QU+QavYb4vnRdhj6KR
         1tgWa2yqm0m4VFOy5C6fYN6c1UrZrdNhfRpFD/3iLpz1yRZoUYYYBVAD4JHVNdPY/YH2
         ZAnH/XDT0GTQes7tVODei9VxOjqmiOCPBJiejaQV8c0LTuxjkxylfbc5mIUI8LnYjkVP
         58gUgmqjeHCx8VudxbnOIE3Kf+uYXVjN1Pf6GnF6tbTO44SPiR3U4gqL8GcYoBAj7mrR
         cJOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3fiGkqWa42RCcWZ4K/yDq1HKGlgRjVuQWgAkk168s3clIqfBHQhYwk7+RuzkfqXWwcHqZ6fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYi76WoufgN6w6cuBeMKpkAw1e5cn2/c9d/HSPUhLVJH4V0HY
	au/9yKFwdjsSb7JIBw062sGXKYMdbqsqeFYh2Xi04o92f6Hw6YUXMjadK3wC/a+YTAJlgGv6MIf
	kxpJAxHi6PtlgYU0m6R9LR8HGgpoIc417WGzP1PfO
X-Gm-Gg: ASbGnctjJWGGyUQlEHOHQKWgPErwm80wBhRpr5lvmzzhtOg6ZVpNuJw2GqGaPOAZdLc
	AD5tqRJkqTHSvUj7kbKjHwK9Y/0zeKPJsLER0jKIsuTAGAQ+02sfjroTg3Z+qnqf8Lm3eI/vflt
	13vr2Or8brfxPTS6Dr7urFUvtsv0KIKyLQHIZpAJnTG7gR
X-Google-Smtp-Source: AGHT+IF6cMRFgpYyek7Lv0dScyv/5IJ6Sir1NxgXPG1tRgIIs7jA4QHDBKsqjRgN3nb3omUnzM541fXUEqxbvQnCrJA=
X-Received: by 2002:a05:622a:1885:b0:47d:cd93:5991 with SMTP id
 d75a77b69052e-49601267b82mr16112951cf.21.1747845674668; Wed, 21 May 2025
 09:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519224325.3117279-1-skhawaja@google.com> <20250520190941.56523ded@kernel.org>
In-Reply-To: <20250520190941.56523ded@kernel.org>
From: Wei Wang <weiwan@google.com>
Date: Wed, 21 May 2025 09:41:02 -0700
X-Gm-Features: AX0GCFvBqm3pdEZAsKgZPa6wGaf4-HdzFe_pMgXbAEo2TvMtMKeXtigUAyiuDZY
Message-ID: <CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 May 2025 22:43:25 +0000 Samiullah Khawaja wrote:
> > -/* Called with irq disabled */
> > -static inline void ____napi_schedule(struct softnet_data *sd,
> > -                                  struct napi_struct *napi)
> > +static inline bool ____try_napi_schedule_threaded(struct softnet_data =
*sd,
> > +                                               struct napi_struct *nap=
i)
> >  {
> >       struct task_struct *thread;
> > +     unsigned long new, val;
> >
> > -     lockdep_assert_irqs_disabled();
> > +     do {
> > +             val =3D READ_ONCE(napi->state);
> > +
> > +             if (!(val & NAPIF_STATE_THREADED))
> > +                     return false;
>
> Do we really need to complicate the fastpath to make the slowpath easy?
>
> Plus I'm not sure it works.
>
>           CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config=
)
>                          if (test_bit(NAPI_STATE_SCHED_THREADED))
>                                ...
>
>   ____napi_schedule()
>   cmpxchg(...)
>   wake_up_process(thread);
>                                                        clear_bit(NAPI_STA=
TE_THREADED)
>                                                        kthread_stop(threa=
d)
>
>                          if (kthread_should_stop())
>                                 exit
>
> Right?
>
Hmm right... I think the main issue is that while dev_set_threaded()
clears STATE_THREADED, SCHED_THREADED could already be set meaning the
napi is already scheduled. And napi_thread_wait() does not really
check STATE_THREADED...

> I think the shutting down thread should do this:
>
>         while (true) {
>                 state =3D READ_ONCE()
>
>                 // safe to clear if thread owns the NAPI,
>                 // or NAPI is completely idle
>                 if (state & SCHED_THREADED || !(state & SCHED)) {

I think we should make sure SCHED_THREADED is cleared as well, or
otherwise the thread is in the middle of calling napi_threaded_poll()
and we can't just disable the thread?

>                         state &=3D ~THREADED;

STATE_THREADED to be exact. Right?

>                 } else {
>                         msleep(1);
>                         continue;
>                 }
>
>                 if (try_cmpxchg())
>                         break;
>         }
>
> But that's just an idea, it could also be wrong... :S

