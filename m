Return-Path: <netdev+bounces-240940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE34C7C526
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 04:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E454E23A0
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BA15687D;
	Sat, 22 Nov 2025 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i0uVyuiy"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BA21348;
	Sat, 22 Nov 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763783262; cv=none; b=VqlrdjZdaQ07GDmeFg3hRC7jczwn13LOBatK0Lx8bBJ7a0B4sVcZIkR4C8XfrDj1SGOd+GGy/OjswzGyK76VRGHi4JTHqfTGcRNr07pfJvvrqh2oyMCvD6AhdxwMcKr6uhe9M6b3A5URj6IOfa9yDK9UeMgX6dTv9kepCdXn7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763783262; c=relaxed/simple;
	bh=Ry3qDoeSwDTYNNzL6LksSM7VDQONNPexEav1hxMV6aA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VO7+47ENWzjZcaqkH+mRLDx0GBNs4LT0sMtuBSXqExfiWBLh4m87GP/TXwxDvxJEIOKT/3NYM5nmoyUfig25BkOiCH+tuFHVjHQhpJHc4vUy9DYW7eZ9BBBe4AD59F0EsEPm7bzcDaAImRoS7dDsmpnXAlw0ZbEbJKDApFqiVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i0uVyuiy; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+lOHELWdx695iEO11uBHGV51YZkXb7rXQJts9MWmWng=;
	b=i0uVyuiyJnNrj6fXacy/jP0QoXO3uj7EdxCtmofMw1FlZoGtx9Qxt/q16NJ8yvY9QmVVoeER1
	dupmX5gRnBmQJ2CChl5ALsglmDP6DMowULKU9QhJtr7kwmLesFKAVnhGuFlZMpBnEIYlJGDrNQ/
	ptspOvAWPCIHtpxYIwc0f9M=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dCyfJ5Ld0zcb3Y;
	Sat, 22 Nov 2025 11:45:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FF2D1401F2;
	Sat, 22 Nov 2025 11:47:36 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Nov 2025 11:47:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 0/3] net: hibmcge: Add support for tracepoint and pagepool on hibmcge driver
Date: Sat, 22 Nov 2025 11:46:54 +0800
Message-ID: <20251122034657.3373143-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In this patch set:
1: add support for tracepoint for rx descriptor
2: double the rx queue depth to reduce packet drop
3: add support for pagepool on rx

---
ChangeLog:
v1 -> v2:
  - remove the legacy path after using pagepool, suggested by Jakub.
  v1: https://lore.kernel.org/all/20251117174957.631e7b40@kernel.org/
---

Jijie Shao (2):
  net: hibmcge: reduce packet drop under stress testing
  net: hibmcge: add support for pagepool on rx

Tao Lan (1):
  net: hibmcge: add support for tracepoint to dump some fields of
    rx_desc

 drivers/net/ethernet/hisilicon/Kconfig        |   1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   4 +
 .../ethernet/hisilicon/hibmcge/hbg_trace.h    |  84 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 217 ++++++++++++++----
 6 files changed, 272 insertions(+), 43 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h

-- 
2.33.0


