Return-Path: <netdev+bounces-43344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D17D2A84
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1D0B20CC1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 06:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DB3D63;
	Mon, 23 Oct 2023 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A76186B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 06:35:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E9DB
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 23:35:08 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SDQKg0klczcdS8;
	Mon, 23 Oct 2023 14:30:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 14:35:04 +0800
From: Liu Jian <liujian56@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net-next] net: sched: sch_qfq: Use non-work-conserving warning handler
Date: Mon, 23 Oct 2023 14:47:29 +0800
Message-ID: <20231023064729.370649-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected

A helper function for printing non-work-conserving alarms is added in
commit b00355db3f88 ("pkt_sched: sch_hfsc: sch_htb: Add non-work-conserving
 warning handler."). In this commit, use qdisc_warn_nonwc() instead of
WARN_ONCE() to handle the non-work-conserving warning in qfq Qdisc.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 546c10adcacd..5598f8be18ae 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1003,7 +1003,7 @@ static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
 	*cl = list_first_entry(&agg->active, struct qfq_class, alist);
 	skb = (*cl)->qdisc->ops->peek((*cl)->qdisc);
 	if (skb == NULL)
-		WARN_ONCE(1, "qfq_dequeue: non-workconserving leaf\n");
+		qdisc_warn_nonwc("qfq_dequeue", (*cl)->qdisc);
 	else
 		*len = qdisc_pkt_len(skb);
 
-- 
2.34.1


