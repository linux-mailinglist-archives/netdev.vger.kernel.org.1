Return-Path: <netdev+bounces-100232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DB8D8463
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6FD1C218A3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831512CDAF;
	Mon,  3 Jun 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtM87fxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEE12C554
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422650; cv=none; b=olXq/ZEHDUeMDQZmzKFouEAYIa9gyHBb9TkJyV9PfLNnQi2hDm3l4vV1MOv9VOHGEeBtNkX6702fGpUsVyBOIIRol7Mw4zkxUvHzhdD5X7rQQSLdBv4Qmrp/oh95Gezd9SQkGmz42NoOsVsjZIStqyAc/RYQKbeXsj/SxkbODtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422650; c=relaxed/simple;
	bh=vSQmXzhYyRv3s2jP1vnHmLgZq7OnvAnFE7bOOw2V5m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9vObS1xUBc+gSO0pYJUCRQxAo182zog/D3U6QVl0J78o7G9iQpmBg0+iaXC+QieUsvGRLfvc9Wz6dpcsTSVo+1MnSmZbe+kbKA2hWduxHg1mmfyYEwiZFn06eMlS7sCocbwfITGU+OfFIgxXQxMleccQPna1DaEM+6r2+Eoujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtM87fxO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so72995e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717422647; x=1718027447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siUU5sgByGH8B3HaEsZNNLSp67rVY2J4w8/cOtuv/tI=;
        b=NtM87fxORCexsesY5QBlppCrdSLhaC3nuq9B7USKBTAs0BAjLge5U5kicABAeMiny+
         DdCa27fie8nM4bygIO6ev/x6AT4cBH4MsFXG2s07+mRb3WUzfkYDYryjwDuDLdTKpAzR
         Ea/UStW7dkmtA0icI9neSONbztILYxxgtZGy7Hg+TA1gLA1hINCYvpxBp5FYazO5sf6t
         BrslVAvqm3vsMB/F36sU4oQVTqLL1OC+D8yBxibrdqbzo39w6cuwohEE/vsTH58/0EUv
         32+j++X2kHbU7sLHOdIaKYvi56CoU/00RYZGvDfLnCA6AluPg9zPlDraTa2ZgXn+JjNq
         KJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422647; x=1718027447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siUU5sgByGH8B3HaEsZNNLSp67rVY2J4w8/cOtuv/tI=;
        b=ZrQ6jBoEwoyhZdNHVmi6Ridn/D7mYvgRkJxLSCUnWvaYJ+TYVulMAEgShuH0svfG2E
         PNRKo+WokWv9DMQIV6p6kK3HL8bhlp76mbEbUsvCT79kwDqrO5t630HuaRnfrOQWUbSn
         CUxFQmVDzBYL33YH+1nwpoz7bp7vYQwxGiFR6i0QDde0fWWfHtdmbgLJtHYqRT7VZ2MS
         v3PyGkECnPQd/OQxejqwPFNkvcty0kEX8j0ZM7Indko1n/ifguRRFf6hiog9z+vEQ6C+
         7M1AvgcCk1jcIfmbAW+oUqxl6Qu9tghM0lKtWGt6Xk6laEJW8xYEf8vxlfoBBjWHFsb6
         S7pw==
X-Gm-Message-State: AOJu0YwhHAmhdwYR+0NgPwvCo5iuaStV5M7CVraygbfwX29jtatatzLc
	rbEHlYvDkNhKJGMtjG8FtZCV1bl0wRlUVFBIzAbrdUNhMVgNNypj0ocpbGrnPd9zzMwdUDccINI
	TxzQmjck60A/rBwsgy8Hz4U723n4Hox0vllvN
X-Google-Smtp-Source: AGHT+IF0ig0X4MYBCu8fW4TyBhHzPVKrJyBlaf064CAYofZfrPOrfer6iTg6nsjTJYZXXeBU5cmqqeEfXZV7JIpaSHA=
X-Received: by 2002:a05:600c:2104:b0:41f:a15d:2228 with SMTP id
 5b1f17b1804b1-42134e35268mr3756965e9.0.1717422646558; Mon, 03 Jun 2024
 06:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603093625.4055-1-fw@strlen.de> <20240603093625.4055-2-fw@strlen.de>
 <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
 <20240603112152.GB8496@breakpoint.cc> <20240603133158.GC8496@breakpoint.cc>
In-Reply-To: <20240603133158.GC8496@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 15:50:35 +0200
Message-ID: <CANn89i+Hn_Ra2v=DoPzBxnYzW_t-X2TNy=0tciGRy8w4PWOC_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer un-pinning
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com, 
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com, 
	dsahern@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:32=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Florian Westphal <fw@strlen.de> wrote:
> > Eric Dumazet <edumazet@google.com> wrote:
> > > On Mon, Jun 3, 2024 at 11:37=E2=80=AFAM Florian Westphal <fw@strlen.d=
e> wrote:
> > > > +       spin_lock(lock);
> > > > +       if (timer_shutdown(&tw->tw_timer)) {
> > > > +               /* releases @lock */
> > > > +               __inet_twsk_kill(tw, lock);
> > > > +       } else {
> > >
> > > If we do not have a sync variant here, I think that inet_twsk_purge()
> > > could return while ongoing timers are alive.
> >
> > Yes.
> >
> > We can't use sync variant, it would deadlock on ehash spinlock.
> >
> > > tcp_sk_exit_batch() would then possibly hit :
> > >
> > > WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refco=
unt));
> > >
> > > The alive timer are releasing tw->tw_dr->tw_refcount at the end of
> > > inet_twsk_kill()
> >
> > Theoretically the tw socket can be unlinked from the tw hash already
> > (inet_twsk_purge won't encounter it), but timer is still running.
> >
> > Only solution I see is to schedule() in tcp_sk_exit_batch() until
> > tw_refcount has dropped to the expected value, i.e. something like
> >
> > static void tcp_wait_for_tw_timers(struct net *n)
> > {
> >       while (refcount_read(&n->ipv4.tcp_death_row.tw_refcount) > 1))
> >               schedule();
> > }
> >
> > Any better idea?
>
> Actually, I think we can solve this in a much simpler way.
>
> Instead of replacing:
>
> void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> {
>  if (del_timer_sync(&tw->tw_timer))
>     inet_twsk_kill(tw);
>  inet_twsk_put(tw);
> }
>
> With:
>  spinlock_t *lock =3D inet_ehash_lockp(hashinfo, tw->tw_hash);
>  spin_lock(lock);
>  if (timer_shutdown(&tw->tw_timer)) {
>
> (Which gets us into the tcp_sk_exit_batch trouble Eric points out),
> we can simply add "empty" ehash lock unlock pair before calling
> del_timer_sync():
>
> void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> {
> +       spinlock_t *lock =3D inet_ehash_lockp(hashinfo, tw->tw_hash);
> +       spin_lock(lock)
> +       spin_unlock(lock)
>
>         if (del_timer_sync(&tw->tw_timer))

Sounds good, maybe use timer_shutdown_sync() here ?

>                 inet_twsk_kill(tw);
>         inet_twsk_put(tw);
> }
>
> Rationale:
> inet_twsk_deschedule_put() cannot be called before hashdance_schedule
> calls refcount_set(&tw->tw_refcnt, 3).
>
> Before this any refcount_inc_not_zero fails so we never get into
> deschedule_put.
>
> Hashdance_schedule holds the ehash lock when it sets the tw refcount.
> The lock is released only after the timer is up and running.
>
> When inet_twsk_deschedule_put() is called, and hashdance_schedule
> is not yet done, the spinlock/unlock pair will guarantee that
> the timer is up after the spin_unlock.
>
> I think this is much better than the schedule loop waiting for tw_dr
> refcount to drop, it mainly needs a comment to explain what this is
> doing.
>
> Thoughts?

