Return-Path: <netdev+bounces-27589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6569677C782
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963A81C20C2D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3E567C;
	Tue, 15 Aug 2023 06:11:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8563207
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:11:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32341BD7;
	Mon, 14 Aug 2023 23:11:50 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ18k0tQ2z1GDRF;
	Tue, 15 Aug 2023 14:10:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 14:11:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] refactor registers information for ethtool -d
Date: Tue, 15 Aug 2023 14:06:37 +0800
Message-ID: <20230815060641.3551665-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

refactor registers information for ethtool -d

Jijie Shao (4):
  net: hns3: move dump regs function to a separate file
  net: hns3: Support tlv in regs data for HNS3 PF driver
  net: hns3: Support tlv in regs data for HNS3 VF driver
  net: hns3: fix wrong rpu tln reg issue

 drivers/net/ethernet/hisilicon/hns3/Makefile  |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 560 +--------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 -
 .../hisilicon/hns3/hns3pf/hclge_regs.c        | 668 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_regs.h        |  17 +
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 121 +---
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   1 +
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 164 +++++
 .../hisilicon/hns3/hns3vf/hclgevf_regs.h      |  13 +
 12 files changed, 875 insertions(+), 681 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h

-- 
2.30.0


