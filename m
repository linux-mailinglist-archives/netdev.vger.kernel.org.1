Return-Path: <netdev+bounces-133008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21829943D4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD221F23242
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4591C3F27;
	Tue,  8 Oct 2024 09:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0687DA76;
	Tue,  8 Oct 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378722; cv=none; b=jkxvpULYDo/yovhhLUOen3Mr6GHsgk2GFkOUNnEZpSb9Ss218OX5J9VNfqCEAteyhADK1RTM0Sor2RxWE6ic76IeQO99nngKVTSj3XdjDEomn4mK0pkRSanhOUQByc4AvgLa4Fc0VpYOmLgJA5wTAWiXjNdnwwPRE2WaXNLDIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378722; c=relaxed/simple;
	bh=psWv/GQWq/bwZDujqdjpK14Oh7RYTn3S4SaIUCbXiIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWtM9HTeU52FzUB4SJBMk8ylKOhIkJoD4SnemaPSxEcVrYPAoy7VAwoiWUwOGtxU3IDH8uQBYu0WL2bRvdDo3jAVRRAJ5lXTSUwTL4eSQYXTZTqrySgNjstntR/pKJ7RgJfUmGeeecZwDIZkfxdvYhBgtuh2Aey9meIfjOPHuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XN9GH1ZQGz1P9Yx;
	Tue,  8 Oct 2024 17:10:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2388F18005F;
	Tue,  8 Oct 2024 17:11:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Oct
 2024 17:11:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 2/2] net: lan743x: Remove duplicate check
Date: Tue, 8 Oct 2024 17:11:01 +0800
Message-ID: <20241008091101.713898-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008091101.713898-1-ruanjinjie@huawei.com>
References: <20241008091101.713898-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since timespec64_valid() has been checked in higher layer
pc_clock_settime(), the duplicate check in lan743x_ptpci_settime64()
can be removed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Update the commit message.
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


