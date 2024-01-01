Return-Path: <netdev+bounces-60702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB378213E8
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7371F216EE
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD025381;
	Mon,  1 Jan 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EGnFGDpv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC83FEF
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118059; x=1735654059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pyCHa3eaBQqhTa6b1wO2m6Z/xOQbdmsKx1vEKxrR3zU=;
  b=EGnFGDpv1J8izrAVbqlS3aUQQZ22GIIsHEwupzQ3XemueLzkNbP1+PxY
   BoPCj3oTRS7wuAEn376aX4mcKe3amw1BbnuklIisdnCHFo0skmcxXD10z
   SwTRxkSwCZSz6SpSTWHkJhleMETaDfbbSvIi4At6sgTSNdYlXmrEeZaVI
   U=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="603901053"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:37 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id A061A49F1A;
	Mon,  1 Jan 2024 14:07:36 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:27788]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.58.125:2525] with esmtp (Farcaster)
 id ffca8a56-2d0a-402b-98f1-369982428b8f; Mon, 1 Jan 2024 14:07:35 +0000 (UTC)
X-Farcaster-Flow-ID: ffca8a56-2d0a-402b-98f1-369982428b8f
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:35 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:35 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:33 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net-next 02/11] net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
Date: Mon, 1 Jan 2024 14:07:15 +0000
Message-ID: <20240101140724.26232-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101140724.26232-1-darinzon@amazon.com>
References: <20240101140724.26232-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

This change will enable the ability to use ena_xmit_common()
in functions that don't have a net_device pointer.
While it can be retrieved by dereferencing
ena_adapter (adapter->netdev), there's no reason to do it in
fast path code where this pointer is only needed for
debug prints.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 9 ++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 2 +-
 drivers/net/ethernet/amazon/ena/ena_xdp.c    | 6 +++---
 drivers/net/ethernet/amazon/ena/ena_xdp.h    | 4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 0a0d97c..b7f300b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -88,19 +88,18 @@ static int ena_change_mtu(struct net_device *dev, int new_mtu)
 	return ret;
 }
 
-int ena_xmit_common(struct net_device *dev,
+int ena_xmit_common(struct ena_adapter *adapter,
 		    struct ena_ring *ring,
 		    struct ena_tx_buffer *tx_info,
 		    struct ena_com_tx_ctx *ena_tx_ctx,
 		    u16 next_to_use,
 		    u32 bytes)
 {
-	struct ena_adapter *adapter = netdev_priv(dev);
 	int rc, nb_hw_desc;
 
 	if (unlikely(ena_com_is_doorbell_needed(ring->ena_com_io_sq,
 						ena_tx_ctx))) {
-		netif_dbg(adapter, tx_queued, dev,
+		netif_dbg(adapter, tx_queued, adapter->netdev,
 			  "llq tx max burst size of queue %d achieved, writing doorbell to send burst\n",
 			  ring->qid);
 		ena_ring_tx_doorbell(ring);
@@ -115,7 +114,7 @@ int ena_xmit_common(struct net_device *dev,
 	 * ena_com_prepare_tx() are fatal and therefore require a device reset.
 	 */
 	if (unlikely(rc)) {
-		netif_err(adapter, tx_queued, dev,
+		netif_err(adapter, tx_queued, adapter->netdev,
 			  "Failed to prepare tx bufs\n");
 		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1,
 				  &ring->syncp);
@@ -2599,7 +2598,7 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* set flags and meta data */
 	ena_tx_csum(&ena_tx_ctx, skb, tx_ring->disable_meta_caching);
 
-	rc = ena_xmit_common(dev,
+	rc = ena_xmit_common(adapter,
 			     tx_ring,
 			     tx_info,
 			     &ena_tx_ctx,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 041f08d..236d1f8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -426,7 +426,7 @@ static inline void ena_ring_tx_doorbell(struct ena_ring *tx_ring)
 	ena_increase_stat(&tx_ring->tx_stats.doorbells, 1, &tx_ring->syncp);
 }
 
-int ena_xmit_common(struct net_device *dev,
+int ena_xmit_common(struct ena_adapter *adapter,
 		    struct ena_ring *ring,
 		    struct ena_tx_buffer *tx_info,
 		    struct ena_com_tx_ctx *ena_tx_ctx,
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index d0c8a2d..42370fa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -73,7 +73,7 @@ error_report_dma_error:
 }
 
 int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
-		       struct net_device *dev,
+		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags)
 {
@@ -93,7 +93,7 @@ int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
 
 	ena_tx_ctx.req_id = req_id;
 
-	rc = ena_xmit_common(dev,
+	rc = ena_xmit_common(adapter,
 			     xdp_ring,
 			     tx_info,
 			     &ena_tx_ctx,
@@ -141,7 +141,7 @@ int ena_xdp_xmit(struct net_device *dev, int n,
 	spin_lock(&xdp_ring->xdp_tx_lock);
 
 	for (i = 0; i < n; i++) {
-		if (ena_xdp_xmit_frame(xdp_ring, dev, frames[i], 0))
+		if (ena_xdp_xmit_frame(xdp_ring, adapter, frames[i], 0))
 			break;
 		nxmit++;
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index 80c7496..6e472ba 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -36,7 +36,7 @@ void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
 					  int first, int count);
 int ena_xdp_io_poll(struct napi_struct *napi, int budget);
 int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
-		       struct net_device *dev,
+		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags);
 int ena_xdp_xmit(struct net_device *dev, int n,
@@ -108,7 +108,7 @@ static inline int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp
 		/* The XDP queues are shared between XDP_TX and XDP_REDIRECT */
 		spin_lock(&xdp_ring->xdp_tx_lock);
 
-		if (ena_xdp_xmit_frame(xdp_ring, rx_ring->netdev, xdpf,
+		if (ena_xdp_xmit_frame(xdp_ring, rx_ring->adapter, xdpf,
 				       XDP_XMIT_FLUSH))
 			xdp_return_frame(xdpf);
 
-- 
2.40.1


