Return-Path: <netdev+bounces-134537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CE99A061
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851A3B22DF4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD72101AD;
	Fri, 11 Oct 2024 09:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832E20B1F3;
	Fri, 11 Oct 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640313; cv=none; b=GNTl3yeBAz6cnLahPyHSiDLOq5Cf/aLzufKSi9SiIsxT0Ouv2CniYRKIMfqESjqg7aonv2BMGSb7eFUu4S+uKTA+nbLCdNaJzupQPPgs+9z4f3I8686Nn55G/0GVwdH02DXzrTl9YSQMfJW1QlG0uTdb+LdswHUo5xia0m8REMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640313; c=relaxed/simple;
	bh=vAVE7LtdTqlUBO9yQ2hPuz/qtZ4cIlGmCNa5nYPv0FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkfsk6c2ZjkpiEQi7ttaFhP5PegFsJcfO2EGF9URBz+KpWCV/GiA6dpOFHRQJwSnd2V2PKDyfWLE2C+R9wlrIha2utP5iLVTB3O7EUEHab3/Oc5Jcx4mmiScZAk6uwJs+mHhF+QO+LgL51ks9oNy3+f4rPnZ0dj7j3twiWVmhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XQ21Y3Qnjz1j9Z1;
	Fri, 11 Oct 2024 17:50:41 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 10B4F1A016C;
	Fri, 11 Oct 2024 17:51:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 17:51:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 4/9] net: hns3: fix missing features due to dev->features configuration too early
Date: Fri, 11 Oct 2024 17:45:16 +0800
Message-ID: <20241011094521.3008298-5-shaojijie@huawei.com>
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

From: Hao Lan <lanhao@huawei.com>

Currently, the netdev->features is configured in hns3_nic_set_features.
As a result, __netdev_update_features considers that there is no feature
difference, and the procedures of the real features are missing.

Fixes: 2a7556bb2b73 ("net: hns3: implement ndo_features_check ops for hns3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Hao Lan <lanhao@huawei.com>
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


