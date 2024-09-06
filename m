Return-Path: <netdev+bounces-125770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE296E853
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54791F24907
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5B45028;
	Fri,  6 Sep 2024 03:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA61EB35
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593974; cv=none; b=si9R2DXxFfFN1Hh646DSTXm0W9VkXBs3vFIqUZ0oTgKFJk07gU7sFXDinr6vVv7iycm6oBsiiUyrgetR0oQg/rMww0pIIXj8vcXuDHEjiLDy88+GZoz2yP4EnITXeD5XQ4H6obddCeD3T3bShq7HmZAOoKw+tLGvLXDyevzNPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593974; c=relaxed/simple;
	bh=c2XJakVWDxbtvXzXQj8rAxQAFIYQTKUEGGn5yXdgNtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/XBtRpgOr7t3CEpmhnUgGnIKaDof4HQ7haXDWzsVFONBQvwdg7MsC/50CM5CW66dbxYT37gfSfi7IR0hbfkEd5hgNbf0/FcSYa47UbukQSXsQItHuQdO5H3Q2j/iYzVTBDrBWv2/jZKBJZm+Qxms5Sdm7w2/WqrdNWno3ECAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X0MP21kYNz1xwyH;
	Fri,  6 Sep 2024 11:37:26 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BD0DE180041;
	Fri,  6 Sep 2024 11:39:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 11:39:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/2] net: lan743x: Remove duplicate check
Date: Fri, 6 Sep 2024 11:48:06 +0800
Message-ID: <20240906034806.1161083-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906034806.1161083-1-ruanjinjie@huawei.com>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since timespec64_valid() has been checked before ptp->info->settime64(),
the duplicate check in lan743x_ptpci_settime64() can be removed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Check it in ptp core instead of using NSEC_PER_SEC macro.
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index dcea6652d56d..4a777b449ecd 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -401,28 +401,21 @@ static int lan743x_ptpci_settime64(struct ptp_clock_info *ptpci,
 	u32 nano_seconds = 0;
 	u32 seconds = 0;
 
-	if (ts) {
-		if (ts->tv_sec > 0xFFFFFFFFLL ||
-		    ts->tv_sec < 0) {
-			netif_warn(adapter, drv, adapter->netdev,
-				   "ts->tv_sec out of range, %lld\n",
-				   ts->tv_sec);
-			return -ERANGE;
-		}
-		if (ts->tv_nsec >= 1000000000L ||
-		    ts->tv_nsec < 0) {
-			netif_warn(adapter, drv, adapter->netdev,
-				   "ts->tv_nsec out of range, %ld\n",
-				   ts->tv_nsec);
-			return -ERANGE;
-		}
-		seconds = ts->tv_sec;
-		nano_seconds = ts->tv_nsec;
-		lan743x_ptp_clock_set(adapter, seconds, nano_seconds, 0);
-	} else {
-		netif_warn(adapter, drv, adapter->netdev, "ts == NULL\n");
-		return -EINVAL;
+	if (ts->tv_sec > 0xFFFFFFFFLL) {
+		netif_warn(adapter, drv, adapter->netdev,
+			   "ts->tv_sec out of range, %lld\n",
+			   ts->tv_sec);
+		return -ERANGE;
+	}
+	if (ts->tv_nsec < 0) {
+		netif_warn(adapter, drv, adapter->netdev,
+			   "ts->tv_nsec out of range, %ld\n",
+			   ts->tv_nsec);
+		return -ERANGE;
 	}
+	seconds = ts->tv_sec;
+	nano_seconds = ts->tv_nsec;
+	lan743x_ptp_clock_set(adapter, seconds, nano_seconds, 0);
 
 	return 0;
 }
-- 
2.34.1


