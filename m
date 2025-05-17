Return-Path: <netdev+bounces-191288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A30ABA97B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2BD1BA270C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE61F5820;
	Sat, 17 May 2025 10:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C11DE3A7;
	Sat, 17 May 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476337; cv=none; b=b0svIcro3Jyx/h5KvxKeZrDvNJEQa/EcF3SzcS+bG6GLnYdhoEf5Bht2mLtYOhhFyy7mYZ4r46eEDo0g86kj93UrWwmYlRzSktKlB9G1LIHnFdVIv7d5X9mzGitQr/bIWJKJRQVWEw7s6Ba+xw6jPBJ/h0SOIg93zbPhBUcDCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476337; c=relaxed/simple;
	bh=cDKGUI3rjs2G7Oboz1ElaHfdfU5ASoa3Muk9Q8T29So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGn626QvH3pCHeY74ao0a8YjLLXUkTvOwHqYHZh2Em8jqW0IlRz5aga9Ij7+D7WFvXe0req5AgaoAljDB+/5gMiyRXUmZOyLj6uMGy2bPKWhNZDH0EFfT6dZw6XNoRvSRavz6bD3SOaccEFzHS9CuEp4RNC26L6WUXOEbc6bnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b002g4Hrlz27hdQ;
	Sat, 17 May 2025 18:06:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AFEE61800B3;
	Sat, 17 May 2025 18:05:15 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 May 2025 18:05:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net 2/2] net: hibmcge: fix wrong ndo.open() after reset fail issue.
Date: Sat, 17 May 2025 17:58:28 +0800
Message-ID: <20250517095828.1763126-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250517095828.1763126-1-shaojijie@huawei.com>
References: <20250517095828.1763126-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

If the driver reset fails, it may not work properly.
Therefore, the ndo.open() operation should be rejected.

In this patch, the driver calls netif_device_detach()
before the reset and calls netif_device_attach()
after the reset succeeds. If the reset fails,
netif_device_attach() is not called. Therefore,
netdev does not present and cannot be opened.

If reset fails, only the PCI reset (via sysfs)
can be used to attempt recovery.

Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - Use netif_device_detach() to block netdev callbacks after reset fails, suggested by Jakub.
  v1: https://lore.kernel.org/all/20250430093127.2400813-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index a0bcfb5a713d..ff3295b60a69 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -61,6 +61,8 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 		return -EBUSY;
 	}
 
+	netif_device_detach(priv->netdev);
+
 	priv->reset_type = type;
 	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
@@ -91,6 +93,8 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
 		return ret;
 	}
 
+	netif_device_attach(priv->netdev);
+
 	dev_info(&priv->pdev->dev, "reset done\n");
 	return ret;
 }
@@ -117,16 +121,13 @@ void hbg_err_reset(struct hbg_priv *priv)
 	if (running)
 		dev_close(priv->netdev);
 
-	hbg_reset(priv);
-
-	/* in hbg_pci_err_detected(), we will detach first,
-	 * so we need to attach before open
-	 */
-	if (!netif_device_present(priv->netdev))
-		netif_device_attach(priv->netdev);
+	if (hbg_reset(priv))
+		goto err_unlock;
 
 	if (running)
 		dev_open(priv->netdev, NULL);
+
+err_unlock:
 	rtnl_unlock();
 }
 
@@ -160,7 +161,6 @@ static pci_ers_result_t hbg_pci_err_slot_reset(struct pci_dev *pdev)
 	pci_save_state(pdev);
 
 	hbg_err_reset(priv);
-	netif_device_attach(netdev);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.33.0


