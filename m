Return-Path: <netdev+bounces-238726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7030C5E47A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848F33AA357
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72E326945;
	Fri, 14 Nov 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OoDegP7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03C2D5A0C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137722; cv=none; b=IVymaf1pokLLERL3PlrLNIU6yRSnhnNahOZiK8wj+tAU53sKlR9He9pzgmfWPmu1ixzZPARFS/uYAL4V1QYtyC+XZdncVjWGgSUNd9JGqTKv8Sw5Xfy0Bb554oMDtRqiJILedAbvh1q9qD5dAq04wjhE/RpRQyhLu0AEEGkeJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137722; c=relaxed/simple;
	bh=U40H9NO0WHOrs4jwom/Iq/J/V8h8k401hNI8eose6fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHJK1EbiV6BUbgPgFIexuExWQjsjnh7qMhAcMBVzy6bFgFx2NVSSpNyxokjxGH79iiPcmU8heSrFwGrhSfePqf8+Y/d/pcMr7k60WYtMUGJsO8bCKm5NUmgzg4TpkIeKEX8pj1jWR+0VEkzq1I1Fx1v8cEZtYJZLJeYfnzl886c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OoDegP7W; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so2603668b3a.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763137720; x=1763742520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3iKIilovzcTaCwo2KhKij6DjG6ReKtj+0Hewpk1hu8=;
        b=OoDegP7WyKZr/TuIhyTOQmVEeKe6qxCWHMIJvo8pf0lXoUEcJ04qcnEJrkt03seO7Y
         lZIPdG3dzFR5IcnYLxjFQ9UoNOcfW2xYT4aotTQqU6qRKI9kvTnAdy/AhlDCgNZsfiIT
         WzjTps4X8SBZ8ZG8jiO2cRhAv3SvgJ7gTup6XOUOFzrvNGrH4OJthxX9NfdbGLo49lbb
         q9dhREcz32SHY/li8H1LsHeWKjuzFPeQQ/K/vS2VBfxI/nWlxrHzNXMM8CQsAlcMavjL
         A5W5RowlpkT6XzufSMVqJi7s29krOgqka0B6OoNwFCHouDkIuXBp7Iu6LyhdGcr/80LV
         Wukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137720; x=1763742520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3iKIilovzcTaCwo2KhKij6DjG6ReKtj+0Hewpk1hu8=;
        b=TXhlSJZXbFcj4c1vt8y4Ubb/iCWvd+DLW2CRW1pp8UEbhcUGNWBT343XWM6Mwgp2x+
         Jk7SplyQxdqZZsYVXbZacuBkr1Ash84rtk+KLtbdkWIvZu1HLAiW7l5ICd4oQ+Be3WIy
         FNOWyFmwXMwMQqUOKdrePArawd+yQUlL7d4bh2xUDrKWJrvrCnLcr5HomexEcf5QUiqW
         qrYiNZgC1X8MHxpnmFPW2UrC/CxSwVUpMpjf9VrXkoFsoCbKl/Lj1X6/DINxZ2EGAoER
         8ep2dOP+lY7xuh9rxit2D2fws2SDzZYDGU4gh9Kg5rBGj1/f8lGhW3OZUS0ub5wqYJjg
         rt7w==
X-Forwarded-Encrypted: i=1; AJvYcCUcMtQq+0xnTdUwPm2tBPz1aQuWRfXGtw38FWET8dh+zzgqm6nu7YHEY/01PQdo81RTyt22jS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEbiT5H8SqMZnm/jJ3BqhL0F4A9pZezaZBEBWe1pdHjpwRz6r
	It8smVw+3WXTaIh6bO2zQNv/uTnRl2Jx0kf50D4M9Gv79cLSAYsVvSDnHdEWlaiVhNLg3/o9LCj
	0h2ct09qYO8QpyHGSD3P5j3czGXNyUCFNToCei4WA
X-Gm-Gg: ASbGncvZPE5vtiyHnhijeg7Y8lktKTY8713U517Nf1XTpyGEmgq4uY0EpGRchMaOcfr
	Tbp128+mIYMC80bI34pu3mOPQaapQnrM/xXhmIoCpElSOFCI13lMWEp6EaD1EVkW7zXSs7Qtfhl
	JqRZfwnewLtypKEMkNYKVe0m039xdA/6Og070OvuYp7RA5EsXLfdvjiDKL0Nht4i67PcUC3S6aP
	ZkWtQCk0IMamd2S+BvQMbQSGlNgC+GBDP1oDEe0yZGeiIF/nXa+ajBHnaUqDJF53tD7EI96RtIV
	WdU=
X-Google-Smtp-Source: AGHT+IHIVuBd/nIh4nfn9uO8L30diY2fJ/8nUm5DT+e0b+dTUFE9rviJ55IngWE/5NPaLPkMMKSCzvLAmfsgJ1uWUZw=
X-Received: by 2002:a05:6a21:e098:b0:354:d467:eaa9 with SMTP id
 adf61e73a8af0-35ba0289c66mr4557975637.26.1763137719903; Fri, 14 Nov 2025
 08:28:39 -0800 (PST)
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
 <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com> <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com>
In-Reply-To: <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 14 Nov 2025 11:28:28 -0500
X-Gm-Features: AWmQ_bnFaptN-u8S7O3Evp6wNR_tKLP1OpC9EMK4CWo0EiNv526ZACkWLkxahxI
Message-ID: <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > [..]
> > > > > Eric,
> > > > >
> > > > > So you are correct that requeues exist even before your changes t=
o
> > > > > speed up the tx path - two machines one with 6.5 and another with=
 6.8
> > > > > variant exhibit this phenoma with very low traffic... which got m=
e a
> > > > > little curious.
> > > > > My initial thought was perhaps it was related to mq/fqcodel combo=
 but
> > > > > a short run shows requeues occur on a couple of other qdiscs (ex =
prio)
> > > > > and mq children (e.g., pfifo), which rules out fq codel as a
> > > > > contributor to the requeues.
> > > > > Example, this NUC i am typing on right now, after changing the ro=
ot qdisc:
> > > > >
> > > > > --
> > > > > $ uname -r
> > > > > 6.8.0-87-generic
> > > > > $
> > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1=
 2 0
> > > > > 0 1 1 1 1 1 1 1 1
> > > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeu=
es 1528)
> > > > >  backlog 0b 0p requeues 1528
> > > > > ---
> > > > >
> > > > > and 20-30  seconds later:
> > > > > ---
> > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1=
 2 0
> > > > > 0 1 1 1 1 1 1 1 1
> > > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeu=
es 1531)
> > > > >  backlog 0b 0p requeues 1531
> > > > > ----
> > > > >
> > > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > > ---
> > > > > $ ethtool -i eno1
> > > > > driver: igc
> > > > > version: 6.8.0-87-generic
> > > > > firmware-version: 1085:8770
> > > > > expansion-rom-version:
> > > > > bus-info: 0000:02:00.0
> > > > > supports-statistics: yes
> > > > > supports-test: yes
> > > > > supports-eeprom-access: yes
> > > > > supports-register-dump: yes
> > > > > supports-priv-flags: yes
> > > > >
> > > > > $ ethtool eno1
> > > > > Settings for eno1:
> > > > > Supported ports: [ TP ]
> > > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > > >                         100baseT/Half 100baseT/Full
> > > > >                         1000baseT/Full
> > > > >                         2500baseT/Full
> > > > > Supported pause frame use: Symmetric
> > > > > Supports auto-negotiation: Yes
> > > > > Supported FEC modes: Not reported
> > > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > > >                         100baseT/Half 100baseT/Full
> > > > >                         1000baseT/Full
> > > > >                         2500baseT/Full
> > > > > Advertised pause frame use: Symmetric
> > > > > Advertised auto-negotiation: Yes
> > > > > Advertised FEC modes: Not reported
> > > > > Speed: 1000Mb/s
> > > > > Duplex: Full
> > > > > Auto-negotiation: on
> > > > > Port: Twisted Pair
> > > > > PHYAD: 0
> > > > > Transceiver: internal
> > > > > MDI-X: off (auto)
> > > > > netlink error: Operation not permitted
> > > > >         Current message level: 0x00000007 (7)
> > > > >                                drv probe link
> > > > > Link detected: yes
> > > > > ----
> > > > >
> > > > > Requeues should only happen if the driver is overwhelmed on the t=
x
> > > > > side - i.e tx ring of choice has no more space. Back in the day, =
this
> > > > > was not a very common event.
> > > > > That can certainly be justified today with several explanations i=
f: a)
> > > > > modern processors getting faster b) the tx code path has become m=
ore
> > > > > efficient (true from inspection and your results but those patche=
s are
> > > > > not on my small systems) c) (unlikely but) we are misaccounting f=
or
> > > > > requeues (need to look at the code). d) the driver is too eager t=
o
> > > > > return TX BUSY.
> > > > >
> > > > > Thoughts?
> > > >
> > > > requeues can happen because some drivers do not use skb->len for th=
e
> > > > BQL budget, but something bigger for GSO packets,
> > > > because they want to account for the (N) headers.
> > > >
> > > > So the core networking stack could pull too many packets from the
> > > > qdisc for one xmit_more batch,
> > > > then ndo_start_xmit() at some point stops the queue before the end =
of
> > > > the batch, because BQL limit is hit sooner.
> > > >
> > > > I think drivers should not be overzealous, BQL is a best effort, we=
 do
> > > > not care of extra headers.
> > > >
> > > > drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealous=
 drivers ;)
> > > >
> > > > igc_tso() ...
> > > >
> > > > /* update gso size and bytecount with header size */
> > > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > > >
> > >
> > >
> > > Ok, the 25G i40e driver we are going to run tests on seems to be
> > > suffering from the same enthusiasm ;->
> > > I guess the same codebase..
> > > Very few drivers tho seem to be doing what you suggest. Of course idp=
f
> > > being one of those ;->
> >
> > Note that few requeues are ok.
> >
> > In my case, I had 5 millions requeues per second, and at that point
> > you start noticing something is wrong ;)
>
> That's high ;-> For the nuc with igc, its <1%. Regardless, the
> eagerness for TX BUSY implies reduced performance due to the early
> bailout..

Ok, we are going to do some testing RSN, however, my adhd wont let
this requeue thing go ;->

So on at least i40e when you start sending say >2Mpps (forwarding or
tc mirred redirect ) - the TX BUSY is most certainly not because of
the driver is enthusiastically bailing out. Rather, this is due to BQL
- and specifically because netdev_tx_sent_queue() stops the queue;
Subsequent packets from the stack will get the magic TX_BUSY label in
sch_direct_xmit().

Some context:
For forwarding use case benchmarking, the typical idea is to use RSS
and IRQ binding to a specific CPU then craft some traffic patterns on
the sender so that the test machine has a very smooth distribution
across the different CPUs i.e goal is to have almost perfect load
balancing.

Q: In that case, would the defer list ever accumulate more than one
packet? Gut feeling says no.
Would have been nice to have an optional histogram to see the distribution.=
.

cheers,
jamal

