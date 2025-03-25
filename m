Return-Path: <netdev+bounces-177587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A6A70ADE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E997A621F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D9D1F1913;
	Tue, 25 Mar 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UYY8v9Mk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEE23A560
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932760; cv=none; b=IH2owxpl+Mgv6qJ9bnzvapS9FNNQFxXGEyx1eE/DwQgbD0u9WXi/DO6e7bv+QjcCbqAI1bhjYb8G2o4+QQKNOG3UYVmwGBgpKNzdJg8sN35/k3r89RJcYzy5yV4MuM3MhTpQRFNxlbQ1fw70N6jBV4hqn4OVETMqvwejsU7iz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932760; c=relaxed/simple;
	bh=yTQDVK8rq0WUWlQAUKORTPi2y5nZHMvP0nbol2f6DkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLn0kB6+kvRrE+Jz14K+pWMxD7DZ8+5i7ocSzh5negn8/E4v90/Hiv53xyeWBxK56yJeCTocrPlLvQHsRUhm7WhbxI/6BE29JxGGlXbICXHJpcgT6WAeP7w+RJeAqTKwajHSyqkhEpCHLAwp9EwrPJR/yIr5B0pKqNRfb/fvHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UYY8v9Mk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742932759; x=1774468759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrtSxCmmwn1oJrlLMBq25QX/HcBG97AR6KlmKlaZROQ=;
  b=UYY8v9Mkc66/Fy+FTWQ0VJmtH+IEj1lFlcAYYzBOKBwPAWAqSg/XsV8p
   IKO4xfk56mkGr1Tr+ZrgRPbR2siVAje0x6BgY1gLAEmOFyQ/uPp2I5I0d
   OM5a9G5GVGxQVzmqWq7Tz2244PBjrUf1GkEH1dEoSNs9v35B8u8BJ24vH
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="77610092"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 19:59:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:34798]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.51:2525] with esmtp (Farcaster)
 id 983e86c8-7f98-4291-b632-5f2a0bf065fd; Tue, 25 Mar 2025 19:59:12 +0000 (UTC)
X-Farcaster-Flow-ID: 983e86c8-7f98-4291-b632-5f2a0bf065fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
Date: Tue, 25 Mar 2025 12:58:13 -0700
Message-ID: <20250325195826.52385-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325195826.52385-1-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
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
---
v2:
  * Define rmem and rcvbuf as unsigned int
  * Take skb->truesize into account for the large rcvbuf case
---
 net/ipv4/udp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438e..4499e1fe4d50 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1726,17 +1726,25 @@ static int udp_rmem_schedule(struct sock *sk, int size)
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
@@ -1749,7 +1757,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 
 		busy = busylock_acquire(sk);
 	}
-	size = skb->truesize;
+
 	udp_set_dev_scratch(skb);
 
 	atomic_add(size, &sk->sk_rmem_alloc);
-- 
2.48.1


