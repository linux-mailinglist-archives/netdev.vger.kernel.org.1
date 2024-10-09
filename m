Return-Path: <netdev+bounces-133471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486029960C1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085E72854A3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2481183CCA;
	Wed,  9 Oct 2024 07:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754617C9B8;
	Wed,  9 Oct 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458663; cv=none; b=BY5rEAM5AuYf1nz87VlI+HJLzL2ksyfCFjSUciM5Q/wbmopzl5uqL8Y41dK2ru37ttQQS4urtW3uvuL4MYKobPzJjfdwtnRfvT7U26iDm+Mp8gVTWJ96G6tufdjqd4O7Y6xqpC1e/TfvYGyMlRvy6B6WOLrafwW5REm/egCpXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458663; c=relaxed/simple;
	bh=O96UbTEsoJPPX4U/aIemGDnuhCKWsVXkJYZ65ZRSlRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huWeCbiB8zSxC/4EpGK2sAm6PcOyLn9reBpBcfCWtpxk3CpJWdw5eBMgt4ooLid4YrTuhQoLjJ7TjHoRwHoMAyJqVlmwhluEEHnzFB0qG8iYjcyza1bZ1isNrRdDvkyjs/xt3QNqMuH6zWWiZHpf8dQA+y3wR1zxE61FrVzDOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XNkrL05HLz2DdHn;
	Wed,  9 Oct 2024 15:23:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 162DA140134;
	Wed,  9 Oct 2024 15:24:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Oct
 2024 15:24:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <jstultz@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check in pc_clock_settime()
Date: Wed, 9 Oct 2024 15:23:01 +0800
Message-ID: <20241009072302.1754567-2-ruanjinjie@huawei.com>
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

As Andrew pointed out, it will make sense that the PTP core
checked timespec64 struct's tv_sec and tv_nsec range before calling
ptp->info->settime64().

As the man manual of clock_settime() said, if tp.tv_sec is negative or
tp.tv_nsec is outside the range [0..999,999,999], it should return EINVAL,
which include dynamic clocks which handles PTP clock, and the condition is
consistent with timespec64_valid(). As Thomas suggested, timespec64_valid()
only check the timespec is valid, but not ensure that the time is
in a valid range, so check it ahead using timespec64_valid_strict()
in pc_clock_settime() and return -EINVAL if not valid.

There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
write registers without validity checks and assume that the higher layer
has checked it, which is dangerous and will benefit from this, such as
hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
and some drivers can remove the checks of itself.

Cc: stable@vger.kernel.org
Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v5 -> resend
- Add Acked-by.
- Also Cc John Stultz.
v5:
- Update the commit message.
- Use timespec64_valid_strict() instead of timespec64_valid()
  as Thomas suggested.
- Add fix tag.
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
index c2f3d0c490d5..316a4e8c97d3 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -318,6 +318,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
-- 
2.34.1


