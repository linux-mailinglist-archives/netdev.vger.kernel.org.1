Return-Path: <netdev+bounces-136931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F09A3B38
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360051C21AE9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F02010F8;
	Fri, 18 Oct 2024 10:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC516201105;
	Fri, 18 Oct 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246650; cv=none; b=nCTvL/YHmtsk7+8pi3O6qkb19MWhkwjm92JwoxhFw7eKjzOYEe8hcGtd2DEkozBZpkTLQzHsUWUvp/psTbJpZAn78A9cDSMOG+fYr8FMvxa645333OxnxeKl7F9KGOqZPg7KRIUyQCpFzZZ87MBlX9tIyNZrhniJqEy6FGR1Dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246650; c=relaxed/simple;
	bh=sPlNRJ4iB0rTlHTKUhqZHx3dCitEzP2AnfeECVBMu+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FS/GywkhCp1W40/X6pGqES4KeKzd+bN16vlUvYz04vndK5iuRKnkRXxqigcy//qidoQzbNMq+kClY9fVY9lVBtUENkHooMANZv11FalC2ljktYaOidMpekDO6OaJpikXuQPGjjSHB1DLGQPvDhaHEoXPa1BcHx11IDQI70wQTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVLFj3Yjtz1j9k1;
	Fri, 18 Oct 2024 18:16:09 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 1242F14010D;
	Fri, 18 Oct 2024 18:17:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:17:25 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>
CC: <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 0/9] There are some bugfix for the HNS3 ethernet driver
Date: Fri, 18 Oct 2024 18:10:50 +0800
Message-ID: <20241018101059.1718375-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)

There are some bugfix for the HNS3 ethernet driver

---
ChangeLog:
v1 -> v2:
  - Pass IRQF_NO_AUTOEN to request_irq(), suggested by Jakub.
  - Rewrite the commit logs of 'net: hns3: default enable tx bounce buffer when smmu enabled'
    and 'net: hns3: add sync command to sync io-pgtable'.
v1: https://lore.kernel.org/all/20241011094521.3008298-1-shaojijie@huawei.com/
---

Hao Lan (4):
  net: hns3: fixed reset failure issues caused by the incorrect reset
    type
  net: hns3: fix missing features due to dev->features configuration too
    early
  net: hns3: Resolved the issue that the debugfs query result is
    inconsistent.
  net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds
    issue

Jian Shen (3):
  net: hns3: add sync command to sync io-pgtable
  net: hns3: don't auto enable misc vector
  net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jie Wang (1):
  net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Peiyang Wang (1):
  net: hns3: default enable tx bounce buffer when smmu enabled

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 59 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 45 +++++++++++---
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  3 +
 .../hisilicon/hns3/hns3pf/hclge_regs.c        |  9 +--
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 40 ++++++++++---
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      |  9 +--
 9 files changed, 178 insertions(+), 26 deletions(-)

-- 
2.33.0


