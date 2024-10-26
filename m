Return-Path: <netdev+bounces-139317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365649B17BC
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F039F281AD1
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39F1D45F2;
	Sat, 26 Oct 2024 12:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD779C2;
	Sat, 26 Oct 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944258; cv=none; b=cdou1yNoSLeL8qu/g0/8u/+Eb/JcaD2qZO8w9w3NWScELpQ5fEmmvTS878BO/HiQyXIIv2F7EEOhplenVbU5W57xsbvE4QPdoZgbhN3hmSofP7NgPUdBHCdXDUtWcTFkjmMUZu8yGTG3sqkGg5nDkDvW1YNJ/AYEtvMiLY82SVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944258; c=relaxed/simple;
	bh=XGk6e6SVSaatywr66aklpO7qXv6RRauDBSaidoum9Kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIyzBiZbI38i6VgHJim7ALu6n+dEtwmBx/sae5RMqYPczI66Nq3c9VMWVJPvMH1c0QrBvgf6shJkRNH/2AmjUgwiPeAanxyz1w+igQTFNMxOdCarPZ4PCxoXmtDNVCki0qk7V1pVtsBE0sH+0/KQonXH/geN49C0WyXXOvdo45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XbJ9b6T0Tz1HKy8;
	Sat, 26 Oct 2024 19:59:47 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 2746E14010D;
	Sat, 26 Oct 2024 20:04:12 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 20:04:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net-next 0/8] Support some features for the HIBMCGE driver
Date: Sat, 26 Oct 2024 19:57:32 +0800
Message-ID: <20241026115740.633503-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

In this patch series, The HIBMCGE driver implements some functions
such as statistics query, dump register, unicast MAC address filtering,
debugfs and reset.

---
ChangeLog:
v1 -> v2:
  - Remove debugfs file 'dev_specs' because the dump register
    does the same thing, suggested by Andrew.
  - Move 'tx timeout cnt' from debugfs to ethtool -S, suggested by Andrew.
  - Ignore the error code of the debugfs initialization failure, suggested by Andrew.
  - Add a new patch for debugfs file 'irq_info', suggested by Andrew.
  - Add somme comments for filtering, suggested by Andrew.
  - Not pass back ASCII text in dump register, suggested by Andrew.
v1: https://lore.kernel.org/all/20241023134213.3359092-1-shaojijie@huawei.com/
---

Jijie Shao (8):
  net: hibmcge: Add dump statistics supported in this module
  net: hibmcge: Add debugfs supported in this module
  net: hibmcge: Add irq_info file to debugfs
  net: hibmcge: Add unicast frame filter supported in this module
  net: hibmcge: Add register dump supported in this module
  net: hibmcge: Add pauseparam supported in this module
  net: hibmcge: Add reset supported in this module
  net: hibmcge: Add nway_reset supported in this module

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   3 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 135 +++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 167 ++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 140 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 357 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  48 ++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 276 ++++++++++++--
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 136 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 171 ++++++++-
 13 files changed, 1434 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

-- 
2.33.0


