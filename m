Return-Path: <netdev+bounces-149688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71EA9E6D4E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E1284330
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3082010E6;
	Fri,  6 Dec 2024 11:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE1200B90;
	Fri,  6 Dec 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484223; cv=none; b=JPAktOgoovB/4Ie5jHHlGd8ZV7HnwWzG86zrwPgdbFX7cq0AG4DcRm2AfchusM+5yxqEIhxsWTy57MXBE+2NqzqW1HpG8vauHQSnUovxKSvxr1SRpngXXUWdJGGbmKaCRWuw42kbcGaFodgCjGk/+byhPt58pngxNKdLiu+KJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484223; c=relaxed/simple;
	bh=pmazI+7YnrOqKRvtT86NkSg2xxq6Zhw/c0X1cpwdhk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onBjxNL62nxNz3sXPpOZZYWsjqzuobP1eHLA/GqQWnfkbZJ3z/GxPDYRff7Br7hMTG1bQbrHrfMS+R3TGSeKG/St1OlbptPyIvALy1qbuuyGNYe7Wt/0HYQtc18Djt1qUwxwRnMlelLh8odgemDA2uvOmbjTBmB/697QscfOX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4TNH1K4kz1kvX0;
	Fri,  6 Dec 2024 19:21:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C178140136;
	Fri,  6 Dec 2024 19:23:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 19:23:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V5 net-next 8/8] net: hibmcge: Add nway_reset supported in this module
Date: Fri, 6 Dec 2024 19:16:29 +0800
Message-ID: <20241206111629.3521865-9-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241206111629.3521865-1-shaojijie@huawei.com>
References: <20241206111629.3521865-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Add nway_reset supported in this module

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index c4de75892c99..4cecca7d446a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -195,6 +195,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_pauseparam         = hbg_ethtool_get_pauseparam,
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 	.reset			= hbg_ethtool_reset,
+	.nway_reset		= phy_ethtool_nway_reset,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
-- 
2.33.0


