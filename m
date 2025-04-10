Return-Path: <netdev+bounces-181013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C873A83658
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D119E889E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A731E51F1;
	Thu, 10 Apr 2025 02:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB231E2845;
	Thu, 10 Apr 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251608; cv=none; b=POcs35pJDVI1+QRLaDwIiFONAlC6yw53NCNS3UZ5DNrl0m3Ke9RW58AINDt07yw9hipxRHl00rHInlWtAmbCTdpSNcYFK47ww7O5QzJYD1vTMf+40XCLwMni7qlrs9Qi9Hjl0VpWx4ayV0SAQQqDfE0bWEZyDzm5dEzNS6j3bxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251608; c=relaxed/simple;
	bh=mkEBsARjksLeX2+g3bv48+qM7C1Y3MYbhEFBfLSPeGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwbUUWWMdHGuoAulcSwi1WH3fbEhlCEIlu0pXH0HbpChEsJ/ysLCBWLiyG9kWXVagUiMRqEay93B8v1WRd3NYyMXDxgji1yoPw22X4p+1sWUwCN9cJ09WeD6cNGcPK+RPQRNzRBkmaG9q9IdKhF8TvyH4f2QZOMBLRjxXEIrpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZY3N56rXlzHrRv;
	Thu, 10 Apr 2025 10:16:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A06831401E0;
	Thu, 10 Apr 2025 10:20:01 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 10:20:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v3 6/7] net: hibmcge: fix not restore rx pause mac addr after reset issue
Date: Thu, 10 Apr 2025 10:13:26 +0800
Message-ID: <20250410021327.590362-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250410021327.590362-1-shaojijie@huawei.com>
References: <20250410021327.590362-1-shaojijie@huawei.com>
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

The MAC hardware supports receiving two types of
pause frames from link partner.
One is a pause frame with a destination address
of 01:80:C2:00:00:01.
The other is a pause frame whose destination address
is the address of the hibmcge driver.

01:80:C2:00:00:01 is supported by default.

In .ndo_set_mac_address(), the hibmcge driver calls
.hbg_hw_set_rx_pause_mac_addr() to set its mac address as the
destination address of the rx puase frame.
Therefore, pause frames with two types of MAC addresses can be received.

Currently, the rx pause addr does not restored after reset.
As a result, pause frames whose destination address is
the hibmcge driver address cannot be correctly received.

This patch restores the configuration by calling
.hbg_hw_set_rx_pause_mac_addr() after reset is complete.

Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v2 -> v3:
  - Add more details in commit log, suggested by Jakub.
  v2: https://lore.kernel.org/all/20250403135311.545633-7-shaojijie@huawei.com/
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


