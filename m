Return-Path: <netdev+bounces-125769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3E96E852
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5535D1F21EF4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9D38DD1;
	Fri,  6 Sep 2024 03:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362F1E521
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593973; cv=none; b=fGtQ3y4lSCC/V2LxtdXiXu6ioJ7WXlApD6nqqfLdoq+nN4I/uhT9KdD+cTnn46Sx/m4cgnm1TwzhsjkCeiNkmtdnjpVn/EUp4Q8t9s4pOlF5OkryQjq0tVWe03+pEd6QLmXrG6bRdwLVk2mgCrc+9EWEcNFKcanPxmwdNvuDHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593973; c=relaxed/simple;
	bh=2h4eUyrGBKe5MJjatNFE32Xqb9H4icCDQGksUXu4l6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2hhjHkWC8jhDzG1TY16ecaA0/275IsgtsqTwnKxoJJsUwDXa1XbaYVexkpRZSfIqb2CQDDS+pf4KIVMq01HmQe3RXYOa0w8pPc80Zi/qjtWBhsRGsRFYhBYlzOmpDFMk08rp/r2liFg0oXvM+t1o3pYYQjysTJG2zF2J20PFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X0MKb74J5z69Wd;
	Fri,  6 Sep 2024 11:34:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B76114064D;
	Fri,  6 Sep 2024 11:39:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 11:39:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 1/2] ptp: Check timespec64 before call settime64()
Date: Fri, 6 Sep 2024 11:48:05 +0800
Message-ID: <20240906034806.1161083-2-ruanjinjie@huawei.com>
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

As Andrew pointed out, it will make sence that the PTP core
checked timespec64 struct's tv_sec and tv_nsec range before calling
ptp->info->settime64(), so check it ahead.

There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
write registers without validity checks and assume that the PTP core has
been checked, which is dangerous and will benefit from this, such as
hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
and some drivers can remove the checks of itself.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/ptp/ptp_clock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..cf75899a6681 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -100,6 +100,16 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 		return -EBUSY;
 	}
 
+	if (!tp) {
+		pr_warn("ptp: tp == NULL\n");
+		return -EINVAL;
+	}
+
+	if (!timespec64_valid(tp)) {
+		pr_warn("ptp: tv_sec or tv_usec out of range\n");
+		return -ERANGE;
+	}
+
 	return  ptp->info->settime64(ptp->info, tp);
 }
 
-- 
2.34.1


