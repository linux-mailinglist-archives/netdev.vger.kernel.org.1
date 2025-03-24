Return-Path: <netdev+bounces-177065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AFA6DA06
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4A93A94DD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027625E819;
	Mon, 24 Mar 2025 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBuHoIwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CC25DCF8
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819044; cv=none; b=X/wTY5ROVsZFfIA3XmwC4ZxafjTIpOmauLEzULi2BOFc2du5U6EfRiHhD682gspj7SqzxDyFcsuVpsQN01xpwEqb27OohcTBnT2t6JJMctKwxjas0PD5HPUJ4BWnyIxZjwWyKgTJHI/IyyOdROT6qC6UBFmiiXMRcZvHaOnzp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819044; c=relaxed/simple;
	bh=l5wT2yMAwiJuX/kTLoFIi7b58hF4JHqWsVvGuJmoQxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mChDGjv6nD3SBnMzv0bJFCAhj3IF3CaJsDWo+WLcnkVJ4qpJkBYCZlbBIKdpsB18XXJckE77me2fkOktFf4puAhCix2ocGjgR8UX1N0ic/cyU7Eno7IF1Nqme6/Srcep21uce+ItwhVlLS7JeHix1qPojhdC7fZydYsLEshx4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBuHoIwU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769f3e19a9so27029371cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742819042; x=1743423842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rw7KdFhgGlzA9hJZu3CUQol3b3y3Kzt/ot+PZJwkTg=;
        b=YBuHoIwUFo8+1Qe7UShQHY4KD08caEZn2okM6G5LArLVbiyo50NSWrvO91cMQGob9F
         vmi1JQLPSjBZM62MRoFriVtmc3xDMgRJ7EGCnSnHXTGouL4LVhCcnJHRjgsRpkhwdU3B
         lUVfhGmsY1WhOnmapVTGf9RnfXv0G913qhEVGLsb2ogrk6zb3hgx3xfK5pQVJ1OwJ5eW
         7q8FLGDoW8EKV+Lu0x/6CxpTeNmazD3nwpRX7bYKWeyoi+BTui22jpaEq7mVu9/BA+KM
         arlbiT2ezSaSjBrAjH3IbHPOyd4ENpOTf4EZpbYOWC4hFTgwfeo8xqTAJqKMakVVeR0m
         r1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819042; x=1743423842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rw7KdFhgGlzA9hJZu3CUQol3b3y3Kzt/ot+PZJwkTg=;
        b=omPPFlQgVkEupXiQ52M8sQj8DMvl2c+tAr/M25n25xgpLGrcSR1bI5nd23tM1pTcs6
         LrDQ3dxXzZcpoRugPNUGazao4/OK7G0RX0mR0wDUT6UUAfrk8uOudzFe8zbRZ1vS1VG3
         YU3KRlnNB8oonLxNRNgGiP3BlVrfxnjvKZ3dVu9/P4be4Q7dp7WDshQTATPziDbIWRAt
         a3KDQ+sQ621lEmv7TnNuIr8sIjPl9MYkw0a8BgPcPxI8oWCuD87aEsBqoB7OpRSAK0NF
         YM7OAlipdLwHF5hT8b9VgahtYw91Pr8EwdXO67mXemtFLiRgBLvijUD2nKSu//XDpjpn
         if3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuTM+oB9TMgfmSQ0ZzHdo3UnftNEUxtAboahiFk16iEJOmGjtt4lVipSCPa/cb48WpmHgr/tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77SC5F9bOoOS9ibZomjYhQVl3sDcp2wQd4fAFJVVS2zwXEsaW
	GwjEFEhRYBYXIcTlBpu3CEywQbRymo369H1T+qKKT5hooBPJOTr3YxgP3eIQvdoAEnzJtN4ZXt+
	rTHGlOnpuuxLF4qqD3mt9pIY4Rp95gk43NyZf
X-Gm-Gg: ASbGncui+K2kJsb4GkVqI2ee239UsraQ3qD6mbTR6hBVUaubWAmk1QhJIfjI+qZr13h
	oHGef1Ze9yb0QeyYj9LyeWTLrZwgR36DJkG7E3xmUCvDBTke7/pXzsqKuvocEDJm5ftaBn6BlTZ
	SgnpuIxPpftHJqSKp9opdG4ubUUbg=
X-Google-Smtp-Source: AGHT+IFamWA+o+dJNENoDIKowoy2ZKZjHw7Gx4z6RKzEwodmMi0dQWsxzn7/ybltodE1h5nA0JP+UTvoh6D9sJLd41Y=
X-Received: by 2002:a05:622a:1e97:b0:476:a895:7e82 with SMTP id
 d75a77b69052e-4771de78f90mr214642051cf.50.1742819041534; Mon, 24 Mar 2025
 05:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org> <20250324121202.GG14944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250324121202.GG14944@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 13:23:50 +0100
X-Gm-Features: AQ5f1JpS_e7Szu4iSZLtlamMU8FxAJtCvtZEXy-PL1Ofpt1wyNMoShDqHy0mZzU
Message-ID: <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Peter Zijlstra <peterz@infradead.org>
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, aeh@meta.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 1:12=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> > lockdep_unregister_key() is called from critical code paths, including
> > sections where rtnl_lock() is held. For example, when replacing a qdisc
> > in a network device, network egress traffic is disabled while
> > __qdisc_destroy() is called for every network queue.
> >
> > If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key()=
,
> > which gets blocked waiting for synchronize_rcu() to complete.
> >
> > For example, a simple tc command to replace a qdisc could take 13
> > seconds:
> >
> >   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> >     real    0m13.195s
> >     user    0m0.001s
> >     sys     0m2.746s
> >
> > During this time, network egress is completely frozen while waiting for
> > RCU synchronization.
> >
> > Use synchronize_rcu_expedited() instead to minimize the impact on
> > critical operations like network connectivity changes.
> >
> > This improves 10x the function call to tc, when replacing the qdisc for
> > a network card.
> >
> >    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> >      real     0m1.789s
> >      user     0m0.000s
> >      sys      0m1.613s
> >
> > Reported-by: Erik Lundgren <elundgren@meta.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> > ---
> >  kernel/locking/lockdep.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 4470680f02269..a79030ac36dd4 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_ke=
y *key)
> >       if (need_callback)
> >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> >
> > -     /* Wait until is_dynamic_key() has finished accessing k->hash_ent=
ry. */
> > -     synchronize_rcu();
> > +     /* Wait until is_dynamic_key() has finished accessing k->hash_ent=
ry.
> > +      * This needs to be quick, since it is called in critical section=
s
> > +      */
> > +     synchronize_rcu_expedited();
> >  }
> >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>
> So I fundamentally despise synchronize_rcu_expedited(), also your
> comment style is broken.
>
> Why can't qdisc call this outside of the lock?

Good luck with that, and anyway the time to call it 256 times would
still hurt Breno use case.

My suggestion was to change lockdep_unregister_key() contract, and use
kfree_rcu() there

> I think we should redesign lockdep_unregister_key() to work on a separate=
ly
> allocated piece of memory,
> then use kfree_rcu() in it.
>
> Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer=
 to
>
> struct ... {
>      struct lock_class_key key;
>      struct rcu_head  rcu;
> }

More work because it requires changing all lockdep_unregister_key() users.

