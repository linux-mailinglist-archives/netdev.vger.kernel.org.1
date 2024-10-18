Return-Path: <netdev+bounces-136934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523979A3B3E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1134B22020
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A02038BE;
	Fri, 18 Oct 2024 10:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E31200CB4;
	Fri, 18 Oct 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246652; cv=none; b=gWYD4raENkMJ96kOj12qDeawKCrCcpK9pdcJqCKTAY0Q1E3mzGCKyLrpN9oTwob1OisK49qqCcJmUTXXRNk00XBiu6+PHEXMbmXdScd/Ybcmv2pKPZ0osNeYq4fKuM4ud+CdMLrOuklBuj0+huYhy2itrae3gjl8wWspfnBDWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246652; c=relaxed/simple;
	bh=OduBsRI+5brxvfecv14Oqo66NEhumOkOaeJWxOctJmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyfJ83HNEZMcM/QNRsn3UySeGHvoEcwQq7A/oER7RmpolCsaQYHPHyTSZihg1nKwGeuxCmKBeOBz9WdwTkdHIVK+Rec208daqhG7JB8psr4Jrp+EFYfR1RpSDDDC1SgMAXF37/Qb/f9Acd0ENWJjk3o3xLT5C2+0ulbWdESO1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVLF102rXz10NfW;
	Fri, 18 Oct 2024 18:15:33 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BAE6180087;
	Fri, 18 Oct 2024 18:17:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:27 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 5/9] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
Date: Fri, 18 Oct 2024 18:10:55 +0800
Message-ID: <20241018101059.1718375-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018101059.1718375-1-shaojijie@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

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


