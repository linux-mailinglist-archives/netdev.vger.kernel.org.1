Return-Path: <netdev+bounces-236845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC75C40A74
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C08034F2AC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D433016E8;
	Fri,  7 Nov 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nN6JXYfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC02C2369
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530377; cv=none; b=ZD4hGnNgjGZ9VsNKAozxUGMRlSBs0M9X8FjQKPHm6FjB6bY5gmsLD6BLQH0654lz4W7MYm4fqK58Zg9yQSqcOqAVp7QVjLKxYlrWVY4olpGemGddLAGwtOv1aY3UuE/dQq2aP7+gcq+6r+iJZX0jLkq57zUH3dzzFy0PT7N2kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530377; c=relaxed/simple;
	bh=AIekf4cKOjrujJFSERZNBkCdVXTGaZz6CyfXde4Y8nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC68AjTVzu2UqANGQVE/N0VNAPSntyjuY1r1B47/7D0SBEC3YYohTRrs65X3UIGxDE6Eo2eKHfrKssCi/EnNjsjVDOhtf3L0NM9UrTyh/qeUFKkNVNet+OFcj4iJa7iGJY9yiLtlXKNga+e+moUMnzJY3fBvE9Ao0f0OoRpQb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nN6JXYfD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87bb66dd224so10171996d6.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762530375; x=1763135175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmFKfcAXka27qOJswJYQHivunF6dOITkjwuMJ+EktRs=;
        b=nN6JXYfDD4M2WdT6hEwQKdJUvRtE31LRoC+TY+qKLPTj3bKhWAyk++aC6mhAFNOVNw
         Evp+WzH+t/JHKCHtrHJjXHCkvXqrwOCR6zoJ8Q4aXJ6plPz3JKklbbgyMn41z15MnpvW
         Ihzpnd2g+uvAsLvADunKgioLrSFBF5GZJjOmE4HKIQHU+DiFP+YmjUdErWS3GA6HxOwQ
         PNViiKcvBkvB6R811GVRaau5HFt6mR3QSjI/u3a0gBZmoChwUBFuZSdlZ2Hu2CcXs0HP
         WnyIWXXJrnACtjUsKOGX+DL/YYW5uA6lvQteNy0hnHrVRsMQSUbnLyIMnb3scpuN6OH0
         iw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530375; x=1763135175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmFKfcAXka27qOJswJYQHivunF6dOITkjwuMJ+EktRs=;
        b=HJBnayUse065zMywus2o3kCKq5DI33oLj8HS3yMykRf2c5nfpR5IAROOGtln9U92P5
         3avccv7h3HsqmKvhEaUFOZDlVbdaDxuVGMGsKfJSzz6w9AJXSH35ujUgE3dwHqZEuWF9
         CWs/ntaatLzA2VZIeWE9d2lqiVnXgrkkT6iMzgsMKXBaQfTq/JzKdLejR1EsIDAbbChE
         pJ5aJOgW1DdnBl+gH+TpBpoXeDPHruSL+UlIC2DDRMzGGxdXf13sGYqgpqB+SF2tAdmr
         Mn59rAqjRrLXxA5Z1YGiSzmCmPIog63VxLcPR20l6OqJQV0xkOjVZnxe7B6ObhRRjmw1
         zvqw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1uXqXl6BvSNrQ9rPnr/vSQil/ouqcvIq56ZuDDethd9swkwj3ztOjM7nfUwyesdLnGuT+Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9UTRdI/orWdI761zKFwHoHQJYvfsjPqUNvWmQ2fWae7tvQcJ
	QsryWqJ4XOYhCjJGfChBOjHEgIt50jaTSMMNvk+hPiV9e6EF00YG0nIJ5S6dAfjTbwqLghdAzNh
	z0vM4+VWAMrmZEK4YZEJALiC58CzxwpBRQC/PdDNe
X-Gm-Gg: ASbGncu240p8emvzMLlpWX0xu/m1c2vDR2Oewz60hQ7dQsy3DrcguknZjWQeI4nq8YA
	gvSXAKNmKIkR5snfuQSd3EOCEZvp1Y619kqcTMji3mid5MqlzQ978xTsfxDVrZ0O2PWRXRjUBIx
	AtEQSa/BBonh/0AG5vbFheSsmoSCdlnYeOuoeG/vbivImJp3P1VFxGBRNekTAJFWrGSIwJGIxZx
	nx15RO6Z7B8J3JyVmgZrw+n5V3aTLk0YtSAOmbouwiLOt7yOhi7cWk2vUMC
X-Google-Smtp-Source: AGHT+IEie9Qk1ci1n+OEznH44DBqofYkezo9/GlpKHgDD0O9plkCz4O4c3lOpXdFbEo7OuJN+BxI9myO8aAXIPIJ6Q4=
X-Received: by 2002:a05:6214:1d2c:b0:87d:e32:81c4 with SMTP id
 6a1803df08f44-88176762888mr46388566d6.48.1762530374483; Fri, 07 Nov 2025
 07:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
In-Reply-To: <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 07:46:03 -0800
X-Gm-Features: AWmQ_bkBvkTEQzWVbsQPEmdzIUaSBZARQ7B2FlavtGDeMkEAbPzh0rIm7TRyKRg
Message-ID: <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Nov 7, 2025 at 7:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >
> > Eric Dumazet <edumazet@google.com> writes:
> >
> > > Remove busylock spinlock and use a lockless list (llist)
> > > to reduce spinlock contention to the minimum.
> > >
> > > Idea is that only one cpu might spin on the qdisc spinlock,
> > > while others simply add their skb in the llist.
> > >
> > > After this patch, we get a 300 % improvement on heavy TX workloads.
> > > - Sending twice the number of packets per second.
> > > - While consuming 50 % less cycles.
> > >
> > > Note that this also allows in the future to submit batches
> > > to various qdisc->enqueue() methods.
> > >
> > > Tested:
> > >
> > > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> > > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> > > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid cont=
ention in mm)
> > > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
> >
> > Hi Eric
> >
> > While testing this with sch_cake (to get a new baseline for the mq_cake
> > patches as Jamal suggested), I found that this patch completely destroy=
s
> > the performance of cake in particular.
> >
> > I run a small UDP test (64-byte packets across 16 flows through
> > xdp-trafficgen, offered load is ~5Mpps) with a single cake instance on
> > as the root interface qdisc.
> >
> > With a stock Fedora (6.17.7) kernel, this gets me around 630 Kpps acros=
s
> > 8 queues (on an E810-C, ice driver):
> >
> > Ethtool(ice0p1  ) stat:     40321218 (     40,321,218) <=3D tx_bytes /s=
ec
> > Ethtool(ice0p1  ) stat:     42841424 (     42,841,424) <=3D tx_bytes.ni=
c /sec
> > Ethtool(ice0p1  ) stat:      5248505 (      5,248,505) <=3D tx_queue_0_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82008 (         82,008) <=3D tx_queue_0_=
packets /sec
> > Ethtool(ice0p1  ) stat:      3425984 (      3,425,984) <=3D tx_queue_1_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        53531 (         53,531) <=3D tx_queue_1_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5277496 (      5,277,496) <=3D tx_queue_2_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82461 (         82,461) <=3D tx_queue_2_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5285736 (      5,285,736) <=3D tx_queue_3_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82590 (         82,590) <=3D tx_queue_3_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5280731 (      5,280,731) <=3D tx_queue_4_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82511 (         82,511) <=3D tx_queue_4_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5275665 (      5,275,665) <=3D tx_queue_5_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82432 (         82,432) <=3D tx_queue_5_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5276398 (      5,276,398) <=3D tx_queue_6_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82444 (         82,444) <=3D tx_queue_6_=
packets /sec
> > Ethtool(ice0p1  ) stat:      5250946 (      5,250,946) <=3D tx_queue_7_=
bytes /sec
> > Ethtool(ice0p1  ) stat:        82046 (         82,046) <=3D tx_queue_7_=
packets /sec
> > Ethtool(ice0p1  ) stat:            1 (              1) <=3D tx_restart =
/sec
> > Ethtool(ice0p1  ) stat:       630023 (        630,023) <=3D tx_size_127=
.nic /sec
> > Ethtool(ice0p1  ) stat:       630019 (        630,019) <=3D tx_unicast =
/sec
> > Ethtool(ice0p1  ) stat:       630020 (        630,020) <=3D tx_unicast.=
nic /sec
> >
> > However, running the same test on a net-next kernel, performance drops
> > to round 10 Kpps(!):
> >
> > Ethtool(ice0p1  ) stat:       679003 (        679,003) <=3D tx_bytes /s=
ec
> > Ethtool(ice0p1  ) stat:       721440 (        721,440) <=3D tx_bytes.ni=
c /sec
> > Ethtool(ice0p1  ) stat:       123539 (        123,539) <=3D tx_queue_0_=
bytes /sec
> > Ethtool(ice0p1  ) stat:         1930 (          1,930) <=3D tx_queue_0_=
packets /sec
> > Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_1_=
bytes /sec
> > Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_1_=
packets /sec
> > Ethtool(ice0p1  ) stat:         1837 (          1,837) <=3D tx_queue_2_=
bytes /sec
> > Ethtool(ice0p1  ) stat:           29 (             29) <=3D tx_queue_2_=
packets /sec
> > Ethtool(ice0p1  ) stat:         1776 (          1,776) <=3D tx_queue_3_=
bytes /sec
> > Ethtool(ice0p1  ) stat:           28 (             28) <=3D tx_queue_3_=
packets /sec
> > Ethtool(ice0p1  ) stat:         1654 (          1,654) <=3D tx_queue_4_=
bytes /sec
> > Ethtool(ice0p1  ) stat:           26 (             26) <=3D tx_queue_4_=
packets /sec
> > Ethtool(ice0p1  ) stat:       222026 (        222,026) <=3D tx_queue_5_=
bytes /sec
> > Ethtool(ice0p1  ) stat:         3469 (          3,469) <=3D tx_queue_5_=
packets /sec
> > Ethtool(ice0p1  ) stat:       183072 (        183,072) <=3D tx_queue_6_=
bytes /sec
> > Ethtool(ice0p1  ) stat:         2861 (          2,861) <=3D tx_queue_6_=
packets /sec
> > Ethtool(ice0p1  ) stat:       143322 (        143,322) <=3D tx_queue_7_=
bytes /sec
> > Ethtool(ice0p1  ) stat:         2239 (          2,239) <=3D tx_queue_7_=
packets /sec
> > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_size_127=
.nic /sec
> > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicast =
/sec
> > Ethtool(ice0p1  ) stat:        10609 (         10,609) <=3D tx_unicast.=
nic /sec
> >
> > Reverting commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
> > (and the followon f8a55d5e71e6 ("net: add a fast path in
> > __netif_schedule()"), but that alone makes no difference) gets me back
> > to the previous 630-650 Kpps range.
> >
> > I couldn't find any other qdisc that suffers in the same way (tried
> > fq_codel, sfq and netem as single root qdiscs), so this seems to be som=
e
> > specific interaction between the llist implementation and sch_cake. Any
> > idea what could be causing this?
>
> I would take a look at full "tc -s -d qdisc" and see if anything
> interesting is showing up (requeues ?)
>
> ALso look if you have drops (perf record -a -e skb:kfree_skb)
>
> You are sharing one qdisc on 8 queues ?

I also assume you are running net-next, because final patch was a bit diffe=
rent

int count =3D 0;

llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
    prefetch(next);
    skb_mark_not_on_list(skb);
    rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
    count++;
}
qdisc_run(q);
if (count !=3D 1)
    rc =3D NET_XMIT_SUCCESS;

