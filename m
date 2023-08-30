Return-Path: <netdev+bounces-31346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0378D47D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B3281325
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC1187B;
	Wed, 30 Aug 2023 09:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED41877
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:08:33 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE27AD2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:08:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RbJMH2NGtz1L9Gk
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 17:06:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 17:08:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] ptp: ptp_ines: Use list_for_each_entry() helper
Date: Wed, 30 Aug 2023 17:08:16 +0800
Message-ID: <20230830090816.529438-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert list_for_each() to list_for_each_entry() so that the this
list_head pointer and list_entry() call are no longer needed, which
can reduce a few lines of code. No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/ptp/ptp_ines.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index ed215b458183..c74f2dbbe3a2 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -237,11 +237,9 @@ static struct ines_port *ines_find_port(struct device_node *node, u32 index)
 {
 	struct ines_port *port = NULL;
 	struct ines_clock *clock;
-	struct list_head *this;
 
 	mutex_lock(&ines_clocks_lock);
-	list_for_each(this, &ines_clocks) {
-		clock = list_entry(this, struct ines_clock, list);
+	list_for_each_entry(clock, &ines_clocks, list) {
 		if (clock->node == node) {
 			port = &clock->port[index];
 			break;
-- 
2.34.1


