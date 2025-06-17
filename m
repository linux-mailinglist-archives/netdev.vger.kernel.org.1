Return-Path: <netdev+bounces-198366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF4ADBE65
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3618B7A801C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710E1E25E3;
	Tue, 17 Jun 2025 01:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62401A5B85;
	Tue, 17 Jun 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122601; cv=none; b=tvsszAntQ4t89oHUU612aFLW7Ko3N2w8gVIcM5toOx9ieUzTVXZqeCagrXMuvX0m4ratorAF/ikjPpUPMrz89se8tOChxjltkNqeBgtsb+V3oqq/O+sCnQr6j72hmEZ1V8tVlXuxScRma8Zfj9E45dkyLMM84TmT0WGqyRyCWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122601; c=relaxed/simple;
	bh=9mrKoGUe6Vlojg69hEInfg1bG/5otYIqtTsH6wU58k0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufyq1PgGAoNdpXCF1bf7GqGNUTqzGs7rjIXzSPOL7PvtLbwER0pbatS3AR1iR81YCKbf6AMklXgzvh3wSl1hMr4Ij5fVRl5ER7Bqg+/2ov6r1O0TEsWyCLKQsddN4EuqXPww52APdGtw4mFT6BBs996ClEKmLbgkECORsQYS7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLpf71L9zz2TSLW;
	Tue, 17 Jun 2025 09:08:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BAF7D140275;
	Tue, 17 Jun 2025 09:09:57 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 09:09:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 6/8] net: hns3: delete redundant address before the array
Date: Tue, 17 Jun 2025 09:02:53 +0800
Message-ID: <20250617010255.1183069-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250617010255.1183069-1-shaojijie@huawei.com>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
index 9d7c9523c9e1..b76400e67a23 100644
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


