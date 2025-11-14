Return-Path: <netdev+bounces-238727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36971C5E573
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA574E4C1B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E923346BB;
	Fri, 14 Nov 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zl+PGfFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021E33469F
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138174; cv=none; b=AgZIvulW1DETeF1FYzKGhGKbIVmqukEGEf9/kUH8oZn5OllWIi2TFYfPdmXwXq80xh6xGsA+QLmRYOOlmMPjOnKrsufvAy7x6zsQs4TosXdT+rY47mhotAmy27/oUHGht2OKJluOJr9vI6S1E9b9bi6+VebW39XTSXIkzPjl8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138174; c=relaxed/simple;
	bh=RGbJi+ZA1os8kEnRAGGbf9KgxMkTfjKFnvPKt7W704U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOLrNCfI4Z6vdX5FdEyEo9zTtCzHNdBZzaIH5QvXz4d6C/HQtq2acMdgWaErncrCk4ya6dUdoWpoQ+T4eqVXC+rWnwva5XBti8LofQ1OHfD08Mt0/2Tr33oNW7QONVp4yMbnc5inKEBDQvPJB+6sMLWAM7a7Fo3ytViSoHbCU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zl+PGfFu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed9d230e6dso27390741cf.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763138172; x=1763742972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhrYQGrqErOmu2eSxrz3vpQ+id3iRmoXUgwXsWwcN3U=;
        b=Zl+PGfFuZVpQ9rL1104J85QP+306qIuGg6Iw872Z31wvknWS8l2h7fD6nlvGlKaOcI
         rsUULCHTlwuVs5FqborL95jePlDMXTFFUacK0JD6vmd+L59e46KZMuxp2mHbdwM6CTC3
         lcVxRAghrTc8WKLsGZUtCgVJkJ1ski741HRbSEMrRjfz1CIFfBeRyAM9Y7XT2+73Cde9
         qhLuANjm1DgkhhH0R1azQuxF7D1JZxVhLsuTYS0FHqILU7zUwr0HtDhCx8rt8B7OeWMm
         Px3I9Tt7ZzBR4ZZabzU+8ACkY5gbC9no/mlUKp1d07e+CHExbfY0FH/eCSn1x35rYWNG
         avOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138172; x=1763742972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhrYQGrqErOmu2eSxrz3vpQ+id3iRmoXUgwXsWwcN3U=;
        b=FGb/KQVjaAEDYN4OW0iKXT8mXYHAlo1GZFHQocJ+Lp0hESCS42mnIFZS4ced0GN563
         QYSW7FUxb0Zt1il3H31T7lVawfcdDz3oBytM/GGXFjOnjPDisfVTdaI5qfsUSb24lQNx
         ywQv854jeEV8USAbeIoMwyAU5Ft5qaQhjMPHgu/eb4QraeX8JSyQBMyIjoVSj8UDYnst
         a4zCYl247NLzYayhmEewboaAhvMsnXyoSwM/ASJGYzkd8u3jm4e0qLS2KX2uXm2TAnYj
         c4CrGmTfhhlmEvPlutvKav44kQ6VwLBNdDCVD/EbIqacl5kaFIVEhBliQlCMtkbbF9xW
         rREg==
X-Forwarded-Encrypted: i=1; AJvYcCWs1P1oxiXZAf0+Iakq1MnRNJObKVMpW5IHxOEKnUBq321PtyG/YxpIJjnsQCx9z/CiOg44Xsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+c9KImDVXxWSXIfPE9jJrHMPKmIEqCPryMXHsWcDOui7Z0lAY
	QMMW2XrgiEfIqZ45PtNGq1Z79OOiRA5pqLOgnAengs1TGDidobIo/gJ+dfWIWSRzXf0+rmsAWz0
	/asiOuMvcwS4Gxt0LX6AsNIWMiad2yA35NZa/U5kv
X-Gm-Gg: ASbGncvg00QMVlki2KbYWKfy3oTVMMX/CTlpdsqveOc9aHKqXh/+eGACDk7rIQPLm0H
	Dyul2eQTu5WqTvu4LcSejwyS02XNyGIje6EHHdpc42TErGBHqE/Mud78lP3K1uIKGgwaNl4B2WW
	XBxeIYXWhBR+giEghJ6PINkAVwl32b6r3WFOh1kYAMNB0v6/TtB3t8YM7aDvudVlGbR8DOmEdlo
	ccAyNGEQlqlTi5ceMQW39QpHFmmihJfxSXePFqXKf2ZiSo3uen6Kt3k7PfTO5JxTd8hQAnAPt2m
	834afiBgqQvpZoMI2OkEcAfoSZicaQ==
X-Google-Smtp-Source: AGHT+IE/Exe6pdIBIRvUegfpwvjrQX7bIgD3Ee6y0O0uJ4mNEFH7TIlU3D2kV2W/AugfYWld08Z466oefCiojJBa4T0=
X-Received: by 2002:a05:622a:44d:b0:4ec:f49c:af11 with SMTP id
 d75a77b69052e-4edf210c564mr59247831cf.46.1763138171113; Fri, 14 Nov 2025
 08:36:11 -0800 (PST)
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
 <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com> <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com>
In-Reply-To: <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 08:35:59 -0800
X-Gm-Features: AWmQ_bnbhWSccjr6fNLfvdZ5njhDTXPYWB5o-zKYJbwPZTJs7M5AoRcWe8eiOIs
Message-ID: <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Nov 13, 2025 at 1:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@moj=
atatu.com> wrote:
> > > > > >
> > > > > > [..]
> > > > > > Eric,
> > > > > >
> > > > > > So you are correct that requeues exist even before your changes=
 to
> > > > > > speed up the tx path - two machines one with 6.5 and another wi=
th 6.8
> > > > > > variant exhibit this phenoma with very low traffic... which got=
 me a
> > > > > > little curious.
> > > > > > My initial thought was perhaps it was related to mq/fqcodel com=
bo but
> > > > > > a short run shows requeues occur on a couple of other qdiscs (e=
x prio)
> > > > > > and mq children (e.g., pfifo), which rules out fq codel as a
> > > > > > contributor to the requeues.
> > > > > > Example, this NUC i am typing on right now, after changing the =
root qdisc:
> > > > > >
> > > > > > --
> > > > > > $ uname -r
> > > > > > 6.8.0-87-generic
> > > > > > $
> > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2=
 1 2 0
> > > > > > 0 1 1 1 1 1 1 1 1
> > > > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requ=
eues 1528)
> > > > > >  backlog 0b 0p requeues 1528
> > > > > > ---
> > > > > >
> > > > > > and 20-30  seconds later:
> > > > > > ---
> > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2=
 1 2 0
> > > > > > 0 1 1 1 1 1 1 1 1
> > > > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requ=
eues 1531)
> > > > > >  backlog 0b 0p requeues 1531
> > > > > > ----
> > > > > >
> > > > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > > > ---
> > > > > > $ ethtool -i eno1
> > > > > > driver: igc
> > > > > > version: 6.8.0-87-generic
> > > > > > firmware-version: 1085:8770
> > > > > > expansion-rom-version:
> > > > > > bus-info: 0000:02:00.0
> > > > > > supports-statistics: yes
> > > > > > supports-test: yes
> > > > > > supports-eeprom-access: yes
> > > > > > supports-register-dump: yes
> > > > > > supports-priv-flags: yes
> > > > > >
> > > > > > $ ethtool eno1
> > > > > > Settings for eno1:
> > > > > > Supported ports: [ TP ]
> > > > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > > > >                         100baseT/Half 100baseT/Full
> > > > > >                         1000baseT/Full
> > > > > >                         2500baseT/Full
> > > > > > Supported pause frame use: Symmetric
> > > > > > Supports auto-negotiation: Yes
> > > > > > Supported FEC modes: Not reported
> > > > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > > > >                         100baseT/Half 100baseT/Full
> > > > > >                         1000baseT/Full
> > > > > >                         2500baseT/Full
> > > > > > Advertised pause frame use: Symmetric
> > > > > > Advertised auto-negotiation: Yes
> > > > > > Advertised FEC modes: Not reported
> > > > > > Speed: 1000Mb/s
> > > > > > Duplex: Full
> > > > > > Auto-negotiation: on
> > > > > > Port: Twisted Pair
> > > > > > PHYAD: 0
> > > > > > Transceiver: internal
> > > > > > MDI-X: off (auto)
> > > > > > netlink error: Operation not permitted
> > > > > >         Current message level: 0x00000007 (7)
> > > > > >                                drv probe link
> > > > > > Link detected: yes
> > > > > > ----
> > > > > >
> > > > > > Requeues should only happen if the driver is overwhelmed on the=
 tx
> > > > > > side - i.e tx ring of choice has no more space. Back in the day=
, this
> > > > > > was not a very common event.
> > > > > > That can certainly be justified today with several explanations=
 if: a)
> > > > > > modern processors getting faster b) the tx code path has become=
 more
> > > > > > efficient (true from inspection and your results but those patc=
hes are
> > > > > > not on my small systems) c) (unlikely but) we are misaccounting=
 for
> > > > > > requeues (need to look at the code). d) the driver is too eager=
 to
> > > > > > return TX BUSY.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > requeues can happen because some drivers do not use skb->len for =
the
> > > > > BQL budget, but something bigger for GSO packets,
> > > > > because they want to account for the (N) headers.
> > > > >
> > > > > So the core networking stack could pull too many packets from the
> > > > > qdisc for one xmit_more batch,
> > > > > then ndo_start_xmit() at some point stops the queue before the en=
d of
> > > > > the batch, because BQL limit is hit sooner.
> > > > >
> > > > > I think drivers should not be overzealous, BQL is a best effort, =
we do
> > > > > not care of extra headers.
> > > > >
> > > > > drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealo=
us drivers ;)
> > > > >
> > > > > igc_tso() ...
> > > > >
> > > > > /* update gso size and bytecount with header size */
> > > > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > > > >
> > > >
> > > >
> > > > Ok, the 25G i40e driver we are going to run tests on seems to be
> > > > suffering from the same enthusiasm ;->
> > > > I guess the same codebase..
> > > > Very few drivers tho seem to be doing what you suggest. Of course i=
dpf
> > > > being one of those ;->
> > >
> > > Note that few requeues are ok.
> > >
> > > In my case, I had 5 millions requeues per second, and at that point
> > > you start noticing something is wrong ;)
> >
> > That's high ;-> For the nuc with igc, its <1%. Regardless, the
> > eagerness for TX BUSY implies reduced performance due to the early
> > bailout..
>
> Ok, we are going to do some testing RSN, however, my adhd wont let
> this requeue thing go ;->
>
> So on at least i40e when you start sending say >2Mpps (forwarding or
> tc mirred redirect ) - the TX BUSY is most certainly not because of
> the driver is enthusiastically bailing out. Rather, this is due to BQL
> - and specifically because netdev_tx_sent_queue() stops the queue;
> Subsequent packets from the stack will get the magic TX_BUSY label in
> sch_direct_xmit().
>
> Some context:
> For forwarding use case benchmarking, the typical idea is to use RSS
> and IRQ binding to a specific CPU then craft some traffic patterns on
> the sender so that the test machine has a very smooth distribution
> across the different CPUs i.e goal is to have almost perfect load
> balancing.
>
> Q: In that case, would the defer list ever accumulate more than one
> packet? Gut feeling says no.

It can accumulate  way more, when there is a mix of very small packets
and big TSO ones.

IIf you had a lot of large TSO packets being sent, the queue bql/limit
can reach 600,000 easily.
TX completion happens, queue is empty, but latched limit is 600,000
based on the last tx-completion round.

Then you have small packets of 64 bytes being sent very fast (say from pktg=
en)

600,000 / 64 =3D 9375

But most TX queues have a limit of 1024 or 2048 skbs... so they will
stop the queue _before_ BQL does.


> Would have been nice to have an optional histogram to see the distributio=
n..

bpftrace is a nice way for building histograms.

>
> cheers,
> jamal

