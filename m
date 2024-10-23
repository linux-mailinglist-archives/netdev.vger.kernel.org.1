Return-Path: <netdev+bounces-138124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98A9AC118
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A17B24C0B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6415855D;
	Wed, 23 Oct 2024 08:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8B157E78
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671041; cv=none; b=Z9PxyL6milavDFwrglg0oVQR0Kwtl1W8AQdVYmxcgbQUHj+tD/vN10a8ygys/yYstLS3JRo1A3xIDpPrHEvfYgtnRlzBIZlikgK5jt+IDp2PKnjYc8zppyO/vwQNn+7JCYJahg8ITTu8X1ZqZdwLdtwUcAzZmo9PL41HfcBw+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671041; c=relaxed/simple;
	bh=LOpu70cwJidgCBxiWDxTE2T+gCEG72KKRcQuNgOV5OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoLc4W9JhUkE5/HP2VVXFudoyWC6MKlQZo0Q5XUZavyvM/z1gV04x9bL42+ZSrkWH75yOtU26udJkjZtenRZL+3JxpYcacmGeE7ojYiLbw/GROjhVBIlF7JvukZM8kY2DHAzuffRR5kQaQTZlmKAFydnVrcLeti5ix/wqzZE1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYMBH3vhkzpWtL;
	Wed, 23 Oct 2024 16:08:39 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CAB814022F;
	Wed, 23 Oct 2024 16:10:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 16:10:35 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
Date: Wed, 23 Oct 2024 16:09:20 +0800
Message-ID: <20241023080921.326-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241023080921.326-1-thunder.leizhen@huawei.com>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Fix the incorrect return value check for debugfs_create_dir() and
debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
when it fails.

Commit 4ad23d2368cc ("bna: Remove error checking for
debugfs_create_dir()") allows the program to continue execution if the
creation of bnad->port_debugfs_root fails, which causes the atomic count
bna_debugfs_port_count to be unbalanced. The corresponding error check
need to be added back.

Fixes: 4ad23d2368cc ("bna: Remove error checking for debugfs_create_dir()")
Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 97291bfbeea589e..ad0b29391f990f3 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -493,25 +493,29 @@ void
 bnad_debugfs_init(struct bnad *bnad)
 {
 	const struct bnad_debugfs_entry *file;
+	struct dentry *de;
 	char name[64];
 	int i;
 
 	/* Setup the BNA debugfs root directory*/
 	if (!bna_debugfs_root) {
-		bna_debugfs_root = debugfs_create_dir("bna", NULL);
+		de = debugfs_create_dir("bna", NULL);
 		atomic_set(&bna_debugfs_port_count, 0);
-		if (!bna_debugfs_root) {
+		if (IS_ERR(de)) {
 			netdev_warn(bnad->netdev,
 				    "debugfs root dir creation failed\n");
 			return;
 		}
+		bna_debugfs_root = de;
 	}
 
 	/* Setup the pci_dev debugfs directory for the port */
 	snprintf(name, sizeof(name), "pci_dev:%s", pci_name(bnad->pcidev));
 	if (!bnad->port_debugfs_root) {
-		bnad->port_debugfs_root =
-			debugfs_create_dir(name, bna_debugfs_root);
+		de = debugfs_create_dir(name, bna_debugfs_root);
+		if (IS_ERR(de))
+			return;
+		bnad->port_debugfs_root = de;
 
 		atomic_inc(&bna_debugfs_port_count);
 
@@ -523,7 +527,7 @@ bnad_debugfs_init(struct bnad *bnad)
 							bnad->port_debugfs_root,
 							bnad,
 							file->fops);
-			if (!bnad->bnad_dentry_files[i]) {
+			if (IS_ERR(bnad->bnad_dentry_files[i])) {
 				netdev_warn(bnad->netdev,
 					    "create %s entry failed\n",
 					    file->name);
-- 
2.34.1


