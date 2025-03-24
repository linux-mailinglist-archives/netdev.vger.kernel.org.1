Return-Path: <netdev+bounces-177066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DDA6DA08
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AD3188DC4C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70E25E810;
	Mon, 24 Mar 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkDid8qQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8F1A5B85
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819105; cv=none; b=Gs7Q6F7AvlbvfVtM2HBPjHuA5dV+dBQ5jjxZ+G98X/vBQKHuxFH2Zjx4RM0qeHkoGzYaRgi7uNKtnLyY1z/ragfWam89vU2rgqegAyMEnM/EFA2t8q2z6cqsW2vdY4JjcR6ByAizP6zelHSbopijOHhLdghFCGMRlPjOC57egwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819105; c=relaxed/simple;
	bh=BBasGNYs4JxAOn5YK/6EYe4qFJJwybbpdacgazkiMwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSFGPQJhVKaQfhGePCLoVCQ6sCVX6lPOEiix62cRCXRuGRMIK2jjwsZcMiPdrinNm/a6Ah0+YS0jE5/nKXxk9ISXQSOUpA1zuplLO6dietnHfiNKYqMNpNmRGC9UXcI0pH+piQYLci6xC7L6B196mqgIjhxYcUM6rhvNw57fy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkDid8qQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4767e969b94so20813991cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742819103; x=1743423903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToRdZE8LaMAszP0tjQvfUUo+dHg2cOCzpPUQlHznVdk=;
        b=MkDid8qQI72d+l5lP5qDZ842qZvHqu7LZpunqryc+53LVx/Wx04lXyXG14uagky440
         FSYR6ZE4xINfBq1IbTsVqrP6RVV5HornehFOdyDAkJ6Xt1ghvQ0BEUPAVtD4N86CtFNR
         YdcG4LZNUCcfwOSgca96mnbGSV7hU3iFX5L9RYO53NguuHVthT+fvFL8U0cBm/MTLvWU
         j4utw/f4jOrIocFyOc9j1LXIrAAWtR5xRwu4d97TIoTQiRzjVgUdS80aYWS7J1Vx7mV/
         N+w6XHakR9tK5hlsOWlXRGMBKHdGLDVOMuIMkUH587s4IIzkbkok1GJsGZu+6YHJK0OY
         Ch6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819103; x=1743423903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToRdZE8LaMAszP0tjQvfUUo+dHg2cOCzpPUQlHznVdk=;
        b=aMFz2IXkOA5Fg2UiBlt65xt3Q/mFJZ2oUaUKVe8hDUfY36EbIdHOJrNVDEt48G8WGM
         nSHoj3wPARPlNs4C4AYGLQzGPP8Fu9hWifT4QJkhJsLXRIehBNkKtJOOBUul2HfvV7v9
         PtaMTL/WAcP2jpaABTcloQ0eAn274eZe8ZRWB6UG9agAtCk+19PAxfUfhHvK5bEEkQB/
         zIL8uln7lLuHCUWI6CbkhaTX30bKJ4fBVQfjcgb+P85bGA7txasYcL8aYO/bDAZgWP4k
         nv4afmelWMmc3fMk5SbexsCbV6LONbgo6yYnJrU/IiHo+/jNMExm7DbS+l8HB/M6R6gL
         HFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu7Xc3w57s9aEjvDe6pYchekNQzjPccpqLmWdTdBjLmk0nt6rP5aEUC5y22rlBOWrQ4z2+BLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmigYmxjS75eihfngIgEU2lXJB8yNXmUCClgzfyXsUn8Hj5tkO
	LN0pg9LVwM4wsMP47u0HlxXRhMKRq5uAte17cv+Gw30cXhv1HKXoAnqcom3YyZTpug8WB3/2kBd
	FKGyUPpQcb9QSv1y66AvKjCw5bWu21S3FNeLEvcPQZY2r+LQZDQ==
X-Gm-Gg: ASbGncvx7l7oRSKy5hqnS8OIpND3+WAimfca1QOltT1T8tm2lHCsAJcWY/+gIpZWRHt
	B2kPhvcWI62odSSUw7sQ7t7LnLVl1FE1rYbebnCOcYO1AvQ7nypTBnAtiUc6smFBwlubx5P8Hjp
	FbdRRPxq8Usy/xgfnx2una7UYyWX4KYTBaUMDyhg==
X-Google-Smtp-Source: AGHT+IGSFt/ktK10TbWQLF/RWbGmpp6usyQqxqGHRyFr4WR6VxGq8CFhL6+IoCnryw0FQELGtLBVxJEX5Ye2Oj//5ts=
X-Received: by 2002:a05:622a:5c05:b0:477:e17:6b01 with SMTP id
 d75a77b69052e-4771de614e8mr243217671cf.43.1742819102568; Mon, 24 Mar 2025
 05:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net> <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
In-Reply-To: <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 13:24:51 +0100
X-Gm-Features: AQ5f1JpDWf1XLfnOkZb7xev5EDvOCfZ4H_P7PQlI37cioEJbMuGetv-P4KDZLgU
Message-ID: <CANn89i+As5XLgWadB8L3ejVOQv6w4cCo_JHS=WXtacum4fY5Fg@mail.gmail.com>
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

On Mon, Mar 24, 2025 at 1:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 24, 2025 at 1:12=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> > > lockdep_unregister_key() is called from critical code paths, includin=
g
> > > sections where rtnl_lock() is held. For example, when replacing a qdi=
sc
> > > in a network device, network egress traffic is disabled while
> > > __qdisc_destroy() is called for every network queue.
> > >
> > > If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key=
(),
> > > which gets blocked waiting for synchronize_rcu() to complete.
> > >
> > > For example, a simple tc command to replace a qdisc could take 13
> > > seconds:
> > >
> > >   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> > >     real    0m13.195s
> > >     user    0m0.001s
> > >     sys     0m2.746s
> > >
> > > During this time, network egress is completely frozen while waiting f=
or
> > > RCU synchronization.
> > >
> > > Use synchronize_rcu_expedited() instead to minimize the impact on
> > > critical operations like network connectivity changes.
> > >
> > > This improves 10x the function call to tc, when replacing the qdisc f=
or
> > > a network card.
> > >
> > >    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> > >      real     0m1.789s
> > >      user     0m0.000s
> > >      sys      0m1.613s
> > >
> > > Reported-by: Erik Lundgren <elundgren@meta.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > ---
> > >  kernel/locking/lockdep.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > index 4470680f02269..a79030ac36dd4 100644
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_=
key *key)
> > >       if (need_callback)
> > >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > >
> > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_e=
ntry. */
> > > -     synchronize_rcu();
> > > +     /* Wait until is_dynamic_key() has finished accessing k->hash_e=
ntry.
> > > +      * This needs to be quick, since it is called in critical secti=
ons
> > > +      */
> > > +     synchronize_rcu_expedited();
> > >  }
> > >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> >
> > So I fundamentally despise synchronize_rcu_expedited(), also your
> > comment style is broken.
> >
> > Why can't qdisc call this outside of the lock?
>
> Good luck with that, and anyway the time to call it 256 times would
> still hurt Breno use case.
>
> My suggestion was to change lockdep_unregister_key() contract, and use
> kfree_rcu() there
>
> > I think we should redesign lockdep_unregister_key() to work on a separa=
tely
> > allocated piece of memory,
> > then use kfree_rcu() in it.
> >
> > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a point=
er to
> >
> > struct ... {
> >      struct lock_class_key key;
> >      struct rcu_head  rcu;
> > }
>
> More work because it requires changing all lockdep_unregister_key() users=
.

Or add a new function, basically allow users to be converted when they need=
 to.

