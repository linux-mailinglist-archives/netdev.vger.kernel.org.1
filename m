Return-Path: <netdev+bounces-168523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C607EA3F3A0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BED17B221
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1C20B207;
	Fri, 21 Feb 2025 12:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20C1AF0B8;
	Fri, 21 Feb 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139402; cv=none; b=DhBe9v9iiE0Yw884pQps/E+mNRtvDFBvS69RC0Cf/1qlRmNPh4KZkciXI9/r0awU8242aBDSCoBoJX+s1y0J4nYAyYukws3Nbh8x8vGVAI5aE6lDspL/YslFDDgs7yBMqT15FflMOnPikwMop2rUJ4zP7u4itZ2cGWhtbM2XtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139402; c=relaxed/simple;
	bh=zRywRA7/WyMfvVOHBwPh9/SVjcWoMKvenkIiV2OlwHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmltYsXnp8ZXPD8CdQJjqb7LpRfyMV/8sJqXMA8lEwv/Y6s1tPKbCT77vbP+A1u0Pm7cFEjApcZcBr7873ZRtKr8l5tYuTdni5ASj4zOYiBgD9va3qV7IEKt/dyvyaI+mKP5iMpFGczF0c7ATRDmswd2BIBy1SDaqWmyn1NprXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YzpZw1fHQzkXMB;
	Fri, 21 Feb 2025 19:59:36 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 719901800EB;
	Fri, 21 Feb 2025 20:03:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 20:03:17 +0800
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
Subject: [PATCH v3 net-next 6/6] net: hibmcge: Add support for ioctl
Date: Fri, 21 Feb 2025 19:55:26 +0800
Message-ID: <20250221115526.1082660-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250221115526.1082660-1-shaojijie@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


