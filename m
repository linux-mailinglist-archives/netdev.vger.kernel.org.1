Return-Path: <netdev+bounces-34082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1217A2014
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81211C20DC5
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E610A1B;
	Fri, 15 Sep 2023 13:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE11097E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:45:48 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AB4710D;
	Fri, 15 Sep 2023 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JLiGP
	UrgY9r+SiZTEoL4adVndWQTqy+pELCQ+yP3BvE=; b=bqvqx00MGCIgchYvvkHc0
	yp4FvHBeAW89R11b0jo1Z4D6uj3r3K36SaQrzxWFCApaKuoYUVJVsN2gUY3QIQZs
	CzLckjfY/7EYN05Defhk9FkuvGkfNQNnVB8X4sVWeJzKBThfNifBWmTQcX1AWAct
	/yE6tOJOci3XMX1KeP7F3s=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wA3n6uqXwRlSIJ7CA--.59664S4;
	Fri, 15 Sep 2023 21:44:19 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: sched: hfsc: dont intepret cls results when asked to drop
Date: Fri, 15 Sep 2023 21:44:08 +0800
Message-Id: <20230915134408.3410595-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3n6uqXwRlSIJ7CA--.59664S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7uryUWw4UJr4fCFykXwb_yoWDAFc_A3
	4kWryxJr4xCr1qk3WfAr4jkryFkF1Fv3Z3X39xtr9rGrn5Cr98Gr18CwsxJ397GFWSka4k
	JFyqgFW5Jr1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivgXrC1ZcivHc5QAAsT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If asked to drop a packet via TC_ACT_SHOT it is unsafe to
assume that res.class contains a valid pointer.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/sched/sch_hfsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3554085bc2be..8e07a215f7d1 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1135,6 +1135,8 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+		if (result == TC_ACT_SHOT)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
@@ -1142,8 +1144,6 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		case TC_ACT_TRAP:
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
-		case TC_ACT_SHOT:
-			return NULL;
 		}
 #endif
 		cl = (struct hfsc_class *)res.class;
-- 
2.37.2


