Return-Path: <netdev+bounces-158915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442BA13BF9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EA43A9F52
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F81198A29;
	Thu, 16 Jan 2025 14:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162EF8633A
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037041; cv=none; b=HEMEzGlZpqBK7QG1Wv9sTX9rVRgUfU3cfqy+78UA2lGiC7vOGDkuEzAP3yrY0u1Vc98q6CDoo3xzH9wnhc7M2ShNs2Mrt+I++dPGKOMwjTNs8y2gBHOCYiGIWBMtdSYIf/BFzQwzbI2aKWLJo6zJRsgxmV+ypz9vdLso5ip2w9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037041; c=relaxed/simple;
	bh=8kM58Shj9T4pC5Rmb3vmf6xTklpSgJjj0bEZuGF31H0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvd0Z7Y+WnKBKOi1g6CpWeNmzc47oBQu7v6/0Qr0WjbUWpg/R5vxVwb52sO0tLZn5L8Z0JFAGLbbbhXwKcC+CCd1rEpo6LSwWkaPIyK35LjgQHJusJ/R9cIey2HiR69hkZ3HefN8Sj5knka/zv11K/7xCzZvj9vGJwRtEEPbpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YYlGf41Mqz2Dkdv;
	Thu, 16 Jan 2025 22:14:02 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 5246A140109;
	Thu, 16 Jan 2025 22:17:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 22:17:13 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <stephen@networkplumber.org>,
	<matthias.tafelmeier@gmx.net>
CC: <netdev@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH net] net: let net.core.dev_weight always be non-zero
Date: Thu, 16 Jan 2025 22:30:53 +0800
Message-ID: <20250116143053.4146855-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200003.china.huawei.com (7.202.181.30)

The following problem was encountered during stability test:

(NULL net_device): NAPI poll function process_backlog+0x0/0x530 \
	returned 1, exceeding its budget of 0.
------------[ cut here ]------------
list_add double add: new=ffff88905f746f48, prev=ffff88905f746f48, \
	next=ffff88905f746e40.
WARNING: CPU: 18 PID: 5462 at lib/list_debug.c:35 \
	__list_add_valid_or_report+0xf3/0x130
CPU: 18 UID: 0 PID: 5462 Comm: ping Kdump: loaded Not tainted 6.13.0-rc7+
RIP: 0010:__list_add_valid_or_report+0xf3/0x130
Call Trace:
? __warn+0xcd/0x250
? __list_add_valid_or_report+0xf3/0x130
enqueue_to_backlog+0x923/0x1070
netif_rx_internal+0x92/0x2b0
__netif_rx+0x15/0x170
loopback_xmit+0x2ef/0x450
dev_hard_start_xmit+0x103/0x490
__dev_queue_xmit+0xeac/0x1950
ip_finish_output2+0x6cc/0x1620
ip_output+0x161/0x270
ip_push_pending_frames+0x155/0x1a0
raw_sendmsg+0xe13/0x1550
__sys_sendto+0x3bf/0x4e0
__x64_sys_sendto+0xdc/0x1b0
do_syscall_64+0x5b/0x170
entry_SYSCALL_64_after_hwframe+0x76/0x7e

The reproduction command is as follows:
sysctl -w net.core.dev_weight=0
Ping 127.0.0.1

This is because when the napi's weight is set to 0, process_backlog() may
return 0 and clear the NAPI_STATE_SCHED bit of napi->state, causing this
napi to be re-polled in net_rx_action() until __do_softirq() times out.
Since the NAPI_STATE_SCHED bit has been cleared, napi_schedule_rps() can
be retriggered in enqueue_to_backlog(), causing this issue.

Making the napi's weight always non-zero solves this problem.

Fixes: e38766054509 ("[NET]: Fix sysctl net.core.dev_weight")
Fixes: 3d48b53fb2ae ("net: dev_weight: TX/RX orthogonality")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/core/sysctl_net_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index cb8d32e5c14e..ad2741f1346a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -319,7 +319,7 @@ static int proc_do_dev_weight(const struct ctl_table *table, int write,
 	int ret, weight;
 
 	mutex_lock(&dev_weight_mutex);
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
 		WRITE_ONCE(net_hotdata.dev_rx_weight, weight * dev_weight_rx_bias);
@@ -412,6 +412,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_rx_bias",
@@ -419,6 +420,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "dev_weight_tx_bias",
@@ -426,6 +428,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_do_dev_weight,
+		.extra1         = SYSCTL_ONE,
 	},
 	{
 		.procname	= "netdev_max_backlog",
-- 
2.34.1


