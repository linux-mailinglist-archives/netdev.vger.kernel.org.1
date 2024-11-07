Return-Path: <netdev+bounces-142856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BA9C07A5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3683D1C22B96
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC820F5AA;
	Thu,  7 Nov 2024 13:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F91DDA3B;
	Thu,  7 Nov 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986626; cv=none; b=qUtdDZxUCxcdKR2GbnY7+anKGYtWzJ+3WtdThFb6Aytx6LWC2jYjifuCmLLkdnBZrNkK3Tk6RSSaeAZ3Qalk4f/NgPJc9PZsiQpt0z07Pw5jZSaiYUcmN6OoJcYq9mw0J/GrFwujjC85Vv/rwLuFOf5sk1X6/D9ITtgVg7+q2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986626; c=relaxed/simple;
	bh=twFZODRQ3YhB0Skx32kV5XpiMBa1D+v8M58zHDKX/ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbHJ6Yl3DjCD1qVnnIz5Gy6BfRgrNldg1DW3u/m74RsO4LIC/HGDhjWFW9lg/6Zbcl5TKLMKRe71jbUPHekoFKNV6ddkKiNSSFoU/SzKDOn/e+TdW4q0TxMAjfskvo/aCO6+IS1UfQgbn4PW0AZhq8jtbedyBVkfEI1a1KX6bDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XkjkH5l6hz1jwS5;
	Thu,  7 Nov 2024 21:35:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DD18140136;
	Thu,  7 Nov 2024 21:37:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 21:37:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
Date: Thu, 7 Nov 2024 21:30:19 +0800
Message-ID: <20241107133023.3813095-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241107133023.3813095-1-shaojijie@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Hao Lan <lanhao@huawei.com>

This patch modifies the implementation of debugfs:
When the user process stops unexpectedly, not all data of the file system
is read. In this case, the save_buf pointer is not released. When the user
process is called next time, save_buf is used to copy the cached data
to the user space. As a result, the queried data is inconsistent. To solve
this problem, determine whether the function is invoked for the first time
based on the value of *ppos. If *ppos is 0, obtain the actual data.

Fixes: 5e69ea7ee2a6 ("net: hns3: refactor the debugfs process")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Guangwei Zhang <zhangwangwei6@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 807eb3bbb11c..841e5af7b2be 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1293,8 +1293,10 @@ static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
 
 		/* save the buffer addr until the last read operation */
 		*save_buf = read_buf;
+	}
 
-		/* get data ready for the first time to read */
+	/* get data ready for the first time to read */
+	if (!*ppos) {
 		ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
 					read_buf, hns3_dbg_cmd[index].buf_len);
 		if (ret)
-- 
2.33.0


