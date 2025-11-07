Return-Path: <netdev+bounces-236842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA940C40A02
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B97564CAA
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8F328B56;
	Fri,  7 Nov 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5QB7m3F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432E32C326
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529847; cv=none; b=pewkzR2YoG4IzLwJq8Vel5ytLpjbjDO8Pi7F8bvZGCw+oMOO8TZW1eW9IhSdEM9JFfTGjV1lWSBR+/qLiVecNyI13vw3/4b+pl3RgwVUpHG1pTsfq0eFYJQhrwLx9xc85AILuUlQfYeSefIwbEZF26Ary5Oz6Fi0/80nyF52vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529847; c=relaxed/simple;
	bh=mzTckfGnR3BKrxxIuLwdzMMd7FO0+cilnjkiyEbxjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhTPKesOSTxJ1sYjFoOtAd7TiE/9U7YH/UnQ2zvjqWX4z5RgsHBMZ5Zo+wZEko3oxgRRARD4Ff1/FnwMYCr9ID1/6LznpaNLlt6yLK0BtrZ0sXAr1sRDuvPhDIIGFVQnQQ1uaoAnERF4Q8XkJLlTIP3uU3gmFiOn37LO2sJrDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5QB7m3F; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda26a04bfso1300421cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762529844; x=1763134644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i1zwogYUIA0lNVaiiiD+tzvdN3pjRHUAwDjP7lA6ow=;
        b=a5QB7m3F9fPt/hFNEX6bp37bqeNLWWQXuwqEaydOHl0JMGuPVv9R0MHjgNz7bniO1I
         WfHtvQG+ldBi4hk0lo4rezcjOhnpngxBmkI5v6GEM5BcBpUWMdmj0m/2LfD/hva+abhJ
         okK8JdGbxCDurVt0dBymKH7+KaE8dhZqIGw/fIQLUMWSTvw/EU9UTImTNKRzC89cGuew
         7i5SFIxwodlhdiQwM0xOVJbXTsspxV2c8/h9NEsAtfDboyFXwmH1bXE6X4oJkdjoOqIg
         2QADLKGO192nOkBSezx3NQSCOur74cQQDuN7XtGljmUuyiIlK8iPp4Yn15YGLJdGtSYC
         4gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529844; x=1763134644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7i1zwogYUIA0lNVaiiiD+tzvdN3pjRHUAwDjP7lA6ow=;
        b=AGHa6/L2wmXHHMC1nME00kBJsVbrv+NQR+qP5pxzgAMNrqZEU/7vAaro95xBToKHum
         KOqkfiSitvcXSTJBxo2KJmF2qmf1vkisR8bfYAopRdZ78bqk5b4eM3WnHsgzPdGXzFHv
         VaS8Bcl2Ze6Pw1s7JWJL0nCPxqKHo6Py1NJY1Da1OUfQL0Ui+ktltxDdVF4xZ1e5N26H
         Ed8NpdkApBAgkLshGQaWFpf433e0OEddFMyx2ssIIMg1gaHQzXcYyc2a3fxv9jRocfFf
         WhaNPr2vUwPHRknGNsCHUnmBvltph2dIpvx1hBMWi5FwgSvhJzXolZFkhJCAOQll5c2D
         /sfA==
X-Forwarded-Encrypted: i=1; AJvYcCUVB1SBaHZ4RArzJptPNn97ntVXDTg6BK3V7zcZDgQfswYyYtMU3tp99sLXdoGTntmGqr1Aw4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEbv23PtPduDs6AqK3KHi1/CQZ/86IKDQ8IXAlpGgVNUW9LlX
	24SYtM0TRUtR9ww84+1IdOPR/L8q6l08M0F3TD+bXBJ20XyDPQ0byVwRjySUJl0YiCaNjXdlLDc
	qnPwcQOSUAbuBep2tQqvhJoKB64ZtploxNhWeYh6D
X-Gm-Gg: ASbGncu0MwU2feWBwClzFHjVOYac6529a+yAF7MgiFIz+Alx6YUZyjP2HZFtS0+n7ql
	YXl4hBxyPJdCo9v2Ad+nmDvxTR3FZvrpyAYYLuVDSkexZZXxtIdiHJil1oDegrNGXWLo+DXxqLD
	LEsfhhdMiccG7mHP4E8Czx/BULgEACZem1eSkDPU188qxZY+lmiKEav0mFuvBP1YstpV9UWsQFg
	0GqMlKnTM2w5R0KAzJNKimT4jiqAcY2w3lPSP0RiOn63TCsMNgijneAaP4F89WbBBdSaAY=
X-Google-Smtp-Source: AGHT+IGwti67ZIGjh5w4oBisdOrvgTapkQOC/H1XyWAajBbviyiHlnhWjOkXNDQ3AFNY/EfisuTVJXDA9FHo7/lQnek=
X-Received: by 2002:a05:622a:1207:b0:4e8:a9f6:360 with SMTP id
 d75a77b69052e-4ed94a4cbafmr45872791cf.70.1762529844105; Fri, 07 Nov 2025
 07:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk>
In-Reply-To: <877bw1ooa7.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 07:37:12 -0800
X-Gm-Features: AWmQ_bkmscqQCTmncV38eqVDcDT5OEkxjx83dSic7zJbaPOPmhFxdgppaKcmIc0
Message-ID: <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Remove busylock spinlock and use a lockless list (llist)
> > to reduce spinlock contention to the minimum.
> >
> > Idea is that only one cpu might spin on the qdisc spinlock,
> > while others simply add their skb in the llist.
> >
> > After this patch, we get a 300 % improvement on heavy TX workloads.
> > - Sending twice the number of packets per second.
> > - While consuming 50 % less cycles.
> >
> > Note that this also allows in the future to submit batches
> > to various qdisc->enqueue() methods.
> >
> > Tested:
> >
> > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid conten=
tion in mm)
> > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>
> Hi Eric
>
> While testing this with sch_cake (to get a new baseline for the mq_cake
> patches as Jamal suggested), I found that this patch completely destroys
> the performance of cake in particular.
>
> I run a small UDP test (64-byte packets across 16 flows through
> xdp-trafficgen, offered load is ~5Mpps) with a single cake instance on
> as the root interface qdisc.
>
> With a stock Fedora (6.17.7) kernel, this gets me around 630 Kpps across
> 8 queues (on an E810-C, ice driver):
>
> Ethtool(ice0p1  ) stat:     40321218 (     40,321,218) <=3D tx_bytes /sec
> Ethtool(ice0p1  ) stat:     42841424 (     42,841,424) <=3D tx_bytes.nic =
/sec
> Ethtool(ice0p1  ) stat:      5248505 (      5,248,505) <=3D tx_queue_0_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82008 (         82,008) <=3D tx_queue_0_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      3425984 (      3,425,984) <=3D tx_queue_1_by=
tes /sec
> Ethtool(ice0p1  ) stat:        53531 (         53,531) <=3D tx_queue_1_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5277496 (      5,277,496) <=3D tx_queue_2_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82461 (         82,461) <=3D tx_queue_2_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5285736 (      5,285,736) <=3D tx_queue_3_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82590 (         82,590) <=3D tx_queue_3_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5280731 (      5,280,731) <=3D tx_queue_4_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82511 (         82,511) <=3D tx_queue_4_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5275665 (      5,275,665) <=3D tx_queue_5_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82432 (         82,432) <=3D tx_queue_5_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5276398 (      5,276,398) <=3D tx_queue_6_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82444 (         82,444) <=3D tx_queue_6_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:      5250946 (      5,250,946) <=3D tx_queue_7_by=
tes /sec
> Ethtool(ice0p1  ) stat:        82046 (         82,046) <=3D tx_queue_7_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:            1 (              1) <=3D tx_restart /s=
ec
> Ethtool(ice0p1  ) stat:       630023 (        630,023) <=3D tx_size_127.n=
ic /sec
> Ethtool(ice0p1  ) stat:       630019 (        630,019) <=3D tx_unicast /s=
ec
> Ethtool(ice0p1  ) stat:       630020 (        630,020) <=3D tx_unicast.ni=
c /sec
>
> However, running the same test on a net-next kernel, performance drops
> to round 10 Kpps(!):
>
> Ethtool(ice0p1  ) stat:       679003 (        679,003) <=3D tx_bytes /sec
> Ethtool(ice0p1  ) stat:       721440 (        721,440) <=3D tx_bytes.nic =
/sec
> Ethtool(ice0p1  ) stat:       123539 (        123,539) <=3D tx_queue_0_by=
tes /sec
> Ethtool(ice0p1  ) stat:         1930 (          1,930) <=3D tx_queue_0_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_1_by=
tes /sec
> Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_1_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:         1837 (          1,837) <=3D tx_queue_2_by=
tes /sec
> Ethtool(ice0p1  ) stat:           29 (             29) <=3D tx_queue_2_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_3_by=
tes /sec
> Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_3_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:         1654 (          1,654) <=3D tx_queue_4_by=
tes /sec
> Ethtool(ice0p1  ) stat:           26 (             26) <=3D tx_queue_4_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:       222026 (        222,026) <=3D tx_queue_5_by=
tes /sec
> Ethtool(ice0p1  ) stat:         3469 (          3,469) <=3D tx_queue_5_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:       183072 (        183,072) <=3D tx_queue_6_by=
tes /sec
> Ethtool(ice0p1  ) stat:         2861 (          2,861) <=3D tx_queue_6_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:       143322 (        143,322) <=3D tx_queue_7_by=
tes /sec
> Ethtool(ice0p1  ) stat:         2239 (          2,239) <=3D tx_queue_7_pa=
ckets /sec
> Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_size_127.n=
ic /sec
> Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicast /s=
ec
> Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicast.ni=
c /sec
>
> Reverting commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
> (and the followon f8a55d5e71e6 ("net: add a fast path in
> __netif_schedule()"), but that alone makes no difference) gets me back
> to the previous 630-650 Kpps range.
>
> I couldn't find any other qdisc that suffers in the same way (tried
> fq_codel, sfq and netem as single root qdiscs), so this seems to be some
> specific interaction between the llist implementation and sch_cake. Any
> idea what could be causing this?

I would take a look at full "tc -s -d qdisc" and see if anything
interesting is showing up (requeues ?)

ALso look if you have drops (perf record -a -e skb:kfree_skb)

You are sharing one qdisc on 8 queues ?

