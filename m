Return-Path: <netdev+bounces-139415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111359B229D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA026281093
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B9183CD9;
	Mon, 28 Oct 2024 02:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330071422AB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081452; cv=none; b=uT45g14RyMg4NE+F9zxuDeWiBBN1qhvWq/DRGPrTmiq0RLijDd7CLvJI89nSb1Y+LT6/cwNu5yrb2MXVWKDOlFaUn/i/sjqVSumxIMeLt8DzVtqhwwCF5Be95gBQqZGB2EqD0nKy+L0n/5+42q1rSooVpS66SWtM0Qdwn8uAd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081452; c=relaxed/simple;
	bh=+XPO1kAmKUkH/ejfmgA7u6lDbZ0myocH/z/ZPuesW20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUDxuwNoBaXtaePcMPXZ5pnBvM84Qisjs2Wgcidg7/svlvlAeuibnh0g0wt4vHcA3ypBlmyBMs7aIVMOR4KuG//rF/6ArJKpyQNO6M9thlaUnsIfXkv04Xbk29bS2DdntvUnnsAEU4YFWYRFJ4urcVJWFNPJ4xErzBeclBIWV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XcH1563vMz1ynMV;
	Mon, 28 Oct 2024 10:10:49 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F80E140202;
	Mon, 28 Oct 2024 10:10:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 10:10:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/2] bna: Remove error checking for debugfs create APIs
Date: Mon, 28 Oct 2024 10:09:42 +0800
Message-ID: <20241028020943.507-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241028020943.507-1-thunder.leizhen@huawei.com>
References: <20241028020943.507-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Driver bna can work fine even if any previous call to debugfs create
APIs failed. All return value checks of them should be dropped, as
debugfs APIs say.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 97291bfbeea589e..1a3a8bd133706ad 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -500,11 +500,6 @@ bnad_debugfs_init(struct bnad *bnad)
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
@@ -523,12 +518,6 @@ bnad_debugfs_init(struct bnad *bnad)
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


