Return-Path: <netdev+bounces-126392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF99970FE7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EA41C21C07
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1D1AE055;
	Mon,  9 Sep 2024 07:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21961ACDE0;
	Mon,  9 Sep 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867155; cv=none; b=L7nuGJ3U065381rABDllX3FABGnEjklNI5e17wPg2CU4p48UpurPJLtZv51MuiB5ADmwJmuVR0PfuowvkfjSJuTw2SGBNvMWfQQexn0+l26qVSGWqy5YV/dgH3RJ0EsApcEosSxlNW3B9u//EI4Lc8mf1HhBK1qfVg9sk1yZXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867155; c=relaxed/simple;
	bh=myQt5aCzWi8Q6tUlGDOHvpAZu8yRfBEBXg5KUr0U9ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDJeBl6Zk6/uTOm6TVHGF5QkMYVtkN/G88ibncDSferlVVYGTefJiMSNwltEuj9njjJ9QHf782Htt2WqgEX9k3q6+B9WhdqDivhVf9bQLu6UaXqJbLarVjPVFBHdl9WCLO7h8iNVQM8jJIrZ6fGARSYwARUITbAuDRNShOKMtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2JSP35z9z2Dbcw;
	Mon,  9 Sep 2024 15:32:05 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 078FC1A016C;
	Mon,  9 Sep 2024 15:32:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 15:32:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>,
	<jstultz@google.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 2/2] net: lan743x: Remove duplicate check
Date: Mon, 9 Sep 2024 15:41:24 +0800
Message-ID: <20240909074124.964907-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909074124.964907-1-ruanjinjie@huawei.com>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since timespec64_valid() has been checked before ptp->info->settime64(),
the duplicate check in lan743x_ptpci_settime64() can be removed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


