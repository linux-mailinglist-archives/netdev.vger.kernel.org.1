Return-Path: <netdev+bounces-206061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D99B0137E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FDF17CDAA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7421E491B;
	Fri, 11 Jul 2025 06:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD421DFDAB;
	Fri, 11 Jul 2025 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215113; cv=none; b=qj5495qQJSkg5pT+7wNixQIHDkDNKh6tsa39N2KL2qN5uOX6/BE+3G1pWVap5K+pxtYfOV9bro2WWYzlFw9fe65ofhZuCwbd2n8zZiwg/ArHx7+g9KmIPNE5vfPd/WifLxSb9kXRDUnhf5xgF4jpJrstKfH5Ww1cMwVKwU15Gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215113; c=relaxed/simple;
	bh=zEZp+qXyCUazuCiC+Y/Nu2wudY2k42M4YzEkSX0fYrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PU9Sxxa1H8nQ695tqZbn9QGtrKbbouIDgt2F2/zor7IUJPuIkWYAYmGClLiXAg/ObPhPUMzg1DleHW6WD33h7Gsfxh9BkYDGeza/SU3Pa1uM8PWghhTehtgtqOmKsVOYcYsBYv9tEJDEcCRuAs5+YREolCG0OLUK8KOqph2wQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bdhV22tcZz2FbPZ;
	Fri, 11 Jul 2025 14:23:06 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EC95140278;
	Fri, 11 Jul 2025 14:25:03 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 14:25:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 00/11] net: hns3: use seq_file for debugfs
Date: Fri, 11 Jul 2025 14:17:14 +0800
Message-ID: <20250711061725.225585-1-shaojijie@huawei.com>
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

Arnd reported that there are two build warning for on-stasck
buffer oversize. As Arnd's suggestion, using seq file way
to avoid the stack buffer or kmalloc buffer allocating.

---
ChangeLog:
v1 -> v2:
  - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
  - Remove unnecessary cast, suggested by Andrew Lunn
  v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
---

Jian Shen (5):
  net: hns3: clean up the build warning in debugfs by use seq file
  net: hns3: use seq_file for files in queue/ in debugfs
  net: hns3: use seq_file for files in tm/ in debugfs
  net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in
    debugfs
  net: hns3: remove the unused code after using seq_file

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


