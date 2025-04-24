Return-Path: <netdev+bounces-185624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA7A9B29A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003D33AF6C2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BE1C84BD;
	Thu, 24 Apr 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="k7i4jTg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E411B414E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509220; cv=none; b=KRySCR2R4mEHlHidPB5qxBtO6mXLXpx5ZCn9M/FYUlLioOOqrRRvlq3yrZmjsB6gz82oqM9Sw2lZVEGdumZqzM6AP/NOka0F+rBcWtfnSygQ0Y0e9f6x1ZNF+TpWsHT0EPF4icCt0KU0a334X15GqDnepPXq3tGGO2lSTq5bjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509220; c=relaxed/simple;
	bh=bcQazPS7+7efqONLpoP2Cloa6Deag66usEPKrLzEGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKxVknPrYBiL1F/05Jv8w1gE0KRULIGLsbz/5wyn+dgr3Jq6uWP3ZXx7xRgeMz2GhBPFzfdtozgb6Phkclw+Owob8jHbfNYhYWT2U/HBKflmG/bM+QrkLwh4KSp5INXWYqjTBLUkieIKRbWu0GgXNl8eyyl4Fu4xg0/Gz6ibLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=k7i4jTg6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c062b1f5so1064376b3a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745509218; x=1746114018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOVRiGRKPnYWbHEY9UgSeA8yXGdel9iEffYAhGM0/Ww=;
        b=k7i4jTg6MG8O2mitXGhnvrWaXz8adFj1RxafmjadfjOO7lJZqzgPT8d7/+lytkQBkg
         mi5ot78kCpsJWLuXsWc5oAY7yufR/pQCd4cBYyIPMuxFUUFgY0D0A0vnzEPfiw+PolDL
         Prlgc5Gddy7vTx94mAiPJXVj4B7c20U/1hCG87ZRQpje0GA7W87xo4ApgfC036fANCHk
         shbkYKplQ89k0JSkRX53vFMEJgHOOAhUwMdRFxCswevmY7TMF0cwpIw+8ZX4aBIR1qFR
         cPzg6QlfoD4/hWE39LQrxud3fy9zGWs3H8XBAfrJ464DoJEZV0g9ghGHM+DbQKl+nk7r
         qiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509218; x=1746114018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOVRiGRKPnYWbHEY9UgSeA8yXGdel9iEffYAhGM0/Ww=;
        b=lkhb/IwhapspgYhnSHUxexf+z8Yvo+UNIN3J6oKgq9jPMXhm526jj+6rYPMmp+HrkC
         QZaLvoz4rX8EASnk1jAtxq7pCqPrlD2lSfS4i059w3LvZQlaiSgZ5crBPFf2tZYeJP+k
         mzLMdULKHtLnQ1URsBfbV3PCobBv6K6tt/Er8tt3ia3R8sH74MnN0FBOT3qQzuYsBBN6
         o0ZsnVs4/FIfKAUxm+VHUNS8pRSKWQPtcW0ravVlwX1uXaOnFjqyix5pDUG3Ze4oqO1Q
         pVWQ8VFnOukFK1KtZZSBtPutN1f8ScsS15Fcm7s4GLqzTxDDG57/ff/9O9UQYNnfDuca
         u6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8KeFbgvsuOat/mpoc5ZOUBGSlCNJhl4QS1w+iEsFZwosKnzODa+Wptmnag0NcBT2BhBu6WCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGeGqpC1pC9tbQaCI7ZplG33+l/xSBw8I9gx21SGDK1zl4a5L
	8Ce7aAuCEFNuVg4cib369GXdiLOHGg6XM+6QtOPL3aelnr3onLH+oBixU1cclzzvAC/aRj9bWVi
	UeOJFGhUY5MVZ7/tc7CLdb6awp1npfL5YwQtc
X-Gm-Gg: ASbGncuuj/hTA0RbhJL9Wa420rkkjdgIUalvPzEX4OnXH0NLaWuU8jhZ0LZRZV398H1
	rhVtrh3kQ36zGmuLKQLMoIhm5YdAupObrRHNypEJGOTk/TZ+tlwkezK8pMIuYPOwyf4LP1pBOv9
	zzCHUnMQfNrLmu8RVmvXi0vw==
X-Google-Smtp-Source: AGHT+IHIEMpmUKAC/xvO5OtUrmHuT37PTMsbm4oPGG0wmb8ovN6ezybR0J0bE//ANPQtlPeEZncha1RKx21Km+NCx2o=
X-Received: by 2002:a05:6a00:2793:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-73e32fb347amr202005b3a.10.1745509217684; Thu, 24 Apr 2025
 08:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416102427.3219655-1-victor@mojatatu.com> <aAFVHqypw/snAOwu@pop-os.localdomain>
 <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com> <aAlSqk9UBMNu6JnJ@pop-os.localdomain>
 <aAl34pi75s8ItSme@pop-os.localdomain> <20250423172416.4ee6378d@kernel.org> <CAM0EoMki518j_geesnGwh2jk51Z5BGRGootTGQq3HcP79y2ygQ@mail.gmail.com>
In-Reply-To: <CAM0EoMki518j_geesnGwh2jk51Z5BGRGootTGQq3HcP79y2ygQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Apr 2025 11:40:06 -0400
X-Gm-Features: ATxdqUEf1Lw9TaszNK1kqhBvam3YRFO-WTtNT2ooGyIWtNvLCE39lY019xMpffU
Message-ID: <CAM0EoM=Yh8ynZUMqma02ktnajJWOEEr-+GLgCVZH=EohFu6itQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:22=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Apr 23, 2025 at 8:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 23 Apr 2025 16:29:38 -0700 Cong Wang wrote:
> > > > +   /*
> > > > +    * If doing duplication then re-insert at top of the
> > > > +    * qdisc tree, since parent queuer expects that only one
> > > > +    * skb will be queued.
> > > > +    */
> > > > +   if (skb2) {
> > > > +           struct Qdisc *rootq =3D qdisc_root_bh(sch);
> > > > +           u32 dupsave =3D q->duplicate; /* prevent duplicating a =
dup... */
> > > > +
> > > > +           q->duplicate =3D 0;
> > > > +           rootq->enqueue(skb2, rootq, to_free);
> > > > +           q->duplicate =3D dupsave;
> > > > +           skb2 =3D NULL;
> > > > +   }
> > > > +
> > > >  finish_segs:
> > > >     if (skb2)
> > > >             __qdisc_drop(skb2, to_free);
> > > >
> > >
> > > Just FYI: I tested this patch, netem duplication still worked, I didn=
't
> > > see any issue.
> >
> > Does it still work if you have another layer of qdiscs in the middle?
> > It works if say DRR is looking at the netem directly as its child when
> > it does:
> >
> >         first =3D cl->qdisc->q.qlen
> >
> > but there may be another layer, the cl->qdisc may be something that
> > hasn't incremented its qlen, and something that has netem as its child.
>
> Very strong feeling it wont work in that scenario. We can double check.

Verified the following breaks:

drr
  |
  |
class drr
  |
  |
drr
  |
  |
class drr
  |
  |
netem

It's probably a crazy config - but doesnt matter, the bounty types will use=
 it.

cheers,
jamal

> Regardless - even if it did - what Victor sent is still a fix. Seems
> DRR had that bug originally. And then in the true tradition of
> TheLinuxWay(tm) was cutnpasted into HFSC and then the others followed.
>
> cheers,
> jamal

