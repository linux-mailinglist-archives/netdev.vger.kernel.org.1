Return-Path: <netdev+bounces-142858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91859C07A8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179881C2098A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF62101BE;
	Thu,  7 Nov 2024 13:37:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B11E502;
	Thu,  7 Nov 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986627; cv=none; b=XlX4bWsVyL5e5p3tXavEqIaeZmMxIhoJirS4gMuQdY7iRHXr9mYCENbiZWfoRQI0qQQS27rnY9wcZnBF0ljGfcMBTdk23Ak70siPCttqfKGOs0eewsx9FKAxub751HQhjp9PciRsemoogKIzCiZw6iNPKRzO0vAFR16pL/RkBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986627; c=relaxed/simple;
	bh=lh7NmiUOBcEWLfgJbVEpKp+NjmvJRP35r1nY5IUCqi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZge83HvKpOXwfoA6vd4JhXjSyMgi6+EA4vbEmXDKhREM41sEhxafVngfSEgi4+QwNM4AY4f/3i+D2ze0TdH+oSj9bTXhQNCZl2H1OSczGhbfXrYNAYK92mXEJI7nb1xalVl0D1JWKoXdGSgBrwSxkPefdvQX31vcb8p+t2y110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkjjC1cD5z923D;
	Thu,  7 Nov 2024 21:34:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9598914039F;
	Thu,  7 Nov 2024 21:37:00 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 21:36:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Thu, 7 Nov 2024 21:30:16 +0800
Message-ID: <20241107133023.3813095-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

There's a series of bugfix that's been accepted:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=d80a3091308491455b6501b1c4b68698c4a7cd24

However, The series is making the driver poke into IOMMU internals instead of
implementing appropriate IOMMU workarounds. After discussion, the series was reverted:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568

But only two patches are related to the IOMMU.
Other patches involve only the modification of the driver.
This series resends other patches.

Hao Lan (4):
  net: hns3: fixed reset failure issues caused by the incorrect reset
    type
  net: hns3: fix missing features due to dev->features configuration too
    early
  net: hns3: Resolved the issue that the debugfs query result is
    inconsistent.
  net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds
    issue

Jian Shen (2):
  net: hns3: don't auto enable misc vector
  net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jie Wang (1):
  net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  1 -
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 45 +++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  3 ++
 .../hisilicon/hns3/hns3pf/hclge_regs.c        |  9 ++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 40 ++++++++++++++---
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      |  9 ++--
 7 files changed, 85 insertions(+), 26 deletions(-)

-- 
2.33.0


