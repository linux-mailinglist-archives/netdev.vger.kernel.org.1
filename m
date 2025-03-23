Return-Path: <netdev+bounces-176984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F81A6D274
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5E3B0DA3
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD21A257D;
	Sun, 23 Mar 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CclVB/OF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27500291E
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742771467; cv=none; b=m+ESIVTYsCjJ07sh7VMXV7hFCl4iZBBhNoiLg2TNWhGm1tfs44pYHSQs+6R5/ITic37ZiFSiTC+U3FFXNK0B/gMbQN0h/XhWRLCrMzKMytJZPCSN1Y2Hx8hpOOKzqGwrq9M5eLIkIqmk1l0uK2gMXK0iTqEzd6piJ/AqwTNhTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742771467; c=relaxed/simple;
	bh=YO0y6qkTAi1GNwLTfKFcl8ReSX/2erhY2bXykImWRA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsC+qYFTM9sumhOOb+tZkjeqFyLjZKNsKYVwf3WpuR7rSBMw9Ua2QdEjVcTdqTK2iY3LpIU29+k/CWXms4SfbhCgzg0AR6eSbdb+VVktsVAh3fSHkqNBRyypJdAcImE4gZccLvdkZCAIm2h6i9EvhEiX6+bT/uWxC+jus5+l7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CclVB/OF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742771465; x=1774307465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsIhYnowrU82A2CA7uOolNoHygEqtcXHbcb39q+Ad1w=;
  b=CclVB/OFSjaRrJgWf41KhJyEeVELgCcHxzRyXaDw+bkgbGwhKRSrhnQ4
   Rsphcin/c7W3dQw1cL8mZpfP/n5V+Yghff2NiJbUVsAhU5poRtiRA4+Zb
   DqmBlW0lD+Sqrz/qPwrT1v+kAoCGT3MpmcWkODOpIU6b4NpYzur4bucCL
   U=;
X-IronPort-AV: E=Sophos;i="6.14,271,1736812800"; 
   d="scan'208";a="505236508"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:10:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:61874]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.118:2525] with esmtp (Farcaster)
 id 79ade085-9d1d-42f8-b89e-74ca1dc40abe; Sun, 23 Mar 2025 23:10:57 +0000 (UTC)
X-Farcaster-Flow-ID: 79ade085-9d1d-42f8-b89e-74ca1dc40abe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:10:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:10:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Sun, 23 Mar 2025 16:09:50 -0700
Message-ID: <20250323231016.74813-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250323231016.74813-1-kuniyu@amazon.com>
References: <20250323231016.74813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__udp_enqueue_schedule_skb() has the following condition:

  if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
          goto drop;

sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
or SO_RCVBUFFORCE.

If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
as sk->sk_rmem_alloc is also signed int.

Then, the size of the incoming skb is added to sk->sk_rmem_alloc
unconditionally.

This results in integer overflow (possibly multiple times) on
sk->sk_rmem_alloc and allows a single socket to have skb up to
net.core.udp_mem[1].

For example, if we set a large value to udp_mem[1] and INT_MAX to
sk->sk_rcvbuf and flood packets to the socket, we can see multiple
overflows:

  # cat /proc/net/sockstat | grep UDP:
  UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
                                             ^- PAGE_SHIFT
  # ss -uam
  State  Recv-Q      ...
  UNCONN -1757018048 ...    <-- flipping the sign repeatedly
         skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)

Previously, we had a boundary check for INT_MAX, which was removed by
commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").

A complete fix would be to revert it and cap the right operand by
INT_MAX:

  rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
  if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
          goto uncharge_drop;

but we do not want to add the expensive atomic_add_return() back just
for the corner case.

So, let's perform the first check as unsigned int to detect the
integer overflow.

Note that we still allow a single wraparound, which can be observed
from userspace, but it's acceptable considering it's unlikely that
no recv() is called for a long period, and the negative value will
soon flip back to positive after a few recv() calls.

  # cat /proc/net/sockstat | grep UDP:
  UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12

  # ss -uam
  State  Recv-Q      ...
  UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
         skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d14468947)

Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438e..a1e60aab29b5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1735,7 +1735,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (rmem > rcvbuf)
+	if ((unsigned int)rmem > rcvbuf)
 		goto drop;
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
-- 
2.48.1


