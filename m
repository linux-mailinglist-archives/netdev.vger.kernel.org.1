Return-Path: <netdev+bounces-307009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2faEFLtgVGo8lQMAu9opvQ
	(envelope-from <netdev+bounces-307009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EE74701F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bxhvXGyr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307009-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D5BE300B9F7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586E1F3BA4;
	Mon, 13 Jul 2026 03:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF72FE0F
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 03:51:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783914680; cv=none; b=nxER2K9k0/vTDNdpMjgmmVINCi8XEy+PrdEZ/wYi5huBKbB2A413kI2YcQFyVes5/mmEMPV6luBv4vG2WX2nth6z8ZmA2bCo6Det3B6P8xpxJLGGRO9dj+F09lXkPXAze27Viv8jto01pQNNq04laW6DTV9f01RhDv22G+HU5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783914680; c=relaxed/simple;
	bh=HKkOZysNMXdsCaJvW04vKhoqHTNPXJyFMdHSWduwpzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Snctpzjr5Oe/VO/sSG1jqXG/bNOABCDkjmHElUo0Wevf0RQ4jseaeYNwxN64HRQ6zey7pZFXM0ZBpOIk0xWBREtQzz5kierx/M2E908OUy7ZY8IgUGTvvyH9jJyeXeEXKmnxvRe3cpx9GrT66W8I8vHquijP/SHWldSo+sxTT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxhvXGyr; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1576824a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783914678; x=1784519478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7dsA5Iu3ZeC94Ma9K7vWaE+tPx/hOOL5yYifJ4EReo=;
        b=bxhvXGyrTUUEVN/0tICouAK1r1EwcSVJDn+VceIw7q/qst3ssvkWMqFnkVIG7HRVZE
         50G0vVxaN5K/BAuODeXPfGDB18V7wN42s4kOM6wJqNkgTs7wpMFQorCk6jRcjV4O0v/D
         500sXBo/L+pRAvLnDcZE0Vvm6UV7xot0pg7CpJkUj/u0We1+XBPvTCXrqDfAhjCnbt9p
         7UtBM2aQteRlEMQJha6iz7RGz3TaeFCFvgq29CN7tQurq+3vj1Kgcd8Sx2R8JDAcos2G
         LsnUC2TmwcksA7LvpY1xMVE0GVUGoRx0YpK0UHNuJzdEugXHCMtZHbvL4uaXd/VTOJH/
         XpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783914678; x=1784519478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7dsA5Iu3ZeC94Ma9K7vWaE+tPx/hOOL5yYifJ4EReo=;
        b=fgPETpVBjC5j/+dz8PPNgJybN4vgj7/k+ZOnW0x5ZUjjBrV1UTREJJ2nNlGQ+UOtAc
         EiWMQkBfzs9k9l4aYpg7UCW5XOrVJn6pgMJQQGx+M2Qow1V/iaTU1SDCbXKRpMATCgCy
         j0POeutgL2921jceY5gBQFZ43V/+ruIZ69Sf0KVndxmIA6E+9IPhcAN49vUrHEqwxKK5
         OVEKkPKmcv+rbIaIT54ccUfdZ2y1xiyrhZcPrDlM7d/D6kG9euUth2YCKNtkpFUSFGTS
         AlY8BQ2vO+swyv3rOlHklVLVeLAIwCz0QUpUkvBMtGxEYRmNNbA3ffA/vbpkSO4O14MG
         crzA==
X-Forwarded-Encrypted: i=1; AHgh+RriUaUzd26HssLO14FlP+FBsGNp2Ml7FBNHq1J4Y7nkdxfQS97jJ88Xfbu0dbKUBuAk7EYFB2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxroU5SLm1ak8VfylBTq9wX1CaXQwuNDmUeX9rX9o2gicS1qKyb
	qBD0Q0kFBaT8MHvaG/vBLVY3SyfkxSIvSRu/kVcgjYJpWGPzjQHRprSY
X-Gm-Gg: AfdE7ckeeuQHpohxZhoUUODGHsEI3/bMNNyHEy+SYOSa3RdC+5WPID2sshvoJABDUJT
	jo0JSie8F4YTBXqbg4SA7md/IZMDHm73Rqw8siN09lkMyXy30wndfsSC53WfmUYi8M+hE1iTtH3
	eIlPGwBQvArxmc8qGaHXfmuSwmwVca1gp4+NFSPryryYhjxO19dxDACIztN0qfOYXD0S9qgKgdy
	Z4qmBtGSt6u+IxldCLme+/bWaZXY/S0c/Z5LMC/xmRBpnzuGLvOGJGDbQ34qYFA7iXBY32mI84u
	aiz+na/6xH9ReRM+xge7Valf0O+VBujehKyBB6O5KAZC54MPB4f4kU4Jzn3rZ0Qmb4PHvO4kP5b
	m5PM94T2IIzsrKtrpKV/o0vKL682SJfNrfF+oxBN3BQBHqImgTHoqUE62h3XJQeMF4QyAzRRV1w
	WjfT7FVUAxuIVW8Fn5XAq8IRvcew==
X-Received: by 2002:a05:6a21:511:b0:3b3:3852:6663 with SMTP id adf61e73a8af0-3c0f0ae8f4amr13460214637.24.1783914677991;
        Sun, 12 Jul 2026 20:51:17 -0700 (PDT)
Received: from archbtw ([2405:201:22:b1c5:42c3:4851:cefc:8c57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ba16d46dfsm657297c88.7.2026.07.12.20.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:51:17 -0700 (PDT)
From: Atharva Potdar <atharvapotdar07@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
	netdev@vger.kernel.org,
	atharvapotdar07@gmail.com
Subject: [PATCH v5] r8169: migrate Rx path to page_pool, prepare for XDP
Date: Mon, 13 Jul 2026 09:20:49 +0530
Message-ID: <20260713035049.25310-1-atharvapotdar07@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fr.zoreil.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307009-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:romieu@fr.zoreil.com,m:netdev@vger.kernel.org,m:atharvapotdar07@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,params.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B8EE74701F

Replace the alloc_pages() + dma_map_page() + skb_copy() Rx model with
a page_pool-backed napi_build_skb() path for zero-copy delivery.
PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV delegate DMA mapping and
cache sync to the page_pool core for correct cross-architecture
behaviour.

MACs up to RTL_GIGA_MAC_VER_06 are kept on the copy path with no
headroom. Newer MACs reserve XDP_PACKET_HEADROOM (256 B) per buffer
via pp_params.offset and desc->addr, avoiding pskb_expand_head()
reallocations on forwarded traffic and establishing the headroom
contract expected by later XDP patches.

The pool uses order-2 (SZ_16K) pages on all MACs. Old silicon in this
family ignores the descriptor buffer size limit, allowing oversized
packets to corrupt memory (see fdd7b4c3302c, c0cd884af045,
6f0333b8fde4). opts1 and napi_build_skb() both derive their sizes
from tp->rx_buf_sz = SZ_16K - SKB_DATA_ALIGN(sizeof(struct
skb_shared_info)) - rx_headroom, keeping the NIC write window and skb
tailroom consistent and within the allocation.

Rx consumption (cur_rx) is decoupled from refill (dirty_rx).
xdp_rxq_info is registered at pool creation time for the MEM_TYPE_
PAGE_POOL return path required by XDP redirect.

Signed-off-by: Atharva Potdar <atharvapotdar07@gmail.com>
---
Testing on RTL8168h, x86, bare metal:
- Verified napi_build_skb() is taken for all Rx packets via bpftrace.
  No copy-path fallback observed at 1Gbps line rate.
- Confirmed 256B skb headroom on eno1 via bpftrace (403091 packets).
  No pskb_expand_head() calls during routed traffic.
- Cycled ip link down/up under load. Ring repopulates cleanly after
  rtl_reset_work(); no stale descriptor accesses.
- 9000-byte MTU TCP streams at line rate (992 Mbps). nstat showed no
  TcpExtTCPRcvQDrop or OfoPrune regressions.

v5:
 - Introduced tp->rx_buf_sz, derived from SZ_16K -
   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - rx_headroom.
   Used for both opts1 and napi_build_skb() frag_size, fixing a
   255-byte DMA overflow past the end of the order-2 page on modern
   MACs and a potential skb_put() panic on large frames.
 - Fixed rtl8169_rx_clear() to iterate all NUM_RX_DESC entries
   unconditionally. Early exit on NULL leaked pool pages on teardown
   after any zero-copy traffic.
 - Fixed rtl_reset_work() to repopulate NULL Rx_databuff slots before
   re-arming descriptors, preventing DMA into stale addresses after
   a reset.
 - Removed spurious #include <linux/if_link.h>.
 - Fixed napi_build_skb() frag_size: must be the total page allocation
   (SZ_16K), not the pre-reduced rx_buf_sz + rx_headroom. The function
   subtracts SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) internally;
   passing an already-reduced value caused a double subtraction, giving
   skb tailroom SBI_ALIGN bytes smaller than opts1 permits and risking
   skb_over_panic on large frames.
v4:
 - Bifurcated headroom by MAC version (0 for legacy, 256 for modern).
   MACs <= RTL_GIGA_MAC_VER_06 retained on copy path as a conservative
   choice given limited test coverage, not a known version-specific
   erratum.
 - Locked pool to order-2 allocations matching R8169_RX_BUF_SIZE.
   Old silicon ignores the descriptor buffer size limit; undersized
   buffers cause memory corruption (fdd7b4c3302c, c0cd884af045,
   6f0333b8fde4).
 - Fixed prefetch offset to align with payload start.
v3:
 - Reserved XDP_PACKET_HEADROOM per buffer to prevent pskb_expand_head()
   on forwarded traffic.
 - Decoupled Rx consumption (cur_rx) from buffer refill (dirty_rx).
 - Registered xdp_rxq_info mem model at pool creation time.
v2:
 - Reverted buffer size to SZ_16K to prevent MTU regression and restore
   protection against the chipset buffer-limit erratum.
v1:
 - Initial page_pool migration.

 drivers/net/ethernet/realtek/r8169_main.c | 173 ++++++++++++++++++----
 1 file changed, 141 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa..c548e7e8d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -31,7 +31,9 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 #include <net/phy/realtek_phy.h>
+#include <net/xdp.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -729,6 +731,10 @@ enum rtl_dash_type {
 };
 
 struct rtl8169_private {
+	struct page_pool *rx_pool;
+	struct xdp_rxq_info xdp_rxq;
+	u32 rx_headroom;
+	u32 rx_buf_sz;
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
 	struct net_device *dev;
@@ -739,6 +745,7 @@ struct rtl8169_private {
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
+	u32 dirty_rx;
 	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
 	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
 	dma_addr_t TxPhyAddr;
@@ -2622,6 +2629,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 {
 	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+	tp->dirty_rx = 0;
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -4148,37 +4156,30 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
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
 	dma_addr_t mapping;
 	struct page *data;
 
-	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
+	data = page_pool_dev_alloc_pages(tp->rx_pool);
 	if (!data)
 		return NULL;
 
-	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(d, mapping))) {
-		netdev_err(tp->dev, "Failed to map RX DMA!\n");
-		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
-		return NULL;
-	}
+	mapping = page_pool_get_dma_addr(data) + tp->rx_headroom;
 
 	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
+	rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
 
 	return data;
 }
@@ -4187,15 +4188,21 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
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
+		page_pool_put_full_page(tp->rx_pool, tp->Rx_databuff[i], false);
 		tp->Rx_databuff[i] = NULL;
 		tp->RxDescArray[i].addr = 0;
 		tp->RxDescArray[i].opts1 = 0;
 	}
+
+	if (tp->rx_pool) {
+		if (xdp_rxq_info_is_reg(&tp->xdp_rxq))
+			xdp_rxq_info_unreg(&tp->xdp_rxq);
+		page_pool_destroy(tp->rx_pool);
+		tp->rx_pool = NULL;
+	}
 }
 
 static int rtl8169_rx_fill(struct rtl8169_private *tp)
@@ -4221,12 +4228,57 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	struct page_pool_params params = {0};
+	int err;
+
 	rtl8169_init_ring_indexes(tp);
 
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
+		tp->rx_headroom = 0;
+		tp->rx_buf_sz = R8169_RX_BUF_SIZE;
+	} else {
+		tp->rx_headroom = XDP_PACKET_HEADROOM;
+		tp->rx_buf_sz = SZ_16K -
+						SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) -
+						XDP_PACKET_HEADROOM;
+	}
+
+	params.order = get_order(R8169_RX_BUF_SIZE);
+	params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	params.pool_size = NUM_RX_DESC;
+	params.nid = dev_to_node(tp_to_dev(tp));
+	params.dev = tp_to_dev(tp);
+	params.napi = &tp->napi;
+	params.dma_dir = DMA_FROM_DEVICE;
+	params.offset = tp->rx_headroom;
+	params.max_len = tp->rx_buf_sz;
+
+	tp->rx_pool = page_pool_create(&params);
+	if (IS_ERR(tp->rx_pool)) {
+		err = PTR_ERR(tp->rx_pool);
+		tp->rx_pool = NULL;
+		return err;
+	}
+
+	err = xdp_rxq_info_reg(&tp->xdp_rxq, tp->dev, 0, tp->napi.napi_id);
+	if (err)
+		goto err_free_pool;
+
+	err = xdp_rxq_info_reg_mem_model(&tp->xdp_rxq, MEM_TYPE_PAGE_POOL, tp->rx_pool);
+	if (err)
+		goto err_unreg_rxq;
+
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
 	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
 	return rtl8169_rx_fill(tp);
+
+err_unreg_rxq:
+	xdp_rxq_info_unreg(&tp->xdp_rxq);
+err_free_pool:
+	page_pool_destroy(tp->rx_pool);
+	tp->rx_pool = NULL;
+	return err;
 }
 
 static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
@@ -4311,8 +4363,20 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 
 	rtl8169_cleanup(tp);
 
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	for (i = 0; i < NUM_RX_DESC; i++) {
+		if (tp->Rx_databuff[i])
+			continue;
+		tp->Rx_databuff[i] =
+			rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
+		if (!tp->Rx_databuff[i])
+			break;
+	}
+
+	for (i = 0; i < NUM_RX_DESC; i++) {
+		if (!tp->Rx_databuff[i])
+			continue;
+		rtl8169_mark_to_asic(tp->RxDescArray + i, tp->rx_buf_sz);
+	}
 
 	napi_enable(&tp->napi);
 	rtl_hw_start(tp);
@@ -4768,16 +4832,39 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
+static void rtl8169_rx_refill(struct rtl8169_private *tp)
+{
+	while (tp->dirty_rx != tp->cur_rx) {
+		unsigned int entry = tp->dirty_rx % NUM_RX_DESC;
+		struct RxDesc *desc = tp->RxDescArray + entry;
+
+		if (!tp->Rx_databuff[entry]) {
+			struct page *new_page = page_pool_dev_alloc_pages(tp->rx_pool);
+
+			if (unlikely(!new_page))
+				break;
+
+			tp->Rx_databuff[entry] = new_page;
+
+			desc->addr = cpu_to_le64(page_pool_get_dma_addr(new_page) +
+				tp->rx_headroom);
+		}
+		rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
+
+		tp->dirty_rx++;
+	}
+}
+
 static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
 {
 	struct device *d = tp_to_dev(tp);
 	int count;
 
-	for (count = 0; count < budget; count++, tp->cur_rx++) {
+	for (count = 0; count < budget;) {
 		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
 		struct RxDesc *desc = tp->RxDescArray + entry;
 		struct sk_buff *skb;
-		const void *rx_buf;
+		void *rx_buf;
 		dma_addr_t addr;
 		u32 status;
 
@@ -4820,21 +4907,40 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
-		if (unlikely(!skb)) {
-			dev->stats.rx_dropped++;
-			goto release_descriptor;
-		}
+		if (unlikely(!tp->Rx_databuff[entry]))
+			break;
 
 		addr = le64_to_cpu(desc->addr);
 		rx_buf = page_address(tp->Rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
-		prefetch(rx_buf);
-		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
-		skb->tail += pkt_size;
-		skb->len = pkt_size;
-		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+		prefetch(rx_buf + tp->rx_headroom);
+
+		if (unlikely(tp->rx_headroom == 0)) {
+			skb = napi_alloc_skb(&tp->napi, pkt_size);
+			if (likely(skb)) {
+				skb_copy_to_linear_data(skb, rx_buf, pkt_size);
+				skb_put(skb, pkt_size);
+			}
+			dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+		} else {
+			skb = napi_build_skb(rx_buf, tp->rx_buf_sz + tp->rx_headroom
+				+ SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			if (likely(skb)) {
+				skb_reserve(skb, tp->rx_headroom);
+				skb_put(skb, pkt_size);
+				skb_mark_for_recycle(skb);
+
+				tp->Rx_databuff[entry] = NULL;
+			} else {
+				dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+			}
+		}
+
+		if (unlikely(!skb)) {
+			dev->stats.rx_dropped++;
+			goto release_descriptor;
+		}
 
 		rtl8169_rx_csum(skb, status);
 		skb->protocol = eth_type_trans(skb, dev);
@@ -4848,9 +4954,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_mark_to_asic(desc);
+		tp->cur_rx++;
+		count++;
 	}
 
+	rtl8169_rx_refill(tp);
+
 	return count;
 }
 
-- 
2.55.0


