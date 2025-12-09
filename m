Return-Path: <netdev+bounces-244130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD0CB0170
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 14:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5722E30E1FC3
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32632E6AA;
	Tue,  9 Dec 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y0cjGTio"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B1320A3B;
	Tue,  9 Dec 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287578; cv=none; b=Y04OVq2yVVNdeJcYFz5vrkXp2eapSWhHUmpZfOhYO8jZaTvmSF7Coo576D1gwXuESyM64WAVnpb51apcfNUZYp/57FNikP57PU7/mbOmHwgU4oXdAX8a2BBaEgbwTP0YFi/8tDcWYvFC0pkZxOo5E7U8f40DcXI/tWQqgyctAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287578; c=relaxed/simple;
	bh=VB8+cxSqfMtpQil+MMBj+qqbZ0Icly7VPQpiKSY7rVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvE9dJXkgetaMzWFg2XHFKgwjYYoE7iNSmODePVh8uOOkwytCocCQuP5d6oomiLueNkfHy6pYTnUQthgx3RifZaYNgEAjZLcaAgvk2NaOO8Wxk9edtrlKIuU5AaNJ9aed8+gk2dicHSJyM/G/y8OISGpdg9AYxDLoH1Q/1DoD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y0cjGTio; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MdH3++3W4bys0UrCphvQHTDq/H/Rp7gzPD0YSU9c3aU=;
	b=Y0cjGTio/6hEb24YhPZ0waB0U+HeYf2gIDdlWuonL8UCtGukzIpehl0VLoF5dJ8HX5Rp5+a4X
	1/pCBz4SvsEngb7i2CP9DIMHw4E3wBRhEJU4TDWoMI44izJb64bjcoqXg0218dWJQzWcyws0UwT
	IprWK2PukuGJCtVFkhqL4/0=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dQfzj5blgz1cyPb;
	Tue,  9 Dec 2025 21:37:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E18C14013B;
	Tue,  9 Dec 2025 21:39:34 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 21:39:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 2/3] net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
Date: Tue, 9 Dec 2025 21:38:24 +0800
Message-ID: <20251209133825.3577343-3-shaojijie@huawei.com>
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

Currently, rss_size = num_tqps / tc_num. If tc_num is 1, then num_tqps
equals rss_size. However, if the tc_num is greater than 1, then rss_size
will be less than num_tqps, causing the tqp_index check for subsequent TCs
using rss_size to always fail.

This patch uses the num_tqps to check whether tqp_index is out of range,
instead of rss_size.

Fixes: 326334aad024 ("net: hns3: add a check for tqp_index in hclge_get_ring_chain_from_mbx()")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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


