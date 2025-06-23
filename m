Return-Path: <netdev+bounces-200122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38533AE342C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92A77A5F39
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6C1A5BA4;
	Mon, 23 Jun 2025 04:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC224B28;
	Mon, 23 Jun 2025 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651661; cv=none; b=ILbdS6i80KnGn88TIMtAX5IE6QrvoqbCxOh7SA2cYWNW7T6PQM9k9YBKWrk5dPnbbBhdp0XxfS4q6SVMQWnykl3fOV51191nZI7+d8EMuMMBNg7mruUy8T5Z2hWjZQgJUXcc5//3lJftlvBqNdopTCyjuxwOZLqLDqslRufFfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651661; c=relaxed/simple;
	bh=K9H7I0xoL8bA9Vzt0jjvtk5vgmFCk4kPS3mT75zEwOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBaXN1b57TXphdthkxqgqTYJo5Btr1qFaj4g6KNA22DWJhrRPSlgLEmDQ7xbHcqCUQj3cQUboqojZN0e4PyUTAhx95jB21QcsUECW8v6JlYUH4MjH0bvHm5mBcmzlRNUpKSmgdEzV2PXkHn/hLtF6gO+bFrSBge6yvsBUq4Ipjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bQZFS0QYdzPss3;
	Mon, 23 Jun 2025 12:03:40 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CA9F8180B4A;
	Mon, 23 Jun 2025 12:07:36 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 12:07:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v4 net-next 5/7] net: hns3: delete redundant address before the array
Date: Mon, 23 Jun 2025 12:00:41 +0800
Message-ID: <20250623040043.857782-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623040043.857782-1-shaojijie@huawei.com>
References: <20250623040043.857782-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Yonglong Liu <liuyonglong@huawei.com>

Address before the array is redundant, this patch delete it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index 205cdbb81743..1282e4f75db9 100644
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


