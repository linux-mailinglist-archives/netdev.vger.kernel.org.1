Return-Path: <netdev+bounces-142863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FFB9C07B3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1701F242B5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAE214403;
	Thu,  7 Nov 2024 13:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80A20EA46;
	Thu,  7 Nov 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986629; cv=none; b=UNGn5YFh6MIRasQDgvcu4b4lzkvF7TmstDY4W0XV5xSD7jybBfSf9rziKm2Vy3TRj516qzLxRpAn7kcch7L1LZyUSLTixOomCEIzzcGaKRKkC1GwHosXA6MezlKe2/jgMxHsrm9DEazcv/gVBzEfnZmV/kj18Yk4aoAn6kDBUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986629; c=relaxed/simple;
	bh=1NfpTGa+610LIA5bCYj2z5h3/CQnRL8PXNg8NwDimvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNsl1Q9wbq9UGdyXLcWEOarNQibp3U6EQukZl2Y/UcHN/yRdCgFSFpB0Pl1CrMB4nUzLT4O0MdzopXt/9/drR4JsjwNCBDr+Zfv+YvzQW1g93EGOfL9s9wf4s1fWnV7KXhXNNKDZzjM1yKGkYIcGl5hoyM533ehJ9PRc9aXmULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xkjkz3ZtZz20sqC;
	Thu,  7 Nov 2024 21:35:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F7001402E2;
	Thu,  7 Nov 2024 21:37:03 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 21:37:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net 6/7] net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue
Date: Thu, 7 Nov 2024 21:30:22 +0800
Message-ID: <20241107133023.3813095-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241107133023.3813095-1-shaojijie@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
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

From: Hao Lan <lanhao@huawei.com>

The TQP BAR space is divided into two segments. TQPs 0-1023 and TQPs
1024-1279 are in different BAR space addresses. However,
hclge_fetch_pf_reg does not distinguish the tqp space information when
reading the tqp space information. When the number of TQPs is greater
than 1024, access bar space overwriting occurs.
The problem of different segments has been considered during the
initialization of tqp.io_base. Therefore, tqp.io_base is directly used
when the queue is read in hclge_fetch_pf_reg.

The error message:

Unable to handle kernel paging request at virtual address ffff800037200000
pc : hclge_fetch_pf_reg+0x138/0x250 [hclge]
lr : hclge_get_regs+0x84/0x1d0 [hclge]
Call trace:
 hclge_fetch_pf_reg+0x138/0x250 [hclge]
 hclge_get_regs+0x84/0x1d0 [hclge]
 hns3_get_regs+0x2c/0x50 [hns3]
 ethtool_get_regs+0xf4/0x270
 dev_ethtool+0x674/0x8a0
 dev_ioctl+0x270/0x36c
 sock_do_ioctl+0x110/0x2a0
 sock_ioctl+0x2ac/0x530
 __arm64_sys_ioctl+0xa8/0x100
 invoke_syscall+0x4c/0x124
 el0_svc_common.constprop.0+0x140/0x15c
 do_el0_svc+0x30/0xd0
 el0_svc+0x1c/0x2c
 el0_sync_handler+0xb0/0xb4
 el0_sync+0x168/0x180

Fixes: 939ccd107ffc ("net: hns3: move dump regs function to a separate file")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c  | 9 +++++----
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
index 43c1c18fa81f..8c057192aae6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
@@ -510,9 +510,9 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
 static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
 			      struct hnae3_knic_private_info *kinfo)
 {
-#define HCLGE_RING_REG_OFFSET		0x200
 #define HCLGE_RING_INT_REG_OFFSET	0x4
 
+	struct hnae3_queue *tqp;
 	int i, j, reg_num;
 	int data_num_sum;
 	u32 *reg = data;
@@ -533,10 +533,11 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
 	reg_num = ARRAY_SIZE(ring_reg_addr_list);
 	for (j = 0; j < kinfo->num_tqps; j++) {
 		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_RING, reg_num, reg);
+		tqp = kinfo->tqp[j];
 		for (i = 0; i < reg_num; i++)
-			*reg++ = hclge_read_dev(&hdev->hw,
-						ring_reg_addr_list[i] +
-						HCLGE_RING_REG_OFFSET * j);
+			*reg++ = readl_relaxed(tqp->io_base -
+					       HCLGE_TQP_REG_OFFSET +
+					       ring_reg_addr_list[i]);
 	}
 	data_num_sum += (reg_num + HCLGE_REG_TLV_SPACE) * kinfo->num_tqps;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
index 6db415d8b917..7d9d9dbc7560 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
@@ -123,10 +123,10 @@ int hclgevf_get_regs_len(struct hnae3_handle *handle)
 void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 		      void *data)
 {
-#define HCLGEVF_RING_REG_OFFSET		0x200
 #define HCLGEVF_RING_INT_REG_OFFSET	0x4
 
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hnae3_queue *tqp;
 	int i, j, reg_um;
 	u32 *reg = data;
 
@@ -147,10 +147,11 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 	reg_um = ARRAY_SIZE(ring_reg_addr_list);
 	for (j = 0; j < hdev->num_tqps; j++) {
 		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
+		tqp = &hdev->htqp[j].q;
 		for (i = 0; i < reg_um; i++)
-			*reg++ = hclgevf_read_dev(&hdev->hw,
-						  ring_reg_addr_list[i] +
-						  HCLGEVF_RING_REG_OFFSET * j);
+			*reg++ = readl_relaxed(tqp->io_base -
+					       HCLGEVF_TQP_REG_OFFSET +
+					       ring_reg_addr_list[i]);
 	}
 
 	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
-- 
2.33.0


