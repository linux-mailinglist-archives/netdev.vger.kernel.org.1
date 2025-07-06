Return-Path: <netdev+bounces-203335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A7AF26C3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570184A3955
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF827E1DC;
	Wed,  2 Jul 2025 13:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC527A456;
	Wed,  2 Jul 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461462; cv=none; b=O7V8T4rngiHjAfil4oysJuOLiG3IHt1dJGV37Xz8eYSoNLY7Ph7K/roedUII4eKqp/CJ88cUnFSWLlYZNwd8lUbK1rhnDk98r0cM8irt8IQFELMKJcEVO1WGp5vUroj0gggR1USu4Fg6wLFsK4JJmlQxMbOKWD/Imr4wE8TMRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461462; c=relaxed/simple;
	bh=3f4gcrnMSKnMOdj6g/xhAF++jPkWPplseWiRneurOfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkRTfmIfK6lFJkxgePRh7L5O9T2YUsCipefbQtU0EJWxa+FaGgZoPzhktX8K94rfOQB4DzR7o+h6uCQtBgAbde4czENE1JLaFq2DmhvMgyjguk57PCXDUh9s7Q7FqWhQDwKO0YQ+NPLCg28039Bcs9jU4l4iyjhNFH3vruQhFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXKmC5NfVz1R7Ys;
	Wed,  2 Jul 2025 21:01:47 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CF2331A016C;
	Wed,  2 Jul 2025 21:04:18 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 21:04:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 4/4] net: hns3: default enable tx bounce buffer when smmu enabled
Date: Wed, 2 Jul 2025 20:57:31 +0800
Message-ID: <20250702125731.2875331-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250702125731.2875331-1-shaojijie@huawei.com>
References: <20250702125731.2875331-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The SMMU engine on HIP09 chip has a hardware issue.
SMMU pagetable prefetch features may prefetch and use a invalid PTE
even the PTE is valid at that time. This will cause the device trigger
fake pagefaults. The solution is to avoid prefetching by adding a
SYNC command when smmu mapping a iova. But the performance of nic has a
sharp drop. Then we do this workaround, always enable tx bounce buffer,
avoid mapping/unmapping on TX path.

This issue only affects HNS3, so we always enable
tx bounce buffer when smmu enabled to improve performance.

Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 +++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 49fcee7a6d0f..b028ca9a67a5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
@@ -1039,6 +1040,8 @@ static bool hns3_can_use_tx_sgl(struct hns3_enet_ring *ring,
 static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 {
 	u32 alloc_size = ring->tqp->handle->kinfo.tx_spare_buf_size;
+	struct net_device *netdev = ring_to_netdev(ring);
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hns3_tx_spare *tx_spare;
 	struct page *page;
 	dma_addr_t dma;
@@ -1080,6 +1083,7 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 	tx_spare->buf = page_address(page);
 	tx_spare->len = PAGE_SIZE << order;
 	ring->tx_spare = tx_spare;
+	ring->tx_copybreak = priv->tx_copybreak;
 	return;
 
 dma_mapping_error:
@@ -4874,6 +4878,30 @@ static void hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
 	devm_kfree(&pdev->dev, priv->tqp_vector);
 }
 
+static void hns3_update_tx_spare_buf_config(struct hns3_nic_priv *priv)
+{
+#define HNS3_MIN_SPARE_BUF_SIZE (2 * 1024 * 1024)
+#define HNS3_MAX_PACKET_SIZE (64 * 1024)
+
+	struct iommu_domain *domain = iommu_get_domain_for_dev(priv->dev);
+	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(priv->ae_handle);
+	struct hnae3_handle *handle = priv->ae_handle;
+
+	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V3)
+		return;
+
+	if (!(domain && iommu_is_dma_domain(domain)))
+		return;
+
+	priv->min_tx_copybreak = HNS3_MAX_PACKET_SIZE;
+	priv->min_tx_spare_buf_size = HNS3_MIN_SPARE_BUF_SIZE;
+
+	if (priv->tx_copybreak < priv->min_tx_copybreak)
+		priv->tx_copybreak = priv->min_tx_copybreak;
+	if (handle->kinfo.tx_spare_buf_size < priv->min_tx_spare_buf_size)
+		handle->kinfo.tx_spare_buf_size = priv->min_tx_spare_buf_size;
+}
+
 static void hns3_ring_get_cfg(struct hnae3_queue *q, struct hns3_nic_priv *priv,
 			      unsigned int ring_type)
 {
@@ -5107,6 +5135,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 	int i, j;
 	int ret;
 
+	hns3_update_tx_spare_buf_config(priv);
 	for (i = 0; i < ring_num; i++) {
 		ret = hns3_alloc_ring_memory(&priv->ring[i]);
 		if (ret) {
@@ -5311,6 +5340,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->ae_handle = handle;
 	priv->tx_timeout_count = 0;
 	priv->max_non_tso_bd_num = ae_dev->dev_specs.max_non_tso_bd_num;
+	priv->min_tx_copybreak = 0;
+	priv->min_tx_spare_buf_size = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d3bad5d1b888..933e3527ed82 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -596,6 +596,8 @@ struct hns3_nic_priv {
 	struct hns3_enet_coalesce rx_coal;
 	u32 tx_copybreak;
 	u32 rx_copybreak;
+	u32 min_tx_copybreak;
+	u32 min_tx_spare_buf_size;
 };
 
 union l3_hdr_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d5454e126c85..a752d0e3db3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1927,6 +1927,31 @@ static int hns3_set_tx_spare_buf_size(struct net_device *netdev,
 	return ret;
 }
 
+static int hns3_check_tx_copybreak(struct net_device *netdev, u32 copybreak)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	if (copybreak < priv->min_tx_copybreak) {
+		netdev_err(netdev, "tx copybreak %u should be no less than %u!\n",
+			   copybreak, priv->min_tx_copybreak);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hns3_check_tx_spare_buf_size(struct net_device *netdev, u32 buf_size)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	if (buf_size < priv->min_tx_spare_buf_size) {
+		netdev_err(netdev,
+			   "tx spare buf size %u should be no less than %u!\n",
+			   buf_size, priv->min_tx_spare_buf_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int hns3_set_tunable(struct net_device *netdev,
 			    const struct ethtool_tunable *tuna,
 			    const void *data)
@@ -1943,6 +1968,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
 	switch (tuna->id) {
 	case ETHTOOL_TX_COPYBREAK:
+		ret = hns3_check_tx_copybreak(netdev, *(u32 *)data);
+		if (ret)
+			return ret;
+
 		priv->tx_copybreak = *(u32 *)data;
 
 		for (i = 0; i < h->kinfo.num_tqps; i++)
@@ -1957,6 +1986,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
 		break;
 	case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
+		ret = hns3_check_tx_spare_buf_size(netdev, *(u32 *)data);
+		if (ret)
+			return ret;
+
 		old_tx_spare_buf_size = h->kinfo.tx_spare_buf_size;
 		new_tx_spare_buf_size = *(u32 *)data;
 		netdev_info(netdev, "request to set tx spare buf size from %u to %u\n",
-- 
2.33.0


