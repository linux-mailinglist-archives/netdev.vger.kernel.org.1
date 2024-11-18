Return-Path: <netdev+bounces-145859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C089D12DD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E341F22E9D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82191BD01F;
	Mon, 18 Nov 2024 14:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5661AF0A5;
	Mon, 18 Nov 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939640; cv=none; b=TZB/oVfZ6oRSq4VhEy3lrRyUvCBkd3y4KJdWj0YfnKSNxxF9iaN0up5r67+69rbMt20iNJsrGd+6Wl8DCL68+eUPpq3nIGDwCy/I5IXXWGlvxvsxt2Hghar3hrE/djRFmQIEAsR8nkRbZK3XnpR1N0oCEo/AEzMcjHTVK3qhcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939640; c=relaxed/simple;
	bh=FUDxglx01sRgab9GHliuU2m1EoSE1igfBs/5yoKEftc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd3OlpK/H62mHDWUsyAT5h9P8puUp20r+6TulG8kh4+GkFtw5kHNdTqcphr9fUz1Wz9tURb2E9WP6l7j6iKqUSDdv8aVa0ju+6QCg8SlaUd+x2kHqPzG/WbyWp+qEN6ydkSwz0JAbestsY7U0EYV1qU/4Ibbu7A/r+tyrGH3MW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XsV8S28zNz1V4dV;
	Mon, 18 Nov 2024 22:18:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 24454180064;
	Mon, 18 Nov 2024 22:20:36 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 22:20:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V4 net-next 7/7] net: hibmcge: Add nway_reset supported in this module
Date: Mon, 18 Nov 2024 22:13:39 +0800
Message-ID: <20241118141339.3224263-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241118141339.3224263-1-shaojijie@huawei.com>
References: <20241118141339.3224263-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Add nway_reset supported in this module

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index e27f835a3230..9ff08154908d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -186,6 +186,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_pauseparam         = hbg_ethtool_get_pauseparam,
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 	.reset			= hbg_ethtool_reset,
+	.nway_reset		= phy_ethtool_nway_reset,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
-- 
2.33.0


