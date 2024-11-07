Return-Path: <netdev+bounces-142857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCD9C07A7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883B8282500
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258202101A6;
	Thu,  7 Nov 2024 13:37:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6F1EF0A2;
	Thu,  7 Nov 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986627; cv=none; b=o7U7HzzLLlx2ZKyEpGetdzTqvoMt+UOIGUVrM+fPJVKCrFNGL9omCWI8nmJEIURxZQuQ2bc0MQ8UrtPBKMO8N3G1cJx5d2fzRuIG+kMSkHNK/KsDRWobeKBztvUcte5oSvDTXF2OLg7koGKUR4uCtZFfmdhMA65zVlQ5fXR/yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986627; c=relaxed/simple;
	bh=jMllCpTV1qMjUdYu5oHkxd912cLB1dQrnLA6scHSn5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYfLEAe/Q+5RFQdXk68nu9d6UhGPbWj2UO9gVIrMHwi6x5MBK9ZQA2oi81lv5HIuCuRRg1YMWhMZ1egzEwbd78R4a+ZkHAZt3uyUYo1o41CdFbXsvwOIWDlxMkhjlFj+pem4ENIMk1WbkjBZSTuoTSGAUGpzQytk2oQ+TViramw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XkjjW6NGfz10PlN;
	Thu,  7 Nov 2024 21:34:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 97603180AEA;
	Thu,  7 Nov 2024 21:37:01 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 21:37:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net 2/7] net: hns3: fix missing features due to dev->features configuration too early
Date: Thu, 7 Nov 2024 21:30:18 +0800
Message-ID: <20241107133023.3813095-3-shaojijie@huawei.com>
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

Currently, the netdev->features is configured in hns3_nic_set_features.
As a result, __netdev_update_features considers that there is no feature
difference, and the procedures of the real features are missing.

Fixes: 2a7556bb2b73 ("net: hns3: implement ndo_features_check ops for hns3 driver")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4cbc4d069a1f..73825b6bd485 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2452,7 +2452,6 @@ static int hns3_nic_set_features(struct net_device *netdev,
 			return ret;
 	}
 
-	netdev->features = features;
 	return 0;
 }
 
-- 
2.33.0


