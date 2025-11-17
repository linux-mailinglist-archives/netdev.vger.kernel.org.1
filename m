Return-Path: <netdev+bounces-239252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4488C66441
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A28F35C13F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A5322A29;
	Mon, 17 Nov 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="t6giJ5Ge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E472D3237
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414494; cv=none; b=A3KzFpUNFnZpoEqeuk4drzUxFKFrIqVun2mjoPOW64m3ySaZAoCXLtv6b8lN13uV2zEzmxxsojaBwvX8RXe3NXqz4c0KcYshmoBay5d2SahkW3Mo0eW1DJpc/rhxcWd++2fSqCQk0znKhZw/vy7cMz1Nwg1GnekM4aGUp2yCUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414494; c=relaxed/simple;
	bh=FYaGwZEmtC/XpMZDljsOIBgE/U0kJlNbPcFwZxP1z0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgFtd8hEegVuFUxQgA8RfLoSMziXfRMdlz3uYwT1vmCNoP8jLJziUXWZEEigVCCxlfdAUkvnS4GwQTK6iG1n4JNwB2xRFudI9NzeCV/Fa6DQVLRYP5ieslD8vrvdjWIVm61ek01/WKN/GZ4IQV+cJaPGB9UR+1cSRguG2fpyZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=t6giJ5Ge; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437ea05540so4493453a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763414492; x=1764019292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2J8xbVL3KhSXmpiKGmph7hscHeFTDaYlZXtNZbovI=;
        b=t6giJ5GeKpQVPSXFgtJ3XonUqOlE6Fifhrjtnjf9j+3UbjCiI42xvAwQ71tiXCIG7t
         2IJsqCvkejj84jdlvY6ITGf9XC5Mf+LeWSjAlsRl41U1R4fCw5eeqMsRMjhk9VIh2RUf
         W459g+0oVwoDJeMQ3xuL6MjYu93huuDDIl4f5mwyT0tI1g2TMViZgAVxAjz7VA1A8QAB
         Z6KVp38ocDPGwXlg52gbWaZl2/NWTpTLK8sdx22gbBXFKjqOw8ixe8vDtO4yt+slbGQ2
         LSNu7U4jhjAO0Qk8uKKEXLFlyblBBHBCpbhPPTJfwIcI5RmCVF4PK2Rh7NpcLuIZHpkr
         8LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763414492; x=1764019292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NV2J8xbVL3KhSXmpiKGmph7hscHeFTDaYlZXtNZbovI=;
        b=Cybir2goVApqMEYfuhhK1+Km0j8gCPJXtqVB73LDlvNryGouEGTcWj4t67yHonbOyL
         dS+H4DE4Mg4BAboGORxVFIy/0Vy2aS0ODV6T2BO7sQGkBuhVMbFipwAVbbfRIge6NhvW
         D4nhqaG9vTCxDJ/31hTI6/dpkmO5UxSpUexoCcK2NsnRnkO1DGGvSEJot4Vams7pfBf4
         JuvxjwPrLEgb4+6xJjubbvAjyCa2MRpOPjWqhACDZaSDRBk/nuWWHUxKPAgCFUTh8BYh
         nL3MWzHq1cql6EOt2hiWDcEiTXRkdlRmvvtzz8dxUl/UXhlxVKAYikrZ6v2lwQQgHyMM
         N2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVN/2/zb2ZrBqYClCpcs6m90cAK1sDCit0/QE0iBuG/ObrBSga53hrf0NLU+qN9wSR3ADUAmXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWS3A9eLz9p8VAEkv/b4dnakbnQ5Sfi1aY7HrmdPjulmy5RAwv
	53MZslerqaM3GrjrR9zPgiN1fLBY5rGtJ7wdfnvWklFM5EXP8fwIfEgG3dKsppsTrMysssgXgxc
	4RRWyPZSmmewhBCeL2v9xOLRa59A4j9Hicpdu+kWC
X-Gm-Gg: ASbGnct0vDPTWb23wZzylqJx0OK3zNfsHikw8LXQFbbnN4+sGvZB8IseupZD6ELcVDw
	1hQiW3vulxgdm/EU5d3op/w/GWrAJ8UKKaZRylSg7ASRApL+JZDhzNZeOibXWPzGvAT6elJJtkn
	ywrGNFnwue/FPfVSxJiZPPUZT2aNFo4L5MkKvMF/a+YppXM1wq14yItmooBfAnD3MyCk2zDf8/C
	dTpdZBTjtSJjItCsua1le+87LPYrKftn/M8SIWqhizS4qrZY1wtXZzlBifHZkF6HeJZ0vZWXqoc
	hw4=
X-Google-Smtp-Source: AGHT+IFUfMaSyaowLULeNAnsLI2I8x9lh/KtvEqapayfV7WqjvUPcXjR3us2nieOcO5vWHxznXxtjF9itw+vHemjZAc=
X-Received: by 2002:a17:90b:2dc6:b0:343:eb40:8e01 with SMTP id
 98e67ed59e1d1-343fa63dc9cmr15298969a91.27.1763414492170; Mon, 17 Nov 2025
 13:21:32 -0800 (PST)
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
 <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com>
 <CAM0EoMkD1QTJjrtZH3w4vG0Q_MFVA2Daqs5nbuT6GAbT-2XUhQ@mail.gmail.com> <CANn89iKD725z-AAWjUxB4F5U1nM_3fB37mLx8nNojCHEHb9B6g@mail.gmail.com>
In-Reply-To: <CANn89iKD725z-AAWjUxB4F5U1nM_3fB37mLx8nNojCHEHb9B6g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 17 Nov 2025 16:21:21 -0500
X-Gm-Features: AWmQ_bnhhZ-avkmNQVM8-lQLg81XhEowdrxIF7rm1-Yi4ukHtR1B_G6yHMQ8Zk4
Message-ID: <CAM0EoMk6CWor=djYMCj4hV+cAA52TFb7yh7RNLMHTiQjEjwEOw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
Sorry - was distracted.

On Fri, Nov 14, 2025 at 1:52=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 14, 2025 at 9:13=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Fri, Nov 14, 2025 at 11:36=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 1:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumaze=
t@google.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <j=
hs@mojatatu.com> wrote:
> > > > > > > > >
> > > > > > > > > [..]
> > > > > > > > > Eric,
> > > > > > > > >
> > > > > > > > > So you are correct that requeues exist even before your c=
hanges to
> > > > > > > > > speed up the tx path - two machines one with 6.5 and anot=
her with 6.8
> > > > > > > > > variant exhibit this phenoma with very low traffic... whi=
ch got me a
> > > > > > > > > little curious.
> > > > > > > > > My initial thought was perhaps it was related to mq/fqcod=
el combo but
> > > > > > > > > a short run shows requeues occur on a couple of other qdi=
scs (ex prio)
> > > > > > > > > and mq children (e.g., pfifo), which rules out fq codel a=
s a
> > > > > > > > > contributor to the requeues.
> > > > > > > > > Example, this NUC i am typing on right now, after changin=
g the root qdisc:
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > $ uname -r
> > > > > > > > > 6.8.0-87-generic
> > > > > > > > > $
> > > > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1=
 2 2 2 1 2 0
> > > > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits =
0 requeues 1528)
> > > > > > > > >  backlog 0b 0p requeues 1528
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > and 20-30  seconds later:
> > > > > > > > > ---
> > > > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1=
 2 2 2 1 2 0
> > > > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits =
0 requeues 1531)
> > > > > > > > >  backlog 0b 0p requeues 1531
> > > > > > > > > ----
> > > > > > > > >
> > > > > > > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > > > > > > ---
> > > > > > > > > $ ethtool -i eno1
> > > > > > > > > driver: igc
> > > > > > > > > version: 6.8.0-87-generic
> > > > > > > > > firmware-version: 1085:8770
> > > > > > > > > expansion-rom-version:
> > > > > > > > > bus-info: 0000:02:00.0
> > > > > > > > > supports-statistics: yes
> > > > > > > > > supports-test: yes
> > > > > > > > > supports-eeprom-access: yes
> > > > > > > > > supports-register-dump: yes
> > > > > > > > > supports-priv-flags: yes
> > > > > > > > >
> > > > > > > > > $ ethtool eno1
> > > > > > > > > Settings for eno1:
> > > > > > > > > Supported ports: [ TP ]
> > > > > > > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > > > >                         1000baseT/Full
> > > > > > > > >                         2500baseT/Full
> > > > > > > > > Supported pause frame use: Symmetric
> > > > > > > > > Supports auto-negotiation: Yes
> > > > > > > > > Supported FEC modes: Not reported
> > > > > > > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > > > >                         1000baseT/Full
> > > > > > > > >                         2500baseT/Full
> > > > > > > > > Advertised pause frame use: Symmetric
> > > > > > > > > Advertised auto-negotiation: Yes
> > > > > > > > > Advertised FEC modes: Not reported
> > > > > > > > > Speed: 1000Mb/s
> > > > > > > > > Duplex: Full
> > > > > > > > > Auto-negotiation: on
> > > > > > > > > Port: Twisted Pair
> > > > > > > > > PHYAD: 0
> > > > > > > > > Transceiver: internal
> > > > > > > > > MDI-X: off (auto)
> > > > > > > > > netlink error: Operation not permitted
> > > > > > > > >         Current message level: 0x00000007 (7)
> > > > > > > > >                                drv probe link
> > > > > > > > > Link detected: yes
> > > > > > > > > ----
> > > > > > > > >
> > > > > > > > > Requeues should only happen if the driver is overwhelmed =
on the tx
> > > > > > > > > side - i.e tx ring of choice has no more space. Back in t=
he day, this
> > > > > > > > > was not a very common event.
> > > > > > > > > That can certainly be justified today with several explan=
ations if: a)
> > > > > > > > > modern processors getting faster b) the tx code path has =
become more
> > > > > > > > > efficient (true from inspection and your results but thos=
e patches are
> > > > > > > > > not on my small systems) c) (unlikely but) we are misacco=
unting for
> > > > > > > > > requeues (need to look at the code). d) the driver is too=
 eager to
> > > > > > > > > return TX BUSY.
> > > > > > > > >
> > > > > > > > > Thoughts?
> > > > > > > >
> > > > > > > > requeues can happen because some drivers do not use skb->le=
n for the
> > > > > > > > BQL budget, but something bigger for GSO packets,
> > > > > > > > because they want to account for the (N) headers.
> > > > > > > >
> > > > > > > > So the core networking stack could pull too many packets fr=
om the
> > > > > > > > qdisc for one xmit_more batch,
> > > > > > > > then ndo_start_xmit() at some point stops the queue before =
the end of
> > > > > > > > the batch, because BQL limit is hit sooner.
> > > > > > > >
> > > > > > > > I think drivers should not be overzealous, BQL is a best ef=
fort, we do
> > > > > > > > not care of extra headers.
> > > > > > > >
> > > > > > > > drivers/net/ethernet/intel/igc/igc_main.c is one of the ove=
rzealous drivers ;)
> > > > > > > >
> > > > > > > > igc_tso() ...
> > > > > > > >
> > > > > > > > /* update gso size and bytecount with header size */
> > > > > > > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > > > > > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Ok, the 25G i40e driver we are going to run tests on seems to=
 be
> > > > > > > suffering from the same enthusiasm ;->
> > > > > > > I guess the same codebase..
> > > > > > > Very few drivers tho seem to be doing what you suggest. Of co=
urse idpf
> > > > > > > being one of those ;->
> > > > > >
> > > > > > Note that few requeues are ok.
> > > > > >
> > > > > > In my case, I had 5 millions requeues per second, and at that p=
oint
> > > > > > you start noticing something is wrong ;)
> > > > >
> > > > > That's high ;-> For the nuc with igc, its <1%. Regardless, the
> > > > > eagerness for TX BUSY implies reduced performance due to the earl=
y
> > > > > bailout..
> > > >
> > > > Ok, we are going to do some testing RSN, however, my adhd wont let
> > > > this requeue thing go ;->
> > > >
> > > > So on at least i40e when you start sending say >2Mpps (forwarding o=
r
> > > > tc mirred redirect ) - the TX BUSY is most certainly not because of
> > > > the driver is enthusiastically bailing out. Rather, this is due to =
BQL
> > > > - and specifically because netdev_tx_sent_queue() stops the queue;
> > > > Subsequent packets from the stack will get the magic TX_BUSY label =
in
> > > > sch_direct_xmit().
> > > >
> > > > Some context:
> > > > For forwarding use case benchmarking, the typical idea is to use RS=
S
> > > > and IRQ binding to a specific CPU then craft some traffic patterns =
on
> > > > the sender so that the test machine has a very smooth distribution
> > > > across the different CPUs i.e goal is to have almost perfect load
> > > > balancing.
> > > >
> > > > Q: In that case, would the defer list ever accumulate more than one
> > > > packet? Gut feeling says no.
> > >
> > > It can accumulate  way more, when there is a mix of very small packet=
s
> > > and big TSO ones.
> > >
> > > IIf you had a lot of large TSO packets being sent, the queue bql/limi=
t
> > > can reach 600,000 easily.
> > > TX completion happens, queue is empty, but latched limit is 600,000
> > > based on the last tx-completion round.
> > >
> > > Then you have small packets of 64 bytes being sent very fast (say fro=
m pktgen)
> > >
> > > 600,000 / 64 =3D 9375
> > >
> > > But most TX queues have a limit of 1024 or 2048 skbs... so they will
> > > stop the queue _before_ BQL does.
> > >
> >
> > Nice description, will check.
> > Remember, our use case is a middle box which receives pkts on one
> > netdev, does some processing, and sends to another. Essentially, we
> > pull from rx ring of src netdev, process and send to tx ring of the
> > other netdev. No batching or multiple CPUs funnelig to one txq and
> > very little if any TSO or locally generated traffic - and of course
> > benchmark is on 64B pkts.
>
> One thing that many drivers get wrong is that they limit the number of
> packets that a napi_poll() can tx-complete at a time.
>

I suppose drivers these days do the replenishing at napi_poll() time -
but it could also be done in the tx path when a driver fails to get
space on tx ring. I think at one point another strategy was to turn on
thresholds for TX completion interrupts, and you get the trigger to
replenish - my gut feel is this last one probably was deemed bad for
performance.

> BQL was meant to adjust its limit based on the number of bytes per round,
> and the fact that the queue has been stopped (because of BQL limit) in
> the last round.
>

For our benchmarking i dont think BQL is adding much value - more below..

> So really, a driver must dequeue as many packets as possible.
>

IIUC, the i40e will replenish up to 256 descriptor which is > than the
default NAPI weight (64).
So should be fine there?
is 256 a good number for a weight of 64? I'm not sure how these
thresholds are chosen; Is it a factor of tx ring size (default of 512,
so 256 is 50%)  or is it based on napi weight? The max size i40e can
do is tx/rx is 8160, it defaults to 512/512.

It used to be that you knew your hardware and its limitations and your
strategy of when and where to replenish was based sometimes on
experimentation.
i40e_clean_tx_irq() is entered on every napi poll for example...

> Otherwise you may have spikes, even if your load is almost constant,
> when under stress.

I see.
So the trick is to use max tx size then then increase the weight for
every replenish? We can set the TX ring to be the max and increase the
replenish size to all..

> In fact I am a bit lost on what your problem is...

Well, it started with observation that there are many requeues ;-> And
in my initial thought was the tx side was not keeping up. And then it
turned out that it was bql that was causing the requeues.

A forwarding example:
--> rx ring x on eth0 --> tc mirred -->tx ring y on eth1 ("tc mirred"
could be replaced with forwarding/bridging)

As you can see the rx softirq will likely run from napi poll all the
way to completion on tx side. Our tests are for 16 flows which are
crafted to distribute nicely via RSS to hit 16 cpus on 16 rx rings
(one per cpu) then fprwarding to 16 tx rings. Each packet is 64B. That
way 16 CPUs are kept busy in parallel. If it all works out there
should be zero lock contention on the tx side..

If we turn off BQL, there should be _zero_ requeues, which in my
thinking should make things faster..
we'll compare with/out bql.

Motivation for all this was your work to add the defer list - i would
like to check if we have a regression for forwarding workloads.
In theory, for our benchmark, we should never be able to accumulate
more than one packet on that defer list (if ever), so all that extra
code is not going to be useful for us.
That is fine as long as the new additional lines of code we are
hitting dont affect us as much..

cheers,
jamal

