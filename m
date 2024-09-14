Return-Path: <netdev+bounces-128325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0219978FB2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2E4B22184
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A241CEADD;
	Sat, 14 Sep 2024 09:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C961CDFD5;
	Sat, 14 Sep 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307840; cv=none; b=uIbTdzVIoqgNvF1tkjp42uAZ0KiELO6uKOlPnkaz5j8hjCtOfnZEES1t3Ca3kLxu63GZvaY0wbgo1wUx4bdxyEgS+bDnf5UyZ9jiA2qwtOWKz35/NXdwDJmz90GfUl75ktr5OHpLSAKTOVjrcqaLEGBX9fGI4pi1nZtR9bzTbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307840; c=relaxed/simple;
	bh=cpU6ipXWa9Zv3VptYWD2uUpDNTPuz9LPWpsU9qNRoSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tShQbBxll48VJZPGMZJTFVjFuLJvLs0FW9HOKWU8jIgVQIbFFqwqMYE/3sQQ0GV/86q0pbZKYIP7GFSqw6wHGR5PFQ+Rqelx+o3Rd313dHiMTiYWE9WWDkWUtSgyWdi/U80uGKd82ZS2AQCdny9LyGikO6+8H7EdEpPojA55yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X5RRQ0TdrzFqYt;
	Sat, 14 Sep 2024 17:57:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 79F691401F1;
	Sat, 14 Sep 2024 17:57:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 17:57:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>,
	<jstultz@google.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v4 2/2] net: lan743x: Remove duplicate check
Date: Sat, 14 Sep 2024 18:06:25 +0800
Message-ID: <20240914100625.414013-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914100625.414013-1-ruanjinjie@huawei.com>
References: <20240914100625.414013-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since timespec64_valid() has been checked in higher layer
pc_clock_settime(), the duplicate check in lan743x_ptpci_settime64()
can be removed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Update the commit message.
---
v2:
- Check it in ptp core instead of using NSEC_PER_SEC macro.
- Remove the NULL check.
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


