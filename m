Return-Path: <netdev+bounces-211458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431DBB18E72
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B37517E3C1
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6508222FF22;
	Sat,  2 Aug 2025 12:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCB223DDF;
	Sat,  2 Aug 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138400; cv=none; b=XjfRe/hRHIYpaAUESnze9OdOQcBHs53oNaPmzep00qlVjhO4ncKvnO7rSMGFiiCF0Aiv4AmuWJNjYx6CzEeR7COPJlTXNU6SUqtzCSzb6rQKajLpGSA3Jx7wlidZ61w1XF6pUjUod8M5oNDys/NaTo4wfZ4x0J+wdsud2Fg/mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138400; c=relaxed/simple;
	bh=aBRqLh7e6J8eZ6mrUnRKX3siBTezwokCwCBIJemL6Dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhZIe8YZPdRR7nIQKdlJbtMUT1pYmFYOJePDi8AEShPf3RNSe6Tc49+IdCFTtgTS3z05EU5o7JYIS4z7dg7kEVSnsW7wraBtRqdE3a0k5ZmUYUXNLlXfozFavEZTVWqrjfoqMbzTcsLJAtkCCJZt8PjOZk2hE97mFq6hO8R/5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bvMl14ZFBz13MsM;
	Sat,  2 Aug 2025 20:36:45 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B72EB180485;
	Sat,  2 Aug 2025 20:39:55 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 2 Aug 2025 20:39:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 3/3] net: hibmcge: fix the np_link_fail error reporting issue
Date: Sat, 2 Aug 2025 20:32:26 +0800
Message-ID: <20250802123226.3386231-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250802123226.3386231-1-shaojijie@huawei.com>
References: <20250802123226.3386231-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Currently, after modifying device port mode, the np_link_ok state
is immediately checked. At this point, the device may not yet ready,
leading to the querying of an intermediate state.

This patch will poll to check if np_link is ok after
modifying device port mode, and only report np_link_fail upon timeout.

Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 8cca8316ba40..d0aa0661ecd4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -12,6 +12,8 @@
 
 #define HBG_HW_EVENT_WAIT_TIMEOUT_US	(2 * 1000 * 1000)
 #define HBG_HW_EVENT_WAIT_INTERVAL_US	(10 * 1000)
+#define HBG_MAC_LINK_WAIT_TIMEOUT_US	(500 * 1000)
+#define HBG_MAC_LINK_WAIT_INTERVAL_US	(5 * 1000)
 /* little endian or big endian.
  * ctrl means packet description, data means skb packet data
  */
@@ -228,6 +230,9 @@ void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr)
 
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
+	u32 link_status;
+	int ret;
+
 	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
 
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
@@ -239,8 +244,14 @@ void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
 
-	if (!hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
-				HBG_REG_AN_NEG_STATE_NP_LINK_OK_B))
+	/* wait MAC link up */
+	ret = readl_poll_timeout(priv->io_base + HBG_REG_AN_NEG_STATE_ADDR,
+				 link_status,
+				 FIELD_GET(HBG_REG_AN_NEG_STATE_NP_LINK_OK_B,
+					   link_status),
+				 HBG_MAC_LINK_WAIT_INTERVAL_US,
+				 HBG_MAC_LINK_WAIT_TIMEOUT_US);
+	if (ret)
 		hbg_np_link_fail_task_schedule(priv);
 }
 
-- 
2.33.0


