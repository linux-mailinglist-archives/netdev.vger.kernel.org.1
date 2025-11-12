Return-Path: <netdev+bounces-237807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099EFC5071B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D973A72E5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66C22370D;
	Wed, 12 Nov 2025 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOuR5qiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CF1DE8B5
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919352; cv=none; b=CEbAUT8YSjkRXZIpF1a6JkaJ23Le0+zOUpPGNZfClOsZ4RODcvHsY6eSyqDLhUhtHPKwZ5YDaed4uUTGl+VwKFgp8zovq7RB4225vBJIgmdb8Ca2vcbPFrm1razdev2bPiUJd9Pw9ik8AKnJQMGYvhQ3mmjGMuzAbeHEEYT3Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919352; c=relaxed/simple;
	bh=Q2l5zlCZ7FCDU8QIZlCsM68JImgcEXzwIGSEqEutYXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOAPsHguWSq3oLRc3zyMQObEbKZLMW4UukoWpq3dzmhnk/LNsgHaqeVBDNjNV5CJaigl1Eu8IUlv2sgDxCcj2F3XPEGMtJoSnKVaBXCBKEciwcXzWVST3wDAItfwG09BDVLTpQx4PvegZ5wCNiv0p75HjyOPMx8v8JzkG6nZqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOuR5qiQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-298145fe27eso4277805ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762919348; x=1763524148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl5bz9l18gUMHjozAgMW1FH8sHXRwkJVM8xIbme4eWg=;
        b=EOuR5qiQwudEjaYBK2yf/F3+cwuJPXrx4mLpPT1eMy99LAZcadiD7+vLUp6kjnCjec
         a0YQx82AOY9nWHTQuIGHnwon/Nmb2TnZaKjBlob9OQR6EIageNjK8i6JPSusSpd4Hh3+
         l+MyGkU9nra0BlroLCvizOZydyash9yTpuEcmh1k5CqKKFipLYDZu/bC37wYD4ktRZB5
         hWt+3Bl41I/IR8K7DM9KdnT+7ssUlDAYy/yWD8BhR0fZ9W6xTxPpb/y2zeA5B/mQEZgA
         KtLoX8pgnRulQOVY6DbTTOFYDjuKWWkIUgZRLdS473YfztbYcNu8oMP7kpiw6RpvZTGl
         Xp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762919348; x=1763524148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xl5bz9l18gUMHjozAgMW1FH8sHXRwkJVM8xIbme4eWg=;
        b=NV49KThRixH5yMl0VqOulcAHYALQzeo+yHPOb7rZHmKBezNMJb73ER8B2pvhKPDtMX
         zGZWQfylq4gp2vF9WBVA/MXib43MHhqkD1G7iLAphyryCHhT9zs7P0JK+rSDxHw3UKNB
         am8S4xuU2ez+Jawgd/u+XPIfJvevMLeEp4bnvCYjCHROLmtsEPFaJKX9+AEnaSUyEon1
         GyYtjTf1lFjpQX300/jiKSHPwjcHHigK2avWd57iqIhUcfPJnlZjhiCWovh6aZ2tHKNB
         N29AmwwpwjUHHCYiP2iHaNEIUEQ/zKLw3DZkkDYXACU/1hv/clNpWcP9PFGABd9g7h1m
         dYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsnxDvhT/At/SuOhFeunQx9va5iRy3+Hsi0treKUzvC+3O8slhs8Su+abbxb6VMpN7BKdYzTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVKPDYz2oEP91VF9i7qBvMklgMNQ3sE+tgPaZRPARIdPuWfHw
	+s4R5FPfLOg0frOUuHW8HHiTnx/3iDUCLuGQtgXPk39mpcbH2JLDGDqDkCtM8W2evzQguuM8SK9
	AN1z4hvVNeEbfLp0xeuKdMSMQYQoD8VlaWY9gtcLI
X-Gm-Gg: ASbGncvX3vvs72raNajOkA7Bh3iknijV+ZL66Fc4mw2Xi2F5EeO20OXZvonlH1zLcRj
	c/u8gferzyVOJXPjo0jiyF/0JEGwYp1UAabM+EnSR+o+izsAqGxv9CvMlWxMQDDTn6pC5A4dfwe
	96h4B83eBBXKmSt2R0w8EOJp39jJatyxRhVyGwbRsyy+JdO/yjHc1tS2OjUcHMuSZQuKBgbYrTG
	NsL6acnFLFZuii7s+lLy2enj9QQcg0gf4cYg5ys0WZTFPwDKniRM3iRCRN2oKNornJNLNR3OkWS
	vRu63kTRZhVtw0O0uxTNlR9kVFzWChACEcRrN90=
X-Google-Smtp-Source: AGHT+IEWFQGvRzmLS/N4HSZcLtU6qcOMbA11o7ZpmqpIAJa0d40w6VUsOE6JiUb4JwMVV3n5KsbaCopmdrftgRLN0BQ=
X-Received: by 2002:a17:902:ce83:b0:295:9e4e:4092 with SMTP id
 d9443c01a7336-2984ee05655mr22604605ad.56.1762919347616; Tue, 11 Nov 2025
 19:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106071050.494080-1-kuniyu@google.com> <aRJJaCVk181ErQWJ@pop-os.localdomain>
 <CAAVpQUDi8hLHa6nps9PyNbxqLUEm4znO8xF8M=rER5UAEN7ghw@mail.gmail.com>
In-Reply-To: <CAAVpQUDi8hLHa6nps9PyNbxqLUEm4znO8xF8M=rER5UAEN7ghw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Nov 2025 19:48:56 -0800
X-Gm-Features: AWmQ_blMwCXO_hOrZTBHrD3s9de6uaaehNcBSSAUkMC1mSEHrAzTpvNL0EZY-vY
Message-ID: <CAAVpQUDxg_BjyJ5ZPYAwCiWwZ=pgb4x+uymc=x_yPs8_hiSbzw@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: sched: sch_qfq: Fix use-after-free in qfq_reset_qdisc().
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Valente <paolo.valente@unimore.it>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, Nov 10, 2025 at 12:22=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.=
com> wrote:
> >
> > On Thu, Nov 06, 2025 at 07:10:49AM +0000, Kuniyuki Iwashima wrote:
> > >  static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 pare=
ntid,
> > >                           struct nlattr **tca, unsigned long *arg,
> > >                           struct netlink_ext_ack *extack)
> > > @@ -511,6 +541,10 @@ static int qfq_change_class(struct Qdisc *sch, u=
32 classid, u32 parentid,
> > >               new_agg =3D kzalloc(sizeof(*new_agg), GFP_KERNEL);
> > >               if (new_agg =3D=3D NULL) {
> > >                       err =3D -ENOBUFS;
> > > +
> > > +                     if (existing)
> > > +                             goto delete_class;
> > > +
> > >                       gen_kill_estimator(&cl->rate_est);
> > >                       goto destroy_class;
> > >               }
> > > @@ -528,40 +562,14 @@ static int qfq_change_class(struct Qdisc *sch, =
u32 classid, u32 parentid,
> > >       *arg =3D (unsigned long)cl;
> > >       return 0;
> > >
> > > -destroy_class:
> > > -     qdisc_put(cl->qdisc);
> > > -     kfree(cl);
> > > +delete_class:
> > > +     qfq_delete_class(sch, (unsigned long)cl, extack);
> > >       return err;
> >
> > Is it better to just call qfq_delete_class() directly? Two reasons:
> > 1) It is only used by this code path
> > 2) It reads odd to place a 'return' above 'destroy_class' label below.
> >
> > And, what about the error patch of gen_new_estimator()? 'existing' coul=
d
> > be true for that case too, which I assume requires the same error
> > handling?
>
> Ah right, the path also needs qfq_delete_class().

Oh no.  Just to be sure, I assume you meant
gen_replace_estimator() (and gen_new_estimator() in it), right ?
Otherwise 'existing' can't be true for the other gen_new_estimator().

In case gen_replace_estimator () fails, we just return an error
without destroying the existing one because we can still use it
without reverting gen_replace_estimator().

So I think we don't need extra error handling for that case.

