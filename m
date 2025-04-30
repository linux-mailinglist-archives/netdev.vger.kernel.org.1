Return-Path: <netdev+bounces-187014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31AFAA4767
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D366A9A13C9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1823507C;
	Wed, 30 Apr 2025 09:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AE235055;
	Wed, 30 Apr 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005912; cv=none; b=Ue9uYRDYVcCu/1TLz03VrcWBJuWcWILXodJAIRM5WqFrIr73C6nwnWrDWXmEj8y36Jx0ubGcOIXpA/qwUMZX5djQNdXabVTKYxrgKuTEHo591i3ZVL57J8nvba52MtSI+KqERO5PBiwLiaCNTigmYzhmFjV57aiZrFurdYIAPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005912; c=relaxed/simple;
	bh=j9Rn5hX6mv7spf3KVf2Y3X9LbA0hK8RNFXlA259jL6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjyke7HTF8b3Djja4t2Q8e1AkFVeEbPYdzvtQspSQHaLt7JyGrDFPZQESKLBdYWoKNXXbncUmoHqZsrrIX1wMmwdYRWjsGRaCnNgEd01xl0VLpF2oyQ8NTfzqGZ+FSuiwoA8MzXnmdIB/u8dGGk3N5N/Sgne2RyvYACUIyE6oX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZnXCP0tDlz13L8J;
	Wed, 30 Apr 2025 17:37:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C04F1401F4;
	Wed, 30 Apr 2025 17:38:29 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 17:38:28 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/2] net: hibmcge: fix wrong ndo.open() after reset fail issue.
Date: Wed, 30 Apr 2025 17:31:27 +0800
Message-ID: <20250430093127.2400813-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250430093127.2400813-1-shaojijie@huawei.com>
References: <20250430093127.2400813-1-shaojijie@huawei.com>
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

If the driver reset fails, it may not work properly.
Therefore, the ndo.open() operation should be rejected.

In this patch, if a reset failure is detected in ndo.open(),
return directly.

Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 2e64dc1ab355..6c98f906bf0d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -35,6 +35,9 @@ static int hbg_net_open(struct net_device *netdev)
 	struct hbg_priv *priv = netdev_priv(netdev);
 	int ret;
 
+	if (test_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state))
+		return -EBUSY;
+
 	ret = hbg_txrx_init(priv);
 	if (ret)
 		return ret;
-- 
2.33.0


