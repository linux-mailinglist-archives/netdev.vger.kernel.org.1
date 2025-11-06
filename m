Return-Path: <netdev+bounces-236484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF6C3CFA8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115E63ABF51
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FE34D4C0;
	Thu,  6 Nov 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="mPAVZlkL"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529E34A3BC;
	Thu,  6 Nov 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451800; cv=none; b=jOU8nT5QIs4hYOb7NMXnr4cbqthPPDVGgMlGl9DQ+cE/qAVNh6rVmrsSAu0ekn0Dc9aUnY1rPLSJ77zu6+EgItKuaYgSNWLRJ00ra/5Kr53/77SyTUvRIhdHcrF7VhzcvBBjvE4LFaEfQ/0c0OdzFygMJQzRHex0mKPVGwYBcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451800; c=relaxed/simple;
	bh=nQ57i8dH7Nm/uXtna/JxiKIX3iH6HAa/JKy4WzkSbYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9/U7QSY5g3C+5lmCvbFvx5rlRLFwrYYzayaXUPkMnyG649E408zBG04jnxM8AGP9vXFP7IKgGvCi3o5ptJjnqxVHiLc8hpA/KYxNi1ZRTSUjmyeU7nNwBpTMMXE+8HRuu98/TjJDD4L4OEPvyiTVE3stUl3r5gsUTjWIL9d5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=mPAVZlkL; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-072-112.customers.d1-online.com [80.187.72.112])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A6HuOKm024412
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 18:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762451789;
	bh=nQ57i8dH7Nm/uXtna/JxiKIX3iH6HAa/JKy4WzkSbYA=;
	h=From:To:Cc:Subject:Date;
	b=mPAVZlkLy9neHrsgaiPqcP4KJnzvbNPBMW7/zCUaY4cPa7nOl/4TrnykF4Yyjwl5/
	 Xn3rLcL5zNJ9YlFkxpaE2iFxnLnXzXXYN9trzFedLByoj3cV8Ct7U6QDWN1j7L73aG
	 ygGuWk/+/aA6+tQCQKzXVeegBz/K+P+Ry+tMpCuY=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        dnlplm@gmail.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next v2] usbnet: Add support for Byte Queue Limits (BQL)
Date: Thu,  6 Nov 2025 18:56:15 +0100
Message-ID: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation, usbnet uses a fixed tx_qlen of:

USB2: 60 * 1518 bytes = 91.08 KB
USB3: 60 * 5 * 1518 bytes = 454.80 KB

Such large transmit queues can be problematic, especially for cellular
modems. For example, with a typical celluar link speed of 10 Mbit/s, a
fully occupied USB3 transmit queue results in:

454.80 KB / (10 Mbit/s / 8 bit/byte) = 363.84 ms

of additional latency.

This patch adds support for Byte Queue Limits (BQL) [1] to dynamically
manage the transmit queue size and reduce latency without sacrificing
throughput.

Testing was performed on various devices using the usbnet driver for
packet transmission:

- DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
- DELOCK 61969: USB2 to 1 GbE adapter (asix)
- Quectel RM520: 5G modem (qmi_wwan)
- USB2 Android tethering (cdc_ncm)

No performance degradation was observed for iperf3 TCP or UDP traffic,
while latency for a prioritized ping application was significantly
reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
utilized by iperf3 UDP traffic, the prioritized ping was improved from
1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
connection, the prioritized ping was improved from 35 ms to 5 ms.

[1] https://lwn.net/Articles/469652/

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
v1 -> v2:
Add a new spinlock to ensure netdev_completed_queue() is not executed
concurrently by process context usbnet_bh_work() and the timer
dev->delay.
- https://lore.kernel.org/netdev/20251104161327.41004-1-simon.schippers@tu-dortmund.de/

 drivers/net/usb/usbnet.c   | 11 +++++++++++
 include/linux/usb/usbnet.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index f3087fb62f4f..3d10cf791c51 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue (net);
+	netdev_reset_queue(net);
 
 	netif_info(dev, ifdown, dev->net,
 		   "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
@@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
 	}
 
 	set_bit(EVENT_DEV_OPEN, &dev->flags);
+	netdev_reset_queue(net);
 	netif_start_queue (net);
 	netif_info(dev, ifup, dev->net,
 		   "open: enable queueing (rx %d, tx %d) mtu %d %s framing\n",
@@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 	case 0:
 		netif_trans_update(net);
 		__usbnet_queue_skb(&dev->txq, skb, tx_start);
+		netdev_sent_queue(net, skb->len);
 		if (dev->txq.qlen >= TX_QLEN (dev))
 			netif_stop_queue (net);
 	}
@@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
 static void usbnet_bh(struct timer_list *t)
 {
 	struct usbnet		*dev = timer_container_of(dev, t, delay);
+	unsigned int bytes_compl = 0, pkts_compl = 0;
 	struct sk_buff		*skb;
 	struct skb_data		*entry;
 
@@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
 				usb_free_skb(skb);
 			continue;
 		case tx_done:
+			bytes_compl += skb->len;
+			pkts_compl++;
 			kfree(entry->urb->sg);
 			fallthrough;
 		case rx_cleanup:
@@ -1584,6 +1590,10 @@ static void usbnet_bh(struct timer_list *t)
 		}
 	}
 
+	spin_lock_bh(&dev->bql_spinlock);
+	netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
+	spin_unlock_bh(&dev->bql_spinlock);
+
 	/* restart RX again after disabling due to high error rate */
 	clear_bit(EVENT_RX_KILL, &dev->flags);
 
@@ -1755,6 +1765,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	skb_queue_head_init (&dev->txq);
 	skb_queue_head_init (&dev->done);
 	skb_queue_head_init(&dev->rxq_pause);
+	spin_lock_init(&dev->bql_spinlock);
 	INIT_WORK(&dev->bh_work, usbnet_bh_work);
 	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
 	init_usb_anchor(&dev->deferred);
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index a2d54122823d..2945923a8a95 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/types.h>
 #include <linux/usb.h>
+#include <linux/spinlock.h>
 
 /* interface from usbnet core to each USB networking link we handle */
 struct usbnet {
@@ -59,6 +60,7 @@ struct usbnet {
 	struct mutex		interrupt_mutex;
 	struct usb_anchor	deferred;
 	struct work_struct	bh_work;
+	spinlock_t		bql_spinlock;
 
 	struct work_struct	kevent;
 	unsigned long		flags;
-- 
2.43.0


