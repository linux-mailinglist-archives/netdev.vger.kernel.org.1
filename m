Return-Path: <netdev+bounces-157315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E62A09EBB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CAA167E37
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA613222575;
	Fri, 10 Jan 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dKC8nGfD"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE4221D86
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552066; cv=none; b=Ozd5SQjJAPvKlVtxxZz94dAiQEi9m65Eg/T8FmZYwWGGwDw3YNoz5CsAwyvTGdqO6cY2jffOWN2Tum1v/g+JKDm68AilwKCubSWP/2vkep04ILqfUFDF6KJFya2peU7/PbT29mMiPIKe2P+c3jlYmV4DmKjTCdgGr8NVXxC9r0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552066; c=relaxed/simple;
	bh=biBIfFqV7edhp9Ts2kkfDATDLpg2ynqjrtq9Q+z1sH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vo3QrV30jGBs5TiiJ8+c67j3+RObOGhbwH4PZcTleW7bZ9L9V8dHpch0JCbGh7q6sUIjOhg2bSUFihczaErku2y5NQJ7+xm9ezoGW3dIxhuNH6IubofOrlj5LT3tpMrnCG+feMLP2AEadUyfxpIX6CUtqPc6qaxKNXjEDAPoTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dKC8nGfD; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11417; q=dns/txt;
  s=iport; t=1736552064; x=1737761664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UC0WnjeBW6PrMAOR+T/12J3J/Z2IiJpNiyWkLzisbnU=;
  b=dKC8nGfDD+BRjABp15kETN8bHslU5sDvF1qAyNEqcgEqeepZNPAOtSbT
   KZjJLdo1bDJEjVIdMlExMxYOluvYVw2U6emLj7OjgtYGoUz6l/1usC4rB
   WmyBSvDXisIZVL4VfkXFQWnmxZ2NXev4IH9SgC08KSjSHhGmiA8hGWlSb
   4=;
X-CSE-ConnectionGUID: 6EN0lzqfR6G9HYsQS5v6FA==
X-CSE-MsgGUID: 5V5rK67mTYuiT/D0YmG2hw==
X-IPAS-Result: =?us-ascii?q?A0AnAAD5rYFn/5H/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfpw2BJQNWDwEBAQ9EBAEBhQcCinQCJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQUSsrB?=
 =?us-ascii?q?xKDAYJlA7RVgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO4E+b4sHBIdnn?=
 =?us-ascii?q?lRIgSEDWSwBVRMNCgsHBYE4OgMiCwsMCxQcFQIVHgERBhAEbUQ3gkZpSzoCD?=
 =?us-ascii?q?QI1gh4kWIIrhFyER4RUgktVgkeCFHqBGYQDQAMLGA1IESw3Bg4bBj5uB5soP?=
 =?us-ascii?q?INwexSBJoFEoyWCIKEDhCWBY59jGjOqU5h8IqQlhGaBZzyBWTMaCBsVgyJSG?=
 =?us-ascii?q?Q+OKgMWFrxGJTI8AgcLAQEDCZEeAQE?=
IronPort-Data: A9a23:Cv5ph6NPcBUNk7DvrR2HlsFynXyQoLVcMsEvi/4bfWQNrUomhWQGy
 mRJW2uDPP/ZZWOnedBwPNmxpxtTscKHndE2HHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZQf8gmYsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj66tDKhkyL5QWwLhYUEF/7
 sUjdS5TQDnW0opawJrjIgVtrt4oIM+uOMYUvWttiGmJS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMXwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQqiOSyboaEIIDiqcN9w3jFv
 EGYoGHFMwwbCJuzkQuA3Sismbqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWkPeSMJUyMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJZbka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9fABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:uqiIsq6JCMqwZWFePgPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: 9a23:LNQ3x2BhAc13I1r6E3dK0hYQCNkrSCPynVfhOHaDVHg3ZpTAHA==
X-Talos-MUID: 9a23:7s/sFghbmg5AsJFrNKWxDMMpafk1+YfwV0UxoIgHh46obR11FG2dk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="304764924"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:32:53 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTP id 23D48180001E8;
	Fri, 10 Jan 2025 23:32:53 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id F07E820F2007; Fri, 10 Jan 2025 15:32:52 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v5 4/4] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Fri, 10 Jan 2025 15:32:49 -0800
Message-Id: <20250110233249.23258-5-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250110233249.23258-1-johndale@cisco.com>
References: <20250110233249.23258-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com

The Page Pool API improves bandwidth and CPU overhead by recycling
pages instead of allocating new buffers in the driver. Make use of
page pool fragment allocation for smaller MTUs so that multiple
packets can share a page.

Added 'pp_alloc_error' per RQ ethtool statistic to count
page_pool_dev_alloc() failures.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  10 ++
 drivers/net/ethernet/cisco/enic/enic_main.c |  53 ++++++++-
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 123 ++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |   5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |   2 +
 5 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 51f80378d928..19e22aba71a8 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -17,6 +17,8 @@
 #include "vnic_nic.h"
 #include "vnic_rss.h"
 #include <linux/irq.h>
+#include <linux/if_vlan.h>
+#include <net/page_pool/helpers.h>
 
 #define DRV_NAME		"enic"
 #define DRV_DESCRIPTION		"Cisco VIC Ethernet NIC Driver"
@@ -158,6 +160,7 @@ struct enic_rq_stats {
 	u64 pkt_truncated;		/* truncated pkts */
 	u64 no_skb;			/* out of skbs */
 	u64 desc_skip;			/* Rx pkt went into later buffer */
+	u64 pp_alloc_error;		/* page alloc error */
 };
 
 struct enic_wq {
@@ -169,6 +172,7 @@ struct enic_wq {
 struct enic_rq {
 	struct vnic_rq vrq;
 	struct enic_rq_stats stats;
+	struct page_pool *pool;
 } ____cacheline_aligned;
 
 /* Per-instance private data structure */
@@ -231,8 +235,14 @@ struct enic {
 			       void *opaque);
 	int (*rq_alloc_buf)(struct vnic_rq *rq);
 	void (*rq_free_buf)(struct vnic_rq *rq, struct vnic_rq_buf *buf);
+	void (*rq_cleanup)(struct enic_rq *rq);
 };
 
+static inline unsigned int get_max_pkt_len(struct enic *enic)
+{
+	return enic->netdev->mtu + VLAN_ETH_HLEN;
+}
+
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
 {
 	struct enic *enic = vdev->priv;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d3319f62ad1b..64f25a5b1507 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1313,6 +1313,11 @@ static int enic_get_vf_port(struct net_device *netdev, int vf,
 	return -EMSGSIZE;
 }
 
+/* nothing to do for buffers based allocation */
+static void enic_rq_buf_cleanup(struct enic_rq *rq)
+{
+}
+
 static void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
@@ -1882,10 +1887,33 @@ static int enic_open(struct net_device *netdev)
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
 	int err, ret;
-
-	enic->rq_buf_service = enic_rq_indicate_buf;
-	enic->rq_alloc_buf = enic_rq_alloc_buf;
-	enic->rq_free_buf = enic_free_rq_buf;
+	bool use_page_pool;
+	struct page_pool_params pp_params = { 0 };
+
+	/* Use the Page Pool API for MTUs <= PAGE_SIZE */
+	use_page_pool = (get_max_pkt_len(enic) <= PAGE_SIZE);
+
+	if (use_page_pool) {
+		/* use the page pool API */
+		pp_params.order = 0;
+		pp_params.pool_size = enic->config.rq_desc_count;
+		pp_params.nid = dev_to_node(&enic->pdev->dev);
+		pp_params.dev = &enic->pdev->dev;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.max_len = PAGE_SIZE;
+		pp_params.netdev = netdev;
+		pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+
+		enic->rq_buf_service = enic_rq_indicate_page;
+		enic->rq_alloc_buf = enic_rq_alloc_page;
+		enic->rq_free_buf = enic_rq_free_page;
+		enic->rq_cleanup = enic_rq_page_cleanup;
+	} else {
+		enic->rq_buf_service = enic_rq_indicate_buf;
+		enic->rq_alloc_buf = enic_rq_alloc_buf;
+		enic->rq_free_buf = enic_free_rq_buf;
+		enic->rq_cleanup = enic_rq_buf_cleanup;
+	}
 
 	err = enic_request_intr(enic);
 	if (err) {
@@ -1903,6 +1931,13 @@ static int enic_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
+		/* create a page pool for each RQ */
+		if (use_page_pool) {
+			pp_params.napi = &enic->napi[i];
+			pp_params.queue_idx = i;
+			enic->rq[i].pool = page_pool_create(&pp_params);
+		}
+
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
 		vnic_rq_fill(&enic->rq[i].vrq, enic->rq_alloc_buf);
@@ -1943,8 +1978,10 @@ static int enic_open(struct net_device *netdev)
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
-		if (!ret)
+		if (!ret) {
 			vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
+			enic->rq_cleanup(&enic->rq[i]);
+		}
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -2002,8 +2039,10 @@ static int enic_stop(struct net_device *netdev)
 
 	for (i = 0; i < enic->wq_count; i++)
 		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
-	for (i = 0; i < enic->rq_count; i++)
+	for (i = 0; i < enic->rq_count; i++) {
 		vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
+		enic->rq_cleanup(&enic->rq[i]);
+	}
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -2513,6 +2552,7 @@ static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
 	rxs->hw_drop_overruns = rqstats->pkt_truncated;
 	rxs->csum_unnecessary = rqstats->csum_unnecessary +
 				rqstats->csum_unnecessary_encap;
+	rxs->alloc_fail = rqstats->pp_alloc_error;
 }
 
 static void enic_get_queue_stats_tx(struct net_device *dev, int idx,
@@ -2540,6 +2580,7 @@ static void enic_get_base_stats(struct net_device *dev,
 	rxs->hw_drops = 0;
 	rxs->hw_drop_overruns = 0;
 	rxs->csum_unnecessary = 0;
+	rxs->alloc_fail = 0;
 	txs->bytes = 0;
 	txs->packets = 0;
 	txs->csum_none = 0;
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index ae2ab5af87e9..624a0d05f393 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -7,6 +7,7 @@
 #include "enic_rq.h"
 #include "vnic_rq.h"
 #include "cq_enet_desc.h"
+#include "enic_res.h"
 
 #define ENIC_LARGE_PKT_THRESHOLD		1000
 
@@ -118,3 +119,125 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 
 	return 0;
 }
+
+void enic_rq_page_cleanup(struct enic_rq *rq)
+{
+	page_pool_destroy(rq->pool);
+}
+
+void enic_rq_free_page(struct vnic_rq *vrq, struct vnic_rq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct enic_rq *rq = &enic->rq[vrq->index];
+
+	if (!buf->os_buf)
+		return;
+
+	page_pool_put_full_page(rq->pool, (struct page *)buf->os_buf, true);
+	buf->os_buf = NULL;
+}
+
+int enic_rq_alloc_page(struct vnic_rq *vrq)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct enic_rq *rq = &enic->rq[vrq->index];
+	struct enic_rq_stats *rqstats = &rq->stats;
+	struct vnic_rq_buf *buf = vrq->to_use;
+	dma_addr_t dma_addr;
+	struct page *page;
+	unsigned int offset = 0;
+	unsigned int len;
+	unsigned int truesize;
+
+	len = get_max_pkt_len(enic);
+	truesize = len;
+
+	if (buf->os_buf) {
+		dma_addr = buf->dma_addr;
+	} else {
+		page = page_pool_dev_alloc(rq->pool, &offset, &truesize);
+		if (unlikely(!page)) {
+			rqstats->pp_alloc_error++;
+			return -ENOMEM;
+		}
+		buf->os_buf = (void *)page;
+		buf->offset = offset;
+		buf->truesize = truesize;
+		dma_addr = page_pool_get_dma_addr(page) + offset;
+	}
+
+	enic_queue_rq_desc(vrq, buf->os_buf, dma_addr, len);
+
+	return 0;
+}
+
+void enic_rq_indicate_page(struct vnic_rq *vrq, struct cq_desc *cq_desc,
+			   struct vnic_rq_buf *buf, int skipped, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct sk_buff *skb;
+	struct enic_rq *rq = &enic->rq[vrq->index];
+	struct enic_rq_stats *rqstats = &rq->stats;
+	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, vrq->index)];
+	struct napi_struct *napi;
+	u8 type, color, eop, sop, ingress_port, vlan_stripped;
+	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
+	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
+	u8 ipv6, ipv4, ipv4_fragment, fcs_ok, rss_type, csum_not_calc;
+	u8 packet_error;
+	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
+	u32 rss_hash;
+
+	if (skipped) {
+		rqstats->desc_skip++;
+		return;
+	}
+
+	if (!buf || !buf->dma_addr) {
+		net_warn_ratelimited("%s: !buf || !buf->dma_addr!!\n",
+				     enic->netdev->name);
+		return;
+	}
+
+	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc,
+			    &type, &color, &q_number, &completed_index,
+			    &ingress_port, &fcoe, &eop, &sop, &rss_type,
+			    &csum_not_calc, &rss_hash, &bytes_written,
+			    &packet_error, &vlan_stripped, &vlan_tci, &checksum,
+			    &fcoe_sof, &fcoe_fc_crc_ok, &fcoe_enc_error,
+			    &fcoe_eof, &tcp_udp_csum_ok, &udp, &tcp,
+			    &ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
+			    &fcs_ok);
+
+	if (enic_rq_pkt_error(vrq, packet_error, fcs_ok, bytes_written))
+		return;
+
+	napi = &enic->napi[vrq->index];
+	skb = napi_get_frags(napi);
+	if (unlikely(!skb)) {
+		net_warn_ratelimited("%s: skb alloc error rq[%d], desc[%d]\n",
+				     enic->netdev->name, vrq->index,
+				     completed_index);
+		rqstats->no_skb++;
+		return;
+	}
+
+	dma_sync_single_for_cpu(&enic->pdev->dev, buf->dma_addr, bytes_written,
+				DMA_FROM_DEVICE);
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, (struct page *)buf->os_buf,
+			buf->offset, bytes_written, buf->truesize);
+
+	buf->os_buf = NULL;
+	buf->dma_addr = 0;
+	buf = buf->next;
+
+	enic_rq_set_skb_flags(vrq, type, rss_hash, rss_type, fcoe, fcoe_fc_crc_ok,
+			      vlan_stripped, csum_not_calc, tcp_udp_csum_ok, ipv6,
+			      ipv4_csum_ok, vlan_tci, skb);
+	if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
+		enic_intr_update_pkt_size(&cq->pkt_size_counter, skb->len);
+	skb_mark_for_recycle(skb);
+	skb_record_rx_queue(skb, vrq->index);
+	napi_gro_frags(napi);
+	rqstats->packets++;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.h b/drivers/net/ethernet/cisco/enic/enic_rq.h
index 46ab75fd74a0..f429f31b6172 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.h
@@ -19,4 +19,9 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 		    u8 type, u16 q_number, u16 completed_index, void *opaque);
 void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 			  struct vnic_rq_buf *buf, int skipped, void *opaque);
+void enic_rq_indicate_page(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			   struct vnic_rq_buf *buf, int skipped, void *opaque);
+int enic_rq_alloc_page(struct vnic_rq *rq);
+void enic_rq_free_page(struct vnic_rq *rq, struct vnic_rq_buf *buf);
+void enic_rq_page_cleanup(struct enic_rq *rq);
 #endif /* _ENIC_RQ_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.h b/drivers/net/ethernet/cisco/enic/vnic_rq.h
index 0bc595abc03b..2ee4be2b9a34 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.h
@@ -61,6 +61,8 @@ struct vnic_rq_buf {
 	unsigned int index;
 	void *desc;
 	uint64_t wr_id;
+	unsigned int offset;
+	unsigned int truesize;
 };
 
 enum enic_poll_state {
-- 
2.44.0


