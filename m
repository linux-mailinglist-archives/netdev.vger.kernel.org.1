Return-Path: <netdev+bounces-302304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NsN8CjtJP2q8RAkAu9opvQ
	(envelope-from <netdev+bounces-302304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F936D109E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:53:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HfXm0nH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302304-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302304-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 009093018D17
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1B3769F5;
	Sat, 27 Jun 2026 03:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B85369972
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 03:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532406; cv=none; b=rCEBd4HGGsM4PMAFA1cGj46ojj4BPW0E+ysoYVP7ojEdMIO1+8kr/Y7RzeIafoo9iyNJkVNdlBjMgQf4aNhN/xhZ5RyW7jS7Vw77vxa5G+D3/ROKATlqG/Aw//GqiNQpyaOH8V1h0+kXBXu0dqyTQxAqCFsRYdDjuOC1/nCjj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532406; c=relaxed/simple;
	bh=ETblho3kML3xNG+kPNK/R7JFDZnBj9K4luFtMCfdKlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxU9qnwUsEXqY20z/W34uuZHeIq6Ux/4+2BmBw8TlTES1gUa9egBMwpXeqiIGf4cbhyHUv128kbLVljEPdO03FTy49UH3ygOcA9GgWIo0aISKgZedycNGrM+/JxOGB5brQKvyeuSccPe4k2S0RwBNEDrB8jvjx2GIhGa7V5p6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfXm0nH3; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bc871ecdfso2178026eec.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782532397; x=1783137197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQNrL9braNEccOjKmgbxk/VmLxwleiapiKYQvIiDJSQ=;
        b=HfXm0nH3ma6/Qr/LTpwEeoDkFLtUB4eWDDjSeGbxsLHkxUCX2lAxa5eodMnL79p2vD
         Ikqhpri6z+k3wXk2RzBu2tJJJ5c7aNAtji+guzyxW2sLZvRFnJ2uM9VTfbSUzVOHkPCl
         QpK4n3lfX4o64g8mBGErz/03RPui5Anxdifsu+h9n5dzYS92L8aawZ2pZL+6fgWXF7NP
         3Yjlm6IxkGuzM9SKhjP4GerXyHCskR47sNIs5xSmMebeFpLdNSqbfqvIwMcVm4FNTKd4
         XojQp32VW8znurnQhqBQEnPJoXpKJJJx8SY+pJqc9lPJaokEn4q00XGlCd82Lp3HtJ8q
         EK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782532397; x=1783137197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQNrL9braNEccOjKmgbxk/VmLxwleiapiKYQvIiDJSQ=;
        b=Z30622KGbX80xdUkXoah9dND8XpTFsodhdQ0Q+kKkfhqCaanPxDkXYqoUoiEKemlbZ
         R9SA5fA8m6uYHzM39nQ4bLIAFXjKDG/QhURNrL3RTkKgf8B7qdyzAU+pLqy/G/LmcI6e
         KfGABVlxrnohiT9C674hWlBubfaYExBf7AewMVuRR70lb8r5mpF3mf9VyvL0pNxt7sDg
         gZ3kdRrrvcKhxL36cfoPrtCLjlgFuGrEhFxCgr+qIfGaztljuoyzwWvdHb8N8Gm/EbHz
         ihTMUtdpLCT86lQ33frds8FnbtDc+C5LyVFzHgfqQS8xF+ER43yM29DpK/ve0LeFKjss
         t/pA==
X-Forwarded-Encrypted: i=1; AHgh+RoAXYMic+5iZM5oP8uTMJ9kXe4Xp/bWkHnhbAo1KllgzBlEY0ZvRxodTQyi4ulyGwB00IyWmgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWcjcx49rTVyaWC40ResNNRARDmduh+0p4EKX6yzwRqzwAPyk
	m4L5NrDMudeq65YW3KAOyDYqI2BmfSKTtk4N5/hRhTIKCM/nBk49NI8b
X-Gm-Gg: AfdE7ck9YFrPcbKyu2HQCdvqPLAC+Dh4BIHTwhwH592UeMOYyrQqA/+bTPPRy/t0KiP
	tA4daw/2PmDZ2uomIRreQ1kup6mQORs0pB3FpdXvkE0cEPycqFS5jrbJuYH+vQOlQqTVEHdg0IM
	O8jAkRFwSyyDKfMJ79pmuxROgdcFJN1k9b7bwUS+FkzN3lJ4I5Id7bGp7HJ8G+i183+1eC/IM/l
	bzm7zzHoSKt/h6Lae4HSVdM1UXJz4E503i0mT6S7qIYhH6tUVh7olSJeXju2/ctuuDy4kB7HLr+
	AJCG6OnO1LGvvz778IQByqNH7GdvYmFvPSk1+q+sGkGsiTJJXM9n9sX/SHlvKw69GmAIeqDl6rG
	DYTtojgcSlfWqnG+6+Gnd5LDU0GpWmfv5bZ7HwWK8bdLokuaR+2ugHulrD6MnYKFh/QgK0nyR8o
	pAQxaRAk6DsGtbIpA=
X-Received: by 2002:a05:7300:578f:b0:30c:7dcb:c8fb with SMTP id 5a478bee46e88-30c84d51fc8mr9403164eec.11.1782532397077;
        Fri, 26 Jun 2026 20:53:17 -0700 (PDT)
Received: from archbtw ([2405:201:22:b1c5:42c3:4851:cefc:8c57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30d3af0d2e4sm1307957eec.22.2026.06.26.20.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 20:53:16 -0700 (PDT)
From: atharva-potdar <atharvapotdar07@gmail.com>
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
Subject: [PATCH net-next v2] r8169: migrate Rx path to page_pool
Date: Sat, 27 Jun 2026 09:22:41 +0530
Message-ID: <20260627035241.59689-1-atharvapotdar07@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fr.zoreil.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302304-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,params.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9F936D109E

Migrate the Rx path to use the page_pool API, replacing the legacy
alloc_pages() + skb_copy() model with napi_build_skb() for zero-copy
delivery. This prepares the driver for future XDP support.

To prevent MTU regressions and DMA overflows on older MACs
(CVE-2009-1389), the pool allocates higher-order pages using
get_order(SZ_16K), matching the legacy driver behavior.

DMA mapping and cache syncing are delegated to the page_pool core via
PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV to ensure safe operation across
all architectures.

Signed-off-by: atharva-potdar <atharvapotdar07@gmail.com>
---
v2:
 - Reverted buffer size to SZ_16K and utilized get_order(SZ_16K) to 
   prevent MTU regression and mitigate CVE-2009-1389.
 - Use napi_build_skb() instead of skb_add_rx_frag() to keep ethernet
   headers in the linear data area.

 drivers/net/ethernet/realtek/r8169_main.c | 77 ++++++++++++++++-------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa..a9bedf93b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -31,6 +31,7 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 #include <net/phy/realtek_phy.h>
 
 #include "r8169.h"
@@ -729,6 +730,7 @@ enum rtl_dash_type {
 };
 
 struct rtl8169_private {
+	struct page_pool *rx_pool;
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
 	struct net_device *dev;
@@ -4161,21 +4163,14 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
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
+	mapping = page_pool_get_dma_addr(data);
 
 	desc->addr = cpu_to_le64(mapping);
 	rtl8169_mark_to_asic(desc);
@@ -4188,14 +4183,16 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp)
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
+		page_pool_destroy(tp->rx_pool);
+		tp->rx_pool = NULL;
+	}
 }
 
 static int rtl8169_rx_fill(struct rtl8169_private *tp)
@@ -4221,8 +4218,26 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	struct page_pool_params params = {0};
+
 	rtl8169_init_ring_indexes(tp);
 
+	params.order = get_order(SZ_16K);
+	params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	params.pool_size = NUM_RX_DESC;
+	params.dev = tp_to_dev(tp);
+	params.nid = dev_to_node(tp_to_dev(tp));
+	params.dma_dir = DMA_FROM_DEVICE;
+	params.offset = 0;
+	params.max_len = SZ_16K;
+	tp->rx_pool = page_pool_create(&params);
+	if (IS_ERR(tp->rx_pool)) {
+		int err = PTR_ERR(tp->rx_pool);
+
+		tp->rx_pool = NULL;
+		return err;
+	}
+
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
 	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
@@ -4777,6 +4792,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
 		struct RxDesc *desc = tp->RxDescArray + entry;
 		struct sk_buff *skb;
+		struct page *new_page;
 		const void *rx_buf;
 		dma_addr_t addr;
 		u32 status;
@@ -4820,21 +4836,36 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
-		if (unlikely(!skb)) {
-			dev->stats.rx_dropped++;
-			goto release_descriptor;
-		}
-
 		addr = le64_to_cpu(desc->addr);
 		rx_buf = page_address(tp->Rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
-		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
-		skb->tail += pkt_size;
-		skb->len = pkt_size;
-		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+
+		new_page = page_pool_dev_alloc_pages(tp->rx_pool);
+		if (unlikely(!new_page)) {
+			skb = napi_alloc_skb(&tp->napi, pkt_size);
+			if (unlikely(!skb)) {
+				dev->stats.rx_dropped++;
+				goto release_descriptor;
+			}
+			skb_copy_to_linear_data(skb, rx_buf, pkt_size);
+			skb_put(skb, pkt_size);
+			dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
+		} else {
+			skb = napi_build_skb(page_address(tp->Rx_databuff[entry]), SZ_16K);
+			if (unlikely(!skb)) {
+				page_pool_recycle_direct(tp->rx_pool, new_page);
+				dev->stats.rx_dropped++;
+				goto release_descriptor;
+			}
+
+			skb_put(skb, pkt_size);
+			skb_mark_for_recycle(skb);
+
+			tp->Rx_databuff[entry] = new_page;
+			desc->addr = cpu_to_le64(page_pool_get_dma_addr(new_page));
+		}
 
 		rtl8169_rx_csum(skb, status);
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.54.0


