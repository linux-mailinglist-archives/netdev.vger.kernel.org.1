Return-Path: <netdev+bounces-199510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41BAE0913
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1EF3BB7FA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E43248F55;
	Thu, 19 Jun 2025 14:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44141AF0B5;
	Thu, 19 Jun 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344497; cv=none; b=Iob3goA6rAbm0gV0rsFidQ7aqPckz5gSuLxvyHiccMkYc5iNMBy1P1PhSIaS/JZY95vYPna2IL4uyLoKGyfU75UW9QtahMJE+L55dteKWp+0XVnOHAP+eELJ7NyvcBqwxf3eRQGd6dpLfWVE0jWKbEJmjmEk7I2xf/rqdarx98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344497; c=relaxed/simple;
	bh=YjMS2CcpuzRSbboHGnLRakfRmitcWwOqCbDpXu5+n/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnc7OqXLD97nvkfLxtBHtbf8vGSE+HeiqMNRDY9t/OODpTL9Oh+CO1Kx16udywBGSZPG5oBUFAPRuT3vIb15JFCJNbF2XHieYj1BB7us9VP6eVJRnkNcTtCZQbBPF0nYpG8ip1veiPb6mIot8C4fMePFVJlhl8xV+6zWi0b18+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bNNf26wL3zRk5T;
	Thu, 19 Jun 2025 22:43:54 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D6A8B180B6A;
	Thu, 19 Jun 2025 22:48:11 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 22:48:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 5/8] net: hns3: set the freed pointers to NULL when lifetime is not end
Date: Thu, 19 Jun 2025 22:40:54 +0800
Message-ID: <20250619144057.2587576-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250619144057.2587576-1-shaojijie@huawei.com>
References: <20250619144057.2587576-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

There are several pointers are freed but not set to NULL,
and their lifetime is not end immediately. To avoid misusing
there wild pointers, set them to NULL.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v2 -> v3:
  - Remove unnecessary pointer set to NULL operation, suggested by Simon Horman.
  v2: https://lore.kernel.org/all/20250617010255.1183069-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e0a2ca21ee46..9d7c9523c9e1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5208,6 +5208,7 @@ static void hclge_fd_free_node(struct hclge_dev *hdev,
 {
 	hlist_del(&rule->rule_node);
 	kfree(rule);
+	rule = NULL;
 	hclge_sync_fd_state(hdev);
 }
 
@@ -5232,6 +5233,7 @@ static void hclge_update_fd_rule_node(struct hclge_dev *hdev,
 		new_rule->rule_node.pprev = old_rule->rule_node.pprev;
 		memcpy(old_rule, new_rule, sizeof(*old_rule));
 		kfree(new_rule);
+		new_rule = NULL;
 		break;
 	case HCLGE_FD_DELETED:
 		hclge_fd_dec_rule_cnt(hdev, old_rule->location);
@@ -8521,6 +8523,7 @@ static void hclge_update_mac_node(struct hclge_mac_node *mac_node,
 		if (mac_node->state == HCLGE_MAC_TO_ADD) {
 			list_del(&mac_node->node);
 			kfree(mac_node);
+			mac_node = NULL;
 		} else {
 			mac_node->state = HCLGE_MAC_TO_DEL;
 		}
@@ -9151,6 +9154,7 @@ static void hclge_uninit_vport_mac_list(struct hclge_vport *vport,
 		case HCLGE_MAC_TO_ADD:
 			list_del(&mac_node->node);
 			kfree(mac_node);
+			mac_node = NULL;
 			break;
 		}
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index e3f86638540b..3ffd47b30ad3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -933,6 +933,7 @@ static void hclgevf_update_mac_node(struct hclgevf_mac_addr_node *mac_node,
 		if (mac_node->state == HCLGEVF_MAC_TO_ADD) {
 			list_del(&mac_node->node);
 			kfree(mac_node);
+			mac_node = NULL;
 		} else {
 			mac_node->state = HCLGEVF_MAC_TO_DEL;
 		}
@@ -2395,6 +2396,7 @@ static int hclgevf_init_msi(struct hclgevf_dev *hdev)
 					sizeof(int), GFP_KERNEL);
 	if (!hdev->vector_irq) {
 		devm_kfree(&pdev->dev, hdev->vector_status);
+		hdev->vector_status = NULL;
 		pci_free_irq_vectors(pdev);
 		return -ENOMEM;
 	}
@@ -2408,6 +2410,8 @@ static void hclgevf_uninit_msi(struct hclgevf_dev *hdev)
 
 	devm_kfree(&pdev->dev, hdev->vector_status);
 	devm_kfree(&pdev->dev, hdev->vector_irq);
+	hdev->vector_status = NULL;
+	hdev->vector_irq = NULL;
 	pci_free_irq_vectors(pdev);
 }
 
-- 
2.33.0


