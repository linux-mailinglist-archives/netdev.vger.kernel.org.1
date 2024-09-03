Return-Path: <netdev+bounces-124574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E096A059
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235AD2850EA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367706F30D;
	Tue,  3 Sep 2024 14:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65A1CA684
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373515; cv=none; b=gbje8v47p5avYDpMoeobBB7VIZ+aj5EUv1etrSbKzZWsSXDL2PHmCkrlFYzhakIdDvdiy6VHkcu8+5xR3EXDozf9rr4bxKgXD3yxmzemAlw2bTFBQf5omFJXkgljV+7b4xLyCeWc/aNLm24iPcTBUv4dibDLzZIxOyHJsDLZyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373515; c=relaxed/simple;
	bh=s5Otau86VVH9rl2ZgjLEaReDiTXR3z/WrwCfZe2zyuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOcw7JGl1hDVS9bFbeXgvGAB0aPQ66Jk+m1JXKiOcFhflb9I4Z7II+oDGkfLhKTyEy9qSv7wTg1irr/1kULn+AkPsIIeW2Yn9Uo+zgSjojHHah2f6XBgFiFFvcF5V6EGXys8wu0xusa2RthZsVy0KmIR3Fo6qwOgm8DzLA4JO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wynqq6NDFz1HJ9x;
	Tue,  3 Sep 2024 22:21:43 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C53E1402C6;
	Tue,  3 Sep 2024 22:25:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 22:25:09 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next] pds_core: Remove redundant null pointer checks
Date: Tue, 3 Sep 2024 22:33:43 +0800
Message-ID: <20240903143343.2004652-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the debugfs_create_dir() never returns a null pointer, checking
the return value for a null pointer is redundant, and using IS_ERR is
safe enough.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 6bdd02b7aa6d..ac37a4e738ae 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -112,7 +112,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	struct pdsc_cq *cq = &qcq->cq;
 
 	qcq_dentry = debugfs_create_dir(q->name, pdsc->dentry);
-	if (IS_ERR_OR_NULL(qcq_dentry))
+	if (IS_ERR(qcq_dentry))
 		return;
 	qcq->dentry = qcq_dentry;
 
@@ -123,7 +123,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	debugfs_create_x32("accum_work", 0400, qcq_dentry, &qcq->accum_work);
 
 	q_dentry = debugfs_create_dir("q", qcq->dentry);
-	if (IS_ERR_OR_NULL(q_dentry))
+	if (IS_ERR(q_dentry))
 		return;
 
 	debugfs_create_u32("index", 0400, q_dentry, &q->index);
@@ -135,7 +135,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 	debugfs_create_u16("head", 0400, q_dentry, &q->head_idx);
 
 	cq_dentry = debugfs_create_dir("cq", qcq->dentry);
-	if (IS_ERR_OR_NULL(cq_dentry))
+	if (IS_ERR(cq_dentry))
 		return;
 
 	debugfs_create_x64("base_pa", 0400, cq_dentry, &cq->base_pa);
@@ -148,7 +148,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 		struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
 
 		intr_dentry = debugfs_create_dir("intr", qcq->dentry);
-		if (IS_ERR_OR_NULL(intr_dentry))
+		if (IS_ERR(intr_dentry))
 			return;
 
 		debugfs_create_u32("index", 0400, intr_dentry, &intr->index);
-- 
2.34.1


