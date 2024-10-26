Return-Path: <netdev+bounces-139288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044229B145E
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 05:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D97A2818F3
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0713C3F6;
	Sat, 26 Oct 2024 03:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2D13C9A3
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729914554; cv=none; b=cw24eNaFvCegBfsKyaeNInuPNMT2l3KSPydT4UnxFrlRKu+spVFegMywNWWX4hP7I3WT4nyPuaXODe7dSJ+9/2lGM0v7E+KoyTDWx8Wqnv47aQ3cTG99kpORTMfX7cCo3izlteyzxnV8REXHi0g4gs43Kd9jbhOY27qYDCSlBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729914554; c=relaxed/simple;
	bh=M+vbKR/dapp5WWzfzGYRNGd+SKluD0eHn0NA3znI5Mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAcdOxHAsxJ/kQO9sWJQCLGJFwQKtiqrOM0/1P0XEx++XINZ0rwhL8ERgB6QPYJCmNitNiuryTM7giOOVX1BSy1lMiVONheIX3T28ufAoKiRt9EX1hodCNPdRyFOb2dS/zfYAVSak7/cGtkM8giaZXhxZOFDkIvnr+6cP27pRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xb5Fg2nMJz1jvwL;
	Sat, 26 Oct 2024 11:47:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id CF4F81401E9;
	Sat, 26 Oct 2024 11:49:01 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 11:49:01 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] bna: Remove error checking for debugfs create APIs
Date: Sat, 26 Oct 2024 11:47:59 +0800
Message-ID: <20241026034800.450-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241026034800.450-1-thunder.leizhen@huawei.com>
References: <20241026034800.450-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Driver bna can work fine even if any previous call to debugfs create
APIs failed. All return value checks of them should be dropped, as
debugfs APIs say.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 97291bfbeea589e..220d20a829c8a84 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -500,19 +500,12 @@ bnad_debugfs_init(struct bnad *bnad)
 	if (!bna_debugfs_root) {
 		bna_debugfs_root = debugfs_create_dir("bna", NULL);
 		atomic_set(&bna_debugfs_port_count, 0);
-		if (!bna_debugfs_root) {
-			netdev_warn(bnad->netdev,
-				    "debugfs root dir creation failed\n");
-			return;
-		}
 	}
 
 	/* Setup the pci_dev debugfs directory for the port */
 	snprintf(name, sizeof(name), "pci_dev:%s", pci_name(bnad->pcidev));
 	if (!bnad->port_debugfs_root) {
-		bnad->port_debugfs_root =
-			debugfs_create_dir(name, bna_debugfs_root);
-
+		bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);
 		atomic_inc(&bna_debugfs_port_count);
 
 		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
@@ -523,12 +516,6 @@ bnad_debugfs_init(struct bnad *bnad)
 							bnad->port_debugfs_root,
 							bnad,
 							file->fops);
-			if (!bnad->bnad_dentry_files[i]) {
-				netdev_warn(bnad->netdev,
-					    "create %s entry failed\n",
-					    file->name);
-				return;
-			}
 		}
 	}
 }
-- 
2.34.1


