Return-Path: <netdev+bounces-118700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C549295282A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA83B2400D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68212231C;
	Thu, 15 Aug 2024 03:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9639FCF
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691465; cv=none; b=WJ/qbWz/XfwyjDtrjsx9VwpHQVmRcoN+Mp1YeinbStKkSRxM/mr/N8BpLpraVgp4/Yt2GN3qY9AJvq4eZmWEaENlZQ85nrhMsfBW29CMtNftb4ZYbsq8ynwbIbPwRb4EsgdLuRRCvbDD2mEqNpl65HPmK7BaxkN3ywMjnleLTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691465; c=relaxed/simple;
	bh=O/bWMPzn/pDyFB6e7+AmZWh5VKHxPGa/hvRe75XXuew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NfhCzM/hMllQ/uALa64B7W6sBV7pLGRcNB+THWE1C/VgrmoOhm+oaBw1feNLsxFgaNqI0s4pRgd3sJOsBKvLPWOvWwSbRtEQ3w05lXUf0wPt/fJJsQY3nvv8XADYuEIgKqvGqdhYqJZaRDeLF+OPypPtTfPrvdk1dw/TeRHjSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wkqn769d9z1HGP3;
	Thu, 15 Aug 2024 11:07:55 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id F10951A0188;
	Thu, 15 Aug 2024 11:11:00 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 11:11:00 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <alex.austin@amd.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
Subject: [PATCH v2 -next] sfc: Add missing pci_disable_device() for error path
Date: Thu, 15 Aug 2024 03:04:36 +0000
Message-ID: <20240815030436.1373868-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)

This error path needs to disable the pci device before returning.

Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
Fixes: 89c758fa47b5 ("sfc: Add power-management and wake-on-LAN support")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---

v2: add pci_disable_device() for efx_pm_resume() (drivers/net/ethernet/sfc/efx.c)
and ef4_pm_resume() (drivers/net/ethernet/sfc/falcon/efx.c)

 drivers/net/ethernet/sfc/efx.c        | 6 ++++--
 drivers/net/ethernet/sfc/falcon/efx.c | 6 ++++--
 drivers/net/ethernet/sfc/siena/efx.c  | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 6f1a01ded7d4..bf6567093001 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1278,13 +1278,15 @@ static int efx_pm_resume(struct device *dev)
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
 
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 8925745f1c17..2c3cf1c9a1a7 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -3027,11 +3027,13 @@ static int ef4_pm_resume(struct device *dev)
 	pci_set_master(efx->pci_dev);
 	rc = efx->type->reset(efx, RESET_TYPE_ALL);
 	if (rc)
-		return rc;
+		goto fail;
 	rc = efx->type->init(efx);
 	if (rc)
-		return rc;
+		goto fail;
 	rc = ef4_pm_thaw(dev);
+fail:
+	pci_disable_device(pci_dev);
 	return rc;
 }
 
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


