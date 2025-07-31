Return-Path: <netdev+bounces-211207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F046B17295
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE693BA0AD
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB62D239A;
	Thu, 31 Jul 2025 13:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAB2BF00B;
	Thu, 31 Jul 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970123; cv=none; b=gt2XnUpFLGQfxyMFhY3b+AqYaFCobf8fxS1dquay+WZ4ezk0zeTSTmHUrif30PfWpoza1Q9hM6y3cI5TU27IIXmQ2UCwqN8ibjRzSm86ZEL5LyTZIcM9w0csKbp0lUJaKKHINzh30sNbkxvrMG+amHfhtwEFtEXFb2I9yqZNnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970123; c=relaxed/simple;
	bh=7hHBqQf805NswColiBex+ANNVzs2Xz5BQCv/ANGMenY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUY67nFPLYvtiWtnSejB+00yAKXlhAfMdEtRuM9hiCr0GMN3qme5MfZjcb7tauuHcbRSdypDq+l5zVzR/hZ0JFmc6+s/OMwSXPidgeN9EDmxKRaK+Zl/GF5zN+gUHLN5OP+jGpQXhx14ucoAxuXUvii1Jg2yJSiADsBRjHmdNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bt9YL3j4wztSbd;
	Thu, 31 Jul 2025 21:54:14 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0813118007F;
	Thu, 31 Jul 2025 21:55:17 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Jul 2025 21:55:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 1/3] net: hibmcge: fix rtnl deadlock issue
Date: Thu, 31 Jul 2025 21:47:47 +0800
Message-ID: <20250731134749.4090041-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250731134749.4090041-1-shaojijie@huawei.com>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index 503cfbfb4a8a..94bc6f0da912 100644
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
@@ -84,10 +85,8 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
 	    type != priv->reset_type)
 		return 0;
 
-	ASSERT_RTNL();
-
-	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	ret = hbg_rebuild(priv);
+	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	if (ret) {
 		priv->stats.reset_fail_cnt++;
 		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
@@ -101,12 +100,10 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
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
@@ -171,7 +168,6 @@ static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct hbg_priv *priv = netdev_priv(netdev);
 
-	rtnl_lock();
 	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
 }
 
@@ -181,7 +177,6 @@ static void hbg_pci_err_reset_done(struct pci_dev *pdev)
 	struct hbg_priv *priv = netdev_priv(netdev);
 
 	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
-	rtnl_unlock();
 }
 
 static const struct pci_error_handlers hbg_pci_err_handler = {
-- 
2.33.0


