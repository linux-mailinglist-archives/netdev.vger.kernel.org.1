Return-Path: <netdev+bounces-136937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE429A3B43
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ACF1F24EDC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3560204033;
	Fri, 18 Oct 2024 10:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961862036F6;
	Fri, 18 Oct 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246653; cv=none; b=QfEHglM7cBkLoIeThs8Gf0BHJ7rDJEkdwlnPuJXn9O/GQRBUjWZWB2/YUwdUgtLh3ujqkQEaQ54DvJoftuBD2rc4UxEEmMhJ/kGQvHAhNTOervsWrDWPLBLf9W7tVBGMj3mI7MO2uYPpzxK0AubfR9IdBYdpOvVOTFVi5KVumF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246653; c=relaxed/simple;
	bh=rDii2SmUfHZSedVWxQAoqFqlT2Nfi1duerE1AAZ9FM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUCTs5ejAR/tH8c5kE6dSfze09RC3KMQ6MeYGgORrwOfE+Agx9yZeRWY6VvzQRwvCJEqTizHy1qUX662gel1JAdL8vxF3wuBK8B5NW49b82pJxRAb32dJ7yMvE1cg13XXYa0yyPVexOiZbPdyO/8MdjBCLMQ8ntTD9TAcJ3m4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XVLHL1Ndjz1ymyH;
	Fri, 18 Oct 2024 18:17:34 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E3A9614022D;
	Fri, 18 Oct 2024 18:17:27 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 4/9] net: hns3: fix missing features due to dev->features configuration too early
Date: Fri, 18 Oct 2024 18:10:54 +0800
Message-ID: <20241018101059.1718375-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018101059.1718375-1-shaojijie@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

From: Hao Lan <lanhao@huawei.com>

Currently, the netdev->features is configured in hns3_nic_set_features.
As a result, __netdev_update_features considers that there is no feature
difference, and the procedures of the real features are missing.

Fixes: 2a7556bb2b73 ("net: hns3: implement ndo_features_check ops for hns3 driver")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8760b4e9ade6..b09f0cca34dc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2483,7 +2483,6 @@ static int hns3_nic_set_features(struct net_device *netdev,
 			return ret;
 	}
 
-	netdev->features = features;
 	return 0;
 }
 
-- 
2.33.0


