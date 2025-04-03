Return-Path: <netdev+bounces-179052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBFA7A47D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3AD1899323
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201624EF91;
	Thu,  3 Apr 2025 13:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0C24EA95;
	Thu,  3 Apr 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688774; cv=none; b=MqQ2LA+S3Mjpz7PAcbbIF2nFAZ54TCs4pqHuQ++ue17hZtokC7PT6lKw0WdhhhwAIVyz7Mah9cWs4yPaAkaXqtZXPRuQ9gBeV09GW34P736pCR2+FtokLvz69FQnqLTYizvedp0vOW830ehZY574cR4TmB1OLUSwb1IPlohpdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688774; c=relaxed/simple;
	bh=0AwhIhi1ehpRwnp2Jb+rz2879Bk3+zJOAdOtlje8OBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0Vzn4FdFvHzT8MpdF6vwMi5zYcQGLp8cMp+ZWeGJPZRjL0Dcwy2ZjtbNqeCTEKJXwXsc3VHxEvkFa1mIdhd0pnU+y5iwnJ8+MGNSy9151pOzArE+L/asaFq6fZvXoRT9uOXfJy0DlUPdOc4wU81anxJ40d7SJro3Pugfo1/Epc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZT3Hg6KP1z13LPh;
	Thu,  3 Apr 2025 21:58:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 33276140383;
	Thu,  3 Apr 2025 21:59:29 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 21:59:28 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v2 6/7] net: hibmcge: fix not restore rx pause mac addr after reset issue
Date: Thu, 3 Apr 2025 21:53:10 +0800
Message-ID: <20250403135311.545633-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250403135311.545633-1-shaojijie@huawei.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In normal cases, the driver must ensure that the value
of rx pause mac addr is the same as the MAC address of
the network port. This ensures that the driver can
receive pause frames whose destination address is
the MAC address of the network port.

Currently, the rx pause addr does not restored after reset.

The index of the MAC address of the host is always 0.
Therefore, this patch sets rx pause addr to
the MAC address with index 0.

Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 4e8cb66f601c..a0bcfb5a713d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -26,12 +26,15 @@ static void hbg_restore_mac_table(struct hbg_priv *priv)
 
 static void hbg_restore_user_def_settings(struct hbg_priv *priv)
 {
+	/* The index of host mac is always 0. */
+	u64 rx_pause_addr = ether_addr_to_u64(priv->filter.mac_table[0].addr);
 	struct ethtool_pauseparam *pause_param = &priv->user_def.pause_param;
 
 	hbg_restore_mac_table(priv);
 	hbg_hw_set_mtu(priv, priv->netdev->mtu);
 	hbg_hw_set_pause_enable(priv, pause_param->tx_pause,
 				pause_param->rx_pause);
+	hbg_hw_set_rx_pause_mac_addr(priv, rx_pause_addr);
 }
 
 int hbg_rebuild(struct hbg_priv *priv)
-- 
2.33.0


