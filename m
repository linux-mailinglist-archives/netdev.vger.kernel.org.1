Return-Path: <netdev+bounces-126394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72A970FEB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8868028153B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118751B013A;
	Mon,  9 Sep 2024 07:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB11AED44;
	Mon,  9 Sep 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867157; cv=none; b=S+BiqxefF2j7r62G7vxEgn9ZW9cfEHbKcRo/bHbM9Le7DsF36Ko9+IWE1hf2M0kf4K6/nnTxCyU6CMSVbPwKj4SwD1JD1fFsgzbsi+a8VGDRQuSi/2u1C8mSBg99eKzuifCwzzxE1XB7gqzL3JRiO9qyVVszdNMrrz6W1jFhQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867157; c=relaxed/simple;
	bh=44yXp+sP7M1cH2OOmMq345KHAgBHsVihNXy838Mz91w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFDyER5eumh9qZUOtozgf0CovzNCUwkPb2AfGLJ1Dj+MMiwmmdR9/4+mS6rAhqZbk5qMF4eDNWcXzgiWPGsLw9arzK2ljaK7zSZwj5kIUDQYcxpE+2xzEhH4PX7JHR3hE1simpE8JPz+bHfpNKf7VNwjEd7rGGiWBXyW+J+Xk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X2JQP6fKVzfbw1;
	Mon,  9 Sep 2024 15:30:21 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 762CB18007C;
	Mon,  9 Sep 2024 15:32:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 15:32:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>,
	<jstultz@google.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call clock_set()
Date: Mon, 9 Sep 2024 15:41:23 +0800
Message-ID: <20240909074124.964907-2-ruanjinjie@huawei.com>
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

As Andrew pointed out, it will make sense that the PTP core
checked timespec64 struct's tv_sec and tv_nsec range before calling
ptp->info->settime64(). Check it ahead in more higher layer
clock_settime() as Richard suggested.

There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
write registers without validity checks and assume that the higher layer
has checked it, which is dangerous and will benefit from this, such as
hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
and some drivers can remove the checks of itself.

Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Adjust to check in more higher layer clock_settime().
- Remove the NULL check.
- Update the commit message and subject.
v2:
- Adjust to check in ptp_clock_settime().
---
 kernel/time/posix-timers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cc830ef93a7..34deec619e17 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1137,6 +1137,9 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	if (get_timespec64(&new_tp, tp))
 		return -EFAULT;
 
+	if (!timespec64_valid(&new_tp))
+		return -ERANGE;
+
 	/*
 	 * Permission checks have to be done inside the clock specific
 	 * setter callback.
-- 
2.34.1


