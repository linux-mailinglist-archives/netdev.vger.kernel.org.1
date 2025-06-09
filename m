Return-Path: <netdev+bounces-195684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06322AD1DCF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A42D163DF3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620E253F1B;
	Mon,  9 Jun 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="V/6z0VEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAF1E98FB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472064; cv=none; b=Ro7vf8EJsRPGFXnXCwv7rL8Y73xNmR7gB6hzSOYjdZHVFNHmG946sA+YzqLcAgb3kuh+mIL0gOzwC2grtt+J4xpzJF2wsqnuV+hp6zrfnCXdO2yqqPfK32KZkl19Zb4xl+oKP4s3bSntF9ZwVDW1tj2kyCePycQeoEsI9Pkriqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472064; c=relaxed/simple;
	bh=M5o+EwLrOFhdYIlCLSTse/WcnoXWX9ckLORJVunt7JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa/ul9foaL7STktkiNuAlMC1wXYQgKREOJPDS+NcEp6EwG4eICr8MMumPBi698hXsmJ0ARg+5/Ugs/b/YFY9CqYExi1HQcuKhx+l1Sx8XHtBCwkLFD73L7duc+TLhnWgIyFxHFN1njVmdh0ramcJRSzt6rTZVdqUoEpSG9gvurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=V/6z0VEs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3573101b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1749472061; x=1750076861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5o+EwLrOFhdYIlCLSTse/WcnoXWX9ckLORJVunt7JA=;
        b=V/6z0VEsDsjNpiJ9l6cYGcJsKyI3OtvYEP+OQAvoeRJRQsLDeqdmaPmxALJe3e60VR
         npT0ePQlw2DhSxGzcGpZ3r8UEXIQXUmYYMCX+f9+I0zA61Z0ojdM73qxhMXaNejN3npO
         Oimz9AjBpOg8+hUrud5G4OYA3r9il6AuP2Fat9MXlVhRTXK0yOelTbieGaThvf81j1C+
         m6v6Vqbgk+9CEjpx4KQXHBjmwRR1+HSzl4CWLafbhSwVyKEDhpl2kvmbtsDWdgpOL3fL
         pbL2/OI0fGtu1ghO4E+301w+J7NgRX14h+mk0xY4KiXSRmyWBqQd3mazZOsLIsGqfont
         GiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749472061; x=1750076861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5o+EwLrOFhdYIlCLSTse/WcnoXWX9ckLORJVunt7JA=;
        b=lNd5jTYOrjPdfszrEzjtHHFXBlazHJF2FQAfXidlV6G5l2O+2jYUkfLE5EpgI/3a0l
         ebbgR0fox/ZY3i32Vz3LyAJYmUhQUf7E9Ye4S9Ot+wkPkpewPvWqzn3E9H9oeDlcvN2R
         JG+OyJPD/EX7wCc+uIv+OcXymYUZg6E2pR6/C9F66Y7zD+skR83bZRZuSr9AFv8tNipM
         iCtRSASqBQRI9nE5XzZaGNN3zAiY/3HF/lHdT3ocTFf/aFBbU0HdmMBJqSkhdvhkvfZN
         7JfI6mwG4sr3VFdXwJc6lbyDmCK2veMLr6qKpk+qu5idvBF6mor3Jsh6hYd/t+y1tx6I
         82fg==
X-Forwarded-Encrypted: i=1; AJvYcCX1PPTGsL0+Qk9cSkfsWNZehvH6mZfdpZWhx0k7TwlXNJn1HXEtZ/RrvXKchpzClYUk+gnbUD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6z0ckMg08u5CIxgjbR2QluePkfpEaKl2p5PcH9LrKgCMYRFI
	WhFYtbYw4v5TqbGiHMvPkRHxmgbgVoMLEyQaKz6FE3MrRxi+mkZL4i2CLOAuNDomGBS3R1C7Gbi
	E13HD8hl3+lhO9LpaGW4Ir2bH+vizSuOtiXCpoU+a
X-Gm-Gg: ASbGncuyjTc+LvZTEjFLhN2h5VZAHXTCUu1Gfx2c+BpIrXzauq4/8y3CefYEM8COrQu
	TA9qkOOFNr75YwC6rFLDC//MsvTsirqkonlEGD/pd7baxheSrnlKzZyKwoFnbhcBTOf6ulYinTE
	fn9J1CMVxHjB5a+LIadOUdSNKahFLuwi4A/ViVKwPrw3Z1K64V00UC
X-Google-Smtp-Source: AGHT+IGC/jzPKi4nek7QkexWMOUKi5B4mChFreX7XJ/rIazr7KXV2XfAYzxXP7fo4mFpGCx2UXPCzbyR+DgZ42QLMhY=
X-Received: by 2002:a05:6a00:1255:b0:740:6fa3:d323 with SMTP id
 d2e1a72fcca58-74827e9c37fmr15660505b3a.11.1749472060724; Mon, 09 Jun 2025
 05:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
 <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
 <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
 <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com>
 <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com>
 <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
 <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
 <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com> <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
In-Reply-To: <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Jun 2025 08:27:29 -0400
X-Gm-Features: AX0GCFt_zpdzYfPlcHL_vucLYhKyakrRViMM8gKl8T2T-9-fRAQYy0H7v_jyCn4
Message-ID: <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:04=E2=80=AFPM William Liu <will@willsroot.io> wrot=
e:
>
>
>
>
>
>
> On Sunday, June 8th, 2025 at 12:39 PM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> >
> >
> > On Thu, Jun 5, 2025 at 11:20=E2=80=AFAM William Liu will@willsroot.io w=
rote:
> >
> > > On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim jhs@mojatatu.c=
om wrote:
> > >
> > > > On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> > > >
> > > > > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > > > >
> > > > > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfailure=
.io wrote:
> > > > > >
> > > > > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jhs@mo=
jatatu.com wrote:
> > > > > > >
> > > > > > > > Hi Will,
> > > > > > > >
> > > > > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@w=
illsroot.io wrote:
> > > > > > > >
> > > > > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jh=
s@mojatatu.com wrote:
> > > > > > > > >
> > > > > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu wi=
ll@willsroot.io wrote:
> > > > > > > > > >
> > > > > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi =
Salim jhs@mojatatu.com wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Hi,
> > > > > > > > > > > > Sorry for the latency..
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu=
 will@willsroot.io wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > I did some more testing with the percpu approach,=
 and we realized the following problem caused now by netem_dequeue.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Recall that we increment the percpu variable on n=
etem_enqueue entry and decrement it on exit. netem_dequeue calls enqueue on=
 the child qdisc - if this child qdisc is a netem qdisc with duplication en=
abled, it could duplicate a previously duplicated packet from the parent ba=
ck to the parent, causing the issue again. The percpu variable cannot prote=
ct against this case.
> > > > > > > > > > > >
> > > > > > > > > > > > I didnt follow why "percpu variable cannot protect =
against this case"
> > > > > > > > > > > > - the enqueue and dequeue would be running on the s=
ame cpu, no?
> > > > > > > > > > > > Also under what circumstances is the enqueue back t=
o the root going to
> > > > > > > > > > > > end up in calling dequeue? Did you test and hit thi=
s issue or its just
> > > > > > > > > > > > theory? Note: It doesnt matter what the source of t=
he skb is as long
> > > > > > > > > > > > as it hits the netem enqueue.
> > > > > > > > > > >
> > > > > > > > > > > Yes, I meant that just using the percpu variable in e=
nqueue will not protect against the case for when dequeue calls enqueue on =
the child. Because of the child netem with duplication enabled, packets alr=
eady involved in duplication will get sent back to the parent's tfifo queue=
, and then the current dequeue will remain stuck in the loop before hitting=
 an OOM - refer to the paragraph starting with "In netem_dequeue, the paren=
t netem qdisc's t_len" in the first email for additional clarification. We =
need to know whether a packet we dequeue has been involved in duplication -=
 if it has, we increment the percpu variable to inform the children netem q=
discs.
> > > > > > > > > > >
> > > > > > > > > > > Hopefully the following diagram can help elucidate th=
e problem:
> > > > > > > > > > >
> > > > > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > > > > >
> > > > > > > > > > > +----------------------+
> > > > > > > > > > > | Packet A |
> > > > > > > > > > > +----------------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > +-------------------------+
> > > > > > > > > > > | netem_enqueue |
> > > > > > > > > > > +-------------------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > > > > v prevents duplication of B
> > > > > > > > > > > +-------------+
> > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > | [A, B] |
> > > > > > > > > > > +-------------+
> > > > > > > > > > >
> > > > > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > > > > >
> > > > > > > > > > > +-------------+
> > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > | [A] |
> > > > > > > > > > > +-------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > > > > v does not know about previous dup involvement
> > > > > > > > > > > +----------------------------------------------------=
----+
> > > > > > > > > > > | Child qdisc duplicates B to root (original netem) a=
s C |
> > > > > > > > > > > +----------------------------------------------------=
----+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > >
> > > > > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > > > > >
> > > > > > > > > > > +-------------------------+
> > > > > > > > > > > | netem_enqueue (again) |
> > > > > > > > > > > +-------------------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > |
> > > > > > > > > > > v
> > > > > > > > > > > .....
> > > > > > > > > > >
> > > > > > > > > > > If you increment a percpu variable in enqueue prologu=
e and decrement in enqueue epilogue, you will notice that our original repr=
o will still trigger a loop because of the scenario I pointed out above - t=
his has been tested.
> > > > > > > > > > >
> > > > > > > > > > > From a current view of the codebase, netem is the onl=
y qdisc that calls enqueue on its child from its dequeue. The check we prop=
ose will only work if this invariant remains.
> > > > > > > > > > >
> > > > > > > > > > > > > However, there is a hack to address this. We can =
add a field in netem_skb_cb called duplicated to track if a packet is invol=
ved in duplicated (both the original and duplicated packet should have it m=
arked). Right before we call the child enqueue in netem_dequeue, we check f=
or the duplicated value. If it is true, we increment the percpu variable be=
fore and decrement it after the child enqueue call.
> > > > > > > > > > > >
> > > > > > > > > > > > is netem_skb_cb safe really for hierarchies? grep f=
or qdisc_skb_cb
> > > > > > > > > > > > net/sched/ to see what i mean
> > > > > > > > > > >
> > > > > > > > > > > We are not using it for cross qdisc hierarchy checkin=
g. We are only using it to inform a netem dequeue whether the packet has pa=
rtaken in duplication from its corresponding netem enqueue. That part seems=
 to be private data for the sk_buff residing in the current qdisc, so my un=
derstanding is that it's ok.
> > > > > > > > > > >
> > > > > > > > > > > > > This only works under the assumption that there a=
ren't other qdiscs that call enqueue on their child during dequeue, which s=
eems to be the case for now. And honestly, this is quite a fragile fix - th=
ere might be other edge cases that will cause problems later down the line.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Are you aware of other more elegant approaches we=
 can try for us to track this required cross-qdisc state? We suggested addi=
ng a single bit to the skb, but we also see the problem with adding a field=
 for a one-off use case to such a vital structure (but this would also comp=
letely stomp out this bug).
> > > > > > > > > > > >
> > > > > > > > > > > > It sounds like quite a complicated approach - i don=
t know what the
> > > > > > > > > > > > dequeue thing brings to the table; and if we really=
 have to dequeue to
> > > > > > > > > > >
> > > > > > > > > > > Did what I say above help clarify what the problem is=
? Feel free to let me know if you have more questions, this bug is quite a =
nasty one.
> > > > > > > > > >
> > > > > > > > > > The text helped a bit, but send a tc reproducer of the =
issue you
> > > > > > > > > > described to help me understand better how you end up i=
n the tfifo
> > > > > > > > > > which then calls the enqueu, etc, etc.
> > > > > > > > >
> > > > > > > > > The reproducer is the same as the original reproducer we =
reported:
> > > > > > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicat=
e 100%
> > > > > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit=
 1 duplicate 100% delay 1us reorder 100%
> > > > > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > > > > >
> > > > > > > > > We walked through the issue in the codepath in the first =
email of this thread at the paragraph starting with "The root cause for thi=
s is complex. Because of the way we setup the parent qdisc" - please let me=
 know if any additional clarification is needed for any part of it.
> > > > > > > >
> > > > > > > > Ok, so I tested both your approach and a slight modificatio=
n of the
> > > > > > > > variant I sent you. They both fix the issue. TBH, I still f=
ind your
> > > > > > > > approach complex. While i hate to do this to you, my prefer=
ence is
> > > > > > > > that you use the attached version - i dont need the credit,=
 so just
> > > > > > > > send it formally after testing.
> > > > > > > >
> > > > > > > > cheers,
> > > > > > > > jamal
> > > > > > >
> > > > > > > Hi Jamal,
> > > > > > >
> > > > > > > Thank you for your patch. Unfortunately, there is an issue th=
at Will and I
> > > > > > > also encountered when we submitted the first version of our p=
atch.
> > > > > > >
> > > > > > > With this check:
> > > > > > >
> > > > > > > if (unlikely(nest_level > 1)) {
> > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev =
%s\n",
> > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > // ...
> > > > > > > }
> > > > > > >
> > > > > > > when netem_enqueue is called, we have:
> > > > > > >
> > > > > > > netem_enqueue()
> > > > > > > // nest_level is incremented to 1
> > > > > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > > > > // skb2 =3D skb_clone()
> > > > > > > // rootq->enqueue(skb2, ...)
> > > > > > > netem_enqueue()
> > > > > > > // nest_level is incremented to 2
> > > > > > > // nest_level now is > 1
> > > > > > > // The duplicate is dropped
> > > > > > >
> > > > > > > Basically, with this approach, all duplicates are automatical=
ly dropped.
> > > > > > >
> > > > > > > If we modify the check by replacing 1 with 2:
> > > > > > >
> > > > > > > if (unlikely(nest_level > 2)) {
> > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev =
%s\n",
> > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > // ...
> > > > > > > }
> > > > > > >
> > > > > > > the infinite loop is triggered again (this has been tested an=
d also verified in GDB).
> > > > > > >
> > > > > > > This is why we proposed an alternative approach, but I unders=
tand it is more complex.
> > > > > > > Maybe we can try to work on that and make it more elegant.
> > > > > >
> > > > > > I am not sure.
> > > > > > It is a choice between complexity to "fix" something that is a =
bad
> > > > > > configuration, i.e one that should not be allowed to begin with=
, vs
> > > > > > not burdening the rest.
> > > > > > IOW, if you created a single loop(like the original report) the
> > > > > > duplicate packet will go through but subsequent ones will not).=
 If you
> > > > > > created a loop inside a loop(as you did here), does anyone real=
ly care
> > > > > > about the duplicate in each loop not making it through? It woul=
d be
> > > > > > fine to "fix it" so you get duplicates in each loop if there wa=
s
> > > > > > actually a legitimate use case. Remember one of the original ch=
oices
> > > > > > was to disallow the config ...
> > > > >
> > > > > Actually I think i misunderstood you. You are saying it breaks ev=
en
> > > > > the working case for duplication.
> > > > > Let me think about it..
> > > >
> > > > After some thought and experimentation - I believe the only way to =
fix
> > > > this so nobody comes back in the future with loops is to disallow t=
he
> > > > netem on top of netem setup. The cb approach can be circumvented by
> > > > zeroing the cb at the root.
> > > >
> > > > cheers,
> > > > jamal
> > >
> > > Doesn't the cb zeroing only happen upon reset, which should be fine?
> >
> >
> > The root qdisc can be coerced to set values that could be zero. IMO,
> > it is not fine for folks to come back in a few months and claim some
> > prize because they managed to create the loop after this goes in. I am
> > certainly not interested in dealing with that...
> > I wish we still had the 2 bit TTL in the skb, this would have been an
> > easy fix[1].
> >
>
> The loopy fun problem combined with this duplication issue maybe shows th=
e need for us to get some bits in the sk_buff reserved for this case - this=
 is a security issue, as container/unprivileged users can trigger DOS.
>
> Regarding the size of sk_buff, at least when I tried this approach, there=
 was no increase in struct size. The slab allocator architecture wouldn't c=
ause increased memory consumption even if an extra byte were to be used. A =
robust fix here can future proof this subsystem against packet looping bugs=
, so maybe this can be a consideration for later.
>

There are approaches which alleviate these issues but i would argue
the return on investment to remove those two bits has been extremely
poor return on investment in terms of human hours invested for working
around and fixing bugs. The "penny wise pound foolish" adage is a very
apropos. Decisions like that work if you assume free labor.
I dont think you will get far trying to restore those bits, so no
point in trying.

> > > I agree that the strategy you propose would be more durable. We would=
 have to prevent setups of the form:
> > >
> > > qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...
> > >
> > > Netem qdiscs can be identified through the netem_qdisc_ops pointer.
> > >
> > > We would also have to check this property on qdisc insertion and repl=
acement. I'm assuming the traversal can be done with the walk/leaf handlers=
.
> > >
> > > Are there other things we are missing?
> >
> >
> > Make it simple: Try to prevent the config of a new netem being added
> > when one already exists at any hierarchy i.e dont bother checking if
> > Can I assume you will work on this? Otherwise I or someone else can.
> >
>
> Yep, I will give this a try in the coming days and will let you know if I=
 encounter any difficulties.
>

I didnt finish my thought on that: I meant just dont allow a second
netem to be added to a specific tree if one already exists. Dont
bother checking for duplication.

cheers,
jamal

> >
> > [1] see "loopy fun" in https://lwn.net/Articles/719297/
>
> Best,
> Will

