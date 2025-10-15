Return-Path: <netdev+bounces-229798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A8BE0E34
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037A54E90B2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF0253B71;
	Wed, 15 Oct 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3HiREFP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B833086
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565634; cv=none; b=NY+sCEm69ndaJ2MNTyzHkHfaP2/0y0D2N5Fl5WG5SGOYMldrEv/p5idpRc+rVL7z8AE0Sv4tvJUjjsaMBLokIMgrH2GHqmUs4v48zD8C+Rj/qbUIiYV2idIldtRPyt4oMwCWCPfal3OrCDiZxpNxzzuQnTNJXi+VqBGlYj2PUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565634; c=relaxed/simple;
	bh=sBNT/ZJL3UJS59HYufpHQ3aOPRt/eMCT7ydwYQnOzEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBrSb4t7XnsmSdDquVp04N6wRT4+bc1mJWf1cruaVRjTtN0VcgdR+4FQWbXdlTzFEgp1Y8GILzI5rzpS4/fPubBhyFl3CVDniUKS9c10+viFJBDR+ygRFFtsT2gFMxl1CbbMUpiGTAyaYH4CQnAFZMbMKYmLz5f0R9TCa++Vy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3HiREFP8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29091d29fc8so734445ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760565632; x=1761170432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bxrYbA/aVh0ezEHvSBK0eCaN/Xx2Rs835EWBUCbM8k=;
        b=3HiREFP88aLRusegHjHX6WtffWgDjwsP/Dn6rLC8tJKKRkG0SWfVgCWwZab3JhRKxr
         Nd8ZHwul8ey49XmR7pJYYmFidnsfKjcCR0QVj8Ep/Gf3vQdN1q+v3u2eNPJS8cV+OlB6
         ozAgnsXOVVCIiB4jAwhc1R50TjOM9YNggh8RYTjtztXnWAuT9JkulIDbTKktt5JcU5TJ
         UB5lxqRy4hN9NLrvHBZFyYw9hgbH9GjZxXYlbYvckHGPRNxa/ZlR5/yVOOdQOWLH4+HI
         rFFjxckKdKEpMY0cHpUupMRZIUK5fnAi36Fr9pYxWHsK0n86XGtMXyJ7a+krA5mll5cE
         ny8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565632; x=1761170432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bxrYbA/aVh0ezEHvSBK0eCaN/Xx2Rs835EWBUCbM8k=;
        b=ji9E19sU1FF5obHezDCiWgvMAjLdAZoEwKT7NgI43VwarOFTjA6SL8s93PDEzQQ5iZ
         ZyncuKLFudzAnY2KRYNgLpYWyhANJY2Xeb5Q/X9Kbm1vZBV50hrlgRPu3+pq3kYhuzMV
         gocRBZSRgm/YHpAt3RYrQQdKYPX/omhBcNO7DqT7FCfq1ULm7piNAALOAt6NBTGOIqG8
         +lyhY6WVl7K9MtWw0yZLrNNNouulenVizghRUkpXQRjQYmqSAekCsPOOYzGA19DNncvZ
         XFFZHO7++VcYF0DIJ7Z/tVZw9IfNOyP8/rrcHmkGKNR9dofPf/pNKyMTIYTg8nuUX/v4
         WWEA==
X-Forwarded-Encrypted: i=1; AJvYcCWDrQKlGjFde7Ck4+k1Sb9CWFdhsJDZTQs3/x5heEEkIRJdpZ9OCPcJnqecFazequBVhI5hOJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPhRlnxeltB2sRXSQHW6EnVg6S4evXRpEo8UltrjiiWhaJdoC
	fvc65daFQu7Gw4tyngA+d/VN8EX8NQL96JsVwZWhV+vGRaiOy8mc/txqubcp9TwJ4Gwde3MTiYU
	pdNW0qg/8C6HWa4Q7F6iqVmdENBLT6ErLaE0yvOpX
X-Gm-Gg: ASbGnctLdIowuQCtJYaek8fWtlRBUg6Q7WM1RxpCifc3XV/TGzKvjHLuVcKTvzCt91r
	REBW007y4Nlr3d9u5RR1hlMaLPxcIjD1GlF1gXnC6rCQxe0AlDFZ+cKnSsViR3uJZziru78vT5H
	KrEFgU2WW2s8cM4ZaQ77n1do0F6VYC68LjoZD+BrAhzdvX8pNdJCv5kUbLdGm+xXgIb+aoCDuHA
	1rMZSs+Tx7omVynzn4CqGTfzI+GzO9FwYiEp9wHZZCVEuP0nukimqXCNSonGRLNSD57i3UWpn4V
	ZMjH32VE9U0HBijoq5ZVQqKT5K4BRqCHPLm0
X-Google-Smtp-Source: AGHT+IHRlV+MLyseGxUVQRMKzETHOpgwAcuG87f74U4jV5Y6r3+ySDjIi/KpY5XTjoj2kuKJ/aEinbvbKyRpq8/Ja0Y=
X-Received: by 2002:a17:903:2d2:b0:267:6754:8fd9 with SMTP id
 d9443c01a7336-290272c9322mr362529005ad.39.1760565631783; Wed, 15 Oct 2025
 15:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Oct 2025 18:00:20 -0400
X-Gm-Features: AS18NWDemmVexSlgj-cGOW3aTyGqdzwJ-k-4rkPbpwYJYpHRJgltJURxs43WJbA
Message-ID: <CAM0EoMnvMZQpjNP5vCneur8GR+3oW3PxvzjtthNjFTtLBF5GtA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/6] net: optimize TX throughput and efficiency
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In this series, I replace the busylock spinlock we have in
> __dev_queue_xmit() and use lockless list (llist) to reduce
> spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this series, we get a 300 % (4x) improvement on heavy TX workloads,
> sending twice the number of packets per second, for half the cpu cycles.
>

Not important but i am curious: you didnt mention what NIC this was in
the commit messages ;->

For the patchset, I have done testing with existing tdc tests and no
regression..
It does inspire new things when time becomes available.... so will be
doing more testing and likely small extensions etc.
So:
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
(For the tc bits, since the majority of the code touches tc related stuff)

cheers,
jamal


> v2: deflake tcp_user_timeout_user-timeout-probe.pkt.
>     Ability to return a different code than NET_XMIT_SUCCESS
>     when __dev_xmit_skb() has a single skb to send.
>
> Eric Dumazet (6):
>   selftests/net: packetdrill: unflake
>     tcp_user_timeout_user-timeout-probe.pkt
>   net: add add indirect call wrapper in skb_release_head_state()
>   net/sched: act_mirred: add loop detection
>   Revert "net/sched: Fix mirred deadlock on device recursion"
>   net: sched: claim one cache line in Qdisc
>   net: dev_queue_xmit() llist adoption
>
>  include/linux/netdevice_xmit.h                |  9 +-
>  include/net/sch_generic.h                     | 23 ++---
>  net/core/dev.c                                | 97 +++++++++++--------
>  net/core/skbuff.c                             | 11 ++-
>  net/sched/act_mirred.c                        | 62 +++++-------
>  net/sched/sch_generic.c                       |  7 --
>  .../tcp_user_timeout_user-timeout-probe.pkt   |  6 +-
>  7 files changed, 111 insertions(+), 104 deletions(-)
>
> --
> 2.51.0.788.g6d19910ace-goog
>

