Return-Path: <netdev+bounces-126393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547B970FE8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A68B20F99
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2E1AF4DC;
	Mon,  9 Sep 2024 07:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B21AE856;
	Mon,  9 Sep 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867156; cv=none; b=DrgGyp5W+EE3PhAIRJeKgv1OWQyRQDeUAOXPnxHK4hUnSpetWIs4/q88pKuvbCGmAqTRWzsQ7+9RN/8wv1jpX719f+dUQJbeUBhtwKggQDys1CZMPqa2p+0wnfXhTe1jTYrKQEwfymTI9BTmYJaxqjOOAnTSUsky4QChMqaI+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867156; c=relaxed/simple;
	bh=L1BwsFi4gWp4XdMuHQhFGXObXKbisILfekiPuUvJ/Ts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsfU5Nl7vTeq3T9Feou478jjV/xYStJlObU4EmWqxFCRDNixUQHFSQhNpLTuB5kFXtGQeqV9J2DY5/zGARn6XiLGCVBCzmr5HWnLmwfREYgpOWTaXEzrQWcVh3zXI8aKPd1eZM0ApWNaxdCx1k+EuuTy2cFdZrafCEc9nxp/Hss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X2JSq0z49z69LR;
	Mon,  9 Sep 2024 15:32:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F05E21403D3;
	Mon,  9 Sep 2024 15:32:30 +0800 (CST)
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
Subject: [PATCH -next v3 0/2] posix-timers: Check timespec64 before call clock_set()
Date: Mon, 9 Sep 2024 15:41:22 +0800
Message-ID: <20240909074124.964907-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Check timespec64 before call settime64() to make sense.

Changes in v3:
- Check it before call clock_set().
- Update the commit message.

Jinjie Ruan (2):
  posix-timers: Check timespec64 before call clock_set()
  net: lan743x: Remove duplicate check

 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 kernel/time/posix-timers.c                   |  3 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.34.1


