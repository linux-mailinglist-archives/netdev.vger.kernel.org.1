Return-Path: <netdev+bounces-136932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1E9A3B39
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129B4B2435D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173B20111E;
	Fri, 18 Oct 2024 10:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6C20110F;
	Fri, 18 Oct 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246650; cv=none; b=HbOQX30UKPROcII1/toGnLa02whtPEoVRS8wTJujubPSQdObotdCY6O7SlwXkjPiHEvlC4UqBzUGGRA+BG8cXNgpWK+4U3MhlXQyU+3S2F0HZC8u5MYoVsHIaig8EEL6aIR1PpE2pqCg5jwYgBo16SFuxjFQKk0iidkM0uqK7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246650; c=relaxed/simple;
	bh=O8e137Q8ly8ubPgnGdwUZoenJIIOzqoxQalDDHTUmkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh7TcfT4ATV6x/IKuJSFbBzCTmtAx9sUcNvuBtGq2ThmTBjsW/5EcpG23NtAHlDsMVi6zW1OUWuacTHlZv9oVWWQ1z+cCA1fPl6BQK8QDQvWFhDlQPFnBhuiKSldEsI48ES605my3wnzPvrfw/5BOUdEF18bCjKe2DXl4L2THaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVLBH3TBGz1HLFm;
	Fri, 18 Oct 2024 18:13:11 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id EFF0E180019;
	Fri, 18 Oct 2024 18:17:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:26 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
Date: Fri, 18 Oct 2024 18:10:52 +0800
Message-ID: <20241018101059.1718375-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018101059.1718375-1-shaojijie@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

From: Jian Shen <shenjian15@huawei.com>

To avoid errors in pgtable prefectch, add a sync command to sync
io-pagtable.

In the case of large traffic, the TX bounce buffer may be used up.
At this point, we go to mapping/unmapping on TX path again.
So we added the sync command in driver to avoid hardware issue.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ac88e301f221..8760b4e9ade6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -381,6 +381,24 @@ static const struct hns3_rx_ptype hns3_rx_ptype_tbl[] = {
 #define HNS3_INVALID_PTYPE \
 		ARRAY_SIZE(hns3_rx_ptype_tbl)
 
+static void hns3_dma_map_sync(struct device *dev, unsigned long iova)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_iotlb_gather iotlb_gather;
+	size_t granule;
+
+	if (!domain || !iommu_is_dma_domain(domain))
+		return;
+
+	granule = 1 << __ffs(domain->pgsize_bitmap);
+	iova = ALIGN_DOWN(iova, granule);
+	iotlb_gather.start = iova;
+	iotlb_gather.end = iova + granule - 1;
+	iotlb_gather.pgsize = granule;
+
+	iommu_iotlb_sync(domain, &iotlb_gather);
+}
+
 static irqreturn_t hns3_irq_handle(int irq, void *vector)
 {
 	struct hns3_enet_tqp_vector *tqp_vector = vector;
@@ -1728,7 +1746,9 @@ static int hns3_map_and_fill_desc(struct hns3_enet_ring *ring, void *priv,
 				  unsigned int type)
 {
 	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
+	struct hnae3_handle *handle = ring->tqp->handle;
 	struct device *dev = ring_to_dev(ring);
+	struct hnae3_ae_dev *ae_dev;
 	unsigned int size;
 	dma_addr_t dma;
 
@@ -1760,6 +1780,13 @@ static int hns3_map_and_fill_desc(struct hns3_enet_ring *ring, void *priv,
 		return -ENOMEM;
 	}
 
+	/* Add a SYNC command to sync io-pgtale to avoid errors in pgtable
+	 * prefetch
+	 */
+	ae_dev = hns3_get_ae_dev(handle);
+	if (ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V3)
+		hns3_dma_map_sync(dev, dma);
+
 	desc_cb->priv = priv;
 	desc_cb->length = size;
 	desc_cb->dma = dma;
-- 
2.33.0


