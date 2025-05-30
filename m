Return-Path: <netdev+bounces-194390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9BFAC92B8
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8739E4A3112
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103D212B2F;
	Fri, 30 May 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Jt/RN70v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFC194124
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620254; cv=none; b=bTvZIRdjjGVJEgMTRZlbDt5EypQLPH6u61wLY7kxb3TsHEuqGqqlYE8BttEjGTMNGoR+pA9aVlslIqnxTmLmJjmzCZ6T0zJnH2+IBSQ+30nENMVuMZP9hddnjOTzexF6iZrNMPhsMXeoUFm8B9+hiiiRd6RgcrlnXqHVhxWwdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620254; c=relaxed/simple;
	bh=YU4z2efJ0wE6szkzrrCDfJJbNn4d+2tn4AU9qzbuFsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrGxcSj+OlZOkn1uez+wOQJREmHsTHBZY7JNFDNNhk+Ow7ja+8wIOW9bQ+t/eJbB9h6Dc34ZKIqBLIcCbjgf/bGZpECejwVjKLIA3vhK54cP4KyYvM3/WAWnSy3qNlqlDZv5gu41eeC+TaZ5nXLJUTAZuYy2Kk0E3igbpUpei/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Jt/RN70v; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1627035a12.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748620251; x=1749225051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYTHvGWlRkF7tZKWn/YVBYkqE4caSBWokzlz16TUlhw=;
        b=Jt/RN70v4UfsAUHfP3J9Em6JCztwVy0htCDMn1ud2y8LoMPmbuExKCwZktYzYet8fQ
         jw+C9eOaOdSmMX/uRfRlGPJeknTv9ggjnp/tjmTyf7jNwlB335Mh0MmwxGf13yvNx6Kx
         Tmk6J4eaYE9ArvRzQ20jklReQg8yvTWmkAk5HOzrHY0IYwz1mb4VAylc6/hcACYC0PAt
         LJmyijVYqZ1397CY2a7rw6IWwn4bPFQZwy9o2g7jJbGCPcPt/+c2ScC+fhmlV9FDpABF
         U0p5hTVkGADIC8jlKEmUiclfHv1Xej3VZiFQ8HKfzGgYh0kcjc0WBr9+Z0DFODROPbpC
         65tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620251; x=1749225051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYTHvGWlRkF7tZKWn/YVBYkqE4caSBWokzlz16TUlhw=;
        b=L24QSQUeXQJ7vZKnygHL9juAqicOyFj11okAUsAQ3iXVabyVTkDf2IDVHo85o9sQt7
         DzhHOz7tC2ClDOED4CklMAvMaDpnsR+Ejkl7I8y/Rvdy8zZ1FPyZxUYit94s+K3uHq5q
         4Ss5TvSP2z4TSuwRVCEbO7iAIA9lDvTwFmwW750FQg/aNcqjwjCaQ+X6XQdx9sC/XsSX
         4GBCELWwYu0qi7dlYTRxlJ4cnibB/+tnzRYfqa3guETgZIfWv/C73OHsMcyjLdRKewhi
         DzD58164F+5Bs0EY6lkQfeDT1YF/sDJkXJWlvuUHceod0p+w6c5P7WXo6ifVTzF4D7hW
         cqWA==
X-Gm-Message-State: AOJu0Ywln+YBL6FNMy8UBOlSaoXS+jzDhC++HsAq8zpj9zoLjaQB5KCU
	h4IFW8f9NCou7/hRrdUBRd7KVWTTUMRGV4jnYGomf22vScsGKEDd7rgeLkTEpfgIeJkrhxSxgSQ
	E9jICZOQphQRB5vOikyWYB7D15WVwsov1VIXZntHR
X-Gm-Gg: ASbGncsh6Kzx025JHFi/V/nQBkwcQNoLgtH/7/8X1lEINo8ayAz1u/B3Eyz4suM8DFO
	JbQ73/nDT1oqiG+buaLkFiKoiPDWrfvx8etaX29fsJfSbJkrBVPcmCuap+DlrTqTY4Iaw5N1A3T
	SYHNTVkR83OhCCmQy+Qb89hqAZpVnFRPs=
X-Google-Smtp-Source: AGHT+IHfwraajcmli3GSUDzBjz4AWEFkgYQE/B5cnw6GCvBCZWetMlSvhUyonV2h89Grm7+tob356Eqc8q6IH4jbRmA=
X-Received: by 2002:a05:6a20:9c9b:b0:1f5:8c05:e8f8 with SMTP id
 adf61e73a8af0-21ad95bffbcmr6238117637.25.1748620251505; Fri, 30 May 2025
 08:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
 <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
 <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
 <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
 <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
 <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
 <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
 <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com> <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
In-Reply-To: <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 May 2025 11:50:40 -0400
X-Gm-Features: AX0GCFu379-l7yM6yKg--vpY0uLQL3337n4N-wKZHFD_9Y8Nb8w53tm2rUvUK-U
Message-ID: <CAM0EoM=wfobw0DQbOYx+QDmDEpQKT-WFjdiBkbquUNP1G2==9A@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
> On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> >
> >
> > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot.io =
wrote:
> >
> > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > >
> > > > Hi,
> > > > Sorry for the latency..
> > > >
> > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroot.=
io wrote:
> > > >
> > > > > I did some more testing with the percpu approach, and we realized=
 the following problem caused now by netem_dequeue.
> > > > >
> > > > > Recall that we increment the percpu variable on netem_enqueue ent=
ry and decrement it on exit. netem_dequeue calls enqueue on the child qdisc=
 - if this child qdisc is a netem qdisc with duplication enabled, it could =
duplicate a previously duplicated packet from the parent back to the parent=
, causing the issue again. The percpu variable cannot protect against this =
case.
> > > >
> > > > I didnt follow why "percpu variable cannot protect against this cas=
e"
> > > > - the enqueue and dequeue would be running on the same cpu, no?
> > > > Also under what circumstances is the enqueue back to the root going=
 to
> > > > end up in calling dequeue? Did you test and hit this issue or its j=
ust
> > > > theory? Note: It doesnt matter what the source of the skb is as lon=
g
> > > > as it hits the netem enqueue.
> > >
> > > Yes, I meant that just using the percpu variable in enqueue will not =
protect against the case for when dequeue calls enqueue on the child. Becau=
se of the child netem with duplication enabled, packets already involved in=
 duplication will get sent back to the parent's tfifo queue, and then the c=
urrent dequeue will remain stuck in the loop before hitting an OOM - refer =
to the paragraph starting with "In netem_dequeue, the parent netem qdisc's =
t_len" in the first email for additional clarification. We need to know whe=
ther a packet we dequeue has been involved in duplication - if it has, we i=
ncrement the percpu variable to inform the children netem qdiscs.
> > >
> > > Hopefully the following diagram can help elucidate the problem:
> > >
> > > Step 1: Initial enqueue of Packet A:
> > >
> > > +----------------------+
> > > | Packet A |
> > > +----------------------+
> > > |
> > > v
> > > +-------------------------+
> > > | netem_enqueue |
> > > +-------------------------+
> > > |
> > > v
> > > +-----------------------------------+
> > > | Duplication Logic (percpu OK): |
> > > | =3D> Packet A, Packet B (dup) |
> > > +-----------------------------------+
> > > | <- percpu variable for netem_enqueue
> > > v prevents duplication of B
> > > +-------------+
> > > | tfifo queue |
> > > | [A, B] |
> > > +-------------+
> > >
> > > Step 2: netem_dequeue processes Packet B (or A)
> > >
> > > +-------------+
> > > | tfifo queue |
> > > | [A] |
> > > +-------------+
> > > |
> > > v
> > > +----------------------------------------+
> > > | netem_dequeue pops B in tfifo_dequeue |
> > > +----------------------------------------+
> > > |
> > > v
> > > +--------------------------------------------+
> > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > +--------------------------------------------+
> > > | <- percpu variable in netem_enqueue prologue
> > > | and epilogue does not stop this dup,
> > > v does not know about previous dup involvement
> > > +--------------------------------------------------------+
> > > | Child qdisc duplicates B to root (original netem) as C |
> > > +--------------------------------------------------------+
> > > |
> > > v
> > >
> > > Step 3: Packet C enters original root netem again
> > >
> > > +-------------------------+
> > > | netem_enqueue (again) |
> > > +-------------------------+
> > > |
> > > v
> > > +-------------------------------------+
> > > | Duplication Logic (percpu OK again) |
> > > | =3D> Packet C, Packet D |
> > > +-------------------------------------+
> > > |
> > > v
> > > .....
> > >
> > > If you increment a percpu variable in enqueue prologue and decrement =
in enqueue epilogue, you will notice that our original repro will still tri=
gger a loop because of the scenario I pointed out above - this has been tes=
ted.
> > >
> > > From a current view of the codebase, netem is the only qdisc that cal=
ls enqueue on its child from its dequeue. The check we propose will only wo=
rk if this invariant remains.
> > >
> > > > > However, there is a hack to address this. We can add a field in n=
etem_skb_cb called duplicated to track if a packet is involved in duplicate=
d (both the original and duplicated packet should have it marked). Right be=
fore we call the child enqueue in netem_dequeue, we check for the duplicate=
d value. If it is true, we increment the percpu variable before and decreme=
nt it after the child enqueue call.
> > > >
> > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
> > > > net/sched/ to see what i mean
> > >
> > > We are not using it for cross qdisc hierarchy checking. We are only u=
sing it to inform a netem dequeue whether the packet has partaken in duplic=
ation from its corresponding netem enqueue. That part seems to be private d=
ata for the sk_buff residing in the current qdisc, so my understanding is t=
hat it's ok.
> > >
> > > > > This only works under the assumption that there aren't other qdis=
cs that call enqueue on their child during dequeue, which seems to be the c=
ase for now. And honestly, this is quite a fragile fix - there might be oth=
er edge cases that will cause problems later down the line.
> > > > >
> > > > > Are you aware of other more elegant approaches we can try for us =
to track this required cross-qdisc state? We suggested adding a single bit =
to the skb, but we also see the problem with adding a field for a one-off u=
se case to such a vital structure (but this would also completely stomp out=
 this bug).
> > > >
> > > > It sounds like quite a complicated approach - i dont know what the
> > > > dequeue thing brings to the table; and if we really have to dequeue=
 to
> > >
> > > Did what I say above help clarify what the problem is? Feel free to l=
et me know if you have more questions, this bug is quite a nasty one.
> >
> >
> > The text helped a bit, but send a tc reproducer of the issue you
> > described to help me understand better how you end up in the tfifo
> > which then calls the enqueu, etc, etc.
>
> The reproducer is the same as the original reproducer we reported:
> tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
> ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
>
> We walked through the issue in the codepath in the first email of this th=
read at the paragraph starting with "The root cause for this is complex. Be=
cause of the way we setup the parent qdisc" - please let me know if any add=
itional clarification is needed for any part of it.
>

Ok, thanks - I thought it was something different. I actually did run
that one but didnt notice the infinite requeueing you mention but
perhaps i wasnt paying attention to the stats closely.
Let me just run it again in about an hour -  it will provide me clarity.

cheers,
jamal

> Best,
> Will

