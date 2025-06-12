Return-Path: <netdev+bounces-196781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A948AD6578
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE97189CA11
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E201DE2A0;
	Thu, 12 Jun 2025 02:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632272622;
	Thu, 12 Jun 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694856; cv=none; b=T9v1wv8/BNCPJ+GUX26u7V4XRAaiYJvxorCSuljEra14V9ybSnu2cAQrlB61WTkJn5sNfcQM5srZ6j25g0WLG0f9q7pnVUR9/sOfUSmLTosy8Sfni6OaQ4asl1zwSC1f4foGsdd6Gr5S36uG6J9JP0Jjf3P2ERwDkt1z0kvjU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694856; c=relaxed/simple;
	bh=98gmCq4A4uZI0+vufjsL2MJYUFMETa0YE+pJrpv/HZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r76uKanhPv54QwdrCJlbJlk+QcLUvJ8jzgFnmyCKMDum/L/tJhAuWVgBOG2tvHd0oLHAZ8LXdsi5Hca+whKURxBq8tn03vE4bpYH3JOdUlC6qWVBcT+h6zuIt8aSVP/m935P0/JgqekelYRdKllTiwhe2Vp5HcE7bXDlBbFGnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bHmSX4J3nztS3L;
	Thu, 12 Jun 2025 10:19:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DEDC14027A;
	Thu, 12 Jun 2025 10:20:52 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 10:20:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 5/8] net: hns3: set the freed pointers to NULL when lifetime is not end
Date: Thu, 12 Jun 2025 10:13:14 +0800
Message-ID: <20250612021317.1487943-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250612021317.1487943-1-shaojijie@huawei.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

There are several pointers are freed but not set to NULL,
and their lifetime is not end immediately. To avoid misusing
there wild pointers, set them to NULL.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 6a244ba5e051..0d6db46db5ed 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -276,6 +276,7 @@ static int hns3_lp_run_test(struct net_device *ndev, enum hnae3_loop mode)
 			good_cnt++;
 		} else {
 			kfree_skb(skb);
+			skb = NULL;
 			netdev_err(ndev, "hns3_lb_run_test xmit failed: %d\n",
 				   tx_ret);
 		}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 7545e70c7726..d35be31442e6 100644
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
index 06065b653019..d1883ec7f8cf 100644
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


