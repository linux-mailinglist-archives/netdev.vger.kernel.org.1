Return-Path: <netdev+bounces-200902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B25AE749B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C99C16E03B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C01922D3;
	Wed, 25 Jun 2025 02:04:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84A15278E;
	Wed, 25 Jun 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817095; cv=none; b=fUQY+c7SmjWLwz4NySetcFXR66+0jyxoDB25HwoYobhpoLbWKpLT5MwV6NLQbbB6rANaHauTzeo+kT/abqww+0XqvUdzQqtS+jUPOtXkpcnQj226U9E6zAbc3XOWFVba889KKgfvqp+GHhQRfD84vo7rA9Lt85mpemNBcpJs1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817095; c=relaxed/simple;
	bh=culdkqbFYK9shNmCfgB7f/uFr+cX5HWHD5oZkjIM+iM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ui3RPh7tpbd0HextaZucbKOIKrsZfSnPwuFG7cGNZ1hz/6MzOZIqVnNoU8knHYCfpxq7Eeccz/mKaplDf59OoSecv6C76OuiuzI8CPwajjPTzGidMkrkNJ7f9+oiG7N93Y4jhiq0XZA1EhPZuIZ2DiA4/OjWjKbN0A4ZV77ziV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bRlSj5cBBz1d1lV;
	Wed, 25 Jun 2025 10:02:29 +0800 (CST)
Received: from kwepemk100010.china.huawei.com (unknown [7.202.194.58])
	by mail.maildlp.com (Postfix) with ESMTPS id D33C51402EB;
	Wed, 25 Jun 2025 10:04:49 +0800 (CST)
Received: from workspace-z00536909-5022804397323726849.huawei.com
 (7.151.123.135) by kwepemk100010.china.huawei.com (7.202.194.58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 10:04:48 +0800
From: zhangjianrong <zhangjianrong5@huawei.com>
To: <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <guhengsheng@hisilicon.com>, <caiyadong@huawei.com>,
	<xuetao09@huawei.com>, <lixinghang1@huawei.com>
Subject: [PATCH] [net] net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
Date: Wed, 25 Jun 2025 10:04:48 +0800
Message-ID: <20250625020448.1407142-1-zhangjianrong5@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100010.china.huawei.com (7.202.194.58)

According to the description of tb_xdomain_enable_paths(), the third
parameter represents the transmit ring and the fifth parameter represents
the receive ring. tb_xdomain_disable_paths() is the same case.

Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
---
 drivers/net/thunderbolt/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0a53ec293d04..f4c782759566 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -396,9 +396,9 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
 
 		ret = tb_xdomain_disable_paths(net->xd,
 					       net->local_transmit_path,
-					       net->rx_ring.ring->hop,
+					       net->tx_ring.ring->hop,
 					       net->remote_transmit_path,
-					       net->tx_ring.ring->hop);
+					       net->rx_ring.ring->hop);
 		if (ret)
 			netdev_warn(net->dev, "failed to disable DMA paths\n");
 
@@ -662,9 +662,9 @@ static void tbnet_connected_work(struct work_struct *work)
 		goto err_free_rx_buffers;
 
 	ret = tb_xdomain_enable_paths(net->xd, net->local_transmit_path,
-				      net->rx_ring.ring->hop,
+				      net->tx_ring.ring->hop,
 				      net->remote_transmit_path,
-				      net->tx_ring.ring->hop);
+				      net->rx_ring.ring->hop);
 	if (ret) {
 		netdev_err(net->dev, "failed to enable DMA paths\n");
 		goto err_free_tx_buffers;
-- 
2.34.1


