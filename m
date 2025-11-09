Return-Path: <netdev+bounces-237036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B742C43B7F
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 11:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A7F3ADF06
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1324677B;
	Sun,  9 Nov 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILWGiQAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C42205E02
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762682958; cv=none; b=cT7/gr6IF8Qt3gSX1W7L9BUjQPOi67HLpBEp8fQ59mbtwF5gy5bZddKsHSS9ryXRZ5meL5JFyUcxy3X5zA526y8Riz9xos8l9wm8ENiUYvTaq5XgMMDqQL5Fsv7oXKWlrc0qwSrW0hJXPnk1eAk6MFWyGcNO19hH51cCd2mU9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762682958; c=relaxed/simple;
	bh=p9NKq+c4j5i0DmwFWl3ApaVv55ajIcABlUVcHfqyLOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imxOiasxP1R6N55AOci93DUUdIX6v7VGA3cokayagUCbwcMNRk+6nTA1vAafGeGrmjGXCFrS6Oc940yFMnTXNPN2hYkHPagqN7fUKtLgGBlyVtaAh3vGbop1Wl4f2rTzvJT5cWGqg6hXKtzvooMzf9hTOQORCpXeqvyRQy5zsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILWGiQAx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787e7aa1631so2046777b3.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762682955; x=1763287755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUhjKMukcqM8RbLb2BP4c+VHkWwKKYP73S1W6vqPC9Y=;
        b=ILWGiQAxGmIkFunPhvDF5zSO/tT9SBOVm3SKRtgZFABBpa9tCPRn1bTZOue/QhbrCs
         GbbmAjmwCI/GR4EZdGU6x64SixHLh8gkxWfwXj59zqjNIDGdZGg+cnd7+xLLj+lOk/2X
         0seoJi5tQWvV0KuZphSidVMFJJOZBZuZbZjPXbM5Gu6bDqEfG/TY05nc34GBMREJYMB8
         OYDPsIuxv+eINpflkWyu8pKyzmFOc3sb4jHCDymDLcwICjJOZVQNqqMJieUXz0pdnPv8
         4CjIcy2atRe1+fnCCRq3IuV9r+1UbKUoCT4aWW2b17FiqNoWBB1p4eXUwBQ1HI7Qbi1f
         A2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762682955; x=1763287755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUhjKMukcqM8RbLb2BP4c+VHkWwKKYP73S1W6vqPC9Y=;
        b=H+bBtYfzMAXQMEgpy8hKVqpWxfGW93OaKLdPkULcsnu+5m9dkkP79xmHERQtnIJxSM
         A8zPBOM4mBvZw3PXSdzLhFadtnT7BvRhzfRd300T/d4Aw446jbjKMcZrK2q5tSV5O4db
         R6thuP8+zenMZWpuzKZoSuJAMxOw8xQOd0oBy3HBu0QqW3eSLwrKttYpB1l17CGhqx/e
         NoUwQSN+iHdgEX7AUXTcOfUy4u/ZFUrePWThcNJl3nK3pFIOlfuAqFA/R4gtW2vj98e9
         f5MVgCkH5WOWzyfD63/NjIAdkNEIXS6tHiEJ7+HD90cC2ZA097w3TkIYse2AyGJzbi/k
         fcpg==
X-Forwarded-Encrypted: i=1; AJvYcCWRlA1XTKCPA6AwVZwmwGLbWHXLvOTL4n4xjdbAhlmoQB18Ziyz/qHPj/eHDCGSgtUr9CtVeVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5HcXMz9+kssV2owAlAtqgwuBfNOVCMPyjDAvz+gm2GtKmZAX
	dFbj/X2NXCN79ugaODcS7U4+nb7BWOAhzcf8aOnVActVLgV0XMT9LLLE+g4I56N6yHDSv2uG2JL
	OESai5nJq3HnXC3dQQDGNKl/m11IuJsKweqQLr/Oh
X-Gm-Gg: ASbGncuKZGDroxzLdYXJkEJ1i0Rw1EJkTs9O0OAInobyLctwcDa5cM13sGGgbJECX5u
	eThC9AHgXFnFzr6j/aJ1P4Q3pEq3HJYdPOHozYnWmJV2enbc9Aoq3ZpD7FSxl1Dj+13QlGCqOQR
	Z791a9MyC8hjAT9OoMu19/smfLYa9vepy7AHl9/vR7LwoTmNAmkkFjASXUUU0RTDDXcNm2y9iFT
	zZJ3q28S3hTlZ+Cbei1WTppmnU77ZsbtH+tJ1ds23xTj4GTvDbCyZcb3rQ=
X-Google-Smtp-Source: AGHT+IGymYXutWf0w423H6eWONpHowkmdWU2xC1Fy+kBmXs2UM9SnZgwYDK2r6gDIrmK4XG6EqvhwZp2Y+qY7qBlTlA=
X-Received: by 2002:a05:690e:4316:b0:63f:ae23:b5e6 with SMTP id
 956f58d0204a3-640c9d94192mr4593205d50.26.1762682954416; Sun, 09 Nov 2025
 02:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
In-Reply-To: <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 02:09:03 -0800
X-Gm-Features: AWmQ_bkBOVv0k0-rtI138SM7Vf96ZYEsFhcknYFA1p8XXR0TQ5FHAlhv_NQ-cd0
Message-ID: <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Nov 7, 2025 at 7:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> > >
> > > Eric Dumazet <edumazet@google.com> writes:
> > >
> > > > Remove busylock spinlock and use a lockless list (llist)
> > > > to reduce spinlock contention to the minimum.
> > > >
> > > > Idea is that only one cpu might spin on the qdisc spinlock,
> > > > while others simply add their skb in the llist.
> > > >
> > > > After this patch, we get a 300 % improvement on heavy TX workloads.
> > > > - Sending twice the number of packets per second.
> > > > - While consuming 50 % less cycles.
> > > >
> > > > Note that this also allows in the future to submit batches
> > > > to various qdisc->enqueue() methods.
> > > >
> > > > Tested:
> > > >
> > > > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> > > > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> > > > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid co=
ntention in mm)
> > > > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
> > >
> > > Hi Eric
> > >
> > > While testing this with sch_cake (to get a new baseline for the mq_ca=
ke
> > > patches as Jamal suggested), I found that this patch completely destr=
oys
> > > the performance of cake in particular.
> > >
> > > I run a small UDP test (64-byte packets across 16 flows through
> > > xdp-trafficgen, offered load is ~5Mpps) with a single cake instance o=
n
> > > as the root interface qdisc.
> > >
> > > With a stock Fedora (6.17.7) kernel, this gets me around 630 Kpps acr=
oss
> > > 8 queues (on an E810-C, ice driver):
> > >
> > > Ethtool(ice0p1  ) stat:     40321218 (     40,321,218) <=3D tx_bytes =
/sec
> > > Ethtool(ice0p1  ) stat:     42841424 (     42,841,424) <=3D tx_bytes.=
nic /sec
> > > Ethtool(ice0p1  ) stat:      5248505 (      5,248,505) <=3D tx_queue_=
0_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82008 (         82,008) <=3D tx_queue_=
0_packets /sec
> > > Ethtool(ice0p1  ) stat:      3425984 (      3,425,984) <=3D tx_queue_=
1_bytes /sec
> > > Ethtool(ice0p1  ) stat:        53531 (         53,531) <=3D tx_queue_=
1_packets /sec
> > > Ethtool(ice0p1  ) stat:      5277496 (      5,277,496) <=3D tx_queue_=
2_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82461 (         82,461) <=3D tx_queue_=
2_packets /sec
> > > Ethtool(ice0p1  ) stat:      5285736 (      5,285,736) <=3D tx_queue_=
3_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82590 (         82,590) <=3D tx_queue_=
3_packets /sec
> > > Ethtool(ice0p1  ) stat:      5280731 (      5,280,731) <=3D tx_queue_=
4_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82511 (         82,511) <=3D tx_queue_=
4_packets /sec
> > > Ethtool(ice0p1  ) stat:      5275665 (      5,275,665) <=3D tx_queue_=
5_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82432 (         82,432) <=3D tx_queue_=
5_packets /sec
> > > Ethtool(ice0p1  ) stat:      5276398 (      5,276,398) <=3D tx_queue_=
6_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82444 (         82,444) <=3D tx_queue_=
6_packets /sec
> > > Ethtool(ice0p1  ) stat:      5250946 (      5,250,946) <=3D tx_queue_=
7_bytes /sec
> > > Ethtool(ice0p1  ) stat:        82046 (         82,046) <=3D tx_queue_=
7_packets /sec
> > > Ethtool(ice0p1  ) stat:            1 (              1) <=3D tx_restar=
t /sec
> > > Ethtool(ice0p1  ) stat:       630023 (        630,023) <=3D tx_size_1=
27.nic /sec
> > > Ethtool(ice0p1  ) stat:       630019 (        630,019) <=3D tx_unicas=
t /sec
> > > Ethtool(ice0p1  ) stat:       630020 (        630,020) <=3D tx_unicas=
t.nic /sec
> > >
> > > However, running the same test on a net-next kernel, performance drop=
s
> > > to round 10 Kpps(!):
> > >
> > > Ethtool(ice0p1  ) stat:       679003 (        679,003) <=3D tx_bytes =
/sec
> > > Ethtool(ice0p1  ) stat:       721440 (        721,440) <=3D tx_bytes.=
nic /sec
> > > Ethtool(ice0p1  ) stat:       123539 (        123,539) <=3D tx_queue_=
0_bytes /sec
> > > Ethtool(ice0p1  ) stat:         1930 (          1,930) <=3D tx_queue_=
0_packets /sec
> > > Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_=
1_bytes /sec
> > > Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_=
1_packets /sec
> > > Ethtool(ice0p1  ) stat:         1837 (          1,837) <=3D tx_queue_=
2_bytes /sec
> > > Ethtool(ice0p1  ) stat:           29 (             29) <=3D tx_queue_=
2_packets /sec
> > > Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_=
3_bytes /sec
> > > Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_=
3_packets /sec
> > > Ethtool(ice0p1  ) stat:         1654 (          1,654) <=3D tx_queue_=
4_bytes /sec
> > > Ethtool(ice0p1  ) stat:           26 (             26) <=3D tx_queue_=
4_packets /sec
> > > Ethtool(ice0p1  ) stat:       222026 (        222,026) <=3D tx_queue_=
5_bytes /sec
> > > Ethtool(ice0p1  ) stat:         3469 (          3,469) <=3D tx_queue_=
5_packets /sec
> > > Ethtool(ice0p1  ) stat:       183072 (        183,072) <=3D tx_queue_=
6_bytes /sec
> > > Ethtool(ice0p1  ) stat:         2861 (          2,861) <=3D tx_queue_=
6_packets /sec
> > > Ethtool(ice0p1  ) stat:       143322 (        143,322) <=3D tx_queue_=
7_bytes /sec
> > > Ethtool(ice0p1  ) stat:         2239 (          2,239) <=3D tx_queue_=
7_packets /sec
> > > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_size_1=
27.nic /sec
> > > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicas=
t /sec
> > > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicas=
t.nic /sec
> > >
> > > Reverting commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption"=
)
> > > (and the followon f8a55d5e71e6 ("net: add a fast path in
> > > __netif_schedule()"), but that alone makes no difference) gets me bac=
k
> > > to the previous 630-650 Kpps range.
> > >
> > > I couldn't find any other qdisc that suffers in the same way (tried
> > > fq_codel, sfq and netem as single root qdiscs), so this seems to be s=
ome
> > > specific interaction between the llist implementation and sch_cake. A=
ny
> > > idea what could be causing this?
> >
> > I would take a look at full "tc -s -d qdisc" and see if anything
> > interesting is showing up (requeues ?)
> >
> > ALso look if you have drops (perf record -a -e skb:kfree_skb)
> >
> > You are sharing one qdisc on 8 queues ?

This might be something related to XDP, because I ran the following
test (IDPF, 32 TX queues)

tc qd replace dev eth1 root cake
./super_netperf 16 -H tjbp27 -t UDP_STREAM -l 1000 -- -m 64 -Nn &

Before my series : ~360 Kpps
After my series : ~550 Kpps

