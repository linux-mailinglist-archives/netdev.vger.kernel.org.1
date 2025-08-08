Return-Path: <netdev+bounces-212223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AACB1EC3A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5357A1C91
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62527FB1C;
	Fri,  8 Aug 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="UHMYObw0"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F823F417;
	Fri,  8 Aug 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667502; cv=none; b=soWwy0x8dA2MNT+M8sFWdVIh/la5eU/Jd7kWNuXHTnp9XLLG1O6MiEVrlJmJyNe5gssJPEIQzQZWYVAEaRDed+on6wjI6VSf+P3Ced3G5Px5MpfP2vlt8+I29jImZwyFjqK2R974KI861ZN7TTb12PQdDONE/qyDdzibXhD9yyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667502; c=relaxed/simple;
	bh=qsqW+P4dJou89Vrpwc+AH6es5bPP/fSIuyeAzJXBo4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOCViHR/Ab9k5bCBr0qZwc9ADPik4dsIG34GQWvC8JV2SFfosA1gZ97DGxHpo054suXX50yTEEIA/nL+ExqXCfPG55S+53xeraym+CY42/kQKFIm55tm32VHBa8CtcT/xXkSX6FrPFZUV9IjPYIkLxowdRMHb04FWOHQXhsLa/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=UHMYObw0; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.92])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 578FcEML014116
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 Aug 2025 17:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1754667494;
	bh=qsqW+P4dJou89Vrpwc+AH6es5bPP/fSIuyeAzJXBo4c=;
	h=From:To:Cc:Subject:Date;
	b=UHMYObw0IqCEt/tUZPw895BC0jQRID6Fv+xXhC9Z+OIT14VomwTC8ez9+gCjuMHMG
	 XXfOzlN6Git3v6s9VwauW3Xk6iy3CkuqiKJbeqymyjaIOSX8g17kqwaiw9ZaES3rXB
	 uqCoHdI/7UG+w3Un/fREC2HHStoCwadcHJeuhHMw=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: [PATCH net] TUN/TAP: Improving throughput and latency by avoiding SKB drops
Date: Fri,  8 Aug 2025 17:37:21 +0200
Message-ID: <20250808153721.261334-1-simon.schippers@tu-dortmund.de>
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
- In the unlikely case when tun_net_xmit is called even though the tx_ring
is full, the subqueue is stopped once again and NETDEV_TX_BUSY is returned.

In the tun_ring_recv function:
- Waking the subqueue is done after consuming a SKB from the tx_ring when
the tx_ring is empty. Waking the subqueue when the tx_ring has any
available space, so when it is not full, showed crashes in our testing. We
are open to suggestions.
- Especially when the tx_ring is configured to be small, queuing might be
stopped in the tun_net_xmit function while at the same time,
ptr_ring_consume is not able to grab a packet. This prevents tun_net_xmit
from being called again and causes tun_ring_recv to wait indefinitely for
a packet. Therefore, the queue is woken after grabbing a packet if the
queuing is stopped. The same behavior is applied in the accompanying wait
queue.
- Because the tun_struct is required to get the tx_queue into the new txq
pointer, the tun_struct is passed in tun_do_read aswell. This is likely
faster then trying to get it via the tun_file tfile because it utilizes a
rcu lock.

We are open to suggestions regarding the implementation :)
Thank you for your work!

[1] Link:
https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2
025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
[2] Link:
https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective
-on-tun-device
[3] Link: https://github.com/tudo-cni/nodrop

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index cc6c50180663..e88a312d3c72 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1023,6 +1023,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netif_info(tun, tx_queued, tun->dev, "%s %d\n", __func__, skb->len);
 
+	if (unlikely(ptr_ring_full(&tfile->tx_ring))) {
+		queue = netdev_get_tx_queue(dev, txq);
+		netif_tx_stop_queue(queue);
+		rcu_read_unlock();
+		return NETDEV_TX_BUSY;
+	}
+
 	/* Drop if the filter does not like it.
 	 * This is a noop if the filter is disabled.
 	 * Filter can be enabled only for the TAP devices. */
@@ -1060,13 +1067,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -2110,15 +2120,21 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile, int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
+	struct netdev_queue *txq;
 	void *ptr = NULL;
 	int error = 0;
 
 	ptr = ptr_ring_consume(&tfile->tx_ring);
 	if (ptr)
 		goto out;
+
+	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
+	if (unlikely(netif_tx_queue_stopped(txq)))
+		netif_tx_wake_queue(txq);
+
 	if (noblock) {
 		error = -EAGAIN;
 		goto out;
@@ -2131,6 +2147,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
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
@@ -2147,6 +2167,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 	remove_wait_queue(&tfile->socket.wq.wait, &wait);
 
 out:
+	if (ptr_ring_empty(&tfile->tx_ring)) {
+		txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
+		netif_tx_wake_queue(txq);
+	}
 	*err = error;
 	return ptr;
 }
@@ -2165,7 +2189,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
-- 
2.43.0


