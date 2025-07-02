Return-Path: <netdev+bounces-203350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1AAF5858
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A73AA6ED
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2927A468;
	Wed,  2 Jul 2025 13:15:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAE277009;
	Wed,  2 Jul 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462158; cv=none; b=Et3l4hdWpGdV92SWxSuYSHx+Rgt06SJfhJZTgB3WptSZihuJAu4uxiZDiBbm4LkKupo/bbCtQsnocxXzNA/2ZjZ9exChKn0pI/65uz6GFnC7RBGV6Fk0OY2T11x82Xa8vQRt7aRN74WNxHZYjeZNl8LwuNbeshnTITtTZsDwNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462158; c=relaxed/simple;
	bh=1jz1lYd7x2I0708KNfVafPGFiL/QsP1Pdqv8jXtYEYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tV22DIbV1t2WT1LoyACut7m/NuBDt1t0cZy5G6N+fJucH8u1+JMTvUQlaOMYjyshQWc1Lkoi1/wk4S1abBSc5Fnor51tzQpPDL/Ygk4Xj0DxpO1/f6KWZ+c0378EH5IuEghdxHRK8aMnnj1r9n0YvGbxJzp6hz/+D4Y4TXw4SQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bXL1c5kq8z1d1ZK;
	Wed,  2 Jul 2025 21:13:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 937E0180B60;
	Wed,  2 Jul 2025 21:15:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 21:15:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 3/4] net: hns3: fixed vf get max channels bug
Date: Wed, 2 Jul 2025 21:09:00 +0800
Message-ID: <20250702130901.2879031-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250702130901.2879031-1-shaojijie@huawei.com>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Hao Lan <lanhao@huawei.com>

Currently, the queried maximum of vf channels is the maximum of channels
supported by each TC. However, the actual maximum of channels is
the maximum of channels supported by the device.

Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 33136a1e02cf..626f5419fd7d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
 {
-	struct hnae3_handle *nic = &hdev->nic;
-	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
-
-	return min_t(u32, hdev->rss_size_max,
-		     hdev->num_tqps / kinfo->tc_info.num_tc);
+	return min_t(u32, hdev->rss_size_max, hdev->num_tqps);
 }
 
 /**
-- 
2.33.0


