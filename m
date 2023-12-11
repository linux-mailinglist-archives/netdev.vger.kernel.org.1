Return-Path: <netdev+bounces-55724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0F80C152
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50E2280D6B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5A1F600;
	Mon, 11 Dec 2023 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EpVBgPcC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CE2CD
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 22:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702276109; x=1733812109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1IJz2l0juziCvMnsvEbOolxYYF0CdFHEdvVrr5qDJbk=;
  b=EpVBgPcCtK5+CwEJ+JTG+H2oCgNuHh29LH48eoOYfiIrJEMYtkiAkoPf
   dtWZRlD6/uKki64cqnbgxgVySOx1uGXZY1OTu0xKdCou05A8j1xj9d4jt
   sfv91UXLZRYOcWKqmNPKS0/KGJ40IUUMJ9tTeNA+8GSkYNv4H3qLwqH2z
   0=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="258768220"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:28:27 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 4615680874;
	Mon, 11 Dec 2023 06:28:25 +0000 (UTC)
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:8358]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.48.204:2525] with esmtp (Farcaster)
 id c6bb0273-2809-4c8a-a265-359628ed6ef2; Mon, 11 Dec 2023 06:28:25 +0000 (UTC)
X-Farcaster-Flow-ID: c6bb0273-2809-4c8a-a265-359628ed6ef2
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:25 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:25 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 06:28:23
 +0000
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
	<evostrov@amazon.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v2 net 3/4] net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
Date: Mon, 11 Dec 2023 06:28:00 +0000
Message-ID: <20231211062801.27891-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211062801.27891-1-darinzon@amazon.com>
References: <20231211062801.27891-1-darinzon@amazon.com>
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

This patch fixes two issues:

Issue 1
-------
Description
```````````
Current code does not call dma_sync_single_for_cpu() to sync data from
the device side memory to the CPU side memory before the XDP code path
uses the CPU side data.
This causes the XDP code path to read the unset garbage data in the CPU
side memory, resulting in incorrect handling of the packet by XDP.

Solution
````````
1. Add a call to dma_sync_single_for_cpu() before the XDP code starts to
   use the data in the CPU side memory.
2. The XDP code verdict can be XDP_PASS, in which case there is a
   fallback to the non-XDP code, which also calls
   dma_sync_single_for_cpu().
   To avoid calling dma_sync_single_for_cpu() twice:
2.1. Put the dma_sync_single_for_cpu() in the code in such a place where
     it happens before XDP and non-XDP code.
2.2. Remove the calls to dma_sync_single_for_cpu() in the non-XDP code
     for the first buffer only (rx_copybreak and non-rx_copybreak
     cases), since the new call that was added covers these cases.
     The call to dma_sync_single_for_cpu() for the second buffer and on
     stays because only the first buffer is handled by the newly added
     dma_sync_single_for_cpu(). And there is no need for special
     handling of the second buffer and on for the XDP path since
     currently the driver supports only single buffer packets.

Issue 2
-------
Description
```````````
In case the XDP code forwarded the packet (ENA_XDP_FORWARDED),
ena_unmap_rx_buff_attrs() is called with attrs set to 0.
This means that before unmapping the buffer, the internal function
dma_unmap_page_attrs() will also call dma_sync_single_for_cpu() on
the whole buffer (not only on the data part of it).
This sync is both wasteful (since a sync was already explicitly
called before) and also causes a bug, which will be explained
using the below diagram.

The following diagram shows the flow of events causing the bug.
The order of events is (1)-(4) as shown in the diagram.

CPU side memory area

     (3)convert_to_xdp_frame() initializes the
        headroom with xdpf metadata
                      ||
                      \/
          ___________________________________
         |                                   |
 0       |                                   V                       4K
 ---------------------------------------------------------------------
 | xdpf->data      | other xdpf       |   < data >   | tailroom ||...|
 |                 | fields           |              | GARBAGE  ||   |
 ---------------------------------------------------------------------

                   /\                        /\
                   ||                        ||
   (4)ena_unmap_rx_buff_attrs() calls     (2)dma_sync_single_for_cpu()
      dma_sync_single_for_cpu() on the       copies data from device
      whole buffer page, overwriting         side to CPU side memory
      the xdpf->data with GARBAGE.           ||
 0                                                                   4K
 ---------------------------------------------------------------------
 | headroom                           |   < data >   | tailroom ||...|
 | GARBAGE                            |              | GARBAGE  ||   |
 ---------------------------------------------------------------------

Device side memory area                      /\
                                             ||
                               (1) device writes RX packet data

After the call to ena_unmap_rx_buff_attrs() in (4), the xdpf->data
becomes corrupted, and so when it is later accessed in
ena_clean_xdp_irq()->xdp_return_frame(), it causes a page fault,
crashing the kernel.

Solution
````````
Explicitly tell ena_unmap_rx_buff_attrs() not to call
dma_sync_single_for_cpu() by passing it the ENA_DMA_ATTR_SKIP_CPU_SYNC
flag.

Fixes: f7d625adeb7b ("net: ena: Add dynamic recycling mechanism for rx buffers")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 23 ++++++++------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c7bc572..c44c44e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1493,11 +1493,6 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		if (unlikely(!skb))
 			return NULL;
 
-		/* sync this buffer for CPU use */
-		dma_sync_single_for_cpu(rx_ring->dev,
-					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
-					len,
-					DMA_FROM_DEVICE);
 		skb_copy_to_linear_data(skb, buf_addr + buf_offset, len);
 		dma_sync_single_for_device(rx_ring->dev,
 					   dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
@@ -1516,17 +1511,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
 
-	pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
-
 	/* If XDP isn't loaded try to reuse part of the RX buffer */
 	reuse_rx_buf_page = !is_xdp_loaded &&
 			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
 
-	dma_sync_single_for_cpu(rx_ring->dev,
-				pre_reuse_paddr + pkt_offset,
-				len,
-				DMA_FROM_DEVICE);
-
 	if (!reuse_rx_buf_page)
 		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
 
@@ -1723,6 +1711,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	int xdp_flags = 0;
 	int total_len = 0;
 	int xdp_verdict;
+	u8 pkt_offset;
 	int rc = 0;
 	int i;
 
@@ -1749,13 +1738,19 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
 		/* First descriptor might have an offset set by the device */
 		rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
-		rx_info->buf_offset += ena_rx_ctx.pkt_offset;
+		pkt_offset = ena_rx_ctx.pkt_offset;
+		rx_info->buf_offset += pkt_offset;
 
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx_poll: q %d got packet from ena. descs #: %d l3 proto %d l4 proto %d hash: %x\n",
 			  rx_ring->qid, ena_rx_ctx.descs, ena_rx_ctx.l3_proto,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
+		dma_sync_single_for_cpu(rx_ring->dev,
+					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
+					rx_ring->ena_bufs[0].len,
+					DMA_FROM_DEVICE);
+
 		if (ena_xdp_present_ring(rx_ring))
 			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
@@ -1781,7 +1776,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 				if (xdp_verdict & ENA_XDP_FORWARDED) {
 					ena_unmap_rx_buff_attrs(rx_ring,
 								&rx_ring->rx_buffer_info[req_id],
-								0);
+								DMA_ATTR_SKIP_CPU_SYNC);
 					rx_ring->rx_buffer_info[req_id].page = NULL;
 				}
 			}
-- 
2.40.1


