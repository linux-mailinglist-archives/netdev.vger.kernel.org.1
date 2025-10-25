Return-Path: <netdev+bounces-232763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40730C08AC6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEDEF4E44A1
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A428851F;
	Sat, 25 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nA2SMAru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD202877E7
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366334; cv=none; b=bIVJKieGie65b4u9GFoJhEK1mSBvXkJRIRvqlXabRSMyVOF9M0hbo1vTCCj4Quq8RgWmb+ijQcqPPHHxc59bZgi7p4F3RAtc92UruPOzTGnVX4h4dF4HX5ppPfX+Q9lBUZp9gDTmy/STnAokXXn44X6USOOVSTuKou0/D/ytlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366334; c=relaxed/simple;
	bh=T024JLzezhn/owYdSKp0XfQ7RUhl+MWD6QiZ4czgoTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVeqGdwH/Sn67GS3fM+txIvP9/po8PG3TBtXTuD/hKvkprKfp671t3yUmAzTC80JW+mxAWHEXShcsmAMzDievqpccD3zSRQKkLw7MT9v7d/WJ34jOOqFEnt0hgufX4HXrgsH+XVa6dkwupKr0gGZKQibHcDP7hdx8MAnoj4yJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nA2SMAru; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so1755907a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761366333; x=1761971133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PhHVYAu3GoqB9tOUrtNyZ6VllNlvh/UDz5NmlzDI5Q=;
        b=nA2SMAruIFkndqX+KIawqn1fj8R02TJuA5DWQuQ7vOkKWLqQ7b7tIdBlFZxFTdX9v0
         QSVFM9ATox47IooKm5u6VqVjnN6jIWWVcAxGyPQe/6p96gHOzE+SHwAV/x3c3reiF+jV
         CU2Mo+p+Ic7frB/wl4j5y5i39ld7mStMtR4BR6i3+WoLGWGFO7Qdj//vKDtoxzF4VmQ8
         mAS9WGmaZqC/ZqUYHld+yOnxsK3LHnONVfValJMnwMglFzagx0pOX7meSaGCLL1E2bwk
         R1GMAqt3D393KY518KUEQEj3IiF7cNBf2mKS4lwr82ym6uF6qHMJUN95i1QbOViyIIUx
         jwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366333; x=1761971133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PhHVYAu3GoqB9tOUrtNyZ6VllNlvh/UDz5NmlzDI5Q=;
        b=uusdExrmCdSwwoMH7Cf97eJCMNFodCdmHZQNXrF/L6T3ZjlzMTMrOZvHyVjnkSELrX
         oVbhbXE7HVLlrvVWnxA/Isp5R+ZlJzTibVZ7Hu2b8Js7/QNXgBA1skjYVbBCFMn3lrfs
         vpYHyYJK2bzQvNJj4JX1yUVsbzMbuH5Yrbu7+IWBJc3PqDxZy3xrEHBOjKCoAJ4i2IsC
         PxgmfjT0pP2tgcM10qH0A6AbYYWfUJeRWgD+xgyRUMCJknJF7Z4z67N5z8S12j2/SYHG
         yH1PQudb+qqaRjR8kUn7v6NCpFujuGhpwyNsJNrJvmBnNZ5kC59Cfl/lfX3T0u+Lq5HD
         r3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXux4yV2+FM9F2eEFDkPB9gIGKpEhrn4nxv9mdgPMcQBzSQQpgw9zq1lzsjDh+mmwEbbz884fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsOj18AUOQgceyMfYServ/m0JJc5nOkOJl9O93CqA0mIVS9/e
	K7YtmFXd+AAfLKm/zHuYk+zWst/gDUCPrOikQhNsYmIL8cS4ZAvzWqqjt/Ygut33hgOzYT2l3aG
	YnNc1cVti0nIy3Dlq346Q6vyIvkBS1e/oaqx16wZ0
X-Gm-Gg: ASbGncsZqe6ZFli4TSqEC29uiZhQPe/fbo7kSBG9wFlE6IcifO8+gB4c5gcsfQDYoos
	v+TDuARXzqzjc0fBvENKgw3Jcmrk890ygm02EXqySW1XtijSzofgT4g2pbe2B9meIjfVnWxSu+x
	N4boyya5004VrtrtRrW9umdv0jzuFBlByWHjammWvjGzY7BucpfUxsGIlQCPAcGQPrQGXiJ4+WK
	GnGj8iBUft/sUgk6+7hUx8QY9QLPD9+bB8HOZcAfO2jTaohVQFN4w3zeS7ApReE+NkZYyo73uaz
	6Pq18q6UvUk6svR0li/kPxBtMw==
X-Google-Smtp-Source: AGHT+IE3YSxNIMuDra80sjllPz1FMOI4xMsMGSHUumbJrsGzXTOGgEeAdl92i/4ykKaEWjGEn4MI+t4Ip6reBjO6l1o=
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id
 d9443c01a7336-290cc9be17amr377871245ad.48.1761366332191; Fri, 24 Oct 2025
 21:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUCx9MOJobomXXBcXsCNgSn__U3mJp8LFxD515o-boyr=w@mail.gmail.com>
 <20251025035147.2094258-1-lizhi.xu@windriver.com>
In-Reply-To: <20251025035147.2094258-1-lizhi.xu@windriver.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Oct 2025 21:25:20 -0700
X-Gm-Features: AS18NWBRmH_2lAVRSFK1FC1NYFaseykjicIslllLmdlBt_n_d0eBcPdw3LG8pXk
Message-ID: <CAAVpQUA_CqqUfoJb=NaQ7YnBUbW0UWQS4W++TXwRFekenkDM8Q@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:51=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> On Fri, 24 Oct 2025 19:18:46 -0700, Kuniyuki Iwashima <kuniyu@google.com>=
 wrote:
> > On Fri, Oct 24, 2025 at 2:39=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.co=
m> wrote:
> > >
> > > There is no synchronization between the two timers, rose_t0timer_expi=
ry
> > > and rose_timer_expiry.
> > > rose_timer_expiry() puts the neighbor when the rose state is ROSE_STA=
TE_2.
> > > However, rose_t0timer_expiry() does initiate a restart request on the
> > > neighbor.
> > > When rose_t0timer_expiry() accesses the released neighbor member digi=
peat,
> > > a UAF is triggered.
> > >
> > > To avoid this UAF, defer the put operation to rose_t0timer_expiry() a=
nd
> > > stop restarting t0timer after putting the neighbor.
> > >
> > > When putting the neighbor, set the neighbor to NULL. Setting neighbor=
 to
> > > NULL prevents rose_t0timer_expiry() from restarting t0timer.
> > >
> > > syzbot reported a slab-use-after-free Read in ax25_find_cb.
> > > BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/=
af_ax25.c:237
> > > Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> > > Call Trace:
> > >  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
> > >  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
> > >  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
> > >  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
> > >  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
> > >
> > > Freed by task 17183:
> > >  kfree+0x2b8/0x6d0 mm/slub.c:6826
> > >  rose_neigh_put include/net/rose.h:165 [inline]
> > >  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
> > >
> > > Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> > > Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > ---
> > > V1 -> V2: Putting the neighbor stops t0timer from automatically start=
ing
> > > V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
> > >
> > >  include/net/rose.h   | 12 ++++++++++++
> > >  net/rose/rose_link.c |  5 +++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/include/net/rose.h b/include/net/rose.h
> > > index 2b5491bbf39a..33de310ba778 100644
> > > --- a/include/net/rose.h
> > > +++ b/include/net/rose.h
> > > @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct rose_ne=
igh *rose_neigh)
> > >         }
> > >  }
> > >
> > > +static inline void rose_neigh_putex(struct rose_neigh **roseneigh)
> > > +{
> > > +       struct rose_neigh *rose_neigh =3D *roseneigh;
> > > +       if (refcount_dec_and_test(&rose_neigh->use)) {
> > > +               if (rose_neigh->ax25)
> > > +                       ax25_cb_put(rose_neigh->ax25);
> > > +               kfree(rose_neigh->digipeat);
> > > +               kfree(rose_neigh);
> > > +               *roseneigh =3D NULL;
> > > +       }
> > > +}
> > > +
> > >  /* af_rose.c */
> > >  extern ax25_address rose_callsign;
> > >  extern int  sysctl_rose_restart_request_timeout;
> > > diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> > > index 7746229fdc8c..334c8cc0876d 100644
> > > --- a/net/rose/rose_link.c
> > > +++ b/net/rose/rose_link.c
> > > @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh)
> > >
> > >  static void rose_start_t0timer(struct rose_neigh *neigh)
> > >  {
> > > +       if (!neigh)
> > > +               return;
> > > +
> > >         timer_delete(&neigh->t0timer);
> > >
> > >         neigh->t0timer.function =3D rose_t0timer_expiry;
> > > @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_list=
 *t)
> > >  {
> > >         struct rose_neigh *neigh =3D timer_container_of(neigh, t, t0t=
imer);
> > >
> >
> > What prevents rose_timer_expiry() from releasing the
> > last refcnt here ?
> The issue reported by syzbot is that rose_t0timer_expiry() is triggered
> first, followed by rose_timer_expiry().

I don't see how you read that ordering from the report.
https://syzkaller.appspot.com/bug?extid=3Dcaa052a0958a9146870d

The only ordering I can find is that kfree() in rose_timer_expiry()
happened before ax25_find_cb () in rose_t0timer_expiry().

> Therefore, in rose_t0timer_expiry(), the reference count of neigh is
> increased before entering rose_transmit_restart_request() to prevent
> neigh from being put in rose_timer_expiry(). Then, in rose_t0timer_expiry=
(),
> neigh is put before executing rose_start_t0timer() and the neigh value is
> set to NULL to prevent t0timer restarts.
>
> The case where rose_timer_expiry() is triggered before rose_t0timer_expir=
y()
> is not considered at this time.

So this change just papers over the root cause.


> >
> > The t0timer could be triggered even after that happens.
> >
> >
> > > +       rose_neigh_hold(neigh);
> > >         rose_transmit_restart_request(neigh);
> > >
> > >         neigh->dce_mode =3D 0;
> > >
> > > +       rose_neigh_putex(&neigh);
> > >         rose_start_t0timer(neigh);
> > >  }
> > >
> > > --
> > > 2.43.0
> > >

