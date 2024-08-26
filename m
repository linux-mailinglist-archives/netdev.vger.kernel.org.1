Return-Path: <netdev+bounces-121753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571795E63F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92851C2093B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9FD184E;
	Mon, 26 Aug 2024 01:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80607F9
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635471; cv=none; b=qbnZ53zSk1dyOjwF/CuqPP8otB6ALv0lvbvu+T+5q+dl1YlpnZ+Hr7MWvt9Pedhw06HeFxsuFtHlEY0Vz/6PwEt4PZsEwFGqEON8R1++RYfQQ6DflTeugH0Bj+QK8sA+cIHgO1dEsMvFlNx9UL6PgmF+JUkK4492BIoaU/QOyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635471; c=relaxed/simple;
	bh=dx7MCdWwBjb6iQNmVwWw0CMaPLZjvM+ynH4U1GuLqtY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qmCUz57PTNkcLn6YIw5FEanHo2UDrWqEy0YgGgTToCijxG7DUgxJrLd6BUc7dbI6KiK9PM/cxyyktxpT+khBMzpjiyHXW1qkIjlK05/aodxaTo93BeK7cwAMFB4xFdttSyNCGwrwnMx2YKdq99aJDPskMHP1vyTz/trcoxC1tXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WsXs61Qfbz69HH;
	Mon, 26 Aug 2024 09:19:38 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A6351800F2;
	Mon, 26 Aug 2024 09:24:25 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 09:24:25 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH -next] net: txgbe: use pci_dev_id() helper
Date: Mon, 26 Aug 2024 09:21:00 +0800
Message-ID: <20240826012100.3975175-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)

PCI core API pci_dev_id() can be used to get the BDF number for a PCI
device. We don't need to compose it manually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5f502265f0a6..67b61afdde96 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -688,8 +688,7 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 	mii_bus->parent = &pdev->dev;
 	mii_bus->phy_mask = GENMASK(31, 1);
 	mii_bus->priv = wx;
-	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe-%x",
-		 (pdev->bus->number << 8) | pdev->devfn);
+	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe-%x", pci_dev_id(pdev));
 
 	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
 	if (ret) {
-- 
2.33.0


