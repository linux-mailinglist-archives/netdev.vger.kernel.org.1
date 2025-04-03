Return-Path: <netdev+bounces-179057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4ECA7A488
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FD03B53A2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B493250C11;
	Thu,  3 Apr 2025 13:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7C2505B7;
	Thu,  3 Apr 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688778; cv=none; b=UVWyUXCSu/qPQbBX7+CNWqK5gqIyZSKU8Imqgf4GOwIIqT/UI6plp8K5Gx096szlKjmXn4aPSvLXeBMQ2Q+afqDZ1d6Q4FEfg0Uniy6VJQXoNnTEEBKy0No+FQvH4KjYIOYcIcqI6AJ0xD2MYmykhtLRPwzj7ySEB/VnzsuxvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688778; c=relaxed/simple;
	bh=oBEAqFWDdWO3OY9KeCPxwBkQnxRnPSDppcWNl3NRi3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUaekZNXYtn81Ckhk20S2yTrMokzJhVizsA2pWVEtCcLdB1SsFQKwxrw9MDcDp1FzFMj2VvI/PWL5FTVONK6tp/UTTWS1fFeBYFd5ySP5tkpCj6FiCpqCz86xQz+hGmD43/6ynj6xpTii8vt2iGr116zuJkF/BFyEsja/RSORIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZT3DR5Dk3zHrKQ;
	Thu,  3 Apr 2025 21:56:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CBDC180087;
	Thu,  3 Apr 2025 21:59:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 21:59:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v2 5/7] net: hibmcge: fix the incorrect np_link fail state issue.
Date: Thu, 3 Apr 2025 21:53:09 +0800
Message-ID: <20250403135311.545633-6-shaojijie@huawei.com>
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

In the debugfs file, the driver displays the np_link fail state
based on the HBG_NIC_STATE_NP_LINK_FAIL.

However, HBG_NIC_STATE_NP_LINK_FAIL is cleared in hbg_service_task()
So, this value of np_link fail is always false.

This patch directly reads the related register to display the real state.

Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 9c09e4835990..01ad82d2f5cc 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -106,6 +106,7 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 {
 	struct net_device *netdev = dev_get_drvdata(s->private);
 	struct hbg_priv *priv = netdev_priv(netdev);
+	bool np_link_fail;
 
 	seq_printf(s, "event handling state: %s\n",
 		   state_str_true_false(priv, HBG_NIC_STATE_EVENT_HANDLING));
@@ -117,8 +118,10 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 		   reset_type_str[priv->reset_type]);
 	seq_printf(s, "need reset state: %s\n",
 		   state_str_true_false(priv, HBG_NIC_STATE_NEED_RESET));
-	seq_printf(s, "np_link fail state: %s\n",
-		   state_str_true_false(priv, HBG_NIC_STATE_NP_LINK_FAIL));
+
+	np_link_fail = !hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
+					   HBG_REG_AN_NEG_STATE_NP_LINK_OK_B);
+	seq_printf(s, "np_link fail state: %s\n", str_true_false(np_link_fail));
 
 	return 0;
 }
-- 
2.33.0


