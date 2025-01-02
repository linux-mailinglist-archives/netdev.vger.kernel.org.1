Return-Path: <netdev+bounces-154847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260C3A0012A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E411E163235
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E061B6CE3;
	Thu,  2 Jan 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HUiU6h7C"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AC188904
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856721; cv=none; b=QIZHMDAFTNmZRsS8GjEBz45OfRmucjDlI1jqNdgdHsSQriO4Tkwtqu9f5uLYlrBFbVn806QqRIP3Z08th4xWyrl/TdgnO+3/CkSqvqiKjTnnKB7slicqpbKc44X4woyvyFdSwqA7Xlii/euSq1ZC7rb6H9HMw1fNXAwRh2k79KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856721; c=relaxed/simple;
	bh=GyzVXlrhNuOeeyeYKuK8+/tXVqcAN69TRbJWWK25Ab8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBED+XK931BKfZnK5vUpgYfCKU4faLnG6Mql4kNhPJ4jAXWkrY6JlYhnpAGY5AU1aYjSAZO+uVVaQHyWFpJMbcBn3bxaEiaiAnRbNYMNeo9ioIXWRqi/Enx8oBuHEjN0BtIEKzA+gGzboO8NDDgP68pFgsoLJwcGSPFTwAJcoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HUiU6h7C; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11871; q=dns/txt;
  s=iport; t=1735856719; x=1737066319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7cpB4LVa90XUfPoFuX5DAoaCtNbHectOx9Plcby2WM=;
  b=HUiU6h7Cr4UuzVCgosg7iFJsHG59GjJX9Ub+m/mkkMFcklG7R4yLHFb+
   ZJDRaba1uuGc0YJtyGu6BdhTgsYXsgRZN5boxe9sv84vtbTobH3VyTKua
   DQwk1fsVl9vSCYLdaVbjGuSoUVgKpDCmntaANvLUp4lNfJnyWwVlhPpxL
   k=;
X-CSE-ConnectionGUID: bGmDxfjkTGu9BeXeT6ODnQ==
X-CSE-MsgGUID: Kdzxq83CSGqHMnT9C0H6KQ==
X-IPAS-Result: =?us-ascii?q?A0ANAADxEHdnj5EQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6cNgSUDVg8BAQEPRAQBAYUHAopvAiY0CQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BUmGCIZbAgEDJwsBR?=
 =?us-ascii?q?hBRKysHEoMBgmUDsxaBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSBFYE7gT5vi?=
 =?us-ascii?q?wcEiQidV0iBIQNZLAFVEw0KCwcFgTk6AyILCwwLFBwVAoEagQEBFAYVBIELR?=
 =?us-ascii?q?T2CSGlJNwINAjaCICRYgiuEXYRHhFaCSVWCSIIXfIEagipAAwsYDUgRLDcGD?=
 =?us-ascii?q?hsGPm4Hm3k8g257FBOBE4FEoyWCIKEDhCSBY59jGjOqUph8IqQkhGaBZzqBW?=
 =?us-ascii?q?zMaCBsVgyJSGQ+OLQ0JFrBcJTI8AgcLAQEDCZFWAQE?=
IronPort-Data: A9a23:yzPCS6nrJcU6KACduSdTS8ro5gxkJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbDziCafqIYzamco8gYdmyoEwCu5WAnIJqGgJvqiA8EVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubzpNs/jb83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYc3/8pnD2NNy
 dMFeRoAXh2/2cWaxovuH4GAhux7RCXqFIobvnclyXTSCuwrBMiTBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkESUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaNJIzVGJgExC50o
 Erl83bpG0FBH+ew0Bqg9E79rbfvwwDCDdd6+LqQraMy3wbJmQT/EiY+WVKlrPyRhkegVtdbL
 EIIvCwjscAa+UC2S9DvUgGQr3mDsRoRHdFXFoUS6xyHw4LX7hyfC2xCSSROAPQvssMsSCNp0
 FKVk973LThytrvTQnL13q+dpz60OAAPIGMCbDNCRgwAi/HlrZ0/gwznUNluCui2g8fzFDW2x
 CqFxBXSnJ0aicoNkqH+9lfdjnf09t7CTxU+4UPcWWfNAh5FiJCNbaOtxUjV7/V8A5vIZFSxs
 URavOSY1bVbZX2SrxClTOIIFbCvwv+KNjzAnFJid6XNERzzoBZPmqgOvFlDyFdVDyoSRdP+j
 KbuVeJtCH17YSLCgUxfOt7Z5yEWIU7ITomNuhf8NYEmX3SJXFXblByCnGbJt4wXrGAikLskJ
 bCQetu2AHARBMxPlWXtGrhAj+R3nXFhnws/oKwXKTz6gNJyg1bIGN843KemNLtRAF6s+V+Mq
 o0ObaNmNT0CD7GgOkE7DrL/3XhRcCBkXsqpwyCmXuWCOQFhUHowEOPcxKhpeopu2cxoehTgo
 BmAtrtj4AOn3xXvcFzSAlg6MeOHdcgk9xoTY3dzVWtELlB/Ou5DGo9DLMNvJdHKNYVLkZZJc
 hXyU5zZU6QSE2WeoWR1gFuUhNUKSSlHTDmmZ0KNCAXTtbY5L+AV0rcIpjfSyRQ=
IronPort-HdrOrdr: A9a23:Hx8XC6Mc0uphQ8BcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3A756cYmhEBm+aW96T9L+rZXoD8zJueFLY4GfeIUy?=
 =?us-ascii?q?EJns4YrClRGPO349iqp87?=
X-Talos-MUID: 9a23:DPmUwQSsJK9wJym+RXTPiCNyLZczyJ+BEWAol6lXkJGkaw9JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="406875592"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-08.cisco.com (Postfix) with ESMTP id 58A961800022A;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 2F56420F2007; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
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
Subject: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Thu,  2 Jan 2025 14:24:25 -0800
Message-Id: <20250102222427.28370-5-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250102222427.28370-1-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com

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
 drivers/net/ethernet/cisco/enic/enic.h        |  10 ++
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c   |  51 ++++++-
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 140 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |   5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 6 files changed, 203 insertions(+), 6 deletions(-)

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
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index d607b4f0542c..799f44b95bfc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -51,6 +51,7 @@ static const struct enic_stat enic_per_rq_stats[] = {
 	ENIC_PER_RQ_STAT(napi_repoll),
 	ENIC_PER_RQ_STAT(no_skb),
 	ENIC_PER_RQ_STAT(desc_skip),
+	ENIC_PER_RQ_STAT(pp_alloc_error),
 };
 
 #define NUM_ENIC_PER_RQ_STATS   ARRAY_SIZE(enic_per_rq_stats)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 45ab6b670563..5bfd89749237 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1282,6 +1282,11 @@ static int enic_get_vf_port(struct net_device *netdev, int vf,
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
@@ -1881,10 +1886,33 @@ static int enic_open(struct net_device *netdev)
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
@@ -1902,6 +1930,13 @@ static int enic_open(struct net_device *netdev)
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
@@ -1942,8 +1977,10 @@ static int enic_open(struct net_device *netdev)
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
@@ -2001,8 +2038,10 @@ static int enic_stop(struct net_device *netdev)
 
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
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index ae2ab5af87e9..d450d2f4f694 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -7,6 +7,7 @@
 #include "enic_rq.h"
 #include "vnic_rq.h"
 #include "cq_enet_desc.h"
+#include "enic_res.h"
 
 #define ENIC_LARGE_PKT_THRESHOLD		1000
 
@@ -118,3 +119,142 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 
 	return 0;
 }
+
+void enic_rq_page_cleanup(struct enic_rq *rq)
+{
+	struct vnic_rq *vrq = &rq->vrq;
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct napi_struct *napi = &enic->napi[vrq->index];
+
+	napi_free_frags(napi);
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
+/* Unmap and free pages fragments making up the error packet.
+ */
+static void enic_rq_error_reset(struct vnic_rq *vrq)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct napi_struct *napi = &enic->napi[vrq->index];
+
+	napi_free_frags(napi);
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
+	if (enic_rq_pkt_error(vrq, packet_error, fcs_ok, bytes_written)) {
+		enic_rq_error_reset(vrq);
+		return;
+	}
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
2.35.2


