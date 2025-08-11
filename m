Return-Path: <netdev+bounces-212633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49CB217E8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145987A4983
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2C27D771;
	Mon, 11 Aug 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="M4iS+utp"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBB1EF0A6;
	Mon, 11 Aug 2025 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949889; cv=none; b=iUEDMKYcDSJhYoDCG9MOIu0955ZZbtNtNM5WK4dN2Fz5iyErAlMpHo//7Rbwk7oEDxYTOVrajOacy75QLrxvz+d+H3ej/uKpUTXcJ2IDf25ql1U3PXAvT+6VFbnvsNQ8Zypr/F0MrLWsj7YJHRs4XgoHHmspPR5GjhcMZbksWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949889; c=relaxed/simple;
	bh=qxH/vUlWNOPD+oS7i4N7nf5PewbWQYYpSRYIIS0+nro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9L4fXWdLC3QYwyM58X43XuPPDxQGMnlapGoUXRwSC/Y6pyzPUWXiGe2Spa+LVkbVfUK1GmeEkkq04MeNnHQp4UmwEx63JQ/w3bgR3ww651pYr0LEEYB4BG6w1ahDxmUzRUhYn/atKoe2i6gS8d2ooPQDyM527sIsNB9MYpyCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=M4iS+utp; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-072-64.customers.d1-online.com [80.187.72.64])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 57BM4dre019850
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 00:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1754949881;
	bh=qxH/vUlWNOPD+oS7i4N7nf5PewbWQYYpSRYIIS0+nro=;
	h=From:To:Cc:Subject:Date;
	b=M4iS+utpvMKRprFS897/nIpqmPhimUh5UlmDeWV2cmcxkgMIQdNNfvVo/T8P2iZVv
	 9SlwnRcaJHb2sd8dlK/EP6MGlt1kVACpzbtR92b8hBuERDTFyOAnP20ajkGlbw5IgE
	 ah1VsoRgkIve6SIXvEH4coa+U0QLuqIxVtDjvFuw=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: [PATCH net v2] TUN/TAP: Improving throughput and latency by avoiding SKB drops
Date: Tue, 12 Aug 2025 00:03:48 +0200
Message-ID: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is the result of our paper with the title "The NODROP Patch:
Hardening Secure Networking for Real-time Teleoperation by Preventing
Packet Drops in the Linux TUN Driver" [1].
It deals with the tun_net_xmit function which drops SKB's with the reason
SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
resulting in reduced TCP performance and packet loss for bursty video
streams when used over VPN's.

The abstract reads as follows:
"Throughput-critical teleoperation requires robust and low-latency
communication to ensure safety and performance. Often, these kinds of
applications are implemented in Linux-based operating systems and transmit
over virtual private networks, which ensure encryption and ease of use by
providing a dedicated tunneling interface (TUN) to user space
applications. In this work, we identified a specific behavior in the Linux
TUN driver, which results in significant performance degradation due to
the sender stack silently dropping packets. This design issue drastically
impacts real-time video streaming, inducing up to 29 % packet loss with
noticeable video artifacts when the internal queue of the TUN driver is
reduced to 25 packets to minimize latency. Furthermore, a small queue
length also drastically reduces the throughput of TCP traffic due to many
retransmissions. Instead, with our open-source NODROP Patch, we propose
generating backpressure in case of burst traffic or network congestion.
The patch effectively addresses the packet-dropping behavior, hardening
real-time video streaming and improving TCP throughput by 36 % in high
latency scenarios."

In addition to the mentioned performance and latency improvements for VPN
applications, this patch also allows the proper usage of qdisc's. For
example a fq_codel can not control the queuing delay when packets are
already dropped in the TUN driver. This issue is also described in [2].

The performance evaluation of the paper (see Fig. 4) showed a 4%
performance hit for a single queue TUN with the default TUN queue size of
500 packets. However it is important to notice that with the proposed
patch no packet drop ever occurred even with a TUN queue size of 1 packet.
The utilized validation pipeline is available under [3].

As the reduction of the TUN queue to a size of down to 5 packets showed no
further performance hit in the paper, a reduction of the default TUN queue
size might be desirable accompanying this patch. A reduction would
obviously reduce buffer bloat and memory requirements.

Implementation details:
- The netdev queue start/stop flow control is utilized.
- Compatible with multi-queue by only stopping/waking the specific
netdevice subqueue.
- No additional locking is used.

In the tun_net_xmit function:
- Stopping the subqueue is done when the tx_ring gets full after inserting
the SKB into the tx_ring.
- In the unlikely case when the insertion with ptr_ring_produce fails, the
old dropping behavior is used for this SKB.

In the tun_ring_recv function:
- Waking the subqueue is done after consuming a SKB from the tx_ring when
the tx_ring is empty. Waking the subqueue when the tx_ring has any
available space, so when it is not full, showed crashes in our testing. We
are open to suggestions.
- When the tx_ring is configured to be small (for example to hold 1 SKB),
queuing might be stopped in the tun_net_xmit function while at the same
time, ptr_ring_consume is not able to grab a SKB. This prevents
tun_net_xmit from being called again and causes tun_ring_recv to wait
indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
queue is woken in the wait queue if it has stopped.
- Because the tun_struct is required to get the tx_queue into the new txq
pointer, the tun_struct is passed in tun_do_read aswell. This is likely
faster then trying to get it via the tun_file tfile because it utilizes a
rcu lock.

We are open to suggestions regarding the implementation :)
Thank you for your work!

[1] Link:
https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
[2] Link:
https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
[3] Link: https://github.com/tudo-cni/nodrop

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
unnecessary netif_tx_wake_queue in tun_ring_recv.

 drivers/net/tun.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index cc6c50180663..81abdd3f9aca 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1060,13 +1060,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+	if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
+		netif_tx_stop_queue(queue);
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
+	if (ptr_ring_full(&tfile->tx_ring))
+		netif_tx_stop_queue(queue);
 
 	/* dev->lltx requires to do our own update of trans_start */
-	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
@@ -2110,9 +2113,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile, int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
+	struct netdev_queue *txq;
 	void *ptr = NULL;
 	int error = 0;
 
@@ -2124,6 +2128,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 		goto out;
 	}
 
+	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
 	add_wait_queue(&tfile->socket.wq.wait, &wait);
 
 	while (1) {
@@ -2131,6 +2136,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 		ptr = ptr_ring_consume(&tfile->tx_ring);
 		if (ptr)
 			break;
+
+		if (unlikely(netif_tx_queue_stopped(txq)))
+			netif_tx_wake_queue(txq);
+
 		if (signal_pending(current)) {
 			error = -ERESTARTSYS;
 			break;
@@ -2147,6 +2156,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 	remove_wait_queue(&tfile->socket.wq.wait, &wait);
 
 out:
+	if (ptr_ring_empty(&tfile->tx_ring)) {
+		txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
+		netif_tx_wake_queue(txq);
+	}
 	*err = error;
 	return ptr;
 }
@@ -2165,7 +2178,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
-- 
2.43.0


