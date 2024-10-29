Return-Path: <netdev+bounces-139928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40E9B4A56
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CD41C22838
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534120606A;
	Tue, 29 Oct 2024 12:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B89205E3F;
	Tue, 29 Oct 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206595; cv=none; b=HLDFV/TNSIFkbYxWlApdOgnBkEfvIJTSVYtdO9SkSUiUlDYviyrqSm8STYNZvLPFnnUOvkRm2HItQxPGPMbahGWD3MfCfuS80QT+TfOfGW9yvBu+ccOFXqv/fYtUMB/Cq6dYTb80NQYJDRlH6dlzvQQ6tCYZMpa0EZY0NSK0ZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206595; c=relaxed/simple;
	bh=tyo3Nc4syGk/FXCiD9NnYtlRpN5+7UlSgvNefxzTQIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJCbMBRcm/xlDJhVivc+4rQPUoCZIauLPXJfnmZYG51TmomjR/Ox1G9Yzltb2U7Doru6s/vfWRMw8AShOxNwOzAKpZ6yiA09e6LaRtATl6vsRIfIh7y84PlMzu8lvogfiY0p+CVEvlPc957LoyCgW6CxvrnfRMNVSxJsaMnUXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xd9Fm001PzyV4Z;
	Tue, 29 Oct 2024 20:54:51 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CAF7140257;
	Tue, 29 Oct 2024 20:56:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Oct
 2024 20:56:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chandrashekar.devegowda@intel.com>, <chiranjeevi.rapolu@linux.intel.com>,
	<haijun.liu@mediatek.com>, <m.chetan.kumar@linux.intel.com>,
	<ricardo.martinez@linux.intel.com>, <loic.poulain@linaro.org>,
	<ryazanov.s.a@gmail.com>, <johannes@sipsolutions.net>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v2] net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()
Date: Tue, 29 Oct 2024 20:56:00 +0800
Message-ID: <20241029125600.3036659-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
allocated and mapped skb in a loop, but the loop condition terminates when
the index reaches zero, which fails to free the first allocated skb at
index zero.

Check for >= 0 so that skb at index 0 is freed as well.

Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the commit title.
- Declare i as signed to avoid the endless loop.
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 210d84c67ef9..45e7833965b1 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -166,8 +166,8 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
 			     const unsigned int q_num, const unsigned int buf_cnt,
 			     const bool initial)
 {
-	unsigned int i, bat_cnt, bat_max_cnt, bat_start_idx;
-	int ret;
+	unsigned int bat_cnt, bat_max_cnt, bat_start_idx;
+	int ret, i;
 
 	if (!buf_cnt || buf_cnt > bat_req->bat_size_cnt)
 		return -EINVAL;
@@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
 	return 0;
 
 err_unmap_skbs:
-	while (--i > 0)
+	while (--i >= 0)
 		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
 
 	return ret;
-- 
2.34.1


