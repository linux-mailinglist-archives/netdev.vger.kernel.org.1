Return-Path: <netdev+bounces-177555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AAA70894
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD61175F75
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48422263F3A;
	Tue, 25 Mar 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hRK/NU7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B9188A0C
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925267; cv=none; b=nvJd+KD0o9KAno2hEyvVHqgaeeNA74GxJb3SjTzXnILA5z8zwTqZuMRxUwgw7c+GnpbZD2cBDWEnuK6b0hI02Ur2Vh9M52ev/WfeT0C8M39M5Kd4jt1TU6lkCjWAkREf5Wqvw1g5POjmEhKlHZDCHWIUirp/STim7CZQDj0VVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925267; c=relaxed/simple;
	bh=1JhfSuiPQte1a1zNm8aXexWcglo8GCNvOeIC5bKHJPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlzTVwstCkLp6AATEQDsjSY8gh+mhMuxY+MJ6t324FSUqCEADya4R8gBUsPqjIjzACm2jH3+FYzwYyhtwirNAIFDArOE0AxJ6e4Ii5Bj9BBvWh0Zp5KdZBNcSv6PK7p8V6aY9lS9U11blZRaZ3FLaP05KTrLkAGgkd29r+iI/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hRK/NU7Z; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742925266; x=1774461266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fblqJ1pz/XHmKUMInh+XHC6b8yDLslicEfbeM3OwgdM=;
  b=hRK/NU7Z2ufUbk5SZ33BSuRZ6XKaTDoAvJJoAvs1JfMFYk8AfxyALKlC
   WFh76kXaCzc7g5qpPnseemZBWZxlCWVQpkqoS5g6ml2uNgzTdI9O5dPUS
   IEWm+bSP5l8W/c+1XbKVeysVxwJS6P4zYWaYtmcGC7Q38TZnt0BwfjnAd
   0=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="708069142"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 17:54:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:62589]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.254:2525] with esmtp (Farcaster)
 id 47f46f58-9e3d-4a0f-ab21-452cf9e75f82; Tue, 25 Mar 2025 17:54:21 +0000 (UTC)
X-Farcaster-Flow-ID: 47f46f58-9e3d-4a0f-ab21-452cf9e75f82
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 17:54:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 17:54:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Tue, 25 Mar 2025 10:53:57 -0700
Message-ID: <20250325175408.32112-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67e2bb367b235_3b4cd829495@willemb.c.googlers.com.notmuch>
References: <67e2bb367b235_3b4cd829495@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 25 Mar 2025 10:18:30 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Mon, 24 Mar 2025 15:44:40 -0400
> > > Kuniyuki Iwashima wrote:
> > > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Date: Mon, 24 Mar 2025 10:59:49 -0400
> > > > > Kuniyuki Iwashima wrote:
> > > > > > __udp_enqueue_schedule_skb() has the following condition:
> > > > > > 
> > > > > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > > > > >           goto drop;
> > > > > > 
> > > > > > sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> > > > > > be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> > > > > > or SO_RCVBUFFORCE.
> > > > > > 
> > > > > > If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> > > > > > as sk->sk_rmem_alloc is also signed int.
> > > > > > 
> > > > > > Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> > > > > > unconditionally.
> > > > > > 
> > > > > > This results in integer overflow (possibly multiple times) on
> > > > > > sk->sk_rmem_alloc and allows a single socket to have skb up to
> > > > > > net.core.udp_mem[1].
> > > > > > 
> > > > > > For example, if we set a large value to udp_mem[1] and INT_MAX to
> > > > > > sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> > > > > > overflows:
> > > > > > 
> > > > > >   # cat /proc/net/sockstat | grep UDP:
> > > > > >   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
> > > > > >                                              ^- PAGE_SHIFT
> > > > > >   # ss -uam
> > > > > >   State  Recv-Q      ...
> > > > > >   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
> > > > > >          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> > > > > > 
> > > > > > Previously, we had a boundary check for INT_MAX, which was removed by
> > > > > > commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> > > > > > 
> > > > > > A complete fix would be to revert it and cap the right operand by
> > > > > > INT_MAX:
> > > > > > 
> > > > > >   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> > > > > >   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
> > > > > >           goto uncharge_drop;
> > > > > > 
> > > > > > but we do not want to add the expensive atomic_add_return() back just
> > > > > > for the corner case.
> > > > > > 
> > > > > > So, let's perform the first check as unsigned int to detect the
> > > > > > integer overflow.
> > > > > > 
> > > > > > Note that we still allow a single wraparound, which can be observed
> > > > > > from userspace, but it's acceptable considering it's unlikely that
> > > > > > no recv() is called for a long period, and the negative value will
> > > > > > soon flip back to positive after a few recv() calls.
> > > > > 
> > > > > Can we do better than this?
> > > > 
> > > > Another approach I had in mind was to restore the original validation
> > > > under the recvq lock but without atomic ops like
> > > > 
> > > >   1. add another u32 as union of sk_rmem_alloc (only for UDP)
> > > >   2. access it with READ_ONCE() or under the recvq lock
> > > >   3. perform the validation under the lock
> > > > 
> > > > But it requires more changes around the error queue handling and
> > > > the general socket impl, so will be too invasive for net.git but
> > > > maybe worth a try for net-next ?
> > > 
> > > Definitely not net material. Adding more complexity here
> > > would also need some convincing benchmark data probably.
> > > 
> > > > 
> > > > > Is this because of the "Always allow at least one packet" below, and
> > > > > due to testing the value of the counter without skb->truesize added?
> > > > 
> > > > Yes, that's the reason although we don't receive a single >INT_MAX
> > > > packet.
> > > 
> > > I was surprised that we don't take the current skb size into
> > > account when doing this calculation.
> > > 
> > > Turns out that this code used to do that.
> > > 
> > > commit 363dc73acacb ("udp: be less conservative with sock rmem
> > > accounting") made this change:
> > > 
> > > -       if (rmem && (rmem + size > sk->sk_rcvbuf))
> > > +       if (rmem > sk->sk_rcvbuf)
> > >                 goto drop;
> > > 
> > > The special consideration to allow one packet is to avoid starvation
> > > with small rcvbuf, judging also from this review comment:
> > > 
> > > https://lore.kernel.org/netdev/1476938622.5650.111.camel@edumazet-glaptop3.roam.corp.google.com/
> > 
> > Interesting, thanks for the info !
> > 
> > Now it's allowed to exceed by the total size of the incoming skb
> > on every CPUs, and a user may notice that rmem > rcvbuf via ss,
> > but I guess it's allowed because the fast recovery is expected.
> > 
> > 
> > > 
> > > That clearly doesn't apply when rcvbuf is near INT_MAX.
> > > Can we separate the tiny budget case and hard drop including the
> > > skb->truesize for normal buffer sizes?
> > 
> > Maybe like this ?
> > 
> >         if (rcvbuf < UDP_MIN_RCVBUF) {
> >                 if (rmem > rcvbuf)
> >                         goto drop;
> >         } else {
> >                 if (rmem + size > rcvbuf)
> >                         goto drop;
> >         }
> > 
> > SOCK_MIN_RCVBUF is 2K + skb since 2013, but the regression was
> > reported after that in 2016, so UDP_MIN_RCVBUF would be more ?
> 
> Since the only issue is the overflow, could use a higher bound like
> INT_MAX >> 1.
>  
> > But I wonder if adding new branches in the fast path is worth for
> > the corner case, and that's why I chose integrating the cast into
> > the exisintg branch, allowing a small overflow, which is observable
> > only when no thread calls recv() and skbs are queued more than INT_MAX.
> 
> Okay. Though it can probably be structured that the likely path does
> not even see this?

Ah exactly, will use this and update commit message in v2.

Thanks!

> 
>     if (rmem + size > rcvbuf) {
>             if (rcvbuf > INT_MAX << 1)
>                     goto drop;
>             if (rmem > rcvbuf)
>                     goto drop;
>     }
> 

