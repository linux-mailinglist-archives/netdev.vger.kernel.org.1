Return-Path: <netdev+bounces-244133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE82CB0179
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 14:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 488E030F7028
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28A32F74A;
	Tue,  9 Dec 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ydukaw4h"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18E32ED53;
	Tue,  9 Dec 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287584; cv=none; b=RBbPWWD8l90E4LgN5bgDBS/zvFVDumqf9wZ44Cd4sI2UM7UtiL1ddFrXAlxfGHnZOHhQQnQCXU6LTt03/GA8W0gbi+mecB1SBKaocyT2SGs8tfl3KTbBkq//A/tC7Mf/fnkvO2q1TuVIBwHUKzk07VuA5JhxguWtCYYf/GbYje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287584; c=relaxed/simple;
	bh=uKk1q6G1xxRI9lFlI+KlF1jeF5aDlqgEu6wI+JD3sEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUIll6z8nvShRQiQDBG7zMS6Spi/Jmr84kgRHGxb6HZWB7jMA/2V0KxW5N561GKHwb3KGVFwbKN53wTS4/aVWVeEwo1xkQ66BdCKjANhikLGWskt8l3cOjjMgoAWwJ8x+8wWygcA13ZtSnky/CyJqCseCxSzpi0yeJfPndTQ73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ydukaw4h; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=d0ZH9JZE6cJljODPXPOZp/NH7WwBbc8dYLkopeTIbxc=;
	b=ydukaw4hQc5rb8bXmrJAiElvWqoYnS1F/jgK82/b2DVnkI2fipYC4NQPuWcv0XGIncQrYACa/
	L+6mQDtmmI0TK02z2Pwf2SgGbogStXFG6v4ntUBUZjVtx8eOcqyNoE21+29Rnkt32BimcsJVvSX
	4v32BCMkmujnMnYyuucTIwQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dQfzH1q47z12LKY;
	Tue,  9 Dec 2025 21:37:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 744DE140156;
	Tue,  9 Dec 2025 21:39:33 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 21:39:32 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 1/3] net: hns3: using the num_tqps in the vf driver to apply for resources
Date: Tue, 9 Dec 2025 21:38:23 +0800
Message-ID: <20251209133825.3577343-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251209133825.3577343-1-shaojijie@huawei.com>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Currently, hdev->htqp is allocated using hdev->num_tqps, and kinfo->tqp
is allocated using kinfo->num_tqps. However, kinfo->num_tqps is set to
min(new_tqps, hdev->num_tqps);  Therefore, kinfo->num_tqps may be smaller
than hdev->num_tqps, which causes some hdev->htqp[i] to remain
uninitialized in hclgevf_knic_setup().

Thus, this patch allocates hdev->htqp and kinfo->tqp using hdev->num_tqps,
ensuring that the lengths of hdev->htqp and kinfo->tqp are consistent
and that all elements are properly initialized.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8fcf220a120d..70327a73dee3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -368,12 +368,12 @@ static int hclgevf_knic_setup(struct hclgevf_dev *hdev)
 	new_tqps = kinfo->rss_size * num_tc;
 	kinfo->num_tqps = min(new_tqps, hdev->num_tqps);
 
-	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
+	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, hdev->num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
 		return -ENOMEM;
 
-	for (i = 0; i < kinfo->num_tqps; i++) {
+	for (i = 0; i < hdev->num_tqps; i++) {
 		hdev->htqp[i].q.handle = &hdev->nic;
 		hdev->htqp[i].q.tqp_index = i;
 		kinfo->tqp[i] = &hdev->htqp[i].q;
-- 
2.33.0


