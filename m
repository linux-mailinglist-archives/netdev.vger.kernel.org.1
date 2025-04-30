Return-Path: <netdev+bounces-187009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E931BAA475A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568344A66CA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B7235049;
	Wed, 30 Apr 2025 09:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7D21C197;
	Wed, 30 Apr 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005859; cv=none; b=mPJ3/aeM3j+/CgsTb3j5+COuf0unNxOm8xE/xsBB9TY1CcJwSP9+4wMhNJb9pQVt3f0FPQUj6Blh5wU613JkgUoKVNaC+2W5WxP5qTCbVBesQd09NF1PdHxLQlFbRHC2tuX9QBVBQ/YDOfl0qRvB4NIRrcsaydl+PzkIGYN4vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005859; c=relaxed/simple;
	bh=dx3gwFLN+r2LapQatGyKjXKO7bo4RtW3nbFWJ9ZSfS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SihLqcDSQq90YGtn6b80jXDg/KIDSLnkF1n90XElb/bj7BUEDEA2KtSPbwH+GT5BaUCru/RuwhsCb30YPPjAwHk4VBImmVIgYYE8FKUoMJD1ln3seEWpdtxZMciW7HWUljspadmZbvMv4gBCZsCLLyZmnGXMP/0IbPuT3nKGaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZnX6n6VrdzySq1;
	Wed, 30 Apr 2025 17:33:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FF6118046F;
	Wed, 30 Apr 2025 17:37:34 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Apr 2025 17:37:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/4] There are some bugfix for the HNS3 ethernet driver
Date: Wed, 30 Apr 2025 17:30:48 +0800
Message-ID: <20250430093052.2400464-1-shaojijie@huawei.com>
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

There is a pathset that contains three patches, but two of them
need to be removed:
 https://lore.kernel.org/all/20250402121001.663431-1-shaojijie@huawei.com/
The last patch and other patches form this patchset:
 net: hns3: store rx VLAN tag offload state for VF

Hao Lan (1):
  net: hns3: fixed debugfs tm_qset size

Jian Shen (2):
  net: hns3: store rx VLAN tag offload state for VF
  net: hns3: defer calling ptp_clock_register()

Yonglong Liu (1):
  net: hns3: fix an interrupt residual problem

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 82 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         | 13 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 25 ++++--
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  1 +
 5 files changed, 67 insertions(+), 56 deletions(-)

-- 
2.33.0


