Return-Path: <netdev+bounces-211891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF3B1C468
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AF518A87A7
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FFD28A726;
	Wed,  6 Aug 2025 10:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77628B7E5;
	Wed,  6 Aug 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476523; cv=none; b=MfDeiOWBoEl/LCTs5kR3uoMYpAy2FCYif/TflpKKRl1eRJMBaqtTGNxQvT3d07XJAU+VnmXdTBK5/xfJPnYzfoCdXDteIt4lMm/trtrhN0VTCKrIiJPCT5S/PVq+QrobrHy4DW4sl1/ziqv5LeUKVPqSNvsSxj8DMV//1aJRw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476523; c=relaxed/simple;
	bh=eug1EX83YhP5DoRdi3jIIJv2lkC90vAIfdJ12++J9uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSTeGPa6wutlRTK9vlEt6zHaLeXrjcZ24BphPs9YP92OzePFXQsWCX/hzlkZ6a2L3QbAqzK1fL/lV8p4rkVyxjv6AqG2X7TGk0V0Q3YjSbFh3h4VgZz0Kncn08uRdeosh//S3Lne28fGBPidpLaTodeUJFELJcoNeRd4DERT0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bxmlz52D3z2Cfq6;
	Wed,  6 Aug 2025 18:30:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C7B6180044;
	Wed,  6 Aug 2025 18:35:12 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 18:35:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 0/3] There are some bugfix for hibmcge ethernet driver
Date: Wed, 6 Aug 2025 18:27:55 +0800
Message-ID: <20250806102758.3632674-1-shaojijie@huawei.com>
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

This patch set is intended to fix several issues for hibmcge driver:
1. Holding the rtnl_lock in pci_error_handlers->reset_prepare()
   may lead to a deadlock issue.
   2. A division by zero issue caused by debugfs when the port is down.
   3. A probabilistic false positive issue with np_link_fail.

---
ChangeLog:
v2 -> v3:
  - Use READ_ONCE() to read temporary variable, suggested by Jakub Kicinski
  v2: https://lore.kernel.org/all/20250805181446.3deaceb9@kernel.org/
v1 -> v2:
  - Fix a concurrency issue for patch1, suggested by Simon Horman
  v1: https://lore.kernel.org/all/20250731134749.4090041-1-shaojijie@huawei.com/
---

Jijie Shao (3):
  net: hibmcge: fix rtnl deadlock issue
  net: hibmcge: fix the division by zero issue
  net: hibmcge: fix the np_link_fail error reporting issue

 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c  | 14 +++++---------
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 15 +++++++++++++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  7 ++++++-
 3 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.33.0


