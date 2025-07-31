Return-Path: <netdev+bounces-211205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C6B17291
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298CB1AA06BE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977F2D12EF;
	Thu, 31 Jul 2025 13:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F32D0C82;
	Thu, 31 Jul 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970122; cv=none; b=Zv91zt+jLosXdRYN5Tq3bgu0G+I2BOABFuI7NzAldHp/W1lricVDWNb+FEdKy6L7W8QAqEO4QLnE5BBqW5UCgY0H82NAdgcBjUp48Q1HZaBFGm54lYvVr0Ron6/43GgkoYlS4ALlQ4M8pGlzpOP37gyAlD28jH7MKBHQ8SM59Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970122; c=relaxed/simple;
	bh=xFJC9FfhPYR+V/mzUi/sw+Ke0NvLlb+afnYUIfS0k1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQSjOcQ6LhAIQaLByWzoaSr/5UsYtSAmsshrz8EOoHCX1LLH9xP573AOtEFmFnLsDB34c9TdKJ7mu/fBhJHJuF9sWksrPeqD+cALClbHy8njem0hpzAv7RSZTBP4KPca7hVW3jbie8FwrmvvCPYH3xmC3R/4wSLKoU4z7u9kJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bt9St5hwbz14M7j;
	Thu, 31 Jul 2025 21:50:22 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 68123180B51;
	Thu, 31 Jul 2025 21:55:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Jul 2025 21:55:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 0/3] There are some bugfix for hibmcge ethernet driver
Date: Thu, 31 Jul 2025 21:47:46 +0800
Message-ID: <20250731134749.4090041-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch set is intended to fix several issues for hibmcge driver:
1. Holding the rtnl_lock in pci_error_handlers->reset_prepare()
   may lead to a deadlock issue.
2. A division by zero issue caused by debugfs when the port is down.
3. A probabilistic false positive issue with np_link_fail. 

Jijie Shao (3):
  net: hibmcge: fix rtnl deadlock issue
  net: hibmcge: fix the division by zero issue
  net: hibmcge: fix the np_link_fai error reporting issue

 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c  | 13 ++++---------
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 15 +++++++++++++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  3 +++
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.33.0


