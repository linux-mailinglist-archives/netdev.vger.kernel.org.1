Return-Path: <netdev+bounces-94129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58BA8BE4A8
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EB528A3B1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369415ECC5;
	Tue,  7 May 2024 13:49:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0115B128;
	Tue,  7 May 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089795; cv=none; b=GCeCMaPvLz+rYkhBY8a3MCFkslmKRBlrzuVsyE6a67WiNSG8k2ECKNyBAWaj7lsaLDq77z5NvPVWXHEtKRBp7cmgG0THWpwqz8l1Yhnew6u2gGam9qE7JjDVlu/ttHEliT4p+Tj6JdmUG1ll7bQqxJxo9n3mnw2AhpIQTQ6p3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089795; c=relaxed/simple;
	bh=Er8lywoBRvvPKkaPq7no//gWKCJG4PMOTUPvGkQyG9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryYIzlkL5GLsnZXRJD+oiAWrjjBM7QpOBjjlRwFq499COsQKdeczlNRDwWxezgyonHj8srKlFsBPRLs3gQzMWL5Uv6rWnmzMZ5OYMoQMOAcEXaYGWdraP+/ELCJnEb4JYQWQxn/qhIIQxF5Jr20SxXEkoEc33X5k1Q6PsRJxTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYfh23PX6ztT3Y;
	Tue,  7 May 2024 21:46:26 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B80E180065;
	Tue,  7 May 2024 21:49:51 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 4/7] net: hns3: release PTP resources if pf initialization failed
Date: Tue, 7 May 2024 21:42:21 +0800
Message-ID: <20240507134224.2646246-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240507134224.2646246-1-shaojijie@huawei.com>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Peiyang Wang <wangpeiyang1@huawei.com>

During the PF initialization process, hclge_update_port_info may return an
error code for some reason. At this point,  the ptp initialization has been
completed. To void memory leaks, the resources that are applied by ptp
should be released. Therefore, when hclge_update_port_info returns an error
code, hclge_ptp_uninit is called to release the corresponding resources.

Fixes: eaf83ae59e18 ("net: hns3: add querying fec ability from firmware")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ecff9b426527..1d255b3ae988 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11764,7 +11764,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	ret = hclge_update_port_info(hdev);
 	if (ret)
-		goto err_mdiobus_unreg;
+		goto err_ptp_uninit;
 
 	INIT_KFIFO(hdev->mac_tnl_log);
 
@@ -11815,6 +11815,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	devl_unlock(hdev->devlink);
 	return 0;
 
+err_ptp_uninit:
+	hclge_ptp_uninit(hdev);
 err_mdiobus_unreg:
 	if (hdev->hw.mac.phydev)
 		mdiobus_unregister(hdev->hw.mac.mdio_bus);
-- 
2.30.0


