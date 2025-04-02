Return-Path: <netdev+bounces-178779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74DA78DFE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193B616EDDD
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF01D7E57;
	Wed,  2 Apr 2025 12:16:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557820E01D;
	Wed,  2 Apr 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596187; cv=none; b=dNlE3rwFXSK34LPAAcKW8Ja2sIn2DMVpm8vcBrbtNPa8g3RptKZbm5hRaQ+7+RAQrrAJbPL0F7EMfv4fCKCz4prXMZl6MsY3VsiJmFMfb/bB6qTqB83LlAxMMHUgG4WrAvlGnUl5RBGYoMA03/uuvrH0wPxlaNXIwapbuVMpwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596187; c=relaxed/simple;
	bh=wMzkNwLUkTDB2rGAA3d36B+dNkQV51SXRAiylkF+XTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD2w7CZCNFy5AenwICrGhGXrHFk22bJ0rKF7vI96zD/Qq76TGb2ePEJ/Eu9Zr/fNNAKGF1oexsV6Pa+zF7U5q/ZsjzA1MsJqbFvnUQxnXeAcKqfLNelP340sYFyhjBuckRvWByUuIfwBa/3HFlQWNfZlKIYn2ckNxGhxVDx1BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSNz83psWzvWq0;
	Wed,  2 Apr 2025 20:12:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CB9C14010D;
	Wed,  2 Apr 2025 20:16:20 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:16:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 3/3] net: hns3: store rx VLAN tag offload state for VF
Date: Wed, 2 Apr 2025 20:10:01 +0800
Message-ID: <20250402121001.663431-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402121001.663431-1-shaojijie@huawei.com>
References: <20250402121001.663431-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

The VF driver missed to store the rx VLAN tag strip state when
user change the rx VLAN tag offload state. And it will default
to enable the rx vlan tag strip when re-init VF device after
reset. So if user disable rx VLAN tag offload, and trig reset,
then the HW will still strip the VLAN tag from packet nad fill
into RX BD, but the VF driver will ignore it for rx VLAN tag
offload disabled. It may cause the rx VLAN tag dropped.

Fixes: b2641e2ad456 ("net: hns3: Add support of hardware rx-vlan-offload to HNS3 VF driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 25 ++++++++++++++-----
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  3 ++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 9ba767740a04..dada42e7e0ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1292,9 +1292,8 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	rtnl_unlock();
 }
 
-static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+static int hclgevf_en_hw_strip_rxvtag_cmd(struct hclgevf_dev *hdev, bool enable)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclge_vf_to_pf_msg send_msg;
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1303,6 +1302,19 @@ static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclgevf_send_mbx_msg(hdev, &send_msg, false, NULL, 0);
 }
 
+static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int ret;
+
+	ret = hclgevf_en_hw_strip_rxvtag_cmd(hdev, enable);
+	if (ret)
+		return ret;
+
+	hdev->rxvtag_strip_en = enable;
+	return 0;
+}
+
 static int hclgevf_reset_tqp(struct hnae3_handle *handle)
 {
 #define HCLGEVF_RESET_ALL_QUEUE_DONE	1U
@@ -2204,12 +2216,13 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 					  tc_valid, tc_size);
 }
 
-static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
+static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev,
+				    bool rxvtag_strip_en)
 {
 	struct hnae3_handle *nic = &hdev->nic;
 	int ret;
 
-	ret = hclgevf_en_hw_strip_rxvtag(nic, true);
+	ret = hclgevf_en_hw_strip_rxvtag(nic, rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to enable rx vlan offload, ret = %d\n", ret);
@@ -2879,7 +2892,7 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, hdev->rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
@@ -2994,7 +3007,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		goto err_config;
 	}
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, true);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index cccef3228461..1e452b14b04e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -252,7 +252,8 @@ struct hclgevf_dev {
 	u16 *vector_status;
 	int *vector_irq;
 
-	bool gro_en;
+	u32 gro_en :1;
+	u32 rxvtag_strip_en :1;
 
 	unsigned long vlan_del_fail_bmap[BITS_TO_LONGS(VLAN_N_VID)];
 
-- 
2.33.0


