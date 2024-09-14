Return-Path: <netdev+bounces-128326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBF978FB3
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E990C1F23940
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6471CEACF;
	Sat, 14 Sep 2024 09:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE791448C5;
	Sat, 14 Sep 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307840; cv=none; b=KesvaZOHSREZaRduYkQOoY7u6DDj93gcdKO4Wej1w7Vh77N7wmh1mG+NCspi1LxdDK6hz3Y7BBlOo9J/1radxE//1eKt+oKsUFS0NaUMPuXGqyY1GjxlOnvhLsqVOSFwdeZCo9tKqGiw9E0ehuNMQQiaUOE7IZCAmFYsGBTZkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307840; c=relaxed/simple;
	bh=bExolXvkJwwhhylCHDxGsUjYZWzbgOCGMqAZeN/sitk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts5wO5IJ7O1Svqa6DDOsxCBhxvDsdPzkijeUue8WQX4WZUwjf60ry+NzENNx06vC+e+rGwmOI1vsW1xhCQhStoH2+HeeoAcOSMv8fqQ9nAT5Ar4nmHUvioIkJVKwKu6q5pb6jcmuD7e97eu7NKAnA7uA06PuWB7vu/TAFS2ml+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X5RQx5ljyz2CpTV;
	Sat, 14 Sep 2024 17:56:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EBCC914037D;
	Sat, 14 Sep 2024 17:57:14 +0800 (CST)
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
Subject: [PATCH -next v4 1/2] posix-clock: Check timespec64 before call clock_settime()
Date: Sat, 14 Sep 2024 18:06:24 +0800
Message-ID: <20240914100625.414013-2-ruanjinjie@huawei.com>
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

As Andrew pointed out, it will make sense that the PTP core
checked timespec64 struct's tv_sec and tv_nsec range before calling
ptp->info->settime64().

As the man mannul of clock_settime() said, if tp.tv_sec is negative or
tp.tv_nsec is outside the range [0..999,999,999], it shuld return EINVAL,
which include Dynamic clocks which handles PTP clock, and the condition is
consistent with timespec64_valid(). So check it ahead using
timespec64_valid() in pc_clock_settime() and return -EINVAL if not valid.

There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
write registers without validity checks and assume that the higher layer
has checked it, which is dangerous and will benefit from this, such as
hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
and some drivers can remove the checks of itself.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Check it in pc_clock_settime().
- Update the commit message.
v3:
- Adjust to check in more higher layer clock_settime().
- Remove the NULL check.
- Update the commit message and subject.
v2:
- Adjust to check in ptp_clock_settime().
---
 kernel/time/posix-clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 4782edcbe7b9..89e39f9bd7ae 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -319,6 +319,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
-- 
2.34.1


