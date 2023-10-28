Return-Path: <netdev+bounces-44957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B747E7DA4F1
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 05:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B2C1C211EC
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F81394;
	Sat, 28 Oct 2023 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46677F5
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 03:02:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFD114;
	Fri, 27 Oct 2023 20:02:39 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SHPQQ3K4Nz1L9Gb;
	Sat, 28 Oct 2023 10:59:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 4/7] net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
Date: Sat, 28 Oct 2023 10:59:14 +0800
Message-ID: <20231028025917.314305-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231028025917.314305-1-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

From: Yonglong Liu <liuyonglong@huawei.com>

The hns3 driver define an array of string to show the coalesce
info, but if the kernel adds a new mode or a new state,
out-of-bounds access may occur when coalesce info is read via
debugfs, this patch fix the problem.

Fixes: c99fead7cb07 ("net: hns3: add debugfs support for interrupt coalesce")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index b8508533878b..4f385a18d288 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -500,11 +500,14 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 
 	sprintf(result[j++], "%d", i);
-	sprintf(result[j++], "%s", dim_state_str[dim->state]);
+	sprintf(result[j++], "%s", dim->state < ARRAY_SIZE(dim_state_str) ?
+		dim_state_str[dim->state] : "unknown");
 	sprintf(result[j++], "%u", dim->profile_ix);
-	sprintf(result[j++], "%s", dim_cqe_mode_str[dim->mode]);
+	sprintf(result[j++], "%s", dim->mode < ARRAY_SIZE(dim_cqe_mode_str) ?
+		dim_cqe_mode_str[dim->mode] : "unknown");
 	sprintf(result[j++], "%s",
-		dim_tune_stat_str[dim->tune_state]);
+		dim->tune_state < ARRAY_SIZE(dim_tune_stat_str) ?
+		dim_tune_stat_str[dim->tune_state] : "unknown");
 	sprintf(result[j++], "%u", dim->steps_left);
 	sprintf(result[j++], "%u", dim->steps_right);
 	sprintf(result[j++], "%u", dim->tired);
-- 
2.30.0


