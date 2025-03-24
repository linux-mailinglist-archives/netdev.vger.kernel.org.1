Return-Path: <netdev+bounces-177163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3174A6E20A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6946D1893C49
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F62264A67;
	Mon, 24 Mar 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K8cM5zQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4D3C17
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839281; cv=none; b=b9i+KOI8BQqGWguNG0VpMqQiYfjydJ1GK4M2I6jKThc3rvK9Ij/2ZiwAQuIGv51IHdaTAI2a95ytvG93nNKa/6mpJOBMtuk0NLsyp0cezRt+wHkj8TusbztAmXAaf/OC1uotfM64LBu5kY0O8HmoUYk+q3stURNVOUKM6okXDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839281; c=relaxed/simple;
	bh=fL0dQ+42oHQUj/UlKPWKcA56lOuyKNjgY16KdlKtKm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGVQ3P27rqmhM6pIgwtQV0/7Bwc51PyYu8ZPElL9ji1CkObzjuybdVQtlV8rFcTF5O84rQ6oB82S95GYkcrGgXNETsCaCGeVuCsOYUBson5B3yKbtiowmvgaAtYZCjAMAKqyToGxdoaF6q+N5Yttdg+Umw/UgHpfB46q2DFSq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K8cM5zQp; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742839280; x=1774375280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czvk6SxxVKkRI0A4BM66nFC/aKT0Ox1F7ndgIh5zSHo=;
  b=K8cM5zQp26fFIgKEQ5phJpFlbdYW+OTW/CPaB32pSxuI/fqeI4tcv7qR
   6iKy7kl2Kr8J/xLfRUpusI0pGh3qxq2YobwPo6qjVr81oyb17AmNUrlJT
   R+gQmW+D3DoCjjJ3HfLdVJUwlVQ7ki5juGe6E4pO4JSkelB2XYIErn8Sv
   8=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="389487797"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 18:01:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:48883]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id ea006d29-6c09-4685-8505-1961b2fd9e20; Mon, 24 Mar 2025 18:01:15 +0000 (UTC)
X-Farcaster-Flow-ID: ea006d29-6c09-4685-8505-1961b2fd9e20
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:01:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:01:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Mon, 24 Mar 2025 11:00:50 -0700
Message-ID: <20250324180056.41739-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANn89iLu=6jT_2xvOOzkzQJzXVDroJyiMKC2B83dAwycat2Lhg@mail.gmail.com>
References: <CANn89iLu=6jT_2xvOOzkzQJzXVDroJyiMKC2B83dAwycat2Lhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 11:01:15 +0100
> On Mon, Mar 24, 2025 at 12:11 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > __udp_enqueue_schedule_skb() has the following condition:
> >
> >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> >           goto drop;
> >
> > sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> > be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> > or SO_RCVBUFFORCE.
> >
> > If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> > as sk->sk_rmem_alloc is also signed int.
> >
> > Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> > unconditionally.
> >
> > This results in integer overflow (possibly multiple times) on
> > sk->sk_rmem_alloc and allows a single socket to have skb up to
> > net.core.udp_mem[1].
> >
> > For example, if we set a large value to udp_mem[1] and INT_MAX to
> > sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> > overflows:
> >
> >   # cat /proc/net/sockstat | grep UDP:
> >   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
> >                                              ^- PAGE_SHIFT
> >   # ss -uam
> >   State  Recv-Q      ...
> >   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
> >          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> >
> > Previously, we had a boundary check for INT_MAX, which was removed by
> > commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> >
> > A complete fix would be to revert it and cap the right operand by
> > INT_MAX:
> >
> >   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> >   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
> >           goto uncharge_drop;
> >
> > but we do not want to add the expensive atomic_add_return() back just
> > for the corner case.
> >
> > So, let's perform the first check as unsigned int to detect the
> > integer overflow.
> >
> > Note that we still allow a single wraparound, which can be observed
> > from userspace, but it's acceptable considering it's unlikely that
> > no recv() is called for a long period, and the negative value will
> > soon flip back to positive after a few recv() calls.
> >
> >   # cat /proc/net/sockstat | grep UDP:
> >   UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12
> >
> >   # ss -uam
> >   State  Recv-Q      ...
> >   UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
> >          skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d14468947)
> >
> > Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/udp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index a9bb9ce5438e..a1e60aab29b5 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1735,7 +1735,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >          */
> >         rmem = atomic_read(&sk->sk_rmem_alloc);
> >         rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> > -       if (rmem > rcvbuf)
> > +       if ((unsigned int)rmem > rcvbuf)
> 
> SGTM, but maybe make rmem and rcvbuf  'unsigned int ' to avoid casts ?

That's cleaner.  I'll add a small comment above the comparison
not to lose the boundary check by defining these two as int in
the future.


> 
> BTW piling 2GB worth of skbs in a single UDP receive queue means a
> latency spike when
> __skb_queue_purge(&sk->sk_receive_queue) is called, say from
> inet_sock_destruct(),
> which is a problem on its own.

Yes, we need to improve our application a lot :)

Thanks!

> 
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index db606f7e4163809d8220be1c1a4adb5662fc914e..575baac391e8af911fc1eff3f2d8e64bb9aa4c70
> 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1725,9 +1725,9 @@ static int udp_rmem_schedule(struct sock *sk, int size)
>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  {
>         struct sk_buff_head *list = &sk->sk_receive_queue;
> -       int rmem, err = -ENOMEM;
> +       unsigned int rmem, rcvbuf;
> +       int size, err = -ENOMEM;
>         spinlock_t *busy = NULL;
> -       int size, rcvbuf;
> 
>         /* Immediately drop when the receive queue is full.
>          * Always allow at least one packet.
> 

