Return-Path: <netdev+bounces-242629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946DBC93225
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415AB3A8E90
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374D2D5920;
	Fri, 28 Nov 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="D+UFBkCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A726B971
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764363186; cv=none; b=JICTPUP7kKeAsRFShmOinkfH0pUectMScGEYNunKMsVLsQG5e+fK3q9D7mKN+sijBfvbXkbyAJ6dCplZih/Ftfijtcq7JdrcyH4XHx8yNcvHHTIhNqnc0qajwVwapEOmA/WrP1LAw2k9y2sa7gtzV+j1OojGMEMt5ouda3hCcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764363186; c=relaxed/simple;
	bh=Js3xj2aiv+xlnQ8eUy+vcnCYv2tp2RHOX+242GR5tG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9sSzbFL55DfFO5Oe5OVIvYMm1tcHz13oyq1D9CwBfuJhhpvyx7k6DHJLPcPtCDMQ1MBlMLwSZOSSuva6F5JNQJveOYa1u/rm06W3M0qGqwmiFGlJ//GX7WsPj+8oJBz0dR/N101FmS33keiHNZmPZqM6tLwwJZTf15LnkqVzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=D+UFBkCU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34381ec9197so1974099a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764363184; x=1764967984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLNZk9IpPA5ZOJfeFQ1y2wnf6+19SXAAm7Mn2f3oaVE=;
        b=D+UFBkCUTRujQ9kPVeTLfFNtOd4GGS5Ym04ooolrc/fmjpqEv9Kjg1yiqkDse4fRH0
         fvr7B/xgTsXgTFLnw7U53LPd/DF/s2ynQkAaxxnWOPfRz46j9FLVuVVupHYY9ZEsOjr3
         5zGJvSGltW3bOU3kbZBbvNnxOU0+s85Ln2UGU8jH3bkV4hLcKYLr1A+IfC/RZPqke90H
         rzaaHbvr3pout4VkOv6pW/AYzPvkAL44NpBUiAFa4cG9fX1chwpTeP3EJwLp6fBUrqaj
         jQhGPx1xhnA9kJJOHKOOGLwulIS0GadnBthhZfE92C/rYEWykrVp58ZFTwOnER5qQqBZ
         FHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764363184; x=1764967984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLNZk9IpPA5ZOJfeFQ1y2wnf6+19SXAAm7Mn2f3oaVE=;
        b=UMxea4bN6yjZccdg3SOGdrdocCwjy6ptGHmmu10mCjuLmV4ASY+Qk6uWQfI9oPgSlH
         4cB3jqw5Z+btZYDXhJuEwGjqwIQJvI24VI35qJ78yP6ynfg2y9H4w55r0c5j9PkyJ5/U
         aJ+zRAJC1NzFEQLKe8ApSYehPo5Z6MFG5graAHUlZDJlbpZX0mMF1iCJVEbxu1+y+2Hy
         mVEBzg13cpWp9aNsvYpV/X8RhmUs4VBbcf70MQH0oEhebaveq2ApY2Qv8x6tcN3AScfv
         3niwpY4/B23Sh1nOH5sce9Qe/J+GtBCBCQjIYO8g+39Xrmi6K5XMpIHf9ch96s8PqMK6
         8HQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgQkI2Hlz6EQBUQ5tnC5cHf2AjGyG4PAuCMFLO2t3zy8QWQsONsJhU0K0+Q7g9YZPJFPn0wb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC61RC4xbOUNgudad/A6flrQLxkNq0+jNCxMcZ96Uwj3CJsaYs
	aBBE5VYfnb1UXxp37Hi2sCTnklrBiAbvat/H/2g/eNWq0iWkdiG2+rAPCBsbgoIsQPTVYk6+9F6
	Pg+K/gsAdqya+/FinUhUS1MCmneZCXMnf0BAbrvft
X-Gm-Gg: ASbGncsqdYzOA7nzTTxVLY2CtArbdG+/vifEuHpnwh5CuFdunONoaXS3lVtX1Vx6HSv
	7jaAacSoW2f8/QKFnhEzHGrtLy+WQ1Uq9eF0CJsZm0X7fSz3cMJzgvd75XqArP+Tra8MJJ+cKw4
	0mOjcu9slW0BOSFjfte715y9O2akErubNi5uxDxY0+k0ztzirtMyTrFTHtaDTNB7tUjfyuViYhY
	N1ciorePyxVqsq5jE4Gw+V14oYyh3KzV3bhxdRT0zbv87H0EHy/Bhw7cUZhnMZYspaOTEgwXdrh
	qIU=
X-Google-Smtp-Source: AGHT+IHwrmCHq6+3KvRYuggxU1nnDIBKKxMDevpPjSh7UQBtIFM8+3tEHcqvONTsOoS4IN6oEV7U9No9dkTHIXmeoB4=
X-Received: by 2002:a17:90b:1ccf:b0:343:6108:1712 with SMTP id
 98e67ed59e1d1-34733f34400mr25820562a91.18.1764363184123; Fri, 28 Nov 2025
 12:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128151919.576920-1-jhs@mojatatu.com> <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
In-Reply-To: <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Nov 2025 15:52:53 -0500
X-Gm-Features: AWmQ_blsh_zkAYwz4mbZn2jN9rsDY1gq4fhD2WntoTBzzoE3F-T4mKDao2z7ogw
Message-ID: <CAM0EoMmtqe_09jpG8-HzTVKNs2gfi_qNNCDq4Y4CayRVuDF4Jg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, horms@kernel.org, zdi-disclosures@trendmicro.com, 
	w@1wt.eu, security@kernel.org, tglx@linutronix.de, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On Fri, Nov 28, 2025 at 12:25=E2=80=AFPM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> On Fri, Nov 28, 2025 at 10:19:19AM -0500, Jamal Hadi Salim wrote:
> > zdi-disclosures@trendmicro.com says:
> >
> > The vulnerability is a race condition between `ets_qdisc_dequeue` and
> > `ets_qdisc_change`.  It leads to UAF on `struct Qdisc` object.
> > Attacker requires the capability to create new user and network namespa=
ce
> > in order to trigger the bug.
> > See my additional commentary at the end of the analysis.
>
> hello, thanks for your patch!
>
> [...]
>
> >
> > Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond =
'nbands'")
> > Reported-by: zdi-disclosures@trendmicro.com
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_ets.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index 82635dd2cfa5..ae46643e596d 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
> > @@ -652,7 +652,7 @@ static int ets_qdisc_change(struct Qdisc *sch, stru=
ct nlattr *opt,
> >       sch_tree_lock(sch);
> >
> >       for (i =3D nbands; i < oldbands; i++) {
> > -             if (i >=3D q->nstrict && q->classes[i].qdisc->q.qlen)
> > +             if (cl_is_active(&q->classes[i]))
> >                       list_del_init(&q->classes[i].alist);
> >               qdisc_purge_queue(q->classes[i].qdisc);
> >       }
>
> (nit)
>
> the reported problem is NULL dereference of q->classes[i].qdisc, then
> probably the 'Fixes' tag is an hash precedent to de6d25924c2a ("net/sched=
: sch_ets: don't
> peek at classes beyond 'nbands'"). My understanding is: the test on 'q->c=
lasses[i].qdisc'
> is no more NULL-safe after 103406b38c60 ("net/sched: Always pass notifica=
tions when
> child class becomes empty"). So we might help our friends  planning backp=
orts with something like:
>
> Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'n=
bands'")
> Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from =
the round-robin list")
>
> WDYT?

I may be misreading your thought process, seems you are thinking the
null ptr deref is in change()?
The null ptr deref (and the uaf if you add a delay) is in dequeue
(ets_qdisc_dequeue()) i.e not in change.
If that makes sense, what would be a more appropriate Fixes?

BTW, is that q->classes[i].qdisc =3D NULL even needed after this?
It was not clear whether it guards against something else that was not
obvious from inspection.

cheers,
jamal
> --
> davide
>

