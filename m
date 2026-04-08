Return-Path: <netdev+bounces-276212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOddCdGe1Wks8AcAu9opvQ
	(envelope-from <netdev+bounces-276212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 931013B5AA7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E78E3007950
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192C17C220;
	Wed,  8 Apr 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aVn/g33D"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5C22301;
	Wed,  8 Apr 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607500; cv=none; b=bFfPpwu8akrGW/5cPmmohit/xDexd/amaYVqCTSLm9BiE6vryIAGYKtjOpQ9qv9WBsw4er+jpZ0HPOh/yF8Quu9RtC9tMd4ptFr9AKHN3vRPs0xztwjwbL0343O9Xmc5ahTKH06xSvpqsCZwhVtvKkjb0BJ7ouetdMPcGMUQhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607500; c=relaxed/simple;
	bh=I/3zrDuL4P/qG6D0+8Z2qamWffAvPYalcx8+qa/Xu68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlJ6r5sEmqqnNgxzbMBo4T3AuAFaq8xYObJzuLVsqosFGdvCSVuEqc7b8SMCrTQOgQ5P/Ol42gCsY0XtRwW8rpjhtF26ZfloaUh7Z8sacck11tGaPKkZSZuWasP5YpOOb6+Vm/9U1AraMVaH/V3Zn5Vv+JitA0dRRiFcr0dZbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aVn/g33D; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3E8A8C054EE9;
	Tue,  7 Apr 2026 17:18:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3E8A8C054EE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775607498;
	bh=I/3zrDuL4P/qG6D0+8Z2qamWffAvPYalcx8+qa/Xu68=;
	h=From:To:Cc:Subject:Date:From;
	b=aVn/g33Dq/I8vp9MrspstA8dUES66zvbPXNrUukuURzceBCy+NAk9hq3WCxujvNFD
	 Dr+Ru5TomD5EKBhc1R3dzxnyRZ3UPD+N7HsoSkih+XtrNdrTPQ1+K1onjvOwVsipao
	 Y7xw2WwAleWHMdKSqH5bsgFZmUjFc2cAp4DfTAj8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id ED127AE80;
	Tue,  7 Apr 2026 20:18:16 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <markus@blochl.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kernel@vger.kernel.org (open list),
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2] net: bcmasp: Switch to page pool for RX path
Date: Tue,  7 Apr 2026 17:18:13 -0700
Message-Id: <20260408001813.635679-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,arndb.de,blochl.de,gmail.com,suse.de,vger.kernel.org,tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276212-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid]
X-Rspamd-Queue-Id: 931013B5AA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This shows an improvement of 1.9% in reducing the CPU cycles and data
cache misses.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- addressed Nicolai's comments by setting the .netdev and .napi members
  and dropped the useless comment and .dma_dir initialization

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   8 +-
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 125 +++++++++++++++---
 .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |   4 +
 4 files changed, 115 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index dd164acafd01..4287edc7ddd6 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -272,6 +272,7 @@ config BCMASP
 	depends on OF
 	select PHYLIB
 	select MDIO_BCM_UNIMAC
+	select PAGE_POOL
 	help
 	  This configuration enables the Broadcom ASP 2.0 Ethernet controller
 	  driver which is present in Broadcom STB SoCs such as 72165.
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 29cd87335ec8..8c8ffaeadc79 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -6,6 +6,7 @@
 #include <linux/phy.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <uapi/linux/ethtool.h>
+#include <net/page_pool/helpers.h>
 
 #define ASP_INTR2_OFFSET			0x1000
 #define  ASP_INTR2_STATUS			0x0
@@ -298,16 +299,19 @@ struct bcmasp_intf {
 	void __iomem			*rx_edpkt_cfg;
 	void __iomem			*rx_edpkt_dma;
 	int				rx_edpkt_index;
-	int				rx_buf_order;
 	struct bcmasp_desc		*rx_edpkt_cpu;
 	dma_addr_t			rx_edpkt_dma_addr;
 	dma_addr_t			rx_edpkt_dma_read;
 	dma_addr_t			rx_edpkt_dma_valid;
 
-	/* RX buffer prefetcher ring*/
+	/* Streaming RX data ring (RBUF_4K mode) */
 	void				*rx_ring_cpu;
 	dma_addr_t			rx_ring_dma;
 	dma_addr_t			rx_ring_dma_valid;
+	int				rx_buf_order;
+
+	/* Page pool for recycling RX SKB data pages */
+	struct page_pool		*rx_page_pool;
 	struct napi_struct		rx_napi;
 
 	struct bcmasp_res		res;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index b368ec2fea43..ec63f50a849e 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/page_pool/helpers.h>
 
 #include "bcmasp.h"
 #include "bcmasp_intf_defs.h"
@@ -482,10 +483,14 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 	struct bcmasp_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t valid;
+	struct page *page;
 	void *data;
 	u64 flags;
 	u32 len;
 
+	/* Hardware advances DMA_VALID as it writes each descriptor
+	 * (RBUF_4K streaming mode); software chases with rx_edpkt_dma_read.
+	 */
 	valid = rx_edpkt_dma_rq(intf, RX_EDPKT_DMA_VALID) + 1;
 	if (valid == intf->rx_edpkt_dma_addr + DESC_RING_SIZE)
 		valid = intf->rx_edpkt_dma_addr;
@@ -493,12 +498,12 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 	while ((processed < budget) && (valid != intf->rx_edpkt_dma_read)) {
 		desc = &intf->rx_edpkt_cpu[intf->rx_edpkt_index];
 
-		/* Ensure that descriptor has been fully written to DRAM by
-		 * hardware before reading by the CPU
+		/* Ensure the descriptor has been fully written to DRAM by
+		 * the hardware before the CPU reads it.
 		 */
 		rmb();
 
-		/* Calculate virt addr by offsetting from physical addr */
+		/* Locate the packet data inside the streaming ring buffer. */
 		data = intf->rx_ring_cpu +
 			(DESC_ADDR(desc->buf) - intf->rx_ring_dma);
 
@@ -524,19 +529,38 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 
 		len = desc->size;
 
-		skb = napi_alloc_skb(napi, len);
-		if (!skb) {
+		/* Allocate a page pool page as the SKB data area so the
+		 * kernel can recycle it efficiently after the packet is
+		 * consumed, avoiding repeated slab allocations.
+		 */
+		page = page_pool_dev_alloc_pages(intf->rx_page_pool);
+		if (!page) {
 			u64_stats_update_begin(&stats->syncp);
 			u64_stats_inc(&stats->rx_dropped);
 			u64_stats_update_end(&stats->syncp);
 			intf->mib.alloc_rx_skb_failed++;
+			goto next;
+		}
 
+		skb = napi_build_skb(page_address(page), PAGE_SIZE);
+		if (!skb) {
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->rx_dropped);
+			u64_stats_update_end(&stats->syncp);
+			intf->mib.alloc_rx_skb_failed++;
+			page_pool_recycle_direct(intf->rx_page_pool, page);
 			goto next;
 		}
 
+		/* Reserve headroom then copy the full descriptor payload
+		 * (hardware prepends a 2-byte alignment pad at the start).
+		 */
+		skb_reserve(skb, NET_SKB_PAD);
 		skb_put(skb, len);
 		memcpy(skb->data, data, len);
+		skb_mark_for_recycle(skb);
 
+		/* Skip the 2-byte hardware alignment pad. */
 		skb_pull(skb, 2);
 		len -= 2;
 		if (likely(intf->crc_fwd)) {
@@ -558,6 +582,7 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 		u64_stats_update_end(&stats->syncp);
 
 next:
+		/* Return this portion of the streaming ring buffer to HW. */
 		rx_edpkt_cfg_wq(intf, (DESC_ADDR(desc->buf) + desc->size),
 				RX_EDPKT_RING_BUFFER_READ);
 
@@ -661,12 +686,31 @@ static void bcmasp_adj_link(struct net_device *dev)
 		phy_print_status(phydev);
 }
 
-static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
+static struct page_pool *
+bcmasp_rx_page_pool_create(struct bcmasp_intf *intf)
+{
+	struct page_pool_params pp_params = {
+		.order		= 0,
+		.flags		= 0,
+		.pool_size	= NUM_4K_BUFFERS,
+		.nid		= NUMA_NO_NODE,
+		.dev		= &intf->parent->pdev->dev,
+		.napi		= &intf->rx_napi,
+		.netdev		= intf->ndev,
+		.offset		= 0,
+		.max_len	= PAGE_SIZE,
+	};
+
+	return page_pool_create(&pp_params);
+}
+
+static int bcmasp_alloc_rx_buffers(struct bcmasp_intf *intf)
 {
 	struct device *kdev = &intf->parent->pdev->dev;
 	struct page *buffer_pg;
+	int ret;
 
-	/* Alloc RX */
+	/* Contiguous streaming ring that hardware writes packet data into. */
 	intf->rx_buf_order = get_order(RING_BUFFER_SIZE);
 	buffer_pg = alloc_pages(GFP_KERNEL, intf->rx_buf_order);
 	if (!buffer_pg)
@@ -675,13 +719,55 @@ static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
 	intf->rx_ring_cpu = page_to_virt(buffer_pg);
 	intf->rx_ring_dma = dma_map_page(kdev, buffer_pg, 0, RING_BUFFER_SIZE,
 					 DMA_FROM_DEVICE);
-	if (dma_mapping_error(kdev, intf->rx_ring_dma))
-		goto free_rx_buffer;
+	if (dma_mapping_error(kdev, intf->rx_ring_dma)) {
+		ret = -ENOMEM;
+		goto free_ring_pages;
+	}
+
+	/* Page pool for SKB data areas (copy targets, not DMA buffers). */
+	intf->rx_page_pool = bcmasp_rx_page_pool_create(intf);
+	if (IS_ERR(intf->rx_page_pool)) {
+		ret = PTR_ERR(intf->rx_page_pool);
+		intf->rx_page_pool = NULL;
+		goto free_ring_dma;
+	}
+
+	return 0;
+
+free_ring_dma:
+	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
+		       DMA_FROM_DEVICE);
+free_ring_pages:
+	__free_pages(buffer_pg, intf->rx_buf_order);
+	return ret;
+}
+
+static void bcmasp_reclaim_rx_buffers(struct bcmasp_intf *intf)
+{
+	struct device *kdev = &intf->parent->pdev->dev;
+
+	page_pool_destroy(intf->rx_page_pool);
+	intf->rx_page_pool = NULL;
+	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
+		       DMA_FROM_DEVICE);
+	__free_pages(virt_to_page(intf->rx_ring_cpu), intf->rx_buf_order);
+}
+
+static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
+{
+	struct device *kdev = &intf->parent->pdev->dev;
+	int ret;
+
+	/* Alloc RX */
+	ret = bcmasp_alloc_rx_buffers(intf);
+	if (ret)
+		return ret;
 
 	intf->rx_edpkt_cpu = dma_alloc_coherent(kdev, DESC_RING_SIZE,
-						&intf->rx_edpkt_dma_addr, GFP_KERNEL);
+						&intf->rx_edpkt_dma_addr,
+						GFP_KERNEL);
 	if (!intf->rx_edpkt_cpu)
-		goto free_rx_buffer_dma;
+		goto free_rx_buffers;
 
 	/* Alloc TX */
 	intf->tx_spb_cpu = dma_alloc_coherent(kdev, DESC_RING_SIZE,
@@ -701,11 +787,8 @@ static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
 free_rx_edpkt_dma:
 	dma_free_coherent(kdev, DESC_RING_SIZE, intf->rx_edpkt_cpu,
 			  intf->rx_edpkt_dma_addr);
-free_rx_buffer_dma:
-	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
-		       DMA_FROM_DEVICE);
-free_rx_buffer:
-	__free_pages(buffer_pg, intf->rx_buf_order);
+free_rx_buffers:
+	bcmasp_reclaim_rx_buffers(intf);
 
 	return -ENOMEM;
 }
@@ -717,9 +800,7 @@ static void bcmasp_reclaim_free_buffers(struct bcmasp_intf *intf)
 	/* RX buffers */
 	dma_free_coherent(kdev, DESC_RING_SIZE, intf->rx_edpkt_cpu,
 			  intf->rx_edpkt_dma_addr);
-	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
-		       DMA_FROM_DEVICE);
-	__free_pages(virt_to_page(intf->rx_ring_cpu), intf->rx_buf_order);
+	bcmasp_reclaim_rx_buffers(intf);
 
 	/* TX buffers */
 	dma_free_coherent(kdev, DESC_RING_SIZE, intf->tx_spb_cpu,
@@ -738,7 +819,7 @@ static void bcmasp_init_rx(struct bcmasp_intf *intf)
 	/* Make sure channels are disabled */
 	rx_edpkt_cfg_wl(intf, 0x0, RX_EDPKT_CFG_ENABLE);
 
-	/* Rx SPB */
+	/* Streaming data ring: hardware writes raw packet bytes here. */
 	rx_edpkt_cfg_wq(intf, intf->rx_ring_dma, RX_EDPKT_RING_BUFFER_READ);
 	rx_edpkt_cfg_wq(intf, intf->rx_ring_dma, RX_EDPKT_RING_BUFFER_WRITE);
 	rx_edpkt_cfg_wq(intf, intf->rx_ring_dma, RX_EDPKT_RING_BUFFER_BASE);
@@ -747,7 +828,9 @@ static void bcmasp_init_rx(struct bcmasp_intf *intf)
 	rx_edpkt_cfg_wq(intf, intf->rx_ring_dma_valid,
 			RX_EDPKT_RING_BUFFER_VALID);
 
-	/* EDPKT */
+	/* EDPKT descriptor ring: hardware fills descriptors pointing into
+	 * the streaming ring buffer above (RBUF_4K mode).
+	 */
 	rx_edpkt_cfg_wl(intf, (RX_EDPKT_CFG_CFG0_RBUF_4K <<
 			RX_EDPKT_CFG_CFG0_DBUF_SHIFT) |
 		       (RX_EDPKT_CFG_CFG0_64_ALN <<
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
index af7418348e81..0318f257452a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
@@ -246,6 +246,10 @@
 	((((intf)->channel - 6) * 0x14) + 0xa2000)
 #define  RX_SPB_TOP_BLKOUT		0x00
 
+/*
+ * Number of 4 KB pages that make up the contiguous RBUF_4K streaming ring
+ * and the page pool used as copy-target SKB data areas.
+ */
 #define NUM_4K_BUFFERS			32
 #define RING_BUFFER_SIZE		(PAGE_SIZE * NUM_4K_BUFFERS)
 
-- 
2.34.1


