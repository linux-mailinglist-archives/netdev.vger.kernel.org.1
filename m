Return-Path: <netdev+bounces-206542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6DB036C5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1063B5F9F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EB5223324;
	Mon, 14 Jul 2025 06:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A41F3FDC;
	Mon, 14 Jul 2025 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473881; cv=none; b=PZ8/nmA9y9HRcpOLKOjVJdKIKrxvAw3T5PVY0yap9AIsY5AXcKBIP+PE070kNhsnamGmqgpzE7lal/JI+GvSTZFpbrZtjiG4gfyHKGX63lWWqBEuSVZnHih1PBTcRpa4fgJLsBgguo7BDc/8B+BzMp+kdOwYVe6I08SlQCjr72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473881; c=relaxed/simple;
	bh=lYLWk2KaW5wvorepRpTMHvGmk+PoCEyOt8Ebsl/+kzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jM3FLobtMaIj9Nwu4dUlWg5y7zC4wCKP6cHELq2LJaw7tN4/ncQjCphLlrSjxKYEjTOHiIm2NoW1kUwLVEcU4ydg6S50ZA7ZSU/XGA8TMY80e7379uTPGUx2cnaNi15zKlbyR2RcQRA3a/cCqUJ75LGrDpXj+93VI/UfPuVsYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgX7V5CygzXf7m;
	Mon, 14 Jul 2025 14:13:26 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AA2721402F0;
	Mon, 14 Jul 2025 14:17:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 14:17:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net-next 00/10] net: hns3: use seq_file for debugfs
Date: Mon, 14 Jul 2025 14:10:27 +0800
Message-ID: <20250714061037.2616413-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Arnd reported that there are two build warning for on-stasck
buffer oversize. As Arnd's suggestion, using seq file way
to avoid the stack buffer or kmalloc buffer allocating.

---
ChangeLog:
v2 -> v3:
  - Merge patch (11/11) into the previous two, suggested by Simon Horman
  v2: https://lore.kernel.org/all/20250711061725.225585-1-shaojijie@huawei.com/
v1 -> v2:
  - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
  - Remove unnecessary cast, suggested by Andrew Lunn
  v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
---

Jian Shen (4):
  net: hns3: clean up the build warning in debugfs by use seq file
  net: hns3: use seq_file for files in queue/ in debugfs
  net: hns3: use seq_file for files in tm/ in debugfs
  net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in
    debugfs

Jijie Shao (4):
  net: hns3: remove tx spare info from debugfs.
  net: hns3: use seq_file for files in common/ of hns3 layer
  net: hns3: use seq_file for files in reg/ in debugfs
  net: hns3: use seq_file for files in fd/ in debugfs

Yonglong Liu (2):
  net: hns3: use seq_file for files in mac_list/ in debugfs
  net: hns3: use seq_file for files in common/ of hclge layer

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   16 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 1044 ++++---------
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |   16 -
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |    2 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 1356 +++++++----------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |    1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |    2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    4 +-
 8 files changed, 859 insertions(+), 1582 deletions(-)

-- 
2.33.0


