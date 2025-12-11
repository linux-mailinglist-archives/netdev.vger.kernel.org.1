Return-Path: <netdev+bounces-244318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43BCB4920
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A581C3043F65
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8792BE057;
	Thu, 11 Dec 2025 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PL6+6VDv";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PL6+6VDv"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D942BDC32;
	Thu, 11 Dec 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420751; cv=none; b=OujGof4Vrg3qevLjfqAdqTTJNjP9rWFQAfNWjBhJbZ1fC5ENOR8iehDmb9rliM172M9t0YYei9croKUpdHCUkvs5TAvSJIcd+ajvkYM4ibXcmjLTLEz5PPre6wGro1tyeF2gWrXeRxJdcq1s63hbD5aHoJKPWmK807rpw4MlVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420751; c=relaxed/simple;
	bh=haamQuVbfenYQko8OQnnHEaPL9CsrYxsGC/6C1fGNjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryoYLA8nGW3sjozWg6GPDV7LJA/dfbnjecCD2RQkieJzoSICLPPWHZr5JCoflNiVPRRMW1M2MlGZLy0voH73W84ZwpbA8N98hiZwJgh0mHET5n3IrJa/YZ67r0D98vcVjLcVThwj7OrOpoZtK1Aou7QS+gngG3KKygHNuHJ8G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PL6+6VDv; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PL6+6VDv; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qi+GBLgDCR2z7fRSZb2mOHHpdy1LRN+xvpB0CYTqqYU=;
	b=PL6+6VDvsB5b1oAObOP9o1gjMggHrVK9UtdXTi/u47sy1+GiecdEQrLV9M/IkOmtN80+8QH93
	zF/zadnqj0uFdh0Vh8CIeUNIXfHmK/OduXWisqyWaX4hoxoYdZJfnPC26Ve7bqZl4s3to6XlbeQ
	2hb+u90cGe2YVPpN/N8u5qI=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dRcGd48FMz1BG4v;
	Thu, 11 Dec 2025 10:38:49 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qi+GBLgDCR2z7fRSZb2mOHHpdy1LRN+xvpB0CYTqqYU=;
	b=PL6+6VDvsB5b1oAObOP9o1gjMggHrVK9UtdXTi/u47sy1+GiecdEQrLV9M/IkOmtN80+8QH93
	zF/zadnqj0uFdh0Vh8CIeUNIXfHmK/OduXWisqyWaX4hoxoYdZJfnPC26Ve7bqZl4s3to6XlbeQ
	2hb+u90cGe2YVPpN/N8u5qI=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dRcDY1hYyz1cyPb;
	Thu, 11 Dec 2025 10:37:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C426140143;
	Thu, 11 Dec 2025 10:38:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Dec 2025 10:38:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 2/3] net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
Date: Thu, 11 Dec 2025 10:37:36 +0800
Message-ID: <20251211023737.2327018-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251211023737.2327018-1-shaojijie@huawei.com>
References: <20251211023737.2327018-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Currently, rss_size = num_tqps / tc_num. If tc_num is 1, then num_tqps
equals rss_size. However, if the tc_num is greater than 1, then rss_size
will be less than num_tqps, causing the tqp_index check for subsequent TCs
using rss_size to always fail.

This patch uses the num_tqps to check whether tqp_index is out of range,
instead of rss_size.

Fixes: 326334aad024 ("net: hns3: add a check for tqp_index in hclge_get_ring_chain_from_mbx()")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index c7ff12a6c076..b7d4e06a55d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -193,10 +193,10 @@ static int hclge_get_ring_chain_from_mbx(
 		return -EINVAL;
 
 	for (i = 0; i < ring_num; i++) {
-		if (req->msg.param[i].tqp_index >= vport->nic.kinfo.rss_size) {
+		if (req->msg.param[i].tqp_index >= vport->nic.kinfo.num_tqps) {
 			dev_err(&hdev->pdev->dev, "tqp index(%u) is out of range(0-%u)\n",
 				req->msg.param[i].tqp_index,
-				vport->nic.kinfo.rss_size - 1U);
+				vport->nic.kinfo.num_tqps - 1U);
 			return -EINVAL;
 		}
 	}
-- 
2.33.0


