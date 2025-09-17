Return-Path: <netdev+bounces-224002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F1B7DF52
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E567B4853
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F834283FE9;
	Wed, 17 Sep 2025 12:37:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72036D;
	Wed, 17 Sep 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112672; cv=none; b=ZYsiWSS6lt1e4RvNPtksRRDg5nfiGPDs7xa8cWqWTk42GcwhunBg8r9LOVmvy1yWtWlS/wYr4e5rzxSRdGKQT0AmciRtBkM7duRu7phqzJMCEvrU1k7EDKRqEu4BCMf4KHaM5KRtUC4Ko9O6v/MIucUvIv/C+V1VBtYetj9kubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112672; c=relaxed/simple;
	bh=4b0yS3bHw4hdRnAsU/fqET8C8on0HsorpTHay5/m+TA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f/KFqaQlk55DZpm2Lyevi5MS7PhicXxOC6KsgxHD7lMoOFWNUChL18xcEJx5UOenQJm7yNen8qz2em4b7GGVZHqvuHu9NVtODTaGFxCq2GVthE6d7KlHL/Xfwrfb0KbKlZ+q9LlBmY3X1ShWy+o2c9JOrRIIJd4Fzmx8SuQTeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cRdTf4xJPzPtGY;
	Wed, 17 Sep 2025 20:33:10 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 58747180486;
	Wed, 17 Sep 2025 20:37:46 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 20:37:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<huangdengdui@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Wed, 17 Sep 2025 20:29:51 +0800
Message-ID: <20250917122954.1265844-1-shaojijie@huawei.com>
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

This patchset includes 3 fixes:
1. Patch1 fixes the issue of loopback failure under half-duplex mode.
  The driver will automatically switch to full-duplex mode
  before loopback tests.
2. Patch2 fixes an incorrect function return value.
3. Patch4 fixes the potential loss of user rate and duplex configuration
  after reset.

Jijie Shao (3):
  net: hns3: fix loopback test of serdes and phy is failed if duplex is
    half
  net: hns3: return error code when function fails
  net: hns3: use user configure after hardware reset when using kernel
    PHY

 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  26 ++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 139 ++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   3 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |   9 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.h        |   2 +-
 5 files changed, 130 insertions(+), 49 deletions(-)

-- 
2.33.0


