Return-Path: <netdev+bounces-88779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B958A886D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7F9B20CA5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6F1487C0;
	Wed, 17 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBVfmQR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7461482E8
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369961; cv=none; b=gpjKBQ0Ge/kmru14WkotlOFNvfGmBmhlDreqqjMRo1cA65CSILS9fMUxHaeFnEkx7h8fmOfRGamSgl3z6Mgd1O80CDdfM1KSyjmujDxi7KXCIhKa3MUXMtVeV9nZihRU4pJmNX9BK10bdVsqtTWqCRiR/hJU3slgtkHM6oRcZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369961; c=relaxed/simple;
	bh=5b908OQHWDDcZC0CkaK9nkizk9RQfOQFDhBaGsLKjT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1l0TAx+pC7lL3Nut5E/YQKvaortywB3cOnmLTJ6P+myMZNQO4oikcoWGJwdkMjeQjiAS8F/ZngdF4oGSciwdsC7JnuErkzagCw1zVljt2/Sh0p/XtwnHh9rdWG0t8xV50oFKu6UQp0morrqDqR0FmdCUFUFlz1vmZ5yNXEkja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBVfmQR6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso17706a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713369957; x=1713974757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gu1tGIK91kHZuchV5AKADHbefWv5hrhwng0XQF3BVg=;
        b=dBVfmQR6V/Y4fqNRTE1q3LLun8F9PUN5UrKitG7T7uuI5d3eRQ2wYtQAkYqwTbG6Mp
         Sf7rdH5YNmcaX50wn3UbNzwHHfL/CEAmcgpgERLWtSX3QaVedoO9qk8EV+4KvdWZHvkX
         VKlHgzxKELozeiaj+D9iPrXVFL1BkjiAHmfxqNyFBOf80Tlg9M3ejrJHMw2+Mfq8/5Fa
         x0o+UTR4a9m2QNqa+uvo/dipG0xhP6+Le5E8LeWzP9Km2+SppotuaEJWKx30Y6+LEdlm
         zVG14A/r36nehZ8fpb16GxOaMKfz7XbDAk6pFbViNLa0aXI/7l2ELSFqFpNGWqLDx4Dd
         /OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369957; x=1713974757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gu1tGIK91kHZuchV5AKADHbefWv5hrhwng0XQF3BVg=;
        b=kLz0oWhibJbmkKe6GoKhkfTwRtyAZg7X/MPR8Ras115DlMvimeBgZjCw8NTcr5Isq+
         PGuti8P42JvWBWPb5hnXt3bTsVjpLQpVfvAwrZ0tpI7DET4oW5W4QwStAMHUTs0kdoLF
         9nVTw/8cJpe6tlfMRMsNyQ4d6tgNpK1WJi36tNE012YTWD/8iJMzbRO3tGWnAhOtzyUt
         RNiMjDhEd7Da3wYGEHpl96QER5s3TAQ2Jz4OajtmIgsZpMpCYMSj53jUxYyCpUpkukKg
         Tz4NBTSvOe4Dqw/BjK4gtzk2xQDEVrsU4q9qM+h7SkrXBbIKaH9PI4wxUUThnaygfPQp
         bwCA==
X-Forwarded-Encrypted: i=1; AJvYcCXtOwG4Cx8hnnEvi8oEahdf6K3UdrtX4EBqpout6NPsTji+aziYaC8zLeL0bF8aPzwEeiHMCFUsE7FCPrZClnF4/vwoVcka
X-Gm-Message-State: AOJu0Yxhh+xbLVOHyYHL3RN0WHe7sDS1TuGkmVDgD3NBJrCTpnus5cqy
	Www4sXAMSxUKs4iEpK/W6CjPofJrID91uHjiAsC8gSNR261x+ATQxI6KLVYuxUPyKRxaSRMyN42
	/ZTtSm1+Gmz0/dX3WqhfhDY5pGEkxqmo5fx4R
X-Google-Smtp-Source: AGHT+IEyXObPausrdag05JW91pyeKMX6C9YUp/4xI3XiUwQL9nTuUsPMtH34DR4Kkq+/r3ec28/BVZsckof7hHrVVjM=
X-Received: by 2002:a50:c347:0:b0:570:5cb3:b98 with SMTP id
 q7-20020a50c347000000b005705cb30b98mr168627edb.4.1713369957400; Wed, 17 Apr
 2024 09:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-6-edumazet@google.com>
 <20240417155909.GZ2320920@kernel.org>
In-Reply-To: <20240417155909.GZ2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 18:05:46 +0200
Message-ID: <CANn89iLKtpszMyzmOvj0QdQCvsyDv7S_R04SrfEdOMZb5HQexQ@mail.gmail.com>
Subject: Re: [PATCH net-next 05/14] net_sched: sch_codel: implement lockless codel_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:59=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:45PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, codel_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in codel_change().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_codel.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
> > index ecb3f164bb25b33bd662c8ee07dc1b5945fd882d..3e8d4fe4d91e3ef2b771564=
0f6675aa5e8e2a326 100644
> > --- a/net/sched/sch_codel.c
> > +++ b/net/sched/sch_codel.c
> > @@ -118,26 +118,31 @@ static int codel_change(struct Qdisc *sch, struct=
 nlattr *opt,
> >       if (tb[TCA_CODEL_TARGET]) {
> >               u32 target =3D nla_get_u32(tb[TCA_CODEL_TARGET]);
> >
> > -             q->params.target =3D ((u64)target * NSEC_PER_USEC) >> COD=
EL_SHIFT;
> > +             WRITE_ONCE(q->params.target,
> > +                        ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT);
> >       }
> >
> >       if (tb[TCA_CODEL_CE_THRESHOLD]) {
> >               u64 val =3D nla_get_u32(tb[TCA_CODEL_CE_THRESHOLD]);
> >
> > -             q->params.ce_threshold =3D (val * NSEC_PER_USEC) >> CODEL=
_SHIFT;
> > +             WRITE_ONCE(q->params.ce_threshold,
> > +                        (val * NSEC_PER_USEC) >> CODEL_SHIFT);
> >       }
> >
> >       if (tb[TCA_CODEL_INTERVAL]) {
> >               u32 interval =3D nla_get_u32(tb[TCA_CODEL_INTERVAL]);
> >
> > -             q->params.interval =3D ((u64)interval * NSEC_PER_USEC) >>=
 CODEL_SHIFT;
> > +             WRITE_ONCE(q->params.interval,
> > +                        ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT=
);
> >       }
> >
> >       if (tb[TCA_CODEL_LIMIT])
> > -             sch->limit =3D nla_get_u32(tb[TCA_CODEL_LIMIT]);
> > +             WRITE_ONCE(sch->limit,
> > +                        nla_get_u32(tb[TCA_CODEL_LIMIT]));
> >
>
> Hi Eric,
>
> Sorry to be so bothersome.
>
> As a follow-up to our discussion of patch 4/14 (net_choke),
> I'm wondering if reading sch->limit in codel_qdisc_enqueue()
> should be updated to use READ_ONCE().

No worries !

A READ_ONCE() in codel_qdisc_enqueue() is not needed
because codel_change() writes  all the fields  under the protection of
qdisc spinlock.

sch_tree_lock() / ... / sch_tree_unlock()

Note that I removed the READ_ONCE() in choke enqueue() in V2,
for the same reason.

>
> >       if (tb[TCA_CODEL_ECN])
> > -             q->params.ecn =3D !!nla_get_u32(tb[TCA_CODEL_ECN]);
> > +             WRITE_ONCE(q->params.ecn,
> > +                        !!nla_get_u32(tb[TCA_CODEL_ECN]));
> >
> >       qlen =3D sch->q.qlen;
> >       while (sch->q.qlen > sch->limit) {
>
> ...

