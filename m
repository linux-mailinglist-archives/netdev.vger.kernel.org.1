Return-Path: <netdev+bounces-117548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BA94E3F7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFCD1F21755
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F82914;
	Mon, 12 Aug 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FILCkmb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDF1114;
	Mon, 12 Aug 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423012; cv=none; b=jEzd6DFFnk3Jeu8piCUvuXhTHUdi20vyl0EsfftzFcouzP88Jmh03CczoGAWiiVgSgs0mogM/5uXW9Z0I2WW7Bc0mISV8vBUgDHVHpGmZuBSAJc8yIQ37PFGNtHqZtZIx5CEVhkMWAK41I6ALMAtOx8T25oIYXbMw7k3EG2Pw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423012; c=relaxed/simple;
	bh=QX6TK3wzCtrwq4wqmNmuJxL8rDfVOCb6B4sv/ZhITm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1eiyIHwyc/s3p8C+Zm2+txTZi5XPx/b5/XjIEX1IkPjwwhVHG+2i80aZTgtKhn3tewLqUMNYkj6nzlZmDogeZAr450n8/E3JKdlb/x1qCwFqUUMtfZoqW+WY1v6Pp5uL0GLl3orMaDp7RWz4AcD9XwI1TNxZT2n8P2kL2zEnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FILCkmb8; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39b3f65b387so16454695ab.1;
        Sun, 11 Aug 2024 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423010; x=1724027810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkOoBf1TBypbLgtDJdNsxwUYIdHaPJyZTk4KjhZphlI=;
        b=FILCkmb8TtkRQm4sJTYPCYWbRts6YnHhuPz7lAfVQeWmiinrb+ArRX0X5bhodfhnIl
         KiztvYD0j9W7ogqZz5fCN9JEdRotHL+DdQ370oJVrQLekw/gfIQEZbGR7LhwblW61yMD
         YcyiUSJlkNCnMsxoOq7knglLAvhwY49Lz+fSf9MgvPJ1NFbxdRCUE211toBQS2B1ovwT
         X2ETsQMLERxbNKKX8hNqZ7hbzrrVm4nt9eMKbhNzDtj5vZZ/O9zbp4ZMJ7DG7+9E2M4y
         uJoEKJZD3zWzts3oaC87NChgervTiBz+Gw+xzpaZbb4LKcQFejWTFitVeFmQ3QKBa+44
         VSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423010; x=1724027810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkOoBf1TBypbLgtDJdNsxwUYIdHaPJyZTk4KjhZphlI=;
        b=ZcfAOjwXN637ycqSj2pKa3RTXSCg46rGTpwL8M7f1CN40L+DBe9cXoypEarFUTuePU
         rAlsyvBrgEhcoVEYj8uUmF/0e436UD3pWoTgOeBD07iuqUpgtLgH4Ce/G77bBoLb7Baj
         QFltUjop6ZJGiRE4dIaKYe0RFaOFQmYn6TuwJTo71id2we6OvOYJbeDor3E1UJaquywe
         uZskTnLPFVVCZGTH9ISHgmISpIm5ZiQWgaIbHh9aC3O5yi0EfF4B6uCndYmJJGo/m3G5
         GgzJtKLf/TJFHlhXrEzEnoimpTe/GRM9sO17vaJZCVafXByp74yorMar8MEOrnEI8oZm
         ezLA==
X-Forwarded-Encrypted: i=1; AJvYcCX1UbupRDGHIAoixkpiKA3r6SgWgBCTlIru6nJjKcb+90T60AhnCFnVnGVn6vE8+gc+ZRQLmbxnBV6hoYru+tjD/Om/+tyhyXEXSiU08aVV4a0v6+NQg+GSRJrnVSpEM+pTnT/q
X-Gm-Message-State: AOJu0YxIWO0e9emHMn5mt7JUZqjQSNnwvMkixk80O/Ebl2ZrMg0oph2c
	iCcveNBQ9ZilKZziLzf7mFZ04i0VFPMfmdkDwsS+/gO5CP3OY3T4QhFbN98xRyfb8xaLETzsSd+
	dOMFnO0HBggdkN2hdGZr1cVxwQUSMu0pV
X-Google-Smtp-Source: AGHT+IEtgurMCetoMTmGAT4Mx29Mntgb7T9XQnHkXclDvkiAy8FfUGhAVgTOxe1nrG/JQFApWNNRdGga4osX4ujw9rs=
X-Received: by 2002:a05:6e02:4b0:b0:39a:eabf:c28a with SMTP id
 e9e14a558f8ab-39b7a4726b4mr88135485ab.20.1723423009933; Sun, 11 Aug 2024
 17:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811230029.95258-1-kuniyu@amazon.com> <20240811230836.95914-1-kuniyu@amazon.com>
In-Reply-To: <20240811230836.95914-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 12 Aug 2024 08:36:13 +0800
Message-ID: <CAL+tcoBqfC=Gg8=AVEFC1APWXq8mFtXBmu+6jt=MnsVYWc6cig@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Sun, 11 Aug 2024 16:00:29 -0700
> > From: Florian Westphal <fw@strlen.de>
> > Date: Sun, 11 Aug 2024 18:28:50 +0200
> > > Florian Westphal <fw@strlen.de> wrote:
> > > > https://syzkaller.appspot.com/x/log.txt?x=3D117f3182980000
> > > >
> > > > ... shows at two cores racing:
> > > >
> > > > [ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
> > > > and
> > > > [ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not taint=
ed 6.9.0-syzkalle (netns cleanup net).
> > > >
> > > >
> > > > first splat backtrace shows invocation of tcp_sk_exit_batch() from
> > > > netns error unwinding code.
> > > >
> > > > Second one lacks backtrace, but its also in tcp_sk_exit_batch(),
> > >
> > > ... which doesn't work.  Does this look like a plausible
> > > theory/exlanation?
> >
> > Yes!  The problem here is that inet_twsk_purge() operates on twsk
> > not in net_exit_list, but I think such a check is overkill and we
> > can work around it in another way.
> >
> >
> > >
> > > Given:
> > > 1 exiting netns, has >=3D 1 tw sk.
> > > 1 (unrelated) netns that failed in setup_net
> > >
> > > ... we run into following race:
> > >
> > > exiting netns, from cleanup wq, calls tcp_sk_exit_batch(), which call=
s
> > > inet_twsk_purge(&tcp_hashinfo).
> > >
> > > At same time, from error unwinding code, we also call tcp_sk_exit_bat=
ch().
> > >
> > > Both threads walk tcp_hashinfo ehash buckets.
> > >
> > > From work queue (normal netns exit path), we hit
> > >
> > > 303                         if (state =3D=3D TCP_TIME_WAIT) {
> > > 304                                 inet_twsk_deschedule_put(inet_tws=
k(sk));
> > >
> > > Because both threads operate on tcp_hashinfo, the unrelated
> > > struct net (exiting net) is also visible to error-unwinding thread.
> > >
> > > So, error unwinding code will call
> > >
> > > 303                         if (state =3D=3D TCP_TIME_WAIT) {
> > > 304                                 inet_twsk_deschedule_put(inet_tws=
k(sk));
> > >
> > > for the same tw sk and both threads do
> > >
> > > 218 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> > > 219 {
> > > 220         if (del_timer_sync(&tw->tw_timer))
> > > 221                 inet_twsk_kill(tw);
> > >
> > > Error unwind path cancel timer, calls inet_twsk_kill, while
> > > work queue sees timer as already shut-down so it ends up
> > > returning to tcp_sk_exit_batch(), where it will WARN here:
> > >
> > >   WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_ref=
count));
> > >
> > > ... because the supposedly-last tw_refcount decrement did not drop
> > > it down to 0.
> > >
> > > Meanwhile, error unwiding thread calls refcount_dec() on
> > > tw_refcount, which now drops down to 0 instead of 1, which
> > > provides another warn splat.

Right, last night I should have thought of it. I noticed that two
'killers' may access the inet_twsk_kill() concurrently (during that
time, I paid attention to the tcp_abort() which can cause such an
issue), but I easily let it go :(

Thanks for the detailed explanation:)

> > >
> > > I'll ponder on ways to fix this tomorrow unless someone
> > > else already has better theory/solution.
> >
> > We need to sync two inet_twsk_kill(), so maybe give up one
> > if twsk is not hashed ?
> >
> > ---8<---
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_soc=
k.c
> > index 337390ba85b4..51889567274b 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -52,7 +52,10 @@ static void inet_twsk_kill(struct inet_timewait_sock=
 *tw)
> >       struct inet_bind_hashbucket *bhead, *bhead2;
> >
> >       spin_lock(lock);
> > -     sk_nulls_del_node_init_rcu((struct sock *)tw);
> > +     if (!sk_nulls_del_node_init_rcu((struct sock *)tw)) {
> > +             spin_unlock(lock);
> > +             return false;
>
> forgot to remove false, just return :)

It does make sense to me !

Thanks,
Jason

>
>
> > +     }
> >       spin_unlock(lock);
> >
> >       /* Disassociate with bind bucket. */
> > ---8<---
>

