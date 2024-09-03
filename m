Return-Path: <netdev+bounces-124573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCD096A053
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98831F2449B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356357CB1;
	Tue,  3 Sep 2024 14:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943F6F2E3
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373401; cv=none; b=In24+UhQCxYBNQyZHHDkBrtIV6WmZRBx/knhqzqEbbSUR2Hj6HXSR1OEhiYDzSXRfqS6uzCo/NjBNe0kXMjRKvqRHv59WQwuqQ8ibS7HgoHApMRL0FVcdNO+i/svKO/Vjbz+gNMc+Q/p9+EFp21K6l+3agWRcaFFtS/itnS0ouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373401; c=relaxed/simple;
	bh=yWTKaeI+4yxBrrAqcDP6KP4hjgkQxmxilwGh7H79+JI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FqCoz9+FlRL7CbGlm1GeteiTqaEeyWF3crL+ZYmDoEP+s4AhfZzpEX93TCsZBJcCx6FLMqCRm856DvW/KLfx2dWfTJHlyZMQLTPg4WmC48KAe0HK2nytmomzhGl2wR5EJLjHhTueL/L5zZzXzwUyTJL7t7+Ba9xrhTPI56Nhf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WynsD4ryYz1S9mx;
	Tue,  3 Sep 2024 22:22:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DAAC18002B;
	Tue,  3 Sep 2024 22:23:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 22:23:15 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next] ionic: Remove redundant null pointer checks in ionic_debugfs_add_qcq()
Date: Tue, 3 Sep 2024 22:31:49 +0800
Message-ID: <20240903143149.2004530-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the debugfs_create_dir() never returns a null pointer, checking
the return value for a null pointer is redundant, and using IS_ERR is
safe enough.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index 59e5a9f21105..c98b4e75e288 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -123,7 +123,7 @@ void ionic_debugfs_add_qcq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	struct ionic_cq *cq = &qcq->cq;
 
 	qcq_dentry = debugfs_create_dir(q->name, lif->dentry);
-	if (IS_ERR_OR_NULL(qcq_dentry))
+	if (IS_ERR(qcq_dentry))
 		return;
 	qcq->dentry = qcq_dentry;
 
-- 
2.34.1


