Return-Path: <netdev+bounces-155501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8DA02858
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6322018864D7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A21DF96F;
	Mon,  6 Jan 2025 14:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393A1DE8B8;
	Mon,  6 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174658; cv=none; b=SYbsVGrb6f8W+bzgq6f1i0kCCWaoggW8FuyrS+S4lQfUcDMU0loda+M/xVqZsUagMffVILdvJdgZ/VBSjniUo4GVKopXpyLdR1aCF1Eb5uxO66C8YzrTZGM9dvBKq1qpA+DDKjqDCfowbZ/nI5Rj51omh4DezkBINDNdsRCEL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174658; c=relaxed/simple;
	bh=eKWEx8xRwhTllo6yhgTJcmyURg0CWnNx4rpL7atPUec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/5/BZ0gGGxdnuD03KMK7JUeKV3PXk6J9nwSyA1sqWCR9tg6CHmEqXgkkmCS8lR6wJ1t7wMvxBSaRZTWMXdm9J7ebFFkX44HTBCLDfvMQ/01oJvHkrOFGy1cK3gsCZ7KL4JHFvbhdaTLOVgrB1XYEIGtkNhNjTAx6gEN9NKvzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YRcKt1rZtz1W3D5;
	Mon,  6 Jan 2025 22:40:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F171402D0;
	Mon,  6 Jan 2025 22:44:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 22:44:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 6/7] net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue
Date: Mon, 6 Jan 2025 22:36:41 +0800
Message-ID: <20250106143642.539698-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106143642.539698-1-shaojijie@huawei.com>
References: <20250106143642.539698-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


