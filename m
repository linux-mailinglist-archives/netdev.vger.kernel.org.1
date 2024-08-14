Return-Path: <netdev+bounces-118404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE889517CA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B121F22A8B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07B14A093;
	Wed, 14 Aug 2024 09:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E316149C6E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628165; cv=none; b=IFP6onqfH0zWN+oIDYhuJvek2Xls8DxAScCQUm/LjabKIaCUtQ+v62PFK9iQdt2pJhinpHTbvSXgvnMnil5uijvZU5Ev2IOncu0TWIkyLwx4ZGlLRVuAzfg6P0+Nnh8ApYNlHZrMkZawg/UazuUYuWvXbcX8alFh42241ARrdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628165; c=relaxed/simple;
	bh=vvniSCZJ5dOoAFzrYjFH1O75ui1N65MuTLytqs6yJuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=trSHrWifjV/VbJ4mBRXVnnZz68kWGfog4G7LTCATsdJQa8WqXxfRz42sIrQqu3MzLERR9WpP09iz7jDFx96uMjyCJWzEqiexFAGLcKjml8dxHRix8uc25v5/ZUUk12LoTIXR0lnpUtCTwxXTIKrutEQbt/lAMfZ+ril9jjD0WyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WkNQp3JcbzyPt2;
	Wed, 14 Aug 2024 17:35:30 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 69F8F1400C9;
	Wed, 14 Aug 2024 17:36:00 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:35:59 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <alex.austin@amd.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
Subject: [PATCH -next] sfc: Add missing pci_disable_device() for efx_pm_resume()
Date: Wed, 14 Aug 2024 09:29:46 +0000
Message-ID: <20240814092946.1371750-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)

Add missing pci_disable_device() in error path of efx_pm_resume().

Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/net/ethernet/sfc/siena/efx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
index 59d3a6043379..dce9a5174e4a 100644
--- a/drivers/net/ethernet/sfc/siena/efx.c
+++ b/drivers/net/ethernet/sfc/siena/efx.c
@@ -1240,13 +1240,15 @@ static int efx_pm_resume(struct device *dev)
 	pci_set_master(efx->pci_dev);
 	rc = efx->type->reset(efx, RESET_TYPE_ALL);
 	if (rc)
-		return rc;
+		goto fail;
 	down_write(&efx->filter_sem);
 	rc = efx->type->init(efx);
 	up_write(&efx->filter_sem);
 	if (rc)
-		return rc;
+		goto fail;
 	rc = efx_pm_thaw(dev);
+fail:
+	pci_disable_device(pci_dev);
 	return rc;
 }
 
-- 
2.25.1


