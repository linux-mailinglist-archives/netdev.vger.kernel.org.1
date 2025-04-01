Return-Path: <netdev+bounces-178671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E7A78268
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD1B3A8D08
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694C20E708;
	Tue,  1 Apr 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jLa5L0EG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E420D4F8
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533140; cv=none; b=MIVg9hfzJQ93ROUgP5sUVdwb4dESP/diF3imbYqwakuhzos39qwZtALsMF+cZk2K/KwUHMPa2YoBzjMUAk8gLyMP9xP19kiij3ATj+1JPRVzq/08cxqAxnDg5jaVZxT5qtEeSxAWTbmooifV6IL0osblvmMLK9cP+EFOztIVBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533140; c=relaxed/simple;
	bh=0/+NsGaA4UJN8Idac/wNUP+ElqPUA4eSJ4a6DUwjddI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4n24cHVUGVgR9mITHUQhzYrJfvShealMTgd68IEpubfNSLVLUowVwedRYB+aYqu6BY9ltd+rvmDFa+DIe0T27OW49i5Iovn/4R9XWls0oyDCnK0NE6PteSrgmI93+cDCjyFjzj4wAY0Pku5gE5XS2hP+PG4ZoID/fFqmTcHCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jLa5L0EG; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743533139; x=1775069139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM8vc23pEVfCbMV92Jd/3+cBhw6BiCwxAkEnLyrSACY=;
  b=jLa5L0EGq6LeGWy+MIj5KoZN4N58uYMB0ZF5rkoDEhVISSu2FmzL6KL6
   FGstAidDzZInRV+zZ4+kdqhoKAFnfqIu13ja+UuAj7dkcbLnKJffYGe8e
   T/JbBp/UdDVUnITV/Dfpcg0FNBkpnlfOJIwjAx40tIEwHbf6DfgPjPpNi
   A=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="37129533"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 18:45:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:37942]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.16:2525] with esmtp (Farcaster)
 id 18501e4e-4792-4876-bd5c-15bb09ed66fb; Tue, 1 Apr 2025 18:45:37 +0000 (UTC)
X-Farcaster-Flow-ID: 18501e4e-4792-4876-bd5c-15bb09ed66fb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:45:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:45:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Willem de
 Bruijn" <willemb@google.com>
Subject: [PATCH v5 net 1/2] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Tue, 1 Apr 2025 11:44:42 -0700
Message-ID: <20250401184501.67377-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401184501.67377-1-kuniyu@amazon.com>
References: <20250401184501.67377-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
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

Casting rmem to unsigned int prevents multiple wraparounds, but we still
allow a single wraparound.

  # cat /proc/net/sockstat | grep UDP:
  UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12

  # ss -uam
  State  Recv-Q      ...
  UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
         skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d14468947)

So, let's define rmem and rcvbuf as unsigned int and check skb->truesize
only when rcvbuf is large enough to lower the overflow possibility.

Note that we still have a small chance to see overflow if multiple skbs
to the same socket are processed on different core at the same time and
each size does not exceed the limit but the total size does.

Note also that we must ignore skb->truesize for a small buffer as
explained in commit 363dc73acacb ("udp: be less conservative with
sock rmem accounting").

Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v5:
  * Update size after skb_condense()

v2:
  * Define rmem and rcvbuf as unsigned int
  * Take skb->truesize into account for the large rcvbuf case
---
 net/ipv4/udp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..354779b22faf 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1725,17 +1725,25 @@ static int udp_rmem_schedule(struct sock *sk, int size)
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
-	int rmem, err = -ENOMEM;
+	unsigned int rmem, rcvbuf;
 	spinlock_t *busy = NULL;
-	int size, rcvbuf;
+	int size, err = -ENOMEM;
 
-	/* Immediately drop when the receive queue is full.
-	 * Always allow at least one packet.
-	 */
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (rmem > rcvbuf)
-		goto drop;
+	size = skb->truesize;
+
+	/* Immediately drop when the receive queue is full.
+	 * Cast to unsigned int performs the boundary check for INT_MAX.
+	 */
+	if (rmem + size > rcvbuf) {
+		if (rcvbuf > INT_MAX >> 1)
+			goto drop;
+
+		/* Always allow at least one packet for small buffer. */
+		if (rmem > rcvbuf)
+			goto drop;
+	}
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
 	 * having linear skbs :
@@ -1745,10 +1753,10 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (rmem > (rcvbuf >> 1)) {
 		skb_condense(skb);
-
+		size = skb->truesize;
 		busy = busylock_acquire(sk);
 	}
-	size = skb->truesize;
+
 	udp_set_dev_scratch(skb);
 
 	atomic_add(size, &sk->sk_rmem_alloc);
-- 
2.48.1


