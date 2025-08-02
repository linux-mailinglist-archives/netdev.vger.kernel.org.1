Return-Path: <netdev+bounces-211460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F25B18E74
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E9DAA3663
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDB23497B;
	Sat,  2 Aug 2025 12:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AE227E80;
	Sat,  2 Aug 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138401; cv=none; b=JSlZyfGi3pD/UdGPjSvhQbAmPHFrr2AED1sCSknZQLA6XiWUi8o/AvfWpMUaQRTQzOWcAMmrT/a2y+n2b3wRTowB3PDfi0E+52usHu2lElp0fnow/MFbSpzu/x2wn8J3s9NeRjGAyJCBVlO5aKanjxXUeYPCVdemFJWf/30WpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138401; c=relaxed/simple;
	bh=Eg3zeCbFOh6SREIl5ejV6ktPPQzFQ+5dby6FlCRAjso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FNsTEGkpmF+mMZas7x7YqNNVXRoapYHtA0ijOjo4ttTqS7IZz+ThrxsRLzl9D715xMJdxlpRvogPazwTvXbpkQT3MYtAE8gYaqZlkhoSoJmJ1QcC7JX4hazKezXrdim0f5uyRVhMGcTV0B85uMtYaNlZRS6Gs8j6dciWf9/9xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bvMjl2Tjwz2CfZh;
	Sat,  2 Aug 2025 20:35:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B9621A0188;
	Sat,  2 Aug 2025 20:39:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 2 Aug 2025 20:39:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 0/3] There are some bugfix for hibmcge ethernet driver
Date: Sat, 2 Aug 2025 20:32:23 +0800
Message-ID: <20250802123226.3386231-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch set is intended to fix several issues for hibmcge driver:
1. Holding the rtnl_lock in pci_error_handlers->reset_prepare()
   may lead to a deadlock issue.
2. A division by zero issue caused by debugfs when the port is down.
3. A probabilistic false positive issue with np_link_fail.

---
ChangeLog:
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
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h |  3 +++
 3 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.33.0


