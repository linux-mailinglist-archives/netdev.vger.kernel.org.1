Return-Path: <netdev+bounces-154321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0E9FCFC9
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D133A0509
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE983597F;
	Fri, 27 Dec 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="XPIR7KHm"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABC8821
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735269345; cv=none; b=AOQJUZsCOKwJgr7pYo/jENQI5QJDKxnOeTim8HABc9OXftiPmdkN2iu4hSEDt+ziwhbqSieSN+BBdE4zQV8uVqGfuZ4mPQHmRiS0qSRJpiXpzT7lFTqnaktqUA7fkr+//016G7Jk8pK4vy3ShWgmf9i3jq0MTLvtCrKpUg03sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735269345; c=relaxed/simple;
	bh=oz2fWwvx81rFge50egn/1VlY2jaPRMGlPFcGhZXOQCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fII8oIpVB3P/QFUyup5dO9roJKsryZQMQI6E5YLuoeOkXavJW45iPp2Z6lTeBQ8zno2yL1sMV0l5pK79ihUlda1mI8dOulSLBlr0ZdKk19cKMPqlzjzeyZPyp0jXI76IZ/m3GtaipmR+OzG4dw2bFR5yBrk2ItK/vdJm4NGxs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=XPIR7KHm; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11892; q=dns/txt;
  s=iport; t=1735269343; x=1736478943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xH1rjzpEFaJGZH+Owb7ksqdWelNWS2+mOAi0VL0Hhjw=;
  b=XPIR7KHmADeFtltRU2rANDAQ0Jvz0uZ/IOJsW54E8oIdVvopVeJm8Kij
   JrdVpCCH2KAQki++SmYV6v2OKvn8r/mcKO6gfVYiokgs634xmGy+Lb5XC
   iTJshf32KM5RXIlCLnt59n5SrZws9YHauepfCvaJK36u+GnGPuqbpyVLf
   o=;
X-CSE-ConnectionGUID: JOqgq8+jTI2Df075YuO94Q==
X-CSE-MsgGUID: /q0X6VC8SHCBwanmNT4xOA==
X-IPAS-Result: =?us-ascii?q?A0ANAADbGm5nj5X/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6cNgSUDVg8BAQEPRAQBAYUHAopuAiY0CQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BQ47hgiGWwIBAycLA?=
 =?us-ascii?q?UYQUSsrBxKDAYJlA68VgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO4E+b?=
 =?us-ascii?q?4sHBIkVnnVIgSEDWSwBVRMNCgsHBYE5OgMiDAsMCxQcFQKBHoEBARQGFQSBC?=
 =?us-ascii?q?0U9gkppSTcCDQI2giAkWIJNhReEYYRXgklVgnuCF3yBHYIlQAMLGA1IESw3B?=
 =?us-ascii?q?g4bBj5uB5xkRoN0exQTgROBRKMlgiChA4QkgWOfYxozqlKYfCKkJIRmgWc6g?=
 =?us-ascii?q?VszGggbFYMiUhkPji0NCRa1fCUyPAIHCwEBAwmRNwEB?=
IronPort-Data: A9a23:e3Y7FaAKsUTk0RVW/83jw5YqxClBgxIJ4kV8jS/XYbTApD4mhjIHx
 2tMWjrVbvuKYmb0fdB3YN618khS7Z6HzYMyOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQX/hGYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE4dJ3A1hmfo8k27xbDzkRq
 M0FD2FRV0XW7w626OrTpuhEnM8vKozveYgYoHwllGufBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY+BPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FApjOa0a4OFI7RmQ+0Shx6o+
 Fztr1/ZKTsFPdqa7wbZ4lWF07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDipxbMgimnod7CSQtdChjrsnyNzCRga5f1JI6UyAL3464fcbeEaQjdh
 S1R8ySB19wmAZaInS2LZewCGrC1+vqIWAEwZ3YxRPHNEBzzpxaekZBs3d1oGKt+3i85ld7Vj
 K375Fk5CHx7ZSfCgUpLj2SZV55CIU/IToiNaxwsRoASCqWdjSfelM2UWWae3nr2jG8nmrwlN
 JGQfK6EVClBVP48k2rnHLZAidfHIxzSI0uNHPgXKDz6gdKjiIK9E+xt3KamN7pgtfjV+m05D
 f4CaJfVl32zr9ESkgGMrNZMdgpVRZTKLZv3sMdQPvWSORZrHXppCvnah9scl39NwcxoehPz1
 ijlACdwkQOn7VWecFniQi44MtvHA80gxU/XyARwZj5ELVB/Ot73tM/ytvIfIdEayQCU5aUrF
 qNZIJTdXqsnp/au0211UKQRZbdKLHyD7T9i9QL8CNTjV/aMnzD0x+I=
IronPort-HdrOrdr: A9a23:4gBiZq3uGwNEj5Tnl0zSWQqjBLUkLtp133Aq2lEZdPWaSKOlfq
 eV7ZMmPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WBuB9eftWDd0QPCRr2Kr7GSpgEIcBeRygcy78
 tdmtBFeb7N5ZwQt7eC3OF+eOxQpuW6zA==
X-Talos-CUID: 9a23:0KFvH25TnsnpgPpJNNss1mkNFdl1MX/h7S38LRfnVFd0b+zJcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AVQ7c3Q8j3f1RYjylvInst/qQf4Bxu5TwNmtdqrU?=
 =?us-ascii?q?tkdaNMylWB2uNqx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,268,1728950400"; 
   d="scan'208";a="404613181"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Dec 2024 03:14:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTP id E828B180001D3;
	Fri, 27 Dec 2024 03:14:33 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id C187A20F2007; Thu, 26 Dec 2024 19:14:33 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Thu, 26 Dec 2024 19:14:09 -0800
Message-Id: <20241227031410.25607-5-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241227031410.25607-1-johndale@cisco.com>
References: <20241227031410.25607-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com

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
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 141 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |   5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 6 files changed, 204 insertions(+), 6 deletions(-)

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
index ae2ab5af87e9..4d520af3033d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -7,6 +7,7 @@
 #include "enic_rq.h"
 #include "vnic_rq.h"
 #include "cq_enet_desc.h"
+#include "enic_res.h"
 
 #define ENIC_LARGE_PKT_THRESHOLD		1000
 
@@ -118,3 +119,143 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 
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
+	page_pool_put_page(rq->pool, (struct page *)buf->os_buf,
+			   get_max_pkt_len(enic), true);
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


