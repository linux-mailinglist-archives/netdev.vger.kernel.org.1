Return-Path: <netdev+bounces-31345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570B78D479
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE622812FD
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EB187B;
	Wed, 30 Aug 2023 09:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455B1877
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:05:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B16CC9
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:05:35 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RbJHv4Dq2z1L9Gl;
	Wed, 30 Aug 2023 17:03:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 17:05:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <benjamin.tissoires@redhat.com>, Karsten Keil
	<isdn@linux-pingi.de>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] isdn: capi, Use list_for_each_entry() helper
Date: Wed, 30 Aug 2023 17:05:28 +0800
Message-ID: <20230830090529.529209-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert list_for_each() to list_for_each_entry() so that the l
list_head pointer and list_entry() call are no longer needed, which
can reduce a few lines of code. No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/isdn/capi/capi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 2f3789515445..6664eb3dc35c 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1326,11 +1326,9 @@ static inline void capinc_tty_exit(void) { }
 static int __maybe_unused capi20_proc_show(struct seq_file *m, void *v)
 {
 	struct capidev *cdev;
-	struct list_head *l;
 
 	mutex_lock(&capidev_list_lock);
-	list_for_each(l, &capidev_list) {
-		cdev = list_entry(l, struct capidev, list);
+	list_for_each_entry(cdev, &capidev_list, list) {
 		seq_printf(m, "0 %d %lu %lu %lu %lu\n",
 			   cdev->ap.applid,
 			   cdev->ap.nrecvctlpkt,
-- 
2.34.1


