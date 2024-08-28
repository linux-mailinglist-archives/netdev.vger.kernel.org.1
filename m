Return-Path: <netdev+bounces-122748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6C9626B1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4561F23F1D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9F16D321;
	Wed, 28 Aug 2024 12:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03E166F36
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847339; cv=none; b=pW2xd6ardLiuY/g6kScTQalpW4XpLZRzDNFP8P9FAEX2bB747TTXQjzmlJjuZLSD84ahvnXgRYI6YGKYt//z8gI2/GdZYxjF47f9aJ36in2mVd3/h3KqOYrzP+SELmpmnchQYqZA81Y890AbahIsZ67Wiz9XuMJ6nU8bgU5U+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847339; c=relaxed/simple;
	bh=NAAPPhaJgjSrve0VgHpOE23wP4KyroMAUTkEgXOXexk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ty/iMZk2QMmgvw4vbvozJJNcd+VjuqVU6JgSy8K9hQeZH9eV2992warRcpe/ONhGVOUwrdHdESgs33NZzzEGhYT/2j3V5Dr89cnQNarkziog6TWEMd6tPk+SllRYDg+ELEk8XGPlnhHICB/+0rGVG9WasGmpz2yqgdcEhqQlGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wv3J64jh5zyQhm;
	Wed, 28 Aug 2024 20:14:46 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3642F18007C;
	Wed, 28 Aug 2024 20:15:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:15:34 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next] net: hns: Use IS_ERR_OR_NULL() helper function
Date: Wed, 28 Aug 2024 20:23:36 +0800
Message-ID: <20240828122336.3697176-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..53e0da0bfbed 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -734,7 +734,7 @@ hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
 		return -ENODATA;
 
 	phy = get_phy_device(mdio, addr, is_c45);
-	if (!phy || IS_ERR(phy))
+	if (IS_ERR_OR_NULL(phy))
 		return -EIO;
 
 	phy->irq = mdio->irq[addr];
-- 
2.34.1


