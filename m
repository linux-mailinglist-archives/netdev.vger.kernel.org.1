Return-Path: <netdev+bounces-152063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB19F2933
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8031918880F4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AF1C54A5;
	Mon, 16 Dec 2024 04:13:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15C15359A;
	Mon, 16 Dec 2024 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322428; cv=none; b=NokwyVGOAJ0wDgr5rmPL8mxQTDNIE/xJQDSf77h3jlxHiTC3SaM+oXRqmwg9KxxNioNYdS6ZWr6nFuZeIPBZ8zD/Hc1mi/1zgKwkj88NwkMw0PX7nL2PHA59hDdMgVg8220Q9M+ZppHbOCIsj5C7/b2HLZOzzgq21421uJaOTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322428; c=relaxed/simple;
	bh=0NviE5omXh7bLJRQSNugHtzmum21WdBlyDlmIKBJ+MQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tB5J0Bj1e2g6H32esikc5OVH0qRJclfKVRLCYTRNlzCPkFEhcbsRCToM/IvdXZBsNasKVE5SwDO/S6AqmcFVnk3nGqmLaenf04OuduE/0dPUX46kUWBFEhvI2TFxdNIcnaLsVfALelFyAcok+rEZgiPsQsmrv9xfJ/G4nR1lg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YBRPm4gMsz1JFHm;
	Mon, 16 Dec 2024 12:13:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DBD241A0188;
	Mon, 16 Dec 2024 12:13:36 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 12:13:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V8 net-next 0/7] Support some features for the HIBMCGE driver
Date: Mon, 16 Dec 2024 12:05:25 +0800
Message-ID: <20241216040532.1566229-1-shaojijie@huawei.com>
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
v7 -> v8:
  - Use kernel public helper "str_true_false" instead of self-defined,
    suggested by Jakub.
  v7: https://lore.kernel.org/all/20241212142334.1024136-1-shaojijie@huawei.com/
v6 -> v7:
  - Optimize the wrapper name, suggested by Jakub.
  - Delete table_overflow to simplify the code, suggested by Jakub.
  v6: https://lore.kernel.org/all/20241210134855.2864577-1-shaojijie@huawei.com/
v5 -> v6:
  - Drop debugfs_create_devm_dir() helper, suggested by Greg KH.
  v5: https://lore.kernel.org/all/20241206111629.3521865-1-shaojijie@huawei.com/
v4 -> v5:
  - Add debugfs_create_devm_dir() helper, suggested by Jakub.
  - Simplify reset logic by optimizing rtnl lock, suggested by Jakub.
  v4: https://lore.kernel.org/all/20241203150131.3139399-1-shaojijie@huawei.com/
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
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  29 +++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 160 ++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.h  |  12 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  | 134 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_err.h  |  13 ++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 181 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  48 ++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 199 ++++++++++++++++--
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  15 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  39 ++++
 12 files changed, 811 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h

-- 
2.33.0


