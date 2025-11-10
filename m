Return-Path: <netdev+bounces-237296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B0C48850
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12ED43ABDBE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ADF329E4B;
	Mon, 10 Nov 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwFwW3mK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374A328B67
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798949; cv=none; b=ngDgZN22jo833QrHvSyDcvxsx+08YXEAVE+hwvvbUCBp2XJuG52/+8TRcwhCLH1/Gt0Q3KSLSeJ8XY66+yeP7XKv0aSpbT3hLGZ+taAaRRrTo6WQqAPCIpo45H7wgXG42ul/Lq5wFodchtOmYCorAZyqZrKfjXkf7grXzB58zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798949; c=relaxed/simple;
	bh=cXX8PjW530wRwF+5synP1AbgigS4D18X/ne6LiewzqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpHYc4rhVV84JD82Ooqaj7h6mwNvG5+kP1cs5aYhM38HRwZfGIxZVUhk/GU8WxJnjGlE1sx12me1u0+7W4vCoYzNGe4CZ9Pl6uO+19/wJyOj2E5hrqZpARTvYHdva0QJL43IE4m7FJW44hT2yRsjYtnq28vR+yLQGtGxEZ+FTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwFwW3mK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7869deffb47so32380687b3.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762798946; x=1763403746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqNldQfPbaUYsuFeasTuPiUdUm+aL1pk8qRBRhMkgiA=;
        b=DwFwW3mKcUgpYsecen+Sk1wJ2Sr3IheMobAkDRxKRvt10+Qjj6OmMuM0k2yEXuANlG
         i8DELUu96j0lDsck1tkqkLibdq9Ma/lIjqUjQqTcoclxJVvFvFjYZVQx8l9YxVaqJEuU
         4TkWYgxW2L5WA3xs34hMAOnHOTzh1DJME06NW8IMCoXWiCG4RBzn7U/nIXCpvR5nQyCR
         3bccGt3pMG/Qt0DYSHP7oJHQQA7wrWtYNEc5up2afScqRRfsCEid/WskweEbo26+h8tH
         aEZ6ZZ9JthEHD/4CCio2WGPMjSEtVYfxfRISQqscj8cPiTAiFVkWne/XC/uBxrWkwbLC
         gkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798946; x=1763403746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqNldQfPbaUYsuFeasTuPiUdUm+aL1pk8qRBRhMkgiA=;
        b=JL8TlejnEf0YP81ZdZzdvui6mjD+pnnnDTfDmQUh1H4uZWazLiOXsvx5LB7W9OfkLC
         bN4KVkTWpfozFT+JQ1aK1aQTrxASUkqDnN/e1Eo1WioJdowd3q3ozMetVWa1KDGYDFj3
         AiemI41Y3J7GTKw+x1e3C/hIkNxXvogVeAKjWy69H08+ysg1hbS1uKU1iPFlzQQaKSqv
         X7UWZA0K7qZOY+P/21v7hMyh2pLdL8zYdNq34pgUo+A/LmBJDlmPxJjocsXcVX5RNDUc
         iJxgk+tsY+qtVb1KSsT9xkFCfXv8Tfm4nF00rGIb0rdxC1rvnCvDxVy9otr//A7WwU5R
         YWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVEmbueM4BiRzFMrgVqAcEUcpNYdPeJ4CVL1/bZ4iPhnMKbBYMXvm+RWa+6/1yFBkhzX3to+iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IaYO55/2MiNiiNPEQgOrVW0JPP6b0kp85u1nvE2qbrBGBInD
	QUNa7ztkLNOx9YS+0uTlHS4wfmETDbAx8mLypvB7t5ZdAGMvwu0t8yle7RsdqNEQciQG3tGUQU0
	tDeFuLdDi9HohCkV+cNL6Ubj66ir5D/2GcI8/IW6W
X-Gm-Gg: ASbGncsUa3vpxzBT1nFWpNBIcWZBCocAUMq19wkzIyHEaS/vgic+0LEF+ioFkn1RSms
	El8Coiw2V+w4wJRAbO3FoB9/hL6NpHf8uj2I4pVBezZQylGAUABHbXH+w5hqtGtHasr42n1HADb
	MTaWLjBzDEqnBZU1O1ENfEI26hX6TMfRrzc8/J3bFCgFtzS1arEjIOR9dillwbaQZ4pKQmf+1TI
	jDR3qCe20+TrUo5ti9KeUcOjEhmedqaPrb2RJMc7Pcnmy7o60AS0RCAaaqg
X-Google-Smtp-Source: AGHT+IHanHTPI0DFqaKkSVaccEJTM0Iz6BHiXjQsj49toykUEj2YAgk109pHiJe+5nm7jf6ZF+kXIRBOE7j+SFnNXVI=
X-Received: by 2002:a05:690c:d96:b0:787:e9bc:f9ea with SMTP id
 00721157ae682-787e9bd0a20mr50465987b3.26.1762798945984; Mon, 10 Nov 2025
 10:22:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com> <20251110084432.7fdf647b@kernel.org>
 <CANn89i+KtA5C3rY2ump7qr=edvhvFw8fJ0HwRkiNHs=5+wwR3Q@mail.gmail.com>
 <20251110092736.5642f227@kernel.org> <CANn89i+szfpkVD8y-71RTHCmZn5KoHV5X33HzTCf-M1Xq8LJ3g@mail.gmail.com>
In-Reply-To: <CANn89i+szfpkVD8y-71RTHCmZn5KoHV5X33HzTCf-M1Xq8LJ3g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 10:22:14 -0800
X-Gm-Features: AWmQ_bkDZ0ZB1YOMoFdTm0xdm8TMCbQO8O8GlocslLgtkqcmj_Ug7KDo0juFSgw
Message-ID: <CANn89iKqXjxPdFf5PKDZO1HTXXmbsHFFTDWGV9vAJgLVBdn_ag@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:05=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 9:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 10 Nov 2025 09:15:46 -0800 Eric Dumazet wrote:
> > > On Mon, Nov 10, 2025 at 8:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, 10 Nov 2025 09:44:55 +0000 Eric Dumazet wrote:
> > > > > Avoid up to two cache line misses in qdisc dequeue() to fetch
> > > > > skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> > > > >
> > > > > Idea is to cache gso_segs at enqueue time before spinlock is
> > > > > acquired, in the first skb cache line, where we already
> > > > > have qdisc_skb_cb(skb)->pkt_len.
> > > > >
> > > > > This series gives a 8 % improvement in a TX intensive workload.
> > > > >
> > > > > (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)
> > > >
> > > > According to CI this breaks a bunch of tests.
> > > >
> > > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-1=
1-10--12-00
> > > >
> > > > I think they all hit:
> > > >
> > > > [   20.682474][  T231] WARNING: CPU: 3 PID: 231 at ./include/net/sc=
h_generic.h:843 __dev_xmit_skb+0x786/0x1550
> > >
> > > Oh well, I will add this in V2, thank you !
> > >
> > > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > > index b76436ec3f4aa412bac1be3371f5c7c6245cc362..79501499dafba56271b9e=
bd97a8f379ffdc83cac
> > > 100644
> > > --- a/include/net/sch_generic.h
> > > +++ b/include/net/sch_generic.h
> > > @@ -841,7 +841,7 @@ static inline unsigned int qdisc_pkt_segs(const
> > > struct sk_buff *skb)
> > >         u32 pkt_segs =3D qdisc_skb_cb(skb)->pkt_segs;
> > >
> > >         DEBUG_NET_WARN_ON_ONCE(pkt_segs !=3D
> > > -                              skb_is_gso(skb) ? skb_shinfo(skb)->gso=
_segs : 1);
> > > +                       (skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs =
: 1));
> > >         return pkt_segs;
> > >  }
> >
> > Hm, I think we need more..
> >
> > The non-debug workers are also failing and they have DEBUG_NET=3Dn
> >
> > Looks like most of the non-debug tests are tunnel and bridge related.
> > VxLAN, GRE etc.
> >
> > https://netdev.bots.linux.dev/contest.html?pass=3D0&branch=3Dnet-next-2=
025-11-10--12-00&executor=3Dvmksft-forwarding
>
> Nice !
>
> tc_run()
>    mini_qdisc_bstats_cpu_update()  //
>
> I am not sure this path was setting qdisc_pkt_len() either...

 pkt_len was set in sch_handle_ingress(), I will add in V2 :

diff --git a/net/core/dev.c b/net/core/dev.c
index ac994974e2a81889fcc0a2e664edcdb7cfd0496d..10042139dbb054b9a93dfb01947=
7a80263feb029
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4435,7 +4435,7 @@ sch_handle_ingress(struct sk_buff *skb, struct
packet_type **pt_prev, int *ret,
                *pt_prev =3D NULL;
        }

-       qdisc_skb_cb(skb)->pkt_len =3D skb->len;
+       qdisc_pkt_len_segs_init(skb);
        tcx_set_ingress(skb, true);

        if (static_branch_unlikely(&tcx_needed_key)) {

