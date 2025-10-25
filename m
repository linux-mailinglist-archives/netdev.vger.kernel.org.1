Return-Path: <netdev+bounces-232741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3979C0882F
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 566CE4E71BE
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3CB2264CA;
	Sat, 25 Oct 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GUm02yiV"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077842236EE;
	Sat, 25 Oct 2025 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761356851; cv=none; b=FqwLL3mnd8qvc4uyHSaT9NPzVYIUAV6AxpcG6HYmnwmQGo6w7appeSHjfTyYcjp2H5tbrOoF79sDPKPXaxknlfyhzwkRcPpIMOJbxnyRtB2YvU6CGQbqK7i6ESBhRPlUpAjuZQq1LzvBY9Ap2ZSQLn5EEPzfZMv6BvSLXNac7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761356851; c=relaxed/simple;
	bh=78xw9ZqirWqc7NsBNoGHDvBdpZtr3R0MlLEWL8nwRT0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzK2h93wc5PowXXOJeqC0uWvQzdqGjaaDbqbuUV69PgSjAvEIgG07vbU3VmFSuhXvbR6HTAfKLWE6L3L83wuRC6Jcxo/wbLbcemmPEbcUNKIxQs3AaoGgqCJ9qhz2V9P9DtPR4j6Qnk8TRJTXELeLsfRcs6dXwD4myjX0iURJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GUm02yiV; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=43GsLi/CsHNPljqzQY2QbPHejQoiUn9vNYxpN0QBY5k=;
	b=GUm02yiVAh9+PRzDggb8XrVW3GlPcN8ML40mLQb9yFFQGP5b4ssSgfq7pRweKrgJPWExfDVgZ
	ymD06TM25BWa6FSDOj6p6ybN3Jpm5CIQj0y8bc/8BY3GKbON56A12QkvsVeKLeDfvUzMHzMdrhd
	jb3QF3UmOWwlNy9W+I3Ht0s=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4ctjL90bLqz12LJn;
	Sat, 25 Oct 2025 09:46:41 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B976B140279;
	Sat, 25 Oct 2025 09:47:20 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 09:47:20 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jacob.e.keller@intel.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 0/3] bug fixes for the hibmcge ethernet driver
Date: Sat, 25 Oct 2025 09:46:39 +0800
Message-ID: <20251025014642.265259-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch set is intended to fix several issues for hibmcge driver:
1. Patch1 fixes the issue where buf avl irq is disabled after irq_handle.
2. Patch2 eliminates the error logs in scenarios without phy.
3. Patch3 fixes the issue where the network port becomes unusable
   after a PCIe RAS event.
   
---
v1 -> v2:
  - add more details in commit log for patch1 and patch3.
  v1: https://lore.kernel.org/all/20251021140016.3020739-1-shaojijie@huawei.com/
---

Jijie Shao (3):
  net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
  net: hibmcge: remove unnecessary check for np_link_fail in scenarios
    without phy.
  net: hibmcge: fix the inappropriate netif_device_detach()

 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c    | 10 ++++++----
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     |  3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c    |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   |  1 -
 5 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.33.0


