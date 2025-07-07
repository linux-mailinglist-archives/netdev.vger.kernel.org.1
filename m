Return-Path: <netdev+bounces-204693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FDAFBC77
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A58420067
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD2214A6A;
	Mon,  7 Jul 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VPXZbHqx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03383C2FB
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919863; cv=none; b=IJioxLFmpQ9d7dLywyEHLmrFC71xBPXBWv9oedu6WdfN4MFOUnS8YfifxRRHP6wdnl//+5VoRcIyVlG7x9+DhRejiGCg14D9SNCta/7QzxUiQ+8JjzspeTUx95Zm6Vr9kgR/IdF17Mc36qE+3zxOdvhgLbvPTFhc+8IHPeLq97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919863; c=relaxed/simple;
	bh=F77skAchT1i+PxMLTnu9WvFezcvUT8bGfjMRaj2q/Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSY1eHb9XgJpwSjKCmd+GJoBeMHHoTa33AbF/X7qwOYWqji5QORVoCDqZEajLKsg0QovfRTFjGiQfgU5tuDWOa73+45JYak5P+GjwPVDvf236NrVphGGX4Udatt+Omya04SstkXa414gNZKT7HfRZW75RU3+a4WaovKtwrpasYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VPXZbHqx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7494999de5cso2192038b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751919860; x=1752524660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfAUwP4ZKIo5FWG5T7HONZrUJ5KhtQHC6OHNSlNqYVs=;
        b=VPXZbHqxfwukD7pmgx02Teogi9pmKGX9Q34ciu0zF405DIK2z4dRwuTnvRQQWcF2qn
         WfVscGbDavV/BXi0BsOug2T8uNAdFyycycCk8eVEtgVBvDrqa6bIR3/Hp+UsQtnlUgvk
         wOS3g4rk2x6UKWxL4fntufq0D0Yq8qYC+Q0DgddeXzQyAA1Mny1B36VyMMkXztcPdyR9
         uirNSR9MLhV5IXDAaXj7R16A9dWNVh4qS1fBmzF7cGY4j+/GdorNH0XJ3kFAnrgnyInf
         1bMZjj//aoilRIkSKFY8iUfpAYeoE9Hh6G5/RSDx3tSm33wXfL/9HLnMHvhxDO+WpHA1
         k5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751919860; x=1752524660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfAUwP4ZKIo5FWG5T7HONZrUJ5KhtQHC6OHNSlNqYVs=;
        b=dnBFW2e0OUOWy6eN8tmsGC8MZqvFJuxJioOVRX+C8bPyOo4lbsQdXbjSRZBvD2+uQy
         P80kEjJXrJ9OsiOmCid2MvTo3w/zRMXbQ46SRrNFadLTWl/tK2gPTeSJCwgJBYRM6BBr
         TrD/wYt3xpId6pcls++3kK8DAds+sUddcOCsSmhbfdfr0IJDSHwHr7F9+vzMoWjlzGGR
         zNOlwY340jywTkqeCi26Y5/MDNDtBb/1eQONE4Oxhu2JhxtHD5clgKtzsOQ4uUY1mXVD
         9AH0MW28biWXxLOJpRZec4jtbpruUdKuTP6jCY0ehu+Ke8ejL/Dfr1pU5k9P87Wsi+mE
         6g3g==
X-Gm-Message-State: AOJu0YxP9uq6g3AS9ysp80ClBw3xMmJ6L7bYwFqzNVzJqicdsdc2y8Xe
	/xIPyvWlo7nHM7z7jwTXYWvyEDOKgWqK11GJdoncPR/IAWuDRXrRBfDUnda/2mcNTa2NqUmFLws
	sfvb7bnIrzTw/EUANd4wGd8PVswjZN8X6vwV4cuab
X-Gm-Gg: ASbGncvsaPrkXJIRsSMYb65Kf3YDwsj4PYOXOlDStqIDVbyy68lEh/TGlh8qtX/K5DB
	545KgUBlnkeg5YFuA+4DzOb4/0jIhlbKcckoV/MTS7kr33ktUyEhglFDK1Bm+33OBjSvQM4BnUb
	xfv7hqEz0NvE2+EniQpVb3T+BTxMj8nNMlUQhe5wC+VA==
X-Google-Smtp-Source: AGHT+IFr0RnW/GkjJeMIGDtUVVLvapIyZiXlBu/6nAKTDGEXgmLxJ29GNBRZsVwXGfdHow6mkk+MVJkbiZKMAF/nUW0=
X-Received: by 2002:a05:6a00:2450:b0:748:e1e4:71ec with SMTP id
 d2e1a72fcca58-74d249949fdmr592066b3a.12.1751919860126; Mon, 07 Jul 2025
 13:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
 <aGh2TKCthenJ2xS2@pop-os.localdomain> <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
 <aGwiuDju8TNvRdGe@pop-os.localdomain>
In-Reply-To: <aGwiuDju8TNvRdGe@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Jul 2025 16:24:09 -0400
X-Gm-Features: Ac12FXw7Ke4Xd1e8lr9G-WEVzk08gu6xlkc5sFBpqrOcIzEBgqUozgQxNp7bHlY
Message-ID: <CAM0EoMmj8en1kvonqJ6SsPVNtYqL6YhDFf6ogckahKMPXL7KxA@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org, 
	Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:40=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Sat, Jul 05, 2025 at 09:52:05AM -0400, Jamal Hadi Salim wrote:
> > On Fri, Jul 4, 2025 at 8:48=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.=
com> wrote:
> > >
> > > On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> > > > On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang <xiyou.wangcong@=
gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > > > --- a/net/sched/sch_netem.c
> > > > > > > +++ b/net/sched/sch_netem.c
> > > > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *=
skb, struct Qdisc *sch,
> > > > > > >       skb->prev =3D NULL;
> > > > > > >
> > > > > > >       /* Random duplication */
> > > > > > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->d=
up_cor, &q->prng))
> > > > > > > +     if (tc_skb_cb(skb)->duplicate &&
> > > > > >
> > > > > > Oops, this is clearly should be !duplicate... It was lost durin=
g my
> > > > > > stupid copy-n-paste... Sorry for this mistake.
> > > > > >
> > > > >
> > > > > I understood you earlier, Cong. My view still stands:
> > > > > You are adding logic to a common data structure for a use case th=
at
> > >
> > > You are exaggerating this. I only added 1 bit to the core data struct=
ure,
> > > the code logic remains in the netem, so it is contained within netem.
> >
> > Try it out ;->
> > Here's an even simpler setup:
> >
> > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> > 0 0 0 0 0 0 0 0 0 0 0
> > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > netem_bug_test.o sec classifier/pass classid 1:1
> > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate =
100%
> > then:
> > ping -c 1 127.0.0.1
>
> Of course (I replaced your ebpf filter with matchall):
>

Replacing ebpf with matchall is missing the core issue ;->
We cant just tell people "please dont create such a config using ebpf
classifier, use matchall instead"
Cong, just run the example and then look at the code.

> [root@localhost ~]# cat netem_from_jamal.sh
> tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0
> # tc filter add dev lo parent 1:0 protocol ip bpf obj netem_bug_test.o se=
c classifier/pass classid 1:1
> tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
> tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
>
> [root@localhost ~]# bash -x netem_from_jamal.sh
> + tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0
> + tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
> + tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
> [root@localhost ~]# ping -c 1 127.0.0.1
> PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
> 64 bytes from 127.0.0.1: icmp_seq=3D1 ttl=3D64 time=3D3.84 ms
>
> --- 127.0.0.1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev =3D 3.836/3.836/3.836/0.000 ms
>
> There is clearly no soft lockup. Hence the original issue has been succes=
sfully fixed.
>
> >
> > Note: there are other issues as well but i thought citing the ebpf one
> > was sufficient to get the point across.
>
> Please kindly define "issues" here. My definition for issue in this
> context is the soft lockup issue reported by William. Like I already
> explained, I have _no_ intention to solve any other issue than the one
> reported by William, simply because they probably can be deferred to
> -net-next.

But you cant just introduce new issues to solve an existing one. Take
a look: your cb values will be overwritten by ebpf.

cheers,
jamal

> > >
> > > > > really makes no sense. The ROI is not good.
> > >
> > > Speaking of ROI, I think you need to look at the patch stats:
> > >
> > > William/Your patch:
> > >  1 file changed, 40 insertions(+)
> > >
> > > My patch:
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> >
> > ROI is not just about LOC. The consequences of a patch are also part
> > of that formula. And let's not forget the time spent so far debating
> > instead of plugging the hole.
>
> LOC matters a lot for code review and maintainance.
>
> >
> > >
> > > > > BTW: I am almost certain you will hit other issues when this goes=
 out
> > > > > or when you actually start to test and then you will have to fix =
more
> > > > > spots.
> > > > >
> > > > Here's an example that breaks it:
> > > >
> > > > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 =
0 0
> > > > 0 0 0 0 0 0 0 0 0 0 0
> > > > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > > > netem_bug_test.o sec classifier/pass classid 1:1
> > > > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplic=
ate 100%
> > > > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > > > duplicate 100% delay 1us reorder 100%
> > > >
> > > > And the ping 127.0.0.1 -c 1
> > > > I had to fix your patch for correctness (attached)
> > > >
> > > >
> > > > the ebpf prog is trivial - make it just return the classid or even =
zero.
> > >
> > > Interesting, are you sure this works before my patch?
> > >
> > > I don't intend to change any logic except closing the infinite loop. =
IOW,
> > > if it didn't work before, I don't expect to make it work with this pa=
tch,
> > > this patch merely fixes the infinite loop, which is sufficient as a b=
ug fix.
> > > Otherwise it would become a feature improvement. (Don't get me wrong,=
 I
> > > think this feature should be improved rather than simply forbidden, i=
t just
> > > belongs to a different patch.)
> >
> > A quick solution is what William had. I asked him to use ext_cb not
> > because i think it is a better solution but just so we can move
> > forward.
>
> I already posted a patch, instead of just arguing. Now you are arguing
> about the patch I posted...
>
> Thanks.

