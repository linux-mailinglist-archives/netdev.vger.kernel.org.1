Return-Path: <netdev+bounces-55674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7680BF0B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FC11F20D4B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397ED11CAB;
	Mon, 11 Dec 2023 02:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B314BD;
	Sun, 10 Dec 2023 18:23:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpQWh22NYz14M0c;
	Mon, 11 Dec 2023 10:22:56 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E321180069;
	Mon, 11 Dec 2023 10:23:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:23:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <mkubecek@suse.cz>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <lanhao@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ethtool] net: ethtool: Add default branch to sff8636_show_all_ioctl switch
Date: Mon, 11 Dec 2023 10:18:21 +0800
Message-ID: <20231211021821.110467-1-shaojijie@huawei.com>
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

From: Hao Lan <lanhao@huawei.com>

The current sff8636_show_all_ioctl code uses a switch statement
to determine the module type, and exits directly with a return statement
when a match is found. However, when the module type cannot be matched,
the sff8636_memory_map_init_buf and sff8636_show_all_common functions
are executed. This writing style is not intuitive enough.
Therefore, this patch adding a default branch in the switch statement
to improve the readability of the code.

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 qsfp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index eedf688..a2921fb 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -985,11 +985,12 @@ void sff8636_show_all_ioctl(const __u8 *id, __u32 eeprom_len)
 	case SFF8024_ID_SFP_DD_CMIS:
 	case SFF8024_ID_SFP_PLUS_CMIS:
 		cmis_show_all_ioctl(id);
-		return;
+		break;
+	default:
+		sff8636_memory_map_init_buf(&map, id, eeprom_len);
+		sff8636_show_all_common(&map);
+		break;
 	}
-
-	sff8636_memory_map_init_buf(&map, id, eeprom_len);
-	sff8636_show_all_common(&map);
 }
 
 static void sff8636_request_init(struct ethtool_module_eeprom *request, u8 page,
-- 
2.30.0


