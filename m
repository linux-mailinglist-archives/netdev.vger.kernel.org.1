Return-Path: <netdev+bounces-80498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2387F57C
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 03:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BE31C214B9
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 02:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A137B3FE;
	Tue, 19 Mar 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DdMzqcEA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D847B3EB
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815582; cv=none; b=sGtA/6N5kmS1gAZ1yrfpj/alhpKyBbG2CnVKXZ2Nig/ajdOS7EDyvXIUcEAXVGEoQU72bz8QoOCpVMlIfvNsXV5kqFU1nBigV2rs8MZtcYkNEHBEvnKho1yGE3kLBcW29xmHNoghEEJwFucfMecznn/tJWWGGaUQXVI7G53zoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815582; c=relaxed/simple;
	bh=ZvlzHmiqM0PBn3qAhl+WMIP+un56FpRYKp1adoqUp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw/qR++hbG07kRvfhSjv0s/LpeaBKJBPwCemB4OT69Zix2H6gha36O3anx4ukwC9smvFCW8J3H/toOs15TGzTePtGrUACskenZR5PYL/s0L6opg1OfTVsVY7pS8mGIww7okDxUCMxXwdA5xBuX8R+2fPQ9fAgkOfRspNF5LoHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DdMzqcEA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso6517768a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710815579; x=1711420379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/ugjgSVKg/BMvJ6AYVxFTNZ2b8E1qURDrbsQiUbZk8=;
        b=DdMzqcEAOW1rMXNBlPg7KR8wQBFyTu++Lrrhnzgy81v5I3E9jnIcwh6OTtCWrcHkLr
         7+2BHbjbopQ2OhsOKFFfDTJYUs+UF37vRpavRU3Mno7L2KH8XSKl+TWw6pYVcMcBil1+
         h8rGy/s9FNnTPcPef2pe//FIgxCKG3ueawVlVqFrNXr14HVQGgT/nU9zBGR8XQEDnXok
         F/aQal8f29cTMdmEQpyvcTZUWp4Oz/ZSSgINiDhCF9Y13PJK+lKescMGdNu0S6dWlLIr
         YokECc0hm45gPe9Jm9M1EskJbVaA5vHaMCNOMLHZXncszy6J0H5EB2p6uRnDMKWg9sdI
         DpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815579; x=1711420379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ugjgSVKg/BMvJ6AYVxFTNZ2b8E1qURDrbsQiUbZk8=;
        b=Gp8kpD1IsJQQRms/W0C0MMn+f10MSX6lYN7U037b6BKVKd0UQ5DSK+IYCNvAuSmPg9
         d2PBArkMuH0a2NNHoVkSIfXwZwzTagms46RZqfpMg5VqFCcaEovH7i2S04ahwneMOexn
         Gmgvdk37JY0H54RYQthCRYxy8oPsaffG9WwkB+vcinrA0yBRxJgM92b7Hssk68kzCKqY
         WttKr4WLHy0wjugQ9MA2saXwnE9t2J+8SOsW3+IWgD/Yt8xMubE+ZDCNGPbZz1RMNQf4
         34bq0kDbrL/tFjW29gy8xqCgpVYMpCJq5G8sFGJT456G2aQUnGItocnHiZlhSA1yc8ZT
         qa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUidKLCjV+xnLPG2cpnis6kGBRIeJJawY7suE/W0hccpFAsnxCobqaw6pXGgIVLXdot4Falq8k4yqHSzYBX9SqDH+Y1Rbf
X-Gm-Message-State: AOJu0YyXerV9YRArWdufZ/KOMcjNcwCiUa8RSssluA4b98Z+n20mVN7k
	jq02P0HvUvSoOgtKFnImMH0+RsezESOUV+xGmqKKS+w6kgEuQUJb6UKGjF0369j52K6GdyT8tte
	98JTF9mPsgPfMjqeyJnxR368i7IJcD1eHHpIyyQ==
X-Google-Smtp-Source: AGHT+IHvclE+atGpCjbdPFGYgs5VD3VppiJOsondJO5t2uIPfOW/790Iy8kr+o7yx8R1UtGEsQwfHCPpLzwdhJuCkes=
X-Received: by 2002:a05:6402:1f03:b0:568:b4c8:9af with SMTP id
 b3-20020a0564021f0300b00568b4c809afmr7871934edb.17.1710815578912; Mon, 18 Mar
 2024 19:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710525524.git.yan@cloudflare.com> <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
 <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop> <ZfgecVqd6p-ACSZ5@FVFF77S0Q05N>
In-Reply-To: <ZfgecVqd6p-ACSZ5@FVFF77S0Q05N>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 18 Mar 2024 21:32:47 -0500
Message-ID: <CAO3-Pbp6fCayWeJ11U6JtqHn-Rs3OFXoZ9uMohUefSYUvSGUKA@mail.gmail.com>
Subject: Re: [PATCH v4 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 5:59=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, Mar 15, 2024 at 10:40:56PM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 15, 2024 at 12:55:03PM -0700, Yan Zhai wrote:
> > > There are several scenario in network processing that can run
> > > extensively under heavy traffic. In such situation, RCU synchronizati=
on
> > > might not observe desired quiescent states for indefinitely long peri=
od.
> > > Create a helper to safely raise the desired RCU quiescent states for
> > > such scenario.
> > >
> > > Currently the frequency is locked at HZ/10, i.e. 100ms, which is
> > > sufficient to address existing problems around RCU tasks. It's unclea=
r
> > > yet if there is any future scenario for it to be further tuned down.
> >
> > I suggest something like the following for the commit log:
> >
> > -----------------------------------------------------------------------=
-
> >
> > When under heavy load, network processing can run CPU-bound for many te=
ns
> > of seconds.  Even in preemptible kernels, this can block RCU Tasks grac=
e
> > periods, which can cause trace-event removal to take more than a minute=
,
> > which is unacceptably long.
> >
> > This commit therefore creates a new helper function that passes
> > through both RCU and RCU-Tasks quiescent states every 100 milliseconds.
> > This hard-coded value suffices for current workloads.
>
> FWIW, this sounds good to me.
>
> >
> > -----------------------------------------------------------------------=
-
> >
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > > ---
> > > v3->v4: comment fixup
> > >
> > > ---
> > >  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 0746b1b0b663..da224706323e 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -247,6 +247,30 @@ do { \
> > >     cond_resched(); \
> > >  } while (0)
> > >
> > > +/**
> > > + * rcu_softirq_qs_periodic - Periodically report consolidated quiesc=
ent states
> > > + * @old_ts: last jiffies when QS was reported. Might be modified in =
the macro.
> > > + *
> > > + * This helper is for network processing in non-RT kernels, where th=
ere could
> > > + * be busy polling threads that block RCU synchronization indefinite=
ly.  In
> > > + * such context, simply calling cond_resched is insufficient, so giv=
e it a
> > > + * stronger push to eliminate all potential blockage of all RCU type=
s.
> > > + *
> > > + * NOTE: unless absolutely sure, this helper should in general be ca=
lled
> > > + * outside of bh lock section to avoid reporting a surprising QS to =
updaters,
> > > + * who could be expecting RCU read critical section to end at local_=
bh_enable().
> > > + */
> >
> > How about something like this for the kernel-doc comment?
> >
> > /**
> >  * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> >  * @old_ts: jiffies at start of processing.
> >  *
> >  * This helper is for long-running softirq handlers, such as those
> >  * in networking.  The caller should initialize the variable passed in
> >  * as @old_ts at the beginning of the softirq handler.  When invoked
> >  * frequently, this macro will invoke rcu_softirq_qs() every 100
> >  * milliseconds thereafter, which will provide both RCU and RCU-Tasks
> >  * quiescent states.  Note that this macro modifies its old_ts argument=
.
> >  *
> >  * Note that although cond_resched() provides RCU quiescent states,
> >  * it does not provide RCU-Tasks quiescent states.
> >  *
> >  * Because regions of code that have disabled softirq act as RCU
> >  * read-side critical sections, this macro should be invoked with softi=
rq
> >  * (and preemption) enabled.
> >  *
> >  * This macro has no effect in CONFIG_PREEMPT_RT kernels.
> >  */
>
> Considering the note about cond_resched(), does does cond_resched() actua=
lly
> provide an RCU quiescent state for fully-preemptible kernels? IIUC for th=
ose
> cond_resched() expands to:
>
>         __might_resched();
>         klp_sched_try_switch()
>
> ... and AFAICT neither reports an RCU quiescent state.
>
> So maybe it's worth dropping the note?
>
> Seperately, what's the rationale for not doing this on PREEMPT_RT? Does t=
hat
> avoid the problem through other means, or are people just not running eff=
ected
> workloads on that?
>
It's a bit anti-intuition but yes the RT kernel avoids the problem.
This is because "schedule()" reports task RCU QS actually, and on RT
kernel cond_resched() call won't call "__cond_resched()" or
"__schedule(PREEMPT)" as you already pointed out, which would clear
need-resched flag. This then allows "schedule()" to be called on hard
IRQ exit time by time.

Yan

> Mark.
>
> >
> >                                                       Thanx, Paul
> >
> > > +#define rcu_softirq_qs_periodic(old_ts) \
> > > +do { \
> > > +   if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > > +       time_after(jiffies, (old_ts) + HZ / 10)) { \
> > > +           preempt_disable(); \
> > > +           rcu_softirq_qs(); \
> > > +           preempt_enable(); \
> > > +           (old_ts) =3D jiffies; \
> > > +   } \
> > > +} while (0)
> > > +
> > >  /*
> > >   * Infrastructure to implement the synchronize_() primitives in
> > >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > > --
> > > 2.30.2
> > >
> > >

