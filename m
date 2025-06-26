Return-Path: <netdev+bounces-201385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E74BAE93E5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9675A4B57
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E601CAA79;
	Thu, 26 Jun 2025 02:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C171BC9F4;
	Thu, 26 Jun 2025 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903983; cv=none; b=OYp6j+0BorMRoCEDACft2KN558qqSExo9JsN/x+Ybd2TqILBsv3dfS70VIXkpRoildjaR5eL/jQwSFtPCkkptRJpiao4t6WlEQa4wzWYH433aagGr4ONL8fky3li9yev9VvEj9/bk35wzH7eQzkerouHHRpT2/m5Ajo4z76HS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903983; c=relaxed/simple;
	bh=Ni+L1bRR+Fb+tAN9EZBMNNGO3y7Hf10H4g/51esIW0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LC9/YchZYBl2ZxaaKB3Cq6RQxFyA2Vhn8LrZOWmJX3RCTY9cvfVHqukZdgrud7qIejSX+K7BaXxB8jKRWAtL25QcI6mLPYpQouJ97tYkNocwRaXDaw9NW7EBFROW0u5hn9G46bsw6oCl+afRqgvSkq5wwvW+scCAtkXPEPCKZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bSMcS3Tswz2BdVJ;
	Thu, 26 Jun 2025 10:11:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 36E8D140109;
	Thu, 26 Jun 2025 10:12:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 10:12:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v3 net-next 0/3] Support some features for the HIBMCGE driver
Date: Thu, 26 Jun 2025 10:06:10 +0800
Message-ID: <20250626020613.637949-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Support some features for the HIBMCGE driver

---
ChangeLog:
v2 -> v3:
  - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
  v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
v1 -> v2:
  - Fix code formatting errors, reported by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/
---

Jijie Shao (3):
  net: hibmcge: support scenario without PHY
  net: hibmcge: adjust the burst len configuration of the MAC controller
    to improve TX performance.
  net: hibmcge: configure FIFO thresholds according to the MAC
    controller documentation

 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 57 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 38 +++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  8 +++
 3 files changed, 103 insertions(+)

-- 
2.33.0


