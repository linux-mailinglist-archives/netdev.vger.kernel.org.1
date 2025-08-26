Return-Path: <netdev+bounces-216881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90690B35B24
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFFA203AAC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29429BDBA;
	Tue, 26 Aug 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MQbJ4U5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEF30AAC2
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207052; cv=none; b=XZ7RoK9jDk97e93GG6VzOJ6PlxvNnrBbeYfVsrb0yts0mIB5IVrD+c1vdamdSTPHq+LMzjUr6JD9exmf0cIZD53BxNXvmnRFZ+CG/weVMcO1R0FlIinn4AQfQ01VMdI/FsKCR7urHM7WytMes0GTB/0BvgkC0TczXi38D/YqzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207052; c=relaxed/simple;
	bh=xUOJOGIBI/Ab7PsDcS/Z/ObpiLrK6OlJia54hjD6jAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahrjxty4WxGeRZLZsUMD3mOWySKLpOG9aNjjOQmSBWBaAXoiW3DdMEcGAZgOe0mZ5aMJilWlJmLAQNGQFMsyvRBy7a3qr9UQ2i7CBEG4fzvv+niUxyDm29PA3acjTCRTtPYngfo3RnQl9xNH28oaLOATyB9u5hExwQ/MOPSSujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MQbJ4U5W; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-70ba7aa131fso65789396d6.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207049; x=1756811849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP28y4tmkwBBf/S5bkiGCKGV5c1uecqzwrqKc4sBSe8=;
        b=UvhrX9GCWFMuLscrRDXCQ6jrz6WQX+LAdTVLTnEM7Hg+moDfFGHO9v7dJg/gALLsZM
         YKbAy50SFHyZpK98d7YRHbjJLG+mEAc6MPYRvE5d1iuoJX3mnX4CYoXFBwdh9RzHW1OC
         9qPVWPbUBCy6gvG+/iDe/QjmnoG4+49Wju8/fg0B04l5jN8HqcJYKi314pS8Sbp6OZvW
         Z5sQ11d5DYpenQKw40MSKKvTBBx1WTPcyy38JsSict5xYJw3gzi6K8vEyj1MNZktE3L6
         sp5eIFy4PgW8x6wCC8iCj9YWkwfyzBRrU4W0QRvdzvLOLQYGtfiXDtTJ+OBAilnJqDjX
         0TcA==
X-Gm-Message-State: AOJu0Yx7qPeIz0gYook/MJzi+2oHrN8jT7NoejnFo6uAovNkIpVFzUpb
	39rYuY1+UHd11mON5kcZCRfERPujdVb6LG/0bHnKKPiiLbOnZMRuV1B9d60yikyO8Y3dfdtq+Gj
	GwACa9Fp1kmoK2ebDzTpRYq413NAIf5ktkLzVhrVPmzob1xj980R7hAGG7HUEar8lg3UQ2z1Cn6
	X2tucK0SQOMGqjhWTOl5hW295Q5AA+TidB5uP3vkywUuJKc/GtgM3PrnIseBOUHHHYhgBlIJslQ
	0uwVdEQTlOBlFFSkQnW
X-Gm-Gg: ASbGncuoy67lEVJ0OL1fh1BH4JxeMUA0UjF/KHnJ/8XCrpcqjEoR8x+7G9GqcqxmuFu
	ZEKy59A1bbvsWPq3hroQq7tBl5pfQMVDpLzaK64ZCTJe9GyEdPnox0ti5Fbz8NMf83N+telyvw4
	espWBB+2WdUXkrjoJSpauEqCAaK7Cn8Zv2q/bJb9ld7PH4jX0pCb0ri9pobwkC46xPs27hJejHs
	ddZxhgdQmTrBwpYFx2AyBAMIiDBJHBk4Cbqi5d1dpLmMp+sIu3fo0M5zD/RfxQKzYNJjgEae6Xx
	qW4/o20oXVheSrBbNgcP2ptAQ2ty9W12F5uXrBlAMVCYepN+DapHkN6GjcWpPN1tR6B+Q2IZkJ9
	a1pv4sV6ML/rGkuw7IzMuz9A+tSt82ydgVZWdaJD5lw8bGT1BgerNrMFQA3OcWWpmK/YvQnkdFL
	RYbPWV+Q==
X-Google-Smtp-Source: AGHT+IGhLz1+/AnjO0T5hneGkj+7X5Eq9woVFEQL/lWtHW98Y4FD4DkO4jKhpw7iANsV0smkAIw8a2CMkDKC
X-Received: by 2002:a05:6214:2423:b0:70d:bee7:22a8 with SMTP id 6a1803df08f44-70dbee72539mr84115316d6.13.1756207049595;
        Tue, 26 Aug 2025 04:17:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70da713a76dsm7501256d6.3.2025.08.26.04.17.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e43782aaso1973772b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207048; x=1756811848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP28y4tmkwBBf/S5bkiGCKGV5c1uecqzwrqKc4sBSe8=;
        b=MQbJ4U5WzdhNThgULT4ie9d8/uQ3SIRTC+4WHeoj5Kz7sK3fL0LfDuOzZQ6sqCNkMJ
         6tPT6WXxu5MgVIQZjVs1wDFBnJSHyXf7uEW7RwPEsQWimYy9llCmuA9cwBvW4wEnDXn0
         KlPDE2esjvPu5lg1UbcmsyhNQeKyylMaxUJek=
X-Received: by 2002:a05:6a00:2e18:b0:771:fc20:45e7 with SMTP id d2e1a72fcca58-771fc204c98mr1803329b3a.17.1756207048053;
        Tue, 26 Aug 2025 04:17:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:771:fc20:45e7 with SMTP id d2e1a72fcca58-771fc204c98mr1803281b3a.17.1756207047512;
        Tue, 26 Aug 2025 04:17:27 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:26 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 1/9] bng_en: Add initial support for RX and TX rings
Date: Tue, 26 Aug 2025 16:44:04 +0000
Message-ID: <20250826164412.220565-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate data structures to support RX, AGG, and TX rings.
While data structures for RX/AGG rings are allocated,
initialise the page pool accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 350 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  89 ++++-
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  58 +++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |  12 +
 6 files changed, 509 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 0fc10e6c6902..9fdef874f5ca 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -257,6 +257,7 @@ config BNGE
 	tristate "Broadcom Ethernet device support"
 	depends on PCI
 	select NET_DEVLINK
+	select PAGE_POOL
 	help
 	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
 	  The module will be called bng_en. To compile this driver as a module,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 1560ec676ae0..2d3b2fd57be4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -133,6 +133,7 @@ struct bnge_dev {
 
 	unsigned long           state;
 #define BNGE_STATE_DRV_REGISTERED      0
+#define BNGE_STATE_OPEN			1
 
 	u64			fw_cap;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 02254934f3d0..947072707e64 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -14,10 +14,338 @@
 #include <linux/if.h>
 #include <net/ip.h>
 #include <linux/skbuff.h>
+#include <net/page_pool/helpers.h>
 
 #include "bnge.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
+#include "bnge_rmem.h"
+
+#define BNGE_RING_TO_TC_OFF(bd, tx)	\
+	((tx) % (bd)->tx_nr_rings_per_tc)
+
+#define BNGE_RING_TO_TC(bd, tx)		\
+	((tx) / (bd)->tx_nr_rings_per_tc)
+
+static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
+{
+	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
+}
+
+static void bnge_free_rx_rings(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->rx_ring)
+		return;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+		struct bnge_ring_struct *ring;
+
+		page_pool_destroy(rxr->page_pool);
+		page_pool_destroy(rxr->head_pool);
+		rxr->page_pool = rxr->head_pool = NULL;
+
+		kfree(rxr->rx_agg_bmap);
+		rxr->rx_agg_bmap = NULL;
+
+		ring = &rxr->rx_ring_struct;
+		bnge_free_ring(bd, &ring->ring_mem);
+
+		ring = &rxr->rx_agg_ring_struct;
+		bnge_free_ring(bd, &ring->ring_mem);
+	}
+}
+
+static int bnge_alloc_rx_page_pool(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr,
+				   int numa_node)
+{
+	const unsigned int agg_size_fac = PAGE_SIZE / BNGE_RX_PAGE_SIZE;
+	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
+	struct page_pool_params pp = { 0 };
+	struct bnge_dev *bd = bn->bd;
+	struct page_pool *pool;
+
+	pp.pool_size = bn->rx_agg_ring_size / agg_size_fac;
+	pp.nid = numa_node;
+	pp.netdev = bn->netdev;
+	pp.dev = bd->dev;
+	pp.dma_dir = bn->rx_dir;
+	pp.max_len = PAGE_SIZE;
+	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	pp.queue_idx = rxr->bnapi->index;
+
+	pool = page_pool_create(&pp);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+	rxr->page_pool = pool;
+
+	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	if (bnge_separate_head_pool(rxr)) {
+		pp.pool_size = min(bn->rx_ring_size / rx_size_fac, 1024);
+		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pool = page_pool_create(&pp);
+		if (IS_ERR(pool))
+			goto err_destroy_pp;
+	} else {
+		page_pool_get(pool);
+	}
+	rxr->head_pool = pool;
+
+	return 0;
+
+err_destroy_pp:
+	page_pool_destroy(rxr->page_pool);
+	rxr->page_pool = NULL;
+	return PTR_ERR(pool);
+}
+
+static void bnge_enable_rx_page_pool(struct bnge_rx_ring_info *rxr)
+{
+	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
+	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);
+}
+
+static int bnge_alloc_rx_agg_bmap(struct bnge_net *bn,
+				  struct bnge_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bn->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int bnge_alloc_rx_rings(struct bnge_net *bn)
+{
+	int i, rc = 0, agg_rings = 0, cpu;
+	struct bnge_dev *bd = bn->bd;
+
+	if (!bn->rx_ring)
+		return -ENOMEM;
+
+	if (bnge_is_agg_reqd(bd))
+		agg_rings = 1;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+		struct bnge_ring_struct *ring;
+		int cpu_node;
+
+		ring = &rxr->rx_ring_struct;
+
+		cpu = cpumask_local_spread(i, dev_to_node(bd->dev));
+		cpu_node = cpu_to_node(cpu);
+		netdev_dbg(bn->netdev, "Allocating page pool for rx_ring[%d] on numa_node: %d\n",
+			   i, cpu_node);
+		rc = bnge_alloc_rx_page_pool(bn, rxr, cpu_node);
+		if (rc)
+			return rc;
+		bnge_enable_rx_page_pool(rxr);
+
+		rc = bnge_alloc_ring(bd, &ring->ring_mem);
+		if (rc)
+			return rc;
+
+		ring->grp_idx = i;
+		if (agg_rings) {
+			ring = &rxr->rx_agg_ring_struct;
+			rc = bnge_alloc_ring(bd, &ring->ring_mem);
+			if (rc)
+				return rc;
+
+			ring->grp_idx = i;
+			rc = bnge_alloc_rx_agg_bmap(bn, rxr);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return rc;
+}
+
+static void bnge_free_tx_rings(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->tx_ring)
+		return;
+
+	for (i = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		struct bnge_ring_struct *ring;
+
+		ring = &txr->tx_ring_struct;
+
+		bnge_free_ring(bd, &ring->ring_mem);
+	}
+}
+
+static int bnge_alloc_tx_rings(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j, rc;
+
+	for (i = 0, j = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		struct bnge_ring_struct *ring;
+		u8 qidx;
+
+		ring = &txr->tx_ring_struct;
+
+		rc = bnge_alloc_ring(bd, &ring->ring_mem);
+		if (rc)
+			return rc;
+
+		ring->grp_idx = txr->bnapi->index;
+		qidx = bd->tc_to_qidx[j];
+		ring->queue_id = bd->q_info[qidx].queue_id;
+		if (BNGE_RING_TO_TC_OFF(bd, i) == (bd->tx_nr_rings_per_tc - 1))
+			j++;
+	}
+
+	return 0;
+}
+
+static void bnge_free_core(struct bnge_net *bn)
+{
+	bnge_free_tx_rings(bn);
+	bnge_free_rx_rings(bn);
+	kfree(bn->tx_ring_map);
+	bn->tx_ring_map = NULL;
+	kfree(bn->tx_ring);
+	bn->tx_ring = NULL;
+	kfree(bn->rx_ring);
+	bn->rx_ring = NULL;
+	kfree(bn->bnapi);
+	bn->bnapi = NULL;
+}
+
+static int bnge_alloc_core(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j, size, arr_size;
+	int rc = -ENOMEM;
+	void *bnapi;
+
+	arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
+			bd->nq_nr_rings);
+	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
+	bnapi = kzalloc(arr_size + size * bd->nq_nr_rings, GFP_KERNEL);
+	if (!bnapi)
+		return rc;
+
+	bn->bnapi = bnapi;
+	bnapi += arr_size;
+	for (i = 0; i < bd->nq_nr_rings; i++, bnapi += size) {
+		struct bnge_nq_ring_info *nqr;
+
+		bn->bnapi[i] = bnapi;
+		bn->bnapi[i]->index = i;
+		bn->bnapi[i]->bn = bn;
+		nqr = &bn->bnapi[i]->nq_ring;
+		nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
+	}
+
+	bn->rx_ring = kcalloc(bd->rx_nr_rings,
+			      sizeof(struct bnge_rx_ring_info),
+			      GFP_KERNEL);
+	if (!bn->rx_ring)
+		goto err_free_core;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		rxr->rx_ring_struct.ring_mem.flags =
+			BNGE_RMEM_RING_PTE_FLAG;
+		rxr->rx_agg_ring_struct.ring_mem.flags =
+			BNGE_RMEM_RING_PTE_FLAG;
+		rxr->bnapi = bn->bnapi[i];
+		bn->bnapi[i]->rx_ring = &bn->rx_ring[i];
+	}
+
+	bn->tx_ring = kcalloc(bd->tx_nr_rings,
+			      sizeof(struct bnge_tx_ring_info),
+			      GFP_KERNEL);
+	if (!bn->tx_ring)
+		goto err_free_core;
+
+	bn->tx_ring_map = kcalloc(bd->tx_nr_rings, sizeof(u16),
+				  GFP_KERNEL);
+
+	if (!bn->tx_ring_map)
+		goto err_free_core;
+
+	if (bd->flags & BNGE_EN_SHARED_CHNL)
+		j = 0;
+	else
+		j = bd->rx_nr_rings;
+
+	for (i = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		struct bnge_napi *bnapi2;
+		int k;
+
+		txr->tx_ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
+		bn->tx_ring_map[i] = i;
+		k = j + BNGE_RING_TO_TC_OFF(bd, i);
+
+		bnapi2 = bn->bnapi[k];
+		txr->txq_index = i;
+		txr->tx_napi_idx =
+			BNGE_RING_TO_TC(bd, txr->txq_index);
+		bnapi2->tx_ring[txr->tx_napi_idx] = txr;
+		txr->bnapi = bnapi2;
+	}
+
+	bnge_init_ring_struct(bn);
+
+	rc = bnge_alloc_rx_rings(bn);
+	if (rc)
+		goto err_free_core;
+
+	rc = bnge_alloc_tx_rings(bn);
+	if (rc)
+		goto err_free_core;
+
+	return 0;
+
+err_free_core:
+	bnge_free_core(bn);
+	return rc;
+}
+
+static int bnge_open_core(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	netif_carrier_off(bn->netdev);
+
+	rc = bnge_reserve_rings(bd);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_reserve_rings err: %d\n", rc);
+		return rc;
+	}
+
+	rc = bnge_alloc_core(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_alloc_core err: %d\n", rc);
+		return rc;
+	}
+
+	set_bit(BNGE_STATE_OPEN, &bd->state);
+	return 0;
+}
 
 static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
@@ -28,11 +356,30 @@ static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static int bnge_open(struct net_device *dev)
 {
-	return 0;
+	struct bnge_net *bn = netdev_priv(dev);
+	int rc;
+
+	rc = bnge_open_core(bn);
+	if (rc)
+		netdev_err(dev, "bnge_open_core err: %d\n", rc);
+
+	return rc;
+}
+
+static void bnge_close_core(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_core(bn);
 }
 
 static int bnge_close(struct net_device *dev)
 {
+	struct bnge_net *bn = netdev_priv(dev);
+
+	bnge_close_core(bn);
+
 	return 0;
 }
 
@@ -238,6 +585,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 
 	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
 	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
+	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
 	bnge_set_ring_params(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index a650d71a58db..92bae665f59c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -113,7 +113,7 @@ struct bnge_sw_rx_bd {
 };
 
 struct bnge_sw_rx_agg_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
@@ -164,6 +164,14 @@ struct bnge_net {
 	struct hlist_head	l2_fltr_hash_tbl[BNGE_L2_FLTR_HASH_SIZE];
 	u32			hash_seed;
 	u64			toeplitz_prefix;
+
+	struct bnge_napi		**bnapi;
+
+	struct bnge_rx_ring_info	*rx_ring;
+	struct bnge_tx_ring_info	*tx_ring;
+
+	u16				*tx_ring_map;
+	enum dma_data_direction		rx_dir;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -203,4 +211,83 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 #define BNGE_MAX_RX_JUM_DESC_CNT	(RX_DESC_CNT * MAX_RX_AGG_PAGES - 1)
 #define BNGE_MAX_TX_DESC_CNT		(TX_DESC_CNT * MAX_TX_PAGES - 1)
 
+#define BNGE_MAX_TXR_PER_NAPI	8
+
+#define bnge_for_each_napi_tx(iter, bnapi, txr)		\
+	for (iter = 0, txr = (bnapi)->tx_ring[0]; txr;	\
+	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
+	     (bnapi)->tx_ring[++iter] : NULL)
+
+struct bnge_cp_ring_info {
+	struct bnge_napi	*bnapi;
+	dma_addr_t		*desc_mapping;
+	struct tx_cmp		**desc_ring;
+	struct bnge_ring_struct	ring_struct;
+};
+
+struct bnge_nq_ring_info {
+	struct bnge_napi	*bnapi;
+	dma_addr_t		*desc_mapping;
+	struct nqe_cn		**desc_ring;
+	struct bnge_ring_struct	ring_struct;
+};
+
+struct bnge_rx_ring_info {
+	struct bnge_napi	*bnapi;
+	struct bnge_cp_ring_info	*rx_cpr;
+	u16			rx_prod;
+	u16			rx_agg_prod;
+	u16			rx_sw_agg_prod;
+	u16			rx_next_cons;
+
+	struct rx_bd		*rx_desc_ring[MAX_RX_PAGES];
+	struct bnge_sw_rx_bd	*rx_buf_ring;
+
+	struct rx_bd			*rx_agg_desc_ring[MAX_RX_AGG_PAGES];
+	struct bnge_sw_rx_agg_bd	*rx_agg_buf_ring;
+
+	unsigned long		*rx_agg_bmap;
+	u16			rx_agg_bmap_size;
+
+	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
+	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
+
+	struct bnge_ring_struct	rx_ring_struct;
+	struct bnge_ring_struct	rx_agg_ring_struct;
+	struct page_pool	*page_pool;
+	struct page_pool	*head_pool;
+	bool			need_head_pool;
+};
+
+struct bnge_tx_ring_info {
+	struct bnge_napi	*bnapi;
+	struct bnge_cp_ring_info	*tx_cpr;
+	u16			tx_prod;
+	u16			tx_cons;
+	u16			tx_hw_cons;
+	u16			txq_index;
+	u8			tx_napi_idx;
+	u8			kick_pending;
+
+	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
+	struct bnge_sw_tx_bd	*tx_buf_ring;
+
+	dma_addr_t		tx_desc_mapping[MAX_TX_PAGES];
+
+	u32			dev_state;
+#define BNGE_DEV_STATE_CLOSING	0x1
+
+	struct bnge_ring_struct	tx_ring_struct;
+};
+
+struct bnge_napi {
+	struct napi_struct		napi;
+	struct bnge_net			*bn;
+	int				index;
+
+	struct bnge_nq_ring_info	nq_ring;
+	struct bnge_rx_ring_info	*rx_ring;
+	struct bnge_tx_ring_info	*tx_ring[BNGE_MAX_TXR_PER_NAPI];
+};
+
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 52ada65943a0..e0c16ed62865 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -436,3 +436,61 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 
 	return 0;
 }
+
+void bnge_init_ring_struct(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_ring_mem_info *rmem;
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_rx_ring_info *rxr;
+		struct bnge_tx_ring_info *txr;
+		struct bnge_ring_struct *ring;
+
+		nqr = &bnapi->nq_ring;
+		ring = &nqr->ring_struct;
+		rmem = &ring->ring_mem;
+		rmem->nr_pages = bn->cp_nr_pages;
+		rmem->page_size = HW_CMPD_RING_SIZE;
+		rmem->pg_arr = (void **)nqr->desc_ring;
+		rmem->dma_arr = nqr->desc_mapping;
+		rmem->vmem_size = 0;
+
+		rxr = bnapi->rx_ring;
+		if (!rxr)
+			goto skip_rx;
+
+		ring = &rxr->rx_ring_struct;
+		rmem = &ring->ring_mem;
+		rmem->nr_pages = bn->rx_nr_pages;
+		rmem->page_size = HW_RXBD_RING_SIZE;
+		rmem->pg_arr = (void **)rxr->rx_desc_ring;
+		rmem->dma_arr = rxr->rx_desc_mapping;
+		rmem->vmem_size = SW_RXBD_RING_SIZE * bn->rx_nr_pages;
+		rmem->vmem = (void **)&rxr->rx_buf_ring;
+
+		ring = &rxr->rx_agg_ring_struct;
+		rmem = &ring->ring_mem;
+		rmem->nr_pages = bn->rx_agg_nr_pages;
+		rmem->page_size = HW_RXBD_RING_SIZE;
+		rmem->pg_arr = (void **)rxr->rx_agg_desc_ring;
+		rmem->dma_arr = rxr->rx_agg_desc_mapping;
+		rmem->vmem_size = SW_RXBD_AGG_RING_SIZE * bn->rx_agg_nr_pages;
+		rmem->vmem = (void **)&rxr->rx_agg_buf_ring;
+
+skip_rx:
+		bnge_for_each_napi_tx(j, bnapi, txr) {
+			ring = &txr->tx_ring_struct;
+			rmem = &ring->ring_mem;
+			rmem->nr_pages = bn->tx_nr_pages;
+			rmem->page_size = HW_TXBD_RING_SIZE;
+			rmem->pg_arr = (void **)txr->tx_desc_ring;
+			rmem->dma_arr = txr->tx_desc_mapping;
+			rmem->vmem_size = SW_TXBD_RING_SIZE * bn->tx_nr_pages;
+			rmem->vmem = (void **)&txr->tx_buf_ring;
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 300f1d8268ef..162a66c79830 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -6,6 +6,7 @@
 
 struct bnge_ctx_mem_type;
 struct bnge_dev;
+struct bnge_net;
 
 #define PTU_PTE_VALID             0x1UL
 #define PTU_PTE_LAST              0x2UL
@@ -180,9 +181,20 @@ struct bnge_ctx_mem_info {
 	struct bnge_ctx_mem_type	ctx_arr[BNGE_CTX_V2_MAX];
 };
 
+struct bnge_ring_struct {
+	struct bnge_ring_mem_info	ring_mem;
+
+	union {
+		u16		grp_idx;
+		u16		map_idx; /* Used by NQs */
+	};
+	u8			queue_id;
+};
+
 int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
 void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
 int bnge_alloc_ctx_mem(struct bnge_dev *bd);
 void bnge_free_ctx_mem(struct bnge_dev *bd);
+void bnge_init_ring_struct(struct bnge_net *bn);
 
 #endif /* _BNGE_RMEM_H_ */
-- 
2.47.3


