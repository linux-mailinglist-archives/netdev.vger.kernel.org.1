Return-Path: <netdev+bounces-211890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAFB1C465
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF411874C4
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D028B4EA;
	Wed,  6 Aug 2025 10:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F610A41;
	Wed,  6 Aug 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476520; cv=none; b=iokL3NKVar0YVNM/ueg3R0R9WooqSCdmJ/U518bSGNUZyGHYvy/CxDgIJ4Xu8UpFR5GS/sqIc0dHVtGnyOqfJzW75jHt4ycEL9dpgltJLDYMMvK5h26mziXt+da+NWL4olb/5KfhUvB8wIdZ8xS5Fo3MliZ50VjttyDM5qlY8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476520; c=relaxed/simple;
	bh=rjny7gErLFEdkyoVCzj4TvXLwbf6D+3TUyA/WEluhsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXNQ7n6fhZI8jxSh6riWmBB551aSPCMnFEL6Nb4IyhfjRHFEbN7D0k1C0wZWvqfUPIzl5BGFV3uwHrboIH21zB50qz6xtEsZMaUUF4hQeaJEhPNsjk4NCQRMYQEDklLFdfN4LUsZcNI1Jlpottz9V/65dL/SkTDC3BNctADi1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bxmql2YVsztT1y;
	Wed,  6 Aug 2025 18:34:11 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C56EE180486;
	Wed,  6 Aug 2025 18:35:12 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 18:35:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 1/3] net: hibmcge: fix rtnl deadlock issue
Date: Wed, 6 Aug 2025 18:27:56 +0800
Message-ID: <20250806102758.3632674-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250806102758.3632674-1-shaojijie@huawei.com>
References: <20250806102758.3632674-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Currently, the hibmcge netdev acquires the rtnl_lock in
pci_error_handlers.reset_prepare() and releases it in
pci_error_handlers.reset_done().

However, in the PCI framework:
pci_reset_bus - __pci_reset_slot - pci_slot_save_and_disable_locked -
 pci_dev_save_and_disable - err_handler->reset_prepare(dev);

In pci_slot_save_and_disable_locked():
	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
		if (!dev->slot || dev->slot!= slot)
			continue;
		pci_dev_save_and_disable(dev);
		if (dev->subordinate)
			pci_bus_save_and_disable_locked(dev->subordinate);
	}

This will iterate through all devices under the current bus and execute
err_handler->reset_prepare(), causing two devices of the hibmcge driver
to sequentially request the rtnl_lock, leading to a deadlock.

Since the driver now executes netif_device_detach()
before the reset process, it will not concurrently with
other netdev APIs, so there is no need to hold the rtnl_lock now.

Therefore, this patch removes the rtnl_lock during the reset process and
adjusts the position of HBG_NIC_STATE_RESETTING to ensure
that multiple resets are not executed concurrently.

Fixes: 3f5a61f6d504f ("net: hibmcge: Add reset supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v1 -> v2:
  - Fix a concurrency issue, suggested by Simon Horman
  v1: https://lore.kernel.org/all/20250731134749.4090041-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 503cfbfb4a8a..83cf75bf7a17 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -53,9 +53,11 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 {
 	int ret;
 
-	ASSERT_RTNL();
+	if (test_and_set_bit(HBG_NIC_STATE_RESETTING, &priv->state))
+		return -EBUSY;
 
 	if (netif_running(priv->netdev)) {
+		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 		dev_warn(&priv->pdev->dev,
 			 "failed to reset because port is up\n");
 		return -EBUSY;
@@ -64,7 +66,6 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 	netif_device_detach(priv->netdev);
 
 	priv->reset_type = type;
-	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
 	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
 	if (ret) {
@@ -84,29 +85,26 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
 	    type != priv->reset_type)
 		return 0;
 
-	ASSERT_RTNL();
-
-	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	ret = hbg_rebuild(priv);
 	if (ret) {
 		priv->stats.reset_fail_cnt++;
 		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
+		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 		dev_err(&priv->pdev->dev, "failed to rebuild after reset\n");
 		return ret;
 	}
 
 	netif_device_attach(priv->netdev);
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 
 	dev_info(&priv->pdev->dev, "reset done\n");
 	return ret;
 }
 
-/* must be protected by rtnl lock */
 int hbg_reset(struct hbg_priv *priv)
 {
 	int ret;
 
-	ASSERT_RTNL();
 	ret = hbg_reset_prepare(priv, HBG_RESET_TYPE_FUNCTION);
 	if (ret)
 		return ret;
@@ -171,7 +169,6 @@ static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct hbg_priv *priv = netdev_priv(netdev);
 
-	rtnl_lock();
 	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
 }
 
@@ -181,7 +178,6 @@ static void hbg_pci_err_reset_done(struct pci_dev *pdev)
 	struct hbg_priv *priv = netdev_priv(netdev);
 
 	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
-	rtnl_unlock();
 }
 
 static const struct pci_error_handlers hbg_pci_err_handler = {
-- 
2.33.0


