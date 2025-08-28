Return-Path: <netdev+bounces-218026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA8B3AD7B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EC9582E13
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84C26D4E9;
	Thu, 28 Aug 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ng1W2zaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E2641F9
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419838; cv=none; b=CQnTfLSrLWjgDglNvZiUDrNNUUtr3TSMDEEvyZ6grcfAwT6iLKy88byqHzbJ9uPakQg2ey/M5g3QBEjFM+2pqJYoBBubE+NKeMPD2hYNqPeZYxrB23YVc/El1s2I53LQD+oftjsK8EIPzW2LqmBNMw1AOpVoaei1vcmPXTbbajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419838; c=relaxed/simple;
	bh=zxftWkFsaYEboWfyBV6TvSIjUVTHG6ofQuPshS170ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGIqAVn5eTZR5qeTVTEI877+bBhcr5s3zW90W+zGEVOlrkpDFrGYLrbaCmdrhZxKabpC9cnXBNgdVmnCfvMp1xsjXUcXYxaxYpF0yOhHHZlQf3GtbmCVDmdEMeMiAR4H6cjgN8GcrgBf/tVjDgNbhzoTN26okxBbjGbDKPnYeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ng1W2zaJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24611734e18so33745ad.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756419836; x=1757024636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sy+mqUkO1lhCHoO8nxgunBNTEODVzvgX+xmF1vSkwM=;
        b=ng1W2zaJ91TUSJCLazThxlXrFT25Q6BuM/jPjaaBtbN697OP4VFBtt1o3TMob7MJp3
         rbU2Xo833vbL9i/lwbj7dVJsEU9Hy+yfS9RAX6ObZM3aTk6bDMc7bi/Oc63LWantWnqX
         MTCMnTBCjh7Jgg36+pZYHjUTu5kT/XmT6rWnZidFO3AVpEeWopgbgC3ByIENVHA5HzlN
         WdCSOqJADgCq6v/I1RNro50yz+rgI+2fM7IVtbE9pgRTJrCFMcA1+0BXOI1zcZUJ0+N+
         Mzvbcwy2ZceLz/HN8JmhUYaVnx180oYCAdPh/5RhjbfSVr4UT1Mk4mCOqsT6EzuBgOBg
         fUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419836; x=1757024636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sy+mqUkO1lhCHoO8nxgunBNTEODVzvgX+xmF1vSkwM=;
        b=CHbHvdGw6NN7gFV00/hwjh85XaPfBB34FjBD/gsZbnYCvK0lydTVK91grcBoA/Qdgz
         XjOklxVR8sxR6f07fOxrJrngZC0zPXY806CufUqPY3XMbjD9wQaea+hVu0vmvTdVNACL
         U2glXh+DmYhoa6GbBvM2A34RqF+mfjtgMGmp5tiG6UTuRKzV4yMgUlN2wM521dhFVvuo
         sG5I4GP5V8qcDvTOFm/2OnGb1Yzey1i6Nmmolvsat2J5rY+FwwPHvka8+ivd7VMgwuIx
         Nqap2azZQ7mP5hb0x499yxRWKbaWuPUDttqnMTqwr5MqGw3C0vNkfb9EqLz1PVVzdVu9
         jOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXtLurUHCzFHDVFbnnHTjkAf68jl2v9mmUJ9BDQwaZU38bEuNcR6XCEgLAXU1J2IsHeqXgmHOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwellD5x5Ad0SQDrPIdzifAexRMS6pQu0GwwSqzW4HMS0LBZY9b
	MaGPViGMs2D/OPPKLwZ9hBivNDIGNZMnuMiUthTpDvZ+SHFyWON0sUQ0ai9tpxQ6EddVXwkOngI
	kSSb7rVp57bBayzm3SY2U/WZCXhzHh8I3vNO9bZO0
X-Gm-Gg: ASbGncvadBbnMBfr2kOZCEfxmaFsAEYa6+JXbE/B9I1f1yT0mkykQOcUiipfuJalSzf
	aLb3P/dJAIN8ODKZpCI7dcAbsV0+cv6qxuL0LlkUQ0HgXQZel0dZosN+hya4WrSBa3hf0h58Kdr
	zuP3XXR3BLUrCEmOsB4o2IKF8SufltahD0rkFofOdlWiE1TdzOeIP2bdBs1J0KUtB8ij/y/YNVr
	tWkqWqwZQf3GXS0vWhvl/EFmwgFM99BC0sSKJD+KRP+AlOIRcTPFVKh
X-Google-Smtp-Source: AGHT+IGAIj5tngB1H4vLJixMnNFd5blyYU41UglpcmbDlis7gV7fv8nw1NQbmImRfOLKY+j9vmt3Fjxul4pKYIDQUgE=
X-Received: by 2002:a17:902:ecd2:b0:246:1f3e:4973 with SMTP id
 d9443c01a7336-2485ba3d4femr17226815ad.6.1756419835428; Thu, 28 Aug 2025
 15:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com> <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
 <CAAywjhT-CEvHUSpjyXQkpkGRN0iX7qMc1p=QOn-iCNQxdycr2A@mail.gmail.com>
 <d2b52ee5-d7a7-4a97-ba9a-6c99e1470d9b@uwaterloo.ca> <CAAywjhStweQXMcc5LoDssLaXYpHRp7Pend2R-h_N16Q_Xa++yQ@mail.gmail.com>
 <fe42bbef-047c-49da-b9ff-a7806820ae0e@uwaterloo.ca>
In-Reply-To: <fe42bbef-047c-49da-b9ff-a7806820ae0e@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 28 Aug 2025 15:23:43 -0700
X-Gm-Features: Ac12FXy5Hc5QNZk2XUXng0brN2dN2_KOIt60V2ZXtX1hUVec-sbqqa0F3Lt9t3w
Message-ID: <CAAywjhQfiWWqE-tpwrVGR9a3uVLbVrSTq7_n_dJGE7c27io7MQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:45=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo=
.ca> wrote:
>
> On 2025-08-25 14:53, Samiullah Khawaja wrote:
> > On Mon, Aug 25, 2025 at 10:41=E2=80=AFAM Martin Karsten <mkarsten@uwate=
rloo.ca> wrote:
> >>
> >> On 2025-08-25 13:20, Samiullah Khawaja wrote:
> >>> On Sun, Aug 24, 2025 at 5:03=E2=80=AFPM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>>>
> >>>> On 2025-08-24 17:54, Samiullah Khawaja wrote:
> >>>>> Extend the already existing support of threaded napi poll to do con=
tinuous
> >>>>> busy polling.
> >>>>>
> >>>>> This is used for doing continuous polling of napi to fetch descript=
ors
> >>>>> from backing RX/TX queues for low latency applications. Allow enabl=
ing
> >>>>> of threaded busypoll using netlink so this can be enabled on a set =
of
> >>>>> dedicated napis for low latency applications.
> >>>>>
> >>>>> Once enabled user can fetch the PID of the kthread doing NAPI polli=
ng
> >>>>> and set affinity, priority and scheduler for it depending on the
> >>>>> low-latency requirements.
> >>>>>
> >>>>> Currently threaded napi is only enabled at device level using sysfs=
. Add
> >>>>> support to enable/disable threaded mode for a napi individually. Th=
is
> >>>>> can be done using the netlink interface. Extend `napi-set` op in ne=
tlink
> >>>>> spec that allows setting the `threaded` attribute of a napi.
> >>>>>
> >>>>> Extend the threaded attribute in napi struct to add an option to en=
able
> >>>>> continuous busy polling. Extend the netlink and sysfs interface to =
allow
> >>>>> enabling/disabling threaded busypolling at device or individual nap=
i
> >>>>> level.
> >>>>>
> >>>>> We use this for our AF_XDP based hard low-latency usecase with usec=
s
> >>>>> level latency requirement. For our usecase we want low jitter and s=
table
> >>>>> latency at P99.
> >>>>>
> >>>>> Following is an analysis and comparison of available (and compatibl=
e)
> >>>>> busy poll interfaces for a low latency usecase with stable P99. Ple=
ase
> >>>>> note that the throughput and cpu efficiency is a non-goal.
> >>>>>
> >>>>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> >>>>> description of the tool and how it tries to simulate the real workl=
oad
> >>>>> is following,
> >>>>>
> >>>>> - It sends UDP packets between 2 machines.
> >>>>> - The client machine sends packets at a fixed frequency. To maintai=
n the
> >>>>>      frequency of the packet being sent, we use open-loop sampling.=
 That is
> >>>>>      the packets are sent in a separate thread.
> >>>>> - The server replies to the packet inline by reading the pkt from t=
he
> >>>>>      recv ring and replies using the tx ring.
> >>>>> - To simulate the application processing time, we use a configurabl=
e
> >>>>>      delay in usecs on the client side after a reply is received fr=
om the
> >>>>>      server.
> >>>>>
> >>>>> The xdp_rr tool is posted separately as an RFC for tools/testing/se=
lftest.
> >>>>>
> >>>>> We use this tool with following napi polling configurations,
> >>>>>
> >>>>> - Interrupts only
> >>>>> - SO_BUSYPOLL (inline in the same thread where the client receives =
the
> >>>>>      packet).
> >>>>> - SO_BUSYPOLL (separate thread and separate core)
> >>> This one uses separate thread and core for polling the napi.
> >>
> >> That's not what I am referring to below.
> >>
> >> [snip]
> >>
> >>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | N=
API threaded |
> >>>>> |---|---|---|---|---|
> >>>>> | 12 Kpkt/s + 0us delay | | | | |
> >>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>>>> | 32 Kpkt/s + 30us delay | | | | |
> >>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>>>> | 125 Kpkt/s + 6us delay | | | | |
> >>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>>>> | 12 Kpkt/s + 78us delay | | | | |
> >>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>>>> | 25 Kpkt/s + 38us delay | | | | |
> >>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>>>>
> >>>>>     ## Observations
> >>>>
> >>>> Hi Samiullah,
> >>>>
> >>> Thanks for the review
> >>>> I believe you are comparing apples and oranges with these experiment=
s.
> >>>> Because threaded busy poll uses two cores at each end (at 100%), you
> >>> The SO_BUSYPOLL(separate) column is actually running in a separate
> >>> thread and using two cores. So this is actually comparing apples to
> >>> apples.
> >>
> >> I am not referring to SO_BUSYPOLL, but to the column labelled
> >> "interrupts". This is single-core, yes?
Not really. The interrupts are pinned to a different CPU and the
process (and it's threads) run a different CPU. Please check the cover
letter for interrupt and process affinity configurations..
> >>
> >>>> should compare with 2 pairs of xsk_rr processes using interrupt mode=
,
> >>>> but each running at half the rate. I am quite certain you would then=
 see
> >>>> the same latency as in the baseline experiment - at much reduced cpu
> >>>> utilization.
> >>>>
> >>>> Threaded busy poll reduces p99 latency by just 100 nsec, while
> >>> The table in the experiments show much larger differences in latency.
> >>
> >> Yes, because all but the first experiment add processing delay to
> >> simulate 100% load and thus most likely show queuing effects.
> >>
> >> Since "interrupts" uses just one core and "NAPI threaded" uses two, a
> >> fair comparison would be for "interrupts" to run two pairs of xsk_rr a=
t
> >> half the rate each. Then the load would be well below 100%, no queuein=
g,
> >> and latency would probably go back to the values measured in the "0us
> >> delay" experiments. At least that's what I would expect.
> > Two set of xsk_rr will go to two different NIC queues with two
> > different interrupts (I think). That would be comparing apples to
> > oranges, as all the other columns use a single NIC queue. Having
> > (Forcing user to have) two xsk sockets to deliver packets at a certain
> > rate is a completely different use case.
>
> I don't think a NIC queue is a more critical resource than a CPU core?
>
> And the rest depends on the actual application that would be using the
> service. The restriction to xsk_rr and its particulars is because that's
> the benchmark you provided.
> >> Reproduction is getting a bit difficult, because you haven't updated t=
he
> >> xsk_rr RFC and judging from the compilation error, maybe not built/run
> >> these experiments for a while now? It would be nice to have a working
> >> reproducible setup.
> > Oh. Let me check the xsk_rr and see whether it is outdated. I will
> > send out another RFC for it if it's outdated.
I checked this, it seems the last xsk_rr needs to be rebased. Will be
sending it out shortly.
> >>
> >>>> busy-spinning two cores, at each end - not more not less. I continue=
 to
> >>>> believe that this trade-off and these limited benefits need to be
> >>>> clearly and explicitly spelled out in the cover letter.
> >>> Yes, if you just look at the first row of the table then there is
> >>> virtually no difference.
> >> I'm not sure what you mean by this. I compare "interrupts" with "NAPI
> >> threaded" for the case "12 Kpkt/s + 0us delay" and I have explained wh=
y
> >> I believe the other experiments are not meaningful.
> > Yes that is exactly what I am disagreeing with. I don't think other
> > rows are "not meaningful". The xsk_rr is trying to "simulate the
> > application processing" by adding a cpu delay and the table clearly
> > shows the comparison between various mechanisms and how they perform
> > with in load.
>
> But these experiments only look at cases with almost exactly 100% load.
> As I mentioned in a previous round, this is highly unlikely for a
> latency-critical service and thus it seems contrived. Once you go to
> 100% load and see queueing effects, you also need to look left and right
> to investigate other load and system settings.
>
> Maybe this means the xsk_rr tool is not a good enough benchmark?
>
> Thanks,
> Martin
>

