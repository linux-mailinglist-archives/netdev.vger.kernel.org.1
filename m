Return-Path: <netdev+bounces-232113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 014ACC01484
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 326424F9AAF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D47314D0D;
	Thu, 23 Oct 2025 13:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E47314B65;
	Thu, 23 Oct 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225239; cv=none; b=dbq3rQ3YG5MPT0UgdMw0+ztAovlBz4ynA+hW6VXDS7IIGB0IcU7cXJFCzCbzQm3RLC3MBwnRXVX16WHo7Mp3aZuKRUKSohEedzgi27IJ1Uftxn4TLJs/zkpybmwK9fj0mwwg+5HGrrwYrkk1JnycQnOEBWvzPfUx/euqq5X/sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225239; c=relaxed/simple;
	bh=Yvvfwas0QD30pAcmtjETbi7zDDDKkyTJTzu7CZsIan4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyf9IsxTkOs964IIMI1TZ0hOWPDGzEb5qybDDHZFqO2ftHOcmyJWdRR1pA9sjWidxcXLkJz/QiLyvaOkVT2nojQj0kGv5JCS4yfdNbbb53COhjeUw0719H6sJBJvQw5VvtU9J8lkQb7hwvolXqw/rg2EG6Nw6Afe1dYhUFyzSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4csmZQ3vvbz2CgnQ;
	Thu, 23 Oct 2025 21:09:02 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 571521A0188;
	Thu, 23 Oct 2025 21:13:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 21:13:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 0/2] There are some bugfix for the HNS3 ethernet driver
Date: Thu, 23 Oct 2025 21:13:36 +0800
Message-ID: <20251023131338.2642520-1-shaojijie@huawei.com>
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

This patchset includes 2 fixes:
1. Patch1 fixes an incorrect function return value.
2. Patch2 fixes the issue of lost reset concurrent protection after
  seq_file reconstruction in debugfs.

Note: Compared to the previous version, this patchset has removed 2 patches
and added 1 new patch, so it is being resent as V1.

previous patchset:
https://lore.kernel.org/all/20250917122954.1265844-4-shaojijie@huawei.com/
Patch 'use user configuration after hardware reset when using kernel PHY'
will be sent separately.

Jijie Shao (2):
  net: hns3: return error code when function fails
  net: hns3: fix null pointer in debugfs issue

 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 67 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  6 ++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  3 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  9 ++-
 .../hisilicon/hns3/hns3pf/hclge_mdio.h        |  2 +-
 5 files changed, 65 insertions(+), 22 deletions(-)

-- 
2.33.0


