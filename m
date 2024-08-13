Return-Path: <netdev+bounces-118085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C19950762
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59C6284439
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351119E7DC;
	Tue, 13 Aug 2024 14:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3019924F;
	Tue, 13 Aug 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558611; cv=none; b=Y8DBvLY1KtrGwTKQJ47T/o0iIBxIkpkKcaTzwhoRvhmi40KqezVcl0r/aqrzgdHz3rqeECg7Km/Te7cDtVSZrJClr2djQbYFsOUGNP8LPx4fvd51QhZbvUGGB/hNE6s83d9D8LTBpP/b6Aq1ykOBxrS6hPqWudRm9DqsDFzjAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558611; c=relaxed/simple;
	bh=J11hOlRMR2YUDq4Lq+k+J7qeJfIM8WmNc/YIfFH1Z0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IadtNj8ah73DzXTw/bq5JiLeMlXhb03nv45jcGfJbdSL0icv2LZP3T1XNmvbS1LM/SZL7Z4Ei3UxT0wevyao2mrOg31JFzl6LpiBlCl4MIsJTBtzDhLWAW5YH91vLNBghJ1920lvjPP8Vvet09HUCem8Zawe0U2FwIEdL13cNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WjtcB1tYcz1S7gg;
	Tue, 13 Aug 2024 22:11:54 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A9791A0188;
	Tue, 13 Aug 2024 22:16:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:16:44 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 4/5] net: hns3: void array out of bound when loop tnl_num
Date: Tue, 13 Aug 2024 22:10:23 +0800
Message-ID: <20240813141024.1707252-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813141024.1707252-1-shaojijie@huawei.com>
References: <20240813141024.1707252-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

From: Peiyang Wang <wangpeiyang1@huawei.com>

When query reg inf of SSU, it loops tnl_num times. However, tnl_num comes
from hardware and the length of array is a fixed value. To void array out
of bound, make sure the loop time is not greater than the length of array

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index e132c2f09560..cc7f46c0b35f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1598,8 +1598,7 @@ static void hclge_query_reg_info_of_ssu(struct hclge_dev *hdev)
 {
 	u32 loop_para[HCLGE_MOD_MSG_PARA_ARRAY_MAX_SIZE] = {0};
 	struct hclge_mod_reg_common_msg msg;
-	u8 i, j, num;
-	u32 loop_time;
+	u8 i, j, num, loop_time;
 
 	num = ARRAY_SIZE(hclge_ssu_reg_common_msg);
 	for (i = 0; i < num; i++) {
@@ -1609,7 +1608,8 @@ static void hclge_query_reg_info_of_ssu(struct hclge_dev *hdev)
 		loop_time = 1;
 		loop_para[0] = 0;
 		if (msg.need_para) {
-			loop_time = hdev->ae_dev->dev_specs.tnl_num;
+			loop_time = min(hdev->ae_dev->dev_specs.tnl_num,
+					HCLGE_MOD_MSG_PARA_ARRAY_MAX_SIZE);
 			for (j = 0; j < loop_time; j++)
 				loop_para[j] = j + 1;
 		}
-- 
2.33.0


