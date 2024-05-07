Return-Path: <netdev+bounces-94132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CC8BE4B1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEECF1F2316D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA215F40F;
	Tue,  7 May 2024 13:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EF15F33A;
	Tue,  7 May 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089800; cv=none; b=EQJApIedVjvkSloHhQCNCMroEKssPZGHF+Zg98mc3mOy5M5AcSCKFNhAO40HnK/5t3dfClIKyBiJgwve6VT3DLRbrLtiCalTOfMTVIlwAC0B9LmPwV4bomR5TZ2mDbRpeKiIgy/MkGx6ruKihZJnWwWNsurYS6XOrvZtaSnWp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089800; c=relaxed/simple;
	bh=SQl0q/8waWVM6wWYngzX0yhg7N5kSFKRxNmdDKQD0JA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iY8GkUxlVR4EeuzIfpISWixX1Hf71asCjC8onKE1gkrw3PVAECsgKBaX/sC8U14DbZLADjMIj27E0v9F1AJaduE0S4N/AByfjmRZA9PXkXPeYrRW0LkY1384z3nIjlyq4WMpU+Hwii5kLznL6NCjN68OovShSoZq434ELli+lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYfh83SyRz1RCRk;
	Tue,  7 May 2024 21:46:32 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 24B3F180065;
	Tue,  7 May 2024 21:49:51 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 3/7] net: hns3: change type of numa_node_mask as nodemask_t
Date: Tue, 7 May 2024 21:42:20 +0800
Message-ID: <20240507134224.2646246-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240507134224.2646246-1-shaojijie@huawei.com>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Peiyang Wang <wangpeiyang1@huawei.com>

It provides nodemask_t to describe the numa node mask in kernel. To
improve transportability, change the type of numa_node_mask as nodemask_t.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 7 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index f19f1e1d1f9f..133c94646c21 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -897,7 +897,7 @@ struct hnae3_handle {
 		struct hnae3_roce_private_info rinfo;
 	};
 
-	u32 numa_node_mask;	/* for multi-chip support */
+	nodemask_t numa_node_mask; /* for multi-chip support */
 
 	enum hnae3_port_base_vlan_state port_base_vlan_state;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 8043f1795dc7..ecff9b426527 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1769,7 +1769,8 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 
 	nic->pdev = hdev->pdev;
 	nic->ae_algo = &ae_algo;
-	nic->numa_node_mask = hdev->numa_node_mask;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
 	ret = hclge_knic_setup(vport, num_tqps,
@@ -2461,7 +2462,8 @@ static int hclge_init_roce_base_info(struct hclge_vport *vport)
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index e3c69be8256f..3a9186457ad8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -894,7 +894,7 @@ struct hclge_dev {
 
 	u16 fdir_pf_filter_count; /* Num of guaranteed filters for this PF */
 	u16 num_alloc_vport;		/* Num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;		/* desc num of per tx queue */
 	u16 num_rx_desc;		/* desc num of per rx queue */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0aa9beefd1c7..b57111252d07 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -412,7 +412,8 @@ static int hclgevf_set_handle_info(struct hclgevf_dev *hdev)
 
 	nic->ae_algo = &ae_algovf;
 	nic->pdev = hdev->pdev;
-	nic->numa_node_mask = hdev->numa_node_mask;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	nic->flags |= HNAE3_SUPPORT_VF;
 	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
@@ -2082,8 +2083,8 @@ static int hclgevf_init_roce_base_info(struct hclgevf_dev *hdev)
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
-
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index a73f2bf3a56a..cccef3228461 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -236,7 +236,7 @@ struct hclgevf_dev {
 	u16 rss_size_max;	/* HW defined max RSS task queue */
 
 	u16 num_alloc_vport;	/* num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;	/* desc num of per tx queue */
 	u16 num_rx_desc;	/* desc num of per rx queue */
-- 
2.30.0


