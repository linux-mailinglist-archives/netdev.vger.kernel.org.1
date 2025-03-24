Return-Path: <netdev+bounces-177164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5BA6E21A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF9F1889AF2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60A26158F;
	Mon, 24 Mar 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TlgwnjGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773E25F98B
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839895; cv=none; b=kBkhdN69LG3yok6/bOkORtLlgEtYUaC0P1vWL6QV9wSRVi51cipUrhnOyOpftd3Zz69hi7NY+IFGiz4hUZyAArPKnS9h7yGb32FOn6Chpt6V+CmYgJz2Si5n1c+hG9Xd43psKYWWja8TITfo/MfarQOZ5xjiXWzEyCjs7z8TFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839895; c=relaxed/simple;
	bh=rHVPwTXIsMCdF4jz9B5EwO02V5M64PFXDRUyRTwB1Do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZuNG7b8IxXyMSLI+S1Ycb5q51zp977ERdGhf1rSfQTofg6+4Io84Nb6RorRFv/hbibjTl2BCOgDYXmslUUUVDMndyEHxSgTeF013flbTR//22tK5qmFSJHWPK9UE3O9CLzyE12H+PNc9GRjba4dWHvUsSxX4F9aVKgRm8ALv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TlgwnjGL; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742839893; x=1774375893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYoCdVKGD2k3Wy4pO5dQ3L0eViP4doELj8FtJPWGmxA=;
  b=TlgwnjGLWpBRdLR6qoYMMYENH9IxeWXoXbfDPJ6iqMPlPHsABXJjPkoS
   xWaLHrpnobaAXUOceVMmU4tamA7Y/DT0PEWC/XUM+76mMWs4wjc5NTGsI
   M7VLUMkpPm7lEscfnRBDcegtHR5xMxFOJOcN8Zx7G1sKBSY6wyZ/OEJ+R
   4=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="729499545"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 18:11:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:13155]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.198:2525] with esmtp (Farcaster)
 id cb3a79cc-6993-468b-844f-e2e4fc54e9a3; Mon, 24 Mar 2025 18:11:29 +0000 (UTC)
X-Farcaster-Flow-ID: cb3a79cc-6993-468b-844f-e2e4fc54e9a3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:11:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:11:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Mon, 24 Mar 2025 11:10:45 -0700
Message-ID: <20250324181116.45359-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67e17365461e3_2f6623294ea@willemb.c.googlers.com.notmuch>
References: <67e17365461e3_2f6623294ea@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 24 Mar 2025 10:59:49 -0400
> Kuniyuki Iwashima wrote:
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
> 
> Can we do better than this?

Another approach I had in mind was to restore the original validation
under the recvq lock but without atomic ops like

  1. add another u32 as union of sk_rmem_alloc (only for UDP)
  2. access it with READ_ONCE() or under the recvq lock
  3. perform the validation under the lock

But it requires more changes around the error queue handling and
the general socket impl, so will be too invasive for net.git but
maybe worth a try for net-next ?


> Is this because of the "Always allow at least one packet" below, and
> due to testing the value of the counter without skb->truesize added?

Yes, that's the reason although we don't receive a single >INT_MAX
packet.


> 
>         /* Immediately drop when the receive queue is full.
>          * Always allow at least one packet.
>          */
>         rmem = atomic_read(&sk->sk_rmem_alloc);
>         rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>         if (rmem > rcvbuf)
>                 goto drop;

