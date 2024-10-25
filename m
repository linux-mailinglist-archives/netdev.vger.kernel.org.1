Return-Path: <netdev+bounces-139058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C629AFE4A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753741C22303
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB61D45FC;
	Fri, 25 Oct 2024 09:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B11D2F5F;
	Fri, 25 Oct 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848987; cv=none; b=inpVQfvtQ3H2NSJcpIWWtyMuY1o1WjT2+zk8c568mpZ5WtIoP1iY1oDsln+LEMNzI51P//SUMTk68yLSh49ttDTL3qRLjlAj5Bb2l7geq4WsQ9nk1HniLTSi5GHARfOq/OSGCNlgSZLo7khTKMFfV7J2/2dQsTch09gkO5ctYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848987; c=relaxed/simple;
	bh=35cOsTT1YYRA+to1SFi0U9iscvlef3bF9fV2AKVrJ9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRuo1DY161CetAtcI/1lM03toW/ERqPzCZzNOMljEL6BpHkvEbwjhg26dsmBUsLJ5kfUymf+W0CYfeN89XliNrKPl8f2S0iYxVIpeu9RzY8aIEkkKzUItsIlY4TrGIEOelNjJInYh3yYR3w80+XL0r99ukFuF+V0vKBXi1pg5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZd2j2P6kz1ynfM;
	Fri, 25 Oct 2024 17:36:29 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id A35B8140361;
	Fri, 25 Oct 2024 17:36:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 17:36:20 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 2/9] net: hns3: add sync command to sync io-pgtable
Date: Fri, 25 Oct 2024 17:29:31 +0800
Message-ID: <20241025092938.2912958-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241025092938.2912958-1-shaojijie@huawei.com>
References: <20241025092938.2912958-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

From: Jian Shen <shenjian15@huawei.com>

To avoid errors in pgtable prefectch, add a sync command to sync
io-pagtable.

This is a supplement for the previous patch.
We want all the tx packet can be handled with tx bounce buffer path.
But it depends on the remain space of the spare buffer, checked by the
hns3_can_use_tx_bounce(). In most cases, maybe 99.99%, it returns true.
But once it return false by no available space, the packet will be handled
with the former path, which will map/unmap the skb buffer.
Then the driver will face the smmu prefetch risk again.

So add a sync command in this case to avoid smmu prefectch,
just protects corner scenes.

Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
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


