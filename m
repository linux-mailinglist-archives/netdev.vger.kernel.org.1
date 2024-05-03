Return-Path: <netdev+bounces-93258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 176FC8BACCD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87671F21AD7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F77153595;
	Fri,  3 May 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWstp2hX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B4153579
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740554; cv=none; b=rLb+RN0t9uVtxnKKjoE5w3ZK2W8NnwHtbuHecjq+x3hhnv2jzWN5p/9J0IsvvDerRmFDWvWVtPnu2qc60zS8PPSsSBYK95IkwYdbtSZey2myQevIpHO4CJy/4Dx8LLR/LrN+hRDNM4wQl0jUa60YF9kD9SLlkAjWoNHlxyMnvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740554; c=relaxed/simple;
	bh=hxw3PTz1zoYEBJdxlqr52yo3+1wc2H8JAGsikiMD2JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9N8beZnoNXrqsk4UbYOcyx1Q/GrfjUtUq/dYXwcK/EHbbjGLQhs71ASqkT5L/F5AwI5TLwegcfoOk8duoEpGIc2IEIG3twccs/a8KtPwz6He/9AUminmo4cfDMMp6Z6xEyUjXSQgLP1dDOe+LslkTiLKT5tUk6lm76hH8EWO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWstp2hX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso9513a12.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714740551; x=1715345351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XpMcGDgIfznZQBNDkU9TkJZOIsLs+k/ZWJlLzD7Qs0=;
        b=nWstp2hXL7cstNw/XeMq7a2JvEMJhnjoKfYBpVPKFRLxLd82roo/1uUW2fcEw1mbzS
         GyGH3CTNvvt9T/6JLD5J2/pbP27OA77Op/DTxFMPY2xQO9nuB4x/kRsPAi1DPKkfj/Fr
         2M81pzKaA7owfztbkrbEuyP08qUpLYBJ5pOiT9FIQRSGGcp1vZqQskKVl3yWi5ntfT9l
         Ou5pxqXr1K+M+vR7tgRbg2sTLmQPaZ2j17+BaMnw87mYWMpr01S6BV74i1BNA8nuWb00
         ov399UDs/tq9scTWV2zh4f5TWjtg5I9xN2kQYeV1wFYpWBPt3EysO748UdzywzhW1xZ7
         QlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740551; x=1715345351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XpMcGDgIfznZQBNDkU9TkJZOIsLs+k/ZWJlLzD7Qs0=;
        b=H5hfb/ze/jSNzjzzlfZTNqnskLJTbKlszjEQjXGu8TFfVJt4BRoCaXvo3mXElOin9p
         qNUvdUraKKKbL1eP4T8EvsUrL2yJJztEPlD3iMLW/2gbTJ7dI0/AR0TcI71bxcpOyxyM
         86ftpV2/msceN8FSR44b8WhV+YntQYjAkC/AYHYwi5af9gV690MqGdeEZvDdd59VFLXm
         1L6xED/EpRaq2Vrux7q+3hnaYBLeNwWoEw5kvZ5MJy5e8RSuqEvKA/olv8IRlpg/m3ZX
         0if+3MAAKU5Nlan13hfdQoH4kwq+WDJmKk/IjdLRY1oZ9dqJ+rRmhO6fd98uk88PgSsC
         KfOA==
X-Forwarded-Encrypted: i=1; AJvYcCULDoEiNz9a1vAr+RIJvwwrIKiLT7uc7r2h8Xh7Svhkq2trSLQT45TyAFmC6+PmQIO4oWa3Cf0thSHQdDAQkqI8QJetns1j
X-Gm-Message-State: AOJu0Yy0yIdC/rrhEcZIvk/EcQJsxMlccjz7ZW+jG1rDmNI+jdPOl1Rj
	DHD8xUSdUO0g6iyLPLgyl6IKIFN8iMHAopelsXmBLC+vRLnEHmL7sKCiPzUQ4Je8bpZjGSutmQ+
	CcQ0imWD/1hOHTVBrSnxlvDTUATYgxg1Hajiv
X-Google-Smtp-Source: AGHT+IHFLeyPZuiU9SKRK9tY0y1SXjGdMNhUxU6FDX95us1zA7XX92qaREfZ+h9mQMvu5b651C8NOvvY/jfkyhyL9Hc=
X-Received: by 2002:a50:999a:0:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-572d0f4be13mr107284a12.3.1714740550653; Fri, 03 May 2024
 05:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
 <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com>
 <ZjE587MsVBZA61fJ@dcaratti.users.ipa.redhat.com> <CANn89iJRA-1z60cvGnbqYa=Ua-ysR9uHufkrFmQGRmN-4Dod2Q@mail.gmail.com>
 <ZjTcNVOT9x8e4UG3@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZjTcNVOT9x8e4UG3@dcaratti.users.ipa.redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 May 2024 14:48:57 +0200
Message-ID: <CANn89i+KVxvHkHT2c+L5ZGbeT34EO6HZahu4o9w9YB_YSJHH9w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:44=E2=80=AFPM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> hello Eric,
>
> On Tue, Apr 30, 2024 at 08:43:22PM +0200, Eric Dumazet wrote:
> > On Tue, Apr 30, 2024 at 8:35=E2=80=AFPM Davide Caratti <dcaratti@redhat=
.com> wrote:
> > >
>
> [...]
>
> > > > For consistency with the other path, what about this instead ?
> > > >
> > > > This would also  allow a qdisc goten from an rcu lookup to allow it=
s
> > > > spinlock to be acquired.
> > > > (I am not saying this can happen, but who knows...)
> > > >
> > > > Ie defer the  lockdep_unregister_key() right before the kfree()
> > >
> > > the problem is, qdisc_free() is called also in a RCU callback. So, if=
 we move
> > > lockdep_unregister_key() inside the function, the non-error path is
> > > going to splat like this
> >
> > Got it, but we do have ways of running a work queue after rcu grace per=
iod.
>
> this would imply scheduling a work that does qdisc_free() + lockdep_unreg=
ister_key()
> in qdisc_free_cb(). I can try that, but maybe the issue is different:
>
> > Let's use your patch, but I suspect we could have other issues.
> >
> > Full disclosure, I have the following syzbot report:
> >
> > WARNING: bad unlock balance detected!
> > 6.9.0-rc5-syzkaller-01413-gdd1941f801bc #0 Not tainted
> > -------------------------------------
> > kworker/u8:6/2474 is trying to release lock (&sch->root_lock_key) at:
> > [<ffffffff897300c5>] spin_unlock_bh include/linux/spinlock.h:396 [inlin=
e]
> > [<ffffffff897300c5>] dev_reset_queue+0x145/0x1b0 net/sched/sch_generic.=
c:1304
> > but there are no more locks to release!
>
> I don't understand how can this "imbalance" be caused by lockdep_unregist=
er_key()
> being called too early. I'm more inclined to think that this splat is due=
 to UaF
> similar to those that we saw a couples of days ago. Is syzbot still
> generating report like the one above?
>

 I had 22 other syzbot reports that I marked as a Duplicate of the original=
 one.

Let's see if syzbot re-opens a new one after the fix.

