Return-Path: <netdev+bounces-196780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B556AD6576
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E8517EB38
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6731DAC95;
	Thu, 12 Jun 2025 02:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947E1C07C3;
	Thu, 12 Jun 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694856; cv=none; b=Xrmf6wlmOd8th5sv4pdPmZQOi9QW7D1qXUr49VL6FacuRr4d4h/vvI6ltxyZLQsyEEeLpRqBeAX8QWN/+rAKellzgH1B10jerNv5EbTvQ0HsKBqfiRml6F2v+0s3c365OyRfFgdauJ98t9zhGUqBtdxW1gidxcy1PN94ZMgT4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694856; c=relaxed/simple;
	bh=BuNk95BHPv2OoLEPlcpCFaWC6Pouxc5RcUlu/J6TdxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyzLHkUJ4g6d3SfrIuEnRs6i/jH97v7cx47R4BHUUyG4Kg6vQ5/p2HNEw+aeaiaGoaSK265BFrMDk6j9YfU0TyHNbpduxyZdDkrkkQu9Ok80hoZPvUn8jSxapCzbLDhrYuiqRV8tt0t0LRVNw1BbMFcq9reuu0ExxLMHdzSjEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bHmP31dDpzRk21;
	Thu, 12 Jun 2025 10:16:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B8D3C180B64;
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
Subject: [PATCH net-next 6/8] net: hns3: delete redundant address before the array
Date: Thu, 12 Jun 2025 10:13:15 +0800
Message-ID: <20250612021317.1487943-7-shaojijie@huawei.com>
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

From: Yonglong Liu <liuyonglong@huawei.com>

Address before the array is redundant, this patch delete it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index c46490693594..21deec217668 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2110,7 +2110,7 @@ static int hclge_dbg_dump_mng_table(struct hclge_dev *hdev, char *buf, int len)
 	for (i = 0; i < HCLGE_DBG_MNG_TBL_MAX; i++) {
 		hclge_cmd_setup_basic_desc(&desc, HCLGE_MAC_ETHERTYPE_IDX_RD,
 					   true);
-		req0 = (struct hclge_mac_ethertype_idx_rd_cmd *)&desc.data;
+		req0 = (struct hclge_mac_ethertype_idx_rd_cmd *)desc.data;
 		req0->index = cpu_to_le16(i);
 
 		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d35be31442e6..ddd11a575c2a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2358,7 +2358,7 @@ static int hclge_common_thrd_config(struct hclge_dev *hdev,
 	for (i = 0; i < 2; i++) {
 		hclge_cmd_setup_basic_desc(&desc[i],
 					   HCLGE_OPC_RX_COM_THRD_ALLOC, false);
-		req = (struct hclge_rx_com_thrd *)&desc[i].data;
+		req = (struct hclge_rx_com_thrd *)desc[i].data;
 
 		/* The first descriptor set the NEXT bit to 1 */
 		if (i == 0)
-- 
2.33.0


