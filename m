Return-Path: <netdev+bounces-18325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0247566D0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DD32811D4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BE253C3;
	Mon, 17 Jul 2023 14:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF75253BA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:50:57 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E049E4C
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=dj4U30xF+0JTV9W8PP
	GYwgBUlnynRBs4kwtLJluCopk=; b=MEuDSPPruhi2Ok/R1KtBeTnwt6v3+cIm7j
	R6UgVnnR2eN3fL+dk2DFbGY+8Ma//+k/p3of+x54Pa7XEZpI+6n94QmZb7q5OEIV
	Tr/igwOEueDxeqhh0DztibpyM0g2J7T5kU314rQcPwWJVxl2gfLbA3hsYjKQmKZT
	X33Xm8KjM=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBnbysyVbVkwrwyAg--.57325S4;
	Mon, 17 Jul 2023 22:50:29 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
Date: Mon, 17 Jul 2023 22:50:24 +0800
Message-Id: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBnbysyVbVkwrwyAg--.57325S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurW5JF18Cw4xtrykuFg_yoWfGwcEkw
	4ft3WkGw47GwsYyr40kr45tr4kZw4IkFyrZ3WSqFW5C3s0q395WrW8CFs7Cr13Way7Wr98
	Xan8CrWxKF1fGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKrWrPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiBmv5VaEFzdftwAAsB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

do kfree_skb() if an unexpected result is returned by pskb_tirm()
in do_output().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/openvswitch/actions.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index cab1e02b63e0..6b3456bdff1c 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -920,9 +920,11 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 
 		if (unlikely(cutlen > 0)) {
 			if (skb->len - cutlen > ovs_mac_header_len(key))
-				pskb_trim(skb, skb->len - cutlen);
+				if (pskb_trim(skb, skb->len - cutlen))
+					kfree_skb(skb);
 			else
-				pskb_trim(skb, ovs_mac_header_len(key));
+				if (pskb_trim(skb, ovs_mac_header_len(key)))
+					kfree_skb(skb);
 		}
 
 		if (likely(!mru ||
-- 
2.17.1


