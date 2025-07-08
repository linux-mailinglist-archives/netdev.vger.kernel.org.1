Return-Path: <netdev+bounces-204959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164FAFCB6A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87671166570
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FF2DBF5D;
	Tue,  8 Jul 2025 13:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC035482EB;
	Tue,  8 Jul 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980082; cv=none; b=MoeqMPm2uVkBllICrywwdBncDVWIy62bey+WWWj5P14xOHI77d0VGY13RLOBdfP8gh7mTU6CdkXeKcfPAO+BF4BZ7E5+Bn8a2PfM7zh1fqeUfr6iB7qd0E8JvAwMNlAh73rSUCjkPmFKg1hgT+n8QeYipcQx7Q/E2acW0jsDN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980082; c=relaxed/simple;
	bh=YjMz/NQ32NUYjDbx/912RQno85nOogOdFl3jqqi82T4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1nozirIp7PHtlO4w1frDDMXvKhICYQcMPDDty1uSrX/Pzb/2CzPACmHLFlN9C3BHeP2Xe/7GH31XTswGJ9rzJLLhEHkPBRWhZ0bxjRM7lx5+vwD0kdnoPVBdtEsywk9VgE6pkfmEmusKG/veySj0MpEmnRz8l0o3uirxMzd7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bc1ZL1B55z2SSqm;
	Tue,  8 Jul 2025 21:06:02 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 580D11A0188;
	Tue,  8 Jul 2025 21:07:56 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:55 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 00/11] net: hns3: use seq_file for debugfs
Date: Tue, 8 Jul 2025 21:00:18 +0800
Message-ID: <20250708130029.1310872-1-shaojijie@huawei.com>
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

Arnd reported that there are two build warning for on-stasck
buffer oversize. As Arnd's suggestion, using seq file way
to avoid the stack buffer or kmalloc buffer allocating.

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

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   17 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 1044 ++++---------
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |   16 -
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |    2 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 1356 +++++++----------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |    1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |    2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    4 +-
 8 files changed, 860 insertions(+), 1582 deletions(-)

-- 
2.33.0


