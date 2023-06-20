Return-Path: <netdev+bounces-12309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB943737126
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C623281363
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6291773D;
	Tue, 20 Jun 2023 16:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4461078E
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:04:54 +0000 (UTC)
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 09:04:49 PDT
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6591F4;
	Tue, 20 Jun 2023 09:04:49 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id E5BCF1023A3;
	Tue, 20 Jun 2023 18:27:39 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id DC62F102395;
	Tue, 20 Jun 2023 18:26:38 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 35KFQceY023407;
	Tue, 20 Jun 2023 18:26:38 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] netfilter: ebtables: remove unnecessary NULL check
Date: Tue, 20 Jun 2023 18:25:49 +0300
Message-Id: <20230620152549.2109063-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20230620 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In ebt_do_table() 'private->chainstack' cannot be NULL
and the 'cs' pointer is dereferenced below, so it does not make
sense to compare 'private->chainstack' with NULL. 

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 net/bridge/netfilter/ebtables.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a..74daca8a5142 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -212,10 +212,7 @@ unsigned int ebt_do_table(void *priv, struct sk_buff *skb,
 	private = table->private;
 	cb_base = COUNTER_BASE(private->counters, private->nentries,
 	   smp_processor_id());
-	if (private->chainstack)
-		cs = private->chainstack[smp_processor_id()];
-	else
-		cs = NULL;
+	cs = private->chainstack[smp_processor_id()];
 	chaininfo = private->hook_entry[hook];
 	nentries = private->hook_entry[hook]->nentries;
 	point = (struct ebt_entry *)(private->hook_entry[hook]->data);
-- 
2.30.2


