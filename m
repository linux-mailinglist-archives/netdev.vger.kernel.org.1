Return-Path: <netdev+bounces-304690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LPPOEG/SGpGtQAAu9opvQ
	(envelope-from <netdev+bounces-304690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 10:07:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A02C707065
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 10:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SXb+QB5w;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304690-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304690-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40B6300B548
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D47392836;
	Sat,  4 Jul 2026 08:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B002727EB
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 08:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783152445; cv=none; b=a4YCpKsNnTXDtRDAypYmRpX41cq9DT3k2yYMIpMtik8STfrmkzoC2Ns/Ckb3dELYumkHE5c7qRKzqcMHeybGMALgl8kFM/FJkBn5XOlio0IudEm7Ex6aMQbt4VotQFmL1aMnlRzcXLXQC8xxajUpNoNY7PFWBlwVykPZTDgjNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783152445; c=relaxed/simple;
	bh=zHa/PkSxRqiCSEg9egN0bODhikQ6FQsQB3sO0xmdZ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsOOtmmRu6t0kxwjVz5ReZGVFV4y+z/tJfliA0S2PwcXwAmdgQkK9xu6VGpohSOrOawGLsTm/w1W57YYQ5Qw3MTpSQ8gZpYgujZ8fQeN6zrruk7W6bSXbf9r7cqnW+dbHl1yrCwnwmBvkEmHi1bhNc+nwwFOX3Nman0HKtbBZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXb+QB5w; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38175907a56so713325a91.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783152441; x=1783757241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/66yiq4HZTy1MWNX7FS7c7Sg95JlQ6WyejV2Gw2GLh4=;
        b=SXb+QB5w+leNhFA6eUoQc/S2iY7OujhTXw3rlRKE/nAowGV+0aS+1TluEBt/R8WEDW
         AXuPwfi5njjfE1C+Nre+k54ILqtHdGhLqOyDNepqM3q2NDYfAbWXV5tRcOyIcMq8YgRe
         xydwai3XjUHeIG5RvmcGtpDLPA8EupHLZd1ikmB2jlJ/WnnF279XrcWFwZCWOT9JMyM/
         2yonxlxCp3yo94jjALhq81WDfilw2b59xGosBZh3RX1W2oGxBmePYFFTis/W1ijFQbNf
         bmgSjjRGtOTBxir4wJ4904nIFdW7VERBMqMgkwUu5J4m6AFDcjyX1sW1oCBN3HM8pzoC
         0n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783152441; x=1783757241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/66yiq4HZTy1MWNX7FS7c7Sg95JlQ6WyejV2Gw2GLh4=;
        b=Ej7W3f/w1Yv1pyQNWFqNSdaPzycwK0qD/quOrYC5/xfbIu058bb8pHkZMcsgMHUNGA
         satVhaSo7uOk79dvWr+lZxd9b82/ldMpysskdZJFGNVChGoa1io0RyNn2rP8MRu1v3Zq
         u/jv66EJeeyzJxfnTJaSdDv7uVrcA3LF8fvn7K/6TKlLIBO0CwcgAQQG92dkreSI9ZVO
         cngJfyIdgX8IJIdQ304FiIcLPSrD1K0jYkWgPvANJ4wm61Z2Pi8CY96NFWhmD+zjDUP4
         gk7Da1GIKWX8vFkkMJeh3icLcWG6mp+n8uovawQVpFF796TIz7AckUkumMcNJizGqrDs
         LqWg==
X-Forwarded-Encrypted: i=1; AHgh+RrO0E48Qo+1Yhe5wEepPb4qTm0MDrr2eGM/MNPP7rafsLhLGjUP8cj0ELs5Lu340rR4wK8c9Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsqcsd+m+g21H4PCmr2HCWaptF8Z2CD/EEaixVyGPBBveDdXdn
	zNOYvF7/eoG9zgu6mi2Byz9C6oHK6lCIOIsJEyjuiqj313lxPGk1lyN3
X-Gm-Gg: AfdE7cl79aGFa2HSzTXpg4XvXshlsQDhW54vgFGvbc/67PTQpFzvZGKfshnEDiryED3
	GavI95dDK/ZrC63jgNZFSFzn4gpStJpWI4oEwySUojX8/X45f1/Ccg5SXwYVxR5UtEJ85V6dnTv
	lSQlT06QtLbvTAb8WSd9KoMyTDJSFjf8+mxBaEnQlJfNe+CPAuewel087CfD4XdvZ3+t5tMFMo+
	JF131ZWjc/+sRA1QfYTm38o/59qVZFtbweP9ad83JKxZm+AmUm6K4OzJXt3JHFuonj9ppNwJUZj
	vpDXEQ3zpquLvpceMdXKMA3+rsgDoKGIcunesa3iihpD+hf9rlCBjfmEtgh1O1vDfcjIKaex9Wh
	xw6bC4cC37e7KMCz+XJ/YBb1ndVsvi5eR68gP3j4ojulUgh3f2UXBolTHNQm7WKvjFxJLWes54Y
	Ad0JmMqKg0lqoUAfo=
X-Received: by 2002:a17:90b:2e46:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-381122ec0a8mr7563473a91.12.1783152440705;
        Sat, 04 Jul 2026 01:07:20 -0700 (PDT)
Received: from archbtw ([2405:201:22:b1c5:42c3:4851:cefc:8c57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm15372751eec.12.2026.07.04.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 01:07:20 -0700 (PDT)
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
Subject: [PATCH v4] r8169: migrate Rx path to page_pool, prepare for XDP
Date: Sat,  4 Jul 2026 13:36:53 +0530
Message-ID: <20260704080653.33740-1-atharvapotdar07@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fr.zoreil.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304690-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A02C707065

Migrate the Rx path to the page_pool API. On MACs newer than
RTL_GIGA_MAC_VER_06, this replaces the alloc_pages() +
skb_copy_to_linear_data() model with napi_build_skb(), giving
zero-copy Rx delivery and laying the groundwork for XDP support.

These MACs are initialized with XDP_PACKET_HEADROOM reserved at the
start of each buffer. This space is needed for skb_push() during
bridged or routed workloads; without it, such workloads fall back to
pskb_expand_head() reallocations on every packet.

MACs up to and including RTL_GIGA_MAC_VER_06 (the original PCI
RTL8169/RTL8110 generation) are kept on the existing copy-based path,
with headroom set to 0. This is a conservative choice rather than a
response to a known, version-specific erratum: this driver's oldest
supported silicon predates the DMA-mapped shared-page model that
zero-copy Rx relies on, and there is comparatively little test
coverage for it.

The pool is locked to order-2 (SZ_16K) allocations on all MACs,
matching the existing R8169_RX_BUF_SIZE, so this migration introduces
no change in per-descriptor allocation size or jumbo-frame behavior
relative to the current tree.

The Rx consumption loop (cur_rx) is decoupled from the buffer refill
loop (dirty_rx). A page is only replaced once napi_build_skb() has
taken ownership of it; under allocation failure, or on the copy path
where the page is reused as-is, the descriptor is left in place for
the NIC to reuse on the next pass. This avoids Tx watchdog timeouts
under memory pressure that the previous unconditional-realloc model
was prone to.

DMA mapping and CPU/device cache synchronization are handled by
page_pool via PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV. The explicit
dma_sync_single_for_device() calls on the copy and failed-build_skb
paths are still required: those pages are returned to the ring
directly rather than through page_pool_put_page(), so the pool's
automatic put-time sync is never invoked for them.

Signed-off-by: Atharva Potdar <atharvapotdar07@gmail.com>
---
Testing:
- Rx path: Verified napi_build_skb() utilization via eBPF. 0 fallback allocations observed at 1Gbps line rate.
- XDP headroom: Confirmed 256B reservation via bpf_xdp_adjust_head(-14). No pskb_expand_head() calls triggered during routing.
- Error path: Injected order-2 allocation failures in the refill loop. Dropped packets as expected without triggering Tx watchdog timeouts.
- Tx ring: Toggled TSO/GSO/SG via ethtool under bidirectional TCP load. No ring stalls or watchdog timeouts.
- skmem: Ran 9k jumbo frame TCP streams. nstat showed no TcpExtTCPRcvQDrop or OfoPrune regressions.

v4:
 - Bifurcated headroom by MAC version (0 for legacy, 256 for modern).
   Older MACs (<= RTL_GIGA_MAC_VER_06) are kept on the copy path as a
   conservative choice given limited test coverage on that hardware,
   not in response to a known version-specific erratum.
 - Locked pool to order-2 allocations to prevent memory fragmentation
   and Tx watchdog panics caused by order-3 churn.
 - Fixed memory leak in error path by retaining pages for hardware reuse.
 - Fixed prefetch offset to align dynamically with payload.
v3:
 - Added XDP_PACKET_HEADROOM to prevent pskb_expand_head() routing overhead.
 - Decoupled Rx consumption (cur_rx) from buffer refill (dirty_rx).
 - Registered xdp_rxq_info mem model at pool creation time.
v2:
 - Reverted buffer size to SZ_16K to prevent MTU regression.
 - Replaced skb_add_rx_frag() with napi_build_skb().
v1:
 - Initial page_pool migration.

 drivers/net/ethernet/realtek/r8169_main.c | 141 ++++++++++++++++++----
 1 file changed, 115 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa..5b13880c7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -9,6 +9,7 @@
  * See MAINTAINERS file for support contact information.
  */
 
+#include <linux/if_link.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
@@ -31,7 +32,9 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 #include <net/phy/realtek_phy.h>
+#include <net/xdp.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -729,6 +732,9 @@ enum rtl_dash_type {
 };
 
 struct rtl8169_private {
+	struct page_pool *rx_pool;
+	struct xdp_rxq_info xdp_rxq;
+	u32 rx_headroom;
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
@@ -4161,21 +4169,14 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
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
 	rtl8169_mark_to_asic(desc);
@@ -4188,14 +4189,18 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
 	int i;
 
 	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
-		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
-			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
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
@@ -4221,12 +4226,52 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	struct page_pool_params params = {0};
+	int err;
+
 	rtl8169_init_ring_indexes(tp);
 
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
+		tp->rx_headroom = 0;
+	else
+		tp->rx_headroom = XDP_PACKET_HEADROOM;
+
+	params.order = get_order(R8169_RX_BUF_SIZE);
+	params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	params.pool_size = NUM_RX_DESC;
+	params.nid = dev_to_node(tp_to_dev(tp));
+	params.dev = tp_to_dev(tp);
+	params.napi = &tp->napi;
+	params.dma_dir = DMA_FROM_DEVICE;
+	params.offset = tp->rx_headroom;
+	params.max_len = R8169_RX_BUF_SIZE - tp->rx_headroom;
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
@@ -4768,16 +4813,39 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
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
+		rtl8169_mark_to_asic(desc);
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
 
@@ -4820,21 +4888,39 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
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
+			skb = napi_build_skb(rx_buf, R8169_RX_BUF_SIZE);
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
@@ -4848,9 +4934,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
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


