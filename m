Return-Path: <netdev+bounces-177588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22324A70AE0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D9C3B4B54
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F911FF1DF;
	Tue, 25 Mar 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UTM9jRYN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9419CD0E
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932775; cv=none; b=KFlKbqAlu9Ldk1J+bDihzquFMq/MF98sGfjyTSbdPokreHy6/wfUazRL/iwMsfTv7KRWuTSkwL0fo1MQ3ondU2pZvQLcW2uSL3FQdGmeQjOt9LlfJgy0POhyJHPeskfGiW7RB1nDkHvz+lXewm4GBfTbKNs5Roc8sQL+Rjl+OBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932775; c=relaxed/simple;
	bh=cVjia0h3jfzdULq/nxFbVQvBZ9/mcEBVIn7LYTxKTps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWs+txs/yindV1Sdcg2S8LUBlk9F7CUNsZdyNpvDECwuZQSKufQ7F8lKTL3gDZALmMfUi+jP7WpimjASzbBVf+RYTu1OpwJ2A2yG2chNBttnAUpW5hcbS9IFyU+P3IMwIIQ4/2Jmws8NM9Fmf0DzxTLSIDJG5ufRtyLoC3yT5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UTM9jRYN; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742932774; x=1774468774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaxJ6z+enGJURk8uRR12MoDCERvfximdHdn+AIsYQhE=;
  b=UTM9jRYNnU6pKyG4jGbQNhEnkbQWUUTsSdVIzjavt7bBEvK8xm6zLcnj
   hsr7Y+dlqdPlJ2UsWc8huJLyhpVyYL1tzXAJyAQsVrxvyBt1IFqYp6EIY
   2nWLVq0Mc5SammTcQoDJPedFpJhFbjesY4KtqfviLBTpFe5+q02v5C8Zs
   0=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="77610185"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 19:59:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:28399]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id 3a6aa219-7641-44ed-a1a6-b9d54d0a177f; Tue, 25 Mar 2025 19:59:31 +0000 (UTC)
X-Farcaster-Flow-ID: 3a6aa219-7641-44ed-a1a6-b9d54d0a177f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Matt
 Dowling" <madowlin@amazon.com>
Subject: [PATCH v2 net 2/3] udp: Fix memory accounting leak.
Date: Tue, 25 Mar 2025 12:58:14 -0700
Message-ID: <20250325195826.52385-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
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
---
 net/ipv4/udp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4499e1fe4d50..0f0e0d3ecae3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1626,12 +1626,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
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
@@ -1651,10 +1651,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
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
@@ -1844,7 +1842,7 @@ EXPORT_SYMBOL_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1877,8 +1875,8 @@ static int first_packet_length(struct sock *sk)
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


