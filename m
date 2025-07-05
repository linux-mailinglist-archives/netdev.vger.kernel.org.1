Return-Path: <netdev+bounces-204303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C93AFA058
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033E23B16B0
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804785260;
	Sat,  5 Jul 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iHZDtszv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E54EED8
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723539; cv=none; b=siusjkoLeasTjb/Ac6U2jw8zJLyybc8wRtl+8BwcCEIS3yB2KRN4wOVMBattcWlMlOKxkjfPrPUxUnKwdzniNPQWvhyifWpUNtruoCx+Yog7gfBWGwT6tWyG/m346le6BX8uEOvG5x0T/jekRskYIkraS4H73YX7p31zZXc83pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723539; c=relaxed/simple;
	bh=0yS7NiSYyvtwe/dPMNJGB7loRucW8Mo0x/eBd35Wfwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFSo42wcvEPiUAcg3rSBEVO0gAGM0KTi35PFkuTcS6LEq0IFxTHf+Se7slKbJ8PctvyNCk/3OtDIx2h8/DENIhgVX+1lKUAjmGpOPUvAyvuelpZdhEd8pCrLCHzCOhTQodcJlK12/96iOxdXqGHkTr7OdFhYYXA57mHJiFyFNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=iHZDtszv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1017669b3a.1
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751723537; x=1752328337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buzJGcHMGpMkYqgrs+/JMHZ18rSLDK9dQ1B89+0x9IY=;
        b=iHZDtszvSG3VwoElVSvjFNGPcQb1kTpi0KNjfSIRGDVrEGxk7TBRlFvv8X5BkmNu4Q
         COONEGhxAWsbvN7ZqwM+oh2QO57MrrqqZbV9UpsK9N4OeT1+mzavAaWF0da/ATIRRr2x
         H3WdbH6uvp/yn6JUffzVa8Bk6FkGxwvccfVik+xGaKlPt++ayW29WJlNrfgZNSO1iDjq
         G/SEud7jamoU6VjywA72KZRdOyK7MagRAcBG2NVcrFjQ3j8wB90/jFxo9RmITjBYDz6w
         yPGVxaD4H7SqMRp6pOFmcPMvNwLRhXcTRiq3DwOKW1r74F1tido6Ij7RbtSv+lf8tagh
         9/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751723537; x=1752328337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buzJGcHMGpMkYqgrs+/JMHZ18rSLDK9dQ1B89+0x9IY=;
        b=Mz6r6PmkULObark+IKr3TusE392QtnF4TNwhyy02A1eaqOeCv0yr4Gk9MFKdSbe/RZ
         kqMzW/9nMHlnTVxb2hyj93ISOEVKZZcRV4P7qg+rUq78+l5s5PvYYTQjtHwf7XeI8ilI
         zZPZjsfw8IV1gW5u5QDX3KNBTmFBjwszSestpR1xSue2kDKRBIsZsZP7tNsy8PgwkaOA
         GhLwH9OBPbYsgLC+0RWaVS7IxClGe1FCY9+kpauaIRwvcFlq3hxDWx180mJ58poxQ0Xi
         zCXYgC1J02avmANFC8huadfa+6iFOL0o8O/9GrzZnS+pZSb4LuzjFyE8hM87H3bHy2Ha
         9oqw==
X-Gm-Message-State: AOJu0YwaTYKRRLOpdCOR6HR8kUhKF8P/GFIGmM6Oze/sdNbCZmfRoOAz
	EJbN8ukW4Xp9EhNEFHN8jeKrWbBO4Ro7KnSNT8hlP+516lxxx7JLRt6N3OJh5HE4EKC7UquVEKS
	DH9InPKayeW5Xq2/a7j2TNsZxvmiIZbxsZHYgXXDv
X-Gm-Gg: ASbGncu5g/ao8rmdzvwsgURC7x3ZFHFeTfYnN1xZz01nOhqcnyabIwzvwe7Wg1b+wTY
	Yc8wu6FN2aWFWWnLOTxitdn5OGC+xSz2ZPrsnf+m6+UZqHw50XD/j7Um12Ei/jq65O59XOXzmGL
	XKSnKPdpmqNuT296bMnge1jiqHGZfQtBrPU7AAx9lAKA==
X-Google-Smtp-Source: AGHT+IHJrhZcQANTNQYBPTEbPCRnaX6SLKTcrhydZVpvs6W1GX0RZq6oDLzjuIx3V79Msg7wrUVDLOQtuW+JqhpwkBE=
X-Received: by 2002:aa7:8893:0:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-74ce8841fc1mr6508181b3a.9.1751723537075; Sat, 05 Jul 2025
 06:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com> <aGh2TKCthenJ2xS2@pop-os.localdomain>
In-Reply-To: <aGh2TKCthenJ2xS2@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 5 Jul 2025 09:52:05 -0400
X-Gm-Features: Ac12FXwUNWALVLxhU3Q40ENrfQb7izZzfd7D7hbU835keSKYLsut2Rb5DbiWBvU
Message-ID: <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org, 
	Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 8:48=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> > On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang <xiyou.wangcong@gmai=
l.com> wrote:
> > > >
> > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > --- a/net/sched/sch_netem.c
> > > > > +++ b/net/sched/sch_netem.c
> > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
> > > > >       skb->prev =3D NULL;
> > > > >
> > > > >       /* Random duplication */
> > > > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_c=
or, &q->prng))
> > > > > +     if (tc_skb_cb(skb)->duplicate &&
> > > >
> > > > Oops, this is clearly should be !duplicate... It was lost during my
> > > > stupid copy-n-paste... Sorry for this mistake.
> > > >
> > >
> > > I understood you earlier, Cong. My view still stands:
> > > You are adding logic to a common data structure for a use case that
>
> You are exaggerating this. I only added 1 bit to the core data structure,
> the code logic remains in the netem, so it is contained within netem.

Try it out ;->
Here's an even simpler setup:

sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0
sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
netem_bug_test.o sec classifier/pass classid 1:1
sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
then:
ping -c 1 127.0.0.1

Note: there are other issues as well but i thought citing the ebpf one
was sufficient to get the point across.

>
> > > really makes no sense. The ROI is not good.
>
> Speaking of ROI, I think you need to look at the patch stats:
>
> William/Your patch:
>  1 file changed, 40 insertions(+)
>
> My patch:
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

ROI is not just about LOC. The consequences of a patch are also part
of that formula. And let's not forget the time spent so far debating
instead of plugging the hole.

>
> > > BTW: I am almost certain you will hit other issues when this goes out
> > > or when you actually start to test and then you will have to fix more
> > > spots.
> > >
> > Here's an example that breaks it:
> >
> > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> > 0 0 0 0 0 0 0 0 0 0 0
> > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > netem_bug_test.o sec classifier/pass classid 1:1
> > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate =
100%
> > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > duplicate 100% delay 1us reorder 100%
> >
> > And the ping 127.0.0.1 -c 1
> > I had to fix your patch for correctness (attached)
> >
> >
> > the ebpf prog is trivial - make it just return the classid or even zero=
.
>
> Interesting, are you sure this works before my patch?
>
> I don't intend to change any logic except closing the infinite loop. IOW,
> if it didn't work before, I don't expect to make it work with this patch,
> this patch merely fixes the infinite loop, which is sufficient as a bug f=
ix.
> Otherwise it would become a feature improvement. (Don't get me wrong, I
> think this feature should be improved rather than simply forbidden, it ju=
st
> belongs to a different patch.)

A quick solution is what William had. I asked him to use ext_cb not
because i think it is a better solution but just so we can move
forward.
Agree that for a longer term we need a more generic solution as discussed .=
..

cheers,
jamal

