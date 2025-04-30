Return-Path: <netdev+bounces-187015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E47AA4769
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157C61C05CD3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7692376FD;
	Wed, 30 Apr 2025 09:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A523235050;
	Wed, 30 Apr 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005913; cv=none; b=FXmQs0sGFDeGwNVlvEkA03sARQNbwvK67SjYCl16/sUVg7ZzG5xAC6hKQOTOb57tlypsB7Hl5yJacRD+walJFUug6BVYCl5/OHdkmx8EmEIAbA125ACq8BS4mCBH4TwoZ65i1v+2NW7OI8oijqmTsTnv8SvW5aq/22AGlaP4McM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005913; c=relaxed/simple;
	bh=zf60cnGWJmyto7hJniS3i37W9CD8mvZyR+D1yMUdzGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik2sh5eNPFQaddtxJ8C7aJv2CpbyHmvEvQQd63XIN21hDWOi1jGZzliuFV9TBzYG5qRKf0TP10O9vUmMvCe69JWyXghyZHDfptoFfYS//HNzaTFZBbaP4QjOYh8Vj/dv1KDv6Jj7X0A6TqNRCffuIYxzU/R4uMAm/dh4xwQSwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZnXFY1MQ9z27hbP;
	Wed, 30 Apr 2025 17:39:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9899A1400DA;
	Wed, 30 Apr 2025 17:38:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 17:38:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 1/2] net: hibmcge: fix incorrect statistics update issue
Date: Wed, 30 Apr 2025 17:31:26 +0800
Message-ID: <20250430093127.2400813-2-shaojijie@huawei.com>
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

When the user dumps statistics, the hibmcge driver automatically
updates all statistics. If the driver is performing the reset operation,
the error data of 0xFFFFFFFF is updated.

Therefore, if the driver is resetting, the hbg_update_stats_by_info()
needs to return directly.

Fixes: c0bf9bf31e79 ("net: hibmcge: Add support for dump statistics")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 8f1107b85fbb..55520053270a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -317,6 +317,9 @@ static void hbg_update_stats_by_info(struct hbg_priv *priv,
 	const struct hbg_ethtool_stats *stats;
 	u32 i;
 
+	if (test_bit(HBG_NIC_STATE_RESETTING, &priv->state))
+		return;
+
 	for (i = 0; i < info_len; i++) {
 		stats = &info[i];
 		if (!stats->reg)
-- 
2.33.0


