Return-Path: <netdev+bounces-93103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD598BA098
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C69284C4D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BA174EC8;
	Thu,  2 May 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NEcyZKX1"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114E155350
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674907; cv=none; b=JO3S86A2yS3U/ErZAb4A/p9TGd7WVw2J1AJKHk8KmO8Ck+m06xlrsD3ezVk7KJGHd8thQoCd5hm/mx3/k9Oqv7UG2IWb/UqGzcToKzynvm595sJ9YVDyukn+yIRqx3H19dSHAiyFftcQ/FVmkAOUZJXN+MBFj1u3Y2l2iDgIjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674907; c=relaxed/simple;
	bh=VdtLlLuJUR1Knd37f5dxLNMQEdlww7HPfOhL0BqYFmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHNBA1hATg1G4B2K3VFBNeaLQ4df7fm4QwlViPDk+TPENZTFeq16gS59Jq17KsAT11FVejGJcLLmm1N5QTNp7lw97SWFBtwEiikyJgjRWhwj6Zie3tCSlteZN6lADgm7W7AHcGpPmlTlJo39/yrA5Q9FCqiFyyD+KN3XWbeC0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NEcyZKX1; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1943D87DB1;
	Thu,  2 May 2024 20:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714674897;
	bh=oBoFdzt0itbZ1FValzlk4sW818G9z7bta32ObbYkzeE=;
	h=From:To:Cc:Subject:Date:From;
	b=NEcyZKX1+IHetHmRgjgynAtVjq5QFersv1Vf2dMsbQhySjkW200eXW2obLTgFUuoe
	 L1LQAEibcOvaVRUu4x4Cczk1aiL8kPvH0kjiitFSq8VS15M3Er1//GmJTb46qvK+Tm
	 Cx2YOazjSUakL20g45NDfQc9uQPjV1LHJrqnsSCZrjTgdUc9PSHn9sTe734FEDtsRH
	 rzNP5I0aj9QMk83reDxaaLdlFMqPZjifImLWNn701HWWqvK2zQFSQbUFQ00HOFL99N
	 LdPGrYUdZ89Hmnl7dJa/opqnun7bwAtlnMpvZxcPdmz76Xzfcwdo+O047yy74He7FU
	 gwZlqwa0EwT6Q==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [net,PATCH v3] net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs
Date: Thu,  2 May 2024 20:32:59 +0200
Message-ID: <20240502183436.117117-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently the driver uses local_bh_disable()/local_bh_enable() in its
IRQ handler to avoid triggering net_rx_action() softirq on exit from
netif_rx(). The net_rx_action() could trigger this driver .start_xmit
callback, which is protected by the same lock as the IRQ handler, so
calling the .start_xmit from netif_rx() from the IRQ handler critical
section protected by the lock could lead to an attempt to claim the
already claimed lock, and a hang.

The local_bh_disable()/local_bh_enable() approach works only in case
the IRQ handler is protected by a spinlock, but does not work if the
IRQ handler is protected by mutex, i.e. this works for KS8851 with
Parallel bus interface, but not for KS8851 with SPI bus interface.

Remove the BH manipulation and instead of calling netif_rx() inside
the IRQ handler code protected by the lock, queue all the received
SKBs in the IRQ handler into a queue first, and once the IRQ handler
exits the critical section protected by the lock, dequeue all the
queued SKBs and push them all into netif_rx(). At this point, it is
safe to trigger the net_rx_action() softirq, since the netif_rx()
call is outside of the lock that protects the IRQ handler.

Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thread to fix hang")
Tested-by: Ronald Wahl <ronald.wahl@raritan.com> # KS8851 SPI
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
---
V2: - Add TB from Ronald
    - Operate private skb queue without locking as suggested by Eric
V3: - Put the RX queue on stack
    - Only set up the RX queue if there is RX IRQ
    - Update the netif_rx while loop per upstream feedback
---
Note: This is basically what Jakub originally suggested in
      https://patchwork.kernel.org/project/netdevbpf/patch/20240331142353.93792-2-marex@denx.de/#25785606
---
 drivers/net/ethernet/micrel/ks8851_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index d4cdf3d4f5525..502518cdb4618 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -234,12 +234,13 @@ static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
+ * @rxq: Queue of packets received in this function.
  *
  * This is called from the IRQ work queue when the system detects that there
  * are packets in the receive queue. Find out how many packets there are and
  * read them from the FIFO.
  */
-static void ks8851_rx_pkts(struct ks8851_net *ks)
+static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
 {
 	struct sk_buff *skb;
 	unsigned rxfc;
@@ -299,7 +300,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				__netif_rx(skb);
+				__skb_queue_tail(rxq, skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -326,11 +327,11 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
+	struct sk_buff_head rxq;
 	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
-
-	local_bh_disable();
+	struct sk_buff *skb;
 
 	ks8851_lock(ks, &flags);
 
@@ -384,7 +385,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		 * from the device so do not bother masking just the RX
 		 * from the device. */
 
-		ks8851_rx_pkts(ks);
+		__skb_queue_head_init(&rxq);
+		ks8851_rx_pkts(ks, &rxq);
 	}
 
 	/* if something stopped the rx process, probably due to wanting
@@ -408,7 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	local_bh_enable();
+	if (status & IRQ_RXI)
+		while ((skb = __skb_dequeue(&rxq)))
+			netif_rx(skb);
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0


