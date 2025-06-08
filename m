Return-Path: <netdev+bounces-195555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F354AD1202
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8F188AABB
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC91F5402;
	Sun,  8 Jun 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vAHnOi1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABA1FBEBE
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749386373; cv=none; b=pdZnYcG9faPywz+JuRM4AfBaJ/CQQSI2FqeFB+Wv9pa7iD0exwT9phH+6kADZa8qRUrYX1MMn7JN9Bga9A+KRyACFuPrVdr3f9UO+fpyeIQA5BqtbUsq/DmBzcvlXVnuGHFm4eHFwzcDnUglOBje5H0rrMR1xSvPQjI9wtWxTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749386373; c=relaxed/simple;
	bh=T117vcysE8F13hkiPInRvWwmB6HvEGKwc/0l9ErQenA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRDDemsnEC07IYDOgDZ8rRUZ/FB0nCLYU6KkgL5+SR61DXsVv+WEkO7nR5TlMejKicfbzWY/BdcV7PNDiZDJbbK/ZBMY0c1TCNdzGUfnZO2dvqbirEWGDCXNXu5Wy6ZcSWpJyskB4K7wKCIVepqHc0M1eE3VVIDdTyDUUIf8jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vAHnOi1d; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2920207b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1749386371; x=1749991171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaCkGGMa1RBiTgUP3lbW/PJWiwxzTpJg8L2AgEQekhQ=;
        b=vAHnOi1d1+b4QnVwQhqKv1SPA66CnekljBE0myHh+3cfPJX9+ilS9BVtKpD7iWOfov
         7AhVTIJ65oVwYB3Ia+SnuRQRvzko1i7JTXpXW2I2Ba88S7UqorEtfdpKVowtXMrzOEIh
         90bxNzDeQpD0RQPzEIsS4mo/dy2eIC/JT6pXtv7KI27+XfLp7AAqB+sEZWQkgIa8jZc8
         4Jg87TdYUH35krInG8qwWgJRYo7vjiioTcdlFUO2VZuGHMwmGVOLLU2uGprOhgDuMM9P
         OBoOVvcGUREg1xaGWgLn3xRL8vRaZkIMCu0gknWWxEcIC1NB9mjyXVXQiRcGdM9a7mB3
         XVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749386371; x=1749991171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaCkGGMa1RBiTgUP3lbW/PJWiwxzTpJg8L2AgEQekhQ=;
        b=cIeaUhYK5C/FZgX76PclBIXwUikWm3O0AiutcQKrWxyJgRX4B/+1EF3IV2S4anWI8h
         H6SWTGsWbUN01YlON96NtK0PxJOicJ8UxRJbYWQmPvpBwKaOxFoiemc01XomWrdvI0IA
         Zlndg6A7+7h7/D6Px0086Li692A+xmYYnt8v5p4p8mJ8d0Vprm00Y2H4IJBhGRsNDToA
         rRyJrz84NpwYI4dbJQF2HQ2pXVlN4o8O0sTQ9j4F5ADDaKkyjEEWaB7+i54Ra247JEuB
         73gG4F+cYgEPGEBDa0nlxhDQucv3CVUiCrlVqxOY3Z2PtKC8IYFv05FbaPfg8SsFSche
         iXxw==
X-Forwarded-Encrypted: i=1; AJvYcCX9y3TuCZA0DZp8eJDU3PP9EOpor00tPXSW8gvPV7e3E9T65otRk2JBl0AzdNv0k9UD5nPdTcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDqs+GJX89Pp27TB80IeTTWsidXrZTMhgG4jVC0itnfbWWPDL
	NDl3v9gd4ENx2hJUb00QMIzwBRFtGDaL9TqpnMzOmPmJ2HAuIDqJP/CSAeeD6+q2uhTrM+1IR9R
	b3UCuLSnEuKPDEjUKL1FeTNxtV97AmUrhZzHU/duqkH8oyGG05hy5og==
X-Gm-Gg: ASbGncvGLlC01kTRoXNTsF2n0UOrcnZDPpNcsC6BbPk7n7M/sy+vNBetFH2eve6LAk1
	Y950LR76kROpXbgC/iI59hPK0AIlEGqOI2H1xxJapSXpIiS7g1bh9loA05O9lO+i1QB9HwETEqi
	VHAzpZ8GanJyDMeZNbF5aS7l/lMjrnrs5F2n60n7YFnA==
X-Google-Smtp-Source: AGHT+IFBYIJzmGZKautT9x2stGwLw9nZ8ZVeLLCry20dXCIOGAG707Mh8xObfuiTpMWFq0Fm5Vmaqg0WqZy7jEsdynM=
X-Received: by 2002:a05:6a00:3d0f:b0:740:aa31:fe66 with SMTP id
 d2e1a72fcca58-74827e4e9bamr13492373b3a.4.1749386370733; Sun, 08 Jun 2025
 05:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
 <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
 <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
 <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
 <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
 <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
 <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
 <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com> <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
In-Reply-To: <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 8 Jun 2025 08:39:19 -0400
X-Gm-Features: AX0GCFvjitL9lNvL5QDnm3BiGlWAyCQTOConyLdK7F3AsjEhHrf_5yphKuVYeJg
Message-ID: <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:20=E2=80=AFAM William Liu <will@willsroot.io> wro=
te:
>
> On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> >
> >
> > On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.=
com wrote:
> >
> > > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs@mojatat=
u.com wrote:
> > >
> > > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfailure.io =
wrote:
> > > >
> > > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > > > >
> > > > > > Hi Will,
> > > > > >
> > > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@wills=
root.io wrote:
> > > > > >
> > > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@mo=
jatatu.com wrote:
> > > > > > >
> > > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@w=
illsroot.io wrote:
> > > > > > > >
> > > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Sali=
m jhs@mojatatu.com wrote:
> > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > > Sorry for the latency..
> > > > > > > > > >
> > > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu wil=
l@willsroot.io wrote:
> > > > > > > > > >
> > > > > > > > > > > I did some more testing with the percpu approach, and=
 we realized the following problem caused now by netem_dequeue.
> > > > > > > > > > >
> > > > > > > > > > > Recall that we increment the percpu variable on netem=
_enqueue entry and decrement it on exit. netem_dequeue calls enqueue on the=
 child qdisc - if this child qdisc is a netem qdisc with duplication enable=
d, it could duplicate a previously duplicated packet from the parent back t=
o the parent, causing the issue again. The percpu variable cannot protect a=
gainst this case.
> > > > > > > > > >
> > > > > > > > > > I didnt follow why "percpu variable cannot protect agai=
nst this case"
> > > > > > > > > > - the enqueue and dequeue would be running on the same =
cpu, no?
> > > > > > > > > > Also under what circumstances is the enqueue back to th=
e root going to
> > > > > > > > > > end up in calling dequeue? Did you test and hit this is=
sue or its just
> > > > > > > > > > theory? Note: It doesnt matter what the source of the s=
kb is as long
> > > > > > > > > > as it hits the netem enqueue.
> > > > > > > > >
> > > > > > > > > Yes, I meant that just using the percpu variable in enque=
ue will not protect against the case for when dequeue calls enqueue on the =
child. Because of the child netem with duplication enabled, packets already=
 involved in duplication will get sent back to the parent's tfifo queue, an=
d then the current dequeue will remain stuck in the loop before hitting an =
OOM - refer to the paragraph starting with "In netem_dequeue, the parent ne=
tem qdisc's t_len" in the first email for additional clarification. We need=
 to know whether a packet we dequeue has been involved in duplication - if =
it has, we increment the percpu variable to inform the children netem qdisc=
s.
> > > > > > > > >
> > > > > > > > > Hopefully the following diagram can help elucidate the pr=
oblem:
> > > > > > > > >
> > > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > > >
> > > > > > > > > +----------------------+
> > > > > > > > > | Packet A |
> > > > > > > > > +----------------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > +-------------------------+
> > > > > > > > > | netem_enqueue |
> > > > > > > > > +-------------------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > +-----------------------------------+
> > > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > > +-----------------------------------+
> > > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > > v prevents duplication of B
> > > > > > > > > +-------------+
> > > > > > > > > | tfifo queue |
> > > > > > > > > | [A, B] |
> > > > > > > > > +-------------+
> > > > > > > > >
> > > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > > >
> > > > > > > > > +-------------+
> > > > > > > > > | tfifo queue |
> > > > > > > > > | [A] |
> > > > > > > > > +-------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > +----------------------------------------+
> > > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > > +----------------------------------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > +--------------------------------------------+
> > > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > > +--------------------------------------------+
> > > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > > v does not know about previous dup involvement
> > > > > > > > > +--------------------------------------------------------=
+
> > > > > > > > > | Child qdisc duplicates B to root (original netem) as C =
|
> > > > > > > > > +--------------------------------------------------------=
+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > >
> > > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > > >
> > > > > > > > > +-------------------------+
> > > > > > > > > | netem_enqueue (again) |
> > > > > > > > > +-------------------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > +-------------------------------------+
> > > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > > +-------------------------------------+
> > > > > > > > > |
> > > > > > > > > v
> > > > > > > > > .....
> > > > > > > > >
> > > > > > > > > If you increment a percpu variable in enqueue prologue an=
d decrement in enqueue epilogue, you will notice that our original repro wi=
ll still trigger a loop because of the scenario I pointed out above - this =
has been tested.
> > > > > > > > >
> > > > > > > > > From a current view of the codebase, netem is the only qd=
isc that calls enqueue on its child from its dequeue. The check we propose =
will only work if this invariant remains.
> > > > > > > > >
> > > > > > > > > > > However, there is a hack to address this. We can add =
a field in netem_skb_cb called duplicated to track if a packet is involved =
in duplicated (both the original and duplicated packet should have it marke=
d). Right before we call the child enqueue in netem_dequeue, we check for t=
he duplicated value. If it is true, we increment the percpu variable before=
 and decrement it after the child enqueue call.
> > > > > > > > > >
> > > > > > > > > > is netem_skb_cb safe really for hierarchies? grep for q=
disc_skb_cb
> > > > > > > > > > net/sched/ to see what i mean
> > > > > > > > >
> > > > > > > > > We are not using it for cross qdisc hierarchy checking. W=
e are only using it to inform a netem dequeue whether the packet has partak=
en in duplication from its corresponding netem enqueue. That part seems to =
be private data for the sk_buff residing in the current qdisc, so my unders=
tanding is that it's ok.
> > > > > > > > >
> > > > > > > > > > > This only works under the assumption that there aren'=
t other qdiscs that call enqueue on their child during dequeue, which seems=
 to be the case for now. And honestly, this is quite a fragile fix - there =
might be other edge cases that will cause problems later down the line.
> > > > > > > > > > >
> > > > > > > > > > > Are you aware of other more elegant approaches we can=
 try for us to track this required cross-qdisc state? We suggested adding a=
 single bit to the skb, but we also see the problem with adding a field for=
 a one-off use case to such a vital structure (but this would also complete=
ly stomp out this bug).
> > > > > > > > > >
> > > > > > > > > > It sounds like quite a complicated approach - i dont kn=
ow what the
> > > > > > > > > > dequeue thing brings to the table; and if we really hav=
e to dequeue to
> > > > > > > > >
> > > > > > > > > Did what I say above help clarify what the problem is? Fe=
el free to let me know if you have more questions, this bug is quite a nast=
y one.
> > > > > > > >
> > > > > > > > The text helped a bit, but send a tc reproducer of the issu=
e you
> > > > > > > > described to help me understand better how you end up in th=
e tfifo
> > > > > > > > which then calls the enqueu, etc, etc.
> > > > > > >
> > > > > > > The reproducer is the same as the original reproducer we repo=
rted:
> > > > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 10=
0%
> > > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 d=
uplicate 100% delay 1us reorder 100%
> > > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > > >
> > > > > > > We walked through the issue in the codepath in the first emai=
l of this thread at the paragraph starting with "The root cause for this is=
 complex. Because of the way we setup the parent qdisc" - please let me kno=
w if any additional clarification is needed for any part of it.
> > > > > >
> > > > > > Ok, so I tested both your approach and a slight modification of=
 the
> > > > > > variant I sent you. They both fix the issue. TBH, I still find =
your
> > > > > > approach complex. While i hate to do this to you, my preference=
 is
> > > > > > that you use the attached version - i dont need the credit, so =
just
> > > > > > send it formally after testing.
> > > > > >
> > > > > > cheers,
> > > > > > jamal
> > > > >
> > > > > Hi Jamal,
> > > > >
> > > > > Thank you for your patch. Unfortunately, there is an issue that W=
ill and I
> > > > > also encountered when we submitted the first version of our patch=
.
> > > > >
> > > > > With this check:
> > > > >
> > > > > if (unlikely(nest_level > 1)) {
> > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s\n=
",
> > > > > nest_level, netdev_name(skb->dev));
> > > > > // ...
> > > > > }
> > > > >
> > > > > when netem_enqueue is called, we have:
> > > > >
> > > > > netem_enqueue()
> > > > > // nest_level is incremented to 1
> > > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > > // skb2 =3D skb_clone()
> > > > > // rootq->enqueue(skb2, ...)
> > > > > netem_enqueue()
> > > > > // nest_level is incremented to 2
> > > > > // nest_level now is > 1
> > > > > // The duplicate is dropped
> > > > >
> > > > > Basically, with this approach, all duplicates are automatically d=
ropped.
> > > > >
> > > > > If we modify the check by replacing 1 with 2:
> > > > >
> > > > > if (unlikely(nest_level > 2)) {
> > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s\n=
",
> > > > > nest_level, netdev_name(skb->dev));
> > > > > // ...
> > > > > }
> > > > >
> > > > > the infinite loop is triggered again (this has been tested and al=
so verified in GDB).
> > > > >
> > > > > This is why we proposed an alternative approach, but I understand=
 it is more complex.
> > > > > Maybe we can try to work on that and make it more elegant.
> > > >
> > > > I am not sure.
> > > > It is a choice between complexity to "fix" something that is a bad
> > > > configuration, i.e one that should not be allowed to begin with, vs
> > > > not burdening the rest.
> > > > IOW, if you created a single loop(like the original report) the
> > > > duplicate packet will go through but subsequent ones will not). If =
you
> > > > created a loop inside a loop(as you did here), does anyone really c=
are
> > > > about the duplicate in each loop not making it through? It would be
> > > > fine to "fix it" so you get duplicates in each loop if there was
> > > > actually a legitimate use case. Remember one of the original choice=
s
> > > > was to disallow the config ...
> > >
> > > Actually I think i misunderstood you. You are saying it breaks even
> > > the working case for duplication.
> > > Let me think about it..
> >
> >
> > After some thought and experimentation - I believe the only way to fix
> > this so nobody comes back in the future with loops is to disallow the
> > netem on top of netem setup. The cb approach can be circumvented by
> > zeroing the cb at the root.
> >
> > cheers,
> > jamal
>
> Doesn't the cb zeroing only happen upon reset, which should be fine?
>

The root qdisc can be coerced to set values that could be zero. IMO,
it is not fine for folks to come back in a few months and claim some
prize because they managed to create the loop after this goes in. I am
certainly not interested in dealing with that...
I wish we still had the 2 bit TTL in the skb, this would have been an
easy fix[1].

> I agree that the strategy you propose would be more durable.  We would ha=
ve to prevent setups of the form:
>
> qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...
>
> Netem qdiscs can be identified through the netem_qdisc_ops pointer.
>
> We would also have to check this property on qdisc insertion and replacem=
ent. I'm assuming the traversal can be done with the walk/leaf handlers.
>
> Are there other things we are missing?

Make it simple: Try to prevent the config of a new netem being added
when one already exists at any hierarchy i.e dont bother checking if
Can I assume you will work on this? Otherwise I or someone else can.

cheers,
jamal

[1] see "loopy fun" in https://lwn.net/Articles/719297/

