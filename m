Return-Path: <netdev+bounces-134538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B799A063
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E1BB23286
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4F20C47B;
	Fri, 11 Oct 2024 09:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23020FAA2;
	Fri, 11 Oct 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640314; cv=none; b=dZyTPIyJFGTAi/UwDe7SESvtoqF2ZfflkvvkeEd+OM4wVeIXAhVomxh7nTjW++sZsedoFM+fzFBiCD+HVeRPCKPTMNYgTDKnooZljmPq4jiVzahTUSQNVS3rzl9FfM6bDIT1KtBnX7HuyhnVOGFa5n+icua2A9OYn+Ohtrav54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640314; c=relaxed/simple;
	bh=KcCR2hzH0Uq0xUZD3RpWJkr7AgTcbWt+Z3Nw0lA76V8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlCl7FCvVTuVFt6SlqpNeSQZ/YA7GtuSsRmIekCXPQX5o8y8OTZuIYvxW5wdfAeyYkPQBfAul/tMHubfVeg+wDUYVXzsSvI7zo4DDuyjV/UUf07BsSE9U//PCBHYGuGNdkIe6w/iXqZveX23ouvKPv6koOnB5uGPNpKLGTCz1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XQ21Z0xVNz1SBS6;
	Fri, 11 Oct 2024 17:50:42 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7639C180041;
	Fri, 11 Oct 2024 17:51:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 17:51:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 7/9] net: hns3: initialize reset_timer before hclgevf_misc_irq_init()
Date: Fri, 11 Oct 2024 17:45:19 +0800
Message-ID: <20241011094521.3008298-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241011094521.3008298-1-shaojijie@huawei.com>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Currently the misc irq is initialized before reset_timer setup. But
it will access the reset_timer in the irq handler. So initialize
the reset_timer earlier.

Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ab54e6155e93..896f1eb172d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2315,6 +2315,7 @@ static void hclgevf_state_init(struct hclgevf_dev *hdev)
 	clear_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state);
 
 	INIT_DELAYED_WORK(&hdev->service_task, hclgevf_service_task);
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	mutex_init(&hdev->mbx_resp.mbx_mutex);
 	sema_init(&hdev->reset_sem, 1);
@@ -3014,7 +3015,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
-	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
-- 
2.33.0


