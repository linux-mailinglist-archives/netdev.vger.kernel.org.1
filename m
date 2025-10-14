Return-Path: <netdev+bounces-229248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF0BD9CA1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC274E8776
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D13313E2D;
	Tue, 14 Oct 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dkA9wLq/"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657931354E;
	Tue, 14 Oct 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449302; cv=none; b=h6ZpZAUOwlvVLcyDkBm0SA+vuMAx4F1Y4f5/YBctbPlqMm596GSX2FyXaatlVdEaqnLshpBUyEerXBilk3KkKvdmsOGWphdZcoghYPGdKO4/9igzcBaSZGf3lTUlK4KCrT4Jv89TE44Zu48ydMyyHda2p940JIddItpYjwh7ZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449302; c=relaxed/simple;
	bh=FvDj0ydaZoi636LkzoBnZUnkpov1fGpiyL+EOd6mK/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwJpRjwrPeInfRHWF1nxtXBoJR877vE1llqLPVqNSsvXF2TLQL+SDIWFVGNvFy5HKTsRJ2HocRy9scLiRun58lpiGKZyEs36aReykhXWEsWuCIz35IFeNBOMlGR66wImzQk1hH2fQCXpR4oa/VmuxhpD9Zn/f4KJp/eu6yu2tjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dkA9wLq/; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LQ53309smQkewC5dTz7cgjIkOofqOc79xt6b/S0KQn8=;
	b=dkA9wLq/vjFteFS6r5px+7yVL+i6QjO2wIggRMQC3tALXARGvsP4IvXTaOtZa+enfoGloFGBJ
	U3aOqpDAGhIBI1/OAEP946WOiP/1PJsND8onTjKv5wMHN4GI4e7NrK3LhHo2FBIrnWe5V7clzxH
	Ptp0AvIvh1xopLjIhLfsxuw=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cmFjZ2gT8z1prQ1;
	Tue, 14 Oct 2025 21:41:06 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 760B71402DA;
	Tue, 14 Oct 2025 21:41:26 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 21:41:25 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next] net: hibmcge: support pci_driver.shutdown()
Date: Tue, 14 Oct 2025 21:40:18 +0800
Message-ID: <20251014134018.1178385-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
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

support pci_driver.shutdown() for hibmcge driver.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 0b92a2e5e986..068da2fd1fea 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -472,6 +472,22 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 }
 
+static void hbg_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	rtnl_lock();
+	if (netif_running(netdev))
+		dev_close(netdev);
+	rtnl_unlock();
+
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
 static const struct pci_device_id hbg_pci_tbl[] = {
 	{PCI_VDEVICE(HUAWEI, 0x3730), 0},
 	{ }
@@ -482,6 +498,7 @@ static struct pci_driver hbg_driver = {
 	.name		= "hibmcge",
 	.id_table	= hbg_pci_tbl,
 	.probe		= hbg_probe,
+	.shutdown	= hbg_shutdown,
 };
 
 static int __init hbg_module_init(void)
-- 
2.33.0


