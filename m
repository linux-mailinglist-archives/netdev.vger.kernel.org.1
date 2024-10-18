Return-Path: <netdev+bounces-136933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9E9A3B3C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65023282A8D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01C2036F8;
	Fri, 18 Oct 2024 10:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44808201117;
	Fri, 18 Oct 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246651; cv=none; b=OrAet/cUBLDcKx0B05Iy9189cleMEt6C14E6g52+ymKaXA/3KPIH2eapbc+YNKQ6Jf18Ux35k1IbLM66RV2I+Ltoh2LeehDKU60NL3A6Cq+ROXGshEoqAEBBBgi/cGFXNK4olbqEUB+OS/SpeUQUgb0bqgIeh1yDKe0b7QuqUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246651; c=relaxed/simple;
	bh=JcKNGsASUm3p4lB1vjqQZTKnc0P4J30lLGn3yjwfGGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7PYlh9+UjgtoatPTxZKm34HHOkXcLLhnpfAEM7QDja5WqCz1hmP5uXeE8ANLr3DGmY/FS/YTAkEneb8fmN/bnDGNZoArCm8kqfn3dqw2MG4t+u/g5Z9mYxyuBAnJrc5BdLGZaBtcKl51XfzdE9ljW8T6AwXUEZBesH6rkCQWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVLFX3BD8zyTQk;
	Fri, 18 Oct 2024 18:16:00 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F8671402CF;
	Fri, 18 Oct 2024 18:17:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:25 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer when smmu enabled
Date: Fri, 18 Oct 2024 18:10:51 +0800
Message-ID: <20241018101059.1718375-2-shaojijie@huawei.com>
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

The SMMU engine on HIP09 chip has a hardware issue.
SMMU pagetable prefetch features may prefetch and use a invalid PTE
even the PTE is valid at that time. This will cause the device trigger
fake pagefaults. The solution is to avoid prefetching by adding a
SYNC command when smmu mapping a iova. But the performance of nic has a
sharp drop. Then we do this workaround, always enable tx bounce buffer,
avoid mapping/unmapping on TX path.

This issue only affects HNS3, so we always enable
tx bounce buffer when smmu enabled to improve performance.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 +++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4cbc4d069a1f..ac88e301f221 100644
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
@@ -1032,6 +1033,8 @@ static bool hns3_can_use_tx_sgl(struct hns3_enet_ring *ring,
 static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 {
 	u32 alloc_size = ring->tqp->handle->kinfo.tx_spare_buf_size;
+	struct net_device *netdev = ring_to_netdev(ring);
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hns3_tx_spare *tx_spare;
 	struct page *page;
 	dma_addr_t dma;
@@ -1073,6 +1076,7 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 	tx_spare->buf = page_address(page);
 	tx_spare->len = PAGE_SIZE << order;
 	ring->tx_spare = tx_spare;
+	ring->tx_copybreak = priv->tx_copybreak;
 	return;
 
 dma_mapping_error:
@@ -4868,6 +4872,30 @@ static void hns3_nic_dealloc_vector_data(struct hns3_nic_priv *priv)
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
@@ -5101,6 +5129,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 	int i, j;
 	int ret;
 
+	hns3_update_tx_spare_buf_config(priv);
 	for (i = 0; i < ring_num; i++) {
 		ret = hns3_alloc_ring_memory(&priv->ring[i]);
 		if (ret) {
@@ -5305,6 +5334,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->ae_handle = handle;
 	priv->tx_timeout_count = 0;
 	priv->max_non_tso_bd_num = ae_dev->dev_specs.max_non_tso_bd_num;
+	priv->min_tx_copybreak = 0;
+	priv->min_tx_spare_buf_size = 0;
 	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	handle->msg_enable = netif_msg_init(debug, DEFAULT_MSG_LEVEL);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d36c4ed16d8d..caf7a4df8585 100644
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
index b1e988347347..97eaeec1952b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1933,6 +1933,31 @@ static int hns3_set_tx_spare_buf_size(struct net_device *netdev,
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
@@ -1949,6 +1974,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
 	switch (tuna->id) {
 	case ETHTOOL_TX_COPYBREAK:
+		ret = hns3_check_tx_copybreak(netdev, *(u32 *)data);
+		if (ret)
+			return ret;
+
 		priv->tx_copybreak = *(u32 *)data;
 
 		for (i = 0; i < h->kinfo.num_tqps; i++)
@@ -1963,6 +1992,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
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


