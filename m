Return-Path: <netdev+bounces-194400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B2AC93B3
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DC41C2117D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1FF7080C;
	Fri, 30 May 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n0+a853q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713B258A
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623030; cv=none; b=myrRHjHY+X3EX0AtCbwqQrkvt4EskIjzyHaSqOp/ckg48gYRRrqjGo2BEYJlH7HURKeJerjQGtzxokk1G5sD+8hKXXzT8JvvcmZbsn1jJHbvL81PLQ+Q54o4b5kfK+lHb/AM2baFz02ZbEgBJmpSQ2mKYxPUFNqk1UF7BnOG8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623030; c=relaxed/simple;
	bh=g7fkwLGMv+mzhppO+BHfSVjA5l2VvhsaNP50/Zxs2mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANVlW3KIgiizu72mvTcNBhpm8dskeKF5pavaUOI81QnLWaDtrF8SoQ1dn8uc3HioIEsnr4gGmEQgVxgD7WRFs1yFMTeQ+SroUa1g3RTEwcJNr/C24o8J0kQQJV/Bpr18medrOoMbDV7ILFFCa3a61igqcB/zqcFcbXcNQ4SlBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=n0+a853q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51596da56so1694203a12.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748623028; x=1749227828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRJcsm1AScvW7I5Z5uTYqr6HQx1FJeXQJB12M7RkdIc=;
        b=n0+a853qzwYELz8t3diJouRtaFywIJhXQsBHY/gVOy1BW0Y9iJkmKfKrd8LsyDuylO
         Ubplus+9GjLpX+q0PyhPunskP0GlKCPSUVceixPNv5LO6nuoM9OomHFaMtCfLGFxp02Y
         TxOJ7bg6QifXEssalPoswJqRG5/u9MAfnlnOPR2ARSi4Bs0Yn1tV2F+OzOcJHPDVUva4
         IEfukC9rnOYxEdr4xZ0s2mcL+AOD6t6Jj1pAUXDnTeCvoogt9epdoQDKd38tF9YW//Jh
         x7bIJc93ZXjttL/5SM1aXlz1s9ejCQqyLA14zUY5il1UNOcDHXXAPgroKeV1gebCbZSV
         y2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748623028; x=1749227828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRJcsm1AScvW7I5Z5uTYqr6HQx1FJeXQJB12M7RkdIc=;
        b=d8rlpj5o5zgnKNru4UEbfQqPWdvTemrjVXndCsAkojb97nkBDG6HA+25RYpoP4LMV5
         nMT20BxhtRiPM5uinxCaG68ta6wkaEWFlk/upxPuFQVGncYQcrO82JiXNmAdYaogLfaU
         dqh6qOosXpYQOPNs3dOERN6T8lqQm4YURNND861TSYSKePlK23D3P7VHpApVO8XlKUqu
         BSmu1MufjVb1cl3cnrya+Osza2DAnbCQe9G4IPMdbKHqT4byudxbzj/MDcy6gDZy1DQH
         u4kULbsem5hR01Rk6qc013b1zQkNFwQcRWKNJAjPaAm6WltjucvIxTElZS3glyb3pmw/
         Lp/Q==
X-Gm-Message-State: AOJu0YwkvyyNtZ8e1FlCPSiIzgtn2Gn/PERFv5d2MpasrlDOx5xIp76r
	slQ2oUxHBtibypuv9G16e7Fah0AVyYTQ10CXPaPo3n5TVPnhUdqcqJQcF5g/NCt2B6q8JA7a6fq
	TYpJaR5Uc6geQ5VqA+1Ci8qit9h8UTs1bz9fDlvSN
X-Gm-Gg: ASbGnctwac9NRQ5vsJy5NO+GuylDfNhNGbgLn5T/5jwh9BNGPokcW9fJUhFv3o+VdQc
	9lJPHjbsFESiYqnMikdz6vsTT/kZwVf0skrsesHJihDzGainmz2EO89rKg59MQHa3V5KY5G3aYd
	nYi9gyoW4ygzdlQANMFdjNLKgvQzW5yO4=
X-Google-Smtp-Source: AGHT+IGshS70tGTv8p/qrzUJDfqSYWtOSG7beL7J4ThTs08zZcaHpeERUmGBvrqVTqAkRK5PTc3ANA6BfaAsjdcImkg=
X-Received: by 2002:a05:6a21:6d86:b0:210:1c3a:6804 with SMTP id
 adf61e73a8af0-21ad9764680mr7766829637.31.1748623027720; Fri, 30 May 2025
 09:37:07 -0700 (PDT)
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
 <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
 <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
 <CAM0EoM=wfobw0DQbOYx+QDmDEpQKT-WFjdiBkbquUNP1G2==9A@mail.gmail.com>
In-Reply-To: <CAM0EoM=wfobw0DQbOYx+QDmDEpQKT-WFjdiBkbquUNP1G2==9A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 May 2025 12:36:56 -0400
X-Gm-Features: AX0GCFuDVBugH9MyJemzAgGUJ0s1jkoD9a4S7xPaIZGKfCdIqv_Y8eUpOQSttPE
Message-ID: <CAM0EoMnsPkXCh6xfT4Cvv4jFoO0LkCHGewt5O+EWh=WZAFTVWw@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 11:50=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu <will@willsroot.io> =
wrote:
> >
> > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > >
> > >
> > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot.i=
o wrote:
> > >
> > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@moja=
tatu.com wrote:
> > > >
> > > > > Hi,
> > > > > Sorry for the latency..
> > > > >
> > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroo=
t.io wrote:
> > > > >
> > > > > > I did some more testing with the percpu approach, and we realiz=
ed the following problem caused now by netem_dequeue.
> > > > > >
> > > > > > Recall that we increment the percpu variable on netem_enqueue e=
ntry and decrement it on exit. netem_dequeue calls enqueue on the child qdi=
sc - if this child qdisc is a netem qdisc with duplication enabled, it coul=
d duplicate a previously duplicated packet from the parent back to the pare=
nt, causing the issue again. The percpu variable cannot protect against thi=
s case.
> > > > >
> > > > > I didnt follow why "percpu variable cannot protect against this c=
ase"
> > > > > - the enqueue and dequeue would be running on the same cpu, no?
> > > > > Also under what circumstances is the enqueue back to the root goi=
ng to
> > > > > end up in calling dequeue? Did you test and hit this issue or its=
 just
> > > > > theory? Note: It doesnt matter what the source of the skb is as l=
ong
> > > > > as it hits the netem enqueue.
> > > >
> > > > Yes, I meant that just using the percpu variable in enqueue will no=
t protect against the case for when dequeue calls enqueue on the child. Bec=
ause of the child netem with duplication enabled, packets already involved =
in duplication will get sent back to the parent's tfifo queue, and then the=
 current dequeue will remain stuck in the loop before hitting an OOM - refe=
r to the paragraph starting with "In netem_dequeue, the parent netem qdisc'=
s t_len" in the first email for additional clarification. We need to know w=
hether a packet we dequeue has been involved in duplication - if it has, we=
 increment the percpu variable to inform the children netem qdiscs.
> > > >
> > > > Hopefully the following diagram can help elucidate the problem:
> > > >
> > > > Step 1: Initial enqueue of Packet A:
> > > >
> > > > +----------------------+
> > > > | Packet A |
> > > > +----------------------+
> > > > |
> > > > v
> > > > +-------------------------+
> > > > | netem_enqueue |
> > > > +-------------------------+
> > > > |
> > > > v
> > > > +-----------------------------------+
> > > > | Duplication Logic (percpu OK): |
> > > > | =3D> Packet A, Packet B (dup) |
> > > > +-----------------------------------+
> > > > | <- percpu variable for netem_enqueue
> > > > v prevents duplication of B
> > > > +-------------+
> > > > | tfifo queue |
> > > > | [A, B] |
> > > > +-------------+
> > > >
> > > > Step 2: netem_dequeue processes Packet B (or A)
> > > >
> > > > +-------------+
> > > > | tfifo queue |
> > > > | [A] |
> > > > +-------------+
> > > > |
> > > > v
> > > > +----------------------------------------+
> > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > +----------------------------------------+
> > > > |
> > > > v
> > > > +--------------------------------------------+
> > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > +--------------------------------------------+
> > > > | <- percpu variable in netem_enqueue prologue
> > > > | and epilogue does not stop this dup,
> > > > v does not know about previous dup involvement
> > > > +--------------------------------------------------------+
> > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > +--------------------------------------------------------+
> > > > |
> > > > v
> > > >
> > > > Step 3: Packet C enters original root netem again
> > > >
> > > > +-------------------------+
> > > > | netem_enqueue (again) |
> > > > +-------------------------+
> > > > |
> > > > v
> > > > +-------------------------------------+
> > > > | Duplication Logic (percpu OK again) |
> > > > | =3D> Packet C, Packet D |
> > > > +-------------------------------------+
> > > > |
> > > > v
> > > > .....
> > > >
> > > > If you increment a percpu variable in enqueue prologue and decremen=
t in enqueue epilogue, you will notice that our original repro will still t=
rigger a loop because of the scenario I pointed out above - this has been t=
ested.
> > > >
> > > > From a current view of the codebase, netem is the only qdisc that c=
alls enqueue on its child from its dequeue. The check we propose will only =
work if this invariant remains.
> > > >
> > > > > > However, there is a hack to address this. We can add a field in=
 netem_skb_cb called duplicated to track if a packet is involved in duplica=
ted (both the original and duplicated packet should have it marked). Right =
before we call the child enqueue in netem_dequeue, we check for the duplica=
ted value. If it is true, we increment the percpu variable before and decre=
ment it after the child enqueue call.
> > > > >
> > > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_c=
b
> > > > > net/sched/ to see what i mean
> > > >
> > > > We are not using it for cross qdisc hierarchy checking. We are only=
 using it to inform a netem dequeue whether the packet has partaken in dupl=
ication from its corresponding netem enqueue. That part seems to be private=
 data for the sk_buff residing in the current qdisc, so my understanding is=
 that it's ok.
> > > >
> > > > > > This only works under the assumption that there aren't other qd=
iscs that call enqueue on their child during dequeue, which seems to be the=
 case for now. And honestly, this is quite a fragile fix - there might be o=
ther edge cases that will cause problems later down the line.
> > > > > >
> > > > > > Are you aware of other more elegant approaches we can try for u=
s to track this required cross-qdisc state? We suggested adding a single bi=
t to the skb, but we also see the problem with adding a field for a one-off=
 use case to such a vital structure (but this would also completely stomp o=
ut this bug).
> > > > >
> > > > > It sounds like quite a complicated approach - i dont know what th=
e
> > > > > dequeue thing brings to the table; and if we really have to deque=
ue to
> > > >
> > > > Did what I say above help clarify what the problem is? Feel free to=
 let me know if you have more questions, this bug is quite a nasty one.
> > >
> > >
> > > The text helped a bit, but send a tc reproducer of the issue you
> > > described to help me understand better how you end up in the tfifo
> > > which then calls the enqueu, etc, etc.
> >
> > The reproducer is the same as the original reproducer we reported:
> > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 1=
00% delay 1us reorder 100%
> > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> >
> > We walked through the issue in the codepath in the first email of this =
thread at the paragraph starting with "The root cause for this is complex. =
Because of the way we setup the parent qdisc" - please let me know if any a=
dditional clarification is needed for any part of it.
> >
>
> Ok, thanks - I thought it was something different. I actually did run
> that one but didnt notice the infinite requeueing you mention but
> perhaps i wasnt paying attention to the stats closely.
> Let me just run it again in about an hour -  it will provide me clarity.

Sorry - a little distracted but will get to it before the end of the day.
Can you test if possible with something like:

|-+ netem as root duplicating
|--+ something like cake or fq
|----+ netem duplication here

cheers,
jamal

