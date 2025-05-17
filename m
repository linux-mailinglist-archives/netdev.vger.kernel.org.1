Return-Path: <netdev+bounces-191289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45218ABA97D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A03BDB48
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F51FBCAD;
	Sat, 17 May 2025 10:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AB1DE3A7;
	Sat, 17 May 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476343; cv=none; b=p2twzqdRDuqlqqeaMvvVpShi2nECwrTwr6MYKWxD63htfRd10ssuYvfaH9z2ONs7+hoISCqjdDmVIu/f4Ko2qIOKGqc7m0CR5nuQkoV/XX8roKbBOZObDFbZlZv9Lj7QKiAz329TYn4jxkQy7PP5EN9uS7XnxmJTkMo3zsKB0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476343; c=relaxed/simple;
	bh=UsSwFBDrySJeMYD2W3ZWiMg6HKjef9gtT0B7FoT7WHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQQd4FW4Jh1Gwp2r7sBoXBF3kI9g+IvbP5lNDrFPGCO15IpLrmg7PoFaH5u8mCpx8BMh4AMk9wGzZ//z4QatwGDTbvAFHR2a1L8m6PRYO1vqSsS+oLPPsuPKfiR7gappuzl3YUFH4eFshlLNrgClViGIOjP5fAwhHmLRf/ZAhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4b000p3mRWz1f1f7;
	Sat, 17 May 2025 18:04:26 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 745D71A016C;
	Sat, 17 May 2025 18:05:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 May 2025 18:05:13 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net 0/2] There are some bugfix for hibmcge driver
Date: Sat, 17 May 2025 17:58:26 +0800
Message-ID: <20250517095828.1763126-1-shaojijie@huawei.com>
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

There are some bugfix for hibmcge driver

---
ChangeLog:
v1 -> v2:
  - Use netif_device_detach() to block netdev callbacks after reset fails, suggested by Jakub.
  v1: https://lore.kernel.org/all/20250430093127.2400813-1-shaojijie@huawei.com/
---

Jijie Shao (2):
  net: hibmcge: fix incorrect statistics update issue
  net: hibmcge: fix wrong ndo.open() after reset fail issue.

 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 16 ++++++++--------
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c |  3 +++
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.33.0


