Return-Path: <netdev+bounces-125771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED296E854
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6809F286733
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D244C86;
	Fri,  6 Sep 2024 03:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759845C1C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593977; cv=none; b=q1usQACdK3WuO0l5wmmN9BrB0oAi6fmfJYJZmFaDi3tXnahNKFHJZTMOHdz8hbdGtyhCwCckX1dI/hUPN+aSghVDPEMuVoZzFOW2CJQIQjfzdYIgH3xfbYDF6RG4jgvJfQ+pQ0f0jCWv9rt0tjZ4vUhPMcWkEwsHM9DW3h23Lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593977; c=relaxed/simple;
	bh=GsIfNrFAElATKdcwqh3g+pkbT4FBJvYPjJvbxEUpZ6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MH71qW7U5m7NStGkGMIJm8L+wXrqMVLIaE9uc42uMp0Z7NhSUMEEqrq9Z6CmOkH775Z9/8HmP/7+RIiALP5eWiJC8c00hwFACWrKJDD3Jl3eQwOXxz4ffxX0TFcSIUqn4vH29TB2M/ZIKLuCSbcCZ1g0kNol33lD8N7nYxtpOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0MQw4cxNz1j8Ck;
	Fri,  6 Sep 2024 11:39:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E54A81402CD;
	Fri,  6 Sep 2024 11:39:26 +0800 (CST)
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
Subject: [PATCH -next v2 0/2] ptp: Check timespec64 before call settime64()
Date: Fri, 6 Sep 2024 11:48:04 +0800
Message-ID: <20240906034806.1161083-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Check timespec64 before call settime64() to make sence.

Jinjie Ruan (2):
  ptp: Check timespec64 before call settime64()
  net: lan743x: Remove duplicate check

 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 drivers/ptp/ptp_clock.c                      | 10 ++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.34.1


