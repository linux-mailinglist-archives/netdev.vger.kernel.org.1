Return-Path: <netdev+bounces-238732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A5C5E924
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59F9E4F7BF1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AA2C2353;
	Fri, 14 Nov 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wpSU9keq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E205333744
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140398; cv=none; b=qE2+KNgJ8u6By5jnLAqsirDRvNpYU/L/cJOYX0VucgKOSVC1Qy2nwnM9eGrjdqdF0BaBND7Ji8j5ikf2Z3UVDvyZu9E89q01HVCCRAdmszWWOmYcJ6onwOTZJtoFiUMEfV+4MIf4gb/gUjkPciPcLt0f0WSZHMA3+W8xf0VCTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140398; c=relaxed/simple;
	bh=PySvhftak1T3yp2H2b5aJdEwoUrdh/kGfeZEzvclZEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoXhD41l/F3O5uTEuUn1A6YenmDi2uni618ma+JA5oJDAlwJvScSYt2UHv0fnvIDEtAdX/lNHX/imwcRdtl0tG0+YHEHASkafqkgZk9yUc/opP8jZkF1C7K9s5xqnYBHSIOwwc+GaSsXU6GVnXHsLvntOs+jY/bm9TNPpRkj/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wpSU9keq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297f35be2ffso33061435ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763140395; x=1763745195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIdQyXDAqn1VfC/IYK7Ki2Wvndec4WNK/tPP4PNcQ8o=;
        b=wpSU9keqKQxWu+hV6LqnURLVEgc3xsJYqvrEz6w7argeYNP7rTjCeUayW7nWJE+NLQ
         +p4NuViSTctBFFGbo4DUHdu5ude6uOoOQttYo/tR6Qc0y9ia8bRj8uzxYmX1xHwXkxv1
         R1YNHLNrDNd/GLa6pkkeknZJpStAzBh0nPWNnzB4Ul5yJkc8Fg02Y0Z69qlwrtYraYd1
         BcstpDzohouYB6Z4T1iwbjtm8kN3dkCMZWfQgWuo9S3zb8+C89iTko2zDJX5yvB1RZuG
         z/IbZ3JL+vAYui8xwSCtMvI/ceFAJATvpaCwBrIdUZaYenTzMUyh7uh7FoWKANW47C0I
         dJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763140395; x=1763745195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIdQyXDAqn1VfC/IYK7Ki2Wvndec4WNK/tPP4PNcQ8o=;
        b=A8+7l3fEjkKj6B2NOzxPlJwXlCwzkErUYpNImcm4qUzXUmmshDWw3IUzaq3nb9GBRw
         8zaUzRi6QjTbHraf1Yk4ntESoDP7BPGU1A0TLMPaf0lkCrlMezuaxR3iodxiSLknPYa4
         jelg+bbr/SxWMiDKoIC8Yx7EtRxaeLZn3h9t/0TMbX/fonQ4lKZZqTMQ59XT3R7y0YQu
         OVQ/nzT9uyVWfRxvNAvvwj0ow1QK3BWrXUzAFsi/3OIPW8mSxwpYs+hPdDF4PvVG2vtQ
         y8ODHROyUov/Qkqd8uvJNeJ6HYjAbTxjaAcyFqwDYSNjW1PEt3VQwvLLwFjmqpBwxT8U
         QOhw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yestnWF4as4+3YN2xfNu+kHdex33d0qcTCV5yDZMW0ropmgzhM3sM5pi6E9ZYGjJl/fb3PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3PDO66LA3kbcL73yGWh0kLMlY58/Cf5OEmynMElb6bY1snAi
	vCvi+1jSeRIf0L3RmWkTudmj9iI4eQA1U0YdvI/0ZOtx0a4GvoU2LKQJJ2L0eWgUuqANpZG5q9u
	doPt8SyQjUceGMpxmMS4pTK5ktoe7bmN1Hwj5F5oM
X-Gm-Gg: ASbGncuKvfpl01YMV0axAWDA5lzoq7l+CU9SD+7wBYpJYjenoJyGchfE43iHkVWiFGC
	5qLo84WrKf6Tlq38UoERJjcwzeC5jochhFDFZxc5Mb5VMk0tq3vPZuPwc2zDh9yvlI/S9mpEgtw
	rCShyQlq5d4ongXf9ivy+3K2hNLc7WlUJgc8WO5eyC94ZI29OfaNtpDr51nElKgJii2+9AnYT2x
	49y41Rg1Xu0BWEh21fSxefM0ypvlUNJyi5mGD4pjrhZSWh1Af6kD21TB6cpbWFwp6AxXLjB4VC8
	diA=
X-Google-Smtp-Source: AGHT+IHyFlxGiTEqblgtGOmCYswRH5KR2sK4vYOpmVdYvn6btz3mosCpY2ghDiT7/69rHWjonw3DyPkpwt74SesaSnk=
X-Received: by 2002:a17:903:3bc7:b0:290:9a74:a8ad with SMTP id
 d9443c01a7336-2986a76f2b7mr41991555ad.53.1763140395415; Fri, 14 Nov 2025
 09:13:15 -0800 (PST)
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
 <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com> <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com>
In-Reply-To: <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 14 Nov 2025 12:13:04 -0500
X-Gm-Features: AWmQ_blSA4TamhFSzm-svvBdz_sUgaNfnuaEDoPPTAP23cbvD35Tq_GQ-ieEWvI
Message-ID: <CAM0EoMkD1QTJjrtZH3w4vG0Q_MFVA2Daqs5nbuT6GAbT-2XUhQ@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:36=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, Nov 13, 2025 at 1:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@m=
ojatatu.com> wrote:
> > > > > > >
> > > > > > > [..]
> > > > > > > Eric,
> > > > > > >
> > > > > > > So you are correct that requeues exist even before your chang=
es to
> > > > > > > speed up the tx path - two machines one with 6.5 and another =
with 6.8
> > > > > > > variant exhibit this phenoma with very low traffic... which g=
ot me a
> > > > > > > little curious.
> > > > > > > My initial thought was perhaps it was related to mq/fqcodel c=
ombo but
> > > > > > > a short run shows requeues occur on a couple of other qdiscs =
(ex prio)
> > > > > > > and mq children (e.g., pfifo), which rules out fq codel as a
> > > > > > > contributor to the requeues.
> > > > > > > Example, this NUC i am typing on right now, after changing th=
e root qdisc:
> > > > > > >
> > > > > > > --
> > > > > > > $ uname -r
> > > > > > > 6.8.0-87-generic
> > > > > > > $
> > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2=
 2 1 2 0
> > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 re=
queues 1528)
> > > > > > >  backlog 0b 0p requeues 1528
> > > > > > > ---
> > > > > > >
> > > > > > > and 20-30  seconds later:
> > > > > > > ---
> > > > > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2=
 2 1 2 0
> > > > > > > 0 1 1 1 1 1 1 1 1
> > > > > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 re=
queues 1531)
> > > > > > >  backlog 0b 0p requeues 1531
> > > > > > > ----
> > > > > > >
> > > > > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > > > > ---
> > > > > > > $ ethtool -i eno1
> > > > > > > driver: igc
> > > > > > > version: 6.8.0-87-generic
> > > > > > > firmware-version: 1085:8770
> > > > > > > expansion-rom-version:
> > > > > > > bus-info: 0000:02:00.0
> > > > > > > supports-statistics: yes
> > > > > > > supports-test: yes
> > > > > > > supports-eeprom-access: yes
> > > > > > > supports-register-dump: yes
> > > > > > > supports-priv-flags: yes
> > > > > > >
> > > > > > > $ ethtool eno1
> > > > > > > Settings for eno1:
> > > > > > > Supported ports: [ TP ]
> > > > > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > >                         1000baseT/Full
> > > > > > >                         2500baseT/Full
> > > > > > > Supported pause frame use: Symmetric
> > > > > > > Supports auto-negotiation: Yes
> > > > > > > Supported FEC modes: Not reported
> > > > > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > > > > >                         100baseT/Half 100baseT/Full
> > > > > > >                         1000baseT/Full
> > > > > > >                         2500baseT/Full
> > > > > > > Advertised pause frame use: Symmetric
> > > > > > > Advertised auto-negotiation: Yes
> > > > > > > Advertised FEC modes: Not reported
> > > > > > > Speed: 1000Mb/s
> > > > > > > Duplex: Full
> > > > > > > Auto-negotiation: on
> > > > > > > Port: Twisted Pair
> > > > > > > PHYAD: 0
> > > > > > > Transceiver: internal
> > > > > > > MDI-X: off (auto)
> > > > > > > netlink error: Operation not permitted
> > > > > > >         Current message level: 0x00000007 (7)
> > > > > > >                                drv probe link
> > > > > > > Link detected: yes
> > > > > > > ----
> > > > > > >
> > > > > > > Requeues should only happen if the driver is overwhelmed on t=
he tx
> > > > > > > side - i.e tx ring of choice has no more space. Back in the d=
ay, this
> > > > > > > was not a very common event.
> > > > > > > That can certainly be justified today with several explanatio=
ns if: a)
> > > > > > > modern processors getting faster b) the tx code path has beco=
me more
> > > > > > > efficient (true from inspection and your results but those pa=
tches are
> > > > > > > not on my small systems) c) (unlikely but) we are misaccounti=
ng for
> > > > > > > requeues (need to look at the code). d) the driver is too eag=
er to
> > > > > > > return TX BUSY.
> > > > > > >
> > > > > > > Thoughts?
> > > > > >
> > > > > > requeues can happen because some drivers do not use skb->len fo=
r the
> > > > > > BQL budget, but something bigger for GSO packets,
> > > > > > because they want to account for the (N) headers.
> > > > > >
> > > > > > So the core networking stack could pull too many packets from t=
he
> > > > > > qdisc for one xmit_more batch,
> > > > > > then ndo_start_xmit() at some point stops the queue before the =
end of
> > > > > > the batch, because BQL limit is hit sooner.
> > > > > >
> > > > > > I think drivers should not be overzealous, BQL is a best effort=
, we do
> > > > > > not care of extra headers.
> > > > > >
> > > > > > drivers/net/ethernet/intel/igc/igc_main.c is one of the overzea=
lous drivers ;)
> > > > > >
> > > > > > igc_tso() ...
> > > > > >
> > > > > > /* update gso size and bytecount with header size */
> > > > > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > > > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > > > > >
> > > > >
> > > > >
> > > > > Ok, the 25G i40e driver we are going to run tests on seems to be
> > > > > suffering from the same enthusiasm ;->
> > > > > I guess the same codebase..
> > > > > Very few drivers tho seem to be doing what you suggest. Of course=
 idpf
> > > > > being one of those ;->
> > > >
> > > > Note that few requeues are ok.
> > > >
> > > > In my case, I had 5 millions requeues per second, and at that point
> > > > you start noticing something is wrong ;)
> > >
> > > That's high ;-> For the nuc with igc, its <1%. Regardless, the
> > > eagerness for TX BUSY implies reduced performance due to the early
> > > bailout..
> >
> > Ok, we are going to do some testing RSN, however, my adhd wont let
> > this requeue thing go ;->
> >
> > So on at least i40e when you start sending say >2Mpps (forwarding or
> > tc mirred redirect ) - the TX BUSY is most certainly not because of
> > the driver is enthusiastically bailing out. Rather, this is due to BQL
> > - and specifically because netdev_tx_sent_queue() stops the queue;
> > Subsequent packets from the stack will get the magic TX_BUSY label in
> > sch_direct_xmit().
> >
> > Some context:
> > For forwarding use case benchmarking, the typical idea is to use RSS
> > and IRQ binding to a specific CPU then craft some traffic patterns on
> > the sender so that the test machine has a very smooth distribution
> > across the different CPUs i.e goal is to have almost perfect load
> > balancing.
> >
> > Q: In that case, would the defer list ever accumulate more than one
> > packet? Gut feeling says no.
>
> It can accumulate  way more, when there is a mix of very small packets
> and big TSO ones.
>
> IIf you had a lot of large TSO packets being sent, the queue bql/limit
> can reach 600,000 easily.
> TX completion happens, queue is empty, but latched limit is 600,000
> based on the last tx-completion round.
>
> Then you have small packets of 64 bytes being sent very fast (say from pk=
tgen)
>
> 600,000 / 64 =3D 9375
>
> But most TX queues have a limit of 1024 or 2048 skbs... so they will
> stop the queue _before_ BQL does.
>

Nice description, will check.
Remember, our use case is a middle box which receives pkts on one
netdev, does some processing, and sends to another. Essentially, we
pull from rx ring of src netdev, process and send to tx ring of the
other netdev. No batching or multiple CPUs funnelig to one txq and
very little if any TSO or locally generated traffic - and of course
benchmark is on 64B pkts.

>
> > Would have been nice to have an optional histogram to see the distribut=
ion..
>
> bpftrace is a nice way for building histograms.

Any tip will help, otherwise will figure it out..

cheers,
jamal
> >
> > cheers,
> > jamal

