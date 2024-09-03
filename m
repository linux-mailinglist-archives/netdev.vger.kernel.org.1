Return-Path: <netdev+bounces-124418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFE9695C4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71220284A95
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671431DAC77;
	Tue,  3 Sep 2024 07:36:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A51DAC73
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349000; cv=none; b=iSsQZC0YqW3qgkL2ghGZOQIO/5JmEMyzEFheuedDMGCrmD58mStyhmDf0hwv2kg2Mu24BhZYuWLiDTWKWG0IfVRZWwfUhhLaA+1IO0ruFC2InAwTkomn0abC69GBAQUeRubvBFh54K5XIJ/ZVouJ/QogOpqYOaxviAQdTauwLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349000; c=relaxed/simple;
	bh=CeFVL3LutuDgYTo5rol5GOraF1JaV3X49wDtMzrz5sA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lHZ9yKCVF13vVXy4C937nCT8txS2bBJ3bPCT25K06SW5uBhreqTarGyJX1GufMcD/c0i92GkfKwtslvMIV9yzMi+CogPgqCtLmJBR/MOl0xJi+4JFgr2kt1gaIO5U6sGPzQrwYhkU21regrl8VkwPfd7g4jlA4MdYm/S9CRX+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WycmL31Blz1HJ0k;
	Tue,  3 Sep 2024 15:33:06 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id A27D414011F;
	Tue,  3 Sep 2024 15:36:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 15:36:31 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
	<avem@davemloft.net>, <netdev@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH net-next] net: txgbe: Simplify code with pci_dev_id()
Date: Tue, 3 Sep 2024 15:23:01 +0800
Message-ID: <20240903072301.117767-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use pci_dev_id() to get the BDF number of a pci device, and we don't
calculate it manually. This can simplify the code a bit.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5f502265f0a6..e8e293b1dd61 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -689,7 +689,7 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 	mii_bus->phy_mask = GENMASK(31, 1);
 	mii_bus->priv = wx;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe-%x",
-		 (pdev->bus->number << 8) | pdev->devfn);
+		 pci_dev_id(pdev));
 
 	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
 	if (ret) {
-- 
2.17.1


