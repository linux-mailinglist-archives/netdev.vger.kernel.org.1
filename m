Return-Path: <netdev+bounces-128324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B3978FB0
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA78AB2315B
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E311CEAAB;
	Sat, 14 Sep 2024 09:57:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889813342F;
	Sat, 14 Sep 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307839; cv=none; b=TvpSx/zsmJSRhrJCKy8sbPu5bpx/+VGD83iA0/VHi8+X+cxI64UpM/Idbi18fcDAlq+MIsXe9uEgTJ0yElidf1ouAL+NJedjG2ayjCQdTES85pumJyZPiYKb+gjPS0Z7m+xOtj4QKF77zZWSoJyxxvKI0rW8i5IsvRsQS8luXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307839; c=relaxed/simple;
	bh=IZEtHSHRUq415LX1d2WkcZIdqQHzOZ2GrsODRstWenQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gN0EdWwgCDHnUnhJnTH1E9r82jxcHFFceHc7k+KIPK10k73ynUaBRvunKbuxsXbuJDa/3z/j1/8vkxKGqmw4UWOsFO+TyNfrYovTN4GUxrLAHdNtXCg0uyL8CxAW7p8V9ym9wKoCCblDrmOFY9Nq1ADUTMP3fCsFtArvglGqm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X5RQd2wqKzyRxT;
	Sat, 14 Sep 2024 17:56:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E39018006C;
	Sat, 14 Sep 2024 17:57:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 17:57:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>,
	<jstultz@google.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v4 0/2] posix-clock: Check timespec64 for PTP clock
Date: Sat, 14 Sep 2024 18:06:23 +0800
Message-ID: <20240914100625.414013-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Check timespec64 in pc_clock_settime() for PTP clock.

Changes in v4:
- Check it in pc_clock_settime() for PTP clock.
- Update the commit message.

Changes in v3:
- Check it before call clock_set().
- Update the commit message.

Jinjie Ruan (2):
  posix-clock: Check timespec64 before call clock_settime()
  net: lan743x: Remove duplicate check

 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 kernel/time/posix-clock.c                    |  3 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.34.1


