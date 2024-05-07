Return-Path: <netdev+bounces-94127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9ED8BE4A4
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A738289E65
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E915E205;
	Tue,  7 May 2024 13:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58515B10A;
	Tue,  7 May 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089795; cv=none; b=U8KcWQRw5dbdawxEZu90C7PaHsRJlyOIRXiga118dducpXzqykKGKYPTxEdTpPawz5y5SGbc0gjhc/8q6Tiafld6Fzz1eE81cRsodB64KCb3Q3kq2IQTbI/X8pX59KSH4283yC0fY8LH+qb5cTEWL8kGSuJcdpwHuQR8NwLedLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089795; c=relaxed/simple;
	bh=H2Kun73WD3Rw/C3T4LCtK/zgZb1EulH35e8HhvhQrBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKChYlhHV8DBBSPHk1Pry4B4AqnBkFEY1OcnxKF9DVl3rc+O3RLBusaS9X1dNKsEyo5DKCXuqEUviCbOQeYh4DyOI7UWSdUBDye2yrLzGbEvBfgu/3Im/1ElvOJqe08GhA3NdPnJSxUHhFPYgLL26QrmAxie8rSZj5NNL3TA0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VYfhl6NktzNw8c;
	Tue,  7 May 2024 21:47:03 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A34B5180080;
	Tue,  7 May 2024 21:49:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 0/7] There are some bugfix for the HNS3 ethernet driver
Date: Tue, 7 May 2024 21:42:17 +0800
Message-ID: <20240507134224.2646246-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

There are some bugfix for the HNS3 ethernet driver

---
changeLog:
v2 -> v3:
  - Fix coding errors in "net: hns3: using user configure after hardware reset", suggested by Simon Horman
  https://lore.kernel.org/all/20240426100045.1631295-1-shaojijie@huawei.com/
v1 -> v2:
  - Adjust the code sequence to completely eliminate the race window, suggested by Jiri Pirko
  v1: https://lore.kernel.org/all/20240422134327.3160587-1-shaojijie@huawei.com/
---

Jian Shen (1):
  net: hns3: direct return when receive a unknown mailbox message

Peiyang Wang (4):
  net: hns3: using user configure after hardware reset
  net: hns3: change type of numa_node_mask as nodemask_t
  net: hns3: release PTP resources if pf initialization failed
  net: hns3: use appropriate barrier function after setting a bit value

Yonglong Liu (2):
  net: hns3: fix port vlan filter not disabled issue
  net: hns3: fix kernel crash when devlink reload during initialization

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 52 ++++++++++---------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  5 +-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 20 ++++---
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  2 +-
 6 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.30.0


