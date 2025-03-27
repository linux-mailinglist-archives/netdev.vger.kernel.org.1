Return-Path: <netdev+bounces-178010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E69A73F50
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA2E1681C1
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05821C84B7;
	Thu, 27 Mar 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qWifcLuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71362914
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107309; cv=none; b=pyLwNTLney8pq/64mvdiFwbyJHvd7LpO/eCWhz4srOYpikeidwvojzwNZriE8oi0s6LnjXaPDPyXCHE9wWR7Ox29kd350r4uY+rGVwxH65XFNuxOvJNm0JYppNsG4GApZqFdp95xEjM/cdiiPBawBgA8ft0ET9xiO3F6byOSbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107309; c=relaxed/simple;
	bh=MypUqbd7zL8VytGIcDRdqVtFBDqsQaC2BrZwIQGaco8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9Z5s9szFbgTrtg28Unpblq2qPULNruRtm1jiEc3xVD7IuDZR4+3wI2KM50JaAsGO+sfq2TV5RS0ohcrPOb84BwwXmL+J34WgCmXnwOkXaGqkKGzpnb7hpLIvwDt6FPHRoUrXeGWZ4qi+PwRw/RM43b7PdyWiEbBXN6zmhmrQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qWifcLuE; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743107308; x=1774643308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VC2g13Ipoe2uJ5zhKmT0DVa9vfg/vOb3ZKXTV4HbCE0=;
  b=qWifcLuEAN7Rbgg+HVkBUjYjTY/AN59WxzzklpOBhiOhAFQ6Zo+q4E9U
   L+5jF59bvfsRT5r25aEtJ1Bt1V2zmBirRDui8p/ulXzL5UAKLz4YArXuI
   ZbCOSwyr5gxUVWsPxinRKIteRFh7yReRmqNsetkvVy/ztNSLD6wqTtKJR
   U=;
X-IronPort-AV: E=Sophos;i="6.14,281,1736812800"; 
   d="scan'208";a="78353977"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 20:28:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:50163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.60:2525] with esmtp (Farcaster)
 id 944f351b-8a16-460f-b948-469d01a93722; Thu, 27 Mar 2025 20:28:24 +0000 (UTC)
X-Farcaster-Flow-ID: 944f351b-8a16-460f-b948-469d01a93722
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:28:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:28:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Matt
 Dowling" <madowlin@amazon.com>, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v3 net 2/3] udp: Fix memory accounting leak.
Date: Thu, 27 Mar 2025 13:26:54 -0700
Message-ID: <20250327202722.63756-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327202722.63756-1-kuniyu@amazon.com>
References: <20250327202722.63756-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Matt Dowling reported a weird UDP memory usage issue.

Under normal operation, the UDP memory usage reported in /proc/net/sockstat
remains close to zero.  However, it occasionally spiked to 524,288 pages
and never dropped.  Moreover, the value doubled when the application was
terminated.  Finally, it caused intermittent packet drops.

We can reproduce the issue with the script below [0]:

  1. /proc/net/sockstat reports 0 pages

    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 0

  2. Run the script till the report reaches 524,288

    # python3 test.py & sleep 5
    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> PAGE_SHIFT

  3. Kill the socket and confirm the number never drops

    # pkill python3 && sleep 5
    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 524288

  4. (necessary since v6.0) Trigger proto_memory_pcpu_drain()

    # python3 test.py & sleep 1 && pkill python3

  5. The number doubles

    # cat /proc/net/sockstat | grep UDP:
    UDP: inuse 1 mem 1048577

The application set INT_MAX to SO_RCVBUF, which triggered an integer
overflow in udp_rmem_release().

When a socket is close()d, udp_destruct_common() purges its receive
queue and sums up skb->truesize in the queue.  This total is calculated
and stored in a local unsigned integer variable.

The total size is then passed to udp_rmem_release() to adjust memory
accounting.  However, because the function takes a signed integer
argument, the total size can wrap around, causing an overflow.

Then, the released amount is calculated as follows:

  1) Add size to sk->sk_forward_alloc.
  2) Round down sk->sk_forward_alloc to the nearest lower multiple of
      PAGE_SIZE and assign it to amount.
  3) Subtract amount from sk->sk_forward_alloc.
  4) Pass amount >> PAGE_SHIFT to __sk_mem_reduce_allocated().

When the issue occurred, the total in udp_destruct_common() was 2147484480
(INT_MAX + 833), which was cast to -2147482816 in udp_rmem_release().

At 1) sk->sk_forward_alloc is changed from 3264 to -2147479552, and
2) sets -2147479552 to amount.  3) reverts the wraparound, so we don't
see a warning in inet_sock_destruct().  However, udp_memory_allocated
ends up doubling at 4).

Since commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
memory_allocated"), memory usage no longer doubles immediately after
a socket is close()d because __sk_mem_reduce_allocated() caches the
amount in udp_memory_per_cpu_fw_alloc.  However, the next time a UDP
socket receives a packet, the subtraction takes effect, causing UDP
memory usage to double.

This issue makes further memory allocation fail once the socket's
sk->sk_rmem_alloc exceeds net.ipv4.udp_rmem_min, resulting in packet
drops.

To prevent this issue, let's use unsigned int for the calculation and
call sk_forward_alloc_add() only once for the small delta.

Note that first_packet_length() also potentially has the same problem.

[0]:
from socket import *

SO_RCVBUFFORCE = 33
INT_MAX = (2 ** 31) - 1

s = socket(AF_INET, SOCK_DGRAM)
s.bind(('', 0))
s.setsockopt(SOL_SOCKET, SO_RCVBUFFORCE, INT_MAX)

c = socket(AF_INET, SOCK_DGRAM)
c.connect(s.getsockname())

data = b'a' * 100

while True:
    c.send(data)

Fixes: f970bd9e3a06 ("udp: implement memory accounting helpers")
Reported-by: Matt Dowling <madowlin@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 07aa5db78c55..b7d03b0b4a07 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1625,12 +1625,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
 }
 
 /* fully reclaim rmem/fwd memory allocated for skb */
-static void udp_rmem_release(struct sock *sk, int size, int partial,
-			     bool rx_queue_lock_held)
+static void udp_rmem_release(struct sock *sk, unsigned int size,
+			     int partial, bool rx_queue_lock_held)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct sk_buff_head *sk_queue;
-	int amt;
+	unsigned int amt;
 
 	if (likely(partial)) {
 		up->forward_deficit += size;
@@ -1650,10 +1650,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
 
-
-	sk_forward_alloc_add(sk, size);
-	amt = (sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
-	sk_forward_alloc_add(sk, -amt);
+	amt = (size + sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(sk, size - amt);
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> PAGE_SHIFT);
@@ -1843,7 +1841,7 @@ EXPORT_IPV6_MOD_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1876,8 +1874,8 @@ static int first_packet_length(struct sock *sk)
 {
 	struct sk_buff_head *rcvq = &udp_sk(sk)->reader_queue;
 	struct sk_buff_head *sk_queue = &sk->sk_receive_queue;
+	unsigned int total = 0;
 	struct sk_buff *skb;
-	int total = 0;
 	int res;
 
 	spin_lock_bh(&rcvq->lock);
-- 
2.48.1


