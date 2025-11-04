Return-Path: <netdev+bounces-235527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E91C31FF5
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D09D18C3BEE
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886F32ED57;
	Tue,  4 Nov 2025 16:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35931B132;
	Tue,  4 Nov 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272891; cv=none; b=nXdxS6p4Snp/ZDAdpBOt2W8QWNDf0N64zTD6vc4hLIOeL3PWgIGfM4lz3bGzRVUh+FiC0/ESRP8Rq6Yn9L9DJaBDNEcYZgBbRK1wFCwB2K7n0sRLHU+47z8pdigmCpSNZ7CxlbbFxQcSL4rPVY5KlxB430ZDMaq2sZNioJs3dTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272891; c=relaxed/simple;
	bh=2hdzC5j2xDQnhL0Fda9wKnz2SrLCX/nkeS+rRf2Ut1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPzkq5qy5szwEf54P2Te1YEBhleOnC42pXu/GHEKJq/Ali2/6h8ohMPXMZdhzn1SdaviS0kHC1UnpuJwabFHmW3u23j0hDNZmx1U49HSqhptf30rtSd/U77msjeD4qtRHkD1EDx4opDklPSrb4gQqJAlfKPJLF9lpv89MTCSff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.118])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A4GEWXX011487
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 17:14:34 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, therbert@google.com
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
Date: Tue,  4 Nov 2025 17:13:27 +0100
Message-ID: <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usbnet driver currently relies on fixed transmit queue lengths, which
can lead to bufferbloat and large latency spikes under load -
particularly with cellular modems.
This patch adds support for Byte Queue Limits (BQL) to dynamically manage
the transmit queue size and reduce latency without sacrificing
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

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/usb/usbnet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 62a85dbad31a..1994f03a78ad 100644
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
@@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
 		}
 	}
 
+	netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
+
 	/* restart RX again after disabling due to high error rate */
 	clear_bit(EVENT_RX_KILL, &dev->flags);
 
-- 
2.43.0


