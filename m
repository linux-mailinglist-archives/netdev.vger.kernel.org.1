Return-Path: <netdev+bounces-216591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CDB34AAC
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDDE7A9C7B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25C27EFF1;
	Mon, 25 Aug 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLDdJRwo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7A27E076
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148053; cv=none; b=gQx7UbQj41Ebjviofwq8TToFMLmKeRAD9o1NnL9X7Ew3DaSrubbvdsZWSUpD1Q/FuX0PIVv962uztAOjXzznRSgBRJFN17zTOjIVuDBhTS24FYg+UJGpkNURJfOsXh9pgXp9AMhhzD7OP4csfdwvCUHJrKf+DfS4G/OXg43fJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148053; c=relaxed/simple;
	bh=TUFgEHJN57hAmHBOAkzyDc+uf8964QaJzI/sn07Ifsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcda2wy15JuXgkh2bTwZwHJNRGGttp2CnhQ69fSq/H8utMFrmIvdZxxtMeDQ4x1oU+xGi9OctbTbGICAt3HkKU25q9fuBORiodIu3TPLy3qUudzJPa9zPlVxj5hLffCVuoiVXtf331jdFl3ha2r7UIDZPn2R3wFYtxqZgc2/N/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLDdJRwo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246013de800so31395ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756148051; x=1756752851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWhSehJQ/cmVas35BHDzVEfyuG1ktcLe1thgeglKcvk=;
        b=tLDdJRwohyFnokDd96iarswiZgT/Fr5E7dIrwo+8JJo4VzcusSdTm1NR0od1cQ+r1x
         YdxjtWRjERSpdTyS8eZgsyvSyODGtGmRLzLyO7ZFIOnWfZ/t9wiDnWLg9yD0ddHWG9Og
         9ffcFa8xEJsO91GyLU/deURQRLFTgfYpHPXerLeAVK9AcwDUR/GYpUD0xPvb0kvtNEYK
         433C5WVtg3EY0tuDuLu2hpDV8HJXN1K89hGbN74ZNj4QdJILw7lEYSOCzeDKv2oqmbHv
         EtdQiEweeOzOdqEeIWdYBPZiar96TEacQI+SarrI529ro2uQ1qlNEQ6l+3d/N63MQdKN
         4NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148051; x=1756752851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWhSehJQ/cmVas35BHDzVEfyuG1ktcLe1thgeglKcvk=;
        b=weKgyE0zGcHEUmpeD/F65UIFYud3xAGNWD/8MJfXuGjFbCN7/jttrgouOBIqbeCqFh
         5M5yMgR+HczaBVcSX7KbSypwZFnZ8lnrZF7RsyHfTt6x6HFuhtTnhMQDeTj1hEknX2NQ
         SKLMFPVSJnljIPJARIvM+xLazuQJfV8DmVzDrXfLcalyW7aN61AXetowhpmRg8WxCtes
         l3u57Qth1O6CxNtbSzMbmQuTIxRW4sfdfPYbkNXqzIy5izzwqyRpeJMkLdg2YgN08PU6
         raOlMjtlE/bk53lc6zmZW/b33kRbTTv5DrlOHnlK0+21bUIcs+miydW+To49SveosiP5
         K0xA==
X-Forwarded-Encrypted: i=1; AJvYcCUpW6nq7SG+ILo8Had+gLa8oQGcwHVOu19NGfRXltpuA6naQaPrAB+EYMASiruvWXmLEfDuCx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxPZAnQRM72/HnktL93ymKKwESE5X6B0vgz2Y93xvFXv0YZZX
	7ZMJXnhNthlFxdtyam3Ev1mS2fJQKbDPdM7r1RRB1UpfP/d5rsWkCTn0UVWfVut1Vs+hlJujBo1
	LEWUTSsIPJjM5d6FwVsE77Xdtdzor/ORFXBUBBy56
X-Gm-Gg: ASbGnctYv4tLxCPF9Rhnu5FTGTnKZRV4EqIH/jNEybhWA8rwUnmfloL2YJDE/QRIOmP
	rvrCGJEWORRRJjaOcCNXLXcYBrIjJrs5xIRha+JTw0f3zwyELZgy2Iv7YMVDNXP8xbx+CNacuTu
	/y2/Ul1c4hW3quhCLntHXFUQ/P50Ep7NX7HqdvJsAVjyqdysMuLC1KouF8Tl19ftVvXAVU4qUGO
	WAx51Yy3LGYx/9rv/KnX2QEmw9NIR01Rx7YkekXt0Sa
X-Google-Smtp-Source: AGHT+IGx0GByvuXs/wDo+Eg0WhuHYIVXZCyPUB1Gao+IenWlXpZgrPvNrMU7DTuFgD+oB4dRw+BF0XcZW+owqV1YU1Q=
X-Received: by 2002:a17:903:2444:b0:245:f7a8:bc60 with SMTP id
 d9443c01a7336-2485bd93e9cmr333435ad.16.1756148050815; Mon, 25 Aug 2025
 11:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com> <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
 <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com> <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca>
In-Reply-To: <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 25 Aug 2025 11:53:58 -0700
X-Gm-Features: Ac12FXxEnHQH8DpGBmGg3RBa5SMsfo6tVdZXLN_U7-PWKJI5jCNAufveF4V3kEc
Message-ID: <CAAywjhStweQXMcc5LoDssLaXYpHRp7Pend2R-h_N16Q_Xa++yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:41=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo=
.ca> wrote:
>
> On 2025-08-25 13:20, Samiullah Khawaja wrote:
> > On Sun, Aug 24, 2025 at 5:03=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-08-24 17:54, Samiullah Khawaja wrote:
> >>> Extend the already existing support of threaded napi poll to do conti=
nuous
> >>> busy polling.
> >>>
> >>> This is used for doing continuous polling of napi to fetch descriptor=
s
> >>> from backing RX/TX queues for low latency applications. Allow enablin=
g
> >>> of threaded busypoll using netlink so this can be enabled on a set of
> >>> dedicated napis for low latency applications.
> >>>
> >>> Once enabled user can fetch the PID of the kthread doing NAPI polling
> >>> and set affinity, priority and scheduler for it depending on the
> >>> low-latency requirements.
> >>>
> >>> Currently threaded napi is only enabled at device level using sysfs. =
Add
> >>> support to enable/disable threaded mode for a napi individually. This
> >>> can be done using the netlink interface. Extend `napi-set` op in netl=
ink
> >>> spec that allows setting the `threaded` attribute of a napi.
> >>>
> >>> Extend the threaded attribute in napi struct to add an option to enab=
le
> >>> continuous busy polling. Extend the netlink and sysfs interface to al=
low
> >>> enabling/disabling threaded busypolling at device or individual napi
> >>> level.
> >>>
> >>> We use this for our AF_XDP based hard low-latency usecase with usecs
> >>> level latency requirement. For our usecase we want low jitter and sta=
ble
> >>> latency at P99.
> >>>
> >>> Following is an analysis and comparison of available (and compatible)
> >>> busy poll interfaces for a low latency usecase with stable P99. Pleas=
e
> >>> note that the throughput and cpu efficiency is a non-goal.
> >>>
> >>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> >>> description of the tool and how it tries to simulate the real workloa=
d
> >>> is following,
> >>>
> >>> - It sends UDP packets between 2 machines.
> >>> - The client machine sends packets at a fixed frequency. To maintain =
the
> >>>     frequency of the packet being sent, we use open-loop sampling. Th=
at is
> >>>     the packets are sent in a separate thread.
> >>> - The server replies to the packet inline by reading the pkt from the
> >>>     recv ring and replies using the tx ring.
> >>> - To simulate the application processing time, we use a configurable
> >>>     delay in usecs on the client side after a reply is received from =
the
> >>>     server.
> >>>
> >>> The xdp_rr tool is posted separately as an RFC for tools/testing/self=
test.
> >>>
> >>> We use this tool with following napi polling configurations,
> >>>
> >>> - Interrupts only
> >>> - SO_BUSYPOLL (inline in the same thread where the client receives th=
e
> >>>     packet).
> >>> - SO_BUSYPOLL (separate thread and separate core)
> > This one uses separate thread and core for polling the napi.
>
> That's not what I am referring to below.
>
> [snip]
>
> >>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAP=
I threaded |
> >>> |---|---|---|---|---|
> >>> | 12 Kpkt/s + 0us delay | | | | |
> >>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>> | 32 Kpkt/s + 30us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>> | 125 Kpkt/s + 6us delay | | | | |
> >>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>> | 12 Kpkt/s + 78us delay | | | | |
> >>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>> | 25 Kpkt/s + 38us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>
> >>>    ## Observations
> >>
> >> Hi Samiullah,
> >>
> > Thanks for the review
> >> I believe you are comparing apples and oranges with these experiments.
> >> Because threaded busy poll uses two cores at each end (at 100%), you
> > The SO_BUSYPOLL(separate) column is actually running in a separate
> > thread and using two cores. So this is actually comparing apples to
> > apples.
>
> I am not referring to SO_BUSYPOLL, but to the column labelled
> "interrupts". This is single-core, yes?
>
> >> should compare with 2 pairs of xsk_rr processes using interrupt mode,
> >> but each running at half the rate. I am quite certain you would then s=
ee
> >> the same latency as in the baseline experiment - at much reduced cpu
> >> utilization.
> >>
> >> Threaded busy poll reduces p99 latency by just 100 nsec, while
> > The table in the experiments show much larger differences in latency.
>
> Yes, because all but the first experiment add processing delay to
> simulate 100% load and thus most likely show queuing effects.
>
> Since "interrupts" uses just one core and "NAPI threaded" uses two, a
> fair comparison would be for "interrupts" to run two pairs of xsk_rr at
> half the rate each. Then the load would be well below 100%, no queueing,
> and latency would probably go back to the values measured in the "0us
> delay" experiments. At least that's what I would expect.
Two set of xsk_rr will go to two different NIC queues with two
different interrupts (I think). That would be comparing apples to
oranges, as all the other columns use a single NIC queue. Having
(Forcing user to have) two xsk sockets to deliver packets at a certain
rate is a completely different use case.
>
> Reproduction is getting a bit difficult, because you haven't updated the
> xsk_rr RFC and judging from the compilation error, maybe not built/run
> these experiments for a while now? It would be nice to have a working
> reproducible setup.
Oh. Let me check the xsk_rr and see whether it is outdated. I will
send out another RFC for it if it's outdated.
>
> >> busy-spinning two cores, at each end - not more not less. I continue t=
o
> >> believe that this trade-off and these limited benefits need to be
> >> clearly and explicitly spelled out in the cover letter.
> > Yes, if you just look at the first row of the table then there is
> > virtually no difference.
> I'm not sure what you mean by this. I compare "interrupts" with "NAPI
> threaded" for the case "12 Kpkt/s + 0us delay" and I have explained why
> I believe the other experiments are not meaningful.
Yes that is exactly what I am disagreeing with. I don't think other
rows are "not meaningful". The xsk_rr is trying to "simulate the
application processing" by adding a cpu delay and the table clearly
shows the comparison between various mechanisms and how they perform
with in load.
>
> Thanks,
> Martin
>

