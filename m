Return-Path: <netdev+bounces-238746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D3C5EF76
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F4003498C2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3972DCBF7;
	Fri, 14 Nov 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SiJo4Lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696A1DED42
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146382; cv=none; b=Kjjoh+/pbIED4UROmsTngWiPMU0F3C4EDWMmLkV60OvZ39owEZOuGzHEb9rbE0pnsN7GXOVEyapLhAjneuHl+Sga9h6LL6FJ1Tt8XIMFX47FcoUrAizv5MTPvQ5Lh78bVTvBQ3or8wIdXUoA52CD8+5ypxWIAbPnVJ/qDUiqBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146382; c=relaxed/simple;
	bh=onzy9wOjPPiAKJrmtGX8khb4YtPJh/e6NrOnJy0+f1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbH5HVpmrY+J+zsiSF+mS9wX/vWMYN1rG9JxQmipvICZZXfbVx6TOQxjzsZD7D2ASZ2pgzt8W4MkMw9Ff29I3GNYgR+zRc57tIDBo1h8FLQzXbpTwluE9dRaI7LnrXMPff7PswV85Q51klwLDUl1bst5LABV737pts0mcO+inoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SiJo4Lk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-882360ca0e2so16471466d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763146375; x=1763751175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sn2weT5aFBYyXan/akl3tMAF5Le7xy3OXJNmSa0ThU=;
        b=2SiJo4LkEfj7U2P1wyZdVuYrUlG/tMzC/JPHCFphkmCQdsRPhErPnK1PheppMp8K+9
         3Gv24/x4VpJzcACukw7W02I4ClAN+xTfdUDDnM0bKQg+65ulpzA9xKf+7ac22JxiP5cf
         jAQHYhFRr3edGO840RSXwRv0y+pnVBambgWowcoWwXybYgfdU81At0tQJt/rP9HIGbjT
         Heq/jc4dNZXuATYrHLtV39J4753GpMM3co5s8NNP3pSxLMxcOlSG5e7BUwkLUHHTaJ2W
         OV82nj4ufYBDYPSu7dSwMjaVR+R4fS3jt0J/AG2MuFawDtesEpKr8WzfamllX+y9XT5R
         S/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146375; x=1763751175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sn2weT5aFBYyXan/akl3tMAF5Le7xy3OXJNmSa0ThU=;
        b=KGb0oeS8s9ZqxNVYTbF3k4KDS6rGe23mSFPuWxO+ppsdJPuL5e6m42ji2ZPzeEHiFk
         m0czawwhp0KxTnN/E/6cb/fCVu8bQ6iD8p6hlSbOabuN3U5wUm0zfsdvFWWvRxPsxOGM
         XmsRH+fGKWsqjaDI/jWQiSJJtBKSsXt99dOqXYD42j+n9XRQZAMGLl4Ne+LdUXmKMm1e
         StwGmXR4dJ9Zlo6isxwJcNiKCErPta7hCHA0/zwBmu/DV60PhTNFCSEm8YK24tKMhds6
         w9Mahc71z3MTm0NxngmN6tjHv05ZtHXztYKcnba/WFBToeRXvt6BrWPTSveS8oTWt5oG
         VygA==
X-Forwarded-Encrypted: i=1; AJvYcCWmAjbmBcg8nDAGzQZKGHRgsJNHRGdW+MQOLMrrxa0eTGt/riZHX3nf1DqNiz+nnLYzJUEpvSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAt3xGqcw/uPs0BkfZqseB+qsOJNLeMJMaYpAdAjt0jRnorXYe
	NZ3vaKs5xRNqq7z+39F2sdAeGL48D6cF9V/97dVzdZnfUWe+w617nEMjVs1IF2ccjI4+WE/tzth
	nQ+QzbZXONgGHM9x7vdxvLZqtqQkzjK3nHTUKM8qi
X-Gm-Gg: ASbGnctQkU6EcwdKpGn/nmC2eau9iMnG3nTZxXaStybxWjC69pMBR1ds6d1n7uQ/4oY
	ydPSLI02O/SASstWuQbDrK9uJdSQrmcYxZbYy265w0I0caL7RVsH4naZOY6CsfZTE2IcN1MWjpG
	lCVtFa25xyrNzbhAN2b1luAvGBq1XvQPt37FxLsTdc6BeqoeYNKEyYngXSiM9ds+nC1aL6MKq33
	M9kGZLSB4K3aRYmPNEREynDuI5shYR8NPZ9DdgZqAEgYhY3/QSDFrGQbwBOVPse1izTpJuuBhua
	fEre
X-Google-Smtp-Source: AGHT+IGdnzoTChFL856zV/T59E86KP6HZ2G5UGGcWsndFJSz33VsD81R16geJiAKNaof/UFQYWN5kW+F9INtFyAA+vU=
X-Received: by 2002:ad4:4ee8:0:b0:880:43e9:fe81 with SMTP id
 6a1803df08f44-882925ba18dmr67454186d6.14.1763146374979; Fri, 14 Nov 2025
 10:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
 <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
 <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
 <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com>
 <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com>
 <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com>
 <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com>
 <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com> <CAM0EoMkD1QTJjrtZH3w4vG0Q_MFVA2Daqs5nbuT6GAbT-2XUhQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkD1QTJjrtZH3w4vG0Q_MFVA2Daqs5nbuT6GAbT-2XUhQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 10:52:42 -0800
X-Gm-Features: AWmQ_blSzqUdBZvrE3MDuybg1x1sQELPOOd4Bz19eAELmBVKJEu4LduX6NPgHY0
Message-ID: <CANn89iKD725z-AAWjUxB4F5U1nM_3fB37mLx8nNojCHEHb9B6g@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:13=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Nov 14, 2025 at 11:36=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 1:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs=
@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > [..]
> > > > > > > > Eric,
> > > > > > > >
> > > > > > > > So you are correct that requeues exist even before your cha=
nges to
> > > > > > > > speed up the tx path - two machines one with 6.5 and anothe=
r with 6.8
> > > > > > > > variant exhibit this phenoma with very low traffic... which=
 got me a
> > > > > > > > little curious.
> > > > > > > > My initial thought was perhaps it was related to mq/fqcodel=
 combo but
> > > > > > > > a short run shows requeues occur on a couple of other qdisc=
s (ex prio)
> > > > > > > > and mq children (e.g., pfifo), which rules out fq codel as =
a
> > > > > > > > contributor to the requeues.
> > > > > > > > Example, this NUC i am typing on right now, after changing =
the root qdisc:
> > > > > > > >
> > > > > > > > --
> > > > > > > > $ uname -r
> > > > > > > > 6.8.0-87-generic
> > > > > > > > $
> > > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2=
 2 2 1 2 0
> > > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 =
requeues 1528)
> > > > > > > >  backlog 0b 0p requeues 1528
> > > > > > > > ---
> > > > > > > >
> > > > > > > > and 20-30  seconds later:
> > > > > > > > ---
> > > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2=
 2 2 1 2 0
> > > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 =
requeues 1531)
> > > > > > > >  backlog 0b 0p requeues 1531
> > > > > > > > ----
> > > > > > > >
> > > > > > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > > > > > ---
> > > > > > > > $ ethtool -i eno1
> > > > > > > > driver: igc
> > > > > > > > version: 6.8.0-87-generic
> > > > > > > > firmware-version: 1085:8770
> > > > > > > > expansion-rom-version:
> > > > > > > > bus-info: 0000:02:00.0
> > > > > > > > supports-statistics: yes
> > > > > > > > supports-test: yes
> > > > > > > > supports-eeprom-access: yes
> > > > > > > > supports-register-dump: yes
> > > > > > > > supports-priv-flags: yes
> > > > > > > >
> > > > > > > > $ ethtool eno1
> > > > > > > > Settings for eno1:
> > > > > > > > Supported ports: [ TP ]
> > > > > > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > > >                         1000baseT/Full
> > > > > > > >                         2500baseT/Full
> > > > > > > > Supported pause frame use: Symmetric
> > > > > > > > Supports auto-negotiation: Yes
> > > > > > > > Supported FEC modes: Not reported
> > > > > > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > > >                         1000baseT/Full
> > > > > > > >                         2500baseT/Full
> > > > > > > > Advertised pause frame use: Symmetric
> > > > > > > > Advertised auto-negotiation: Yes
> > > > > > > > Advertised FEC modes: Not reported
> > > > > > > > Speed: 1000Mb/s
> > > > > > > > Duplex: Full
> > > > > > > > Auto-negotiation: on
> > > > > > > > Port: Twisted Pair
> > > > > > > > PHYAD: 0
> > > > > > > > Transceiver: internal
> > > > > > > > MDI-X: off (auto)
> > > > > > > > netlink error: Operation not permitted
> > > > > > > >         Current message level: 0x00000007 (7)
> > > > > > > >                                drv probe link
> > > > > > > > Link detected: yes
> > > > > > > > ----
> > > > > > > >
> > > > > > > > Requeues should only happen if the driver is overwhelmed on=
 the tx
> > > > > > > > side - i.e tx ring of choice has no more space. Back in the=
 day, this
> > > > > > > > was not a very common event.
> > > > > > > > That can certainly be justified today with several explanat=
ions if: a)
> > > > > > > > modern processors getting faster b) the tx code path has be=
come more
> > > > > > > > efficient (true from inspection and your results but those =
patches are
> > > > > > > > not on my small systems) c) (unlikely but) we are misaccoun=
ting for
> > > > > > > > requeues (need to look at the code). d) the driver is too e=
ager to
> > > > > > > > return TX BUSY.
> > > > > > > >
> > > > > > > > Thoughts?
> > > > > > >
> > > > > > > requeues can happen because some drivers do not use skb->len =
for the
> > > > > > > BQL budget, but something bigger for GSO packets,
> > > > > > > because they want to account for the (N) headers.
> > > > > > >
> > > > > > > So the core networking stack could pull too many packets from=
 the
> > > > > > > qdisc for one xmit_more batch,
> > > > > > > then ndo_start_xmit() at some point stops the queue before th=
e end of
> > > > > > > the batch, because BQL limit is hit sooner.
> > > > > > >
> > > > > > > I think drivers should not be overzealous, BQL is a best effo=
rt, we do
> > > > > > > not care of extra headers.
> > > > > > >
> > > > > > > drivers/net/ethernet/intel/igc/igc_main.c is one of the overz=
ealous drivers ;)
> > > > > > >
> > > > > > > igc_tso() ...
> > > > > > >
> > > > > > > /* update gso size and bytecount with header size */
> > > > > > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > > > > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Ok, the 25G i40e driver we are going to run tests on seems to b=
e
> > > > > > suffering from the same enthusiasm ;->
> > > > > > I guess the same codebase..
> > > > > > Very few drivers tho seem to be doing what you suggest. Of cour=
se idpf
> > > > > > being one of those ;->
> > > > >
> > > > > Note that few requeues are ok.
> > > > >
> > > > > In my case, I had 5 millions requeues per second, and at that poi=
nt
> > > > > you start noticing something is wrong ;)
> > > >
> > > > That's high ;-> For the nuc with igc, its <1%. Regardless, the
> > > > eagerness for TX BUSY implies reduced performance due to the early
> > > > bailout..
> > >
> > > Ok, we are going to do some testing RSN, however, my adhd wont let
> > > this requeue thing go ;->
> > >
> > > So on at least i40e when you start sending say >2Mpps (forwarding or
> > > tc mirred redirect ) - the TX BUSY is most certainly not because of
> > > the driver is enthusiastically bailing out. Rather, this is due to BQ=
L
> > > - and specifically because netdev_tx_sent_queue() stops the queue;
> > > Subsequent packets from the stack will get the magic TX_BUSY label in
> > > sch_direct_xmit().
> > >
> > > Some context:
> > > For forwarding use case benchmarking, the typical idea is to use RSS
> > > and IRQ binding to a specific CPU then craft some traffic patterns on
> > > the sender so that the test machine has a very smooth distribution
> > > across the different CPUs i.e goal is to have almost perfect load
> > > balancing.
> > >
> > > Q: In that case, would the defer list ever accumulate more than one
> > > packet? Gut feeling says no.
> >
> > It can accumulate  way more, when there is a mix of very small packets
> > and big TSO ones.
> >
> > IIf you had a lot of large TSO packets being sent, the queue bql/limit
> > can reach 600,000 easily.
> > TX completion happens, queue is empty, but latched limit is 600,000
> > based on the last tx-completion round.
> >
> > Then you have small packets of 64 bytes being sent very fast (say from =
pktgen)
> >
> > 600,000 / 64 =3D 9375
> >
> > But most TX queues have a limit of 1024 or 2048 skbs... so they will
> > stop the queue _before_ BQL does.
> >
>
> Nice description, will check.
> Remember, our use case is a middle box which receives pkts on one
> netdev, does some processing, and sends to another. Essentially, we
> pull from rx ring of src netdev, process and send to tx ring of the
> other netdev. No batching or multiple CPUs funnelig to one txq and
> very little if any TSO or locally generated traffic - and of course
> benchmark is on 64B pkts.

One thing that many drivers get wrong is that they limit the number of
packets that a napi_poll()
can tx-complete at a time.

BQL was meant to adjust its limit based on the number of bytes per round,
and the fact that the queue has been stopped (because of BQL limit) in
the last round.

So really, a driver must dequeue as many packets as possible.

Otherwise you may have spikes, even if your load is almost constant,
when under stress.

In fact I am a bit lost on what your problem is...

