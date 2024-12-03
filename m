Return-Path: <netdev+bounces-148555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835D9E2741
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB66B624B5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B61FAC5C;
	Tue,  3 Dec 2024 15:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1891F8AE4;
	Tue,  3 Dec 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238504; cv=none; b=FXGe816dkJhLM2XCPIaTQEqQRL6vjpsvHtYDNDYZMe6HctgjF2xLvOMX1g/rSnKiR0pBH279thn8QRS0tOYXcBJb9oA8DAqkn1uanIAPTEZdHYiGOErp8OhJ5PhVxj4MVZoS7eBMDrAcNMKVnS7eK1+a9jWhkSr2VZ9mWvpI+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238504; c=relaxed/simple;
	bh=N0AzwUIyR99bpAq7HE4OJDukn/F0lqB3Hwd3aj3llxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LwyC+GRwNqG4jGHmex1cqIZ339kOK21EwS70Qx2hnzsbM0lKnfOIpTN0ZaZ6jN8XgcMncwNflN93b0HsiyG2h9Mi0PjnfAY2Iqx9G6lGgi6OSq01K2/dBVqCduMduBt58LcmZ7t1oMKLZ4PlEQyKPwje0XiycIGkYyuTIS8WX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y2kYm6K9Nz1yr36;
	Tue,  3 Dec 2024 23:08:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6376C140138;
	Tue,  3 Dec 2024 23:08:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 23:08:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V4 RESEND net-next 0/7] Support some features for the HIBMCGE driver
Date: Tue, 3 Dec 2024 23:01:24 +0800
Message-ID: <20241203150131.3139399-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In this patch series, The HIBMCGE driver implements some functions
such as dump register, unicast MAC address filtering, debugfs and reset.

---
ChangeLog:
v3 -> v4:
  - Support auto-neg pause, suggested by Andrew.
  v3: https://lore.kernel.org/all/20241111145558.1965325-1-shaojijie@huawei.com/
v2 -> v3:
  -  Not not dump in ethtool statistics which can be accessed via standard APIs,
     suggested by Jakub. The relevant patche is removed from this patch series,
     and the statistically relevant patches will be sent separately.
  v2: https://lore.kernel.org/all/20241026115740.633503-1-shaojijie@huawei.com/
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

Jijie Shao (7):
  net: hibmcge: Add debugfs supported in this module
  net: hibmcge: Add irq_info file to debugfs
  net: hibmcge: Add unicast frame filter supported in this module
  net: hibmcge: Add register dump supported in this module
  net: hibmcge: Add pauseparam supported in this module
  net: hibmcge: Add reset supported in this module
  net: hibmcge: Add nway_reset supported in this module

 .../net/ethernet/hisilicon/hibmcge/Makefile   |   3 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  34 +++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 165 ++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 +
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 137 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 181 +++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  48 +++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 241 ++++++++++++++++--
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  15 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  39 +++
 12 files changed, 866 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

-- 
2.33.0


