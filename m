Return-Path: <netdev+bounces-34047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD87A1CD2
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B3F1C20B9E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DEEFC1F;
	Fri, 15 Sep 2023 10:53:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C8DF67
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:53:18 +0000 (UTC)
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 03:53:15 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70FFA1;
	Fri, 15 Sep 2023 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jfg89
	hpAnjS29Cy8nvmMp/5yE2Eqt0KleRCp9ZvqmBM=; b=OZjMqnaYvHGBKOAhIjpvx
	/EmAVLIJX4tPxVWFv/x3jOiIXT7MgqoaEXEtY4VQENXuVRzzGfHZvsK2EtQc264+
	esE+i8FD+AL55bP8Ymnul39jzZmLeeD+53GT24pp8bYBwN/EELIuxGvv4XJtel9W
	o8oFmE6AXNYybIMva9VWqg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wCHKZj+NgRlbfpYAQ--.10881S4;
	Fri, 15 Sep 2023 18:50:47 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: sched: qfq: dont intepret cls results when asked to drop
Date: Fri, 15 Sep 2023 18:50:36 +0800
Message-Id: <20230915105036.3406718-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHKZj+NgRlbfpYAQ--.10881S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7ur4fXry8AF1UZFWUurg_yoW3Xrc_Ga
	48GF4fJr1xWrn7Cw43Jrs8CryrKFn2v3W8Jws3t3srJ3yFyr9xJr1kurs3J3s5Wa1IkryU
	XryDKas8JrsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfOzJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiVxbrC1etsV07kAAAsc
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If asked to drop a packet via TC_ACT_SHOT it is unsafe to
assume that res.class contains a valid pointer.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/sched/sch_qfq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 546c10adcacd..20d52dc484b6 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -695,6 +695,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result == TC_ACT_SHOT)
+		return NULL;
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
-- 
2.37.2


