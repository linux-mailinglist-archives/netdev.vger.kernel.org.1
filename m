Return-Path: <netdev+bounces-133470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623879960BE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C7EB231F9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9817DFF1;
	Wed,  9 Oct 2024 07:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C03178CC5;
	Wed,  9 Oct 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458662; cv=none; b=P8scshNmUC7I8z4rITHnOmuA315yQNgoDA0+N+z/TYMctQBcFrM1PKxoEHGervlpsAGhIOcovDp6LVzbxAdFhJ2eDutk+d4NPGatL9LxhRTMOcQ9plkmrgmsLBtY1qCfXoJHrt3WRZwIcXvUF1f6e1WfV2w4/jiaGFUFonESYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458662; c=relaxed/simple;
	bh=E7Qrifk5KQQ3Q+LxLV8FxeEmNURwLkaI2/XTbKLqvRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pU7x9I78bp8rVGXND8EPrWyRCcS57bilD/NC4r3in9Srig6qmcNP/oHFj61ClSu3K64JNCsQAoD+K7Lt7cYU7ljbI8cmfs1kcLZGwfDjKpqVUWR6WTz4ldTlgXKAdGQSciXHNyi5uqY1ttPEgwBngF1u36R8kRCILYRjNUmHg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XNkqZ0BPVzZhkZ;
	Wed,  9 Oct 2024 15:22:34 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DEDE18009B;
	Wed,  9 Oct 2024 15:24:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Oct
 2024 15:24:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <jstultz@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 RESEND 0/2] posix-clock: Fix missing timespec64 check for PTP clock
Date: Wed, 9 Oct 2024 15:23:00 +0800
Message-ID: <20241009072302.1754567-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Check timespec64 in pc_clock_settime() for PTP clock as
the man manual of clock_settime() said.

Changes in v5 resend:
- Add Acked-by.
- Also Cc John Stultz.

Changes in v5:
- Use timespec64_valid_strict() instead of timespec64_valid()
  as Thomas suggested.
- Add fix tag.
- Update the commit message.

Changes in v4:
- Check it in pc_clock_settime() for PTP clock.
- Update the commit message.

Changes in v3:
- Check it before call clock_set().
- Update the commit message.

Jinjie Ruan (2):
  posix-clock: Fix missing timespec64 check in pc_clock_settime()
  net: lan743x: Remove duplicate check

 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 kernel/time/posix-clock.c                    |  3 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.34.1


