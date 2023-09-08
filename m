Return-Path: <netdev+bounces-32509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01A7980FD
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 05:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A1F1C20BDF
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E31373;
	Fri,  8 Sep 2023 03:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6D1852
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:32:03 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692801BDB;
	Thu,  7 Sep 2023 20:32:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vrb2bZF_1694143917;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vrb2bZF_1694143917)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 11:31:57 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	kgraul@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add
Date: Fri,  8 Sep 2023 11:31:43 +0800
Message-Id: <20230908033143.89489-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
References: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While doing smcr_port_add, there maybe linkgroup add into or delete
from smc_lgr_list.list at the same time, which may result kernel crash.
So, use smc_lgr_list.lock to protect smc_lgr_list.list iterate in
smcr_port_add.

The crash calltrace show below:
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 559726 Comm: kworker/0:92 Kdump: loaded Tainted: G
Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 449e491 04/01/2014
Workqueue: events smc_ib_port_event_work [smc]
RIP: 0010:smcr_port_add+0xa6/0xf0 [smc]
RSP: 0000:ffffa5a2c8f67de0 EFLAGS: 00010297
RAX: 0000000000000001 RBX: ffff9935e0650000 RCX: 0000000000000000
RDX: 0000000000000010 RSI: ffff9935e0654290 RDI: ffff9935c8560000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9934c0401918
R10: 0000000000000000 R11: ffffffffb4a5c278 R12: ffff99364029aae4
R13: ffff99364029aa00 R14: 00000000ffffffed R15: ffff99364029ab08
FS:  0000000000000000(0000) GS:ffff994380600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000f06a10003 CR4: 0000000002770ef0
PKRU: 55555554
Call Trace:
 smc_ib_port_event_work+0x18f/0x380 [smc]
 process_one_work+0x19b/0x340
 worker_thread+0x30/0x370
 ? process_one_work+0x340/0x340
 kthread+0x114/0x130
 ? __kthread_cancel_work+0x50/0x50
 ret_from_fork+0x1f/0x30

Fixes: 1f90a05d9ff9 ("net/smc: add smcr_port_add() and smcr_link_up() processing")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 net/smc/smc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3f465faf2b68..6aa3db47a956 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1654,6 +1654,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *n;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
 		struct smc_link *link;
 
@@ -1669,6 +1670,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 		if (link)
 			smc_llc_add_link_local(link);
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 /* link is down - switch connections to alternate link,
-- 
2.24.3 (Apple Git-128)


