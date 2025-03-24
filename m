Return-Path: <netdev+bounces-177211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B821A6E49B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D58316B563
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F101DC998;
	Mon, 24 Mar 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N6RroDFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2E1B0406
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849241; cv=none; b=QvQ5wyknGlIKhvBlCHbn5Ttuku/b1YWkMi4PH+yWERCS2pJD5AqeRCT/qgsc/ZXLgHJ4QpePmTW2tOjDOLZnvX1TKJ0yANdzdL8lwV2KBwMudnZ1Z8oRz4fdgzuHZleAMh4IoIkHbu1SLYW7+P/EFzOyAh8iXehZvY9Tv12xKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849241; c=relaxed/simple;
	bh=2ewnxVEGUfPsMZJJwJSin6l6tQAzJeo5ydHn0lCITwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pjx3SyusAiT8844l1s7pqR0WqEqexIwGCRaTgxT2JRokc2K5fhsa/lBA9WA4MPkA/aELPJWzyYpmzAMmPLsW643zPy8JDF7K36lxYtiR/g+LR+TgANe/GfSn+gakyHtyHIn1hZGNkupvCed8/2hugQTmW/650e578I8D4Q+mQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N6RroDFE; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742849240; x=1774385240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIysevyEJkEZYcgLNKlc1FMb0T+Yy75/Pdlz1NC/vak=;
  b=N6RroDFEQzjOvZ97l7GO2d1GakMQ2IO/BDHQICy6ViUusBIQnV++eCeZ
   a5q6xGAp3hS+cdzNpvIH4VvfI7Mr8vdgKfBxPNM8E2vU/3jS3XODiSKdr
   rxtkYGtIJLJK01pTgs/oXEE82/D2D6CW9vpU0uC+eAEPCqPJrtbscOxzV
   k=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="473963804"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 20:47:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32429]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.51:2525] with esmtp (Farcaster)
 id 9a8ba20b-6798-4c86-b8f0-7fa9808291da; Mon, 24 Mar 2025 20:47:12 +0000 (UTC)
X-Farcaster-Flow-ID: 9a8ba20b-6798-4c86-b8f0-7fa9808291da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 20:47:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 20:47:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Mon, 24 Mar 2025 13:46:50 -0700
Message-ID: <20250324204653.63879-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67e1b628df780_35010c2948d@willemb.c.googlers.com.notmuch>
References: <67e1b628df780_35010c2948d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 24 Mar 2025 15:44:40 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Mon, 24 Mar 2025 10:59:49 -0400
> > > Kuniyuki Iwashima wrote:
> > > > __udp_enqueue_schedule_skb() has the following condition:
> > > > 
> > > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > > >           goto drop;
> > > > 
> > > > sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> > > > be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> > > > or SO_RCVBUFFORCE.
> > > > 
> > > > If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> > > > as sk->sk_rmem_alloc is also signed int.
> > > > 
> > > > Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> > > > unconditionally.
> > > > 
> > > > This results in integer overflow (possibly multiple times) on
> > > > sk->sk_rmem_alloc and allows a single socket to have skb up to
> > > > net.core.udp_mem[1].
> > > > 
> > > > For example, if we set a large value to udp_mem[1] and INT_MAX to
> > > > sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> > > > overflows:
> > > > 
> > > >   # cat /proc/net/sockstat | grep UDP:
> > > >   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
> > > >                                              ^- PAGE_SHIFT
> > > >   # ss -uam
> > > >   State  Recv-Q      ...
> > > >   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
> > > >          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> > > > 
> > > > Previously, we had a boundary check for INT_MAX, which was removed by
> > > > commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> > > > 
> > > > A complete fix would be to revert it and cap the right operand by
> > > > INT_MAX:
> > > > 
> > > >   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> > > >   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
> > > >           goto uncharge_drop;
> > > > 
> > > > but we do not want to add the expensive atomic_add_return() back just
> > > > for the corner case.
> > > > 
> > > > So, let's perform the first check as unsigned int to detect the
> > > > integer overflow.
> > > > 
> > > > Note that we still allow a single wraparound, which can be observed
> > > > from userspace, but it's acceptable considering it's unlikely that
> > > > no recv() is called for a long period, and the negative value will
> > > > soon flip back to positive after a few recv() calls.
> > > 
> > > Can we do better than this?
> > 
> > Another approach I had in mind was to restore the original validation
> > under the recvq lock but without atomic ops like
> > 
> >   1. add another u32 as union of sk_rmem_alloc (only for UDP)
> >   2. access it with READ_ONCE() or under the recvq lock
> >   3. perform the validation under the lock
> > 
> > But it requires more changes around the error queue handling and
> > the general socket impl, so will be too invasive for net.git but
> > maybe worth a try for net-next ?
> 
> Definitely not net material. Adding more complexity here
> would also need some convincing benchmark data probably.
> 
> > 
> > > Is this because of the "Always allow at least one packet" below, and
> > > due to testing the value of the counter without skb->truesize added?
> > 
> > Yes, that's the reason although we don't receive a single >INT_MAX
> > packet.
> 
> I was surprised that we don't take the current skb size into
> account when doing this calculation.
> 
> Turns out that this code used to do that.
> 
> commit 363dc73acacb ("udp: be less conservative with sock rmem
> accounting") made this change:
> 
> -       if (rmem && (rmem + size > sk->sk_rcvbuf))
> +       if (rmem > sk->sk_rcvbuf)
>                 goto drop;
> 
> The special consideration to allow one packet is to avoid starvation
> with small rcvbuf, judging also from this review comment:
> 
> https://lore.kernel.org/netdev/1476938622.5650.111.camel@edumazet-glaptop3.roam.corp.google.com/

Interesting, thanks for the info !

Now it's allowed to exceed by the total size of the incoming skb
on every CPUs, and a user may notice that rmem > rcvbuf via ss,
but I guess it's allowed because the fast recovery is expected.


> 
> That clearly doesn't apply when rcvbuf is near INT_MAX.
> Can we separate the tiny budget case and hard drop including the
> skb->truesize for normal buffer sizes?

Maybe like this ?

        if (rcvbuf < UDP_MIN_RCVBUF) {
                if (rmem > rcvbuf)
                        goto drop;
        } else {
                if (rmem + size > rcvbuf)
                        goto drop;
        }

SOCK_MIN_RCVBUF is 2K + skb since 2013, but the regression was
reported after that in 2016, so UDP_MIN_RCVBUF would be more ?

But I wonder if adding new branches in the fast path is worth for
the corner case, and that's why I chose integrating the cast into
the exisintg branch, allowing a small overflow, which is observable
only when no thread calls recv() and skbs are queued more than INT_MAX.

