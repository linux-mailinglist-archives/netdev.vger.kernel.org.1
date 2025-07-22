Return-Path: <netdev+bounces-208940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99078B0DA6D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8596169E1A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387E2E9EB1;
	Tue, 22 Jul 2025 13:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE428C2DE;
	Tue, 22 Jul 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189302; cv=none; b=AU79KF67AoIIu2FV9gHYL7jyPxAL88c0rTKQseiwjMUFOYnsaNOBwZOMAlEpksdOBkSEiUj9lHYUx6aXhZW3vXO3jO6l6xWjm7gBvz8DcMhjygpJEGONOtVbBBu4AHresQCF/KvHjjWRiWfqurgJ9IgP0tq6pD2/2kC0BvKQLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189302; c=relaxed/simple;
	bh=x3ST585+9Q0bgAI/ftBoqhybhQK0Pieo1wn9bMm+NqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nn4jr866ndSxs3qFuFvxuSNICx3D1GBjZKhUgDph6MVC4vXdIrBWia81P9L9ZSntmriZl3UcMcPzJUeWGgsRfb2PMwW/YLAITEYolA4K53ZVTS8dJ4Qdo8oUR7If8/auTcWOgXN1Ca+dR8i1a0ajP5UlXiUW+FFV8jlaCbLjMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bmcjx5qTtzdc29;
	Tue, 22 Jul 2025 20:57:25 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C7C61140202;
	Tue, 22 Jul 2025 21:01:35 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 21:01:34 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet driver
Date: Tue, 22 Jul 2025 20:54:19 +0800
Message-ID: <20250722125423.1270673-1-shaojijie@huawei.com>
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

There are some bugfix for the HNS3 ethernet driver

---
ChangeLog:
v1 -> v2:
  - Fix wrong Fixes tag, suggested by Simon Horman
  - Replace min_t() with min(), suggested by Simon Horman
  - Split patch4, omits the ethtool changes,
    ethtool changes will be sent to net-next, suggested by Simon Horman
  v1: https://lore.kernel.org/all/20250702130901.2879031-1-shaojijie@huawei.com/
---

Jian Shen (2):
  net: hns3: fix concurrent setting vlan filter issue
  net: hns3: fixed vf get max channels bug

Jijie Shao (1):
  net: hns3: default enable tx bounce buffer when smmu enabled

Yonglong Liu (1):
  net: hns3: disable interrupt when ptp init failed

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 ++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 36 +++++++++++--------
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  9 +++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +---
 5 files changed, 61 insertions(+), 23 deletions(-)

-- 
2.33.0


