Return-Path: <netdev+bounces-79847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C987BBD1
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9973E283136
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD86EB53;
	Thu, 14 Mar 2024 11:18:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11341A80
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415130; cv=none; b=FO4ikwI/Wv9QckyL1e5DUYoGMuQrpogwG7vatRGH5DYrVt0EyA7M96f82MEjyAh2Kjs4H4krONemzCHmuZ0saK/06TSBJ3Kv8+mbAGiebP0BdCHibGVY0HdZK6H4SqU10oL2bEjWOOF5bSaprrYHgDdzlS3hnm1Yzhmk85OeIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415130; c=relaxed/simple;
	bh=PTGgiiA6/A6UvU9ezCqegelJt5WtNaS/F6VAc2LrNXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMSxeybVNerH2od+/J7fgxOCjhSP1wnorJzPKsVLNJJD9klZS2evzbqABQENxNQniZjTjGu+sUiZP5FYsqyi1WGUHJfV/XIXKdLxBs2VOIukdrcoLhSrK9jy2FhfCoe6A8VRer9MUttALBNpORZFou/vsDl4iH6gKQWk1DX6n6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TwPwS5wP6z1xrD8;
	Thu, 14 Mar 2024 19:16:56 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B9D514011F;
	Thu, 14 Mar 2024 19:18:43 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.214) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Mar 2024 19:18:42 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <vladbu@nvidia.com>
CC: <netdev@vger.kernel.org>, <yanan@huawei.com>, <liaichun@huawei.com>,
	<caowangbao@huawei.com>, <renmingshuai@huawei.com>
Subject: [PATCH] net/sched: Forbid assigning mirred action to a filter attached to the egress
Date: Thu, 14 Mar 2024 19:17:13 +0800
Message-ID: <20240314111713.5979-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100005.china.huawei.com (7.185.36.102)

As we all know the mirred action is used to mirroring or redirecting the
packet it receives. Howerver, add mirred action to a filter attached to
a egress qdisc might cause a deadlock. To reproduce the problem, perform
the following steps:
(1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
(2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
     action police rate 100mbit burst 12m conform-exceed jump 1 \
     / pipe mirred egress redirect dev eth2 action drop

The stack is show as below:
[28848.883915]  _raw_spin_lock+0x1e/0x30
[28848.884367]  __dev_queue_xmit+0x160/0x850
[28848.884851]  ? 0xffffffffc031906a
[28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
[28848.885863]  tcf_action_exec.part.0+0x88/0x130
[28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
[28848.886970]  ? dequeue_entity+0x145/0x9e0
[28848.887464]  ? newidle_balance+0x23f/0x2f0
[28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
[28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
[28848.889137]  ? __flush_work.isra.0+0x35/0x80
[28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
[28848.890293]  ? do_select+0x637/0x870
[28848.890735]  tcf_classify+0x52/0xf0
[28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
[28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
[28848.892251]  __dev_queue_xmit+0x2d8/0x850
[28848.892738]  ? nf_hook_slow+0x3c/0xb0
[28848.893198]  ip_finish_output2+0x272/0x580
[28848.893692]  __ip_queue_xmit+0x193/0x420
[28848.894179]  __tcp_transmit_skb+0x8cc/0x970

In this case, the process has hold the qdisc spin lock in __dev_queue_xmit
before the egress packets are mirred, and it will attempt to obtain the
spin lock again after packets are mirred, which cause a deadlock.

Fix the issue by forbidding assigning mirred action to a filter attached
to the egress.

Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
---
 net/sched/act_mirred.c                        |  4 +++
 .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5b3814365924..fc96705285fb 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 		NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to be passed");
 		return -EINVAL;
 	}
+	if (tp->chain->block->q->parent != TC_H_INGRESS) {
+		NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned to the filter attached to ingress");
+		return -EINVAL;
+	}
 	ret = nla_parse_nested_deprecated(tb, TCA_MIRRED_MAX, nla,
 					  mirred_policy, extack);
 	if (ret < 0)
diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b73bd255ea36..50c6153bf34c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1052,5 +1052,37 @@
             "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
             "$TC actions flush action mirred"
         ]
+    },
+    {
+        "id": "fdda",
+        "name": "Add mirred mirror to the filter which attached to engress",
+        "category": [
+            "actions",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action mirred",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc add dev $DEV1 root handle 1: htb default 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 protocol ip u32 match ip protocol 1 0xff action mirred egress mirror dev $DEV1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC action list action mirred",
+        "matchPattern": "^[ \t]+index [0-9]+ ref",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: htb default 1",
+            "$TC actions flush action mirred"
+        ]
     }
 ]
-- 
2.33.0


