Return-Path: <netdev+bounces-126457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6C971355
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C31F22C82
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CB1B3B14;
	Mon,  9 Sep 2024 09:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205D1B375C;
	Mon,  9 Sep 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873658; cv=none; b=AieL/j4dJ7ua03qp5y73o7abV39qYpkWd4+cIiUJgP/P/iJCZPAmF4C/NFcaZUTONlZlYDbwjaZMPrs5LtAIPAo8mog4etvLf5ldBcDxCj54YDGfzJPsrDTOVu1ttyRkKEUSmsAMri+zxJv1xuIofg3x959gHyWOGvUlsMfFiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873658; c=relaxed/simple;
	bh=2zfASHFrciNzyPWs2bg0H0ZiGBMnkQxcJqjUQ4crK3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uaAGhuAiJwPA3iuuyH5vMcLQSmLM3o12iY3vsUG8sa2ZqhAzt9eg6qYmOKxPDcT6E93t6wcBynCo2GFyk8SHIMLLX3vajU112vYACak0LmI0kEd0kb67hdTSje6oOtHUmCVOiMX2Ew91MgrD5ROGREcMYNx7Ocnz8m3cay3AXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X2Lrj1vLYz1BNDl;
	Mon,  9 Sep 2024 17:19:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 283391402CF;
	Mon,  9 Sep 2024 17:20:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 17:20:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <vz@mleia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
	<alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] net: ethernet: nxp: Fix a possible memory leak in lpc_mii_probe()
Date: Mon, 9 Sep 2024 17:29:48 +0800
Message-ID: <20240909092948.1118381-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

of_phy_find_device() calls bus_find_device(), which calls get_device()
on the returned struct device * to increment the refcount. The current
implementation does not decrement the refcount, which causes memory leak.

So add the missing phy_device_free() call to decrement the
refcount via put_device() to balance the refcount.

Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/nxp/lpc_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index dd3e58a1319c..8bff394991e4 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -768,6 +768,9 @@ static int lpc_mii_probe(struct net_device *ndev)
 		return -ENODEV;
 	}
 
+	if (pldat->phy_node)
+		phy_device_free(phydev);
+
 	phydev = phy_connect(ndev, phydev_name(phydev),
 			     &lpc_handle_link_change,
 			     lpc_phy_interface_mode(&pldat->pdev->dev));
-- 
2.34.1


