Return-Path: <netdev+bounces-133006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2149943CC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC69D1C2436E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956880604;
	Tue,  8 Oct 2024 09:12:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218045C0B;
	Tue,  8 Oct 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378721; cv=none; b=Q3Rw2SCfBD6J9WsYX9UH72vKQ7BmgTQfcQiiL6WBm/yFAAYvbdlMAnDs7WnBbUOf4bMyZR4z+D+roBSEDYb0MERQSsl+bfMWjmp3G0IzL+Lg2DtrPIYH/0BsiGls3FEtQ1rlTZX263y0LcAtYz1GSn8sz1MwGH3skqq4flY4qlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378721; c=relaxed/simple;
	bh=6DTbBsOR+oXg7v+Q3PYVclftc3J+E5upKSODCTV18NU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ba77BbH543BUVo7vVvA8OivM5kW496cAOa43mhajVPYd7USViRIfCu57+OVx5iF7oU6a8uH+b99Ut23uf+8lgbjCa3l3vuDhfEHdLcIHZdCoR1F4BlRQtzhG5QCnIhLWirHpRa7mtYivyI1DYf8Lfe2ytjSgV2WKAoC2GN6orBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XN9Fw3z22zpWgC;
	Tue,  8 Oct 2024 17:09:56 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AE5518005F;
	Tue,  8 Oct 2024 17:11:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Oct
 2024 17:11:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 1/2] posix-clock: Fix missing timespec64 check in pc_clock_settime()
Date: Tue, 8 Oct 2024 17:11:00 +0800
Message-ID: <20241008091101.713898-2-ruanjinjie@huawei.com>
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
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
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


