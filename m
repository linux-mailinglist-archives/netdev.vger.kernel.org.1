Return-Path: <netdev+bounces-170680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E6A498B3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEF1896F48
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253226B941;
	Fri, 28 Feb 2025 12:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44926A1D9;
	Fri, 28 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744110; cv=none; b=i83QO6akjH8EAZUWHX8qJBKM5WduiSFC4ACQ9uIuCO1+zYORaZz37vckiAFKlb6O5INLaueXiGRZpA7Sx55s/yy6xn1S6l2AB5Qe65X2qviwK0V3xXgXWLfoWZZhZwafon+UfwpagD0/BPzEqEgGSiEWHCfvSHqjzrIfBzacGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744110; c=relaxed/simple;
	bh=zRywRA7/WyMfvVOHBwPh9/SVjcWoMKvenkIiV2OlwHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft0px2RwXskza/qFUL0Q8xS2+Ejykq/fQt2B/a+7x/9R4iBowQm1amIB6UGa0UnGoV1ld1ZXRy61X/1xqR23q9cFnSnU4w96DhkSiqBsYIahK8qVJJ1S4Tw079NIeYybaVjqy0AhfFanzWHnxnd6GucOffwpCQgJDVp439z1xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z46Jp63S6z17NTk;
	Fri, 28 Feb 2025 20:02:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 327141A016C;
	Fri, 28 Feb 2025 20:01:46 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 20:01:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net-next 6/6] net: hibmcge: Add support for ioctl
Date: Fri, 28 Feb 2025 19:54:11 +0800
Message-ID: <20250228115411.1750803-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250228115411.1750803-1-shaojijie@huawei.com>
References: <20250228115411.1750803-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch implements the .ndo_eth_ioctl() to
read and write the PHY register.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
ChangeLog:
v1 -> v2:
  - Use phy_do_ioctl() to simplify ioctl code, suggested by Andrew.
  v1: https://lore.kernel.org/all/20250213035529.2402283-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index c6a955e640fc..2ac5454338e4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -5,6 +5,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phy.h>
 #include "hbg_common.h"
 #include "hbg_diagnose.h"
 #include "hbg_err.h"
@@ -277,6 +278,7 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
 	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
 	.ndo_get_stats64	= hbg_net_get_stats,
+	.ndo_eth_ioctl		= phy_do_ioctl_running,
 };
 
 static void hbg_service_task(struct work_struct *work)
-- 
2.33.0


