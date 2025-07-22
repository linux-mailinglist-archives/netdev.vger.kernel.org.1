Return-Path: <netdev+bounces-208942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C1B0DA71
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AAC16DAB7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842D2EA155;
	Tue, 22 Jul 2025 13:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328428B4F9;
	Tue, 22 Jul 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189303; cv=none; b=YeESDXeydKbzWGz9I6aAV7LXpCBvrhpuJc7fYkD69av6vmbLz1CvTzpvyVVEbUjVsLy16NIlXkZg+eQoLtGUoVFzyS6TEvxt4uv8jV70FirpH/YBNGfnn80ubRBvpx8VuXiaLqBVjyqeMbCn5Xw4Yjze0mrCmx0ewplc0JPtsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189303; c=relaxed/simple;
	bh=fEhJXPEiLt3ESxN02Ob/dOP9PCSDXCAXzSGnewvrMvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQzM2EyP3At57yXTtxasGlh59rL65OQI/Flpnc8oW9CxvbxgltifLGRqkmB4eh2qe9ZKuND4VsiYP2FiroKqG7ltEO73+iU+SBxE8rnyo9tBfiKyRlTlFKVirun4Fzo262qkqSn4d3JsgA4Nx2pdtLqqeyr+L6lubXhpF4K1BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bmcmF3dCqz2RVqt;
	Tue, 22 Jul 2025 20:59:25 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AE3DE18001B;
	Tue, 22 Jul 2025 21:01:37 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 21:01:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 3/4] net: hns3: fixed vf get max channels bug
Date: Tue, 22 Jul 2025 20:54:22 +0800
Message-ID: <20250722125423.1270673-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
References: <20250722125423.1270673-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Currently, the queried maximum of vf channels is the maximum of channels
supported by each TC. However, the actual maximum of channels is
the maximum of channels supported by the device.

Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v1 -> v2:
  - Replace min_t() with min(), suggested by Simon Horman
  v1: https://lore.kernel.org/all/20250702130901.2879031-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c4f35e8e2177..4cf6ac04662a 100644
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
+	return min(hdev->rss_size_max, hdev->num_tqps);
 }
 
 /**
-- 
2.33.0


