Return-Path: <netdev+bounces-34096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61D7A2129
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93190282AB2
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8F30CF4;
	Fri, 15 Sep 2023 14:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA230CE5
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:37:21 +0000 (UTC)
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 07:37:20 PDT
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BC931AC;
	Fri, 15 Sep 2023 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GNsVK
	vTS98xa9PYmw/wBQ5bwtcO5/g2y0Ou7JL7DMuI=; b=LjbTTRrsAaTyMK/KjzFTe
	08QsaTkRIbyZQz/iVB5B//9t+zslNFpuiYvqJHpSbsN2MEJ/bF5A79Ya7ebgcuCI
	W97PwJQtPyhDSjj8vM9lpdgc4DOKenbNXj8zrNBHgMBytplTK/0FL26uxS+wSHob
	4e/kuCcisjs5LQGNnkADao=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wD3ZiBKaARlfESGCA--.51912S4;
	Fri, 15 Sep 2023 22:21:06 +0800 (CST)
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
Subject: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
Date: Fri, 15 Sep 2023 22:20:56 +0800
Message-Id: <20230915142056.3411330-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3ZiBKaARlfESGCA--.51912S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7uryUWr17Gry3Zw4kCrg_yoWDWFc_ua
	4rWr93Cr1xCF18Cr4IkF42k395KFyfZ3WfJws7t3srW3yFvr98Ar1kGa93J3ykGF4Fkry7
	X3sFgry5Gr9F9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivgXrC1ZcivHc5wACsT
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
 net/sched/sch_drr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 19901e77cd3b..a535dc3b0e05 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -310,6 +310,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
+		if (result == TC_ACT_SHOT)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
@@ -317,8 +319,6 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_TRAP:
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
-		case TC_ACT_SHOT:
-			return NULL;
 		}
 #endif
 		cl = (struct drr_class *)res.class;
-- 
2.37.2


