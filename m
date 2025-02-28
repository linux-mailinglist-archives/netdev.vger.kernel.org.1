Return-Path: <netdev+bounces-170672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A85A49803
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BD3B60E2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE325B675;
	Fri, 28 Feb 2025 11:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6741ACEDB;
	Fri, 28 Feb 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740457; cv=none; b=oUjkNb10YbTjwePVkIuYOVmC2hcXI47xuvMQas7LSleuUYPTK1jVFVc5R1mCUALfrNnhNuajhuXy5b8tBVkXJ788xFJE3MedHKDKgPQ2zpquDnCGNl+CIZd7KxTjK9LA9eV+TjKWiglpkNOgzHvitVGGlnyoMKQiNNsG4TSrLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740457; c=relaxed/simple;
	bh=fy0rrOyVDewDPklbCqvdhOp3juLTfjm0e3sk1PpGsj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ilw3LcDDHPlF1zOgTPTIM42ePImQRDc6+CVS/sqML0Oe5HhgFlrZAmJXxhEEFbD+4k0XZZ60qaNK3fcKxq+V/VAjFaczS076GqgpRAvQEhPHP16xKKr1yPtkIAFUVXIr3HEXPsF86OpjKKpcd3W9cVfO/CQK7jqhs4XZpEyupKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z44rM06kWzwXF5;
	Fri, 28 Feb 2025 18:56:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 059401800CD;
	Fri, 28 Feb 2025 19:00:51 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 19:00:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net] net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error
Date: Fri, 28 Feb 2025 18:52:58 +0800
Message-ID: <20250228105258.1243461-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Peiyang Wang <wangpeiyang1@huawei.com>

During the initialization of ptp, hclge_ptp_get_cycle might return an error
and returned directly without unregister clock and free it. To avoid that,
call hclge_ptp_destroy_clock to unregist and free clock if
hclge_ptp_get_cycle failed.

Fixes: 8373cd38a888 ("net: hns3: change the method of obtaining default ptp cycle")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index bab16c2191b2..181af419b878 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -483,7 +483,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
-- 
2.33.0


