Return-Path: <netdev+bounces-229800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D930BE0E82
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E351F4028F9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B03054FB;
	Wed, 15 Oct 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjzPbQCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBD3054EB
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566295; cv=none; b=MSo576vBMlWt+dtJH5b4jI5sf0mVUy4fcNPSjTf1F1X6hzwIQ6t1YbYwczrDa4lvMneTzfy5foyBKwiY6bC5TApARCLHR5OV0hTrX0atpeN8bwVW32uULi6Q2Cpy6wSYHAVgJrtvBITt3A/egCHUnti2DKe3Aw1SqOOQOi7wMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566295; c=relaxed/simple;
	bh=/3xLeGVpCG0FWHzbS3rmzGN0Id/obwSwxO71DnBB3Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz5miRtZxen+RS1e5ASIvK7odi7KSNJxgcRTD7ImsVfm5rr0alFrJl9P2GB3zdzygZ6Y545pkU63wHJfW5lbXtfSnS2+zhx07WGPNo6QNJCOCV4PJRK2R/aKdzhag/h+G9IkbiUold4It/sSyJJp+hsrnMHR8qxX8O4zgmgAMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjzPbQCt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85ed0a1b35dso7454685a.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760566293; x=1761171093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzZfgHtklE4QWAAmvOKjfOnZJ/3N2hqit7xP4/xmVtk=;
        b=VjzPbQCtDd9B6Hg6+mtutfWhK3K6JUUY++Jkb8mN+B76OHH9ngN4FJOn2AgLwfxDbT
         1RL7E3QXYDgAyOZ1xzSPSDme5uyiG+eiPDc43vZsjjY6w48v6MLtq7nxsJWhQ5EfgHDM
         JNOBl4UeYBI2HkYXaKlXQ6hPTNVFutxAgrgVCyAGuPiOThxPY316Sk9H6VdLWgo9A+k+
         u9xc29EM69Oe/TZ/1G8xS0yNxp4fXQSdosZgKfEhO/dudOS7Row36uaRwKMd3IRFnxrc
         vKmsX0NvqyT/ff8zoTIiaHpS8czxAjWAppm8FsNgFbvFElNCLc5BM/zvxW+dtLnnWJCq
         yGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566293; x=1761171093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzZfgHtklE4QWAAmvOKjfOnZJ/3N2hqit7xP4/xmVtk=;
        b=k1roQDmWqc2uSyrpjqyfzcU+dGNL+mj4RdqcHdrfZvKWRnTKz6ZykL9V1YYOz3rlI6
         Fdc2zlpxba2M8LC3SNxP25TrK+rVAgnfed00aly3D48lEanwoP6HyZlapX6fo1XkgFAM
         Wwq5cs7YE+hu7qm/QT+pfFVn56VCJ4ihUrn8voU613gx4F5AMlwcmP5qOOjqXztgrjpi
         TnPxca77cjwvR6sNPr1pV9nSiUqZtuCyYVbl88kJVkI+azkT8cfLndzNgg2czgUNO4Vg
         llilW5Ru0Rvqm69bujJlO+GYDQqBS0y3v7RFos1k9PQRXPIrrXAsgkHWkl6k6RS0mLzr
         Af8A==
X-Forwarded-Encrypted: i=1; AJvYcCWLYah4+1Ut+jVLnUg8zTS7mVuVgt5CyCBeH9Jt3YKE10/tFqC9AdPw3pGbuKAaV8jH+x4HSMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLd6FRud5G2odQ2wzPoJ9MKaJ2EsBm7Z9UhyFkh+wKCEWsNVT
	92qbDMCfA00JuqLkvWASmhVyV7b0K7E9pyBYG1J9p6LogUa6RaCR+sGE19R34TZuyqN7XfqCUiE
	KpyuPjRqwN5Vef2F614hOJZT0yUdHN9m+gn9z13am
X-Gm-Gg: ASbGnct2Lj9yKgGYv9kFrkTld0akPh+Put1rYCSbFY/KyvT0Pi/KdypoE9X6kAr5EsG
	dtlrX8Jhdu2sod3Phzia2pUFX9PeBhHvo7cKnQOwcowQXYsxh3VndHwT9hZiiZYUja8bLK4EwOG
	/piHlVuByw8wrqbfqs0XvW+4spOx2OTqNPR/9uA3ABKyKwrtYPro+KKjmPLTizv7fkzZS6MUd4z
	vGq7ZtiS+rfUmYpnWEuUsxOpkcbg/7pkOPXwpbxZVndMKE+6DlGJDRF+9k4R7yu5/nP
X-Google-Smtp-Source: AGHT+IHq5F7PvBRhSIBljInBxjJ+6AVdvwCnPPbwGOvZ6u6pphFffgVa7O7xadBWIyUSYoexgKeDJeS1kqJwlWaHY7I=
X-Received: by 2002:a05:622a:1f0b:b0:4cf:8fa2:ccd2 with SMTP id
 d75a77b69052e-4e6eacb3b68mr469348801cf.13.1760566292313; Wed, 15 Oct 2025
 15:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <CAM0EoMnvMZQpjNP5vCneur8GR+3oW3PxvzjtthNjFTtLBF5GtA@mail.gmail.com>
In-Reply-To: <CAM0EoMnvMZQpjNP5vCneur8GR+3oW3PxvzjtthNjFTtLBF5GtA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 15:11:21 -0700
X-Gm-Features: AS18NWDR0AFXqHr5k51YHXbel6-d-Hjqjpy-QXxhYrp_RS9y0a_x0CppWXdwg2I
Message-ID: <CANn89iKb1a9-dS7g6zauBAechM6Ji7S1F0WAXtSAjYP34+QSqg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/6] net: optimize TX throughput and efficiency
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Oct 14, 2025 at 1:19=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > In this series, I replace the busylock spinlock we have in
> > __dev_queue_xmit() and use lockless list (llist) to reduce
> > spinlock contention to the minimum.
> >
> > Idea is that only one cpu might spin on the qdisc spinlock,
> > while others simply add their skb in the llist.
> >
> > After this series, we get a 300 % (4x) improvement on heavy TX workload=
s,
> > sending twice the number of packets per second, for half the cpu cycles=
.
> >
>
> Not important but i am curious: you didnt mention what NIC this was in
> the commit messages ;->

I have used two NIC : IDPF (200Gbit), and GQ (100Gbit Google NIC)
(Usually with 32 TX queues)

And a variety of platforms, up to 512 cores sharing these 32 TX queues.

>
> For the patchset, I have done testing with existing tdc tests and no
> regression..
> It does inspire new things when time becomes available.... so will be
> doing more testing and likely small extensions etc.
> So:
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks Jamal !

I also have this idea:

cpus serving NIC interrupts and specifically TX completions are often
trapped in also restarting a busy qdisc (because it was stopped by BQL
or the driver's own flow control).

We can do better:

1) In the TX completion loop, collect the skbs and do not free them immedia=
tely.

2) Store them in a private list and sum their skb->len while doing so.

3) Then call netdev_tx_completed_queue() call and netif_tx_wake_queue().

If the queue was stopped, this might add the qdisc in our per-cpu
private list (sd->output_queue), raising NET_TX_SOFTIRQ (no immediate
action because napi poll runs while BH are blocked)

4) Then, take care of all dev_consume_skb_any().

Quite often freeing these skbs can take a lot of time, because of mm
contention, and other false sharing, or expensive skb->destructor like
TCP.

5) By the time net_tx_action() finally runs, perhaps another cpu saw
the queue being in XON state and was able to push more packets to the
queue.

This means net_tx_action() might have nothing to do, saving precious cycles=
.

We should add extra logic in net_tx_action() to not even grab
qdisc_lock() spinlock at all.

My thinking is to add back a sequence (to replace q->running boolean),
and store a snapshot of this sequence every time we restart a queue.
-> net_tx_action can compare the sequence against the last snapshot.

> (For the tc bits, since the majority of the code touches tc related stuff=
)
>
> cheers,
> jamal
>
>
> > v2: deflake tcp_user_timeout_user-timeout-probe.pkt.
> >     Ability to return a different code than NET_XMIT_SUCCESS
> >     when __dev_xmit_skb() has a single skb to send.
> >
> > Eric Dumazet (6):
> >   selftests/net: packetdrill: unflake
> >     tcp_user_timeout_user-timeout-probe.pkt
> >   net: add add indirect call wrapper in skb_release_head_state()
> >   net/sched: act_mirred: add loop detection
> >   Revert "net/sched: Fix mirred deadlock on device recursion"
> >   net: sched: claim one cache line in Qdisc
> >   net: dev_queue_xmit() llist adoption
> >
> >  include/linux/netdevice_xmit.h                |  9 +-
> >  include/net/sch_generic.h                     | 23 ++---
> >  net/core/dev.c                                | 97 +++++++++++--------
> >  net/core/skbuff.c                             | 11 ++-
> >  net/sched/act_mirred.c                        | 62 +++++-------
> >  net/sched/sch_generic.c                       |  7 --
> >  .../tcp_user_timeout_user-timeout-probe.pkt   |  6 +-
> >  7 files changed, 111 insertions(+), 104 deletions(-)
> >
> > --
> > 2.51.0.788.g6d19910ace-goog
> >

