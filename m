Return-Path: <netdev+bounces-133472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08259960C3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E581F21C5B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47828185B69;
	Wed,  9 Oct 2024 07:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA017CA17;
	Wed,  9 Oct 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458664; cv=none; b=e0BngkvSY7WFvsAyjZRcf6d1CQsygF0mVUo1o+4/DsEIU+JeY5TwZysClwUplMLnTmR8tGxrYXE1Mj1fqiSbE9245aJN/9KuRrwVARlaRHirelMClcTPRvlG3UcaFlaW4u9++jLKCm6CDDMk4bK8woVikpJznIfKqSl1hg2cxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458664; c=relaxed/simple;
	bh=4T99RvwuCjhQmYqT6+qr/kE99JxKL65Mc53QM88Ti4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzMmeWV7mqGSqSttJd78S9sWPvwsbJy9VuQznl1Ij7CA6N0P97JwG59p9Sze8uho8LK2cjivuuU/eMJNd4qfkMvb0aoHZvX1wi4fFbmAbdqMAbNklccKg+HD3tEou4U+ggLkXM+Zo/myPBBfMsgRdtuS7WrFM1gjXW/RY7ovsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XNkrM0rghz2DdK3;
	Wed,  9 Oct 2024 15:23:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FD8C140134;
	Wed,  9 Oct 2024 15:24:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Oct
 2024 15:24:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <jstultz@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 RESEND 2/2] net: lan743x: Remove duplicate check
Date: Wed, 9 Oct 2024 15:23:02 +0800
Message-ID: <20241009072302.1754567-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009072302.1754567-1-ruanjinjie@huawei.com>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since timespec64_valid() has been checked in higher layer
pc_clock_settime(), the duplicate check in lan743x_ptpci_settime64()
can be removed.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v5-> resend
- Add Acked-by.
- Also Cc John Stultz.
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


