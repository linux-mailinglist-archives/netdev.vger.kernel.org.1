Return-Path: <netdev+bounces-299149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id as9xDSI/LmrXrAQAu9opvQ
	(envelope-from <netdev+bounces-299149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC336806B4
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Dwf5OmlH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299149-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F35B300951A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC828AB0B;
	Sun, 14 Jun 2026 05:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2A24A078
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:41:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415711; cv=none; b=gII3hajQOkgvWtvynRO5wwhk6ESqQMcveh7Wkl0Z8oaxBbbej5WBbm5R6PKO/gAIZMWvoQ0U8uxtk9HmFgHz3of5+RqY5aLniHbmoU3ws9iTQ7bpPHnT+MFR8nDaCCviTmoh/+a+MKhMxzLxavJUflWMDHHYp7Jg1B1TaQKV4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415711; c=relaxed/simple;
	bh=AbOlvH1gr/6qR6Gzh4/x3mWaM+jRdmY1COumZc2e/zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrbHewIkkLml98euHUWo9Cj4mbauUZH5kYD9BtdF+rxw5YRNOtF2OiU9UCu1rQh+aejASAZHAaNoeY+qezY9Vj4j4hMsqkU6M4G2R6Zn9f+d0tDzXoJF7kEVyOqhIgLyXFihzQl4CoilWVeptcqqRMKT6lbDJiztai/fzq3/OHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwf5OmlH; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f869421so1809716b3a.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781415709; x=1782020509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WenpNgo23YsONcs2rl7lYnENClxx/vSYOkk79qbGJw=;
        b=Dwf5OmlHlJv6ZKtEMoa6cdZ10tkD/GwIbujKViwQ+ucrXsoisxK+UFw+b4wk0zarTu
         EEdmA4H9RtPYSd79wcqsPbxMQSF5KJ7jKBT01CBiOszzJnxbcubT3KR8bgJ2ME4UNuMi
         CKvHYHFq6EhSAFBpL8tzBTgiWtY18xiEjtpwce+RRUlGm1pByAZl1x3J4/mYWI0ALEyM
         Kims2lzESLO14Z+DwQPCsiS+OOw4ycC2N0OibphjAQKU0DR2r29fPD5EoQPds8Yul0qY
         sJNd2pT0VQ5eL30a0lduhG+aToTOUQ0EiSgKOxZVH0hhAQkf3JNJ5ZcZTWOAI6KEz3fo
         2mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781415709; x=1782020509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WenpNgo23YsONcs2rl7lYnENClxx/vSYOkk79qbGJw=;
        b=kQgGz0hCtcgSDYjqAkosAs0mbSsjiOrGqNKY6+f3Qd1uMqgrQynGRgbCgjjchGQ77t
         7S1PlcmK07EK0vPkA4W4zfK+6XB9gnpv0KIGQKYli6rFi+wOOQm3XcIygp932qs6dj0Q
         xCHCV6+vKCYvkXxrykVCDLJzIDY7///W12qKFIsEJuoEZCzs4Zyo06qP0+uplYbIiP+W
         ggldyxJClgWStJ2dDTtFLvDSs8rzGnIcxtPvE7cuN2bsfYHTUn535zIKNi+8Cx6aVG/g
         PKu2LhQhOtu+QC0w3vFIyiwrtOvYHO345D1g2CX4yMNjgT8qebQRcgx9Hz+2Chu+oQZl
         yDmg==
X-Gm-Message-State: AOJu0YxRoJyhhI3kjzqIuXWmhAuZ4u+PQKCB6DavkQBEs0W+hy2eOEAY
	bRtT3xCmrwd0jioTcVgHu3BC2DHCPnyHG10NleGhJb1Ybe9iff36etdS
X-Gm-Gg: Acq92OFwEXp3Jlm2jWr61esxMnvMbB+M/AwgXlwBDxCx+rimn9dP1l4RXxa3hgYK1uV
	hgYtStTR/1iWUb/vUcQlg6U3T2L6PGWoOL5y0C/JPn2ZjEb/OWHPPvZ39Iuq0vsmwoEWfc0+xD9
	lTcAa4SfqSf/aKsoXyqpLJ/H0UmJBmCzEgM813gYhfQpIkzaXLkNCU0WWGSTEOwNvPhXsOh8aC2
	5zmqVQ9yKL1jubRmmAkUNtW4VpZ3P0O3ZzKN1bHGAINtxZhyU8vHuEewQnSiICxqp7YDh4SVMnz
	3Mzxs2OJUoTDEX3J34gYuME/5HUrwfTcSaMRX1a657DjexvskL8WkP1hyo9PupsurMNM6QrXbDe
	+CP1cZ+JmdwXe6xvL7rzYMB880t0B9Ixy7thKKIHZ0HCaMpgqLxMb8gXljPkIlpl1Pbn1ux4U1l
	Z6pWKjFGjSVcAoe31wKYQgFhtV9A==
X-Received: by 2002:a05:6a00:1f04:b0:83d:b0a0:90e3 with SMTP id d2e1a72fcca58-844e1a625ebmr6003095b3a.31.1781415709334;
        Sat, 13 Jun 2026 22:41:49 -0700 (PDT)
Received: from archbtw ([2405:201:22:b1c5:42c3:4851:cefc:8c57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf23a7sm6176615b3a.22.2026.06.13.22.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:41:48 -0700 (PDT)
From: atharva-potdar <atharvapotdar07@gmail.com>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	atharva-potdar <atharvapotdar07@gmail.com>
Subject: [PATCH net-next] r8169: migrate Rx path to page_pool
Date: Sun, 14 Jun 2026 11:11:37 +0530
Message-ID: <20260614054137.32181-1-atharvapotdar07@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299149-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:atharvapotdar07@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,pp_params.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC336806B4

Replace the driver-managed skb+copy Rx model with page_pool
zero-copy in preparation for XDP support.

Key changes:
- Allocate order-0 pages via page_pool instead of alloc_pages + dma_map
- Build skbs directly from pages with napi_build_skb (zero-copy)
- Add rtl8169_rx_refill() to replenish descriptors after processing
- Track dirty_rx boundary for efficient refill scheduling
- Cap max_mtu to R8169_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN
  (order-0 pages can't support arbitrary jumbo frames)

Tested on RTL8168h with iperf3 (~470 Mbps, 0 retransmits) and
1000 pings (0 drops).

Signed-off-by: atharva-potdar <atharvapotdar07@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 128 ++++++++++++++--------
 1 file changed, 85 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa..9d8d678ac 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -31,6 +31,7 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 #include <net/phy/realtek_phy.h>
 
 #include "r8169.h"
@@ -70,7 +71,9 @@
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
 
 #define R8169_REGS_SIZE		256
-#define R8169_RX_BUF_SIZE	(SZ_16K - 1)
+#define R8169_RX_HEADROOM	ALIGN(XDP_PACKET_HEADROOM, 8)
+#define R8169_RX_BUF_SIZE	(PAGE_SIZE - R8169_RX_HEADROOM - \
+				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
@@ -737,6 +740,7 @@ struct rtl8169_private {
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
+	u32 dirty_rx; /* Index of first Rx descriptor needing a new buffer */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
 	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
@@ -745,6 +749,8 @@ struct rtl8169_private {
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	struct page_pool *page_pool;
+	u32 rx_buf_sz;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
@@ -4148,37 +4154,27 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic(struct RxDesc *desc, u32 rx_buf_sz)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
 
 	desc->opts2 = 0;
 	/* Force memory writes to complete before releasing descriptor */
 	dma_wmb();
-	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | rx_buf_sz));
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 					  struct RxDesc *desc)
 {
-	struct device *d = tp_to_dev(tp);
-	int node = dev_to_node(d);
-	dma_addr_t mapping;
 	struct page *data;
 
-	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
+	data = page_pool_dev_alloc_pages(tp->page_pool);
 	if (!data)
 		return NULL;
 
-	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(d, mapping))) {
-		netdev_err(tp->dev, "Failed to map RX DMA!\n");
-		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
-		return NULL;
-	}
-
-	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
+	desc->addr = cpu_to_le64(page_pool_get_dma_addr(data) + R8169_RX_HEADROOM);
+	rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
 
 	return data;
 }
@@ -4187,15 +4183,17 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
 {
 	int i;
 
-	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
-		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
-			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+	for (i = 0; i < NUM_RX_DESC; i++) {
+		if (!tp->Rx_databuff[i])
+			continue;
+		page_pool_put_full_page(tp->page_pool, tp->Rx_databuff[i], true);
 		tp->Rx_databuff[i] = NULL;
 		tp->RxDescArray[i].addr = 0;
 		tp->RxDescArray[i].opts1 = 0;
 	}
+
+	page_pool_destroy(tp->page_pool);
+	tp->page_pool = NULL;
 }
 
 static int rtl8169_rx_fill(struct rtl8169_private *tp)
@@ -4221,11 +4219,28 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	struct page_pool_params pp_params = { 0 };
+
 	rtl8169_init_ring_indexes(tp);
+	tp->dirty_rx = 0;
+	tp->rx_buf_sz = R8169_RX_BUF_SIZE;
 
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
 	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.order = 0;
+	pp_params.pool_size = NUM_RX_DESC;
+	pp_params.nid = dev_to_node(tp_to_dev(tp));
+	pp_params.dev = tp_to_dev(tp);
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.offset = R8169_RX_HEADROOM;
+	pp_params.max_len = tp->rx_buf_sz;
+
+	tp->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(tp->page_pool))
+		return PTR_ERR(tp->page_pool);
+
 	return rtl8169_rx_fill(tp);
 }
 
@@ -4312,7 +4327,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 	rtl8169_cleanup(tp);
 
 	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+		rtl8169_mark_to_asic(tp->RxDescArray + i, tp->rx_buf_sz);
 
 	napi_enable(&tp->napi);
 	rtl_hw_start(tp);
@@ -4776,9 +4791,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 	for (count = 0; count < budget; count++, tp->cur_rx++) {
 		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
 		struct RxDesc *desc = tp->RxDescArray + entry;
+		struct page *page;
 		struct sk_buff *skb;
-		const void *rx_buf;
-		dma_addr_t addr;
 		u32 status;
 
 		status = le32_to_cpu(READ_ONCE(desc->opts1));
@@ -4791,6 +4805,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		 */
 		dma_rmb();
 
+		page = tp->Rx_databuff[entry];
+		tp->Rx_databuff[entry] = NULL;
+
 		if (unlikely(status & RxRES)) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
@@ -4802,9 +4819,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 				dev->stats.rx_crc_errors++;
 
 			if (!(dev->features & NETIF_F_RXALL))
-				goto release_descriptor;
+				goto recycle;
 			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
-				goto release_descriptor;
+				goto recycle;
 		}
 
 		pkt_size = status & GENMASK(13, 0);
@@ -4817,24 +4834,23 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (unlikely(rtl8169_fragmented_frame(status))) {
 			dev->stats.rx_dropped++;
 			dev->stats.rx_length_errors++;
-			goto release_descriptor;
+			goto recycle;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
+		dma_sync_single_for_cpu(d,
+					page_pool_get_dma_addr(page) +
+					R8169_RX_HEADROOM,
+					pkt_size, DMA_FROM_DEVICE);
+
+		skb = napi_build_skb(page_address(page), PAGE_SIZE);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
-			goto release_descriptor;
+			goto recycle;
 		}
 
-		addr = le64_to_cpu(desc->addr);
-		rx_buf = page_address(tp->Rx_databuff[entry]);
-
-		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
-		prefetch(rx_buf);
-		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
-		skb->tail += pkt_size;
-		skb->len = pkt_size;
-		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+		skb_reserve(skb, R8169_RX_HEADROOM);
+		skb_put(skb, pkt_size);
+		skb_mark_for_recycle(skb);
 
 		rtl8169_rx_csum(skb, status);
 		skb->protocol = eth_type_trans(skb, dev);
@@ -4847,13 +4863,34 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		napi_gro_receive(&tp->napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
-release_descriptor:
-		rtl8169_mark_to_asic(desc);
+
+		continue;
+
+recycle:
+		page_pool_put_full_page(tp->page_pool, page, true);
 	}
 
 	return count;
 }
 
+static void rtl8169_rx_refill(struct rtl8169_private *tp)
+{
+	u32 dirty_rx = tp->dirty_rx;
+
+	while (dirty_rx != tp->cur_rx) {
+		u32 entry = dirty_rx % NUM_RX_DESC;
+
+		if (!tp->Rx_databuff[entry]) {
+			tp->Rx_databuff[entry] = rtl8169_alloc_rx_data(tp,
+								       tp->RxDescArray + entry);
+			if (!tp->Rx_databuff[entry])
+				break;
+		}
+		dirty_rx++;
+	}
+	tp->dirty_rx = dirty_rx;
+}
+
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
 	struct rtl8169_private *tp = dev_instance;
@@ -4921,6 +4958,7 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	rtl_tx(dev, tp, budget);
 
 	work_done = rtl_rx(dev, tp, budget);
+	rtl8169_rx_refill(tp);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5775,8 +5813,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	jumbo_max = rtl_jumbo_max(tp);
-	if (jumbo_max)
-		dev->max_mtu = jumbo_max;
+	if (jumbo_max) {
+		unsigned int page_pool_mtu;
+
+		page_pool_mtu = R8169_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+		dev->max_mtu = min_t(int, jumbo_max, page_pool_mtu);
+	}
 
 	rtl_set_irq_mask(tp);
 
@@ -5808,7 +5850,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (jumbo_max)
 		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
-			    jumbo_max, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
+			    dev->max_mtu, tp->mac_version <= RTL_GIGA_MAC_VER_06 ?
 			    "ok" : "ko");
 
 	if (tp->dash_type != RTL_DASH_NONE) {
-- 
2.54.0


